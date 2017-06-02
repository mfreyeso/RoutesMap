//
//  ViewController.swift
//  Routes
//
//  Created by Mario Reyes Ojeda on 22/05/17.
//  Copyright © 2017 Mario Reyes Ojeda. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    private var sourceItem: MKMapItem!
    private var destinationItem: MKMapItem!
    
    @IBOutlet weak var mapOutlet: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapOutlet.delegate = self
        
        let sourceLocation = CLLocationCoordinate2D(latitude: 6.255509, longitude: -75.580916)
        
        let destinationLocation = CLLocationCoordinate2D(latitude: 6.274796, longitude: -75.591388)

        var pointPlace = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        
        sourceItem = MKMapItem(placemark: pointPlace)
        sourceItem.name = "Home"
        
        pointPlace = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        destinationItem = MKMapItem(placemark: pointPlace)
        destinationItem.name = "College"
        
        self.putPlaceItem(place: sourceItem!)
        self.putPlaceItem(place: destinationItem!)
        
        self.requestRoute(sourceItem: sourceItem!, destinationItem: destinationItem!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func putPlaceItem(place: MKMapItem) {
        let handlerPoint = MKPointAnnotation()
        handlerPoint.coordinate = place.placemark.coordinate
        handlerPoint.title = place.name
        mapOutlet.addAnnotation(handlerPoint)
    
    }
    
    func requestRoute(sourceItem: MKMapItem, destinationItem: MKMapItem){
        let request = MKDirectionsRequest()
        request.source = sourceItem
        request.destination = destinationItem
        request.transportType = .automobile
        
        let indications = MKDirections(request: request)
        
        
        indications.calculate(completionHandler: {(response, error) in
            
            if error != nil {
                print(error.debugDescription)
                print("Error getting directions")
            } else {
                self.showRoute(response: response!)
            }
        })
        
        
    }
    
    func showRoute(response: MKDirectionsResponse){
        for route in response.routes {
            mapOutlet.add(route.polyline, level: MKOverlayLevel.aboveRoads)
            for step in route.steps{
                print(step.instructions)
            }
            mapOutlet.add(route.polyline, level: MKOverlayLevel.aboveRoads)
        }
        let center = sourceItem.placemark.coordinate
        let region = MKCoordinateRegionMakeWithDistance(center, 3000, 3000)
        mapOutlet.setRegion(region, animated: true)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 3.0
        return renderer
    }

}

