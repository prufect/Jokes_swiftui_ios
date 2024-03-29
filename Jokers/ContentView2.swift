//
//  ContentView.swift
//  Jokers
//
//  Created by Prudhvi Gadiraju on 9/22/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import SwiftUI

struct ContentView2: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Joke.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Joke.setup, ascending: true)
    ]) var jokes: FetchedResults<Joke>
    
    @State private var showingAddJoke = false
    
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(gradient: Gradient(colors: [Color("Start"), Color("Middle"), Color(
                "End")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(jokes, id: \.setup) { joke in
                        JokeCard(joke: joke)
                    }
                }
            }
            
            Button("Add Joke") {
                self.showingAddJoke.toggle()
            }
            .padding()
            .background(Color.black.opacity(0.5))
            .clipShape(Capsule())
            .foregroundColor(.white)
            .offset(y: 50)
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showingAddJoke) {
            AddView().environment(\.managedObjectContext, self.moc)
        }
    }
    
    func removeJokes(at offsets: IndexSet) {
        for index in offsets {
            let joke = jokes[index]
            moc.delete(joke)
        }
        
        try? moc.save()
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
