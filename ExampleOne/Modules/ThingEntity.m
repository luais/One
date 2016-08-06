//
//  ThingEntity.m
//  ExampleOne
//
//  Created by Aries on 16/6/2.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "ThingEntity.h"

@implementation ThingEntity

- (NSString *)description
{
    return [NSString stringWithFormat:@"strLastUpdateDate = %@, strPn = %@, strBu = %@, strTm = %@, strWu = %@, strId = %@, strTt = %@, strTc = %@.", self.strLastUpdateDate, self.strPn, self.strBu, self.strTm, self.strWu, self.strId, self.strTt, self.strTc];
}
@end
