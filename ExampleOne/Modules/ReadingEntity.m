//
//  ReadingEntity.m
//  ExampleOne
//
//  Created by Aries on 16/6/1.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "ReadingEntity.h"

@implementation ReadingEntity
- (NSString *)description {
    return [NSString stringWithFormat:@"strContent = %@, sRdNum = %@, strContentId = %@, subTitle = %@, strContDayDiffer = %@, strPraiseNumber = %@, strLastUpdateDate = %@, sGW = %@, sAuth = %@, sWebLk = %@, wImgUrl = %@, strContAuthorIntroduce = %@, strContTitle = %@, sWbN = %@, strContAuthor = %@, strContMarketTime = %@.", self.strContent, self.sRdNum, self.strContentId, self.subTitle, self.strContDayDiffer, self.strPraiseNumber, self.strLastUpdateDate, self.sGW, self.sAuth, self.sWebLk, self.wImgUrl, self.strContAuthorIntroduce, self.strContTitle, self.sWbN, self.strContAuthor, self.strContMarketTime];
}
@end
