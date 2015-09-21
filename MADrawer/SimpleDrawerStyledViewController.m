//
//  SimpleDrawerStyledViewController.m
//  MADrawer
//
//  Created by Mahjabin Alam on 9/18/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import "SimpleDrawerStyledViewController.h"

@interface SimpleDrawerStyledViewController ()

@end

@implementation SimpleDrawerStyledViewController

#pragma mark-
#pragma mark- Life Cycle methods

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
#pragma mark- drawerViewManager delegates

-(UIViewController*)setParent{
    return self;
}

-(NSInteger)setDrawerStyle{
    return MADrawerStylePlain;
}

-(NSMutableArray*)setItems{
    NSMutableArray *items =[[NSMutableArray alloc]initWithObjects:@"Home", @"Gallary", @"Contacts", nil];
    return items;
}

-(void)performActionForItem:(id)sender withItemNumber:(NSInteger)itemNumber inGroup:(NSInteger)groupNumber{
    
    UIViewController *vc = [[UIViewController alloc]init];
    MADrawerPlainCell *item = (MADrawerPlainCell*)sender;
   
    vc.title = item.itemLabel.text;
    
    if(itemNumber==0 ){
        vc.view.backgroundColor = [UIColor greenColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (itemNumber==1){
        vc.view.backgroundColor = [UIColor blueColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (itemNumber==2){
        vc.view.backgroundColor = [UIColor purpleColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        vc.view.backgroundColor = [UIColor cyanColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
