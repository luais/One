//
//  QuestionEntity.m
//  ExampleOne
//
//  Created by Aries on 16/6/12.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "QuestionEntity.h"

@implementation QuestionEntity
- (NSString *)description {
    return [NSString stringWithFormat:@"sWebLk = %@, strQuestionId = %@, strQuestionContent = %@, strAnswerTitle = %@, sEditor = %@, strQuestionTitle = %@, strLastUpdateDate = %@, strPraiseNumber = %@, strDayDiffer = %@, strQuestionMarketTime = %@, strAnswerContent = %@.", self.sWebLk, self.strQuestionId, self.strQuestionContent, self.strAnswerTitle, self.sEditor, self.strQuestionTitle, self.strLastUpdateDate, self.strPraiseNumber, self.strDayDiffer, self.strQuestionMarketTime, self.strAnswerContent];
}

@end
