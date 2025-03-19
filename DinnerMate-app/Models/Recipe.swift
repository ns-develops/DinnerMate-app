//
//  Recipe.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//


import Foundation

struct Recipe: Identifiable {
    var id = UUID()  // Unik identifierare
    var name: String
    var category: String
    var description: String
}
