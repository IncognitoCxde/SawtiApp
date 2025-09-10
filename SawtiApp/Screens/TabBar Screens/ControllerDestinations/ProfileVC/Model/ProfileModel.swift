//
//  ProfileModel.swift
//  SawtiApp
//
//  Created by Irina Zakhvatkina on 14/11/24.
//

import UIKit

class ProfileModel {
    
    // MARK: - Struct
    
    struct Book {
        let title: String 
        let imageNames: [String]
    }
    
    struct Category {
        let name: String
        var books: [Book]
    }
    
    // MARK: - Data
    
    var categories: [Category]
    
    init() {
        self.categories = [
            Category(name: "Library", books: [
                Book(title: "Sahih", imageNames: ["Sahih"]),
                Book(title: "1984", imageNames: ["1984"]),
                Book(title: "History of the Tajik", imageNames: ["Tajiks"]),
                Book(title: "arabs", imageNames: ["arabs"])
            ]),
            Category(name: "Liked Books", books: [
                Book(title: "Kafka", imageNames: ["Kafka"]),
                Book(title: "Fahrenheit 451", imageNames: ["451"]),
                Book(title: "Kulliety Forsy", imageNames: ["farsi"]),
                Book(title: "hundredyears", imageNames: ["hundredyears"])
            ]),
            Category(name: "Books Club", books: [
                Book(title: "Beage Club", imageNames: ["BeigeBooks"]),
                Book(title: "Green Club", imageNames: ["GreenBooks"]),
                Book(title: "Brown Club", imageNames: ["BrownBooks"])
            ]),
            Category(name: "Following", books: []),
            Category(name: "Followers", books: []),
            Category(name: "Quotes", books: []),
            Category(name: "History", books: [])
        ]
    }
}
