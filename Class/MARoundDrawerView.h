//
//  MARoundDrawerView.h
//  MADrawer
//
//  Created by Mahjabin Alam on 9/13/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADrawerRoundCornerCell.h"

@protocol MARoundDrawerViewDelegate;

@interface MARoundDrawerView : UIView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *drawerItemsTableView;
@property(nonatomic, strong) NSArray *drawerItems;


@property(nonatomic, strong) id<MARoundDrawerViewDelegate> delegate;

@end

@protocol MARoundDrawerViewDelegate <NSObject>

-(void)setActionForIndexPath:(NSIndexPath*)indexPath andRoundCorneredItem:(MADrawerRoundCornerCell*)sender;

@end
