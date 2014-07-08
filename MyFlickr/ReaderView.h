//
//  ReaderView.h
//  Reader
//
//  Created by florian BUREL on 10/07/13.
//  Copyright (c) 2013 Florian Burel. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ReaderViewDelegate <NSObject>

// Must return the view to be displayed at the given index
- (UIView *) viewForPageAtIndex:(NSInteger)idx;

- (int) numberOfPages;

@end


@interface ReaderView : UIView

@property (nonatomic, readwrite, assign) id<ReaderViewDelegate> delegate;

@property (nonatomic, readonly) int currentPageIndex;

- (void) displayPageAtIndex:(int)idx animated:(BOOL)animated;

@end
