//
//  MapView.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 08/11/2020.
//  Copyright © 2020 rit. All rights reserved.
//
import SwiftUI
import MapKit

enum DirectionsError: Error, LocalizedError {
    case userLocationNotAvailable
    case url(message: String)
    
    var errorDescription: String? {
        localizedDescription
    }
    
    var localizedDescription: String {
        switch self {
        case .userLocationNotAvailable:
            return "User location not available."
        case .url(let message):
            return message
        }
    }
}

struct MapView : UIViewRepresentable {
    
    struct MapState: Identifiable {
        let id = UUID()
        var place: NewsStand? = nil
        var error: Error? = nil
    }
    
    @Binding var data: [NewsStand]
    @Binding var mapState: MapState?
    @Binding var mapUtil: MapUtil
    @Binding var mapType: MKMapType
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        context.coordinator.zoomToRegion()
        context.coordinator.requestLocationAuthorization()
        return context.coordinator.mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        context.coordinator.createAnnotations(data: data)
        context.coordinator.setType(type: self.mapType)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        var mapView: MKMapView
        private var locationManager: CLLocationManager
        
        init(parent: MapView) {
            self.parent = parent
            self.mapView = MKMapView()
            self.locationManager = CLLocationManager()
            
            super.init()
            
            self.mapView.delegate = self
        }
        
        func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
            print("Finished loading")
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation is MKUserLocation {
                return nil
            }
            
            guard let placeAnnotation = annotation as? NewsStandAnnotation else {
                return nil
            }
            
            let annotationView = MKMarkerAnnotationView(annotation: placeAnnotation,
                                                        reuseIdentifier: "myAnnotation")
            var color: UIColor
            
            switch placeAnnotation.model.category {
            case .technology:
                color = UIColor.blue
            case .gaming:
                color = UIColor.red
            case .apple:
                color = UIColor.gray
            case .entertainment:
                color = UIColor.orange
            case .iOS:
                color = UIColor.blue
            case .sport:
                color = UIColor.purple
            }
            
            annotationView.glyphImage = UIImage(named: placeAnnotation.model.category.description.lowercased())
            annotationView.markerTintColor = color
            
            annotationView.canShowCallout = true
            
            let infoButton = UIButton(type: .infoLight)
            
            let directionsButton = UIButton(type: .infoDark)
            let carImage = UIImage(systemName: "car")
            directionsButton.setImage(carImage, for: .normal)
            
            infoButton.tag = 0
            directionsButton.tag = 1
            
            annotationView.leftCalloutAccessoryView = infoButton
            annotationView.rightCalloutAccessoryView = directionsButton
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            guard let placeAnnotation = view.annotation as? NewsStandAnnotation else {
                return
            }
            
            switch control.tag {
            case 0:
                parent.mapState = MapState(place: placeAnnotation.model)
            case 1:
                do {
                    guard let userCoordinates = locationManager.location?.coordinate else {
                        throw DirectionsError.userLocationNotAvailable
                    }
                    try parent.mapUtil.getDirections(for: placeAnnotation.model, userCoordinates: userCoordinates)
                } catch {
                    parent.mapState = MapState(error: error)
                }
            default:
                return
            }
        }
        
        func requestLocationAuthorization() {
            if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
                locationManager.requestWhenInUseAuthorization()
            }
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        }
        
        func zoomToRegion(center: CLLocationCoordinate2D = MapConfig.initialLocation,
                          regionRadius: CLLocationDistance = MapConfig.regionRadius) {
            
            let region = MKCoordinateRegion(center: center,
                                            latitudinalMeters: regionRadius,
                                            longitudinalMeters: regionRadius)
            
            mapView.setRegion(region, animated: true)
        }
        
        func createAnnotations(data: [NewsStand]) {
            _ = mapView.annotations.filter({ !($0 is MKUserLocation) })
            
            // v5
            mapView.addAnnotations(data.map(NewsStandAnnotation.init))
        }
        
        func setType(type: MKMapType) {
            mapView.mapType = type
        }
    }
}
