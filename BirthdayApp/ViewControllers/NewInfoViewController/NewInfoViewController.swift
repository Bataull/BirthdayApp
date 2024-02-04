import UIKit
import CoreData

class NewInfoViewController: UIViewController {
    
    static let identifier = "NewInfoViewController"
    
    private let secondTitleLabel = UILabel()
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let datePicker = UIDatePicker()
    private let saveButton = UIButton()
    
    var viewModel: NewInfoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        addSetups()
        
        let coreDataManager = CoreDataManager.instance
        viewModel = DefaultNewInfoViewModel(coreDataManager: coreDataManager)
        if let viewModel = viewModel as? DefaultNewInfoViewModel {
            viewModel.setNavigationController(self.navigationController)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameTextField.layer.cornerRadius = nameTextField.frame.height / 2
        surnameTextField.layer.cornerRadius = surnameTextField.frame.height / 2
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
    
    private func addSubviews() {
        view.addSubview(secondTitleLabel)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(datePicker)
        view.addSubview(saveButton)
    }
    
    private func addConstraints() {
        
        secondTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        secondTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        secondTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        secondTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: secondTitleLabel.bottomAnchor, constant: 20).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        surnameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 30).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func addSetups() {
        view.backgroundColor = .systemGray5
        
        title = "New info"
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.backgroundColor = .clear
        
        secondTitleLabel.text = "Enter some information below:"
        secondTitleLabel.textAlignment = .center
        secondTitleLabel.font = UIFont.systemFont(ofSize: 22)
        
        nameTextField.placeholder = "Name"
        nameTextField.textAlignment = .center
        nameTextField.backgroundColor = .white
        
        surnameTextField.placeholder = "Surname"
        surnameTextField.textAlignment = .center
        surnameTextField.backgroundColor = .white
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        saveButton.backgroundColor = .white
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped() {
        guard let name = nameTextField.text,
          let surname = surnameTextField.text
        else {
            return
        }
        let selectedDate = datePicker.date

        viewModel.saveButtonTapped(name: name, surname: surname, date: selectedDate)
    }
}
