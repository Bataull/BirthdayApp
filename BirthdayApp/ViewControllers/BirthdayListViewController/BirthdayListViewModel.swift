import UIKit
import CoreData

protocol BirthdayListViewModel: AnyObject {
    
    func setNavigationController(_ navigationController: UINavigationController?)
    func deleteButtonTapped()
    func addButtonTapped()
    func loadFriendsData(completion: @escaping (Result<[Friend], CoreDataError>) -> Void)
}

final class DefaultBirthdayListViewModel: BirthdayListViewModel {
    
    private var navigationController: UINavigationController?
    
    
    func setNavigationController(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func deleteButtonTapped() {
        
    }
    
    func addButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let newInfoVC = storyboard.instantiateViewController(withIdentifier: NewInfoViewController.identifier) as? NewInfoViewController {
            navigationController?.pushViewController(newInfoVC, animated: true)
        }
    }
    
    func loadFriendsData(completion: @escaping (Result<[Friend], CoreDataError>) -> Void) {
        let result = CoreDataManager.instance.loadFriend()
        switch result {
        case .success(let friends):
            print("Loaded friends count: \(friends.count)")
            completion(.success(friends))
        case .failure(let error):
            print("Error loading friends: \(error)")
            completion(.failure(error))
        }
    }
}
