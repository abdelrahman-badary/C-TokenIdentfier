//
//  TokenIdentifier.m
//  Parser
//
//  Created by Abd al rhman Taher on 10/22/15.
//  Copyright © 2015 Abd al rhman Taher. All rights reserved.
//

#import "TokenIdentifier.h"

@implementation TokenIdentifier
{
    NSArray * Keywords ;
    NSArray * Operators ;
    NSArray * SpecialSymbols ;
    NSMutableArray * keywords ;
    NSMutableArray * operators ;
    NSMutableArray * specialSymbols ;
    NSMutableArray * others ;
    NSMutableArray * identfires ;
    NSMutableArray * stringLiterals ;
    NSMutableArray * intLiterals ;
    NSMutableArray * comments ;
    

}
-(id)initWithContentsOfFile:(NSArray *)fileContents
{
    self = [super init] ;
    if(self)
    {
        _contentsOfFile = fileContents ;
        
        Keywords = @[@"int",@"bool" , @"string" , @"void" , @"true" , @"false" , @"if" , @"else" , @"while" , @"when" , @"return"] ;
        
        Operators = @[@"+" , @"-" , @"*" , @"/" , @"<" , @"<=" , @">" , @">=" , @"==" , @"!=" , @"=-" , @"!"] ;
        
        SpecialSymbols = @[@";" , @"," , @"(" , @")" , @"[" ,@"]" ,@"{" , @"}" , @"//"] ;
        
        keywords = [NSMutableArray new] ;
        
        operators = [NSMutableArray new] ;
        
        specialSymbols = [NSMutableArray new] ;
        
        others = [NSMutableArray new] ;
        
        identfires = [NSMutableArray new] ;
        
        stringLiterals = [NSMutableArray new] ;
        
        intLiterals = [NSMutableArray new] ;
        
        
        
    }
    return self ;
}
-(NSArray *)identify
{

    NSMutableArray * identfiers = [NSMutableArray new] ;
    for(int i = 0 ; i<_contentsOfFile.count ; i++)
    {
        NSString * unModifiedLine = _contentsOfFile[i] ;
        if([self isComment:unModifiedLine])
        {
            [specialSymbols addObject:@"//"];

            continue ;
        }
        NSString * modifiedLine = [self Split:_contentsOfFile[i]] ;
        NSArray * tokens = [self sperateTokensIn:modifiedLine] ;
        for(int x =0 ; x<tokens.count ;x++)
        {
            NSString * tokenType = [self identfie:tokens[x]] ;
            [identfiers addObject:[NSString stringWithFormat:@"%@ : %@" , tokens[x] , tokenType]] ;
        }
        
    }
    NSSet * noDubSet = [NSSet setWithArray:others] ;
    others = [[noDubSet allObjects] mutableCopy] ;
    
    noDubSet = [NSSet setWithArray:keywords] ;
    keywords = [[noDubSet allObjects] mutableCopy] ;
    
    
    noDubSet = [NSSet setWithArray:specialSymbols] ;
    specialSymbols = [[noDubSet allObjects] mutableCopy] ;
    
    
    noDubSet = [NSSet setWithArray:operators] ;
    operators = [[noDubSet allObjects] mutableCopy] ;
    

    

    [self defineOtherTokens] ;

    
    return identfiers ;
}
-(void)defineOtherTokens
{
    for(int i = 0 ; i<others.count ; i++)
    {
        NSString * firstChar = [others[i] substringWithRange:NSMakeRange(0, 1)];
        
        NSCharacterSet * alphaSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ"] ;
        
        NSCharacterSet * numericSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"] ;
        
        if([firstChar rangeOfCharacterFromSet:alphaSet].location != NSNotFound)
        {
            [identfires addObject:others[i]] ;
        }
        else if([firstChar rangeOfCharacterFromSet:numericSet].location != NSNotFound)
        {
            [intLiterals addObject:others[i]] ;
        }
        else if ([firstChar isEqualToString:@"\""])
        {
            [stringLiterals addObject:others[i]] ;
        }
        

    
    }

}
-(NSString *)identfie:(NSString *)token
{
    if([Operators containsObject:token])
    {
        [operators addObject:token] ;
        return @"Operator" ;
    }
    else if ([SpecialSymbols containsObject:token])
    {
        [specialSymbols addObject:token] ;
        return @"Special symbol" ;
    }
    else if([Keywords containsObject:token])
    {
        [keywords addObject:token] ;

        return @"Keyword" ;
    }
    else
    {
        [others addObject:token] ;
        return @"Other" ;
        
    }


}
-(NSString *)Split:(NSString *)line
{
    NSString * finalString ;
    for(int i = 0 ; i<line.length ; i++)
    {
        NSString * newString = [line substringWithRange:NSMakeRange(i, 1)];
        NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789 _\""] invertedSet];
        
        if ([newString rangeOfCharacterFromSet:set].location != NSNotFound)
        {
            BOOL continue_ = true ;

            NSCharacterSet * symbols = [[NSCharacterSet characterSetWithCharactersInString:@"+-<>=!/*"] invertedSet] ;
            
            if([newString rangeOfCharacterFromSet:symbols].location == NSNotFound)
            {
                NSString * nextChar = [line substringWithRange:NSMakeRange(i+1, 1)];
                if([nextChar rangeOfCharacterFromSet:symbols].location == NSNotFound)
                {
                    i=i+2 ;
                    continue_= false ;
                }
                
            }
 
            if(continue_)
            {
                newString = [NSString stringWithFormat:@" %@ " , newString] ;
                
                NSRange  replaceRange = NSMakeRange(i, 1) ;
                
                line = [line stringByReplacingCharactersInRange:replaceRange withString:newString] ;
                
                i++;
            }
        }

        
    }
    finalString = line ; 

    return finalString ;
}
-(NSArray *)sperateTokensIn:(NSString *)line
{
    NSCharacterSet * space = [NSCharacterSet characterSetWithCharactersInString:@" "] ;
   
    NSMutableArray* Tokens =
    
    (NSMutableArray*)[line componentsSeparatedByCharactersInSet:space];
    
    [Tokens removeObject:@""] ;
    
    return Tokens ;
}
-(BOOL)isComment:(NSString *)line
{
    if([line rangeOfString:@"//"].location == NSNotFound)
    {
        return false ;
    }
    else
    {
        return  true ;
    }
}
-(NSArray *)keywords
{
    return keywords ;
}
-(NSArray *)operators
{
    return operators ;
}
-(NSArray *)specialSymbols
{
    return specialSymbols ;
}
-(NSArray *)identfires
{
    return identfires ;
}
-(NSArray *)stringLiterals
{
    return stringLiterals ;
}
-(NSArray *)intLiterals
{
   return intLiterals ;
}



@end
