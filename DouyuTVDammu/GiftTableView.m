//
//  GiftTableView.m
//  DouyuTVDammu
//
//  Created by LuChen on 16/3/20.
//  Copyright © 2016年 Bad Chen. All rights reserved.
//

#import "GiftTableView.h"

@implementation GiftTableView


- (void)receiveNotification:(NSNotification *)notification {
    
    NSString *string = notification.object;
    //判断消息类型
    if ([string rangeOfString:@"type@=mrkl/"].location == NSNotFound) {
        DanmuModel *model = [DanmuModel new];
        if ([string rangeOfString:@"type@=dgb/gfid"].location != NSNotFound){
            model.cellType = CellNewGiftType;
            model.gift = self.giftInfo;
        }else if ([string rangeOfString:@"type@=dgn/gfid"].location != NSNotFound){
            model.cellType = CellGiftType;
            model.gift = self.giftInfo;
        }else if ([string rangeOfString:@"type@=bc_buy_deserve"].location != NSNotFound){
            model.cellType = CellDeserveType;
        }else{
//            NSLog(@"%@",string);
            model = nil;
            return;
        }
        
        [model setModelFromStirng:string];
        
        if (self.data.count > 500) {
            [self.dataCache addObjectsFromArray:self.data];
            [self.data removeAllObjects];
        }
        
        //将model对象加入到信息model数组里面
        [self.data addObject:model];
        if (self.isNotInView == NO) {
            //刷新数据，更新界面
            [self reloadData];
            //将最后一个单元格滚动到表视图的底部显示
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.data.count-1 inSection:0];
            [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        }
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
