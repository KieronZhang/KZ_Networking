//
//  ViewController.h
//  KZ_Networking_macOS
//
//  Created by Kieron Zhang on 2018/5/3.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
    NSTableView *mainTableView;
    NSArray *itemArray;
    NSMutableArray *dataArray;
}

@end
