//
//  ArticleListView.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 17/10/2020.
//  Copyright © 2020 rit. All rights reserved.
//

import SwiftUI

struct BookmarksListView: View {
    
    @ObservedObject var articleViewModel: ArticleViewModel
    
    var body: some View {
        
        Group {
            if articleViewModel.bookmarks.isEmpty {
                Text("")
            }
            else {
                List {
                    ForEach(articleViewModel.bookmarks) {
                        data in
                        if(self.articleViewModel.compact) {
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
                        } else {
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
                        }
                    }.onDelete(perform: self.articleViewModel.deleteBookmark)
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
            }
        }
    }
}


struct BookmarksListView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksListView(articleViewModel: ArticleViewModel())
    }
}
