//
//  CombinedChartVC.swift
//  ChartsUnderstandAndUsage
//
//  Created by 张海峰 on 2018/9/17.
//  Copyright © 2018年 张海峰. All rights reserved.
//
//Charts框架地址
//https://github.com/danielgindi/Charts.git
//该demo地址
//https://github.com/FighterLightning/ChartsUnderstandAndUsage.git
/*组合图*/
import UIKit
import Charts
class CombinedChartVC: UIViewController {
    let months = ["Jan", "Feb", "Mar",
                  "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep",
                  "Oct", "Nov", "Dec"]
    var combinedChartView: CombinedChartView  = CombinedChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZHFColor.white
        //1.添加混合图和刷新按钮
        addCombinedChartAndRefreshBtn()
        //2.基本样式
         setCombinedChartViewBaseStyle()
        //3.添加（刷新数据）
        updataData()
    }
}
//MARK:- UI和组合图基本样式
extension CombinedChartVC{
    //添加组合线图和刷新按钮
    func addCombinedChartAndRefreshBtn(){
        combinedChartView.backgroundColor = ZHFColor.white
        combinedChartView.frame.size = CGSize.init(width: 300, height: 300)
        combinedChartView.center = self.view.center
        combinedChartView.delegate = self
        self.view.addSubview(combinedChartView)
        //添加刷新按钮
        let btn: UIButton = UIButton.init(type: UIButtonType.custom)
        btn.frame = CGRect.init(x: 30, y: 84, width: 40, height: 25)
        btn.setTitle("刷新", for: UIControlState.normal)
        btn.backgroundColor = ZHFColor.red
        btn.setTitleColor(ZHFColor.zhf33_titleTextColor, for: UIControlState.normal)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(updataData), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btn)
    }
    func setCombinedChartViewBaseStyle(){
        //混合图描述
        combinedChartView.chartDescription?.text = "混合图描述"
        combinedChartView.chartDescription?.position = CGPoint.init(x: combinedChartView.frame.width - 30, y:10)//位置（及在lineChartView的中心点）
        combinedChartView.chartDescription?.font = UIFont.systemFont(ofSize: 12)//大小
        combinedChartView.chartDescription?.textColor = UIColor.red
       
        //图例
        let l = combinedChartView.legend
        l.wordWrapEnabled = false //显示图例
        l.horizontalAlignment = .center //居中
        l.verticalAlignment = .bottom //放在底部
        l.orientation = .horizontal //水平排布
        l.drawInside = false // 图例在外
        l.formSize = 10 //（图例大小）默认是8
        l.form = Legend.Form.circle//图例头部样式
        //矩形：.square（默认值） 圆形：.circle   横线：.line  无：.none 空：.empty（与 .none 一样都不显示头部，但不同的是 empty 头部仍然会占一个位置)
        //Y轴右侧线
        let rightAxis = combinedChartView.rightAxis
        rightAxis.axisMinimum = 0
        //Y轴左侧线
        let leftAxis = combinedChartView.leftAxis
        leftAxis.axisMinimum = 0
        //X轴
        let xAxis = combinedChartView.xAxis
        xAxis.labelPosition = .bothSided //分布在两边外部
        xAxis.axisMinimum = 0 //最小刻度值
        xAxis.granularity = 1 //最小间隔
        xAxis.valueFormatter = self
    }
}
//MARK:-    数据加载和刷新
extension CombinedChartVC{
    @objc func updataData(){
        //各类型图表的显示次序（后面的覆盖前面的）
        combinedChartView.drawOrder = [DrawOrder.bar.rawValue,
                               DrawOrder.bubble.rawValue,
                               DrawOrder.line.rawValue,
                               DrawOrder.scatter.rawValue,
                               DrawOrder.candle.rawValue]
        
        //组合图数据
        let chartData = CombinedChartData()
        chartData.barData = generateBarData() //柱形图数据
        chartData.lineData = generateLineData() //线状图数据
        chartData.scatterData = generateScatterData() //
        chartData.bubbleData = generateBubbleData()
        chartData.candleData = generateCandleData() //烛形图（股票线）
        //设置组合图数据
        combinedChartView.xAxis.axisMaximum = chartData.xMax + 0.25
        combinedChartView.data = chartData
    }
    //柱状图数据
    func generateBarData() -> BarChartData {
        // 第一根柱
        //10条随机数据
        var dataEntries1 = [BarChartDataEntry]()
        for i in 0..<10 {
            let y = arc4random()%100 + 100
            let entry = BarChartDataEntry(x: Double(i), y: Double(y))
            dataEntries1.append(entry)
        }
        //这10条数据作为柱状图的所有数据
        let chartDataSet1 = BarChartDataSet(values: dataEntries1, label: "柱状图1")
        chartDataSet1.valueFont = UIFont.systemFont(ofSize: 10)
        chartDataSet1.colors = [.orange] //使用橙色
        chartDataSet1.axisDependency = .left //依赖左侧轴
        chartDataSet1.drawValuesEnabled = false //不带文字
        // 第二根柱
        //生成10条随机数据
        var dataEntries2 = [BarChartDataEntry]()
        for i in 0..<10 {
            let y = arc4random()%50 + 50
            let y1 = arc4random()%50 + 50
            let entry = BarChartDataEntry.init(x: Double(i), yValues: [Double(y),Double(y1)])
            dataEntries2.append(entry)
        }
        //这10条数据作为柱状图的所有数据
        let chartDataSet2 = BarChartDataSet(values: dataEntries2, label: "柱状图2")
        chartDataSet2.stackLabels = ["Stack 1", "Stack 2"]
        chartDataSet2.valueFont = UIFont.systemFont(ofSize: 10)
        chartDataSet2.colors = [.red,.orange] //使用红色
        chartDataSet2.axisDependency = .left //依赖左侧轴
        chartDataSet2.drawValuesEnabled = false //不带文字
        //目前柱状图只包括1组立柱
        let chartData = BarChartData(dataSets: [chartDataSet1,chartDataSet2])
        let groupSpace = 0.06 //组与组之间的空间比
        let barSpace = 0.02 // 一组内两柱之间空间比
        let barWidth = 0.45 // 一组内每个柱宽空间比
        // (0.45 + 0.02) * 2 + 0.06 = 1.00 -> interval per "group"
        chartData.barWidth = barWidth
        // make this BarData object grouped
        chartData.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        return chartData
    }
    //折线图数据
    func generateLineData() -> LineChartData {
        //生成10条随机数据
        var dataEntries = [ChartDataEntry]()
        for i in 0..<10 {
            let y = arc4random()%100
            let entry = ChartDataEntry(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这10条数据作为折线图的所有数据
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "折线图")
        chartDataSet.setColor(ZHFColor.zhf_randomColor())//折线颜色
        chartDataSet.lineWidth = 2.5
        chartDataSet.setCircleColor(ZHFColor.red)
        chartDataSet.circleRadius = 5 //外圆半径
        chartDataSet.circleHoleColor = ZHFColor.yellow
        chartDataSet.circleHoleRadius = 2.5 //内圆半径
//        chartDataSet.drawFilledEnabled = true //开启填充色绘制
//        chartDataSet.fillColor = ZHFColor.zhf_randomColor()
//        chartDataSet.fillAlpha = 0.5 //设置填充色透明度
        
        chartDataSet.mode = .cubicBezier //折线是bezier曲线
        chartDataSet.drawValuesEnabled = true //带文字
        chartDataSet.valueFont = .systemFont(ofSize: 10)
        chartDataSet.valueTextColor = ZHFColor.zhf_randomColor()
        chartDataSet.axisDependency = .left//依赖左侧轴
        
        //目前柱状图只包括1组折线
        let chartData = LineChartData(dataSets: [chartDataSet])
        return chartData
    }
    //生成散点图数据
    func generateScatterData() -> ScatterChartData {
        //生成10条随机数据
        let dataEntries = (0..<10).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(100) + 150)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let chartDataSet = ScatterChartDataSet(values: dataEntries, label: "散点图")
        chartDataSet.colors = [ChartColorTemplates.material()[0]]
        chartDataSet.scatterShapeSize = 8 //(默认是10)
        chartDataSet.drawValuesEnabled = false
        //目前散点图包括1组数据
        let chartData = ScatterChartData(dataSets: [chartDataSet])
        return chartData
    }
    //生成气泡图数据
    func generateBubbleData() -> BubbleChartData {
        //生成10条随机数据
        let dataEntries = (0..<10).map { (i) -> BubbleChartDataEntry in
            let val = Double(arc4random_uniform(100) + 300)
            //气泡大小
            let size = CGFloat(arc4random_uniform(10))
            return BubbleChartDataEntry(x: Double(i), y: val, size: size)
        }
        let chartDataSet = BubbleChartDataSet(values: dataEntries, label: "气泡图")
        chartDataSet.colors = [ChartColorTemplates.material()[1]]
        chartDataSet.valueTextColor = .white
        chartDataSet.valueFont = .systemFont(ofSize: 10)
        chartDataSet.drawValuesEnabled = true //是否显示气泡上的数字
        //目前气泡图包括1组数据
        let chartData = BubbleChartData(dataSets: [chartDataSet])
        return chartData
    }
    //生成烛形图数据
    func generateCandleData() -> CandleChartData {
        //生成10条随机数据
        let dataEntries = (0..<10).map { (i) -> CandleChartDataEntry in
            let val = Double(arc4random_uniform(100) + 10 + 400)
            let high = Double(arc4random_uniform(20) + 8)
            let low = Double(arc4random_uniform(20) + 8)
            let open = Double(arc4random_uniform(20) + 1)
            let close = Double(arc4random_uniform(20) + 1)
            let even = arc4random_uniform(2) % 2 == 0 //true表示开盘价高于收盘价
            return CandleChartDataEntry(x: Double(i),
                                        shadowH: val + high,
                                        shadowL: val - low,
                                        open: even ? val + open : val - open,
                                        close: even ? val - close : val + close)
        }
        let chartDataSet = CandleChartDataSet(values: dataEntries, label: "烛形图")
        chartDataSet.setColor(ChartColorTemplates.material()[2])
        chartDataSet.shadowColor = .darkGray //柱线（烛心线）颜色
        chartDataSet.decreasingColor = ZHFColor.green //实心颜色
        chartDataSet.increasingColor = ZHFColor.red //空心颜色
        //目前烛形图包括1组数据
        let chartData = CandleChartData(dataSets: [chartDataSet])
        return chartData
    }
}
//MARK:-   ChartViewDelegate
extension CombinedChartVC: ChartViewDelegate,IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
       return months[Int(value) % months.count]
    }
    //1.点击选中
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        ZHFLog(message: "点击选中")
    }
    //2.没有选中
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        ZHFLog(message: "没有选中")
    }
    //3.捏合放大或缩小
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        ZHFLog(message: "捏合放大或缩小")
    }
    //4.拖拽图表
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        ZHFLog(message: "拖拽图表")
    }
}
