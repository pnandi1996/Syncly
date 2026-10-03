//
//  SynclyApp.swift
//  Syncly
//
//  Created by Punam Nandi on 03/10/26.
//

import SwiftUI
import SwiftData

@main
struct SynclyApp: App {
    private let persistenceController: PersistenceController

    init() {
        let persistenceController = PersistenceController()

        self.persistenceController = persistenceController
    }

    var body: some Scene {
        WindowGroup {
            ContentView(
                repository: SwiftDataTaskRepository(
                    modelContext: persistenceController.container.mainContext
                )
            )
        }
        .modelContainer(persistenceController.container)
    }
}
