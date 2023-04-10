//
//  TodoListItem.swift
//  SwiftUI_Todo
//
//  Created by 이은재 on 2023/04/10.
//

import SwiftUI

struct TodoListItem: View {
    var todo: Todo
    
    init(_ todo: Todo) {
        self.todo = todo
    }
    
    var body: some View {
        HStack {
            VStack(alignment:.leading, spacing: 0) {
                Divider().frame(maxHeight: 0).opacity(0)
                Text(todo.text)
                    .font(.system(size: 20))
                    .bold()
                Text(todo.postedDate, style: .date)
                    .font(.system(size: 16))
                    .padding(.top, 12)
            }            

        }.padding()
            .background(Color(todo.color))
            .cornerRadius(12)
        
    }
}

struct TodoListItem_Previews: PreviewProvider {
    static var previews: some View {
        TodoListItem(Todo())
    }
}
