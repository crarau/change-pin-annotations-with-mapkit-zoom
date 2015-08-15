#import <MapKit/MapKit.h>

#define MERCATOR_RADIUS 85445659.44705395
#define MAX_GOOGLE_LEVELS 20

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;
- (MKMapRect) rectForCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                            zoomLevel:(NSUInteger)zoomLevel;

- (double)getZoomLevel;

@end