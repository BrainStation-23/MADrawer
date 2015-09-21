//
//  GroupedDrawerStyledViewController.m
//  MADrawer
//
//  Created by Mahjabin Alam on 9/18/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import "GroupedDrawerStyledViewController.h"

@interface GroupedDrawerStyledViewController ()

@end


#pragma mark-
#pragma mark- Life Cycle methods


@implementation GroupedDrawerStyledViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.drawerViewManager = [[MADrawerManagerView alloc]initWithFrame:CGRectMake((self.navigationController.navigationBar.bounds.origin.x + 10), (self.navigationController.navigationBar.bounds.origin.y+10), 40, 20)];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar addSubview:self.drawerViewManager];
    self.drawerViewManager.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-
#pragma mark- MADrawerButton delegates

-(UIViewController*)setParent{
    return self;
}

-(NSInteger)setDrawerStyle{
    return MADrawerStyleGrouped;
}

-(NSMutableArray*)setItems{
  
    //Take an array to hold the different groups
    NSMutableArray *itemGroups=[[NSMutableArray alloc]init];
    
    //add the groups as arrays to the group holder array(itemGroups)
    NSArray *list;
    list =[[NSArray alloc]initWithObjects:@"Note", @"Reminder", @"Calculator", nil];
    [itemGroups addObject:list];
    list =[[NSArray alloc]initWithObjects:@"Audio Player", @"Video Player", nil];
    [itemGroups addObject:list];
    return itemGroups;
}

-(NSMutableArray*)setHeaderTitles{
    NSMutableArray *headerTitles=[[NSMutableArray alloc]initWithObjects:@"Tools", @"Entertainment", nil];
    return headerTitles;
}

-(void)performActionForItem:(id)sender withItemNumber:(NSInteger)itemNumber inGroup:(NSInteger)groupNumber{
    NSLog(@"Item Group = %ld",  groupNumber);
    NSLog(@"Item number = %ld", itemNumber);
    
    UIViewController *vc = [[UIViewController alloc]init];
    MADrawerPlainCell *item = (MADrawerPlainCell*)sender;
    vc.title = item.itemLabel.text;
    
    if(itemNumber==0 && groupNumber==0){
        vc.view.backgroundColor = [UIColor redColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (itemNumber==1 && groupNumber==0){
        vc.view.backgroundColor = [UIColor blueColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (itemNumber==2 && groupNumber==0){
        vc.view.backgroundColor = [UIColor greenColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        vc.view.backgroundColor = [UIColor purpleColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
