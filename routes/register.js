const express = require("express");
const router = express.Router();
const pool = require("../pool.js");

//注册
router.post("/",(req,res)=>{
    var uname = req.body.uname;
    var upwd = req.body.upwd;
    var sql = "INSERT INTO lx_user VALUES(NULL,?,?,NULL,NULL,NULL,NULL,NULL)";
    pool.query(sql,[uname,upwd],(err,result)=>{
        if(err) throw err;
        res.send({ code: 200, msg: 'register suc' });
    });
});
module.exports = router;