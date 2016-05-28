//
//  ViewController.m
//  UISearchBarControllerTest
//
//  Created by 雷凯 on 16/5/27.
//  Copyright © 2016年 likegoto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>
/// 数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
/// 数据源的表格
@property (nonatomic, strong) UITableView *tableView;

/// ---------------------------------------------------------

/// 搜索结果的数组
@property (nonatomic, strong) NSMutableArray *searchArray;
/// 搜索视图
@property (nonatomic, strong) UISearchController *searchController;
/// 搜索结果的表格视图
@property (nonatomic, strong) UITableViewController *searchTVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.tableView];
    
    //把搜索栏放到tableview的头视图上
    self.tableView.tableHeaderView = self.searchController.searchBar;
 
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.tableView) {
        
        return self.dataArray.count;
        
    }else {
        
        return self.searchArray.count;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCellID"];
    
    if (!cell) {
        
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dataCellID"];
    }
    
    
    if (tableView == self.tableView) {
        
        cell.textLabel.text = self.dataArray[indexPath.row];
        
    }else {
        
        cell.textLabel.text = self.searchArray[indexPath.row];
    }
    
    
    return cell;
}

#pragma mark - UISearchResultsUpdating
//在点击搜索时会调用一次，点击取消按钮又调用一次
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    // 让取消按钮提前显示出来
    [_searchController.searchBar setShowsCancelButton:YES animated:NO];
    [_searchController.searchBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:NSClassFromString(@"UIButton")]) {
                
                
                UIButton *button = obj;
                [button setTitle:@"取消" forState:UIControlStateNormal];
                
            }
            
        }];
        
    }];

    //判断当前搜索是否在搜索状态还是取消状态
    if (searchController.isActive) {

        
        if (!self.searchArray) {
            
            self.searchArray = [[NSMutableArray alloc]init];
            
        }else {
            
            [self.searchArray removeAllObjects];
            
            for (NSString  *str in self.dataArray) {
                
                NSRange range = [str rangeOfString:searchController.searchBar.text];
                if (range.location != NSNotFound) {
                    [_searchArray addObject:str];
                }
            }
        }
        
        //刷新搜索界面的tableview
        [self.searchTVC.tableView reloadData];
        
    }
    
    
}

#pragma mark - lazy
-(NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        
        
        _dataArray = [[NSMutableArray alloc]init];
        
        for (NSInteger i=0; i<88; i++) {
            
            NSString *str = [NSString stringWithFormat:@"UISearchBarControllerTest%zd",i];
            
            [_dataArray addObject:str];
        }
        
    }
    return _dataArray;
}

-(UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20) style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}

-(UITableViewController *)searchTVC {
    
    if (!_searchTVC) {
        _searchTVC  = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
        _searchTVC.tableView.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20);
        _searchTVC.tableView.dataSource = self;
        _searchTVC.tableView.delegate = self;
        
    }
    return _searchTVC;
}

-(UISearchController *)searchController {
    
    if (!_searchController) {
        
        /// 创建搜索界面,把表格视图控制器跟搜索界面相关联
        _searchController = [[UISearchController alloc]initWithSearchResultsController:self.searchTVC];
        
        //去掉搜索框边框
        //        [_searchController.searchBar setBackgroundImage:[UIImage new]];
        
        [_searchController.searchBar setPlaceholder:@"搜索"];
        
        //搜索结果不变灰
        //        _searchController.dimsBackgroundDuringPresentation = NO;
        
        
        /// 设置搜索框大小
        _searchController.searchBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);

        
        
        //设置搜索的代理
        _searchController.searchResultsUpdater = self;
        
        
        
        
        
    }
    return _searchController;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
