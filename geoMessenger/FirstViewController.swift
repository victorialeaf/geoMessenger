//
//  FirstViewController.swift
//  geoMessenger
//
//  Created by Victoria Leaf on 10/18/17.
//  Copyright © 2017 Victoria Leaf. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class FirstViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var messageNodeRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        //set initial location at Marquette University
        let initialLocation = CLLocation(latitude: 43.038611, longitude: -87.928759)
        centerMapOnLocation(location: initialLocation)
        //firebase DB ref
        messageNodeRef = Database.database().reference().child("messages")
        
        //observe handler to poll for realtime updates
        let pinMessageId = "msg-1"
        var pinMessage: Message?
        messageNodeRef.child(pinMessageId).observe(.value, with: { (snapshot: DataSnapshot) in
            if let dictionary = snapshot.value as? [String: Any]
            {
                //if pin already exists, remove
                if pinMessage != nil
                {
                    self.mapView.removeAnnotation(pinMessage!)
                }
                //map JSON tags to message class properties
                let pinLat = dictionary ["latitude"] as! Double
                let pinLong = dictionary ["longitude"] as! Double
                let messageDisabled = dictionary["isDisabled"] as! Bool
                
                let message = Message(title: (dictionary["title"] as? String)!, locationName: (dictionary["locationName"] as? String)!, username: (dictionary["username"] as? String)!, coordinate: CLLocationCoordinate2D(latitude: pinLat, longitude: pinLong), isDisabled: messageDisabled
                )
                pinMessage = message
                //if message isn't disabled, show message as annotation
                if !message.isDisabled
                {
                    self.mapView.addAnnotation(message)
                }
            }
        })
        
        mapView.delegate = self
        //show messages on map
        let message = Message(title: "The Bucks are legit!", locationName: "Bradley Center", username: "John Smith", coordinate: CLLocationCoordinate2D(latitude:43.043914, longitude: -87.917262), isDisabled: <#Bool#>)
        self.mapView.addAnnotation(message)
    
    
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0,regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

