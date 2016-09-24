//
//  HMFriendGroup.m
//  03-QQ好友列表
//
//  Created by  on 16/2/17.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMFriendGroup.h"
#import "HMFriend.h"

@implementation HMFriendGroup
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        // 给模型的所有属性赋值
        [self setValuesForKeysWithDictionary:dict];
        
        // 1.创建一个可变数据用来存放成的的好友模型
        NSMutableArray *friendArrM = [NSMutableArray arrayWithCapacity:self.friends.count];
        for (NSDictionary *friendDict in self.friends) {
            HMFriend *friend = [HMFriend friendWithDict:friendDict];
            // 把好友添加到可变数组中保存起来
            [friendArrM addObject:friend];
        }
        // 把装有当前组所有好友模型的数组赋值组friends字典数组
        self.friends = friendArrM;
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
@end
