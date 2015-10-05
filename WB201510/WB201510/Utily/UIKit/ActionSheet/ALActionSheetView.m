//
//  ALActionSheetView.m
//  ALActionSheetView
//
//  Created by WangQi on 7/4/15.
//  Copyright (c) 2015 WangQi. All rights reserved.
//

#import "ALActionSheetView.h"

#define kRowHeight 48.0f
#define kRowLineHeight 0.5f
#define kSeparatorHeight 5.0f

#define kTitleFontSize 13.0f
#define kButtonTitleFontSize 17.0f

#define kTitleVerticalSpacing 15.0f
#define kTitleHorizontalSpacing 22.5f


@interface UIEdgeInsetsLabel : UILabel

@property(nonatomic) UIEdgeInsets edgeInsets;

@end

@implementation UIEdgeInsetsLabel

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_edgeInsets, edgeInsets))
    {
        _edgeInsets = edgeInsets;
        
        [self setNeedsDisplay];
    }
}

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _edgeInsets)];
}

@end


@interface ALActionSheetView ()
{
    UIView *_backView;
    UIView *_actionSheetView;
    CGFloat _actionSheetHeight;
    BOOL  _isShow;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancelButtonTitle;
//@property (nonatomic, copy) NSString *destructiveButtonTitle;
@property (nonatomic, copy) NSIndexSet *destructiveButtonIndexSet;
//@property (nonatomic, copy) NSArray *otherButtonTitles;
@property (nonatomic, copy) NSArray *buttonTitles;

@end


@implementation ALActionSheetView

- (void)dealloc
{
    self.title= nil;
    self.cancelButtonTitle = nil;
//    self.destructiveButtonTitle = nil;
    self.destructiveButtonIndexSet = nil;
//    self.otherButtonTitles = nil;
    self.buttonTitles = nil;
    self.selectRowBlock = nil;
    
    _actionSheetView = nil;
    _backView = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        CGRect frame = [UIScreen mainScreen].bounds;
        self.frame = frame;
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonIndexes:(NSIndexSet *)indexSet buttonTitles:(NSArray *)buttonTitles handler:(ALActionSheetViewDidSelectButtonBlock)block
{
    self = [self init];
    
    if (self)
    {
        _title = title;
        _cancelButtonTitle = cancelButtonTitle;
//        _destructiveButtonTitle = destructiveButtonTitle;
        _destructiveButtonIndexSet = indexSet;
//        _otherButtonTitles = otherButtonTitles;
        _buttonTitles = buttonTitles;
        _selectRowBlock = block;
        
        _backView = [[UIView alloc] initWithFrame:self.frame];
        _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        _backView.alpha = 0.0f;
        [self addSubview:_backView];
        
        _actionSheetView = [[UIView alloc] init];
        _actionSheetView.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
        [self addSubview:_actionSheetView];
        
        CGFloat offy = 0;
        CGFloat width = self.frame.size.width;
        
        UIImage *normalImage = [self imageWithColor:[UIColor whiteColor]];
        UIImage *highlightedImage = [self imageWithColor:[UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]];
        
        if (_title && _title.length>0)
        {
            CGFloat titleWidth = width-kTitleHorizontalSpacing*2;
            
            CGFloat titleHeight = ceil([_title boundingRectWithSize:CGSizeMake(titleWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kTitleFontSize]} context:nil].size.height) + kTitleVerticalSpacing*2;
            
            UIEdgeInsetsLabel *titleLabel = [[UIEdgeInsetsLabel alloc] initWithFrame:CGRectMake(0, 0, width, titleHeight)];
            titleLabel.backgroundColor = [UIColor whiteColor];
            titleLabel.textColor = [UIColor colorWithRed:111.0f/255.0f green:111.0f/255.0f blue:111.0f/255.0f alpha:1.0f];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
            titleLabel.numberOfLines = 0;
            titleLabel.edgeInsets = UIEdgeInsetsMake(0, kTitleHorizontalSpacing, 0, kTitleHorizontalSpacing);
            titleLabel.text = _title;
            [_actionSheetView addSubview:titleLabel];
            
            offy += titleHeight+kRowLineHeight;
        }
        
        if ([_buttonTitles count] > 0)
        {
            offy += kRowLineHeight;
            
            for (int i = 0; i < _buttonTitles.count; i++)
            {
                UIButton *btn = [[UIButton alloc] init];
                btn.frame = CGRectMake(0, offy, width, kRowHeight);
                btn.tag = i;
                btn.backgroundColor = [UIColor whiteColor];
                btn.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleFontSize];
                
                if ([_destructiveButtonIndexSet containsIndex:i]) {
                    [btn setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:10.0f/255.0f blue:10.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
                }else{
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
                
                [btn setTitle:_buttonTitles[i] forState:UIControlStateNormal];
                [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
                [btn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(didSelectAction:) forControlEvents:UIControlEventTouchUpInside];
                [_actionSheetView addSubview:btn];
                
                offy += kRowHeight+kRowLineHeight;
            }
            
            offy -= kRowLineHeight;
        }
        
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, offy, width, kSeparatorHeight)];
        separatorView.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
        [_actionSheetView addSubview:separatorView];
        
        offy += kSeparatorHeight;
        
        
        UIButton *cancelBtn = [[UIButton alloc] init];
        cancelBtn.frame = CGRectMake(0, offy, width, kRowHeight);
        cancelBtn.tag = -1;
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleFontSize];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:_cancelButtonTitle ?: @"取消" forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(didSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [_actionSheetView addSubview:cancelBtn];
        
        offy += kRowHeight;
        
        _actionSheetHeight = offy;
        
        _actionSheetView.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), _actionSheetHeight);
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(ALActionSheetViewDidSelectButtonBlock)block;
{
    if (destructiveButtonTitle.length == 0) {
        return [self initWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonIndexes:nil buttonTitles:otherButtonTitles handler:block];
    }else{
        NSMutableArray *titles = [NSMutableArray arrayWithArray:otherButtonTitles];
        [titles insertObject:destructiveButtonTitle atIndex:0];
        return [self initWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonIndexes:[NSIndexSet indexSetWithIndex:0] buttonTitles:titles handler:block];
    }
}

+ (ALActionSheetView *)showActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(ALActionSheetViewDidSelectButtonBlock)block;
{
    ALActionSheetView *actionSheetView = [[ALActionSheetView alloc] initWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles handler:block];
    
    return actionSheetView;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_backView];
    if (!CGRectContainsPoint([_actionSheetView frame], point))
    {
        [self dismiss];
    }
}

- (void)didSelectAction:(UIButton *)button
{
    if (_selectRowBlock)
    {
        NSInteger index = button.tag;
        
        _selectRowBlock(self, index);
    }
    
    [self dismiss];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - public

- (void)show
{
    if(_isShow) return;
    
    _isShow = YES;
    
    [UIView animateWithDuration:0.35f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        _backView.alpha = 1.0;
        
        _actionSheetView.frame = CGRectMake(0, CGRectGetHeight(self.frame)-_actionSheetHeight, CGRectGetWidth(self.frame), _actionSheetHeight);
    } completion:NULL];
}

- (void)dismiss
{
    _isShow = NO;
    
    [UIView animateWithDuration:0.35f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        
        _backView.alpha = 0.0;
        
        _actionSheetView.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), _actionSheetHeight);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
