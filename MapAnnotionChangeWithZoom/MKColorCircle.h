#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKColorCircle : MKCircle <MKOverlay>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;

@end