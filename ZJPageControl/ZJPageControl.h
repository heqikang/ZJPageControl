//
//  ZJPageControl.h
//  ZJPageControl
//
//  Created by Evan on 7/9/2017.
//  Copyright © 2017 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ZJPageControl : UIControl

@property (nonatomic, assign) IBInspectable CGFloat lineWidth;

@property (nonatomic, assign) IBInspectable CGFloat radius;

@property (nonatomic, assign) IBInspectable CGFloat padding;

@property(nonatomic, assign) IBInspectable NSUInteger numberOfPages;
@property(nonatomic, assign) IBInspectable NSUInteger currentPage;

@property(nonatomic,strong) IBInspectable UIColor *pageIndicatorTintColor;
@property(nonatomic,strong) IBInspectable UIColor *currentPageIndicatorTintColor;

@property(nonatomic, assign) IBInspectable BOOL hidesForSinglePage;

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;

@end
