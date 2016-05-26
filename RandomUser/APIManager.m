//
//  APIManager.m
//  RandomUser
//
//  Created by Wojciech Chojnacki on 11/02/2016.
//  Copyright © 2016 Memrise. All rights reserved.
//

#import "APIManager.h"

@implementation MRUser : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _firstname = dict[@"name"][@"first"];
        _lastname = dict[@"name"][@"last"];
        _username = dict[@"login"][@"username"];
        _avatar = dict[@"picture"][@"thumbnail"];
    }
    return self;
}

- (NSURL *)avatarURL {
    return self.avatar ? [NSURL URLWithString:self.avatar] : nil;
}

@end

@implementation APIManager

- (void)generateRandomUserWithComplete:(void (^)(MRUser *user, NSError *error))complete {
    NSURL *url = [NSURL URLWithString:@"http://api.randomuser.me/"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error) {
            complete ? complete(nil, error):nil;
            return;
        }
        NSError *jsonError;
        id dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if(jsonError) {
            complete ? complete(nil, jsonError):nil;
            return;
        }
        
        if ([dic isKindOfClass:[NSDictionary class]] && dic[@"results"]) {
            NSArray *results = dic[@"results"];
            if ([results count] > 0) {
                NSDictionary *firstItem = results.firstObject;
                MRUser *user = [[MRUser alloc] initWithDictionary:firstItem];
                complete ? complete(user, nil) : nil;
                return;
            }
        }
        complete ? complete(nil, nil) : nil;        
    }];
    [dataTask resume];
}

@end

@interface UserDataManager ()
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation UserDataManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _data = [NSMutableArray array];
    }
    return self;
}

- (NSUInteger)count {
    return self.data.count;
}

- (void)loadUsersWithComplete:(void (^)(NSError *error))complete {
    [self.data removeAllObjects];
    NSArray *users = [self.data copy];
    //dispatch after 10 sec
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.data addObject:users];
        complete ? complete(nil) : nil;
    });
}

- (void)addUser:(MRUser *)user complete:(void (^)(NSError *error))complete {
    //dispatch after 1 sec
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.data addObject:user];
        complete ? complete(nil) : nil;
    });
}

- (MRUser *)userAtIndex:(NSUInteger)index {
    return [self.data objectAtIndex:index];
}
@end
