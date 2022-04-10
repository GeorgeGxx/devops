package com.demo.holamundo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class HolamundoApplication {

	@GetMapping("/hola")
	public String holaMundo(){
		return "Hola Mundo!!";
	}

	public static void main(String[] args) {
		SpringApplication.run(HolamundoApplication.class, args);
	}

}
