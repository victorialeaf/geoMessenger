//
//  MapViewExtension.swift
//  geoMessenger
//
//  Created by Victoria Leaf on 10/18/17.
//  Copyright © 2017 Victoria Leaf. All rights reserved.
//

import UIKit
import MapKit

extension FirstViewController: MKMapViewDelegate {
    func mapView(_mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if let annotation = annotation as? Message {
            let identifier = "Pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation,reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -8, y: -5)
                view.pinTintColor = .green
                view.animatesDrop = true
                //view.image = UIImage(named: "mapButtonOff.png")
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIButton
            }
            return view
        }
        return nil
    }
    func mapView(_mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let message = view.annotation as! Message
        let placeName = message.title
        let placeInfo = message.subtitle
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        //add button to remove annotation
        ac.addAction(UIAlertAction(title: "Remove", style: .default) {
            (result : UIAlertAction) -> Void in
            self.mapView.removeAnnotation(message)
        })
        present(ac, animated: true)
    }
    
    
}


