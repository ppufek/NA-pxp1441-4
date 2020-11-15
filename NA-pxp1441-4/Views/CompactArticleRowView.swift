//
//  CompactArticleRowView.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 29/10/2020.
//  Copyright © 2020 rit. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CompactArticleRowView: View {
    
    var article: Article
    
    var body: some View {
        
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(article.title)
                        .font(.headline).padding(.bottom, 3)
                    Text(article.content)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(width: UIScreen.main.bounds.width * 0.65, height: UIScreen.main.bounds.height * 0.1)
                Spacer()
                WebImage(url: article.imageUrl)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
            }
        }
    }
}
