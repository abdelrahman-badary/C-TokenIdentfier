//
//  ViewController.h
//  Parser
//
//  Created by Abd al rhman Taher on 10/22/15.
//  Copyright © 2015 Abd al rhman Taher. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTableViewDataSource , NSStackViewDelegate>

@property (strong) IBOutlet NSTableView *keywordTable;
@property (strong) IBOutlet NSTableView *operatorsTableView;
@property (strong) IBOutlet NSTableView *specialSymbolsTable;
@property (strong) IBOutlet NSTableView *identfiresTable;
@property (strong) IBOutlet NSTableView *intliteralsTable;
@property (strong) IBOutlet NSTableView *stringLiterals;

@end

