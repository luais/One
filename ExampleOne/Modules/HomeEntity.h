//
//  HomeEntity.h
//  ExampleOne
//
//  Created by Aries on 16/6/3.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  首页－model
 */
@interface HomeEntity : NSObject
//"strLastUpdateDate": "2015-07-22 15:50:45",
//"strDayDiffer": "",
//"strHpId": "1043",
//"strHpTitle": "VOL.1024",
//"strThumbnailUrl": "http:\/\/pic.yupoo.com\/hanapp\/EOTa3fZW\/69lSZ.jpg",
//"strOriginalImgUrl": "http:\/\/pic.yupoo.com\/hanapp\/EOTa3fZW\/69lSZ.jpg",
//"strAuthor": "花&高思远 作品",
//"strContent": "分别是，从此就一个人站在茫茫人群中，一个人站在世界上。我的每句话、每件事，都不能再说给你听。 by 苏更生",
//"strMarketTime": "2015-07-28",
//"sWebLk": "http:\/\/m.wufazhuce.com\/one\/2015-07-28",
//"strPn": "20592",
//"wImgUrl": "http:\/\/211.152.49.184:9000\/upload\/onephoto\/f1437551445290.jpg"

@property (nonatomic,strong)NSString *strLastUpdateDate;
@property (nonatomic,strong) NSString *strDayDiffer;
@property (nonatomic,strong) NSString *strHpId;
@property (nonatomic,strong) NSString *strHpTitle;
@property (nonatomic,strong) NSString *strThumbnailUrl;
@property (nonatomic,strong) NSString *strOriginalImgUrl;
@property (nonatomic,strong) NSString *strAuthor;
@property (nonatomic,strong) NSString *strContent;
@property (nonatomic,strong) NSString *strMarketTime;
@property (nonatomic,strong) NSString *sWebLk;
@property (nonatomic,strong) NSString *strPn;
@property (nonatomic,strong) NSString *wImgUrl;
@end
