//
//  ArticleDetailView.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 07/11/2020.
//  Copyright © 2020 rit. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ButtonInfoView: View {
    
    var text: String
    var icon: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray).opacity(0.3)
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                Text(text)
                    .font(.body)
            }
            .padding()
            .fixedSize(horizontal: true, vertical: false)
        }.opacity(0.4)
    }
}

struct ArticleDetailView: View {
    
    var article: Article
    
    @ObservedObject var articleViewModel: ArticleViewModel
    
    private var relatedArticlesList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(self.articleViewModel.getRelatedArticles(article: article)) {
                    data in VStack(alignment: .leading, spacing: 8) {
                        WebImage(url: data.imageUrl)
                            .resizable()
                            .cornerRadius(12)
                            .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.25)
                        
                        Text(data.title)
                            .font(.subheadline)
                        Spacer()
                    }.frame(width: UIScreen.main.bounds.width * 0.8)
                    
                }
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    WebImage(url: article.imageUrl)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.3)
                    
                    HStack {
                        if article.author != nil {
                            ButtonInfoView(text: article.author ?? "", icon: "pencil")
                        }
                        ButtonInfoView(text: article.views.description, icon: "eye")
                        ButtonInfoView(text: article.rating.description, icon: "star")
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.78, height: 50)
                    .padding()
                }
                Group {
                    Text(article.title)
                        .font(.title)
                    
                    Text(article.content)
                        .font(.body)
                    
                    Button(action: {
                        if URL(string: self.article.url.description) != nil {
                            UIApplication.shared.open(self.article.url)
                        }
                    }) {
                        Text(article.url.description).foregroundColor(.blue).font(.body)
                    }
                    
                    if self.articleViewModel.getRelatedArticles(article: article).count != 0 {
                        Text("Related")
                            .font(.title)
                        self.relatedArticlesList
                    }
                    
                }.navigationBarTitle(article.source)
                    .font(.largeTitle)
                    .padding()
            }
        }
    }
}
