//
//  TodoData.swift
//  SwiftUI_Todo
//
//  Created by 이은재 on 2023/04/10.
//

import Foundation
import RealmSwift
import SwiftUI

class Todo: Object {
    @Persisted var text: String
    @Persisted var postedDate: Date = Date.now
    @Persisted var color: String
}

extension Todo {
    private static var realm = try! Realm()
    
    static func getAllTodo() -> Results<Todo> {
        realm.objects(Todo.self)
    }
    
    static func addTodo(_ todo: Todo) {
        try! realm.write {
            realm.add(todo)
        }
    }
    
    static func delTodo(_ todo: Todo) {
        try! realm.write({
            realm.delete(todo)
        })
    }
    
    static func updateTodo(_ todo: Todo, text: String, color: String) {
        try! realm.write {
            todo.text = text
            todo.color = color
            todo.postedDate = Date.now
        }
    }
}

