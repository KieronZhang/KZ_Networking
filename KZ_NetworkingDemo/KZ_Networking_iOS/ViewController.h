//
//  ViewController.h
//  KZ_Networking_iOS
//
//  Created by Kieron Zhang on 2018/5/3.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *mainTableView;
    NSArray *itemArray;
}

@end
