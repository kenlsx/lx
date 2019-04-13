const express = require("express");
const router = express.Router();
const pool = require("../pool.js");

router.get("/",(req,res)=>{
    var lid = req.query.lid;
    obj = { product: {}, specs: [], pics: [] };
    (async function(){
        //1.查询商品信息和规格
        var sql = "SELECT * FROM lx_laptop WHERE lid=?";
        await new Promise(function(open){
           pool.query(sql, [lid], (err, result) => {
               if (err) throw err;
               obj.product = result[0];
               open();
           });
        })
        //2. 按lid查询规格列表
        var sql = "SELECT lid, spec FROM lx_laptop WHERE family_id=(SELECT family_id FROM lx_laptop WHERE lid=?)";
        await new Promise(function(open){
            pool.query(sql,[lid],(err,result)=>{
                if(err) throw err;
                obj.specs = result;
                open();
            });
        });
        //3. 按lid查询图片列表
        var sql = "SELECT * FROM lx_laptop_pic WHERE laptop_id=?";
        await new Promise(function(open){
            pool.query(sql,[lid],(err,result)=>{
                if(err) throw err;
                obj.pics = result
                open();
            })
        })
        res.send(obj);
    })()
});
module.exports = router;