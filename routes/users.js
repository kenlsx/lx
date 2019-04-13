const express = require("express");
const router = express.Router();
const pool = require("../pool");

//登录
router.post("/signin",(req,res)=>{
    var {uname,upwd}=req.body;
    var sql="SELECT * FROM lx_user WHERE uname=? AND upwd=?";
    pool.query(sql,[uname,upwd],(err,result)=>{
        if(err) throw err;
        if(result.length>0){
            req.session.uid = result[0].uid;
            res.send({ok:1});
        }else{
            res.send({ok:0,msg:"用户名或密码错误"});
        }
    })
});

//判断是否已登录
router.get("/islogin",(req,res)=>{
  if(req.session.uid!==undefined){
    var uid=req.session.uid;
    var sql="SELECT * FROM lx_user WHERE uid=?";
    pool.query(sql,[uid],(err,result)=>{
      if(err) throw(err);
      res.send({ok:1,uname:result[0].uname})
    })
  }else{
    res.send({ok:0})
  }
})

//注销
router.get("/signout",(req,res)=>{
 req.session.uid=undefined;
 res.send();
})

//向购物车添加商品
router.get("/",(req,res)=>{
  if(req.session.uid!==undefined){
    var uid = req.session.uid;
    var lid = req.query.lid;
    var num = req.query.num;
    var sql = "INSERT INTO lx_shoppingcart_item VALUES(NULL,?,?,?,false)";
    pool.query(sql,[uid,lid,num],(err,result)=>{
      if(err) throw err;
      res.send({ok:1})
    });
  }else{
    res.send({ok:0})
  }
})

//购物车
router.get("/cart",(req,res)=>{
  if (req.session.uid !== undefined) {
    var uid = req.session.uid;
    var obj = {};
    var i = 0;
    var sql = "SELECT count FROM lx_shoppingcart_item WHERE user_id=?";
    pool.query(sql,[uid],(err,result)=>{
      if(err) throw err;
      obj.count =  result[0];
      i+=50;
      if(i==100){
        res.send(obj)
      }
    });

    var sql = "SELECT * FROM lx_laptop WHERE lid=(SELECT product_id FROM lx_shoppingcart_item WHERE user_id=?)";
    pool.query(sql,[uid],(err,result)=>{
      if(err) throw err;
      obj.products = result;
      i+=50;
      if(i==100){
        res.send(obj)
      }
    })

  }else{
    res.send({ok:0})
  }
})

module.exports = router;