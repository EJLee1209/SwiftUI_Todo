//
//  TodoEditorView.swift
//  SwiftUI_Todo
//
//  Created by 이은재 on 2023/04/10.
//

import SwiftUI

enum Mode {
    case add, edit
}

struct TodoEditorView: View {
    @State var text: String = ""
    @State var colorIdx: Int = 0
    @State var delCheck: Bool = false
    @ObservedObject var viewModel = TodoViewModel()
    @Environment(\.dismiss) var dismiss
    
    let placeHolder: String = "할 일 내용을 입력해주세요"
    let colors: [String] = [
        MyColors.purple,
        MyColors.green,
        MyColors.blue,
        MyColors.pink,
    ]
    
    var todo: Todo
    var mode: Mode
    
    init(_ todo: Todo, mode: Mode = .add) {
        self.todo = todo
        self.mode = mode
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ZStack(alignment: .topLeading) {
                    if text.isEmpty {
                        Text(placeHolder)
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                    }
                    TextEditor(text: $text)
                        .font(.body)
                        .disableAutocorrection(true)
                        .submitLabel(.done)
                        .frame(height: proxy.size.height - 100, alignment: .top)
                        .scrollContentBackground(.hidden)
                        .padding()
                        .onAppear {
                            text = todo.text
                            colorIdx = colors.firstIndex(of: todo.color) ?? 0
                        }
                }
                .toolbar {
                    if mode == .add {
                        Button {
                            dismiss()
                            viewModel.add(text: text, color: colors[colorIdx])
                        } label: {
                            Text("저장하기")
                                .foregroundColor(.black)
                        }
                    } else {
                        Button {
                            self.delCheck = true
                        } label: {
                            Image(systemName: "trash")
                        }
                        Button {
                            dismiss()
                            viewModel.updateTodo(todo: todo, text: text, color: colors[colorIdx])
                        } label: {
                            Image(systemName: "pencil")
                        }
                    }
                }
                .alert("정말로 삭제하시겠습니까?", isPresented: $delCheck) {
                    Button {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            Todo.delTodo(todo)
                            viewModel.refreshTodo()
                        }
                        
                    } label: {
                        Text("확인")
                    }
                    Button("아니요", role: .cancel) {}
                }
                HStack {
                    Circle()
                        .frame(width: colorIdx == 0 ? 60 : 50, height: colorIdx == 0 ? 60 : 50)
                        .foregroundColor(Color(MyColors.purple))
                        .overlay(
                            Circle().stroke(lineWidth: 3)
                                .foregroundColor(.white)
                        )
                        .onTapGesture {
                            withAnimation {
                                colorIdx = 0
                            }
                        }
                    Circle()
                        .frame(width: colorIdx == 1 ? 60 : 50, height: colorIdx == 1 ? 60 : 50)
                        .foregroundColor(Color(MyColors.green))
                        .overlay(
                            Circle().stroke(lineWidth: 3)
                                .foregroundColor(.white)
                        )
                        .onTapGesture {
                            withAnimation {
                                colorIdx = 1
                            }
                        }
                    Circle()
                        .frame(width: colorIdx == 2 ? 60 : 50, height: colorIdx == 2 ? 60 : 50)
                        .foregroundColor(Color(MyColors.blue))
                        .overlay(
                            Circle().stroke(lineWidth: 3)
                                .foregroundColor(.white)
                        )
                        .onTapGesture {
                            withAnimation {
                                colorIdx = 2
                            }
                        }
                    Circle()
                        .frame(width: colorIdx == 3 ? 60 : 50, height: colorIdx == 3 ? 60 : 50)
                        .foregroundColor(Color(MyColors.pink))
                        .overlay(
                            Circle().stroke(lineWidth: 3)
                                .foregroundColor(.white)
                        )
                        .onTapGesture {
                            withAnimation {
                                colorIdx = 3
                            }
                        }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(colors[colorIdx]))
        
    }
}

struct TodoEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TodoEditorView(Todo())
    }
}
