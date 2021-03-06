//
//  MapOverlay.h
//  ResizeMapAnnotationsWithZoom
//
//  Created by Ciprian Rarau on 2015-08-14.
//  Copyright (c) 2015 Ciprian Rarau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface MapOverlay : NSObject <MKOverlay> {
    
}
- (MKMapRect)boundingMapRect;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end