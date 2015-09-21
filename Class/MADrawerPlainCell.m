//
//  MADrawerPlainCell.m
//  MADrawer
//
//  Created by Mahjabin Alam on 9/14/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import "MADrawerPlainCell.h"

@implementation MADrawerPlainCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, self.bounds.size.width, self.bounds.size.height - 20)];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.itemLabel.textColor = [UIColor blackColor];
        self.itemLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.itemLabel];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
@end
