//
//  EyequetteUniversalApp.swift
//  Shared
//
//  Created by 藤井陽介 on 2020/06/23.
//

import SwiftUI
import CoreData

@main
struct EyequetteUniversalApp: App {

    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var persistentStore = PersistentStore.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentStore.context)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
                case .active:
                    print("===active===")
                case .inactive:
                    print("===inactive===")
                case .background:
                    print("===background===")
                    savePersistentStore()
                @unknown default:
                    fatalError("Not supported phase")
            }
        }
    }

    func savePersistentStore() {
        persistentStore.save()
    }
}
