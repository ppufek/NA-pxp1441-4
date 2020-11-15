//
//  ArticleRowView.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 17/10/2020.
//  Copyright © 2020 rit. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArticleRowView: View {
    
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            WebImage(url: article.imageUrl)
                .resizable()
                .placeholder {
                    Rectangle().fill(Color.gray)
            }
            .frame(height: UIScreen.main.bounds.height * 0.35)
            .cornerRadius(12)
            Text(article.title)
                .font(.headline)
        }
    }
}
