<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>实时统计图表</title>
    <script src="<%=path%>/js/jquery-1.11.3.js"></script>
    <script src="<%=path%>/js/apexcharts.js"></script>
     <script src="http://echarts.baidu.com/build/dist/echarts-all.js"></script>
	<style>
        #container{
             width: 500px;
             height: 400px;
             border: 1px solid #ccc;
             /*background-color: #ccc;*/
         }
      </style>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="barEchart" style="width: 50%;height: 400px;"></div>
    
    <script type="text/javascript">
    $(document).ready(function(){
    	var myData = [10,9,8,7,6,5,4,3,2,1]
    	var myChart = echarts.init(document.getElementById('barEchart'));
    	option = {
    		    title: {
    		        text: '动态数据',
    		        subtext: '纯属虚构'
    		    },
    		    tooltip: {
    		        trigger: 'axis',
    		        axisPointer: {
    		            type: 'cross',
    		            label: {
    		                backgroundColor: '#283b56'
    		            }
    		        }
    		    },
    		    legend: {
    		        data:['最新成交价', '预购队列']
    		    },
    		    toolbox: {
    		        show: true,
    		        feature: {
    		            dataView: {readOnly: false},
    		            restore: {},
    		            saveAsImage: {}
    		        }
    		    },
    		    dataZoom: {
    		        show: false,
    		        start: 0,
    		        end: 100
    		    },
    		    xAxis: [
    		        {
    		            type: 'category',
    		            boundaryGap: true,
    		            data: (function (){
    		                var now = new Date();
    		                var res = [];
    		                var len = 10;
    		                while (len--) {
    		                    res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
    		                    now = new Date(now - 2000);
    		                }
    		                return res;
    		            })()
    		        },
    		        {
    		            type: 'category',
    		            boundaryGap: true,
    		            data: myData
    		        }
    		    ],
    		    yAxis: [
    		        {
    		            type: 'value',
    		            scale: true,
    		            name: '价格',
    		            max: 30,
    		            min: 0,
    		            boundaryGap: [0.2, 0.2]
    		        },
    		        {
    		            type: 'value',
    		            scale: true,
    		            name: '预购量',
    		            max: 1200,
    		            min: 0,
    		            boundaryGap: [0.2, 0.2]
    		        }
    		    ],
    		    series: [
    		        {
    		            name:'预购队列',
    		            type:'bar',
    		            xAxisIndex: 1,
    		            yAxisIndex: 1,
    		            data:(function (){
    		                var res = [];
    		                var len = 10;
    		                while (len--) {
    		                    res.push(Math.round(Math.random() * 1000));
    		                }
    		                return res;
    		            })()
    		        },
    		        {
    		            name:'最新成交价',
    		            type:'line',
    		            data:(function (){
    		                var res = [];
    		                var len = 0;
    		                while (len < 10) {
    		                    res.push((Math.random()*10 + 5).toFixed(1) - 0);
    		                    len++;
    		                }
    		                return res;
    		            })()
    		        }
    		    ]
    		};
    	myChart.setOption(option);
			var count = 11;
    		setInterval(function (){
    		    axisData = (new Date()).toLocaleTimeString().replace(/^\D*/,'');

    		    var data0 = option.series[0].data;
    		    var data1 = option.series[1].data;
    		    data0.shift();
    		    data0.push(Math.round(Math.random() * 1000));
    		    data1.shift();
    		    data1.push((Math.random() * 10 + 5).toFixed(1) - 0);

    		    option.xAxis[0].data.shift();
    		    option.xAxis[0].data.push(axisData);
    		    option.xAxis[1].data.shift();
    		    option.xAxis[1].data.push(count++);

    		    myChart.setOption(option);
    		}, 2000);
    });
	</script>
  </head>
  <body>
    <div id="redisMemoryChart" style="height: 320px"></div>
  </body>
</html>
