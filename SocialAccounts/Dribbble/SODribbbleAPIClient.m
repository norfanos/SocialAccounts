//
// Copyright 2011-2012 Adar Porat (https://github.com/aporat)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "SODribbbleAPIClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kAFDribbbleAPIBaseURLString = @"http://api.dribbble.com/";

@implementation SODribbbleAPIClient

+ (SODribbbleAPIClient *)sharedClient {
    static SODribbbleAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SODribbbleAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kAFDribbbleAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}


- (void)getPath:(NSString *)path
      sessionId:(NSString *)sessionId
      csrfToken:(NSString *)csrfToken
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
	NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters];
    NSMutableURLRequest* urlRequest = [request mutableCopy];

    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:urlRequest success:success failure:failure];
    [self enqueueHTTPRequestOperation:operation];
}


@end
