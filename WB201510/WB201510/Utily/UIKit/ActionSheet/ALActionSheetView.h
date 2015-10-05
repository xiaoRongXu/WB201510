//
//  ALActionSheetView.h
//  ALActionSheetView
//
//  Created by WangQi on 7/4/15.
//  Copyright (c) 2015 WangQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALActionSheetView;

typedef void (^ALActionSheetViewDidSelectButtonBlock)(ALActionSheetView *actionSheetView, NSInteger buttonIndex);

@interface ALActionSheetView : UIView


- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(ALActionSheetViewDidSelectButtonBlock)block;
- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonIndexes:(NSIndexSet *)indexSet buttonTitles:(NSArray *)buttonTitles handler:(ALActionSheetViewDidSelectButtonBlock)block;

@property (nonatomic, copy) ALActionSheetViewDidSelectButtonBlock selectRowBlock;

- (void)show;
- (void)dismiss;

@end
