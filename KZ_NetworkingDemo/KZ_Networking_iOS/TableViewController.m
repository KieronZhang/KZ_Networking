//
//  TableViewController.m
//  KZ_Networking_iOS
//
//  Created by Kieron Zhang on 2018/5/7.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iOS_User.h"
#import <KZ_RefreshScrollView_iOS/UIScrollView+KZ_Refresh.h>
#import <KZ_Networking_iOS/KZ_Networking.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wimplicit-retain-self"

@interface TableViewController ()

@property (nonatomic, assign) int pageIndex;
@property (nonatomic, assign) KZ_PolicyStyle style;
@property (nonatomic, assign) NSTimeInterval expried;

@end

#define KZ_PerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleString;
    itemArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonTapped)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTapped)];
    self.navigationItem.rightBarButtonItems = @[refreshButton, addButton];
    
    mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    [self.view addSubview:mainTableView];
    
    if (NSStringFromSelector(self.method).length > 0) {
        KZ_PerformSelectorLeakWarning([self performSelector:self.method withObject:nil];);
    }
    
    [mainTableView beginRefresh];
}

- (void)refreshButtonTapped {
    [mainTableView beginRefresh];
}

- (void)addButtonTapped {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加用户" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入用户名";
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertController.textFields[0];
        if (textField.text.length == 0) {
            return;
        }
        [self createUserWithUsername:textField.text];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)createUserWithUsername:(NSString *)username {
    KZ_RequestModel *requestModel = [[KZ_RequestModel alloc] init];
    requestModel.method = KZ_RequestMethod_POST;
    requestModel.URLString = @"users/create.json";
    requestModel.parameters = @{@"username" : username, @"password" : @"111111", @"password_confirmation" : @"111111", @"key" : @"cXj2Xn36iuwSUKNAQARnlhnq8cN0RsTN"};
    requestModel.cachePolicy = KZ_PolicyStyle_DoNotReadFromCache;
    requestModel.policyTimeExpried = 60;
    requestModel.timeoutInterval = 10;
    [KZ_NetworkingRequest HTTPRequestWithRequestModel:requestModel progress:nil success:^(id responseObject) {
        [self getUserData];
    } failure:nil];
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
        NSArray *array = [KZ_ModelArray JSONWithClass:[iOS_User class] json:responseObject[@"response"][@"users"]];
        if (self.pageIndex == 1) {
            [itemArray removeAllObjects];
        }
        [itemArray addObjectsFromArray:array];
        [mainTableView reloadData];
        [mainTableView allLoadCompletion];
        if (self.pageIndex > 3) {
            [mainTableView noMoreToLoad];
        }
    } failure:^(NSError *error) {
        [mainTableView allLoadCompletion];
    }];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *NameCell = @"TableViewCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NameCell];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NameCell];
    }
    cell.user = itemArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark exampleMethods
- (void)example0 {
    self.style = KZ_PolicyStyle_DoNotReadFromCache;
    self.expried = 0;
    [self addRefreshAndLoadMore];
}

- (void)example1 {
    self.style = KZ_PolicyStyle_AlwaysReadFromCache;
    self.expried = 0;
    [self addRefreshAndLoadMore];
}

- (void)example2 {
    self.style = KZ_PolicyStyle_OnlyReadFromCacheWhenRequestFailed;
    self.expried = 600;
    [self addRefreshAndLoadMore];
}

- (void)example3 {
    self.style = KZ_PolicyStyle_OnlyReadFromCacheWhenTimeExpired;
    self.expried = 600;
    [self addRefreshAndLoadMore];
}

- (void)example4 {
    self.style = KZ_PolicyStyle_ReadFromCacheWhenTimeExpiredOrRequestFailed;
    self.expried = 0;
    [self addRefreshAndLoadMore];
}

- (void)addRefreshAndLoadMore {
    __weak __typeof(self) weakSelf = self;
    [mainTableView addRefreshViewWithScrollType:KZ_ComponentScrollType_AlwaysFixed viewBlock:nil refreshingCompletionBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf getUserData];
    }];
    [mainTableView addLoadMoreViewWithScrollType:KZ_ComponentScrollType_AlwaysFixed viewBlock:nil loadingMoreCompletionBlock:^{
        weakSelf.pageIndex ++;
        [weakSelf getUserData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

#pragma clang diagnostic pop

@end
