//
//  HomeEntity.m
//  ExampleOne
//
//  Created by Aries on 16/6/3.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "HomeEntity.h"

@implementation HomeEntity
- (NSString *)description {
    return [NSString stringWithFormat:@"strLastUpdateDate = %@, strDayDiffer = %@, strHpId = %@, strHpTitle = %@, strThumbnailUrl = %@, strOriginalImgUrl = %@, strAuthor = %@, strContent = %@, strMarketTime = %@, sWebLk = %@, strPn = %@, wImgUrl = %@.", self.strLastUpdateDate, self.strDayDiffer, self.strHpId, self.strHpTitle, self.strThumbnailUrl, self.strOriginalImgUrl, self.strAuthor, self.strContent, self.strMarketTime, self.sWebLk, self.strPn, self.wImgUrl];
}
@end
