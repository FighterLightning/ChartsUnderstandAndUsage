# ChartsUnderstandAndUsage
## 这是一个对图形框架Charts的理解使用demo(后续会根据自己理解，持续更新)
效果展示
 
 ![](./ChartsUnderstandAndUsage/效果图.gif)

## Demo的使用:
### 该demo包含了Charts框架的 每种图形使用都有详细的注释。（方便理解、调整成自己需要的图形展示）
（柱状图、饼状图、饼状图（半圆形）、雷达图、折线图、折线填充图、散点图、K 线图（烛形图）、气泡图、组合图(混合图)的基本使用方法
#### 1.柱状图 BarChartVC.swift

#### 2.柱状图（波浪图）BarChartWaveVC.swift

//添加柱状图   addBarChartView()

//设置基本样式   setBarChartViewBaseStyle()

//设置X轴，Y轴样式   setBarChartViewXY()

//添加（刷新数据）updataData()

#### 3.饼状图  PieChartVC.swift

#### 4.饼状图（半圆形）PieChartHalfVC.swift

#### 5.饼状图（折线注释）PieChartPolylineVC.swift

//添加饼状图   addPieChart()

//设置基本样式   setPieChartViewBaseStyle()

//添加（刷新数据） updataData()

#### 6.雷达图   RadarChartVC.swift (该图在刷新数据时要重新设置基本样式，否则会越来越小)

//添加雷达图  addRadarChart()

//设置基本样式   setRadarChartViewBaseStyle()

#### 7.折线图.swift

//添加折线   addLineChart()

 //折线图描述文字和样式  chartDescription()

 //设置交互样式  interactionStyle()

 //修改背景色和边框样式  setBackgroundBorder()

 //设置x轴的样式属性 setXAxisStyle()

 //设置y轴的样式属性 setYAxisStyle()

 //设置限制线（可设置多根）setlimitLine()

//添加（刷新数据） updataData()

#### 8.折线填充图   LineFilledChartVC.swift

//添加折线  addLineChart()

//设置基本样式   setLineChartViewBaseStyle()

//添加（刷新数据） updataData()

#### 9.散点图 ScatterChartVC.swift

 //添加散点图    addScatterChart()

 //基本样式     setScatterChartViewBaseStyle()

 //添加（刷新数据）updataData()

#### 10.K 线图（烛形图）CandleStickChartVC.swift

 //添加K 线图（烛形图)    addCandleStickChart()

 //基本样式     setCandleStickChartViewBaseStyle()

 //添加（刷新数据）updataData()

#### 11.气泡图  BubbleChartVC.swift

//添加气泡图 addBubbleChart()

//基本样式 setBubbleChartViewBaseStyle()

 //添加（刷新数据）updataData()

#### 12.组合图(混合图)的基本使用方法 CombinedChartVC.swift

//添加混合图   addCombinedChart()

//基本样式 setCombinedChartViewBaseStyle()

//添加（刷新数据）updataData()

#### 13.波浪图 WaveformChartVC.swift （该波形图主要是针对给一组数据，根据制高点和波形宽来画一连串波形）

//添加折线 addLineChart()

//设置基本样式  setLineChartViewBaseStyle()

   setXAxisStyle()   setYAxisStyle()

 //添加（刷新数据）updataData()
 
 
# PS

 欢迎fork,star.
 该demo地址：
 
 `
https://github.com/FighterLightning/ChartsUnderstandAndUsage.git

