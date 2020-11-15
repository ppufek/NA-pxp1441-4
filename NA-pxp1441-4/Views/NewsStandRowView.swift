//
//  NewsStandRowView.swift
//  NA-pxp1441-4
//
//  Created by Paula Pufek on 17/10/2020.
//  Copyright © 2020 rit. All rights reserved.
//

import SwiftUI

struct NewsStandRowView: View {
    
    var newsStand: NewsStand
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(newsStand.name)
                    .font(.headline)
                Text(newsStand.category.description)
                    .font(.body)
            }
        }
    }
}
