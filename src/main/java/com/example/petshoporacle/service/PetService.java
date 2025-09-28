package com.example.petshoporacle.service;

import com.example.petshoporacle.model.Pet;
import com.example.petshoporacle.repository.PetRepository;
import org.springframework.stereotype.Service;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

@Service
public class PetService {
    private final PetRepository repo;

    public PetService(PetRepository repo) {
        this.repo = repo;
    }

    public List<Pet> listAll() {
        return repo.findAll();
    }

    public Pet save(Pet pet) {
        return repo.save(pet);
    }

    public Optional<Pet> getById(Long id) {
        return repo.findById(id);
    }

    public void delete(Long id) {
        repo.deleteById(id);
    }
}
