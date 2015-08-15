//
//  MapOverlayView.m
//  ResizeMapAnnotationsWithZoom
//
//  Created by Ciprian Rarau on 2015-08-14.
//  Copyright (c) 2015 Ciprian Rarau. All rights reserved.
//

#import "MapOverlayRenderer.h"

@implementation MapOverlayRenderer

- (void)drawMapRect:(MKMapRect)mapRect
          zoomScale:(MKZoomScale)zoomScale
          inContext:(CGContextRef)ctx
{
    UIImage *image          = [UIImage imageNamed:@"pinGreen"];
    
    CGImageRef imageReference = image.CGImage;
    
    MKMapRect theMapRect    = [self.overlay boundingMapRect];
    CGRect theRect           = [self rectForMapRect:theMapRect];
    CGRect clipRect     = [self rectForMapRect:mapRect];
    
    CGContextAddRect(ctx, clipRect);
    CGContextClip(ctx);
    
    CGContextDrawImage(ctx, theRect, imageReference);
    
    
}


@end