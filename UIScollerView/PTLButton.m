//
//  PTLButton.m
//  UIScollerView
//
//  Created by soliloquy on 2018/12/6.
//  Copyright © 2018 ptlCoder. All rights reserved.
//

#import "PTLButton.h"

@implementation PTLButton


-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin = CGPointMake(0, 0);
    titleRect.size = CGSizeMake(self.frame.size.width, self.frame.size.height/2);
    self.titleLabel.frame = titleRect;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    CGRect imageRect = self.imageView.frame;
    imageRect.origin = CGPointMake(0, titleRect.size.height);
    imageRect.size = CGSizeMake(self.frame.size.width, self.frame.size.height/2);
    self.imageView.frame = imageRect;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

@end
