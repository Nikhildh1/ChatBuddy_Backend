package com.chatbuddy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chatbuddy.model.Users;
import com.chatbuddy.repo.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public Users registerUser(Users user) throws Exception {
        if (userRepository.findByEmail(user.getEmail()).isPresent()) {
            throw new Exception("User already exists");
        }
        return userRepository.save(user);
    }

    public Users loginUser(String email, String password) throws Exception {
        Users user = userRepository.findByEmail(email)
            .orElseThrow(() -> new Exception("User not found"));
        if (!user.getPassword().equals(password)) {
            throw new Exception("Invalid password");
        }
        return user;
    }
}	
