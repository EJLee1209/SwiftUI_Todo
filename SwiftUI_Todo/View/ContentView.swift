//
//  ContentView.swift
//  SwiftUI_Todo
//
//  Created by 이은재 on 2023/04/10.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = TodoViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.todoList, id: \.self) { todo in
                    NavigationLink {
                        TodoEditorView(todo, mode: .edit)
                    } label: {
                        TodoListItem(todo)
                            .listRowInsets(EdgeInsets())
                    }
                }
            }
            .listStyle(PlainListStyle())
            .refreshable {
                viewModel.refreshTodo()
            }
                .navigationTitle("Todo List")
                .toolbar {
                    NavigationLink {
                        TodoEditorView(Todo())
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 25))
                            .bold()
                            .foregroundColor(.black)
                    }
                }
        }.tint(.black)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
