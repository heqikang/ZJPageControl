# ZJPageControl

![demo.gif](https://github.com/EvanZhou0319/ZJPageControl/blob/master/Example/demo.gif)

ZJPageControl is a custom animated page control to replace UIPageControl, inspired by [Tamino Martinius](https://dribbble.com/shots/2658222-Onboarding-Nav-Line-Animation).

## Requirements

- iOS 7.0+
- Xcode 8+

## Installation

#### Manually

Just add the `ZJPageControl` folder to your project

#### CocoaPods

use [CocoaPods](https://cocoapods.org/) with Podfile:

```
pod 'ZJPageControl', '~> 1.0'
```

## Usage

#### Storyboard

Just drop UIView and set it's class to be ZJPageControl. 

![ibdesignable.gif](https://github.com/EvanZhou0319/ZJPageControl/blob/master/Example/ibdesignable.gif)

#### Code

```
// init
ZJPageControl *pageControl = [[ZJPageControl alloc] initWithFrame:pageControlFrame];
pageControl.numberOfPages = 4;
pageControl.padding = 8;
pageControl.radius = 4;
pageControl.lineWidth = 2;
pageControl.pageIndicatorTintColor = [UIColor blueColor];
pageControl.currentPageIndicatorTintColor = [UIColor redColor];
[pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];

// set current page
pageControl.currentPage = 2;

// set current page with animation
[pageControl setCurrentPage:2 animated:YES];
```

## License

ZJPageControl is released under the MIT license. See [LICENSE](https://github.com/EvanZhou0319/ZJPageControl/blob/master/LICENSE) for details.