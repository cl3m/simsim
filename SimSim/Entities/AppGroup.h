//
//  AppGroup.h
//  SimSim
//
//  Created by Clem on 13.03.2018.
//

#import <Foundation/Foundation.h>

@class Simulator;

//============================================================================
@interface AppGroup : NSObject

+ (instancetype) appGroupWithDictionary:(NSDictionary*)dictionary simulator:(Simulator*)simulator;

- (instancetype) initWithDictionary:(NSDictionary*)dictionary simulator:(Simulator*)simulator;

@property (nonatomic, readonly) NSString* uuid;
@property (nonatomic, readonly) NSString* bundleIdentifier;
@property (nonatomic, readonly) NSString* contentPath;
@property (nonatomic, readonly) BOOL isAppleApplication;

@end
