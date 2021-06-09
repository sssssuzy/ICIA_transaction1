package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.MessageVO;
import com.example.domain.UserVO;
import com.example.mapper.MessageMapper;
import com.example.mapper.UserMapper;
import com.example.service.MessageService;

@Controller
@RequestMapping("/message/")
public class MessageController {
	@Autowired
	UserMapper uMapper;
	
	@Autowired
	MessageMapper mMapper;
	
	@Autowired
	MessageService service;
	
	@RequestMapping("sendList")
	public String sendList(String sender,Model model){
		model.addAttribute("vo",uMapper.read(sender));
		model.addAttribute("userList",uMapper.list());
		return "/message/sendList";
	}
	@RequestMapping("receiveList")
	public String receiveList(String receiver,Model model){
		model.addAttribute("vo",uMapper.read(receiver));
		return "/message/receiveList";
	}
	@RequestMapping("send.json")
	@ResponseBody
	public List<MessageVO> send(String sender) {
		return mMapper.listSend(sender);
	}
	
	@RequestMapping("read.json")
	@ResponseBody
	public MessageVO read(int mid) {
		return service.read(mid);
	}
	
	@RequestMapping("receive.json")
	@ResponseBody
	public List<MessageVO> receiver(String receiver) {
		return mMapper.listReceive(receiver);
	}
	
	@RequestMapping(value="insert",method=RequestMethod.POST)
	@ResponseBody
	public void insert(MessageVO vo){
		service.insert(vo);
	}
}
