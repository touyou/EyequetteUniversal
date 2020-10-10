//
//  PersistentStore.swift
//  EyequetteUniversal
//
//  Created by 藤井陽介 on 2020/10/10.
//

import SwiftUI
import CoreData

class PersistentStore: ObservableObject {

    var context: NSManagedObjectContext { persistentContainer.viewContext }

    static let shared = PersistentStore()

    private init() {}

    private let persistentStoreName: String = "Eyequette"

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: persistentStoreName)

        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No Descriptions found")
        }
        description.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        NotificationCenter.default.addObserver(self, selector: #selector(processUpdate), name: .NSPersistentStoreRemoteChange, object: nil)

        return container
    }()

    var operationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    @objc func processUpdate(_ notification: Notification) {
//        operationQueue.addOperation {
//            let context = self.persistentContainer.newBackgroundContext()
//            context.performAndWait {
//
//            }
//        }
    }

    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                fatalError("Unresolved errro \(error)")
            }
        }
    }
}
