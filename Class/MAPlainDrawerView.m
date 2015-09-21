//
//  MAPlainDrawerView.m
//  MADrawer
//
//  Created by Mahjabin Alam on 9/14/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import "MAPlainDrawerView.h"
#import <QuartzCore/QuartzCore.h>


@interface MAPlainDrawerView(){
    NSIndexPath *selectedIndexPath;
}
@end

@implementation MAPlainDrawerView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:10/255.0 green:0/255.0 blue:0/255.0 alpha:0.5]];
        self.drawerItemsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ((self.bounds.size.width/3)*2), self.bounds.size.height) style:UITableViewStylePlain];
        self.drawerItemsTableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
        self.drawerItemsTableView.dataSource = self;
        self.drawerItemsTableView.delegate = self;
        
        self.drawerItemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.drawerItemsTableView registerClass:[MADrawerPlainCell class] forCellReuseIdentifier:@"drawerItemCell"];
        
        [self addSubview:self.drawerItemsTableView];
        
    }
    return self;
}


#pragma mark-
#pragma mark- UITableView Datasource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.drawerItems count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MADrawerPlainCell *cell = [[MADrawerPlainCell alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
    cell.itemLabel.text = [self.drawerItems objectAtIndex:indexPath.section];
    return cell;
}



#pragma mark-
#pragma mark- UITableView Delegate methods


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MADrawerPlainCell *cell = (MADrawerPlainCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.itemLabel.textColor=[UIColor redColor];
   [self.delegate setActionForIndexPath:indexPath andPlainItem:cell];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    MADrawerPlainCell *cell = (MADrawerPlainCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.itemLabel.textColor=[UIColor blackColor];
}

@end
