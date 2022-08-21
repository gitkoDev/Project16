//
//  ViewController.swift
//  Project16
//
//  Created by Gitko Denis on 21.07.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ac = UIAlertController(title: "Choose the type of the map", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: chooseMapType))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: chooseMapType))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: chooseMapType))
        present(ac, animated: true)
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", website: "en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", website: "en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", website: "en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", website: "en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", website: "en.wikipedia.org/wiki/Washington_(state)")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }

        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Website") as? WebsiteViewController {
            navigationController?.pushViewController(vc, animated: true)
            vc.placeName = capital.title
            vc.website = capital.website
        }
    }
    
    func chooseMapType(action: UIAlertAction) {
        if let action = action.title {
            switch action {
            case "Hybrid":
                mapView.mapType = .hybrid
            case "Satellite":
                mapView.mapType = .satellite
            default:
                mapView.mapType = .standard
            }
        }
    }
    
}

