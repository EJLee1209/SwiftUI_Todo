//
//  TodoViewModel.swift
//  SwiftUI_Todo
//
//  Created by 이은재 on 2023/04/10.
//

import Foundation

class TodoViewModel: ObservableObject {
    @Published var todoList : [Todo] = Array(Todo.getAllTodo())
    
    func add(text: String, color: String) {
        guard !text.isEmpty else { return }
        guard !color.isEmpty else { return }
        let todo = Todo()
        todo.text = text
        todo.color = color
        Todo.addTodo(todo)
    }
    
    func refreshTodo() {
        self.todoList = Array(Todo.getAllTodo())
    }
    
    func updateTodo(todo: Todo, text: String, color: String) {
        guard !text.isEmpty else { return }
        guard !color.isEmpty else { return }
        Todo.updateTodo(todo, text: text, color: color)
    }
}
