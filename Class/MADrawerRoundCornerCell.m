//
//  MADrawerRoundCornerCell.m
//  MADrawer
//
//  Created by Mahjabin Alam on 9/13/15.
//  Copyright (c) 2015 Brainstation-23. All rights reserved.
//

#import "MADrawerRoundCornerCell.h"

@implementation MADrawerRoundCornerCell

- (void)drawRect:(CGRect)rect {
    
    // constants
    const CGFloat outlineStrokeWidth = 1.0f;
    const CGFloat outlineCornerRadius = 10.0f;
    
    // get the context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the background color to white
    CGContextSetFillColorWithColor(context, [[UIColor grayColor] CGColor]);
    CGContextFillRect(context, rect);
    
    // inset the rect because half of the stroke applied to this path will be on the outside
    CGRect insetRect = CGRectInset(rect, outlineStrokeWidth/2.0f, outlineStrokeWidth/2.0f);
    
    // get our rounded rect as a path
    CGMutablePathRef path = createRoundedCornerPath(insetRect, outlineCornerRadius);
    
    // add the path to the context
    CGContextAddPath(context, path);
    
    // set the stroke params
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGContextSetLineWidth(context, outlineStrokeWidth);
    
    // draw the path
    CGContextDrawPath(context, kCGPathStroke);
    
    // release the path
    CGPathRelease(path);
}

CGMutablePathRef createRoundedCornerPath(CGRect rect, CGFloat cornerRadius) {
    
    // create a mutable path
    CGMutablePathRef path = CGPathCreateMutable();
    
    // get the 4 corners of the rect
    CGPoint topLeft = CGPointMake(rect.origin.x, rect.origin.y);
    CGPoint topRight = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    CGPoint bottomRight = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGPoint bottomLeft = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
    
    // move to top left
    CGPathMoveToPoint(path, NULL, topLeft.x + cornerRadius, topLeft.y);
    
    // add top line
    CGPathAddLineToPoint(path, NULL, topRight.x - cornerRadius, topRight.y);
    
    // add top right curve
    CGPathAddQuadCurveToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y + cornerRadius);
    
    // add right line
    CGPathAddLineToPoint(path, NULL, bottomRight.x, bottomRight.y - cornerRadius);
    
    // add bottom right curve
    CGPathAddQuadCurveToPoint(path, NULL, bottomRight.x, bottomRight.y, bottomRight.x - cornerRadius, bottomRight.y);
    
    // add bottom line
    CGPathAddLineToPoint(path, NULL, bottomLeft.x + cornerRadius, bottomLeft.y);
    
    // add bottom left curve
    CGPathAddQuadCurveToPoint(path, NULL, bottomLeft.x, bottomLeft.y, bottomLeft.x, bottomLeft.y - cornerRadius);
    
    // add left line
    CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y + cornerRadius);
    
    // add top left curve
    CGPathAddQuadCurveToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x + cornerRadius, topLeft.y);
    
    // return the path
    return path;
}


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, self.bounds.size.width, self.bounds.size.height - 20)];
        
        self.itemLabel.textColor = [UIColor whiteColor];
        self.itemLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.itemLabel];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
