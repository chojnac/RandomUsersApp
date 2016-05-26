//
//  ViewController.m
//  RandomUser
//
//  Created by Wojciech Chojnacki on 11/02/2016.
//  Copyright © 2016 Memrise. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"
#import "UserViewController.h"
#import "UserListTableViewCell.h"

NSString * const kUserListTableCellId = @"Cell1";

@interface ViewController ()
@property (nonatomic, strong) UserDataManager *userDataManager;
@property (nonatomic, strong) APIManager *apiManager;
@property (nonatomic, weak) UIActivityIndicatorView *indicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserListTableViewCell class]) bundle:nil] forCellReuseIdentifier:kUserListTableCellId];
    
    _userDataManager = [[UserDataManager alloc] init];
    _apiManager = [[APIManager alloc] init];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator sizeToFit];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:indicator];
    self.navigationItem.leftBarButtonItems = @[item];
    self.indicator = indicator;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userDataManager.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserListTableViewCell *cell = (UserListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kUserListTableCellId];
    MRUser *user = [self.userDataManager userAtIndex:indexPath.row];
    [cell configure:user];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MRUser *user = [self.userDataManager userAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"details" sender:user];
}


#pragma mark - Actions

- (IBAction)createUser:(UIBarButtonItem *)sender {
    sender.enabled = NO;
    [self.indicator startAnimating];
    __weak ViewController *this = self;
    [self.apiManager generateRandomUserWithComplete:^(MRUser *user, NSError *error) {
        [self.userDataManager addUser:user complete:^(NSError *error) {
            [this.tableView reloadData];
            sender.enabled = YES;
            [this.indicator stopAnimating];
        }];

    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([sender isKindOfClass:[MRUser class]] && [segue.destinationViewController isKindOfClass:[UserViewController class]]) {
        UserViewController *vc = segue.destinationViewController;
        MRUser *user = sender;
        vc.user = user;
    }
}

@end
