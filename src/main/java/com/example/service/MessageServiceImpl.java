package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.MessageVO;
import com.example.mapper.MessageMapper;
import com.example.mapper.UserMapper;

@Service
public class MessageServiceImpl implements MessageService {

	@Autowired
	MessageMapper mapper;
	
	@Autowired
	UserMapper uMapper;
	
	@Transactional
	@Override
	public void insert(MessageVO vo) {
		mapper.insert(vo);
		uMapper.updatePoint(vo.getSender(), 10);		
	}

	@Transactional
	@Override
	public MessageVO read(int mid) {
		MessageVO vo = mapper.read(mid);
		uMapper.updatePoint(vo.getReceiver(), 5);
		mapper.updateReadDate(mid);
		return vo;
		
	}
	
}
