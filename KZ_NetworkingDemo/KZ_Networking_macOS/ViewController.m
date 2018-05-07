//
//  ViewController.m
//  KZ_Networking_macOS
//
//  Created by Kieron Zhang on 2018/5/3.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import "ViewController.h"
#import "macOS_User.h"
#import <KZ_Networking_macOS/KZ_Networking.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wimplicit-retain-self"

@interface ViewController ()

@property (nonatomic, assign) int pageIndex;
@property (nonatomic, assign) KZ_PolicyStyle style;
@property (nonatomic, assign) NSTimeInterval expried;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIndex = 1;
    
    itemArray = @[@"不取缓存", @"总是获取缓存", @"请求失败取缓存", @"缓存不过期取缓存", @"请求失败或者缓存不过期取缓存"];
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSScrollView *tableContainer = [[NSScrollView alloc] initWithFrame:self.view.bounds];
    mainTableView = [[NSTableView alloc] initWithFrame:self.view.bounds];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    
    NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"TableColumn"];
    column.width = CGRectGetWidth(tableContainer.frame) / 2;
    column.minWidth = CGRectGetWidth(tableContainer.frame) / 2;
    column.maxWidth = CGRectGetWidth(tableContainer.frame) / 2;
    column.title = @"缓存方式";
    [mainTableView addTableColumn:column];
    
    NSTableColumn *column2 = [[NSTableColumn alloc] initWithIdentifier:@"TableColumn2"];
    column2.width = CGRectGetWidth(tableContainer.frame) / 2;
    column2.minWidth = CGRectGetWidth(tableContainer.frame) / 2;
    column2.maxWidth = CGRectGetWidth(tableContainer.frame) / 2;
    column2.title = @"数据";
    [mainTableView addTableColumn:column2];
    
    tableContainer.documentView = mainTableView;
    tableContainer.hasVerticalScroller = YES;
    [self.view addSubview:tableContainer];
}

- (void)getUserData {
    KZ_RequestModel *requestModel = [[KZ_RequestModel alloc] init];
    requestModel.method = KZ_RequestMethod_GET;
    requestModel.URLString = @"users/query.json";
    requestModel.parameters = @{@"page" : @(self.pageIndex), @"key" : @"cXj2Xn36iuwSUKNAQARnlhnq8cN0RsTN"};
    requestModel.cachePolicy = self.style;
    requestModel.policyTimeExpried = self.expried;
    requestModel.timeoutInterval = 10;
    [KZ_NetworkingRequest HTTPRequestWithRequestModel:requestModel progress:nil success:^(id responseObject) {
        NSArray *array = [KZ_ModelArray JSONWithClass:[macOS_User class] json:responseObject[@"response"][@"users"]];
        if (self.pageIndex == 1) {
            [dataArray removeAllObjects];
        }
        [dataArray addObjectsFromArray:array];
        [mainTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark NSTableViewDelegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return MAX(itemArray.count, dataArray.count);
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return NO;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if ([tableColumn.identifier isEqualToString:@"TableColumn"] && row < itemArray.count) {
        return itemArray[row];
    }
    if ([tableColumn.identifier isEqualToString:@"TableColumn2"] && row < dataArray.count) {
        macOS_User *user = dataArray[row];
        return user.username;
    }
    return nil;
}

- (BOOL)tableView:(NSTableView *)tableView shouldTrackCell:(NSCell *)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    self.style = row;
    self.expried = 60;
    [self getUserData];
    return YES;
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    return YES;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

#pragma clang diagnostic pop

@end
