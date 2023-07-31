////
////  ViewController.swift
////  ReqResApiSingleUser
////
////  Created by Sainath Bamen on 19/07/23.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//    var list = [Datas]()
//
//    @IBOutlet weak var myTableview: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        fetchData()
//    }
//    func fetchData(){
//        let url = URL(string: "https://reqres.in/api/users/2")
//        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {
//            (data, response, error) in
//            print(data)
//            guard let data = data, error == nil
//            else{
//                print("Error Occured While Accessing Data")
//                return
//            }
//            var cList = [Datas]()
//
//            do{
//                cList = try JSONDecoder().decode(Datas.self, from: data)
//            }
//            catch{
//                print("Error While Accesing Data \(error)")
//            }
//            self.list = cList
//        })
//        dataTask.resume()
//    }
//}
//
//extension ViewController:UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = myTableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
//        cell.myLabel2.text = list[indexPath.count].email
//
//
//        return cell
//    }
//
//
//
//}


import UIKit

struct UserData: Codable {
    let data: User
    let support : Support
    
}


struct User: Codable {
    let id: Int
    let email: String
    let first_name:String
    let last_name:String
    
    // Add other properties as needed
}

struct Support:Codable{
    let url:String
    let text:String
}

class ViewController: UIViewController {
    var user: UserData?

    @IBOutlet weak var myTableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    func fetchData() {
        let url = URL(string: "https://reqres.in/api/users/2")
        let dataTask = URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            guard let self = self, let data = data, error == nil else {
                print("Error Occurred While Accessing Data")
                return
            }

            do {
                let responseData = try JSONDecoder().decode(UserData.self, from: data)
                self.user = responseData
                DispatchQueue.main.async {
                    self.myTableview.reloadData()
                }
            } catch {
                print("Error While Accessing Data \(error)")
            }
        }
        dataTask.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user == nil ? 0 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.myLabel2.text = user?.data.email
        cell.myLabel2.text = user?.data.first_name
        cell.myLabel2.text = user?.data.email
        //cell.myLabel2.text = user?.id
        cell.myLabel2.text = user?.support.url
        return cell
    }
}
