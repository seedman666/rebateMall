//
//  CustomTextField.m
//  sosozhe
//
//  Created by seed on 14-4-16.
//  Copyright (c) 2014年 sosozhe. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y+10, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    [[UIColor orangeColor] setFill];
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:14]];
}


@end
