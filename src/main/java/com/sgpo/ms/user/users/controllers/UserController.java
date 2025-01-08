package com.sgpo.ms.user.users.controllers;

import com.sgpo.ms.user.users.dto.MeUserDTO;
import com.sgpo.ms.user.users.dto.UserCreateDTO;
import com.sgpo.ms.user.users.entities.Role;
import com.sgpo.ms.user.users.entities.Users;
import com.sgpo.ms.user.users.mapper.UserMapper;
import com.sgpo.ms.user.users.repositories.RolesRepository;
import com.sgpo.ms.user.users.repositories.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/users")
public class UserController {
    private final UserRepository userRepository;
    private final RolesRepository rolesRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public UserController(UserRepository userRepository,
                          RolesRepository rolesRepository,
                          BCryptPasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.rolesRepository = rolesRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional
    @PostMapping("/register")
    public ResponseEntity<Void> newUser(@RequestBody UserCreateDTO dto) {
        System.out.println(dto.email());
        var basicRole =  rolesRepository.findByName(Role.Values.Client.name());
        System.out.println(basicRole);

        var userFromDb = userRepository.findByEmail(dto.email());
        if (userFromDb.isPresent()) {
            throw new ResponseStatusException(HttpStatus.UNPROCESSABLE_ENTITY);
        }

        var user = new Users();
        user.setEmail(dto.email());
        user.setName(dto.name());
        user.setPhone(dto.phone());
        user.setPassword(passwordEncoder.encode(dto.password()));
        user.setRoles(Set.of(basicRole));

        userRepository.save(user);
        return ResponseEntity.ok().build();
    }


    @GetMapping("/me")
    public ResponseEntity<MeUserDTO> getCurrentUser(JwtAuthenticationToken token) {
        var user = userRepository.findById(UUID.fromString(token.getName()));
        return user
                .map(users -> ResponseEntity.ok(UserMapper.userToMeUserDTO(users)))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.FORBIDDEN).build()
                );
    }

    boolean isAdmin(Users user){
        var scopes = user.getRoles()
                .stream()
                .map(Role::getName)
                .collect(Collectors.joining(" "));
        return scopes.equals("Admin");
    }

    @GetMapping()
    public List<MeUserDTO> getAllUsers() {
        var listUsers =  userRepository.findAll(); // Retorna todos os usuários da tabela
        return listUsers.stream()
                .map(UserMapper::userToMeUserDTO)
                .collect(Collectors.toList());
    }


}
