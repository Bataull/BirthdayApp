import UIKit

final class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    private let mainView = UIView()
    private let stackView = UIStackView()
    private let nameAndSurnameLabel = UILabel()
    private let birthdayDateLabel = UILabel()
    
    override init(style:UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        addConstraints()
        addSetup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubview() {
        contentView.addSubview(mainView)
        mainView.addSubview(stackView)
        stackView.addArrangedSubview(nameAndSurnameLabel)
        stackView.addArrangedSubview(birthdayDateLabel)
    }
    
    private func addConstraints() {
        
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        
    }
    
    private func addSetup() {
        self.backgroundColor = .clear
    
        mainView.backgroundColor = .clear
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 26
        stackView.layer.masksToBounds = true
        
        nameAndSurnameLabel.textColor = .black
        nameAndSurnameLabel.numberOfLines = 2
        nameAndSurnameLabel.textAlignment = .center
        
        birthdayDateLabel.textColor = .black
        birthdayDateLabel.textAlignment = .center
    
        
    }
    
    func configure(with friend: Friend) {
        if let name = friend.name, let surname = friend.surname {
            nameAndSurnameLabel.text = "\(name) \(surname)"
        } else {
            nameAndSurnameLabel.text = "Error"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        if let birthdayDate = friend.date {
            birthdayDateLabel.text = "\(dateFormatter.string(from: birthdayDate))"
        } else {
            birthdayDateLabel.text = "Error"
        }
    }
}
