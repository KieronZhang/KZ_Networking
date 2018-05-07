//
//  ViewController.m
//  KZ_Networking_iOS
//
//  Created by Kieron Zhang on 2018/5/3.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"刷新样式";
    
    itemArray = @[@"不取缓存", @"总是获取缓存", @"请求失败取缓存", @"缓存不过期取缓存", @"请求失败或者缓存不过期取缓存", @"批量请求"];
    
    mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    mainTableView.backgroundColor = [UIColor clearColor];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    [self.view addSubview:mainTableView];
    mainTableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *NameCell = @"NameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NameCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NameCell];
    }
    cell.textLabel.text = itemArray[indexPath.row];
    if (indexPath.row <= 4) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"example%d", (int)indexPath.row];
    }
    else if (indexPath.row == 5) {
        cell.detailTextLabel.text = @"CollectionViewController";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row <= 4) {
        TableViewController *tableViewController = [[TableViewController alloc] init];
        tableViewController.method = NSSelectorFromString([NSString stringWithFormat:@"example%d", (int)indexPath.row]);
        tableViewController.titleString = itemArray[indexPath.row];
        [self.navigationController pushViewController:tableViewController animated:YES];
    }
    else if (indexPath.row == 5) {
        CollectionViewController *collectionViewController = [[CollectionViewController alloc] init];
        [self.navigationController pushViewController:collectionViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
