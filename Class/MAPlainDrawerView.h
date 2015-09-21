//
//  MAPlainDrawerView.h
//  MADrawer
//
//  Created by Mahjabin Alam on 9/14/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADrawerPlainCell.h"

@protocol MAPlainDrawerViewDelegate;

@interface MAPlainDrawerView : UIView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *drawerItemsTableView;
@property(nonatomic, strong) NSArray *drawerItems;


@property(nonatomic, strong) id<MAPlainDrawerViewDelegate> delegate;

@end

@protocol MAPlainDrawerViewDelegate <NSObject>

-(void)setActionForIndexPath:(NSIndexPath*)indexPath andPlainItem:(MADrawerPlainCell*)sender;


@end

