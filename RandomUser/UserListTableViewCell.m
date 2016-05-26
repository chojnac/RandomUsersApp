//
//  UserListTableViewCell.m
//  RandomUser
//
//  Created by Wojciech Chojnacki on 26/05/2016.
//  Copyright © 2016 Memrise. All rights reserved.
//

#import "UserListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserListTableViewCell ()
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *loginLabel;
@end

@implementation UserListTableViewCell

- (void)configure:(MRUser *)user {
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstname, user.lastname];
    self.loginLabel.text = user.username;
    [self.avatarImageView sd_setImageWithURL:user.avatarURL placeholderImage:nil];
}

@end
