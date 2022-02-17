package com.pjg.exam.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.pjg.exam.demo.interceptor.BeforeActionInterceptor;
import com.pjg.exam.demo.interceptor.NeedLoginInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {
	// beforeActionInterceptor 인터셉터 불러오기
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;

	// needLoginInterceptor 인터셉터 불러오기
	@Autowired
	NeedLoginInterceptor needLoginInterceptor;

	// 이 함수는 인터셉터를 적용하는 역할을 합니다.
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**")
				.excludePathPatterns("/error");
		
		// 아래코드로 들어가는 URL 빼고는 간섭하지 않는다.
		registry.addInterceptor(needLoginInterceptor).addPathPatterns("/usr/article/write")
													 .addPathPatterns("/usr/article/doWrite")
													 .addPathPatterns("/usr/article/modify")
													 .addPathPatterns("/usr/article/doModify")
													 .addPathPatterns("/usr/article/doDelete");
	}
}