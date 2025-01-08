package com.sgpo.ms.user.users.dto;

public record UserCreateDTO(
        String name,
        String email,
        String phone,
        String password
) {
}
