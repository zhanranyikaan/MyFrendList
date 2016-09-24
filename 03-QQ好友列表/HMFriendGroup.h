//
//  HMFriendGroup.h
//  03-QQ好友列表
//
//  Created by  on 16/2/17.
//  Copyright © 2016年 itheima. All rights reserved.
// 好友组的模型

#import <Foundation/Foundation.h>

@interface HMFriendGroup : NSObject
// 组的名称
@property (nonatomic, copy) NSString *name;
// 当前组中所有的好友
@property (nonatomic, strong) NSArray *friends;
// 在线人数
@property (nonatomic, strong) NSNumber *online;
// 标识当前组是否展开
@property (nonatomic, assign, getter=isOpen) BOOL open;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;
@end
