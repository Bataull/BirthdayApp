import UIKit

protocol BirthdayListViewModel: AnyObject {
    
    func setNavigationController(_ navigationController: UINavigationController?)
    func deleteButtonTapped()
    func addButtonTapped()
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
}
