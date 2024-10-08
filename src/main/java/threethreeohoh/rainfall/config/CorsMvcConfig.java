package threethreeohoh.rainfall.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsMvcConfig implements WebMvcConfigurer { // 일반 Controller의 CORS 설정

    @Override
    public void addCorsMappings(CorsRegistry corsRegistry) { // 모든 Controller 경로에 대해 http://localhost:3000 에서 오는 요청을 허용
        corsRegistry.addMapping("/**")
                .allowedOrigins("http://3.35.231.194:8080", "http://13.209.187.32:3000", "http://localhost:3000", "http://43.200.165.138:3000") // 사실 cors 설정은 클라우드 쪽에서 리버스 프록시로 사용해도 가능하다..
                .allowedMethods("*")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }
}