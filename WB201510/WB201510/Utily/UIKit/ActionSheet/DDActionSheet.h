//
//  DDActionSheet.h
//  QuizUp
//
//  Created by Normal on 15/6/29.
//  Copyright (c) 2015年 Bo Wang. All rights reserved.
//

//#import "BTActionSheetView.h"
#import "ALActionSheetView.h"

@interface DDActionSheet : ALActionSheetView

- (instancetype)initWithTitle:(NSString *)title destructiveButtonIndexSet:(NSIndexSet *)destructiveIndexSet otherButtonTitles:(NSArray *)otherButtonTitles;

@property (nonatomic,readonly) NSInteger cancelIndex;

@property (nonatomic, copy) void (^didClickedButton)(NSInteger buttonIndex);

@end
