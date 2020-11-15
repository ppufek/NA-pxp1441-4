//
//  MapConfig.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 08/11/2020.
//  Copyright © 2020 rit. All rights reserved.
//
import MapKit

struct MapConfig {
    static let initialLocation = CLLocationCoordinate2D(latitude: 45.782722,
                                                        longitude: 15.981194)
    static let regionRadius: CLLocationDistance = 9000

    private init() {}
}
