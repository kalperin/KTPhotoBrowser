//
//  KTPhotoView.h
//  Sample
//
//  Created by Kirby Turner on 2/24/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KTPhotoScrollViewController;


@interface KTPhotoView : UIScrollView <UIScrollViewDelegate>
{
   UIImageView *imageView_;
   KTPhotoScrollViewController *__unsafe_unretained scroller_;
   NSInteger index_;
}

@property (nonatomic, unsafe_unretained) KTPhotoScrollViewController *scroller;
@property (nonatomic, assign) NSInteger index;

- (void)setImage:(UIImage *)newImage;
- (void)turnOffZoom;

- (CGPoint)pointToCenterAfterRotation;
- (CGFloat)scaleToRestoreAfterRotation;
- (void)setMaxMinZoomScalesForCurrentBounds;
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale;

-(void)showActivityIndicator:(BOOL)show;

@end
