//
//  CaptionViewController.swift
//  InstagramClone
//
//  Created by Pinakpani Mukherjee on 2022/09/15.
//

import UIKit

class CaptionViewController: UIViewController {

    private let image:UIImage
    
    init(image:UIImage){
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder:NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
}
