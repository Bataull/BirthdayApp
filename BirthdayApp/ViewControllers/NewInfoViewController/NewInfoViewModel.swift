import UIKit

protocol NewInfoViewModel: AnyObject {
    func setNavigationController(_ navigationController: UINavigationController?)
    func saveButtonTapped()
}

final class DefaultNewInfoViewModel: NewInfoViewModel {
    
    private var navigationController: UINavigationController?
    
    func setNavigationController(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func saveButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
