package com.example.mapper;

import java.util.List;

import com.example.domain.MessageVO;

public interface MessageMapper {
	//�����޽��� ����Ʈ(sender�� ����)
	public List<MessageVO> listSend(String sender);
		
	//�����޼��� ����Ʈ
	public List<MessageVO> listReceive(String receiver);
	
	//�޼��� ������
	public void insert(MessageVO vo);
	
	//�޽��� �б�
	public MessageVO read(int mid);
	
	//���� ��¥ ������Ʈ
	public void updateReadDate(int mid);
	
}
