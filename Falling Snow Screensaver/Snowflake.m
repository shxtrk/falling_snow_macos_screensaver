#import "Snowflake.h"

CGFloat const SNOWFLAKE_MIN_SIZE = 2.0;
CGFloat const SNOWFLAKE_MAX_SIZE = 10.0;
CGFloat const SNOWFLAKE_MIN_SPEED = 1.0;
CGFloat const SNOWFLAKE_MAX_SPEED = 5.0;
CGFloat const SNOWFLAKE_MIN_TIME_DELTA = 0.001;
CGFloat const SNOWFLAKE_MAX_TIME_DELTA = 0.015;
CGFloat const SNOWFLAKE_DELTA_X_FACTOR = 10.0;

#define shift(t) sin(t * 27) + sin(t * 21.3) + 3 * sin(t * 18.75) + 7 * sin(t * 7.6) + 10 * sin(t * 5.23)

static CGFloat rndCGFloatBetween(CGFloat a, CGFloat b) {
    return a + (b - a) * ((CGFloat) random() / (CGFloat) RAND_MAX);
}

@interface Snowflake ()

@property (assign) CGFloat speed;
@property (assign) CGFloat time;
@property (assign) CGFloat timeDelta;

@end

@implementation Snowflake

- (instancetype) initWith: (NSRect) rect speed: (CGFloat) speed {
    self = [super init];
    if (self) {
        _rect = rect;
        _speed = speed;
        _time = M_PI * rndCGFloatBetween(0.0, 2.0);
        _timeDelta = rndCGFloatBetween(SNOWFLAKE_MIN_TIME_DELTA, SNOWFLAKE_MAX_TIME_DELTA);
    }
    return self;
}

+ (instancetype) newSnowflakeBounded: (NSRect) bound {
    CGFloat size = rndCGFloatBetween(SNOWFLAKE_MIN_SIZE, SNOWFLAKE_MAX_SIZE);
    NSRect snowflakeRect = NSMakeRect(rndCGFloatBetween(bound.origin.x, bound.size.width) - (bound.size.width / (SNOWFLAKE_DELTA_X_FACTOR * 4)),
                                      bound.size.height + SNOWFLAKE_MAX_SIZE,
                                      size,
                                      size);
    CGFloat speed = rndCGFloatBetween(SNOWFLAKE_MIN_SPEED, SNOWFLAKE_MAX_SPEED);
    return [[Snowflake alloc] initWith: snowflakeRect speed: speed];
}

- (nullable instancetype) snowIn: (NSRect) bound {
    [self setTime: [self time] + [self timeDelta]];
    
    CGFloat newY = [self rect].origin.y - [self speed];
    if (newY + [self rect].size.height < 0.0) {
        return [Snowflake newSnowflakeBounded: bound];
    }
    
    CGFloat deltaX = (CGFloat)shift([self time]);
    CGFloat newX = [self rect].origin.x + deltaX / SNOWFLAKE_DELTA_X_FACTOR;
    
    [self setRect: NSMakeRect(newX,
                              newY,
                              [self rect].size.width,
                              [self rect].size.height)];
    return nil;
}

@end
