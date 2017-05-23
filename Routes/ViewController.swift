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

    private var source: MKMapItem!
    private var destination: MKMapItem!
    
    @IBOutlet weak var mapOutlet: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapOutlet.delegate = self
        
        var pointCoordinates = CLLocationCoordinate2D(latitude: 6.255509, longitude: -75.580916)
        var pointPlace = MKPlacemark(coordinate: pointCoordinates, addressDictionary: nil)
        
        source = MKMapItem(placemark: pointPlace)
        source.name = "Home"
        
        pointCoordinates = CLLocationCoordinate2D(latitude: 6.274796, longitude: -75.591388)
        pointPlace = MKPlacemark(coordinate: pointCoordinates, addressDictionary: nil)
        
        destination = MKMapItem(placemark: pointPlace)
        destination.name = "College"
        
        self.putPlaceItem(place: source!)
        self.putPlaceItem(place: destination!)
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
    
    func requestRoute(source: MKMapItem, destination: MKMapItem){
        let request = MKDirectionsRequest()
        request.source = source
        request.destination = destination
        request.transportType = .automobile
        
        let indications = MKDirections(request: request)
        indications.calculate(completionHandler: {
            (response: MKDirectionsResponse?, error: Error?) in
            if error != nil {
                print("Error when it executed")
            } else {
                self.showRoute(response: response!)
            }
        })
    }
    
    func showRoute(response: MKDirectionsResponse){
        for route in response.routes {
            // mapOutlet.addOverlays(route.polyline, level: MKOverlayLevel.aboveRoads)
        }
    }


}

