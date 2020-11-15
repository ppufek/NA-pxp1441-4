//
//  NewsStandListView.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 17/10/2020.
//  Copyright © 2020 rit. All rights reserved.
//

import SwiftUI
import MapKit

struct NewsStandListView: View {
    
    @ObservedObject var newsStandViewModel: NewsStandViewModel
    
    @State private var mapState: MapView.MapState? = nil
    
    @State private var mapUtil: MapUtil = MapUtil()
    
    @State private var mapType: MKMapType = .standard
    
    private let keys = ["Standard", "Hybrid", "Satellite"]
    
    private let types: [String: MKMapType] = [
        "Standard": .standard,
        "Hybrid": .hybrid,
        "Satellite": .satellite
    ]
    
    var body: some View {
        
        VStack {
            ZStack {
                MapView(data: $newsStandViewModel.newsStands,
                        mapState: $mapState, mapUtil: $mapUtil, mapType: $mapType)
                    .edgesIgnoringSafeArea(.bottom)
                Picker(selection: $mapType, label: Text("")) {
                    ForEach(keys, id: \.self) {  value in
                        Text(value).tag(self.types[value] ?? MKMapType.standard)
                    }
                }.pickerStyle(SegmentedPickerStyle()).padding()
                    .offset(y: UIScreen.main.bounds.height * (-0.32))
            }
            
        }
        .alert(item: $mapState) { state in
            Alert(title: Text(state.place?.name ?? state.error?.localizedDescription ?? ""),
                  message: Text(state.place?.category.description ?? ""))
        }
    }
}

struct NewsStandListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsStandListView(newsStandViewModel: NewsStandViewModel())
    }
}
