//
//  ViewController.m
//  QuecNetworkChannelKitExample
//
//  Created by quectel.steven on 2021/8/17.
//

#import "ViewController.h"
#import <QuecNetworkChannelKit/QuecNetworkChannelKit.h>
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIStackView *view = [[UIStackView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 150)];
    view.axis = UILayoutConstraintAxisVertical;
    view.spacing = 20;
    [self.view addSubview:view];
    
    UIButton *getButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getButton.frame = CGRectMake(10, 0, self.view.frame.size.width - 20, 50);
    getButton.layer.cornerRadius = 10.0;
    getButton.layer.borderColor = [UIColor orangeColor].CGColor;
    getButton.layer.borderWidth = 1.0;
    [getButton addTarget:self action:@selector(getButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [getButton setTitle:@"GET" forState:UIControlStateNormal];
    [getButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [view addArrangedSubview:getButton];
    
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    postButton.frame = CGRectMake(10, 0, self.view.frame.size.width - 20, 50);
    postButton.layer.cornerRadius = 10.0;
    postButton.layer.borderColor = [UIColor orangeColor].CGColor;
    postButton.layer.borderWidth = 1.0;
    [postButton addTarget:self action:@selector(postButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [postButton setTitle:@"POST" forState:UIControlStateNormal];
    [postButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [view addArrangedSubview:postButton];
    
    
    UIButton *downLoadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    downLoadButton.frame = CGRectMake(10, 0, self.view.frame.size.width - 20, 50);
    downLoadButton.layer.cornerRadius = 10.0;
    downLoadButton.layer.borderColor = [UIColor orangeColor].CGColor;
    downLoadButton.layer.borderWidth = 1.0;
    [downLoadButton addTarget:self action:@selector(downLoadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [downLoadButton setTitle:@"DownLoad" forState:UIControlStateNormal];
    [downLoadButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [view addArrangedSubview:downLoadButton];
    
    [self setupTableView];
    
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.frame = CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 200);
    [self.view addSubview:self.iconImageView];
    
    
}

- (void)setupTableView {
    self.dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 510, self.view.frame.size.width, 300) style:UITableViewStylePlain];
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.view addSubview:self.dataTableView];
}

- (void)getButtonClick {
    [[QuecNetworkManager shared] requestWithUrlString:@"https://api.66mz8.com/api/weather.php" params:@{@"location":@"合肥"} requestType:QuecNetworkRequestTypeGET success:^(NSDictionary *response) {
        NSLog(@"+++%@",response);
        if (response) {
            NSInteger code = [response[@"code"] integerValue];
            if (code == 200) {
                self.dataArray = [response[@"data"] mutableCopy];
                [self.dataTableView reloadData];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"+++%@",error);
    }];
}

- (void)postButtonClick {
    [[QuecNetworkManager shared] requestWithUrlString:@"" params:@{} requestType:QuecNetworkRequestTypePOST success:^(NSDictionary *response) {
        NSLog(@"+++%@",response);
    } failure:^(NSError *error) {
        NSLog(@"+++%@",error);
    }];
}

- (void)downLoadButtonClick {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    [[QuecNetworkManager shared] requestDownLoadDataWithUrlString:@"http://img.netbian.com/file/2021/0617/6d20675dae44876cead0ddcb77e88a28.jpg" filePath:path progress:^(NSProgress *progress) {
        NSLog(@"progress: %@",progress.localizedDescription);
    } success:^(NSString *filePath) {
        NSLog(@"++++%@",filePath);
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置图片视图的的图片
            self.iconImageView.image= [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/6d20675dae44876cead0ddcb77e88a28.jpg",path]];
        });
    } failure:^(NSError *error) {
        NSLog(@"+++%@",error);
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row][@"temperature"];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = self.dataArray[indexPath.row][@"days"];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

@end

