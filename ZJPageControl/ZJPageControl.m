//
//  ZJPageControl.m
//  ZJPageControl
//
//  Created by Evan on 7/9/2017.
//  Copyright © 2017 Evan. All rights reserved.
//

#import "ZJPageControl.h"

static const CGFloat kZJPageControlDefaultLineWidth = 2.0f;
static const CGFloat kZJPageControlDefaultPadding = 20.0f;
static const CGFloat kZJPageControlDefaultRadius = 10.0f;
static const CGFloat kZJPageControlDefaultAnimationDuration = 0.3f;

@interface ZJPageControl()<CAAnimationDelegate>
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) NSInteger lastPage;
@end

@implementation ZJPageControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _lastPage = 0;
    
    _lineWidth = kZJPageControlDefaultLineWidth;
    _padding = kZJPageControlDefaultPadding;
    _radius = kZJPageControlDefaultRadius;
    
    _hidesForSinglePage = NO;
    
    _numberOfPages = 0;
    _currentPage = 0;
    
    _pageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    _currentPageIndicatorTintColor = [UIColor whiteColor];
    
    [self.layer addSublayer:self.shapeLayer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)drawRect:(CGRect)rect {
    if ((self.numberOfPages <= 1 && self.hidesForSinglePage) || self.numberOfPages == 0) {
        return;
    }
    
    NSInteger totalWidth = self.numberOfPages * self.radius * 2 + (self.numberOfPages - 1) * self.padding;
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    for (int i = 0; i < self.numberOfPages; i++) {
        int minX = (self.frame.size.width - totalWidth) / 2 + (self.radius * 2 + self.padding) * i;
        CGContextSetStrokeColorWithColor(context, self.pageIndicatorTintColor.CGColor);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextAddArc(context, minX + self.radius, self.frame.size.height / 2, self.radius, 0, 2*M_PI, 0);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    [self resetPath];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.shapeLayer.frame = self.bounds;
    [self setNeedsDisplay];
}

#pragma mark - Event Response

- (void)onTapped:(UITapGestureRecognizer*)gesture {
    CGPoint touchPoint = [gesture locationInView:[gesture view]];
    
    BOOL isValueChanged = NO;
    if (touchPoint.x < self.frame.size.width / 2 ) {
        // move left
        if (self.currentPage > 0) {
            self.currentPage--;
            isValueChanged = YES;
        }
    } else {
        // move right
        if (self.currentPage < self.numberOfPages - 1) {
            self.currentPage++;
            isValueChanged = YES;
        }
    }
    
    if (isValueChanged) {
        [self movePageWithAnimated:YES];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark - Private Methods

- (void)resetPath {
    self.shapeLayer.path = [self pathWithAnimated:NO];
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 1;
}

- (void)movePageWithAnimated:(BOOL)animated {
    self.shapeLayer.path = [self pathWithAnimated:animated];
    if (animated) {
        int pageNumber = abs(self.currentPage - self.lastPage);
        CGFloat lineWidth = (self.radius * 2 + self.padding) * pageNumber;
        
        CGFloat circleWidth = 2 * M_PI * self.radius;
        CGFloat totalWidth = circleWidth * 2 + lineWidth;
        
        CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.fromValue = @(0);
        strokeStartAnimation.toValue = @(1 - circleWidth / totalWidth);
        
        CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @(circleWidth / totalWidth);
        strokeEndAnimation.toValue = @(1);
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.animations = @[strokeStartAnimation,strokeEndAnimation];
        animationGroup.duration = kZJPageControlDefaultAnimationDuration;
        animationGroup.delegate = self;
        [self.shapeLayer addAnimation:animationGroup forKey:@"StrokeAnimation"];
    }
}

- (CGPoint)centerOfCircleAtPage:(NSInteger)page {
    NSInteger totalWidth = self.numberOfPages * self.radius * 2 + (self.numberOfPages - 1) * self.padding;
    CGFloat midX = (self.frame.size.width - totalWidth) / 2 + (self.radius * 2 + self.padding) * page + self.radius;
    CGPoint center = CGPointMake(midX, self.frame.size.height / 2);
    return center;
}

- (CGPathRef)pathWithAnimated:(BOOL)animated {
    if ((self.numberOfPages <= 1 && self.hidesForSinglePage) || self.numberOfPages == 0) {
        return nil;
    }
    
    BOOL clockwise = self.lastPage > self.currentPage;
    
    CGFloat startAngle = 0.5 * M_PI;
    
    CGFloat endAngle;
    if (clockwise) {
        endAngle = startAngle + 2 * M_PI;
    } else {
        endAngle = startAngle - 2 * M_PI;
    }
    
    CGPoint lastCircleCenter = [self centerOfCircleAtPage:self.lastPage];
    CGPoint currentCircleCenter = [self centerOfCircleAtPage:self.currentPage];

    UIBezierPath *path = [UIBezierPath bezierPath];
    if (animated) {
        [path addArcWithCenter:lastCircleCenter radius:self.radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
        
        // Line
        CGFloat lineWidth = (self.radius * 2 + self.padding) * (self.currentPage - self.lastPage);
        
        [path moveToPoint:CGPointMake(lastCircleCenter.x, lastCircleCenter.y + self.radius)];
        [path addLineToPoint:CGPointMake(lastCircleCenter.x + lineWidth, lastCircleCenter.y + self.radius)];
    }
    [path addArcWithCenter:currentCircleCenter radius:self.radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    return path.CGPath;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self resetPath];
}

#pragma mark - Getter

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = self.bounds;
        _shapeLayer.lineWidth = _lineWidth;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = _currentPageIndicatorTintColor.CGColor;
    }
    return _shapeLayer;
}

#pragma mark - Setter

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage {
    _hidesForSinglePage = hidesForSinglePage;
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.shapeLayer.lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    [self setNeedsDisplay];
}

- (void)setPadding:(CGFloat)padding {
    _padding = padding;
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    [self setNeedsDisplay];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [self setCurrentPage:currentPage animated:NO];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    [self setNeedsDisplay];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.shapeLayer.strokeColor = currentPageIndicatorTintColor.CGColor;
    [self setNeedsDisplay];
}

#pragma mark - Public Methods

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated {
    if (self.numberOfPages <= 0 || currentPage > self.numberOfPages - 1 || currentPage < 0 || _currentPage == currentPage) {
        return;
    }
    _lastPage = _currentPage;
    _currentPage = currentPage;
    [self movePageWithAnimated:animated];
}

@end
