//
//  ContentView.swift
//  Syncly
//
//  Created by Punam Nandi on 03/10/26.
//

//import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}


import SwiftUI

struct ContentView: View {
    @State private var viewModel: TaskListViewModel

    init(repository: TaskRepository) {
        _viewModel = State(
            initialValue: TaskListViewModel(
                repository: repository
            )
        )
    }

    var body: some View {
        NavigationStack {
            List(viewModel.tasks) { task in
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.headline)

                    Text(task.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Syncly")
            .toolbar {
                Button {
                    Task {
                        await viewModel.addTask(
                            title: "Learn Offline-First",
                            description: "Build Syncly"
                        )
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
            .task {
                await viewModel.loadTasks()
            }
        }
    }
}
