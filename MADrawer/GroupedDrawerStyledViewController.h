//
//  GroupedDrawerStyledViewController.h
//  MADrawer
//
//  Created by Mahjabin Alam on 9/18/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADrawerManagerView.h"

@interface GroupedDrawerStyledViewController : UIViewController<MADrawerManagerViewDelegate>

@property(nonatomic, strong) MADrawerManagerView *drawerViewManager;

@end
