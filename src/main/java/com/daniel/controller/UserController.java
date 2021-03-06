package com.daniel.controller;

import com.daniel.common.Result;
import com.daniel.common.ResultGenerator;
import com.daniel.pojo.User;
import com.daniel.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.io.IOException;

@RestController

@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    // 日志文件
    private static final Logger log = Logger.getLogger(UserController.class);

    @RequestMapping("")
    public ModelAndView login() {
        return new ModelAndView("login");
    }

    @RequestMapping("/register")
    public ModelAndView goRegister(){
        ModelAndView mav = new ModelAndView("register");
        return mav;
    }
    /**
     * 验证登录
     * @param user 用户输入的学号与密码封装成的User对象
     * @param request 登录成功时将user存入session当中
     * @return 登录成功后跳转至首页
     */
    @RequestMapping(value = "/sessions",method = RequestMethod.POST)
    @ResponseBody
    public Result checkLogin(@RequestBody User user, HttpServletRequest request) {
        // userService验证是否登录成功
        boolean flag = userService.checkUser(user);
        log.info("request: user/login , user: " + user.toString());
        if (flag) {
            Map data = new HashMap();
            data.put("currentUser",user);
            // 登录成功，将登录信息放入session
            request.getSession().setAttribute("user",userService.getByStudentid(user.getStudentid()));
            return ResultGenerator.genSuccessResult(data);
        }else {
            return ResultGenerator.genFailResult("学号或密码输入错误！");
        }
    }

    /**
     * 登出操作
     * @param request 用于获取session中的User对象
     * @return 登出后跳转至登录界面
     */
    @RequestMapping(value = "/sessions",method = RequestMethod.DELETE)
    public Result logout(HttpServletRequest request) {
        request.getSession().removeAttribute("user");
        return ResultGenerator.genSuccessResult();
    }

    //注册
    @RequestMapping(value = "/register",method = RequestMethod.POST)
    @ResponseBody
    public Result addUser(@RequestBody User user){
    try {
        if (user != null) {
            userService.add(user);
            log.info("request: user/upload , user: " + user.toString());
            return ResultGenerator.genSuccessResult();
        } else {
            return ResultGenerator.genFailResult("请完善注册信息！");
        }
        } catch (Exception e) {
            e.printStackTrace();
            return ResultGenerator.genFailResult("该账号已注册！");
        }
    }

    @RequestMapping(value = "/updateUser",method = RequestMethod.GET)
    public ModelAndView goEditUser(){
        return new  ModelAndView("editUser");
    }

    @RequestMapping(value = "/changePassword",method = RequestMethod.GET)
    public ModelAndView goChangePassword(){
        return new  ModelAndView("changePassword");
    }
    @RequestMapping(value = "/changePassword",method = RequestMethod.POST)
    public Result changePassword(HttpServletRequest request,User user){
        User cUser = (User) request.getSession().getAttribute("user");
        if (user != null) {
            cUser.setPassword(user.getPassword());
            userService.update(cUser);
            log.info("request: user/update , user: " + user.toString());
            return ResultGenerator.genSuccessResult();
        } else {
            return ResultGenerator.genFailResult("修改失败");
        }
    }


    @RequestMapping(value = "/updateUser",method = RequestMethod.POST)
    public Result editUser(HttpServletRequest request,User user){
        User cUser = (User) request.getSession().getAttribute("user");
        if (user != null) {
            cUser.setAddress(user.getAddress());
            cUser.setMajor(user.getMajor());
            cUser.setName(user.getName());
            cUser.setSex(user.getSex());
            cUser.setTel(user.getTel());
            userService.update(cUser);
            log.info("request: user/update , user: " + user.toString());
            return ResultGenerator.genSuccessResult();
        } else {
            return ResultGenerator.genFailResult("修改失败");
        }
    }

}
