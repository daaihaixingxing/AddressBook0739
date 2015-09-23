//
//  ITView.m
//  AddressBook0739
//
//  Created by lanouhn on 15/9/15.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "ITView.h"

@interface ITView ()

@property (nonatomic,retain) UIImageView *leftImage;
@property (nonatomic,retain) UITextField *rightTextField;

@end

@implementation ITView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    
}


@end
