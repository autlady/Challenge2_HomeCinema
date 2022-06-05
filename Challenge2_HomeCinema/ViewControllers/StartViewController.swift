//
//  ViewController.swift
//  Challenge2_HomeCinema
//
//  Created by Даниил Кирьянчук on 30.05.2022.
//

import UIKit

var indexSection = 0

class StartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titles = ["Popular", "TV Shows", "Continue watching"]
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell") //регистрирую ячейку
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        setupButtonsBar()
        
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            if let destinationVC = segue.destination as? SecondViewController {
                let idMovie = sender as? Int
                destinationVC.idMovie = idMovie ?? 0
            }
        }
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
        
        indexSection = indexPath.section //Временная переменная для хранения текущего номера секции
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.view.bounds.height/3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! HeaderView
        view.titleLabel.text = titles[section]
        return view
    }
}

//MARK: - DidClickCellDelegate

extension StartViewController: DidClickCellDelegate {
    func didClickCell(_ cell: TableViewCell, id: Int) {
        self.performSegue(withIdentifier: "goToDetail", sender: id)
        //print("goToDetail - \(id)")
    }
}

