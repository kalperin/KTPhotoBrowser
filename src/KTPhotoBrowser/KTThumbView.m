//
//  KTThumbView.m
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/3/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "KTThumbView.h"
#import "KTThumbsViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation KTThumbView

@synthesize controller = controller_;
@synthesize index;

- (id)initWithFrame:(CGRect)frame
{
   if (self = [super initWithFrame:frame]) {

      [self addTarget:self
               action:@selector(didTouch:)
     forControlEvents:UIControlEventTouchUpInside];
      
      [self setClipsToBounds:YES];

      // If the thumbnail needs to be scaled, it should mantain its aspect
      // ratio.
      [[self imageView] setContentMode:UIViewContentModeScaleAspectFill];
	   
	   self.index = -1;
   }
   return self;
}

- (void)didTouch:(id)sender 
{
   if (controller_) {
      [controller_ didSelectThumbAtIndex:[self tag]];
   }
}

- (void)setThumbImage:(UIImage *)newImage 
{
  [self setImage:newImage forState:UIControlStateNormal];
}

- (void)setThumbImage:(UIImage *)newImage forIndex:(NSInteger)anIndex
{
	if (self.index < 0 || anIndex == self.index) {
		[self setThumbImage:newImage];
	}
}

- (void)setHasBorder:(BOOL)hasBorder
{
   if (hasBorder) {
      self.layer.borderColor = [UIColor colorWithWhite:0.85 alpha:1.0].CGColor;
      self.layer.borderWidth = 1;
   } else {
      self.layer.borderColor = nil;
   }
}


@end
