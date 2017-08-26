//
//  ViewController.m
//  ZJPageControl
//
//  Created by Evan on 8/26/17.
//  Copyright © 2017 Evan. All rights reserved.
//

#import "ViewController.h"
#import "ZJPageControl.h"

@interface ViewController ()
{
}

@property (nonatomic, strong) ZJPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ZJPageControl *pageControl = [[ZJPageControl alloc] init];
    pageControl.backgroundColor = [UIColor colorWithRed:34.0/255.0 green:174.0/255.0 blue:230.0/255.0 alpha:1];
    pageControl.numberOfPages = 4;
    pageControl.padding = 8;
    pageControl.radius = 4;
    pageControl.lineWidth = 2;
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:60];
    [self.view addConstraint:topConstraint];
    
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:centerXConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:160];
    [pageControl addConstraint:heightConstraint];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:160];
    [pageControl addConstraint:widthConstraint];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pageControlValueChanged:(ZJPageControl *)pageControl {
    NSLog(@"%d",pageControl.currentPage);
}

@end
