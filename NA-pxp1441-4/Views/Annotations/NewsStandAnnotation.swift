//
//  NewsStandAnnotation.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 08/11/2020.
//  Copyright © 2020 rit. All rights reserved.
//

import MapKit
import SwiftUI

class NewsStandAnnotation: NSObject, MKAnnotation {
    var title: String? {
        model.name
    }
    
    var subtitle: String? {
        model.category.description
    }
    
    var coordinate: CLLocationCoordinate2D {
        model.coordinate
    }
    
    var model: NewsStand
    
    init(newsStand: NewsStand) {
        model = newsStand
    }
}
