//
//  CollectionViewController.m
//  KZ_Networking_iOS
//
//  Created by Kieron Zhang on 2018/5/7.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "iOS_User.h"
#import <KZ_RefreshScrollView_iOS/UIScrollView+KZ_Refresh.h>
#import <KZ_Networking_iOS/KZ_Networking.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wimplicit-retain-self"

@interface CollectionViewController ()

@property (nonatomic, assign) int pageIndex;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CollectionView刷新";
    itemArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flow];
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    [self.view addSubview:mainCollectionView];
    [mainCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    __weak __typeof(self) weakSelf = self;
    [mainCollectionView addRefreshViewWithRefreshingCompletionBlock:^{
        [weakSelf refresh];
    }];
    [mainCollectionView addLoadMoreViewWithLoadingMoreCompletionBlock:^{
        [weakSelf loadMore];
    }];
    
    [mainCollectionView beginRefresh];
}

- (void)rightButton {
    [mainCollectionView beginRefresh];
}

- (void)refresh {
    self.pageIndex = 1;
    [self getData];
}

- (void)loadMore {
    [self getData];
}

- (void)getData {
    KZ_RequestModel *requestModel1 = [[KZ_RequestModel alloc] init];
    requestModel1.method = KZ_RequestMethod_GET;
    requestModel1.URLString = @"users/query.json";
    requestModel1.parameters = @{@"page" : @(self.pageIndex), @"key" : @"cXj2Xn36iuwSUKNAQARnlhnq8cN0RsTN"};
    requestModel1.cachePolicy = KZ_PolicyStyle_DoNotReadFromCache;
    requestModel1.policyTimeExpried = 60;
    requestModel1.timeoutInterval = 10;
    
    KZ_RequestModel *requestModel2 = [[KZ_RequestModel alloc] init];
    requestModel2.method = KZ_RequestMethod_GET;
    requestModel2.URLString = @"users/query.json";
    requestModel2.parameters = @{@"page" : @(self.pageIndex), @"key" : @"cXj2Xn36iuwSUKNAQARnlhnq8cN0RsTN"};
    requestModel2.cachePolicy = KZ_PolicyStyle_DoNotReadFromCache;
    requestModel2.policyTimeExpried = 60;
    requestModel2.timeoutInterval = 10;
    
    [KZ_NetworkingRequest addHTTPRequestWithRequestModel:requestModel1];
    [KZ_NetworkingRequest addHTTPRequestWithRequestModel:requestModel2];
    
    [KZ_NetworkingRequest startLoadRequestsWithResult:^(NSArray *resultArray) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        for (id result in resultArray) {
            [array addObjectsFromArray:[KZ_ModelArray JSONWithClass:[iOS_User class] json:result[@"response"][@"users"]]];
        }
        if (self.pageIndex == 0) {
            [itemArray removeAllObjects];
        }
        [itemArray addObjectsFromArray:array];
        [mainCollectionView reloadData];
        [mainCollectionView allLoadCompletion];
        self.pageIndex ++;
        if (self.pageIndex > 3) {
            [mainCollectionView noMoreToLoad];
        }
    }];
}

#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.user = itemArray[indexPath.item];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}

#pragma clang diagnostic pop

@end
