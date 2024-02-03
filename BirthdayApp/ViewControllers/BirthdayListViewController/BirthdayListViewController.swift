import UIKit

class BirthdayListViewController: UIViewController {
    
    private let mainTableView = UITableView()
    
    var viewModel: BirthdayListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        addNavigationControllerSetup()
        
        viewModel = DefaultBirthdayListViewModel()
        if let viewModel = viewModel as? DefaultBirthdayListViewModel {
            viewModel.setNavigationController(self.navigationController)
        }
    }
    
    private func addSubviews() {
        view.addSubview(mainTableView)
    }
    
    private func addConstraints() {
        
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
    }
    
    private func addNavigationControllerSetup() {
        view.backgroundColor = .systemGray5
        
        title = "Birthdays List"
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc private func deleteButtonTapped() {
        viewModel.deleteButtonTapped()
    }
    
    @objc private func addButtonTapped() {
        viewModel.addButtonTapped()
    }
}

//extension BirthdayListViewController: UITabBarDelegate , UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//}
