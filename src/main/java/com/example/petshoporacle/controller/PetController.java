package com.example.petshoporacle.controller;

import com.example.petshoporacle.model.Pet;
import com.example.petshoporacle.service.PetService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/pets")
public class PetController {

    private final PetService service;

    public PetController(PetService service) {
        this.service = service;
    }

    @GetMapping
    public String list(Model model) {
        model.addAttribute("pets", service.listAll());
        return "pets/list";
    }

    @GetMapping("/new")
    public String createForm(Model model) {
        model.addAttribute("pet", new Pet());
        return "pets/form";
    }

    @PostMapping("/save")
    public String save(@Valid @ModelAttribute("pet") Pet pet, BindingResult result) {
        if (result.hasErrors()) {
            return "pets/form";
        }
        service.save(pet);
        return "redirect:/pets";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        return service.getById(id)
                .map(pet -> {
                    model.addAttribute("pet", pet);
                    return "pets/form";
                })
                .orElse("redirect:/pets");
    }

    @GetMapping("/view/{id}")
    public String view(@PathVariable Long id, Model model) {
        return service.getById(id)
                .map(pet -> {
                    model.addAttribute("pet", pet);
                    return "pets/view";
                })
                .orElse("redirect:/pets");
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        service.delete(id);
        return "redirect:/pets";
    }
}
