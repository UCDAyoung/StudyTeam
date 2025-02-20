//
//  CoreDataManager.swift
//  StudyMemo
//
//  Created by 탁제원 on 2021/09/15.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared: CoreDataManager = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Memo")
        container.loadPersistentStores(completionHandler: { (storeDesciption, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var memoList = [Memo]()
    
    //데이터 저장
    // text 매개변수 : memo 내용, 저장됨
    // category, deleted date 추가하면 좋을 듯!
    func saveContext(text: String) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Memo", in: context)
        let newMemo = Memo(entity: entity!, insertInto: context)
        
        newMemo.memo = text
        
        do {
            try context.save()
            memoList.append(newMemo)
            print(memoList)
        }
        catch {
            print("context error")
        }
    }
    
//    func saveCategory(category: String){
//        let context = persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Memo", in: context)
//        let newMemo = Memo(entity: entity!, insertInto: context)
//    }
    

    //데이터 삭제하기 바꿔야해요!!!
    func deleteMemo(_ memo: Memo?) {
        if let memo = memo {
            mainContext.delete(memo)
//            saveContext(text: memo)
        }
    }

}
