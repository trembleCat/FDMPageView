# FDMPageView   
    
FDMPageView（轻量级父子控制器）
    
注：标题选项控件使用[JXSegmentedView](https://github.com/pujiaxin33/JXSegmentedView)的基础Title，感谢[pujiaxin33](https://github.com/pujiaxin33)提供的技术支持   
    
   
### 说明  ------------------------------------------------------------------------
    
    
 - 使用时会将所有控制器视图添加到主控件上，不会造成滑动白屏的现象   
 - 可以随意增加或删除某个页面    
 - 使用方法类似UIView，简单快速   
 - 文字颜色大小等属性请查看segmentedDataSource   
 - 在修改内部属性后需调用刷新方法 - func reloadView(  )  
      
     
### 快速初始化   ------------------------------------------------------------------  
  
```swift     
    class ViewController: UIViewController {  
        let subVCArray = [SubVCOne(),SubVCThree(),SubVCTwo()]  
        var titleArray = ["one","three","two"]  
        
        override func viewDidLoad() {  
        super.viewDidLoad()    
        
        let pageV = FDMPageView()  
        self.view.addSubview(pageV)
        pageV.frame = CGRect(x: 100, y: 100, width: 300, height: 500)  
        pageV.initWithJXPagingView(target: self, titleArray: self.titleArray, controllerArray: self.subVCArray)  
          
        }  
    }  
```
      
### 主要方法列表   ---------------------------------------------------------------   
    
```swift 
    初始化  
        func initWithJXPagingView(target:UIViewController,titleArray:Array<String>,controllerArray:Array<UIViewController>)   
    刷新控件   
        func reloadView()    
    设置选中页面  
        func selectIndex(index:Int)  
    删除某个页面        
        func removeControllerWith(Index index:Int)  
    添加一个页面在最后   
        func addControllerForLast(controller:UIViewController,title:String)       
    重新添加所有页面    
        func addAllController(titleArray:Array<String>,controllerArray:Array<UIViewController>)  
        
    滚动时会调用该闭包    
        func pageViewDidScroll(_ item:@escaping segmentedDidScroll)  
    点击选中的情况才会调用该闭包   
        func pageViewDidClick(_ item:@escaping segmentedItem)    
    滚动选中的情况才会调用该闭包   
        func pageViewDidScrollClick(_ item:@escaping segmentedItem)  
    点击选中或者滚动选中都会调用该闭包    
        func pageViewDidSelected(_ item:@escaping segmentedItem)   
```
   
### 萌新iOS开发者，欢迎报bug  -----------------------------------------------    
  
<img src="https://github.com/trembleCat/FDMPageView/blob/master/LOOKME.jpg" width="300" height="500" alt="截图"/>    
  

