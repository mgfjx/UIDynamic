//
//  DynamicListViewController.m
//  UIDynamic
//
//  Created by 谢小龙 on 16/5/19.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "DynamicListViewController.h"
#import "GravityViewController.h"

@interface DynamicListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation DynamicListViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    self.table = table;
    [self.view addSubview:table];
    
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSInteger indexRow = indexPath.row;
    NSString *title = nil;
    if (indexRow == 0) {
        title = @"重力";
    }else if(indexRow == 1){
        title = @"推力";
    }else if (indexRow == 2){
        title = @"吸附";
    }else if (indexRow == 3){
        title = @"碰撞";
    }
    
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger indexRow = indexPath.row;
    
    if (indexRow == 0) {
        GravityViewController *vc = [[GravityViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

-(void)viewDidLayoutSubviews {
    
    if ([self.table respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.table setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.table respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.table setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end



















