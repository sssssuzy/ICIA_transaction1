package com.example.mapper;

import java.util.List;

import com.example.domain.MessageVO;

public interface MessageMapper {
	//보낸메시지 리스트(sender가 보낸)
	public List<MessageVO> listSend(String sender);
		
	//받은메세지 리스트
	public List<MessageVO> listReceive(String receiver);
	
	//메세지 보내기
	public void insert(MessageVO vo);
	
	//메시지 읽기
	public MessageVO read(int mid);
	
	//읽은 날짜 업데이트
	public void updateReadDate(int mid);
	
}
