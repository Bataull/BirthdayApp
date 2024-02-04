import UIKit
import CoreData

class BirthdayListViewController: UIViewController {
    
    private let mainTableView = UITableView()
    private var friendsInfo: [Friend] = []

    var viewModel: BirthdayListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        addNavigationControllerSetup()

        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        
        viewModel = DefaultBirthdayListViewModel()

        viewModel.loadFriendsData { [weak self] result in
            switch result {
            case .success(let friends):
                print("Successfully loaded friends in view controller. Count: \(friends.count)")
                self?.friendsInfo = friends
                self?.mainTableView.reloadData()
                self?.scheduleBirthdayNotificationsForToday()
            case .failure(let error):
                print("Error loading friends in view controller: \(error)")
            }
        }
        
        if let viewModel = viewModel as? DefaultBirthdayListViewModel {
            viewModel.setNavigationController(self.navigationController)
        }
    }
    
    private func addSubviews() {
        view.addSubview(mainTableView)
    }
    
    private func addConstraints() {
        
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func addNavigationControllerSetup() {
        view.backgroundColor = .systemGray5
        mainTableView.backgroundColor = .clear
        mainTableView.separatorStyle = .none
        
        title = "Birthdays List"
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    private func scheduleBirthdayNotificationsForToday() {
            let today = Date()
            let friendsWithBirthdayToday = friendsInfo.filter { Calendar.current.isDate($0.date ?? Date(), inSameDayAs: today) }
            for friend in friendsWithBirthdayToday {
                BirthdayNotificationManager.shared.scheduleBirthdayNotification(for: friend)
            }
        }
    
    @objc private func deleteButtonTapped() {
        viewModel.deleteButtonTapped()
    }
    
    @objc private func addButtonTapped() {
        viewModel.addButtonTapped()
    }
}

extension BirthdayListViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = mainTableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell {
            let friend = friendsInfo[indexPath.row]
            cell.configure(with: friend)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    
}
