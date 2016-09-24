//
//  HMFriendCell.h
//  03-QQ好友列表
//
//  Created by  on 16/2/17.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMFriend;
@interface HMFriendCell : UITableViewCell
// 好友模型
@property (nonatomic, strong) HMFriend *friendData;

// 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
