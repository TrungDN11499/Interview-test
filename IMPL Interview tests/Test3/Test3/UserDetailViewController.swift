//
//  UserDetailViewController.swift
//  Test3
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

protocol SaveData: class {
    func saveData(indexPath: Int, data: UserModel)
}

class UserDetailViewController: UIViewController {
    weak var delegate: SaveData?
    var saveData: UserModel?
    
    var index: Int = 0
    var data: UserModel? {
        didSet {
            self.saveData = data
            self.nameTextField.text = data?.name
            self.emailTextField.text = data?.email
            self.phoneTextField.text = data?.phone
        }
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // name view
    let nameContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        return textField
    }()
    
    // email view
    let emailContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.borderStyle = .line
        return textField
    }()
    
    // phone view
    let phoneContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "phone"
        return label
    }()
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .phonePad
        textField.borderStyle = .line
        return textField
    }()
    
    // update button
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(handleUpdate(_:)), for: .touchUpInside)
        return button
    }()
    
    // reset button
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(handleReset(_:)), for: .touchUpInside)
        return button
    }()

    // view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        self.view.backgroundColor = .white
        
        // set up content view
        self.view.addSubview(self.contentView)
        self.contentView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        self.view.addVisualFormatConstraints(format: "H:|[v0]|", views: self.contentView)
        
        setUpStackView()
        setUpButtons()
    }
    
    private func setUpStackView() {
        // set up stack view
        self.contentView.addSubview(self.stackView)
        self.contentView.addVisualFormatConstraints(format: "H:|-15-[v0]-15-|", views: self.stackView)
        
        // set up name view
        self.stackView.addArrangedSubview(self.nameContentView)
        setUpNameView()
        
        // set up email view
        self.stackView.addArrangedSubview(self.emailContentView)
        setUpEmailView()
        
        // set up phone view
        self.stackView.addArrangedSubview(self.phoneContentView)
        setUpPhoneView()
    }
    
    private func setUpNameView() {
        // name label constraints
        self.nameContentView.addSubview(self.nameLabel)
        self.nameContentView.addVisualFormatConstraints(format: "H:|[v0]|", views: self.nameLabel)
        
        // name text field constraint
        self.nameContentView.addSubview(self.nameTextField)
        self.nameContentView.addVisualFormatConstraints(format: "H:|[v0]|", views: self.nameTextField)
        
        self.nameContentView.addVisualFormatConstraints(format: "V:|[v0]-5-[v1(45)]|", views: self.nameLabel, nameTextField)
    }
    
    private func setUpEmailView() {
        // email label constraints
        self.emailContentView.addSubview(self.emailLabel)
        self.emailContentView.addVisualFormatConstraints(format: "H:|[v0]|", views: self.emailLabel)
        
        // email text field constraint
        self.emailContentView.addSubview(self.emailTextField)
        self.emailContentView.addVisualFormatConstraints(format: "H:|[v0]|", views: self.emailTextField)
        
        self.emailContentView.addVisualFormatConstraints(format: "V:|[v0]-5-[v1(45)]|", views: self.emailLabel, emailTextField)
    }
    
    private func setUpPhoneView() {
        // email label constraints
        self.phoneContentView.addSubview(self.phoneLabel)
        self.phoneContentView.addVisualFormatConstraints(format: "H:|[v0]|", views: self.phoneLabel)
        
        // email text field constraint
        self.phoneContentView.addSubview(self.phoneTextField)
        self.phoneContentView.addVisualFormatConstraints(format: "H:|[v0]|", views: self.phoneTextField)
        
        self.phoneContentView.addVisualFormatConstraints(format: "V:|[v0]-5-[v1(45)]|", views: self.phoneLabel, phoneTextField)
    }
    
    private func setUpButtons() {
        // set up update button constraints
        self.contentView.addSubview(self.updateButton)
        self.contentView.addVisualFormatConstraints(format: "H:|-15-[v0]-15-|", views: self.updateButton)
        
        // set up reset button constraints
        self.contentView.addSubview(self.resetButton)
        self.contentView.addVisualFormatConstraints(format: "H:|-15-[v0]-15-|", views: self.resetButton)
        
        // content view vertical constraints
        self.contentView.addVisualFormatConstraints(format: "V:|[v0]-8-[v1(45)]-8-[v2(45)]|", views: self.stackView, self.updateButton, self.resetButton)
        
        DispatchQueue.main.async {
            self.resetButton.layer.cornerRadius = 6
            self.updateButton.layer.cornerRadius = 6
        }
        
        self.addInputAccessoryForTextFields(textFields: [nameTextField, emailTextField, phoneTextField], dismissable: true, previousNextable: true)
    }
    
    // MARK: - Action
    @objc private func handleUpdate(_ sender: UIButton) {
        guard let name = self.nameTextField.text else { return }
        guard let email = self.emailTextField.text else { return }
        guard let phone = self.phoneTextField.text else { return }
        
        if !name.isValidName() {
            self.showAlert(title: "Thông báo", message: "tên phải có tối thiểu 4 ký tự và tối đa 20 ký tự")
            return
        } else if !email.isEmail {
            self.showAlert(title: "Thông báo", message: "email sai định dạng")
            return
        } else if !phone.isPhoneNumber {
            self.showAlert(title: "Thông báo", message: "Số điện thoại sai định dạng")
            return
        }
        
        if name != self.saveData?.name || email != self.saveData?.email || phone != self.saveData?.phone {
            self.delegate?.saveData(indexPath: self.index, data: UserModel(name: name, email: email, phone: phone, createdAt: self.saveData?.createdAt ?? ""))
            self.navigationController?.popViewController(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func handleReset(_ sender: UIButton) {
        self.nameTextField.text = self.saveData?.name
        self.emailTextField.text = self.saveData?.email
        self.phoneTextField.text = self.saveData?.phone
    }
}
