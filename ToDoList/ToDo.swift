//
//  ToDo.swift
//  ToDoList
//
//  Created by Алексей Сергеев on 27.04.2021.
//  Copyright © 2021 Алексей Сергеев. All rights reserved.
//

import Foundation

struct ToDo: Equatable, Codable {
    let id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadToDos() -> [ToDo]? {
        guard let codedTodos = try? Data(contentsOf: archiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedTodos)
    }
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        if let codedTodos = try? propertyListEncoder.encode(todos) {
            try? codedTodos.write(to: archiveURL, options: .noFileProtection)
        }
    }
    
    static func loadTestToDos() -> [ToDo] {
        return [ ToDo(title: "Make ToDos", isComplete: false, dueDate: Date(), notes: "Crate five ToDos"),
                 ToDo(title: "Complete two ToDos today", isComplete: false, dueDate: Date(), notes: "Expired: Today")]
    }
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }()
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("todo").appendingPathExtension("plist")
}


