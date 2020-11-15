//
//  MapUtil.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 11/11/2020.
//  Copyright © 2020 rit. All rights reserved.
//
import MapKit

struct MapUtil {
    func getDirections(for newsStand: NewsStand, userCoordinates: CLLocationCoordinate2D) throws {
        let userLat = userCoordinates.latitude
        let userLong = userCoordinates.longitude
        
        let newsStandLat = newsStand.coordinate.latitude
        let newsStandLong = newsStand.coordinate.longitude
        
        let urlString = "https://maps.apple.com/?daddr=(\(newsStandLat),\(newsStandLong))&dirflg=d&saddr=(\(userLat),\(userLong))"
        
        guard let url = URL(string: urlString) else {
            throw DirectionsError.url(message: "Url is not valid.")
        }
        
        guard UIApplication.shared.canOpenURL(url) else {
            throw DirectionsError.url(message: "Url cannot be opened.")
        }
        UIApplication.shared.open(url, options: [:])
    }
}
