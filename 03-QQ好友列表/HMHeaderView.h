//
//  HMHeaerView.h
//  03-QQ好友列表
//
//  Created by  on 16/2/17.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMFriendGroup, HMHeaderView;

@protocol HMHeaderViewDelegate <NSObject>

@required // 必须使用的方法
- (void)headerViewDidReloadData:(HMHeaderView *)headerView;

@end
@interface HMHeaderView : UITableViewHeaderFooterView
// 组模型
@property (nonatomic, strong) HMFriendGroup *group;

// 定义一个代理属性
@property (nonatomic, weak) id<HMHeaderViewDelegate> delegate;

// 创建headerView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
