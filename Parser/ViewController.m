//
//  ViewController.m
//  Parser
//
//  Created by Abd al rhman Taher on 10/22/15.
//  Copyright © 2015 Abd al rhman Taher. All rights reserved.
//

#import "ViewController.h"
#import "TextParser.h"
#import "TokenIdentifier.h"
@implementation ViewController
{
    NSArray * keywords ;
    NSArray * operators ;
    NSArray * specialSymbols ;
    NSArray * stringLiterals ;
    NSArray * intliterals ;
    NSArray * identfirs ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    TextParser * parser = [[TextParser alloc] initWithFile:@"parse"] ;

    NSArray * arr = [parser parseFile] ;
    
    TokenIdentifier * TI = [[TokenIdentifier alloc] initWithContentsOfFile:arr] ;
    
    [TI identify] ;
    
    keywords = [TI keywords] ;
    operators = [TI operators] ;
    specialSymbols = [TI specialSymbols] ;
    identfirs = [TI identfires] ;
    intliterals = [TI intLiterals] ;
    stringLiterals = [TI stringLiterals] ;

    
    _keywordTable.tag = 10 ;
    _keywordTable.tableColumns[0].title = @"Keywords" ;
    
    _operatorsTableView.tag = 20 ;
    _operatorsTableView.tableColumns[0].title = @"Operators" ;
    
    _specialSymbolsTable.tag = 30 ;
    _specialSymbolsTable.tableColumns[0].title = @"Special symbols" ;
    
    _stringLiterals.tag = 40 ;
    _stringLiterals.tableColumns[0].title = @"string literals" ;
    
    _intliteralsTable.tag = 50 ;
    _intliteralsTable.tableColumns[0].title = @"int literals" ;
    
    _identfiresTable.tag = 60 ;
    _identfiresTable.tableColumns[0].title = @"identfires" ;
    
}
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    //tableColumn.title = @"asf" ;
 
     
    
    
    if(tableView.tag == 10)
    {
        cellView.textField.stringValue = keywords[row] ;
        return cellView ;
    }
    else if (tableView.tag == 20)
    {
        cellView.textField.stringValue = operators[row] ;
        return cellView ;
    }
    else if (tableView.tag == 30)
    {
        cellView.textField.stringValue = specialSymbols[row] ;
        return cellView ;
    }
    else if (tableView.tag == 40)
    {
        cellView.textField.stringValue = stringLiterals[row] ;
        return cellView ;
    }
    else if (tableView.tag == 50)
    {
        cellView.textField.stringValue = intliterals[row] ;
        return cellView ;
    }
    else
    {
        cellView.textField.stringValue = identfirs[row] ;
        return cellView ;
    }
    
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    if(tableView.tag == 10)
        return keywords.count ;
    else if (tableView.tag == 20)
        return operators.count ;
    else if (tableView.tag == 30)
        return specialSymbols.count ;
    else if (tableView.tag == 40)
        return stringLiterals.count ;
    else if (tableView.tag == 50)
        return intliterals.count ;
    else
        return identfirs.count ;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
