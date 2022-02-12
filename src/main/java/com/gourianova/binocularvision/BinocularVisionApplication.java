package com.gourianova.binocularvision;

import com.gourianova.binocularvision.model.User;
import com.gourianova.binocularvision.repo.UserRepo;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.math.BigDecimal;
import java.time.LocalDate;

@SpringBootApplication
public class BinocularVisionApplication {

	public static void main ( String[] args ) {
		SpringApplication.run (BinocularVisionApplication.class, args);
	}

	@Bean
	CommandLineRunner commandLineRunner ( UserRepo userRepo ) {
		return args -> {
			User u1 = new User (
					BigDecimal.valueOf (215.06),
					LocalDate.now (),
					"Tatiana",
					"Gourianova",
					"tg",
					"Tatiana",
					2
			);

			userRepo.save (u1);



			};
	}

}
