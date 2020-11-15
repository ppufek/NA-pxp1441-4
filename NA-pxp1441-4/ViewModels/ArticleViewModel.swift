//
//  ArticleViewModel.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 17/10/2020.
//  Copyright © 2020 rit. All rights reserved.
//

import Foundation
import Combine

class ArticleViewModel: ObservableObject {
    
    @Published private(set) var data: [Article] = []
    
    @Published private(set) var bookmarks: [Article] = []
    
    @Published var compact: Bool = false
    
    private var cancellable : Set<AnyCancellable> = []
    
    init() {
        retrieveData()
    }
    
    func retrieveData() {
        guard let url = URL(string: "https://70o99.mocklab.io/news") else {
            return
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { $0.data }
            .decode(type: [Article].self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { self.data = $0 })
            .store(in: &cancellable)
    }
    
    func toggleBookmark(article: Article) {
        guard let index = bookmarks.firstIndex(where: {
            $0.id == article.id
        }) else {
            bookmarks.append(article)
            return
        }
        self.bookmarks.remove(at: index)
    }
    
    func deleteBookmark(at indexSet: IndexSet) {
        self.bookmarks.remove(atOffsets: indexSet)
    }
    
    func isBookmarked(article: Article) -> Bool {
        bookmarks.contains(article)
    }
    
    func getRelatedArticles(article: Article) -> [Article] {
        
        var relatedArticles: [Article] = []
        
        let articleIds = article.relatedArticles
                
        for id in articleIds {
            relatedArticles.append(contentsOf: data.filter { $0.id == id})
        }
        return relatedArticles
    }
}
