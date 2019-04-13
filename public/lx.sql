SET NAMES UTF8;
CREATE DATABASE lx CHARSET=UTF8;
USE lx;



/**笔记本电脑**/
CREATE TABLE lx_laptop(
  lid INT PRIMARY KEY AUTO_INCREMENT,
  family_id INT,              #所属型号家族编号
  md VARCHAR(128),            #中图片路径
  title VARCHAR(128),         #主标题
  subtitle VARCHAR(128),      #副标题
  price DECIMAL(10,2),        #价格
  promise VARCHAR(64),        #服务承诺
  spec VARCHAR(64),           #规格/颜色

  lname VARCHAR(32),          #商品名称
  os VARCHAR(32),             #操作系统
  memory VARCHAR(32),         #内存容量
  resolution VARCHAR(32),     #分辨率
  video_card VARCHAR(32),     #显卡型号
  cpu VARCHAR(32),            #处理器
  video_memory VARCHAR(32),   #显存容量
  category VARCHAR(32),       #所属分类
  disk VARCHAR(32),           #硬盘容量及类型
  details VARCHAR(1024),      #产品详细说明

  shelf_time BIGINT,          #上架时间
  sold_count INT,             #已售出的数量
  is_onsale BOOLEAN           #是否促销中
);

/**笔记本电脑图片**/
CREATE TABLE lx_laptop_pic(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  laptop_id INT,              #笔记本电脑编号
  sm VARCHAR(128),            #小图片路径
  md VARCHAR(128),            #中图片路径
  lg VARCHAR(128)             #大图片路径
);

/**用户信息**/
CREATE TABLE lx_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(32),
  upwd VARCHAR(32),
  email VARCHAR(64),
  phone VARCHAR(16),

  avatar VARCHAR(128),        #头像图片路径
  user_name VARCHAR(32),      #用户名，如王小明
  gender INT                  #性别  0-女  1-男
);

/**收货地址信息**/
CREATE TABLE lx_receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                #用户编号
  receiver VARCHAR(16),       #接收人姓名
  province VARCHAR(16),       #省
  city VARCHAR(16),           #市
  county VARCHAR(16),         #县
  address VARCHAR(128),       #详细地址
  cellphone VARCHAR(16),      #手机
  fixedphone VARCHAR(16),     #固定电话
  postcode CHAR(6),           #邮编
  tag VARCHAR(16),            #标签名

  is_default BOOLEAN          #是否为当前用户的默认收货地址
);

/**购物车条目**/
CREATE TABLE lx_shoppingcart_item(
  iid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,      #用户编号
  product_id INT,   #商品编号
  count INT,        #购买数量
  is_checked BOOLEAN #是否已勾选，确定购买
);

/**用户订单**/
CREATE TABLE lx_order(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  address_id INT,
  status INT,             #订单状态  1-等待付款  2-等待发货  3-运输中  4-已签收  5-已取消
  order_time BIGINT,      #下单时间
  pay_time BIGINT,        #付款时间
  deliver_time BIGINT,    #发货时间
  received_time BIGINT    #签收时间
)AUTO_INCREMENT=10000000;

/**用户订单**/
CREATE TABLE lx_order_detail(
  did INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,           #订单编号
  product_id INT,         #产品编号
  count INT               #购买数量
);

/****首页轮播广告商品****/
CREATE TABLE lx_index_carousel(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  img VARCHAR(128),
  title VARCHAR(64),
  href VARCHAR(128)
);

/****首页商品****/
CREATE TABLE lx_index_product(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(64),
  pic VARCHAR(128),
  price DECIMAL(10,2),
  href INT
);

/*******************/
/******数据导入******/
/*******************/

/**笔记本电脑**/
INSERT INTO lx_laptop VALUES
(1,1,'img/md/mi1.jpg','小米(MI)Pro 15.6英寸金属轻薄笔记本(i5-8250U 8G 256GSSD MX150 2G独显 FHD 指纹识别 预装office)深空灰','焕新季，领券买新机！神券满5000减300！一体成型金属机身，纤薄轻巧，长达12小时续航',5399,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','【MX150 2G独显】四核i5 8G 256G','小米Pro','Windows 10','8G','全高清屏（1920×1080）','入门级游戏独立显卡','Intel i5低功耗版','其它','轻薄本','128G固态','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150123456789,2968,true),
(2,1,'img/md/mi1.jpg','小米(MI)15.6英寸游戏笔记本电脑（英特尔八代酷睿I7-8750H 16G 1T+256G GTX1060 6G 72%高色域）深空灰','焕新季，领券买新机！神券满8000减800！一体成型金属机身，纤薄轻巧，长达12小时续航',8799,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','【GTX1060 6G】八代I7/256G SSD','小米Pro','Windows 10','8G','全高清屏（1920×1080）','高性能游戏独立显卡','Intel i7标准电压版','其它','轻薄本','256G固态','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150223456789,1922,false),
(3,1,'img/md/mi1.jpg','小米(MI)15.6英寸轻薄窄边框游戏笔记本电脑（i7标压 16G 1T+256G GTX1060 6G显存 创新冷酷散热系统）深空灰','i7处理器在此！依旧纤薄轻盈，续航持久，能胜任更多高强度工作，办公利器！',8999,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','【GTX1060】i7标压 16G 1T+256G','小米Pro','Windows 10','16G','1920*1080','高性能游戏独立显卡','Intel i7低功耗版','其它','轻薄本','256G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="//img20.360buyimg.com/vc/jfs/t3034/151/748569500/226790/d6cd86a2/57b15612N81dc489d.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg"></div></div><div class="formwork"><div class="formwork_text">技术规格 请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150323456789,733,false),
(4,1,'img/md/mi1.jpg','小米 (MI)Ruby 15.6英寸金属轻薄笔记本电脑(i5-8250U 8G 1T+128G SSD 2G GDDR5独显 FHD 全键盘 正版Office Win10) 深空灰','依旧纤薄轻盈，续航持久，能胜任更多高强度工作，办公利器！',4199,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','【好评如潮】i5-8250U 8G 2G独显','小米Pro','Windows 10','8G','全高清屏（1920×1080）','入门级游戏独立显卡','Intel i5低功耗版','其它','轻薄本','256G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="//img20.360buyimg.com/vc/jfs/t3034/151/748569500/226790/d6cd86a2/57b15612N81dc489d.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg"></div></div><div class="formwork"><div class="formwork_text">技术规格 请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150323456789,105,false),
(5,2,'img/md/xiaoxin1.jpg','联想(Lenovo)小新潮7000 14英寸轻薄笔记本电脑(英特尔八代酷睿I5-8250U 8G 1T+128G R535 office2016)银','【i5 独立显卡】全高清窄边框 支持SSD硬盘扩容 薄至14.8mm 轻至1.28kg！AKG扬声器！',4999,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','14英寸【i5 256G  新品推荐】','联想小新','Windows 10','8G','全高清屏(1920*1080)','入门级游戏独立显卡','Intel i5低功耗版','1G','轻薄本','256G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/5886e317Nbc52a580.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f747eNfdc5f737.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7483N695168a2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7486Nf809b915.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f748bN28dbcbb2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f748fNd2861229.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7493N5a3758af.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7497N20aac53e.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58d23597N878bf1f7.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58cfbc2aN51481cf1.png"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74a3N1f47e1f2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74acN9da4ea13.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74b0N0af5a884.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74b6N10c0f4a0.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/586f74c0N452b66a1.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/586f74c4N07c85d41.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/58d2350bNb98d64e2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/589458f0N90e67b9d.jpg"></div></div></div>',154123456789,1527,true),
(6,2,'img/md/xiaoxin1.jpg','联想(Lenovo)小新潮7000 2018款 15.6英寸轻薄窄边框笔记本电脑(R5-2500U 4G 2T+128G PCIE R540 2G)湖光蓝','【FHD窄边框】第七代处理器 128G SSD支持M.2接口SSD硬盘扩容 薄至12.9mm 轻至1.07kg！AKG扬声器！',4599,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','15.6英寸【四核 2T+128G 蓝】','联想小新','Windows 10','4G','全高清屏(1920*1080)','集成显卡','Intel CoreM','其它','轻薄本','128G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/5886e317Nbc52a580.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f747eNfdc5f737.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7483N695168a2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7486Nf809b915.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f748bN28dbcbb2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f748fNd2861229.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7493N5a3758af.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7497N20aac53e.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58d23597N878bf1f7.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58cfbc2aN51481cf1.png"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74a3N1f47e1f2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74acN9da4ea13.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74b0N0af5a884.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74b6N10c0f4a0.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/586f74c0N452b66a1.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/586f74c4N07c85d41.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/58d2350bNb98d64e2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/589458f0N90e67b9d.jpg"></div></div></div>',153123456789,115,false),
(7,2,'img/md/xiaoxin1.jpg','联想(Lenovo)小新潮7000 2018款 15.6英寸轻薄窄边框笔记本电脑(R5-2500U 8G 256G PCIE R540 2G)极光银','【FHD窄边框】第七代处理器 128G SSD支持M.2接口SSD硬盘扩容 薄至12.9mm 轻至1.07kg！AKG扬声器！',4898,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','15.6英寸【四核 2T+128G 银】','联想小新','Windows 10','4G','全高清屏(1920*1080)','集成显卡','Intel CoreM','其它','轻薄本','128G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/5886e317Nbc52a580.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f747eNfdc5f737.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7483N695168a2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7486Nf809b915.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f748bN28dbcbb2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f748fNd2861229.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7493N5a3758af.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7497N20aac53e.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58d23597N878bf1f7.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58cfbc2aN51481cf1.png"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74a3N1f47e1f2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74acN9da4ea13.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74b0N0af5a884.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74b6N10c0f4a0.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/586f74c0N452b66a1.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/586f74c4N07c85d41.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/58d2350bNb98d64e2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/589458f0N90e67b9d.jpg"></div></div></div>',156123456789,812,true),
(8,2,'img/md/xiaoxin1.jpg','联想(Lenovo)Ideapad120S 14.0英寸轻薄商务笔记本电脑(英特尔四核N3450 4G 256G固态硬盘 正版Office)银','【FHD窄边框】库存紧张 128G固态硬盘 支持M.2接口SSD硬盘扩容 薄至12.9mm 轻至1.07kg！',3099,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','推荐【四核 256G 超高性价比】','联想小新','Windows 10','4G','全高清屏(1920*1080)','集成显卡','Intel CoreM','其它','轻薄本','128G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/5886e317Nbc52a580.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f747eNfdc5f737.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7483N695168a2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7486Nf809b915.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f748bN28dbcbb2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f748fNd2861229.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7493N5a3758af.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f7497N20aac53e.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58d23597N878bf1f7.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58cfbc2aN51481cf1.png"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74a3N1f47e1f2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74acN9da4ea13.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74b0N0af5a884.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/586f74b6N10c0f4a0.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/586f74c0N452b66a1.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/586f74c4N07c85d41.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/58d2350bNb98d64e2.jpg"></div></div><div class="formwork"><div class="formwork_img"><img src="img/product/detail/589458f0N90e67b9d.jpg"></div></div></div>',157123456789,1081,false),
(9,3,'img/md/dell_xps1.jpg','戴尔DELL XPS13.3英寸超轻薄窄边框笔记本电脑(i7-8550U 8G 256GSSD FHD Win10 指纹识别 白色硅纤维)银','2017年经典款新！精致小黑！22.3mm轻薄体验，180度开合灵活耐用，高效稳健办公最长可达5小时！',12999,' *退货补运费 *30天无忧退货 *48小时快速退款','i7-8550U 8G 256GSSD FHD','戴尔DELL XPS','Windows10','4G','标准屏(1366×768)','入门级游戏独立显卡','Intel i3','2G','常规笔记本','500G','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58745160N7de01df6.jpg"></div></div></div>',150423456789,1461,true),
(10,3,'img/md/dell_xps1.jpg','戴尔DELL全新XPS13.3英寸超轻薄窄边框4K触控屏笔记本电脑白色硅纤维(i7-8550U 16G 512G UHD 指纹识别)金','2017年经典款新！精致小黑！22.3mm轻薄体验，180度开合灵活耐用，高效稳健办公最长可达5小时！',16999,' *退货补运费 *30天无忧退货 *48小时快速退款','i7-8550U 16G 512GSSD UHD 金','戴尔DELL XPS','Windows10','4G','标准屏(1366×768)','入门级游戏独立显卡','Intel i5低功耗版','2G','常规笔记本','500G','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58745160N7de01df6.jpg"></div></div></div>',151423456789,733,false),
(11,3,'img/md/dell_xps1.jpg','戴尔DELL XPS尊享版13.3英寸轻薄窄边框笔记本电脑(i7-8550U 16G 512GSSD IPS 2年全智服务)无忌银','2017年经典款新！精致小黑！22.3mm轻薄体验，180度开合灵活耐用，高效稳健办公最长可达10小时！',11099,' *退货补运费 *30天无忧退货 *48小时快速退款','i7-8550U 16G 512GSSD 银','戴尔DELL XPS','Windows10','4G','标准屏(1366×768)','入门级游戏独立显卡','Intel i5低功耗版','2G','常规笔记本','256G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58745160N7de01df6.jpg"></div></div></div>',152423456789,913,true),
(12,3,'img/md/dell_xps1.jpg','戴尔(DELL)全新XPS13.3英寸轻薄窄边框触屏控翻转笔记本电脑(i7-7Y75 16G 512GSSD FHD 指纹识别 )银','2017年经典款新！精致小黑！22.3mm轻薄体验，180度开合灵活耐用，高效稳健办公最长可达5小时！',14999,' *退货补运费 *30天无忧退货 *48小时快速退款','i7-7Y75 16G 512GSSD FHD','戴尔DELL XPS','Windows10','8G','标准屏(1366×768)','入门级游戏独立显卡','Intel i5低功耗版','2G','常规笔记本','256G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58745160N7de01df6.jpg"></div></div></div>',153423456789,112,false),
(13,4,'img/md/hppro1.jpg','惠普（HP）战66 Pro G1 14英寸轻薄笔记本电脑（i7-8550U 8G 360G PCIe SSD+500G 标压MX150 2G独显）银色','【铝镁合金 纯固态 轻至1.45kg 金属超极本 】双尺寸可选',6499,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','i7【8G/双硬盘】升级大固态','惠普（HP）战66 Pro G1','Windows 10','8G','全高清屏(1920×1080)','高性能游戏独立显卡','Intel i5低功耗版','2G','轻薄本','128G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59190fe7N6a9fb112.jpg"><img class="" src="img/product/detail/58d0bfceNc0694135.jpg"><img class="" src="img/product/detail/59143b58N0f24f48d.jpg"><img class="" src="img/product/detail/58f9de03Nd67611dc.jpg"><img class="" src="img/product/detail/58d0bfcbNc96d061c.jpg"><img class="" src="img/product/detail/58d0bfd1Nea212a7a.jpg"></div></div></div>',151123456789,1197,true),
(14,4,'img/md/hppro1.jpg','惠普（HP）战66 Pro G1 14英寸轻薄笔记本电脑（i5-8250U 8G 360G PCIe SSD 标压MX150 2G独显）银色','【铝镁合金 纯固态 轻至1.45kg 金属超极本 】双尺寸可选',5299,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','i5【8G/360GSSD】升级大固态','惠普（HP）战66 Pro G1','Windows 10','8G','全高清屏(1920×1080)','高性能游戏独立显卡','Intel i5低功耗版','2G','轻薄本','128G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59190fe7N6a9fb112.jpg"><img class="" src="img/product/detail/58d0bfceNc0694135.jpg"><img class="" src="img/product/detail/59143b58N0f24f48d.jpg"><img class="" src="img/product/detail/58f9de03Nd67611dc.jpg"><img class="" src="img/product/detail/58d0bfcbNc96d061c.jpg"><img class="" src="img/product/detail/58d0bfd1Nea212a7a.jpg"></div></div></div>',152123456789,137,false),
(15,4,'img/md/hppro1.jpg','惠普（HP）战66 Pro G1 14英寸轻薄笔记本电脑（i5-8250U 8G 360G PCIe SSD+500G 标压MX150 2G独显）银色','【铝镁合金 纯固态 轻至1.45kg 金属超极本 】双尺寸可选',5699,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','i5【8G/双硬盘】升级大固态','惠普（HP）战66 Pro G1','Windows 10','4G','全高清屏(1920×1080)','高性能游戏独立显卡','Intel i5低功耗版','2G','轻薄本','128G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59190fe7N6a9fb112.jpg"><img class="" src="img/product/detail/58d0bfceNc0694135.jpg"><img class="" src="img/product/detail/59143b58N0f24f48d.jpg"><img class="" src="img/product/detail/58f9de03Nd67611dc.jpg"><img class="" src="img/product/detail/58d0bfcbNc96d061c.jpg"><img class="" src="img/product/detail/58d0bfd1Nea212a7a.jpg"></div></div></div>',153123456789,21,false),
(16,4,'img/md/hppro1.jpg','惠普（HP）战66 Pro G1 14英寸轻薄笔记本电脑（i7-8550U 8G 128GSSD+1T 标压MX150 2G独显 FHD）银色','【铝镁合金 纯固态 轻至1.45kg 金属超极本 】双尺寸可选',6299,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','i7【8G/1T&128GSSD】满血MX150','惠普（HP）战66 Pro G1','Windows 10','8G','全高清屏(1920×1080)','高性能游戏独立显卡','Intel i5低功耗版','2G','轻薄本','128G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59190fe7N6a9fb112.jpg"><img class="" src="img/product/detail/58d0bfceNc0694135.jpg"><img class="" src="img/product/detail/59143b58N0f24f48d.jpg"><img class="" src="img/product/detail/58f9de03Nd67611dc.jpg"><img class="" src="img/product/detail/58d0bfcbNc96d061c.jpg"><img class="" src="img/product/detail/58d0bfd1Nea212a7a.jpg"></div></div></div>',152423456789,981,false),
(17,5,'img/md/asus1.jpg','华硕(ASUS) 飞行堡垒6 15.6英寸窄边框游戏笔记本电脑(i7-8750H 8G 256GSSD+1T GTX1050Ti 4G IPS)火陨红黑','【2017闪耀换新！晒单得E卡！12期免息！】经典之选',7299,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','i7处理器 8G 256G+1T GTX1050Ti','华硕飞行堡垒','Windows 10','8G','分辨率：全高清屏(1920×1080)','GTX950M','Intel i5标准电压版','4G','游戏本','128G+500G','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58ca2b14Nd5c09fcd.jpg"><img class="" src="img/product/detail/58ca2b28Na5a22f83.jpg"><img class="" src="img/product/detail/58ca3012Nc99ab61f.jpg"><img class="" src="img/product/detail/58ca2b51Nbf258c3b.jpg"><img class="" src="img/product/detail/58ca2b67N436e60de.jpg"></div></div></div>',149123456789,192,true),
(18,5,'img/md/asus1.jpg','华硕(ASUS) 飞行堡垒6 15.6英寸窄边框游戏笔记本电脑(i5-8300H 8G 256GSSD+1T GTX1050Ti 4G IPS)火陨红黑','【2017闪耀换新！晒单得E卡！12期免息！】经典之选',6299,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','i5处理器 8G 256G+1T GTX1050Ti','华硕飞行堡垒','Windows 10','8G','分辨率：全高清屏(1920×1080)','GTX950M','Intel i7标准电压版','4G','游戏本','128G+500G','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58ca2b14Nd5c09fcd.jpg"><img class="" src="img/product/detail/58ca2b28Na5a22f83.jpg"><img class="" src="img/product/detail/58ca3012Nc99ab61f.jpg"><img class="" src="img/product/detail/58ca2b51Nbf258c3b.jpg"><img class="" src="img/product/detail/58ca2b67N436e60de.jpg"></div></div></div>',151523456789,260,false),
(19,6,'img/md/suffer1.jpg','微软（Microsoft）Surface Laptop超轻薄触控笔记本（13.5英寸 Core M3 4G 128GSSD Windows10S）亮铂金','【轻薄微边框】IPS全高清显示屏，动力强劲性能澎湃！',4666,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','CoreM 4G+128G  ','微软（Microsoft）Surface','Windows 10','4G','全高清屏(1920×1080)','入门级游戏独立显卡','Intel i5低功耗版','2G','轻薄本','128G+500G','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58d87221Na033954c.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58e5e4b5N862f8aa1.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/57bfa672N20953b71.jpg"></div></div></div>',151923456789,911,false),
(20,6,'img/md/suffer1.jpg','微软（Microsoft）Surface Laptop超轻薄触控笔记本（13.5英寸 i5-7200U 8G 256GSSD Windows10S）亮铂金','【轻薄微边框】IPS全高清显示屏，动力强劲性能澎湃！',6988,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货',' i5 8G+256G','微软（Microsoft）Surface','Windows 10','8G','全高清屏(1920×1080)','入门级游戏独立显卡','Intel i7低功耗版','2G','轻薄本','128G+500G','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58d87221Na033954c.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58e5e4b5N862f8aa1.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/57bfa672N20953b71.jpg"></div></div></div>',150823456789,1930,true),
(21,6,'img/md/suffer1.jpg','微软（Microsoft）Surface Laptop超轻薄触控笔记本（13.5英寸 i5-7200U 8G 256GSSD Windows10S）黑色','【轻薄微边框】IPS全高清显示屏，动力强劲性能澎湃！',6988,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货',' i5 8G+256G 黑色','微软（Microsoft）Surface','Windows 10','4G','全高清屏(1920×1080)','入门级游戏独立显卡','Intel i5低功耗版','2G','轻薄本','128G+500G','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58d87221Na033954c.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58e5e4b5N862f8aa1.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/57bfa672N20953b71.jpg"></div></div></div>',151023456789,987,true),
(22,7,'img/md/s1.jpg','机械革命（MECHREVO）S1 72%IPS 1.18kg 14英寸独显窄边框轻薄笔记本电脑 i7-8550U 8G 256G MX150 灰 OFFICE','【白条6期免息 游匣“10”力出击】七代四核CPU ,GTX1050 4G独显,FHD全高清屏,热血出击！',5299,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','八代i7+MX150+office灰色','机械革命（MECHREVO）S1','Windows 10','8G','全高清屏(1920×1080)','GTX960M','Intel i7标准电压版','4G','游戏本','128G+1T','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003d3fNd4e6c74e.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003d49Nd9aa8623.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003d53N79717f17.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003db4N5441df2e.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003afdN7d9208b8.jpg"></div></div></div>',148123456789,1901,true),
(23,7,'img/md/s1.jpg','机械革命（MECHREVO）S1 72%IPS 1.18kg 14英寸独显窄边框轻薄笔记本电脑 i5-8250U 8G 256G MX150 银 OFFICE','游匣枪弹版精装上市 3D立体喷涂画面 机身更酷炫 七代四核CPU ,GTX1050 4G独显,FHD全高清屏,热血出击！',5199,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','八代i5+MX150+office银色','机械革命（MECHREVO）S1','Windows 10','8G','全高清屏(1920×1080)','GTX960M','Intel i5标准电压版','4G','游戏本','128G+1T','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003d3fNd4e6c74e.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003d49Nd9aa8623.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003d53N79717f17.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003db4N5441df2e.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003afdN7d9208b8.jpg"></div></div></div>',153123456789,1231,false),
(24,7,'img/md/s1.jpg','机械革命（MECHREVO）S1 72%IPS 1.18kg 14英寸独显窄边框轻薄笔记本电脑 i7-8550U 8G 512G MX150 灰 OFFICE','游匣枪弹版精装上市 3D立体喷涂画面 机身更酷炫 七代四核CPU ,GTX1050 4G独显,FHD全高清屏,热血出击！',6599,' *退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','八代i7+MX150+office+512G灰色','机械革命（MECHREVO）S1','Windows 10','8G','全高清屏(1920×1080)','GTX960M','Intel i7标准电压版','4G','游戏本','128G+1T','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003d3fNd4e6c74e.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003d49Nd9aa8623.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003d53N79717f17.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003db4N5441df2e.jpg"></div></div><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/59003afdN7d9208b8.jpg"></div></div></div>',1539923456789,221,false),
(25,8,'img/md/micsorft1.jpg','微软（Microsoft）Surface Book 2 二合一平板电脑笔记本 13.5英寸（Intel i5 8G内存 128G存储）银色','点击进入5月大促，超值满千减百品牌周',8488,'*30天无忧退货 *48小时快速退款','8G+128G','微软（Microsoft）Surface Book 2','Linux','4G','标准屏(1366×768)','入门级游戏独立显卡','Intel i5低功耗版','2G','常规本','500G','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58119b8aNb84f1e22.jpg"></div></div></div>',150123456789,117,true),
(26,8,'img/md/micsorft1.jpg','微软（Microsoft）Surface Book 2 二合一平板电脑笔记本 13.5英寸（Intel i5 8G内存 256G存储）银色','点击进入5月大促，超值满千减百品牌周',12288,'*30天无忧退货 *48小时快速退款','8G+256G','微软（Microsoft）Surface Book 2','Linux','8G','标准屏(1366×768)','入门级游戏独立显卡','Intel i5低功耗版','2G','常规本','500G','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58119b8aNb84f1e22.jpg"></div></div></div>',151123456789,1862,false),
(27,8,'img/md/micsorft1.jpg','微软（Microsoft）Surface Book 2 二合一平板电脑笔记本 13.5英寸（Intel i7 16G内存 512G存储）银色','点击进入5月大促，超值满千减百品牌周',20288,'*30天无忧退货 *48小时快速退款','16G+512G','微软（Microsoft）Surface Book 2','Linux','8G','标准屏(1366×768)','入门级游戏独立显卡','Intel i5低功耗版','2G','常规本','1T','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58119b8aNb84f1e22.jpg"></div></div></div>',152123456789,812,true),
(28,8,'img/md/micsorft1.jpg','微软（Microsoft）Surface Book 2 二合一平板电脑笔记本 13.5英寸（Intel i7 16G内存 1T存储）银色','点击进入5月大促，超值满千减百品牌周',20488,'*30天无忧退货 *48小时快速退款','16G+1TB','微软（Microsoft）Surface Book 2','Linux','4G','标准屏(1366×768)','入门级游戏独立显卡','Intel i5低功耗版','2G','常规本','256G固态','<div class="content_tpl"><div class="formwork"><div class="formwork_img"><img class="" src="img/product/detail/58119b8aNb84f1e22.jpg"></div></div></div>',153123456789,162,false);


/**笔记本电脑图片**/
INSERT INTO lx_laptop_pic VALUES
(NULL, 1, 'img/sm/mi1.jpg','img/md/mi1.jpg','img/lg/mi1.jpg'),
(NULL, 1, 'img/sm/mi2.jpg','img/md/mi2.jpg','img/lg/mi2.jpg'),
(NULL, 1, 'img/sm/mi3.jpg','img/md/mi3.jpg','img/lg/mi3.jpg'),
(NULL, 1, 'img/sm/mi4.jpg','img/md/mi4.jpg','img/lg/mi4.jpg'),
(NULL, 1, 'img/sm/mi5.jpg','img/md/mi5.jpg','img/lg/mi5.jpg'),
(NULL, 1, 'img/sm/mi6.jpg','img/md/mi6.jpg','img/lg/mi6.jpg'),
(NULL, 2, 'img/sm/mi1.jpg','img/md/mi1.jpg','img/lg/mi1.jpg'),
(NULL, 2, 'img/sm/mi2.jpg','img/md/mi2.jpg','img/lg/mi2.jpg'),
(NULL, 2, 'img/sm/mi3.jpg','img/md/mi3.jpg','img/lg/mi3.jpg'),
(NULL, 2, 'img/sm/mi4.jpg','img/md/mi4.jpg','img/lg/mi4.jpg'),
(NULL, 2, 'img/sm/mi5.jpg','img/md/mi5.jpg','img/lg/mi5.jpg'),
(NULL, 2, 'img/sm/mi6.jpg','img/md/mi6.jpg','img/lg/mi6.jpg'),
(NULL, 3, 'img/sm/mi1.jpg','img/md/mi1.jpg','img/lg/mi1.jpg'),
(NULL, 3, 'img/sm/mi2.jpg','img/md/mi2.jpg','img/lg/mi2.jpg'),
(NULL, 3, 'img/sm/mi3.jpg','img/md/mi3.jpg','img/lg/mi3.jpg'),
(NULL, 3, 'img/sm/mi4.jpg','img/md/mi4.jpg','img/lg/mi4.jpg'),
(NULL, 3, 'img/sm/mi5.jpg','img/md/mi5.jpg','img/lg/mi5.jpg'),
(NULL, 3, 'img/sm/mi6.jpg','img/md/mi6.jpg','img/lg/mi6.jpg'),
(NULL, 4, 'img/sm/mi1.jpg','img/md/mi1.jpg','img/lg/mi1.jpg'),
(NULL, 4, 'img/sm/mi2.jpg','img/md/mi2.jpg','img/lg/mi2.jpg'),
(NULL, 4, 'img/sm/mi3.jpg','img/md/mi3.jpg','img/lg/mi3.jpg'),
(NULL, 4, 'img/sm/mi4.jpg','img/md/mi4.jpg','img/lg/mi4.jpg'),
(NULL, 4, 'img/sm/mi5.jpg','img/md/mi5.jpg','img/lg/mi5.jpg'),
(NULL, 4, 'img/sm/mi6.jpg','img/md/mi6.jpg','img/lg/mi6.jpg'),

(NULL, 5, 'img/sm/xiaoxin1.jpg','img/md/xiaoxin1.jpg','img/lg/xiaoxin1.jpg'),
(NULL, 5, 'img/sm/xiaoxin2.jpg','img/md/xiaoxin2.jpg','img/lg/xiaoxin2.jpg'),
(NULL, 5, 'img/sm/xiaoxin3.jpg','img/md/xiaoxin3.jpg','img/lg/xiaoxin3.jpg'),
(NULL, 5, 'img/sm/xiaoxin4.jpg','img/md/xiaoxin4.jpg','img/lg/xiaoxin4.jpg'),
(NULL, 5, 'img/sm/xiaoxin5.jpg','img/md/xiaoxin5.jpg','img/lg/xiaoxin5.jpg'),
(NULL, 5, 'img/sm/xiaoxin6.jpg','img/md/xiaoxin6.jpg','img/lg/xiaoxin6.jpg'),
(NULL, 5, 'img/sm/xiaoxin7.jpg','img/md/xiaoxin7.jpg','img/lg/xiaoxin7.jpg'),
(NULL, 6, 'img/sm/xiaoxin1.jpg','img/md/xiaoxin1.jpg','img/lg/xiaoxin1.jpg'),
(NULL, 6, 'img/sm/xiaoxin2.jpg','img/md/xiaoxin2.jpg','img/lg/xiaoxin2.jpg'),
(NULL, 6, 'img/sm/xiaoxin3.jpg','img/md/xiaoxin3.jpg','img/lg/xiaoxin3.jpg'),
(NULL, 6, 'img/sm/xiaoxin4.jpg','img/md/xiaoxin4.jpg','img/lg/xiaoxin4.jpg'),
(NULL, 6, 'img/sm/xiaoxin5.jpg','img/md/xiaoxin5.jpg','img/lg/xiaoxin5.jpg'),
(NULL, 6, 'img/sm/xiaoxin6.jpg','img/md/xiaoxin6.jpg','img/lg/xiaoxin6.jpg'),
(NULL, 6, 'img/sm/xiaoxin7.jpg','img/md/xiaoxin7.jpg','img/lg/xiaoxin7.jpg'),
(NULL, 7, 'img/sm/xiaoxin1.jpg','img/md/xiaoxin1.jpg','img/lg/xiaoxin1.jpg'),
(NULL, 7, 'img/sm/xiaoxin2.jpg','img/md/xiaoxin2.jpg','img/lg/xiaoxin2.jpg'),
(NULL, 7, 'img/sm/xiaoxin3.jpg','img/md/xiaoxin3.jpg','img/lg/xiaoxin3.jpg'),
(NULL, 7, 'img/sm/xiaoxin4.jpg','img/md/xiaoxin4.jpg','img/lg/xiaoxin4.jpg'),
(NULL, 7, 'img/sm/xiaoxin5.jpg','img/md/xiaoxin5.jpg','img/lg/xiaoxin5.jpg'),
(NULL, 7, 'img/sm/xiaoxin6.jpg','img/md/xiaoxin6.jpg','img/lg/xiaoxin6.jpg'),
(NULL, 7, 'img/sm/xiaoxin7.jpg','img/md/xiaoxin7.jpg','img/lg/xiaoxin7.jpg'),
(NULL, 8, 'img/sm/xiaoxin1.jpg','img/md/xiaoxin1.jpg','img/lg/xiaoxin1.jpg'),
(NULL, 8, 'img/sm/xiaoxin2.jpg','img/md/xiaoxin2.jpg','img/lg/xiaoxin2.jpg'),
(NULL, 8, 'img/sm/xiaoxin3.jpg','img/md/xiaoxin3.jpg','img/lg/xiaoxin3.jpg'),
(NULL, 8, 'img/sm/xiaoxin4.jpg','img/md/xiaoxin4.jpg','img/lg/xiaoxin4.jpg'),
(NULL, 8, 'img/sm/xiaoxin5.jpg','img/md/xiaoxin5.jpg','img/lg/xiaoxin5.jpg'),
(NULL, 8, 'img/sm/xiaoxin6.jpg','img/md/xiaoxin6.jpg','img/lg/xiaoxin6.jpg'),
(NULL, 8, 'img/sm/xiaoxin7.jpg','img/md/xiaoxin7.jpg','img/lg/xiaoxin7.jpg'),

(NULL, 9, 'img/sm/dell_xps1.jpg','img/md/dell_xps1.jpg','img/lg/dell_xps1.jpg'),
(NULL, 9, 'img/sm/dell_xps2.jpg','img/md/dell_xps2.jpg','img/lg/dell_xps2.jpg'),
(NULL, 9, 'img/sm/dell_xps3.jpg','img/md/dell_xps3.jpg','img/lg/dell_xps3.jpg'),
(NULL, 9, 'img/sm/dell_xps4.jpg','img/md/dell_xps4.jpg','img/lg/dell_xps4.jpg'),
(NULL, 9, 'img/sm/dell_xps5.jpg','img/md/dell_xps5.jpg','img/lg/dell_xps5.jpg'),
(NULL, 9, 'img/sm/dell_xps6.jpg','img/md/dell_xps6.jpg','img/lg/dell_xps6.jpg'),
(NULL, 9, 'img/sm/dell_xps7.jpg','img/md/dell_xps7.jpg','img/lg/dell_xps7.jpg'),
(NULL, 10, 'img/sm/dell_xps1.jpg','img/md/dell_xps1.jpg','img/lg/dell_xps1.jpg'),
(NULL, 10, 'img/sm/dell_xps2.jpg','img/md/dell_xps2.jpg','img/lg/dell_xps2.jpg'),
(NULL, 10, 'img/sm/dell_xps3.jpg','img/md/dell_xps3.jpg','img/lg/dell_xps3.jpg'),
(NULL, 10, 'img/sm/dell_xps4.jpg','img/md/dell_xps4.jpg','img/lg/dell_xps4.jpg'),
(NULL, 10, 'img/sm/dell_xps5.jpg','img/md/dell_xps5.jpg','img/lg/dell_xps5.jpg'),
(NULL, 10, 'img/sm/dell_xps6.jpg','img/md/dell_xps6.jpg','img/lg/dell_xps6.jpg'),
(NULL, 10, 'img/sm/dell_xps7.jpg','img/md/dell_xps7.jpg','img/lg/dell_xps7.jpg'),
(NULL, 11, 'img/sm/dell_xps1.jpg','img/md/dell_xps1.jpg','img/lg/dell_xps1.jpg'),
(NULL, 11, 'img/sm/dell_xps2.jpg','img/md/dell_xps2.jpg','img/lg/dell_xps2.jpg'),
(NULL, 11, 'img/sm/dell_xps3.jpg','img/md/dell_xps3.jpg','img/lg/dell_xps3.jpg'),
(NULL, 11, 'img/sm/dell_xps4.jpg','img/md/dell_xps4.jpg','img/lg/dell_xps4.jpg'),
(NULL, 11, 'img/sm/dell_xps5.jpg','img/md/dell_xps5.jpg','img/lg/dell_xps5.jpg'),
(NULL, 11, 'img/sm/dell_xps6.jpg','img/md/dell_xps6.jpg','img/lg/dell_xps6.jpg'),
(NULL, 11, 'img/sm/dell_xps7.jpg','img/md/dell_xps7.jpg','img/lg/dell_xps7.jpg'),
(NULL, 12, 'img/sm/dell_xps1.jpg','img/md/dell_xps1.jpg','img/lg/dell_xps1.jpg'),
(NULL, 12, 'img/sm/dell_xps2.jpg','img/md/dell_xps2.jpg','img/lg/dell_xps2.jpg'),
(NULL, 12, 'img/sm/dell_xps3.jpg','img/md/dell_xps3.jpg','img/lg/dell_xps3.jpg'),
(NULL, 12, 'img/sm/dell_xps4.jpg','img/md/dell_xps4.jpg','img/lg/dell_xps4.jpg'),
(NULL, 12, 'img/sm/dell_xps5.jpg','img/md/dell_xps5.jpg','img/lg/dell_xps5.jpg'),
(NULL, 12, 'img/sm/dell_xps6.jpg','img/md/dell_xps6.jpg','img/lg/dell_xps6.jpg'),
(NULL, 12, 'img/sm/dell_xps7.jpg','img/md/dell_xps7.jpg','img/lg/dell_xps7.jpg'),

(NULL, 13, 'img/sm/hppro1.jpg','img/md/hppro1.jpg','img/lg/hppro1.jpg'),
(NULL, 13, 'img/sm/hppro2.jpg','img/md/hppro2.jpg','img/lg/hppro2.jpg'),
(NULL, 13, 'img/sm/hppro3.jpg','img/md/hppro3.jpg','img/lg/hppro3.jpg'),
(NULL, 13, 'img/sm/hppro4.jpg','img/md/hppro4.jpg','img/lg/hppro4.jpg'),
(NULL, 13, 'img/sm/hppro5.jpg','img/md/hppro5.jpg','img/lg/hppro5.jpg'),
(NULL, 13, 'img/sm/hppro6.jpg','img/md/hppro6.jpg','img/lg/hppro6.jpg'),
(NULL, 14, 'img/sm/hppro1.jpg','img/md/hppro1.jpg','img/lg/hppro1.jpg'),
(NULL, 14, 'img/sm/hppro2.jpg','img/md/hppro2.jpg','img/lg/hppro2.jpg'),
(NULL, 14, 'img/sm/hppro3.jpg','img/md/hppro3.jpg','img/lg/hppro3.jpg'),
(NULL, 14, 'img/sm/hppro4.jpg','img/md/hppro4.jpg','img/lg/hppro4.jpg'),
(NULL, 14, 'img/sm/hppro5.jpg','img/md/hppro5.jpg','img/lg/hppro5.jpg'),
(NULL, 14, 'img/sm/hppro6.jpg','img/md/hppro6.jpg','img/lg/hppro6.jpg'),
(NULL, 15, 'img/sm/hppro1.jpg','img/md/hppro1.jpg','img/lg/hppro1.jpg'),
(NULL, 15, 'img/sm/hppro2.jpg','img/md/hppro2.jpg','img/lg/hppro2.jpg'),
(NULL, 15, 'img/sm/hppro3.jpg','img/md/hppro3.jpg','img/lg/hppro3.jpg'),
(NULL, 15, 'img/sm/hppro4.jpg','img/md/hppro4.jpg','img/lg/hppro4.jpg'),
(NULL, 15, 'img/sm/hppro5.jpg','img/md/hppro5.jpg','img/lg/hppro5.jpg'),
(NULL, 15, 'img/sm/hppro6.jpg','img/md/hppro6.jpg','img/lg/hppro6.jpg'),
(NULL, 16, 'img/sm/hppro1.jpg','img/md/hppro1.jpg','img/lg/hppro1.jpg'),
(NULL, 16, 'img/sm/hppro2.jpg','img/md/hppro2.jpg','img/lg/hppro2.jpg'),
(NULL, 16, 'img/sm/hppro3.jpg','img/md/hppro3.jpg','img/lg/hppro3.jpg'),
(NULL, 16, 'img/sm/hppro4.jpg','img/md/hppro4.jpg','img/lg/hppro4.jpg'),
(NULL, 16, 'img/sm/hppro5.jpg','img/md/hppro5.jpg','img/lg/hppro5.jpg'),
(NULL, 16, 'img/sm/hppro6.jpg','img/md/hppro6.jpg','img/lg/hppro6.jpg'),

(NULL, 17, 'img/sm/asus1.jpg','img/md/asus1.jpg','img/lg/asus1.jpg'),
(NULL, 17, 'img/sm/asus2.jpg','img/md/asus2.jpg','img/lg/asus2.jpg'),
(NULL, 17, 'img/sm/asus3.jpg','img/md/asus3.jpg','img/lg/asus3.jpg'),
(NULL, 17, 'img/sm/asus4.jpg','img/md/asus4.jpg','img/lg/asus4.jpg'),
(NULL, 17, 'img/sm/asus5.jpg','img/md/asus5.jpg','img/lg/asus5.jpg'),
(NULL, 18, 'img/sm/asus1.jpg','img/md/asus1.jpg','img/lg/asus1.jpg'),
(NULL, 18, 'img/sm/asus2.jpg','img/md/asus2.jpg','img/lg/asus2.jpg'),
(NULL, 18, 'img/sm/asus3.jpg','img/md/asus3.jpg','img/lg/asus3.jpg'),
(NULL, 18, 'img/sm/asus4.jpg','img/md/asus4.jpg','img/lg/asus4.jpg'),
(NULL, 18, 'img/sm/asus5.jpg','img/md/asus5.jpg','img/lg/asus5.jpg'),

(NULL, 19, 'img/sm/suffer1.jpg','img/md/suffer1.jpg','img/lg/suffer1.jpg'),
(NULL, 19, 'img/sm/suffer2.jpg','img/md/suffer2.jpg','img/lg/suffer2.jpg'),
(NULL, 19, 'img/sm/suffer3.jpg','img/md/suffer3.jpg','img/lg/suffer3.jpg'),
(NULL, 19, 'img/sm/suffer4.jpg','img/md/suffer4.jpg','img/lg/suffer4.jpg'),
(NULL, 19, 'img/sm/suffer5.jpg','img/md/suffer5.jpg','img/lg/suffer5.jpg'),
(NULL, 19, 'img/sm/suffer6.jpg','img/md/suffer6.jpg','img/lg/suffer6.jpg'),
(NULL, 20, 'img/sm/suffer1.jpg','img/md/suffer1.jpg','img/lg/suffer1.jpg'),
(NULL, 20, 'img/sm/suffer2.jpg','img/md/suffer2.jpg','img/lg/suffer2.jpg'),
(NULL, 20, 'img/sm/suffer3.jpg','img/md/suffer3.jpg','img/lg/suffer3.jpg'),
(NULL, 20, 'img/sm/suffer4.jpg','img/md/suffer4.jpg','img/lg/suffer4.jpg'),
(NULL, 20, 'img/sm/suffer5.jpg','img/md/suffer5.jpg','img/lg/suffer5.jpg'),
(NULL, 20, 'img/sm/suffer6.jpg','img/md/suffer6.jpg','img/lg/suffer6.jpg'),
(NULL, 21, 'img/sm/suffer1.jpg','img/md/suffer1.jpg','img/lg/suffer1.jpg'),
(NULL, 21, 'img/sm/suffer2.jpg','img/md/suffer2.jpg','img/lg/suffer2.jpg'),
(NULL, 21, 'img/sm/suffer3.jpg','img/md/suffer3.jpg','img/lg/suffer3.jpg'),
(NULL, 21, 'img/sm/suffer4.jpg','img/md/suffer4.jpg','img/lg/suffer4.jpg'),
(NULL, 21, 'img/sm/suffer5.jpg','img/md/suffer5.jpg','img/lg/suffer5.jpg'),
(NULL, 21, 'img/sm/suffer6.jpg','img/md/suffer6.jpg','img/lg/suffer6.jpg'),

(NULL, 22, 'img/sm/s1.jpg','img/md/s1.jpg','img/lg/s1.jpg'),
(NULL, 22, 'img/sm/s2.jpg','img/md/s2.jpg','img/lg/s2.jpg'),
(NULL, 22, 'img/sm/s3.jpg','img/md/s3.jpg','img/lg/s3.jpg'),
(NULL, 22, 'img/sm/s4.jpg','img/md/s4.jpg','img/lg/s4.jpg'),
(NULL, 22, 'img/sm/s5.jpg','img/md/s5.jpg','img/lg/s5.jpg'),
(NULL, 22, 'img/sm/s6.jpg','img/md/s6.jpg','img/lg/s6.jpg'),
(NULL, 23, 'img/sm/s1.jpg','img/md/s1.jpg','img/lg/s1.jpg'),
(NULL, 23, 'img/sm/s2.jpg','img/md/s2.jpg','img/lg/s2.jpg'),
(NULL, 23, 'img/sm/s3.jpg','img/md/s3.jpg','img/lg/s3.jpg'),
(NULL, 23, 'img/sm/s4.jpg','img/md/s4.jpg','img/lg/s4.jpg'),
(NULL, 23, 'img/sm/s5.jpg','img/md/s5.jpg','img/lg/s5.jpg'),
(NULL, 23, 'img/sm/s6.jpg','img/md/s6.jpg','img/lg/s6.jpg'),
(NULL, 24, 'img/sm/s1.jpg','img/md/s1.jpg','img/lg/s1.jpg'),
(NULL, 24, 'img/sm/s2.jpg','img/md/s2.jpg','img/lg/s2.jpg'),
(NULL, 24, 'img/sm/s3.jpg','img/md/s3.jpg','img/lg/s3.jpg'),
(NULL, 24, 'img/sm/s4.jpg','img/md/s4.jpg','img/lg/s4.jpg'),
(NULL, 24, 'img/sm/s5.jpg','img/md/s5.jpg','img/lg/s5.jpg'),
(NULL, 24, 'img/sm/s6.jpg','img/md/s6.jpg','img/lg/s6.jpg'),

(NULL, 25, 'img/sm/micsorft1.jpg','img/md/micsorft1.jpg','img/lg/micsorft1.jpg'),
(NULL, 25, 'img/sm/micsorft2.jpg','img/md/micsorft2.jpg','img/lg/micsorft2.jpg'),
(NULL, 25, 'img/sm/micsorft3.jpg','img/md/micsorft3.jpg','img/lg/micsorft3.jpg'),
(NULL, 25, 'img/sm/micsorft4.jpg','img/md/micsorft4.jpg','img/lg/micsorft4.jpg'),
(NULL, 25, 'img/sm/micsorft5.jpg','img/md/micsorft5.jpg','img/lg/micsorft5.jpg'),
(NULL, 25, 'img/sm/micsorft6.jpg','img/md/micsorft6.jpg','img/lg/micsorft6.jpg'),
(NULL, 26, 'img/sm/micsorft1.jpg','img/md/micsorft1.jpg','img/lg/micsorft1.jpg'),
(NULL, 26, 'img/sm/micsorft2.jpg','img/md/micsorft2.jpg','img/lg/micsorft2.jpg'),
(NULL, 26, 'img/sm/micsorft3.jpg','img/md/micsorft3.jpg','img/lg/micsorft3.jpg'),
(NULL, 26, 'img/sm/micsorft4.jpg','img/md/micsorft4.jpg','img/lg/micsorft4.jpg'),
(NULL, 26, 'img/sm/micsorft5.jpg','img/md/micsorft5.jpg','img/lg/micsorft5.jpg'),
(NULL, 26, 'img/sm/micsorft6.jpg','img/md/micsorft6.jpg','img/lg/micsorft6.jpg'),
(NULL, 27, 'img/sm/micsorft1.jpg','img/md/micsorft1.jpg','img/lg/micsorft1.jpg'),
(NULL, 27, 'img/sm/micsorft2.jpg','img/md/micsorft2.jpg','img/lg/micsorft2.jpg'),
(NULL, 27, 'img/sm/micsorft3.jpg','img/md/micsorft3.jpg','img/lg/micsorft3.jpg'),
(NULL, 27, 'img/sm/micsorft4.jpg','img/md/micsorft4.jpg','img/lg/micsorft4.jpg'),
(NULL, 27, 'img/sm/micsorft5.jpg','img/md/micsorft5.jpg','img/lg/micsorft5.jpg'),
(NULL, 27, 'img/sm/micsorft6.jpg','img/md/micsorft6.jpg','img/lg/micsorft6.jpg'),
(NULL, 28, 'img/sm/micsorft1.jpg','img/md/micsorft1.jpg','img/lg/micsorft1.jpg'),
(NULL, 28, 'img/sm/micsorft2.jpg','img/md/micsorft2.jpg','img/lg/micsorft2.jpg'),
(NULL, 28, 'img/sm/micsorft3.jpg','img/md/micsorft3.jpg','img/lg/micsorft3.jpg'),
(NULL, 28, 'img/sm/micsorft4.jpg','img/md/micsorft4.jpg','img/lg/micsorft4.jpg'),
(NULL, 28, 'img/sm/micsorft5.jpg','img/md/micsorft5.jpg','img/lg/micsorft5.jpg'),
(NULL, 28, 'img/sm/micsorft6.jpg','img/md/micsorft6.jpg','img/lg/micsorft6.jpg');


/**用户信息**/
INSERT INTO lx_user VALUES
(NULL, 'dingding', '123456', 'ding@qq.com', '13501234567', 'img/avatar/default.png', '丁伟', '1'),
(NULL, 'dangdang', '123456', 'dang@qq.com', '13501234568', 'img/avatar/default.png', '林当', '1'),
(NULL, 'doudou', '123456', 'dou@qq.com', '13501234569', 'img/avatar/default.png', '窦志强', '1'),
(NULL, 'yaya', '123456', 'ya@qq.com', '13501234560', 'img/avatar/default.png', '秦小雅', '0');

/****首页轮播广告商品****/
INSERT INTO lx_index_carousel VALUES
(NULL, 'img/index/banner1.png','轮播广告商品1','product_details.html?lid=28'),
(NULL, 'img/index/banner2.png','轮播广告商品2','product_details.html?lid=19'),
(NULL, 'img/index/banner3.png','轮播广告商品3','lookforward.html'),
(NULL, 'img/index/banner4.png','轮播广告商品4','lookforward.html');

/****首页商品****/
INSERT INTO lx_index_product VALUES
(NULL, '小米Pro 金属轻薄笔记本15.6英寸', 'img/md/mi1.jpg', 5399, 1),
(NULL, '联想小新潮7000 笔记本14英寸','img/md/xiaoxin1.jpg', 4999, 5),
(NULL, '戴尔 XPS笔记本13.3英寸', 'img/md/dell_xps1.jpg', 12999, 9),
(NULL, '惠普 Pro G1 笔记本14英寸','img/md/hppro1.jpg', 6499, 13),
(NULL, '华硕 飞行堡垒6 游戏本15.6英寸','img/md/asus1.jpg', 7299,17),
(NULL, '微软 Surface 笔记本', 'img/md/suffer1.jpg', 4666, 19),
(NULL, '机械革命 S1 笔记本14英寸','img/md/s1.jpg', 5299, 22),
(NULL, '微软 Surface Book 2 13.5英寸', 'img/md/micsorft1.jpg', 8488, 25);



