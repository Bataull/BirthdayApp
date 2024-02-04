import UIKit

protocol NewInfoViewModel: AnyObject {
    func setNavigationController(_ navigationController: UINavigationController?)
    func saveButtonTapped(name: String, surname: String, date: Date)
}

final class DefaultNewInfoViewModel: NewInfoViewModel {
    
    private var navigationController: UINavigationController?
    private let coreDataManager: CoreDataManager
    
    
    init(coreDataManager: CoreDataManager) {
            self.coreDataManager = coreDataManager
        }
    
    func setNavigationController(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func saveButtonTapped(name: String, surname: String, date: Date) {
        coreDataManager.saveFriend(name: name, surname: surname, date: date) { result in
            switch result {
            case .success:
                print("Friend Saved")
                
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print("Не удалось сохранить друга: \(error)")
            }
        }
    }
}
