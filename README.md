# UISearchBarControllerTest

>About Me &gt; [雷凯](http://www.likegoto.com/about-me/)

---
> 这是一个`UISearchBarController`的简单使用案例，是`iOS8`之后`Apple`新推出的搜索控件，相比较`UISearchBar`而言，使用起来更加简单。

---
> 一、 首先，本Demo分为两个小模块，为了更加方便展示，写在了一个控制器中。

1、本页面的数据模块

```
数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

数据源的表格
@property (nonatomic, strong) UITableView *tableView;
```
---
	
2、搜索页面模块

```
搜索结果的数组
@property (nonatomic, strong) NSMutableArray *searchArray;

搜索视图
@property (nonatomic, strong) UISearchController *searchController;

搜索结果的表格视图
@property (nonatomic, strong) UITableViewController *searchTVC;
```

---

>二、需要遵循`UISearchResultsUpdating`协议,方法实现如下

* 在点击搜索时会调用一次，点击取消按钮又调用一次

```
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController;

```

 * 让取消按钮提前显示出来，并修改默认取消按钮（建议写在代理方法中)
 
 ```   
[_searchController.searchBar setShowsCancelButton:YES animated:NO];
    [_searchController.searchBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:NSClassFromString(@"UIButton")]) {
                
                
                UIButton *button = obj;
                [button setTitle:@"取消" forState:UIControlStateNormal];
                
            }
            
        }];
        
    }];
```
* 判断当前搜索是否在搜索状态还是取消状态

```
    if (searchController.isActive) {

    在此处给self.searchArray赋值
        
    刷新搜索界面的tableview
    [self.searchTVC.tableView reloadData];
        
    }
 ```   
    

