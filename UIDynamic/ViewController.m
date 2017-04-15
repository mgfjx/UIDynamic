//
//  ViewController.m
//  UIDynamic
//
//  Created by 谢小龙 on 16/5/18.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "ViewController.h"
#import "NewtonsCradleViewController.h"
#import "BoxViewController.h"
#import "CoreMotionViewController.h"
#import "DynamicListViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
        title = @"箱子拖拽";
    }else if(indexRow == 1){
        title = @"牛顿摆";
    }else if (indexRow == 2){
        title = @"陀螺仪";
    }else if (indexRow == 3){
        title = @"现实动力系统模拟";
    }
    
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger indexRow = indexPath.row;
    
    if (indexRow == 0) {
        BoxViewController *vc = [[BoxViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexRow == 1){
        NewtonsCradleViewController *vc = [[NewtonsCradleViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexRow == 2){
        CoreMotionViewController *vc = [[CoreMotionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexRow == 3){
        DynamicListViewController *vc = [[DynamicListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end


























