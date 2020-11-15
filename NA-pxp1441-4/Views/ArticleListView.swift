//
//  ArticleListView.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 17/10/2020.
//  Copyright © 2020 rit. All rights reserved.
//

import SwiftUI

struct ArticleListView: View {
    
    @ObservedObject var articleViewModel: ArticleViewModel
    
    var body: some View {
        
        Group {
            if articleViewModel.data.isEmpty {
                Text("")
            }
            else {
                List {
                    ForEach(articleViewModel.data) {
                        data in
                        if(!self.articleViewModel.compact) {
                            ZStack {
                                ArticleRowView(article: data)
                                
                                NavigationLink(destination: ArticleDetailView(article: data, articleViewModel: self.articleViewModel)
                                    .navigationBarItems(trailing: Button(action: {
                                        self.articleViewModel.toggleBookmark(article: data)
                                    }) {
                                        Image(systemName: self.articleViewModel.isBookmarked(article: data) ?
                                            "bookmark.fill" : "bookmark")
                                    }))
                                {
                                    EmptyView()
                                }
                            }
                        } else {
                            NavigationLink(destination: ArticleDetailView(article: data, articleViewModel: self.articleViewModel)
                                .navigationBarItems(trailing: Button(action: {
                                    self.articleViewModel.toggleBookmark(article: data)
                                }) {
                                    Image(systemName: self.articleViewModel.isBookmarked(article: data) ?
                                        "bookmark.fill" : "bookmark")
                                }))
                            {
                                CompactArticleRowView(article: data)
                            }
                        }
                    }
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
            }
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articleViewModel: ArticleViewModel())
    }
}
