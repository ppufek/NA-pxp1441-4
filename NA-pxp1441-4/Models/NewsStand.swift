//
//  NewsStand.swift
//  NA-2
//
//  Created by Andrej Saric.
//

import Foundation
import MapKit

struct NewsStand: Codable, Identifiable {
    let id: Int
    let name: String
    let location: Location
    let category: Category
}

extension NewsStand {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.location.latitude, longitude: self.location.longitude)
    }
}
