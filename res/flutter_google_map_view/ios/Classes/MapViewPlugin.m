#import "MapViewPlugin.h"
#import "MapViewController.h"
#import "MapAnnotation.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation MapViewPlugin

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel
            methodChannelWithName:@"com.apptreesoftware.map_view"
                  binaryMessenger:[registrar messenger]];
    UIViewController *host = UIApplication.sharedApplication.delegate.window.rootViewController;
    MapViewPlugin *instance = [[MapViewPlugin alloc] initWithHost:host channel:channel];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (id)initWithHost:(UIViewController *)host channel:(FlutterMethodChannel *)channel {
    if (self = [super init]) {
        self.host = host;
        self.channel = channel;
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"setApiKey" isEqualToString:call.method]) {
        [GMSServices provideAPIKey:call.arguments];
        result(@YES);
    } else if ([@"show" isEqualToString:call.method]) {
        NSDictionary *args = call.arguments;
        NSDictionary *mapOptions = args[@"mapOptions"];
        NSDictionary *cameraDict = mapOptions[@"cameraPosition"];
        self.mapTitle = mapOptions[@"title"];

        if (mapOptions[@"mapViewType"]  != (id) [NSNull null]) {
             NSString *mapViewTypeName = mapOptions[@"mapViewType"];
             int mapType = [self getMapViewType:mapViewTypeName];
             self.mapViewType = mapType;
        }

        MapViewController *vc = [[MapViewController alloc] initWithPlugin:self
                                                          navigationItems:[self buttonItemsFromActions:args[@"actions"]]
                                                           cameraPosition:[self cameraPositionFromDict:cameraDict]];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        navController.navigationBar.translucent = NO;
        [self.host presentViewController:navController animated:true completion:nil];
        self.mapViewController = vc;
        [self.mapViewController setLocationEnabled:[call.arguments[@"showUserLocation"] boolValue]];
        result(@YES);
    } else if ([@"setAnnotations" isEqualToString:call.method]) {
        [self handleSetAnnotations:call.arguments];
        result(@YES);
    } else if ([@"addAnnotation" isEqualToString:call.method]) {
        [self handleAddAnnotation:call.arguments];
        result(@YES);
    } else if ([@"removeAnnotation" isEqualToString:call.method]) {
        [self handleRemoveAnnotation:call.arguments];
        result(@YES);
    } else if ([@"setCamera" isEqualToString:call.method]) {
        [self handleSetCamera:call.arguments];
        result(@YES);
    } else if ([@"zoomToFit" isEqualToString:call.method]) {
        [self.mapViewController zoomToAnnotations:[((NSNumber *) call.arguments) intValue]];
        result(@YES);
    } else if ([@"zoomToAnnotations" isEqualToString:call.method]) {
        [self handleZoomToAnnotations:call.arguments];
        result(@YES);
    } else if ([@"getCenter" isEqualToString:call.method]) {
        CLLocationCoordinate2D location = self.mapViewController.centerLocation;
        result(@{@"latitude": @(location.latitude), @"longitude": @(location.longitude)});
    } else if ([@"getZoomLevel" isEqualToString:call.method]) {
        result(@(self.mapViewController.zoomLevel));
    } else if ([@"getVisibleMarkers" isEqualToString:call.method]) {
        result(self.mapViewController.visibleMarkers);
    } else if ([@"dismiss" isEqualToString:call.method]) {
        if (self.mapViewController) {
            [self.host dismissViewControllerAnimated:true completion:nil];
        }
        [self.mapViewController shutdown];
        self.mapViewController = nil;
        result(@YES);
    } else {
        result(FlutterMethodNotImplemented);
    }
}


- (NSArray *)buttonItemsFromActions:(NSArray *)actions {
    NSMutableArray *buttons = [NSMutableArray array];
    if (actions) {
        for (NSDictionary *action in actions) {
            UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:[action valueForKey:@"title"]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(handleToolbar:)];
            button.tag = [[action valueForKey:@"identifier"] intValue];
            [buttons addObject:button];
        }
    }
    return buttons;
}

- (void)handleSetAnnotations:(NSArray *)annotations {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *aDict in annotations) {
        MapAnnotation *annotation = [MapAnnotation annotationFromDictionary:aDict];
        if (annotation) {
            [array addObject:annotation];
        }
    }
    [self.mapViewController updateAnnotations:array];
}

- (void)handleAddAnnotation:(NSDictionary *)dict {
    MapAnnotation *annotation = [MapAnnotation annotationFromDictionary:dict];
    if (annotation) {
        [self.mapViewController addAnnotation:annotation];
    }
}

- (void)handleRemoveAnnotation:(NSDictionary *)dict {
    MapAnnotation *annotation = [MapAnnotation annotationFromDictionary:dict];
    if (annotation) {
        [self.mapViewController removeAnnotation:annotation];
    }
}

- (void)handleZoomToAnnotations:(NSDictionary *)zoomToDict {
    NSArray *annotations = zoomToDict[@"annotations"];
    float padding = [zoomToDict[@"padding"] floatValue];
    [self.mapViewController zoomTo:annotations padding:padding];
}

- (void)handleToolbar:(UIBarButtonItem *)item {
    [self.channel invokeMethod:@"onToolbarAction" arguments:@(item.tag)];
}

- (void)handleSetCamera:(NSDictionary *)cameraUpdate {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([cameraUpdate[@"latitude"] doubleValue], [cameraUpdate[@"longitude"] doubleValue]);
    [self.mapViewController setCamera:coordinate zoom:[cameraUpdate[@"zoom"] floatValue]];
}

- (void)onMapReady {
    [self.channel invokeMethod:@"onMapReady" arguments:nil];
}

- (void)locationDidUpdate:(CLLocation *)location {
    [self.channel invokeMethod:@"locationUpdated" arguments:@{@"latitude": @(location.coordinate.latitude), @"longitude": @(location.coordinate.longitude)}];
}

- (void)annotationTapped:(NSString *)identifier {
    [self.channel invokeMethod:@"annotationTapped" arguments:identifier];
}

- (void)infoWindowTapped:(GMSMarker *)identifier {
    [self.channel invokeMethod:@"infoWindowTapped" arguments:identifier];
}

- (void)mapTapped:(CLLocationCoordinate2D)coordinate {
    [self.channel invokeMethod:@"mapTapped" arguments:@{@"latitude": @(coordinate.latitude), @"longitude": @(coordinate.longitude)}];
}

- (void)cameraPositionChanged:(GMSCameraPosition *)position {
    [self.channel invokeMethod:@"cameraPositionChanged" arguments:@{
            @"latitude": @(position.target.latitude),
            @"longitude": @(position.target.longitude),
            @"zoom": @(position.zoom)
    }];
}

- (GMSCameraPosition *)cameraPositionFromDict:(NSDictionary *)dict {
    double latitude = [dict[@"latitude"] doubleValue];
    double longitude = [dict[@"longitude"] doubleValue];
    float zoom = [dict[@"zoom"] floatValue];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(latitude, longitude) zoom:zoom];
    return camera;
}

- (int)getMapViewType:(NSString *)mapViewTypeName {
    int mapType = kGMSTypeNormal;
    if ([@"none" isEqualToString:mapViewTypeName]) {
        mapType = kGMSTypeNone;
    }
    else if ([@"satellite" isEqualToString:mapViewTypeName]) {
        mapType = kGMSTypeSatellite;
    }
    else if ([@"terrain" isEqualToString:mapViewTypeName]) {
        mapType = kGMSTypeTerrain;
    }
    else if ([@"hybrid" isEqualToString:mapViewTypeName]) {
        mapType = kGMSTypeHybrid;
    }
    else if ([@"none" isEqualToString:mapViewTypeName]) {
        mapType = kGMSTypeNone;
    }
    return mapType;
}
@end
