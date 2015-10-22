//
//  TokenIdentifier.h
//  Parser
//
//  Created by Abd al rhman Taher on 10/22/15.
//  Copyright © 2015 Abd al rhman Taher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TokenIdentifier : NSObject
@property (nonatomic , strong) NSArray * contentsOfFile ; 
-(id)initWithContentsOfFile:(NSArray *)fileContents ;
-(NSArray *)identify ;

-(NSArray *)keywords ;
-(NSArray *)operators ;
-(NSArray *)specialSymbols ;
-(NSArray *)identfires ;
-(NSArray *)stringLiterals ;
-(NSArray *)intLiterals ; 

@end
