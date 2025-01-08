package com.sgpo.ms.user.auth.dto;

public record LoginResponse(String accessToken, Long expiresIn ) {
}
