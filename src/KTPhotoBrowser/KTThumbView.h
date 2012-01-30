//
//  KTThumbView.h
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/3/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KTThumbsViewController;

@interface KTThumbView : UIButton 
{
@private
   KTThumbsViewController *__unsafe_unretained controller_;
}

@property (nonatomic, unsafe_unretained) KTThumbsViewController *controller;
@property(nonatomic, assign)NSInteger index;

- (id)initWithFrame:(CGRect)frame;
- (void)setThumbImage:(UIImage *)newImage;
- (void)setThumbImage:(UIImage *)newImage forIndex:(NSInteger)anIndex;
- (void)setHasBorder:(BOOL)hasBorder;

@end

