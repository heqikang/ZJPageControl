//
//  ZJPageControl.h
//  ZJPageControl
//
//  Created by Evan on 7/9/2017.
//  Copyright © 2017 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJPageControl : UIControl


@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, assign) CGFloat padding;

@property(nonatomic, assign) BOOL hidesForSinglePage;

@property(nonatomic, assign) NSInteger numberOfPages;
@property(nonatomic, assign) NSInteger currentPage;

@property(nonatomic,strong) UIColor *pageIndicatorTintColor;
@property(nonatomic,strong) UIColor *currentPageIndicatorTintColor;


- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;

@end
