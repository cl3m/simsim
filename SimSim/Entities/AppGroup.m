//
//  AppGroup.m
//  SimSim
//
//  Created by Clem on 13.03.2018.
//

#import <AppKit/AppKit.h>
#import "AppGroup.h"
#import "Simulator.h"
#import "FileManager.h"

//============================================================================
@interface AppGroup ()

@property (nonatomic, strong) NSString* uuid;
@property (nonatomic, strong) NSString* contentPath;
@property (nonatomic, strong) NSDictionary* properties;

@end


//============================================================================
@implementation AppGroup

//----------------------------------------------------------------------------
+ (instancetype) appGroupWithDictionary:(NSDictionary*)dictionary simulator:(Simulator*)simulator
{
    return [(AppGroup*)[[self class] alloc] initWithDictionary:dictionary simulator:simulator];
}

//----------------------------------------------------------------------------
- (instancetype) initWithDictionary:(NSDictionary*)dictionary simulator:(Simulator*)simulator;
{
    self = [super init];

    if (self)
    {
        self.uuid = dictionary[KEY_FILE];
        self.properties = [self getAppGroupPropertiesByUUID:self.uuid andRootPath:simulator.path];
    }

    return self;
}

//----------------------------------------------------------------------------
- (BOOL) isAppleApplication
{
    return [self.bundleIdentifier hasPrefix:@"group.com.apple"] || [self.bundleIdentifier hasPrefix:@"com.apple"];
}

//----------------------------------------------------------------------------
- (NSString*) bundleIdentifier
{
    return self.properties[@"MCMMetadataIdentifier"];
}

#pragma mark - Private
//----------------------------------------------------------------------------
- (NSString*) appGroupRootPathByUUID:(NSString*)uuid
                            andRootPath:(NSString*)simulatorRootPath
{
    return
        [simulatorRootPath stringByAppendingFormat:@"data/Containers/Shared/AppGroup/%@/", uuid];
}

//----------------------------------------------------------------------------
- (NSDictionary*) getAppGroupPropertiesByUUID:(NSString*)uuid
                                     andRootPath:(NSString*)simulatorRootPath
{
    self.contentPath = [self appGroupRootPathByUUID:uuid andRootPath:simulatorRootPath];

    NSString* appGroupDataPropertiesPath =
        [self.contentPath stringByAppendingString:@".com.apple.mobile_container_manager.metadata.plist"];

    return [NSDictionary dictionaryWithContentsOfFile:appGroupDataPropertiesPath];
}

@end
