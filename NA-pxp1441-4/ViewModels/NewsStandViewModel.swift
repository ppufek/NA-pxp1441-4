//
//  NewsStandViewModel.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 21/10/2020.
//  Copyright © 2020 rit. All rights reserved.
//

import Foundation
import Combine

class NewsStandViewModel: ObservableObject{
    
    @Published var newsStands: [NewsStand] = []
    
    private var cancellable : Set<AnyCancellable> = []
    
    init() {
        retrieveNewsStandsData()
    }
    
    func retrieveNewsStandsData() {
        guard let url = URL(string: "https://70o99.mocklab.io/newsstand") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { $0.data }
            .decode(type: [NewsStand].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { print($0) },
                    receiveValue: { self.newsStands = $0 })
            .store(in: &cancellable)
    }
}
