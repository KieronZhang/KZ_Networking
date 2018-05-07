//
//  CollectionViewCell.h
//  KZ_Networking_iOS
//
//  Created by Kieron Zhang on 2018/5/7.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iOS_User;

@interface CollectionViewCell : UICollectionViewCell {
    UILabel *usernameLabel;
}
@property (nonatomic, strong) iOS_User *user;

@end
