//
//  APIManager.h
//  RandomUser
//
//  Created by Wojciech Chojnacki on 11/02/2016.
//  Copyright © 2016 Memrise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRUser : NSObject
@property (nullable, nonatomic, strong) NSString *firstname;
@property (nullable, nonatomic, strong) NSString *lastname;
@property (nullable, nonatomic, strong) NSString *username;
@property (nullable, nonatomic, strong) NSString *avatar;
- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary *)dict;
- (nullable NSURL *)avatarURL;
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
- (void)generateRandomUserWithComplete:(nullable void (^)(MRUser * _Nonnull user, NSError * _Nullable error))complete;
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
- (void)loadUsersWithComplete:(nullable void (^)(NSError * _Nullable error))complete;

/**
 *  Add user
 *
 *  @param user     user object
 *  @param complete called when async operation finished
 */
- (void)addUser:(nonnull MRUser *)user complete:(nullable void (^)(NSError * _Nullable error))complete;

/**
 *  Get user object at index
 *
 *  @param index object index
 *
 *  @return user object
 */
- (nullable MRUser *)userAtIndex:(NSUInteger)index;
@end