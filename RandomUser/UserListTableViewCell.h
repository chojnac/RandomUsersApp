//
//  UserListTableViewCell.h
//  RandomUser
//
//  Created by Wojciech Chojnacki on 26/05/2016.
//  Copyright © 2016 Memrise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"

@interface UserListTableViewCell : UITableViewCell
- (void)configure:(MRUser *)user;
@end
