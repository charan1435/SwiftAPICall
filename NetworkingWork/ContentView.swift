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
    func FetchData() async {
        //create the URL
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        guard let unwrappedUrl  = url else {
            print("Invalid Response")
            return
        }
        
        do{ //Initialize URL session
            let (data, response) = try await URLSession.shared.data(from: unwrappedUrl)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid Response")
                return
            }
            
            switch httpResponse.statusCode{
            case 200..<300:
                let decodedData = try JSONDecoder().decode([PostDTO].self, from: data)
                postData = decodedData
                
            
                
            default:
                print ("Ivalid Respose")
            }
            
            
        }catch{
            
        }
    }
}

#Preview {
    ContentView()
}
