//
//  ViewController.swift
//  Challenge2_HomeCinema
//
//  Created by Даниил Кирьянчук on 30.05.2022.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    //    var films: [Film] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell") //регистрирую ячейку
        setupButtonsBar()
        
        
    }
    
    private lazy var titleView: UILabel = { // создаю лейбл
        let label = UILabel()
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "some"
        label.textColor = .white
        return label
    }()
    
    private lazy var buttonsBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = .red
        view.clipsToBounds = true
                
        return view
    }()
    
    private func setupButtonsBar() {
        self.view.addSubview(buttonsBar)

        buttonsBar.layer.shadowColor = UIColor.white.cgColor
        buttonsBar.layer.shadowOffset = CGSize(width: 0, height: 10)
        buttonsBar.layer.shadowRadius = 20
        buttonsBar.layer.shadowOpacity = 0.3
        buttonsBar.layer.masksToBounds = false
        
        NSLayoutConstraint.activate([
            buttonsBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.bounds.height * 0.06),
            buttonsBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width/5),
            buttonsBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width/5),
            buttonsBar.topAnchor.constraint(equalTo: view.topAnchor,  constant: view.bounds.height * 0.88)
        
        ])
    }
    
}

extension StartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // количество рядов у таблицы
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //создаем ячейку

        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.view.bounds.height/3
    }

    // почему-то не работает с первым и вторым хидером
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        switch section {
        case 0:
            let header = titleView
            header.text = "Popular"
            return header
        case 1:
            let header = titleView
            header.text = "TV Shows"
            return header
        case 2:
            let header = titleView
            header.text = "Continue watching"
            return header
        default:
            return titleView
        }

    }
    
}

