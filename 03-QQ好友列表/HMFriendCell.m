//
//  HMFriendCell.m
//  03-QQ好友列表
//
//  Created by  on 16/2/17.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMFriendCell.h"
#import "HMFriend.h"

@implementation HMFriendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [tableView dequeueReusableCellWithIdentifier:@"friend"];
}

// 重写此方法组cell里面的子控件设置数据
- (void)setFriendData:(HMFriend *)friendData {
    _friendData = friendData;
    
    self.imageView.image = [UIImage imageNamed:friendData.icon];
    self.textLabel.text = friendData.name;
    self.detailTextLabel.text = friendData.intro;
    
    // 设置昵称文字颜色
    self.textLabel.textColor = (friendData.isVip == YES) ? [UIColor redColor] : [UIColor blackColor];
}

@end
