#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Snowflake : NSObject

@property (assign) NSRect rect;

- (instancetype) initWith: (NSRect) rect speed: (CGFloat) speed;
+ (instancetype) newSnowflakeBounded: (NSRect) bound;

- (nullable instancetype) snowIn: (NSRect) bound;

@end

NS_ASSUME_NONNULL_END
