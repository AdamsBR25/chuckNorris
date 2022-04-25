//
//  ContentView.swift
//  Shared
//
//  Created by Brady Adams on 4/25/22.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State private var joke: String = ""
    var body: some View {
        VStack{
            Spacer()
            Text(joke)
                .padding(20)
            Spacer()
            Button {
                Task {
                    if #available(iOS 15.0, *) {
                        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/random")!)
                        let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
                        joke = decodedResponse?.value ?? ""
                    } else {
//                        let (data, _) = URLSession.shared.UR(with: URL(string: "https://api.chucknorris.io/jokes/random")!)
//                        let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
//                        joke = decodedResponse?.value ?? ""
                    }
                    
                }
            } label: {
                Text("Fetch Joke")
                    .padding(20)
            }
            .contentShape(Rectangle())

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Joke: Codable {
    let value: String
}
