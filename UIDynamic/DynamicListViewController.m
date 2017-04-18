//
//  DynamicListViewController.m
//  UIDynamic
//
//  Created by 谢小龙 on 16/5/19.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "DynamicListViewController.h"
#import "GravityViewController.h"

@interface DynamicListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSDictionary *titleAndController;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation DynamicListViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    titleAndController = @{@"重力":@"GravityViewController",
                           @"推力":@"PushAnimatorController",
                           @"吸附":@"AttachmentBehaviorController",
                           @"捕捉":@"SnapViewController",
                           @"FieldBehavior":@"FieldBehaviorController",
                           };
    
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
    return titleAndController.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSInteger indexRow = indexPath.row;
    NSString *title = titleAndController.allKeys[indexRow];
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger indexRow = indexPath.row;
    NSString *vcName = titleAndController.allValues[indexRow];
    [self pushViewController:vcName];
}

- (void)pushViewController:(NSString *)controllerName{
    UIViewController *vc = [[NSClassFromString(controllerName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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



















