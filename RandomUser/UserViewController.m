//
//  UserViewController.m
//  RandomUser
//
//  Created by Wojciech Chojnacki on 11/02/2016.
//  Copyright © 2016 Memrise. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()
@property (weak, nonatomic) IBOutlet UILabel *firstnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstnameLabel.text = _user.firstname;
    self.lastnameLabel.text = _user.lastname;
    self.usernameLabel.text = _user.username;
}

@end
