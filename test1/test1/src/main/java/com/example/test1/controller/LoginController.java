package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.LoginService;
import com.example.test1.model.Bbs;
import com.example.test1.model.User;
import com.google.gson.Gson;

@Controller
public class LoginController {
	
	@Autowired
	private LoginService loginService;

	@RequestMapping("/login.do") 	// 주소 이름 만들기
    public String login(Model model) throws Exception{

        return "/login";		//실행 시킬 파일
    }
	
	@RequestMapping("/join.do") 	// 주소 이름 만들기
	public String join(Model model) throws Exception{
		
		return "/join";		//실행 시킬 파일
	}
	
	@RequestMapping(value = "/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchUserInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = loginService.searchUserInfo(map);
		return new Gson().toJson(resultMap);
	}
	
}