
import Foundation
import CoreData

protocol MovieDataManagerType {
    func saveNameOfMovie(with name: String)
    //func fetchTitles() -> [NSManagedObject]
}

class MovieDataManager {

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyMovies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension MovieDataManager: MovieDataManagerType {

    func saveNameOfMovie(with name: String) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Title", in: managedContext)!
        let movie = NSManagedObject(entity: entity, insertInto: managedContext)
        
        movie.setValue(name, forKey: "title")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
