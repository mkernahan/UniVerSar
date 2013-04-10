//
//  UVSMainMapViewController.m
//  UniVerSar
//
//  Created by Michael Kernahan on 2013-04-02.
//  Copyright (c) 2013 redshirtlabs. All rights reserved.
//

#import "UVSMainMapViewController.h"
#import <MapKit/MapKit.h>
#import "UVSAppDelegate.h"

@interface UVSMainMapViewController () < MKMapViewDelegate >

@end

@implementation UVSMainMapViewController {
    
    __weak IBOutlet MKMapView *_mainMapView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _mainMapView.delegate = self;
    [_mainMapView addOverlay:[MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(10.0, 0.0) radius:100000.0]];

    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * 4);
    coords[0] = CLLocationCoordinate2DMake(90.0, -180.0);
    coords[1] = CLLocationCoordinate2DMake(90.0, 180.0);
    coords[2] = CLLocationCoordinate2DMake(-90.0, 180.0);
    coords[3] = CLLocationCoordinate2DMake(-90.0, -180.0);
    [_mainMapView addOverlay:[MKPolygon polygonWithCoordinates:coords count:4]];
    free(coords);
    
    UVSAppDelegate *uvsAD = (UVSAppDelegate *)[UIApplication sharedApplication].delegate;
    NSArray *sss = [uvsAD getAllSolarSystems];
    
    [_mainMapView addAnnotations:sss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backgroundNotification:(NSNotification *)notification {
    _mainMapView.delegate = nil;
}

- (void)foregroundNotification:(NSNotification *)notification {
    _mainMapView.delegate = self;
}

# pragma mark - @protocol MKMapViewDelegate <NSObject>

- (void)mapView:(MKMapView *)mv annotationView:(MKAnnotationView *)annotationView calloutAccessoryControlTapped:(UIControl *)control {
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:overlay];
        circleView.lineWidth = 3;
        circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.1f];
        circleView.strokeColor = [UIColor redColor];
        return circleView;
    }
    if ([overlay isKindOfClass:[MKPolygon class]]) {
        MKPolygonView *polygonView = [[MKPolygonView alloc] initWithPolygon:overlay];
        polygonView.lineWidth = 10.0;
        polygonView.strokeColor = [UIColor redColor];
        polygonView.fillColor = [UIColor blackColor];
        return polygonView;
    }
    return nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id <MKAnnotation>)mapAnnotation {
    if ([mapAnnotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    // try to dequeue an existing pin view first    
    NSString *ssId = @"SolarSystem";
    MKPinAnnotationView *av = (MKPinAnnotationView *)[mv dequeueReusableAnnotationViewWithIdentifier:ssId];
    if (!av) {
        av = [[MKPinAnnotationView alloc] initWithAnnotation:mapAnnotation reuseIdentifier:ssId];
        av.pinColor = MKPinAnnotationColorRed;
        av.canShowCallout = YES;
    }
    return av;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)annotationView {

}

@end
