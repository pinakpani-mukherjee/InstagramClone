//
//  ViewController.swift
//  InstagramClone
//
//  Created by Pinakpani Mukherjee on 2022/09/15.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    private var collectionView : UICollectionView?
    private var viewModels = [[HomeFeedCellType]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        configureCollectionView()
        fetchPosts()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        
    }
    
    private func fetchPosts() {
        // mock data
        let postData: [HomeFeedCellType] = [
            .poster(viewModel: PosterCollectionViewCellViewModel(
                username: "flowerman",
                profilePictureURL: URL(string: "https://www.1800flowers.com/blog/wp-content/uploads/2021/05/Birthday-Flowers-Colors.jpg")!)),
            .post(viewModel: PostCollectionViewCellViewModel(
                postURL: URL(string: "https://www.1800flowers.com/blog/wp-content/uploads/2021/05/Birthday-Flowers-Colors.jpg")!)),
            .actions(viewModel: PostActionsCollectionsViewCellViewModel(
                isLiked: true)),
            .likeCount(viewModel: PostLikesCollectionViewCellViewModel(
                likers: ["kappaman"])),
            .caption(viewModel: PostCaptionCollectionViewCellViewModel(
                username: "flowerman",
                caption: "Some Flowers and shit")),
            .timestamp(viewModel: PostDatetimeCollectionViewCellViewModel(
                date: Date()))
        ]
        viewModels.append(postData)
        collectionView?.reloadData()
    }
    
    //CollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = viewModels[indexPath.section][indexPath.row]
        switch cellType {
            
        case .poster(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PosterCollectionViewCell.identifier,
                for: indexPath
            ) as? PosterCollectionViewCell else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: viewModel)
            return cell

        case .post(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCollectionViewCell.identifier,
                for: indexPath
            ) as? PostCollectionViewCell else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: viewModel)
            cell.contentView.backgroundColor = .secondarySystemBackground
            return cell
        case .actions(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostActionsCollectionViewCell.identifier,
                for: indexPath
            ) as? PostActionsCollectionViewCell else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: viewModel)
            return cell
        case .likeCount(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostLikesCollectionViewCell.identifier,
                for: indexPath
            ) as? PostLikesCollectionViewCell else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: viewModel)
            return cell
        case .caption(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCaptionCollectionViewCell.identifier,
                for: indexPath
            ) as? PostCaptionCollectionViewCell else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: viewModel)
            return cell
        case .timestamp(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostDatetimeCollectionViewCell.identifier,
                for: indexPath
            ) as? PostDatetimeCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        }
    }
    
     
}
extension HomeViewController: PosterCollectionViewCellDelegate{
    func posterCollectionViewCellDidTapMore(_ cell: PosterCollectionViewCell) {
        let sheet = UIAlertController(title: "Post Actions", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Share Post", style: .default, handler:{ _ in
            
        }))
        sheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler:{ _ in
            
        }))
        present(sheet, animated: true)
    }
    func posterCollectionViewCellDidTapUsername(_ cell: PosterCollectionViewCell) {
        let vc = ProfileViewController(user: User(username: "flowerman", email: "flower@gmail.com"))
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController:PostCollectionViewCellDelegate{
    func postCollectionViewCellDidLike(_ cell: PostCollectionViewCell) {
        print("double tapped to like")
    }
}

extension HomeViewController:PostActionsCollectionViewCellDelegate{
    func postActionsCollectionViewCellDidTapShare(_ cell: PostActionsCollectionViewCell) {
        let vc = UIActivityViewController(activityItems: ["Sharing From Instagram"],
                                          applicationActivities: [])
        present(vc,animated: true)
    }
    func postActionsCollectionViewCellDidTapComment(_ cell: PostActionsCollectionViewCell) {
        let vc = PostViewController()
        vc.title = "Post"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func postActionsCollectionViewCellDidTapLike(_ cell: PostActionsCollectionViewCell, is_liked: Bool) {
        // Call DB to update like
    }
}
extension HomeViewController:PostLikesCollectionViewCellDelegate{
    func postLikesCollectionViewCellDidTapLikeCount(_ cell: PostLikesCollectionViewCell) {
        let vc = ListViewController()
        vc.title = "Liked By"
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension HomeViewController:PostCaptionCollectionViewCellDelegate{
    func postCaptionCollectionViewCellDidTapCaption(_ cell: PostCaptionCollectionViewCell) {
        print("tapped on caption")
    }
}


extension HomeViewController{
    private func configureCollectionView(){
        
        let sectionHeight: CGFloat = 240 + view.width
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { index, _ ->NSCollectionLayoutSection? in
            //Item
            let posterItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(60)
                )
            )
            
            let postItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1)
                )
            )
            let actionsItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(40)
                )
            )
            
            let likeCountItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(40)
                    )
                )
                
            let captionItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(60)
                    )
                )
                
                let timestampItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(40)
                    )
                )
            
            
            //Group
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(sectionHeight)),
                subitems: [posterItem,postItem,actionsItem,likeCountItem,captionItem,timestampItem])
            //Sections
            let section =  NSCollectionLayoutSection(group: group )
                section.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 0, bottom: 10, trailing: 0)
            return section
        })
        )
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PosterCollectionViewCell.self,
                                forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        collectionView.register(PostCollectionViewCell.self,
                                forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        collectionView.register(PostActionsCollectionViewCell.self,
                                forCellWithReuseIdentifier: PostActionsCollectionViewCell.identifier)
        collectionView.register(PostLikesCollectionViewCell.self,
                                forCellWithReuseIdentifier: PostLikesCollectionViewCell.identifier)
        collectionView.register(PostCaptionCollectionViewCell.self,
                                forCellWithReuseIdentifier: PostCaptionCollectionViewCell.identifier)
        collectionView.register(PostDatetimeCollectionViewCell.self,
                                forCellWithReuseIdentifier: PostDatetimeCollectionViewCell.identifier)
        self.collectionView = collectionView
    }
}

