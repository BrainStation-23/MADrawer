//
//  MAGroupedDrawerView.m
//  MADrawer
//
//  Created by Mahjabin Alam on 9/14/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import "MAGroupedDrawerView.h"
#import <QuartzCore/QuartzCore.h>

@interface MAGroupedDrawerView(){
    NSIndexPath *selectedIndexPath;
}
@end

@implementation MAGroupedDrawerView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:10/255.0 green:0/255.0 blue:0/255.0 alpha:0.5]];
        self.drawerItemsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ((self.bounds.size.width/3)*2), self.bounds.size.height) style:UITableViewStyleGrouped];
        self.drawerItemsTableView.backgroundColor=[UIColor darkGrayColor];
        
        self.drawerItemsTableView.dataSource = self;
        self.drawerItemsTableView.delegate = self;
        
        self.drawerItemsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
    NSArray *groupeItems = (NSArray*)[self.drawerItems objectAtIndex:section];
    return  [groupeItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    
     UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
     [header.textLabel setTextColor:[UIColor whiteColor]];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if([self.headerTitles count] && section<[self.headerTitles count]){
        return [self.headerTitles objectAtIndex:section];
    }
    else{
        NSString *sectionTitle = @"Group ";
        NSString* sectionNumber = [NSString stringWithFormat:@"%ld", (section+1)];
        return [sectionTitle stringByAppendingString:sectionNumber];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MADrawerPlainCell *cell = [[MADrawerPlainCell alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
    NSArray *groupeItems = [[NSArray alloc]initWithArray:[self.drawerItems objectAtIndex:indexPath.section]];
    cell.itemLabel.text = [groupeItems objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark-
#pragma mark- UITableView Delegate methods


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MADrawerPlainCell *cell = (MADrawerPlainCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.itemLabel.textColor=[UIColor redColor];
    
    [self.delegate setActionForIndexPath:indexPath andGroupedItem:cell];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    MADrawerPlainCell *cell = (MADrawerPlainCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.itemLabel.textColor=[UIColor blackColor];
}

@end
