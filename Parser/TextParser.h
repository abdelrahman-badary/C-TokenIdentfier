//
//  TextParser.h
//  Parser
//
//  Created by Abd al rhman Taher on 10/22/15.
//  Copyright © 2015 Abd al rhman Taher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextParser : NSObject
-(id)initWithFile:(NSString *)file ;
-(NSArray *)parseFile ;
@property (nonatomic , strong) NSString * file ; 
@end
