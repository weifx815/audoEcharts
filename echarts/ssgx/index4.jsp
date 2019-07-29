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
    <script src="<%=path%>/js/echarts.js"></script>
    <link rel="stylesheet" href="<%=path%>/css/style.css"/>
  </head>
  <body>
  <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
  <table width="100%" border="1">
  	<tr>
  		<td width="50%"><div id="oneBarEchart" style="width: 100%;height: 300px;"></div></td>
  		<td width="50%">
  			<div class="dl-group3 clearfix">
                <dl class="dl1">
                    <dt>食品生产</dt>
                    <dd>
                        <p class="BL" style="width: 0%"><span id="BL1"></span>%</p>
                    </dd>
                </dl>
                <dl class="dl2">
                    <dt>食品流通</dt>
                    <dd>
                        <p class="BL" style="width: 0%"><span id="BL2"></span>%</p>
                    </dd>
                </dl>
                <dl class="dl3">
                    <dt>餐饮服务</dt>
                    <dd>
                        <p class="BL" style="width: 0%"><span id="BL3"></span>%</p>
                    </dd>
                </dl>
                <dl class="dl4">
                    <dt>特种设备</dt>
                    <dd>
                        <p class="BL" style="width: 0%"><span id="BL4"></span>%</p>
                    </dd>
                </dl>
            </div>
  		</td>
  	</tr>
  </table>
    
  </body>
  <script type="text/javascript">
  	var path = "<%=path%>";
    $(document).ready(function(){
    	/*****************单柱形***************/
	  	var myData = [12, 22, 20, 34, 39, 30, 20,12,34,26];
    	var myChart = echarts.init(document.getElementById('oneBarEchart'));
    	barChartOption = {
    			animation:true,
    			animationEasing:'linear',
    		    tooltip : {
    		        trigger: 'axis',
    		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    		            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
    		        }
    		    },
    		    toolbox: {
        	        feature: {
        	            saveAsImage: {}
        	        }
        	    },
    		    grid: {
    		        left: '3%',
    		        right: '4%',
    		        bottom: '3%',
    		        containLabel: true
    		    },
    		    xAxis : [
    		        {
    		            type : 'category',
    		            data : ['福田区', '宝安区', '南山区', '光明区', '龙华区', '龙岗区', '罗湖区', '坪山区', '盐田区', '大鹏区'],
    		            axisTick: {
    		                alignWithLabel: true
    		            }
    		        }
    		    ],
    		    yAxis : [
    		        {
    		            type : 'value'
    		        }
    		    ],
    		    series : [
    		        {
    		            name:'直接访问',
    		            type:'bar',
    		            barWidth: '60%',
    		            itemStyle: {
    		                normal: {
    		                  color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
									{offset: 0, color: 'rgba(255,255,255,0)'},
									{offset: 0.5, color: '#188df0'},
									{offset: 1, color: '#188df0'}
    		                  ])
    		                }
    		              },
    		            label: {
    		                normal: {
    		                    show: true,
    		                    rotate: 90,
    		                    align: 'left',
    		                    verticalAlign: 'middle',
    		                    position: 'insideBottom',
    		                    distance: 15
    		                }
    		            },
    		            data: myData
    		        }
    		    ]
    		};
    	myChart.setOption(barChartOption);
    	window.setInterval(function(){
    		var url = path+"/Index4Servlet";
    		barChart(url,myChart,barChartOption); 
    		}, 10000);
    	
    	window.setInterval(function(){
    		var url = path+"/Index5Servlet";
    		hengBarChart(url); 
    		}, 5000);
    });
    function barChart(url,myChart,barChartOption){
    	$.get(url, function (rData) {
    		var datas = rData.split("||");
    	    var myDatas = datas[0];
    	    var myData = myDatas.split(",");
    		var xAxisDates = datas[1];
    		var xAxisDate = xAxisDates.split(",");
    		barChartOption.xAxis[0].data=xAxisDate;
    		barChartOption.series[0].data = myData;
        	myChart.setOption(barChartOption);
    	});
    }
    function hengBarChart(url){
    	$.get(url, function (rData) {
    		var data = JSON.parse(rData);
    		setFormObjects(data);
    	});
    }
    /*
    根据之前填报的数据，填充此表单表的对象 
    父页面会调用这个方法，填充表单信息
    */
    function setFormObjects(jsonData) {
    	if (jsonData) {
    		$.each(jsonData, function(key,str) {
    			/**公共文本部分开始**/
    			var ctl = $("#" + key); //获取id对应的对象
    			if (ctl.get(0) != undefined) {
    				var tagname = ctl.get(0).tagName.toLowerCase(); //获取对象的标签名
    				var ctltype; //获取对象的type类型
    				if (tagname == "input") {
    					ctltype = $(ctl).attr("type").toLowerCase();
    					if (ctltype == "text" || ctltype == "hidden") {
    						ctl.val(str);
    					}
    				}else if (tagname == "span") {
    					if(ctl.parent().attr("class")=="BL"){
    						ctl.parent().css("width",str+"%");
    					}
                        ctl.html(str);
                    }
    			}
    		});
    	}
    }

	</script>
</html>
