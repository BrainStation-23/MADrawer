//
//  UIView+UIViewExtension.h
//  MADrawer
//
//  Created by Mahjabin Alam on 9/13/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewExtension)

- (UIViewController *) parentViewController;
- (id) traverseResponderChainForUIViewController;

@end
