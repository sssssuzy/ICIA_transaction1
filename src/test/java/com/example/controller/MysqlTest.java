package com.example.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.domain.UserVO;
import com.example.mapper.MysqlMapper;
import com.example.mapper.UserMapper;

//¸ÕÀú SpringJUnit4ClassRunner.class importÇÑ´Ù.
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MysqlTest {
    @Autowired
    private UserMapper mapper;
    
   @Test
   public void list(){
      mapper.list();
   }
   @Test
   public void insert(){
      UserVO vo = new UserVO();
      vo.setUid("user05");
      vo.setUpw("pass");
      vo.setUname("¸ù·æLee");
      mapper.insert(vo);
   }
   @Test
   public void update(){
      UserVO vo = new UserVO();
      vo.setUid("user05");
      vo.setUpw("pass");
      vo.setUname("¸ù·æ kim");
      mapper.update(vo);
   }
   @Test
   public void read(){
      mapper.read("user05");
   }
   @Test
   public void delete(){
      mapper.delete("user05");
   }
}