//
//  TaskListViewModel.swift
//  Syncly
//
//  Created by Punam Nandi on 03/10/26.
//

import Foundation

@MainActor
@Observable
final class TaskListViewModel {
    private let repository: TaskRepository
    
    var tasks: [Tasks] = []
    var isLoading = false
    var errorMessage: String?
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func loadTasks() async {
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
            tasks = try await repository.fetchTasks()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func addTask(title: String, description: String) async {
        do {
            let task = try await repository.createTask(
                title: title,
                description: description
            )
            
            tasks.insert(task, at: 0)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
