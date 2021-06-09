package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.UserVO;
import com.example.mapper.UserMapper;

@Controller
@RequestMapping("/user/")
public class UserController {
	@Autowired
	UserMapper mapper;

	@RequestMapping("/")
	public String list(){
		return "/user/list";
	}
	
	@RequestMapping("list.json")
	@ResponseBody
	public List<UserVO> listJson() {
		return mapper.list();
	}

	@RequestMapping(value="insert", method=RequestMethod.POST)
	@ResponseBody
	public void insert(UserVO vo) {
		mapper.insert(vo);
	}

	@RequestMapping(value="update", method=RequestMethod.POST)
	@ResponseBody
	public void update(UserVO vo) {
		mapper.update(vo);
	}

	@RequestMapping("read")
	@ResponseBody
	public UserVO read(String uid) {
		return mapper.read(uid);
	}

	@RequestMapping(value="delete", method=RequestMethod.GET)
	@ResponseBody
	public void delete(String uid) {
		mapper.delete(uid);
	}
}
