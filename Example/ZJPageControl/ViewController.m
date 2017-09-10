//
//  ViewController.m
//  ZJPageControl
//
//  Created by Evan on 8/26/17.
//  Copyright © 2017 Evan. All rights reserved.
//

#import "ViewController.h"
#import "ZJPageControl.h"

@interface ViewController () {
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pageControlValueChanged:(ZJPageControl *)sender {
    NSLog(@"current page = %d",sender.currentPage);
}

@end
