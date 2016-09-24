//
//  HMHeaerView.m
//  03-QQ好友列表
//
//  Created by  on 16/2/17.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMHeaderView.h"
#import "HMFriendGroup.h"

@interface HMHeaderView ()
@property (nonatomic, weak) UIButton *headerBtn;
@property (nonatomic, weak) UILabel *onlineLabel;

@end
@implementation HMHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    // 1.先定义一个重用标识
    static NSString *ID = @"group";
    // 2.先去缓存池中找可重用得headerView
    HMHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    // 3.如果缓存池中没有可重用headerView,创建一个新的,并设置重用标识
    if (headerView == nil) {
        headerView = [[HMHeaderView alloc] initWithReuseIdentifier:ID];
        
    }
    return headerView;

}
/** 当一个控件不显示的时候有那些原因
 1.控件没有被添加到父控件
 2.没有设置frame"frame设置的不对"
 3.被其它控件遮住了
 4.透明度 <= 0.01
 5.hiden属性为YES
 6.控件的颜色和父控件的相同
 7.还有父控件的以上所有问题
 */
// 重写haerView初始化方法,在此方法中添加所有子控件/**切记不要在init方法中设置控件的frame
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.显示组的按钮
        UIButton *headerBtn = [[UIButton alloc] init];
        // 设置按钮的背景图片
        [headerBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [headerBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        // 设置按钮中的文字颜色
        [headerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮的小图片
        [headerBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        // 设置按钮中的内容左对齐
        headerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置按钮内容的内边距
        headerBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        // 设置按钮中的文字的内边距
//        headerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        // 设置按钮中的小图片的内边距
        headerBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        // 给按钮添加监听事件
        [headerBtn addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        // 设置按钮中的小图片添充模式
        headerBtn.imageView.contentMode = UIViewContentModeCenter;
        // 设置超出边界部分的图片不裁剪
        headerBtn.imageView.clipsToBounds = NO;
        
        [self.contentView addSubview:headerBtn];
        self.headerBtn = headerBtn;
        
        // 2.显示好友数的标签
        UILabel *onlineLabel = [[UILabel alloc] init];
//        onlineLabel.backgroundColor = [UIColor redColor];
        // 设置文字右对齐
        onlineLabel.textAlignment = NSTextAlignmentRight;
        onlineLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:onlineLabel];
        self.onlineLabel = onlineLabel;
        

    }
    return self;
}

// 按钮的点击方法
- (void)headerBtnClick:(UIButton *)headerBtn {
    // 用来设置当前组是否展开,对上次的值做取反操作
    self.group.open = !self.group.isOpen;
    

    
    // 如果协议方法是必须使用的,就不要再加判断了
//    [self.delegate headerViewDidReloadData:self];
    
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:self userInfo:nil];


}






// 用来调整子控件的frame
/**
 1.当前控件"layoutSubviews方法所在的类",被添加到他的父控件中之后,即将要显示了
 2.当headerView的frame"尺寸bounds"发生变化之后,还会调用此方法来重新调用子控件的frame
 3.当屏幕发生旋转的时候,也会来调用此方法
 
 不会调用:
 1.当headerView在init,刚创建出来的时候是不会调用此方法
 2.当headerView的子控件的frame发生变化之后也不会来调用此方法
 */
- (void)layoutSubviews {
#warning mark - 重写此方法时一定要注意调用super的方法
    [super layoutSubviews];
//    NSLog(@"%@", NSStringFromCGSize(self.contentView.bounds.size));
    // 设置按钮的frame
    self.headerBtn.frame = self.bounds;
    // 计算及设置label的frame
    CGFloat onlineW = 100;
    CGFloat onlineH = self.bounds.size.height;
    CGFloat onlineX = self.bounds.size.width - onlineW - 10;
    CGFloat onlineY = 0;
    self.onlineLabel.frame = CGRectMake(onlineX, onlineY, onlineW, onlineH);
    
}

// 重写组模型属性的set方法,在此方法中给子控件设置数据
- (void)setGroup:(HMFriendGroup *)group {
    _group = group;
    
    // 1.设置组的标题
    [self.headerBtn setTitle:group.name forState:UIControlStateNormal];
    // 2.设置在线数
    self.onlineLabel.text = [NSString stringWithFormat:@"%@ / %zd", group.online, group.friends.count];
    
    
    if (self.group.isOpen == YES) { // 展开了
        
        // 让图片向右转90度
        self.headerBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        // 让图片再回到初始状态
        self.headerBtn.imageView.transform = CGAffineTransformIdentity;
    }
}

@end
