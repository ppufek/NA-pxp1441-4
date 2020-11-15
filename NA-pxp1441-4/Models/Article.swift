//
//  Article.swift
//  NA-2
//
//  Created by Andrej Saric.
//

import Foundation

struct Article: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let content: String
    let imageUrl: URL?
    let url: URL
    let author: String?
    let publishedAt: Date
    let source: String
    let views: Int
    let rating: Int
    let relatedArticles: [Int]
    let category: Category
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case imageUrl
        case url
        case author
        case publishedAt
        case source
        case views
        case rating
        case relatedArticles
        case category
    }
}
