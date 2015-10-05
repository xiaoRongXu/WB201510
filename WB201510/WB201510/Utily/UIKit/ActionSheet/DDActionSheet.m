//
//  DDActionSheet.m
//  QuizUp
//
//  Created by Normal on 15/6/29.
//  Copyright (c) 2015年 Bo Wang. All rights reserved.
//

#import "DDActionSheet.h"
#import "UIImage+ImageEffects.h"

@interface DDActionSheet ()

@end

@implementation DDActionSheet

- (instancetype)initWithTitle:(NSString *)title destructiveButtonIndexSet:(NSIndexSet *)destructiveIndexSet otherButtonTitles:(NSArray *)otherButtonTitles;
{
    self = [super initWithTitle:title cancelButtonTitle:@"取消" destructiveButtonIndexes:destructiveIndexSet buttonTitles:otherButtonTitles handler:nil];
    __weak typeof(self) weakSelf = self;
    [self setSelectRowBlock:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex){
        if (weakSelf.didClickedButton) {
            weakSelf.didClickedButton(buttonIndex);
        }
    }];
    return self;
}

- (NSInteger)cancelIndex
{
    return -1;
}


@end
