//
//  SecondViewController.swift
//  Challenge2_HomeCinema
//
//  Created by Даниил Кирьянчук on 31.05.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .black
        actorCollectionView.dataSource = self
        actorCollectionView.delegate = self
        actorCollectionView.register(ActorsCollectionViewCell.self, forCellWithReuseIdentifier: "ActorsCollectionViewCell") //регистрирую ячейку
        
    }
}

extension SecondViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // настраиваю размер ячеек
        let width = (collectionView.bounds.width - sideInset * 3) / 4
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        // настраиваю отступы между ячейками
        sideInset
    }
}

extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        // количество ячеек
        12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // создаю ячейку

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorsCollectionViewCell", for: indexPath) as! ActorsCollectionViewCell
        cell.setupCell()
        return cell
    }
}
