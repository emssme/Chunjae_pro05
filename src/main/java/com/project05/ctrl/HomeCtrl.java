package com.project05.ctrl;

import com.project05.entity.ProductVO;
import com.project05.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class HomeCtrl {

    @Autowired
    private ProductService productService;

    @RequestMapping("/")
    public String home(Model model) {
//        List<ProductVO> popularProducts = productService.popularProducts();
//
//        model.addAttribute("popularProducts", popularProducts);
        return "/index";
    }

    @RequestMapping("/home")
    public String home2(Model model) {
        List<ProductVO> popularProducts = productService.popularProducts();

        model.addAttribute("popularProducts", popularProducts);
        return "/index";
    }

}
