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
    fileContents =  [self ignoreComments:fileContents] ;
    fileContents =
    [[fileContents componentsSeparatedByCharactersInSet:newLines]
     componentsJoinedByString:@""];
    
    NSMutableArray* singleLines =
    [[fileContents componentsSeparatedByCharactersInSet:delimeters] mutableCopy];
    for(int i = 0 ; i<singleLines.count ; i++)
        if([singleLines[i]isEqualToString:@""])
        {
            [singleLines removeObject:singleLines[i]];
            i-- ;
        }
            
    
    return singleLines ;
    
}
-(NSString *)ignoreComments:(NSString *)fileContents
{
    NSString * marks = @"//" ;
    int countOfAddedChars = 0 ;
    NSArray * marksRangeArr = [self rangesOfString:marks inString:fileContents] ;
    if(marksRangeArr.count != 0)
    {
        for(int i = 0 ; i < marksRangeArr.count ; i++)
        {
            NSRange  marksRange = [marksRangeArr[i] rangeValue] ;
            if(countOfAddedChars != 0)
            {
                marksRange = NSMakeRange(marksRange.location+countOfAddedChars, marksRange.length);
            }
            NSString * nextChar = @"" ;
            int indexOfMarks =(int) (marksRange.location + marksRange.length) ;
            NSString * previousChar = [fileContents substringWithRange:NSMakeRange(marksRange.location-1, 1)];
            if(![previousChar isEqualToString:@";"])
            {
                fileContents = [fileContents stringByReplacingCharactersInRange:NSMakeRange(marksRange.location-1, 1) withString:[NSString stringWithFormat:@"%@%@" , previousChar , @";"]] ;
                countOfAddedChars++ ;
            }
            while (true) {
                nextChar = [fileContents substringWithRange:NSMakeRange(indexOfMarks,1)] ;
                if([nextChar isEqualToString:@"\n"])
                {
                    fileContents = [fileContents stringByReplacingCharactersInRange:NSMakeRange(indexOfMarks,1) withString:@";\n"];
                    countOfAddedChars++ ;
                    break ;
                }
                indexOfMarks++;
            }
        
        }
    
    }
    return fileContents ;
}
- (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    NSMutableArray *results = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, [str length]);
    NSRange range;
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        [results addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
    }
    return results;
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
