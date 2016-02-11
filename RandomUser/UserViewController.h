//
//  UserViewController.h
//  RandomUser
//
//  Created by Wojciech Chojnacki on 11/02/2016.
//  Copyright © 2016 Memrise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"

@interface UserViewController : UITableViewController
@property (nonatomic, strong) MRUser *user;
@end
