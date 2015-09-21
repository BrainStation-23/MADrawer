//
//  RoundEdgedDrawerViewController.h
//  MADrawer
//
//  Created by Mahjabin Alam on 9/13/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADrawerManagerView.h"

@interface RoundEdgedDrawerViewController : UIViewController<MADrawerManagerViewDelegate>

@property(nonatomic, strong) MADrawerManagerView *drawerViewManager;

@end
