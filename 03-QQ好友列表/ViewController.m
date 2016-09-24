//
//  ViewController.m
//  03-QQ好友列表
//
//  Created by  on 16/2/17.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "HMFriend.h"
#import "HMFriendGroup.h"
#import "HMHeaderView.h"
#import "HMFriendCell.h"

@interface ViewController ()<HMHeaderViewDelegate>
// 用来存放所有好友组模型
@property (nonatomic, strong) NSArray *friendGroups;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.rowHeight;
    // 设置每组的高度"高度是统一得"
    self.tableView.sectionHeaderHeight = 44;
    
    
    // 给tableView设置一个最尾部的视图,可以让最后面没有数据的cell,不显示分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headerViewDidReloadData:) name:@"ReloadData" object:nil];
}
// 当每一组的头部视图高度不一样时可以用此代理方法来设置高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//}
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.friendGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 取出组模型
    HMFriendGroup *group = self.friendGroups[section];
    // 每一组有多少行取决于每一组有多少个好友
    return (group.isOpen == YES) ? group.friends.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 1.创建cell
    HMFriendCell *cell = [HMFriendCell cellWithTableView:tableView];
    // 2.设置数据
    // 取出组模型
    HMFriendGroup *group = self.friendGroups[indexPath.section];
    cell.friendData = group.friends[indexPath.row];
    // 3.返回cell
    return cell;
}


// 只要用新的头部视图进入我们视野都会来调用
// 此方法可以返回每一组的头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // 1.创建headerView
    HMHeaderView *headerView = [HMHeaderView headerViewWithTableView:tableView];
    // 2.设置数据
    headerView.group = self.friendGroups[section];
    // 给headerView设置代理
//    headerView.delegate = self;
    
    // 把组号设置组对应组的headerView的tag
    headerView.tag = section;

    // 3.返回headerView
    return headerView;
    
}

// headerView的代理方法
- (void)headerViewDidReloadData:(NSNotification *)note {
    // 刷新表格,让数据源方法重新执行一次
//    [self.tableView reloadData];
    // 取出通知的发布者
   HMHeaderView *headerView = note.object;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:headerView.tag];
    // 刷新指定组
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}



#pragma mark - 懒加载
- (NSArray *)friendGroups {
    if (_friendGroups == nil) {
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil]];
        NSMutableArray *groupArrM = [NSMutableArray arrayWithCapacity:dictArr.count];
        for (NSDictionary *groupDict in dictArr) {
            HMFriendGroup *group = [HMFriendGroup groupWithDict:groupDict];
            [groupArrM addObject:group];
        }
        _friendGroups = groupArrM;
    }
    return _friendGroups;
}

@end
