//
//  BaseViewModel.swift
//  
//
//  Created by Alper Ozturk on 31.7.23..
//

import Foundation

open class BaseViewModel: ObservableObject {
    public init() {}
    
    @Published public var state = ViewState.Initial
    private var task: Task<Void, Never>?
    
    public func startTask(priority: TaskPriority = .userInitiated, _ action: @escaping () async throws -> (), handleError: @escaping (Error) async -> ()) {
        task = Task(priority: priority) { [weak self] in
            do {
                try await action()
            
                self?.cleanupTask()
            } catch {
                await handleError(error)
            }
        }
    }
    
    private func cleanupTask() {
        self.task?.cancel()
        self.task = nil
    }
    
    deinit {
        cleanupTask()
    }
}
