//
//  CollectionViewCell.m
//  KZ_Networking_iOS
//
//  Created by Kieron Zhang on 2018/5/7.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import "CollectionViewCell.h"
#import "iOS_User.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        usernameLabel = [[UILabel alloc] initWithFrame:self.bounds];
        usernameLabel.textAlignment = NSTextAlignmentCenter;
        usernameLabel.numberOfLines = 0;
        [self.contentView addSubview:usernameLabel];
    }
    return self;
}

- (void)setUser:(iOS_User *)user {
    _user = user;
    usernameLabel.text = user.username;
}

@end
