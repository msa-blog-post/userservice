package com.choi.userservice.service

import com.choi.userservice.dto.User
import com.choi.userservice.exception.UserNotFoundException
import com.choi.userservice.repository.UserRepository
import org.springframework.stereotype.Service

@Service
class UserService(private val userRepository: UserRepository) {

    fun createUser(user: User): User {
        return userRepository.save(user)
    }

    fun getUserById(id: Long): User {
        return userRepository.findById(id).orElseThrow { UserNotFoundException("User not found with id $id") }
    }

    fun updateUser(id: Long, updatedUser: User): User {
        val user = getUserById(id)
        val userToSave = user.copy(
            username = updatedUser.username,
            email = updatedUser.email,
            password = updatedUser.password
        )
        return userRepository.save(userToSave)
    }

    fun deleteUser(id: Long) {
        val user = getUserById(id)
        userRepository.delete(user)
    }
}