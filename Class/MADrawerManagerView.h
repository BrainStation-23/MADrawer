//
//  MADrawerManagerView.h
//  MADrawer
//
//  Created by Mahjabin Alam on 9/13/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPlainDrawerView.h"
#import "MARoundDrawerView.h"
#import "MAGroupedDrawerView.h"
#import "UIView+UIViewExtension.h"

typedef enum{
    MADrawerStylePlain      = 1,
    MADrawerStyleGrouped    = 2,
    MADrawerStyleRoundEdged = 3
}MADrawerStyle;


@protocol MADrawerManagerViewDelegate;

@interface MADrawerManagerView : UIButton<MARoundDrawerViewDelegate, MAPlainDrawerViewDelegate, MAGroupedDrawerViewDelegate>

@property BOOL firstTime;
    @property(nonatomic, strong) NSMutableArray *items;
    @property(nonatomic, strong) NSMutableArray *headerTitles;
    @property NSInteger drawerStyle;
    @property(nonatomic, strong) id<MADrawerManagerViewDelegate> delegate;

@end


@protocol MADrawerManagerViewDelegate <NSObject>

@required
-(UIViewController*)setParent;

@optional
-(void)performActionForItem:(id)sender withItemNumber:(NSInteger)itemNumber inGroup:(NSInteger)groupNumber;
-(NSMutableArray*)setItems;
-(NSMutableArray*)setHeaderTitles;
-(NSInteger)setDrawerStyle;

@end