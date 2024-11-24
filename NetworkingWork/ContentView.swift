//
//  ContentView.swift
//  NetworkingWork
//
//  Created by Sabith Salman on 2024-11-24.
//

import SwiftUI
struct PostDTO : Codable, Hashable {
    let userId: Int
    let postId: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey{
        case userId
        case postId = "id"
        case title
        case body
    }
}

struct ContentView: View {
    @State var postData : [PostDTO] = []
    @State var isLoading : Bool = false
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .scaleEffect(2.0)
            } else{
                List(postData, id: \.self ){ post in
                    VStack(alignment: .leading){
                        Text(post.title)
                        Text(post.body)
                        
                    }
                    
                }
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
