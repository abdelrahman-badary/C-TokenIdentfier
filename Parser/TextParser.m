//
//  TextParser.m
//  Parser
//
//  Created by Abd al rhman Taher on 10/22/15.
//  Copyright © 2015 Abd al rhman Taher. All rights reserved.
//

#import "TextParser.h"

@implementation TextParser
-(id)initWithFile:(NSString *)file
{
    self = [super init] ;
    if(self)
    {
        _file = file ;
    }
    return self ;
}
-(NSArray *)parseFile
{
    NSString * fileContents ;
    fileContents = [self getFileContents] ;
    
    NSCharacterSet * delimeters = [NSCharacterSet characterSetWithCharactersInString:@";"] ;
    
    NSCharacterSet * newLines = [NSCharacterSet characterSetWithCharactersInString:@"\n"] ;
    fileContents =
    [[fileContents componentsSeparatedByCharactersInSet:newLines]
     componentsJoinedByString:@""];
    
    NSArray* singleLines =
    [fileContents componentsSeparatedByCharactersInSet:delimeters];
    
  
    
    
    //return fileContents ;
    return singleLines ; 
    
}
-(NSString *)getFileContents
{
    NSString* filePath = _file ;
    NSString* fileRoot = [[NSBundle mainBundle]
                          pathForResource:filePath ofType:@"txt"];
    
    
    NSString* fileContents =
    [NSString stringWithContentsOfFile:fileRoot
                              encoding:NSUTF8StringEncoding error:nil];
    return fileContents ;
}
@end
