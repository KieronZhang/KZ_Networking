//
//  TableViewController.h
//  KZ_Networking_iOS
//
//  Created by Kieron Zhang on 2018/5/7.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *mainTableView;
    NSMutableArray *itemArray;
}
@property (nonatomic, assign) SEL method;
@property (nonatomic, strong) NSString *titleString;

@end
