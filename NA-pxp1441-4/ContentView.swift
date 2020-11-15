//
//  ContentView.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 17/10/2020.
//  Copyright © 2020 rit. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var articleViewModel = ArticleViewModel()
    
    @ObservedObject private var newsStandViewModel = NewsStandViewModel()
    
    @State private var selectedTab = Tab.news
    
    private var buttonText: String {
        return articleViewModel.compact ? "Non-compact" : "Compact"
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                VStack {
                    ArticleListView(articleViewModel: articleViewModel)
                }.tabItem {
                    Image(systemName: Tab.news.icon)
                    Text(Tab.news.title)
                }
                .tag(Tab.news)
                
                BookmarksListView(articleViewModel: articleViewModel)
                    .tabItem {
                        Image(systemName: selectedTab == Tab.bookmarks ?
                            Tab.bookmarks.selectedIcon : Tab.bookmarks.icon)
                        Text(Tab.bookmarks.title)
                }
                .tag(Tab.bookmarks)
                
                
                NewsStandListView(newsStandViewModel: newsStandViewModel)
                    .tabItem {
                        Image(systemName: selectedTab == Tab.newsStand ?
                            Tab.newsStand.selectedIcon : Tab.newsStand.icon)
                        Text(Tab.newsStand.title)
                }
                .tag(Tab.newsStand)
            }
            .navigationBarTitle(selectedTab.title)
            .navigationBarItems(trailing: Button(action: {
                self.articleViewModel.compact.toggle()
            }) {
                if self.selectedTab == Tab.news {
                    Text(buttonText)
                }
            })
        }
    }
    
    private enum Tab {
        case news
        case newsStand
        case bookmarks
        
        var title: String {
            switch self {
            case .news:
                return "News"
            case .newsStand:
                return "News Stands"
            case .bookmarks:
                return "Bookmarks"
            }
        }
        
        var icon: String {
            switch self {
            case .news:
                return "waveform.path.ecg"
            case .newsStand:
                return "location"
            case .bookmarks:
                return "bookmark.fill"
            }
        }
        
        var selectedIcon: String {
            switch self {
            case .news:
                return "waveform.path.ecg"
            case .newsStand:
                return "location.fill"
            case .bookmarks:
                return "bookmark.fill"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
