package com.example.petshoporacle.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import java.time.LocalDate;

@Entity
@Table(name = "PETS")
@SequenceGenerator(name = "pet_seq", sequenceName = "PETS_SEQ", allocationSize = 1)
public class Pet {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "pet_seq")
    private Long id;
}
