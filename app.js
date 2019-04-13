//使用express构建服务器
const express = require("express");
const bodyParser = require('body-parser');
const session = require("express-session");
const cors = require("cors");
//引入路由模块
const index = require("./routes/index");
const details = require("./routes/details");
const products = require("./routes/products");
const register = require("./routes/register");
const users = require("./routes/users");


const app = express();
app.use(cors({
    origin: "*",
    credentials: true
}))
var server = app.listen(6060);
//使用body-parser中间件
app.use(bodyParser.urlencoded({extended:false}));
//托管静态资源到public目录下
app.use(express.static('public'));
app.use(session({
    secret: '随机字符串',
    resave: false,
    saveUninitialized: true
}));
/*挂载路由*/
app.use("/index", index);
app.use("/details",details);
app.use("/products",products);
app.use("/register",register);
app.use("/users",users);
