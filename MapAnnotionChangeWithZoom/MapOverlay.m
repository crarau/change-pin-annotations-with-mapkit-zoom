//
//  MapOverlay.m
//  ResizeMapAnnotationsWithZoom
//
//  Created by Ciprian Rarau on 2015-08-14.
//  Copyright (c) 2015 Ciprian Rarau. All rights reserved.
//

#import "MapOverlay.h"

@implementation MapOverlay

- (MKMapRect)boundingMapRect
{
    MKMapPoint upperLeft = MKMapPointForCoordinate(self.coordinate);
    
    MKMapRect bounds = MKMapRectMake(upperLeft.x, upperLeft.y, 2000, 2000);
    return bounds;
}


@end