//
//  KTThumbsViewController.m
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/3/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "KTThumbsViewController.h"
#import "KTThumbsView.h"
#import "KTThumbView.h"
#import "KTPhotoScrollViewController.h"


@interface KTThumbsViewController (Private)
@end


@implementation KTThumbsViewController

@synthesize dataSource = dataSource_;

- (void)dealloc {
   scrollView_ = nil;
   
}


- (void)loadView {
   // Make sure to set wantsFullScreenLayout or the photo
   // will not display behind the status bar.
   [self setWantsFullScreenLayout:YES];

   KTThumbsView *scrollView = [[KTThumbsView alloc] initWithFrame:CGRectZero];
   [scrollView setDataSource:self];
   [scrollView setController:self];
   [scrollView setScrollsToTop:YES];
   [scrollView setScrollEnabled:YES];
   [scrollView setAlwaysBounceVertical:YES];
   [scrollView setBackgroundColor:[UIColor whiteColor]];
   
   if ([dataSource_ respondsToSelector:@selector(thumbsHaveBorder)]) {
      [scrollView setThumbsHaveBorder:[dataSource_ thumbsHaveBorder]];
   }
   
   if ([dataSource_ respondsToSelector:@selector(thumbSize)]) {
      [scrollView setThumbSize:[dataSource_ thumbSize]];
   }
   
   if ([dataSource_ respondsToSelector:@selector(thumbsPerRow)]) {
      [scrollView setThumbsPerRow:[dataSource_ thumbsPerRow]];
   }
   
   
   // Set main view to the scroll view.
   [self setView:scrollView];
   
   // Retain a reference to the scroll view.
   scrollView_ = scrollView;
   
   // Release the local scroll view reference.
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated {
  // The first time the view appears, store away the current translucency so we can reset on pop.
  UINavigationBar *navbar = [[self navigationController] navigationBar];
  if (!viewDidAppearOnce_) {
    viewDidAppearOnce_ = YES;
    navbarWasTranslucent_ = [navbar isTranslucent];
  }
  // Then ensure translucency to match the look of Apple's Photos app.
  [navbar setTranslucent:YES];
  [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  // Restore old translucency when we pop this controller.
  UINavigationBar *navbar = [[self navigationController] navigationBar];
  [navbar setTranslucent:navbarWasTranslucent_];
  [super viewWillDisappear:animated];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)willLoadThumbs {
   // Do nothing by default.
}

- (void)didLoadThumbs {
   // Do nothing by default.
}

- (void)reloadThumbs 
{
	[self willLoadThumbs];
	[self performSelector:@selector(delayedLoadThumbs) withObject:nil afterDelay:0.01f];	
}

-(void)delayedLoadThumbs
{
	[scrollView_ reloadData];
	[self didLoadThumbs];
	
}

- (void)setDataSource:(id <KTPhotoBrowserDataSource>)newDataSource {
   dataSource_ = newDataSource;
   [self reloadThumbs];
}

- (void)didSelectThumbAtIndex:(NSUInteger)index {
   UIViewController *newController = [self viewControllerForPhotoAtIndex: index];
  
   [[self navigationController] pushViewController:newController animated:YES];
}

-(UIViewController *)viewControllerForPhotoAtIndex:(NSUInteger)index
{
	KTPhotoScrollViewController *newController = [[KTPhotoScrollViewController alloc] 
												  initWithDataSource:dataSource_ 
                                                  andStartWithPhotoAtIndex:index];
	return newController;

}

#pragma mark -
#pragma mark KTThumbsViewDataSource

- (NSInteger)thumbsViewNumberOfThumbs:(KTThumbsView *)thumbsView
{
   NSInteger count = [dataSource_ numberOfPhotos];
   return count;
}

- (KTThumbView *)thumbsView:(KTThumbsView *)thumbsView thumbForIndex:(NSInteger)index
{
   KTThumbView *thumbView = [thumbsView dequeueReusableThumbView];
   if (!thumbView) {
      thumbView = [[KTThumbView alloc] initWithFrame:CGRectZero];
      [thumbView setController:self];
   }
	thumbView.index = index;

   // Set thumbnail image.
   if ([dataSource_ respondsToSelector:@selector(thumbImageAtIndex:thumbView:)] == NO) {
      // Set thumbnail image synchronously.
      UIImage *thumbImage = [dataSource_ thumbImageAtIndex:index];
      [thumbView setThumbImage:thumbImage];
   } else {
      // Set thumbnail image asynchronously.
	  [thumbView setThumbImage:nil];
      [dataSource_ thumbImageAtIndex:index thumbView:thumbView];
   }
   
   return thumbView;
}


@end
