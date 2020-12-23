//
//  GameListViewController.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2020/12/16.
//

import Alamofire
import UIKit

class GameListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    let newGameListURL: String = "https://ec.nintendo.com/api/KR/ko/search/new?count=30&offset=0"
    //    let getGamePriceURL = "https://api.ec.nintendo.com/v1/price"
    var model: NewGameResponse? {
        didSet {
            tableView.reloadData() //세팅될떄마다 새로 업로드
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGameListApiCall()}
    private func newGameListApiCall() {
        AF.request(newGameListURL).responseJSON {[weak self] response in
            guard let data = response.data else { return }
            let decoder: JSONDecoder = JSONDecoder()
            let model: NewGameResponse? = try? decoder.decode(NewGameResponse.self, from: data)
            
            //            for content in model?.contents {
            //                getGamePriceApiCall(id: content.id)
            //            }
            self?.model = model
        }
    }
}

extension GameListViewController: UITableViewDelegate {
}
extension GameListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.contents.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameItemTableViewCell", for: indexPath) as? GameItemTableViewCell, let  content = model?.contents[indexPath.row] else { return UITableViewCell() }
        //스토리보드에 등록된 셀을 가져오는 것. 테이블뷰에 이미 등록되어 있는데 이를 가져오는 방법은 dequeReusableCell을 통해 가져온다
    
        let model: GameItemModel = GameItemModel(gameTitle: content.formalName, gameOriginPrice: 10_000, gameDiscountPrice: nil, imageURL: content.heroBannerURL, screenshots: content.screenshots)
        cell.setModel(model)
        return cell
    }
}