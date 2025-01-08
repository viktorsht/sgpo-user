package com.sgpo.ms.user.users.dto;

public record MeUserDTO(String id, String name,
                        String email,
                        String phone, boolean IsAdmin) {
}
