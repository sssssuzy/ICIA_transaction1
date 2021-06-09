package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.UserVO;

public interface UserMapper {
	public List<UserVO> list();
	   public UserVO read(String uid);
	   public void delete(String uid);
	   public void update(UserVO vo);
	   public void insert(UserVO vo);
	   public void updatePoint(@Param("uid") String uid,@Param("amount") int amount);
}
