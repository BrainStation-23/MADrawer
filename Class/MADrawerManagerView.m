//
//  MADrawerManagerView.m
//  MADrawer
//
//  Created by Mahjabin Alam on 9/13/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//


#import "MADrawerManagerView.h"

#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define DEFAULT_STYLE @"Plain"

@interface MADrawerManagerView(){
    MAPlainDrawerView *plainDrawer;
    MAGroupedDrawerView *groupedDrawer;
    MARoundDrawerView *corneredDrawer;
    UIViewController *parent;
}

@end

@implementation MADrawerManagerView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        parent = [self.delegate setParent];
        UIImage *drawerImage = [UIImage imageNamed:@"drawer.jpg"];
        self.backgroundColor = [UIColor clearColor];
        [self setImage:drawerImage forState:UIControlStateNormal];
        self.selected=NO;
        self.firstTime=YES;
        [self addTarget:self action:@selector(showOrHideDrawer) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark-
#pragma mark- control drawer openning and closing

-(void)showOrHideDrawer{
    [self getitemsAndStyle];
    if(![self isSelected] && self.firstTime){
       
        if(self.drawerStyle==MADrawerStylePlain){
            plainDrawer = [[MAPlainDrawerView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+44, (parent.view.bounds.size.width), parent.view.bounds.size.height)];
             plainDrawer.delegate=self;
             plainDrawer.drawerItems= [[NSMutableArray alloc]initWithArray:self.items];
            [parent.view addSubview:plainDrawer];
        }
         else if(self.drawerStyle==MADrawerStyleGrouped){
             groupedDrawer = [[MAGroupedDrawerView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+44, (parent.view.bounds.size.width), parent.view.bounds.size.height)];
             if(self.delegate && [self.delegate respondsToSelector:@selector(setHeaderTitles)]){
                 self.headerTitles = [self.delegate setHeaderTitles];
             }
             
             groupedDrawer.delegate=self;
             groupedDrawer.drawerItems = [[NSMutableArray alloc]initWithArray:self.items];
             groupedDrawer.headerTitles= [[NSMutableArray alloc]initWithArray:self.headerTitles];
             [parent.view addSubview:groupedDrawer];
         }
        else{
            corneredDrawer = [[MARoundDrawerView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+44, (parent.view.bounds.size.width), parent.view.bounds.size.height)];
            corneredDrawer.delegate=self;
            corneredDrawer.drawerItems = [[NSMutableArray alloc]initWithArray:self.items];
            [parent.view addSubview:corneredDrawer];
        }
        
        [self alterSelection];
        [self addSwipeFeature];
        self.firstTime=NO;
    }
    else if(![self isSelected] && !self.firstTime){
        [self showDrawer];
    }
    else{
        [self hideDrawer];
    }
}

#pragma mark-
#pragma mark- utility methods

-(void)getitemsAndStyle{
    parent = [self.delegate setParent];
    if(self.delegate && [self.delegate respondsToSelector:@selector(setDrawerStyle)]){
        self.drawerStyle = [self.delegate setDrawerStyle];
    }
    else{
        self.drawerStyle = MADrawerStylePlain;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(setItems)]){
        self.items = [self.delegate setItems];
    }
    else{
        self.items = [[NSMutableArray alloc]initWithObjects:@"Custom Item", @"Custom Item", @"Custom Item", @"Custom Item", nil];
    }
}
-(void)alterSelection{
    self.selected = !self.selected;
}

-(void)addSwipeFeature{
   UISwipeGestureRecognizer *recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDrawerIn)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [parent.view addGestureRecognizer:recognizerLeft];
    
    UISwipeGestureRecognizer *recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDrawerOut)];
    [recognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [parent.view addGestureRecognizer:recognizerRight];
}

-(void)removeDrawer{
    [self removeFromSuperview];
}
#pragma mark-
#pragma mark- Create, Show or Animate the drawer out


-(void)showDrawer{
    CGRect drawerRightSide;
    if(self.drawerStyle == MADrawerStylePlain){
         drawerRightSide = plainDrawer.frame;
    }
    else if(self.drawerStyle == MADrawerStyleGrouped){
        drawerRightSide = groupedDrawer.frame;
    }
    else{
         drawerRightSide = corneredDrawer.frame;
    }
   
    drawerRightSide.origin.x += drawerRightSide.size.width;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                          if(self.drawerStyle==MADrawerStylePlain){
                               plainDrawer.frame = drawerRightSide;
                          }
                          else if(self.drawerStyle==MADrawerStyleGrouped){
                              groupedDrawer.frame = drawerRightSide;
                          }
                          else{
                              corneredDrawer.frame = drawerRightSide;
                          }
                     }
                     completion:^(BOOL finished){
                         [self alterSelection];
                         NSLog(@"Drawer Opened!");
                     }];
}

-(void)hideDrawer{
    CGRect drawerRightSide;
    if(self.drawerStyle == MADrawerStylePlain){
        drawerRightSide = plainDrawer.frame;
    }
    else if(self.drawerStyle == MADrawerStyleGrouped){
        drawerRightSide = groupedDrawer.frame;
    }
    else{
        drawerRightSide = corneredDrawer.frame;
    }
    drawerRightSide.origin.x -= drawerRightSide.size.width;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         if(self.drawerStyle==MADrawerStylePlain){
                             plainDrawer.frame=drawerRightSide;
                         }
                         else if(self.drawerStyle == MADrawerStyleGrouped){
                             groupedDrawer.frame = drawerRightSide;
                         }
                         else{
                             corneredDrawer.frame = drawerRightSide;
                         }
                     }
                     completion:^(BOOL finished){
                         [self alterSelection];
                         NSLog(@"Drawer closed!");
                     }];
}

#pragma mark-
#pragma mark- Swipe drawer in and out


-(void)swipeDrawerIn{
     if([self isSelected]){
         CGRect drawerRightSide;
         if(self.drawerStyle ==MADrawerStylePlain){
             drawerRightSide = plainDrawer.frame;
         }
         else if(self.drawerStyle== MADrawerStyleGrouped){
             drawerRightSide = groupedDrawer.frame;
         }
         else{
             drawerRightSide = corneredDrawer.frame;
         }
         drawerRightSide.origin.x -= drawerRightSide.size.width;
         
         [UIView animateWithDuration:0.3
                               delay:0.0
                             options: UIViewAnimationOptionCurveEaseIn
                          animations:^{
                              if(self.drawerStyle==MADrawerStylePlain){
                                  plainDrawer.frame=drawerRightSide;
                              }
                              else if(self.drawerStyle==MADrawerStyleGrouped){
                                  groupedDrawer.frame = drawerRightSide;
                              }
                              else{
                                  corneredDrawer.frame = drawerRightSide;
                              }
                          }
                          completion:^(BOOL finished){
                              [self alterSelection];
                              NSLog(@"Drawer closed By Swiping!");
                          }];
     }
}

-(void)swipeDrawerOut{
    if(![self isSelected] && !self.firstTime){
        CGRect drawerRightSide;
        if(self.drawerStyle==MADrawerStylePlain){
            drawerRightSide = plainDrawer.frame;
        }
         else if(self.drawerStyle==MADrawerStyleGrouped){
             drawerRightSide = groupedDrawer.frame;
         }
        else{
            drawerRightSide = corneredDrawer.frame;
        }
        
        drawerRightSide.origin.x += drawerRightSide.size.width;
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             if(self.drawerStyle==MADrawerStylePlain){
                                 plainDrawer.frame = drawerRightSide;
                             }
                             else if(self.drawerStyle==MADrawerStyleGrouped){
                                 groupedDrawer.frame = drawerRightSide;
                             }
                             else{
                                 corneredDrawer.frame = drawerRightSide;
                             }
                         }
                         completion:^(BOOL finished){
                             [self alterSelection];
                             NSLog(@"Drawer Opened by Swiping!");
                         }];
    }
}

#pragma mark-
#pragma mark- Round Corner style DrawerView Delegate methods

-(void)setActionForIndexPath:(NSIndexPath*)indexPath andRoundCorneredItem:(MADrawerRoundCornerCell*)sender{
    [self removeFromSuperview];
    [self hideDrawer];
    if(self.delegate && [self.delegate respondsToSelector:@selector(performActionForItem:withItemNumber:inGroup:)]){
         [self.delegate performActionForItem:sender withItemNumber:indexPath.section inGroup:indexPath.row];
    }
   
}

#pragma mark-
#pragma mark- Plain Style DrawerView Delegate methods

-(void)setActionForIndexPath:(NSIndexPath*)indexPath andPlainItem:(MADrawerPlainCell*)sender{
    [self removeFromSuperview];
    [self hideDrawer];
    if(self.delegate && [self.delegate respondsToSelector:@selector(performActionForItem:withItemNumber:inGroup:)]){
        [self.delegate performActionForItem:sender withItemNumber:indexPath.section inGroup:indexPath.row];
    }
}

#pragma mark-
#pragma mark- Groped style DrawerView Delegate methods

-(void)setActionForIndexPath:(NSIndexPath*)indexPath andGroupedItem:(MADrawerPlainCell*)sender{
    [self removeFromSuperview];
    [self hideDrawer];
     if(self.delegate && [self.delegate respondsToSelector:@selector(performActionForItem:withItemNumber:inGroup:)]){
         [self.delegate performActionForItem:sender withItemNumber:indexPath.row inGroup:indexPath.section];
     }
}

@end
