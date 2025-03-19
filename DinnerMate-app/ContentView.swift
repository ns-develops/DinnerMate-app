//
//  ContentView.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//


import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        RecipeListView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
