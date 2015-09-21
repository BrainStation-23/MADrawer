//
//  MARoundDrawerView.m
//  MADrawer
//
//  Created by Mahjabin Alam on 9/13/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import "MARoundDrawerView.h"
#import <QuartzCore/QuartzCore.h>


@interface MARoundDrawerView(){
    NSIndexPath *selectedIndexPath;
}
@end

@implementation MARoundDrawerView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.65]];
        self.drawerItemsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, (((self.bounds.size.width/3)*2)-10), self.bounds.size.height) style:UITableViewStylePlain];
        self.drawerItemsTableView.backgroundColor=[UIColor lightGrayColor];
        
        self.drawerItemsTableView.dataSource = self;
        self.drawerItemsTableView.delegate = self;
        
        self.drawerItemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.drawerItemsTableView registerClass:[MADrawerRoundCornerCell class] forCellReuseIdentifier:@"drawerItemCell"];
        
        
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MADrawerRoundCornerCell *cell = [[MADrawerRoundCornerCell alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
    CGColorRef borderColor = [[UIColor grayColor]CGColor];
    cell.layer.cornerRadius= 5.0f;
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=borderColor;
    cell.layer.masksToBounds=YES;
    cell.itemLabel.text = [self.drawerItems objectAtIndex:indexPath.section];
    return cell;
}



#pragma mark-
#pragma mark- UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MADrawerRoundCornerCell *cell = (MADrawerRoundCornerCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.itemLabel.textColor=[UIColor blackColor];
    [self.delegate setActionForIndexPath:indexPath andRoundCorneredItem:cell];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
        MADrawerRoundCornerCell *cell = (MADrawerRoundCornerCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.itemLabel.textColor=[UIColor whiteColor];
}

@end
