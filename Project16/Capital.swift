//
//  Capital.swift
//  Project16
//
//  Created by Gitko Denis on 21.07.2022.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var website: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, website: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.website = website
    }
}
