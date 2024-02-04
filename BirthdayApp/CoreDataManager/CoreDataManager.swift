import UIKit
import CoreData

enum CoreDataError: Error {
    case error(String)
}

final class CoreDataManager {
    
    static let instance = CoreDataManager()
    private init() { }
    
    func saveFriend(name: String , surname: String , date: Date , completion: @escaping (Result<Void, CoreDataError>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(.failure(.error("AppDelegate Error")))
            return
        }
        let managedContent = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Friend", in: managedContent)!
        let friend = NSManagedObject(entity: entity, insertInto: managedContent)
        
        friend.setValue(name, forKey: "name")
        friend.setValue(surname, forKey: "surname")
        friend.setValue(date, forKey: "date")
        
        do {
            try managedContent.save()
            completion(.success(()))
        } catch {
            completion(.failure(.error("Не удалось сохранить")))
        }
    }
    
    func loadFriend() -> Result<[Friend], CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.error("AppDelegate Error"))
        }
        
        let managerContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Friend>(entityName: "Friend")
        
        do {
            let object = try managerContext.fetch(fetchRequest)
            print("Loaded friends: \(object)")
            return . success(object)
        } catch {
            print("Error loading friends: \(error)")
            return .failure(.error("Error"))
        }
    }
}
