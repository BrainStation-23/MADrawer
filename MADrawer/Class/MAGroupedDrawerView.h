//
//  MAGroupedDrawerView.h
//  MADrawer
//
//  Created by Mahjabin Alam on 9/14/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADrawerPlainCell.h"

@protocol MAGroupedDrawerViewDelegate;

@interface MAGroupedDrawerView : UIView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *drawerItemsTableView;
@property(nonatomic, strong) NSArray *drawerItems;
@property(nonatomic, strong) NSArray *headerTitles;

@property(nonatomic, strong) id<MAGroupedDrawerViewDelegate> delegate;

@end


@protocol MAGroupedDrawerViewDelegate <NSObject>


-(void)setActionForIndexPath:(NSIndexPath*)indexPath andGroupedItem:(MADrawerPlainCell*)sender;

@end