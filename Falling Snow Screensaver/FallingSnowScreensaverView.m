#import "FallingSnowScreensaverView.h"
#import "Snowflake.h"

NSInteger const SNOWFLAKE_COUNT_FACTOR = 5;

@interface FallingSnowScreensaverView ()

@property (nonatomic, strong) NSMutableArray *snowflakes;
@property (assign) NSInteger snowflakeCount;

@end

@implementation FallingSnowScreensaverView

- (instancetype)initWithFrame: (NSRect)frame isPreview: (BOOL)isPreview {
    self = [super initWithFrame: frame isPreview: isPreview];
    if (self) {
        [self setAnimationTimeInterval: 1 / 30.0];
    }
    _snowflakes = [[NSMutableArray alloc] init];
    _snowflakeCount = frame.size.width / SNOWFLAKE_COUNT_FACTOR;
    [self createSnow];
    return self;
}

- (void)startAnimation {
    [super startAnimation];
}

- (void)stopAnimation {
    [super stopAnimation];
}

- (void)drawRect: (NSRect)rect {
    [super drawRect: rect];
   
    [[NSColor whiteColor] setFill];
    
    for (int i = 0; i < [self snowflakeCount]; i++) {
        Snowflake *snowflake = [[self snowflakes] objectAtIndex: i];
        NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect: snowflake.rect
                                                             xRadius: snowflake.rect.size.width
                                                             yRadius: snowflake.rect.size.height];
        [path fill];
    }
}

- (void)animateOneFrame {
    [super animateOneFrame];
    
    for (int i = 0; i < [self snowflakeCount]; i++) {
        Snowflake *oldSnowflake = [[self snowflakes] objectAtIndex: i];
        Snowflake *newSnowlake = [oldSnowflake snowIn: [self bounds]];
        
        if (newSnowlake != nil) {
            [[self snowflakes] replaceObjectAtIndex: i withObject: newSnowlake];
        }
    }
    
    [self setNeedsDisplayInRect: [self bounds]];
    return;
}

- (BOOL)hasConfigureSheet {
    return NO;
}

- (NSWindow*)configureSheet {
    return nil;
}

- (void)createSnow {
    [[self snowflakes] removeAllObjects];
    for (int i = 0; i < [self snowflakeCount]; i++) {
        Snowflake *snowflake = [Snowflake newSnowflakeBounded: [self bounds]];
        [[self snowflakes] addObject: snowflake];
    }
}

@end
