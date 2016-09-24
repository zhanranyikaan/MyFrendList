//
//  HMFriend.h
//  03-QQ好友列表
//
//  Created by  on 16/2/17.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMFriend : NSObject
// 头像
@property (nonatomic, copy) NSString *icon;
// 昵称
@property (nonatomic, copy) NSString *name;
// 个性签名
@property (nonatomic, copy) NSString *intro;
// 是不是vip
@property (nonatomic, assign, getter=isVip) BOOL vip;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendWithDict:(NSDictionary *)dict;
@end
