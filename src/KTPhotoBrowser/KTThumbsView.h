//
//  KTThumbsView.h
//  Sample
//
//  Created by Kirby Turner on 3/23/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KTThumbsViewDataSource;
@class KTThumbsViewController;
@class KTThumbView;

@interface KTThumbsView : UIScrollView <UIScrollViewDelegate>
{
@private
   id <KTThumbsViewDataSource> __unsafe_unretained dataSource_;
   KTThumbsViewController *__unsafe_unretained controller_;
   BOOL thumbsHaveBorder_;
   NSInteger thumbsPerRow_;
   CGSize thumbSize_;
   
   NSMutableSet *reusableThumbViews_;
   
   // We use the following ivars to keep track of 
   // which thumbnail view indexes are visible.
   int firstVisibleIndex_;
   int lastVisibleIndex_;
   int lastItemsPerRow_;
}

@property (nonatomic, unsafe_unretained) id<KTThumbsViewDataSource> dataSource;
@property (nonatomic, unsafe_unretained) KTThumbsViewController *controller;
@property (nonatomic, assign) BOOL thumbsHaveBorder;
@property (nonatomic, assign) NSInteger thumbsPerRow;
@property (nonatomic, assign) CGSize thumbSize;

- (KTThumbView *)dequeueReusableThumbView;
- (void)reloadData;

@end

@protocol KTThumbsViewDataSource <NSObject>
@required
- (NSInteger)thumbsViewNumberOfThumbs:(KTThumbsView *)thumbsView;
- (KTThumbView *)thumbsView:(KTThumbsView *)thumbsView thumbForIndex:(NSInteger)index;

@end
