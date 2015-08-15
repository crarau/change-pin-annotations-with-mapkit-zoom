//
//  ViewController.m
//  ResizeMapAnnotationsWithZoom
//
//  Created by Ciprian Rarau on 2015-08-14.
//  Copyright (c) 2015 Ciprian Rarau. All rights reserved.
//

#import "ViewController.h"
#import "MapKit/MapKit.h"
#import "MKMapView+ZoomLevel.h"
#import "MKColorCircle.h"
#import "MapOverlay.h"
#import "MapOverlayRenderer.h"
#import "UIImage+Resize.h"
#import "ImageAnnotation.h"
#import "HexColors.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) NSMutableArray *selectedOptions;
@property double previousZoomZone;
@property UIImage * emptyImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.emptyImage = [self generateEmptyImage];
    CLLocationCoordinate2D coordinate1 =  CLLocationCoordinate2DMake(34.42612, -118.59973);
    CLLocationCoordinate2D coordinate2 =  CLLocationCoordinate2DMake(34.42412, -118.59974);
    CLLocationCoordinate2D coordinate3 =  CLLocationCoordinate2DMake(34.42539, -118.59878);
    CLLocationCoordinate2D coordinate4 =  CLLocationCoordinate2DMake(34.42616, -118.59841);

    ImageAnnotation *point1 = [[ImageAnnotation alloc] init];
    point1.coordinate = coordinate1;
    point1.imageName = @"canion";
    point1.title = @"point1";
    [_mapView addAnnotation:point1];

    ImageAnnotation *point2 = [[ImageAnnotation alloc] init];
    point2.coordinate = coordinate2;
    point2.imageName = @"yellowstone";
    point2.title = @"point2";
    [_mapView addAnnotation:point2];

    ImageAnnotation *point3 = [[ImageAnnotation alloc] init];
    point3.coordinate = coordinate3;
    point3.imageName = @"amazon";
    point3.title = @"point3";
    [_mapView addAnnotation:point3];

    ImageAnnotation *point4 = [[ImageAnnotation alloc] init];
    point4.coordinate = coordinate4;
    point4.imageName = @"machu-picchu";
    point4.title = @"point4";
    [_mapView addAnnotation:point4];

    CLLocationDegrees latDelta = 34.4311 - 34.4194;
    MKCoordinateSpan span = MKCoordinateSpanMake(fabs(latDelta), 0.0);
    MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(34.4248, -118.5971), span);
    self.mapView.region = region;
    
    self.previousZoomZone = [self currentZoomZone];
    
    [self refreshLayers];
    
    self.mapView.mapType = MKMapTypeStandard;
}


- (UIImage *) generateEmptyImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(36, 36), NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return blank;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"zoom level %f", self.mapView.getZoomLevel);

    if (self.previousZoomZone != [self currentZoomZone]) {
        NSArray * mapAnnotations = self.mapView.annotations;
        [self.mapView removeAnnotations:mapAnnotations];
        [self.mapView addAnnotations:mapAnnotations];
        [self.mapView removeOverlays:self.mapView.overlays];

        [self refreshLayers];
        
        self.previousZoomZone = [self currentZoomZone];
    }
}

- (void) refreshLayers {
    if ([self currentZoomZone] != 1) {
        return;
    }
    
    for (id annotation in self.mapView.annotations) {
        if (![annotation isKindOfClass:[MKPointAnnotation class]]) {
            continue;
        }
        
        MKPointAnnotation * pointAnnotation = (MKPointAnnotation *) annotation;
        MKColorCircle *colorCircle = (MKColorCircle *)[MKColorCircle circleWithCenterCoordinate:pointAnnotation.coordinate radius:10];
        colorCircle.color = [UIColor colorWithHexString:@"#00B955"];
        
        [self.mapView addOverlay:colorCircle];
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:MKColorCircle.class]) {
        MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        circleView.strokeColor = [(MKColorCircle *)overlay color];
        
        return circleView;
    }
    return nil;
}

- (int) currentZoomZone {
    if (self.mapView.getZoomLevel < 12) {
        return 1;
    } else if (self.mapView.getZoomLevel < 14) {
        return 2;
    } else {
        return 3;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    NSString * pinIdentifier = [NSString stringWithFormat:@"identified %d", [self currentZoomZone]];
    MKAnnotationView *annotationView  = [mapView dequeueReusableAnnotationViewWithIdentifier:pinIdentifier];
    if (!annotationView)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pinIdentifier];
    }
    
    ImageAnnotation * imageAnnotation = (ImageAnnotation *)annotation;
    switch ([self currentZoomZone]) {
        case 1: {
            annotationView.image = self.emptyImage;
            break;
        }
        case 2: {
            annotationView.image = [UIImage imageNamed:@"pinGreen"];
            break;
        }
        case 3: {
            NSLog(@"%@", imageAnnotation.imageName);
            annotationView.image = [[UIImage imageNamed:imageAnnotation.imageName] resizedImageToFitInSize:CGSizeMake(75, 75) scaleIfSmaller:false];
            break;
        }
        default:
            break;
    }
    annotationView.centerOffset = CGPointMake(0, -annotationView.image.size.height / 2);
    annotationView.annotation = annotation;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"tap on %@", view);

}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)aView
{
    
}


@end
