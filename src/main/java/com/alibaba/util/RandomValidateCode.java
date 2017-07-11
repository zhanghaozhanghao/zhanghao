package com.alibaba.util;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Random;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * author : cnzxzc
 */
public class RandomValidateCode {
    private Random random = new Random();
    private int width = 80;//图片宽
    private int height = 26;//图片高
    private int lineNum = 5;//干扰线数量
    private int pointNum = 30;//噪点数量
    private int stringNum = 4;//随机产生字符数量
    private Font font = new Font("Times New Roman", Font.ROMAN_BASELINE, 18);
    private char[] index = {'a','A','0'};//验证码索引
    /**
     * 生成验证码字符串
     */
    private char[] getValidateString(){
        char[] c = new char[stringNum];
        for(int i = 0; i<stringNum; i++) {
            int offset = random.nextInt(3);
            switch (offset) {
                case 0:
                case 1:
                    c[i] = (char) ((int) index[offset] + random.nextInt(26));
                    break;
                case 2:
                    c[i] = (char) ((int) index[offset] + random.nextInt(10));
                    break;
            }
        }
        return c;
    }
    /**
     * 生成图片
     * */
    public void makeValidateImage(HttpServletRequest request, HttpServletResponse response){
        //验证码
        char[] text = getValidateString();
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();
        g.setFont(font);
        g.setColor(Color.GREEN);
        g.drawRect(0, 0, width, height);
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, width, height);
        //绘制干扰线
        drowLine(g);
        //绘制噪点
        drowPoint(g);
        //绘制随机字符
        drowString(g, text);
        try {
            request.getSession().setAttribute("validateCode", new String(text));
            ImageIO.write(image, "JPEG",  response.getOutputStream());
        } catch (Exception e){
            e.printStackTrace();
        }finally {
            g.dispose();
        }
    }
    /**
     * 绘制字符串
     * */
    private void drowString(Graphics g, char[] text){
        g.setColor(new Color(random.nextInt(101), random.nextInt(111), random.nextInt(121)));
        int x = random.nextInt(width);
        int y = random.nextInt(height);
        //防止画图画出范围
        while(x>25){ x -= 20; }
        while(y<13){ y += 10; }
        g.drawChars(text, 0, stringNum, x, y);
    }
    /**
     * 绘制干扰线
     */
    private void drowLine(Graphics g){
        for(int i = 0; i < lineNum; i++) {
            g.setColor(new Color(random.nextInt(101), random.nextInt(111), random.nextInt(121)));
            int x1 = random.nextInt(width);
            int y1 = random.nextInt(height);
            int x2 = random.nextInt(width);
            int y2 = random.nextInt(height);
            g.drawLine(x1, y1, x2, y2);
        }
    }
    /**
     * 绘制噪声点
     */
    private void drowPoint(Graphics g){
        for(int i = 0; i < pointNum; i++) {
            g.setColor(new Color(random.nextInt(101), random.nextInt(111), random.nextInt(121)));
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            g.drawLine(x, y, x, y);
        }
    }
}