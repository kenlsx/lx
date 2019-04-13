const express=require("express")
const router=express.Router()
const pool=require("../pool")

///products
router.get("/",(req,res)=>{
  var kw=req.query.kw;
  var kws=kw.split(" ");
  kws.forEach((elem,i,kws)=>
    kws[i]=` title like '%${elem}%' `)
  var where=` where ${kws.join(" and ")} `
  var sql=`SELECT *,(
    select md from lx_laptop_pic
    where laptop_id=lid
    limit 1
  ) as md
  FROM lx_laptop `;
  sql+=where;
  //var pno=req.query.pno;
  pool.query(sql,[],(err,result)=>{
    if(err) console.log(err);
    data={};//新建结果对象
    data.pno=req.query.pno;//在结果对象中添加pno属性
    //用查询结果的总数/12,上取整，获得总页数，放入结果data中
    data.pageCount=Math.ceil(result.length/12)
    //仅截取查询结果中的pno*12还是的12条记录，放入data中
    data.products=result.slice(data.pno*12,data.pno*12+12)
    res.send(data);
  })
})

module.exports=router