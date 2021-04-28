//
//  ToDo.swift
//  ToDoList
//
//  Created by Алексей Сергеев on 27.04.2021.
//  Copyright © 2021 Алексей Сергеев. All rights reserved.
//

import Foundation

struct ToDo: Equatable {
    let id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadToDos() -> [ToDo]? {
        return nil
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
}


