//
//  APIManager.h
//  RandomUser
//
//  Created by Wojciech Chojnacki on 11/02/2016.
//  Copyright © 2016 Memrise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRUser : NSObject
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end


/**
 *  Remember to disable ATSP for domain api.randomuser.me
 *  Set in target *-Info.plist
 <key>NSAppTransportSecurity</key>
 <dict>
 <key>NSAllowsArbitraryLoads</key><true/>
 </dict>
 */
@interface APIManager : NSObject
- (void)generateRandomUserWithComplete:(void (^)(MRUser *user, NSError *error))complete;
@end



/**
 *  User data manager
 */
@interface UserDataManager : NSObject
/**
 *  Return number of data records
 *
 *  @return number of records 
 */
- (NSUInteger)count;
/**
 * Load data
 *
 *  @param complete called when async operation finished
 */
- (void)loadUsersWithComplete:(void (^)(NSError *error))complete;

/**
 *  Add user
 *
 *  @param user     user object
 *  @param complete called when async operation finished
 */
- (void)addUser:(MRUser *)user complete:(void (^)(NSError *error))complete;

/**
 *  Get user object at index
 *
 *  @param index object index
 *
 *  @return user object
 */
- (MRUser *)userAtIndex:(NSUInteger)index;
@end