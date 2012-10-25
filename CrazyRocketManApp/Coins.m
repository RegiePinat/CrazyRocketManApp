//
//  Coins.m
//  CrazyRocketManApp
//
//  Created by Regie G. Pinat on 10/24/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import "Coins.h"

@implementation Coins
@synthesize value;





- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(distance) getDistanceFrom:(UIImageView *)character
{
    distance distancevar;
    distancevar.xdistance = self.center.x - character.center.x;
    distancevar.ydistance = self.center.y - character.center.y;
 distancevar.mainDistance = (float) sqrt(pow(distancevar.xdistance, 2) + pow(distancevar.ydistance, 2));
    
    return distancevar;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/




@end
