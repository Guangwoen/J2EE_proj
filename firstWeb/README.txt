                                            ++<J2EE实践项目-物流管理系统>++
                                            -- 姓名：崔光远
                                            -- 学号：10205101451


>>根据项目需求，仅仅实现了一些最基本的功能，包括用户的登陆，注册；用户可以进行包裹的发货，收货，查看本人订单等一些操作；管理员可以进行对员工的管理（增删改查），
  对订单的管理（增删改查），并且对于用户新生成的订单，分配一个员工来配送这个订单。
>>根据实际情况，将每个员工与每个车辆进行了绑定，这样，在对一个订单分配一个司机时，可以同时分配车辆和司机。


>>项目结构:
>>界面：app子目录下 - index.jsp(入口); manager.jsp(管理员界面); main.jsp(用户界面); {packet_list.jsp和staff_list.jsp都被include进了其他界面中}
>>Servlet: java/com.example.firstweb - Servlet:专门处理登陆和注册的功能; Database_Servlet:专门处理数据库操作; Application_Servlet:用来处理用户
  和管理员的各种功能;
>>JAVA类: java/com.example.firstweb - Car:员工，车辆类; Packet:订单，包裹类; User:用户类;
>>css: 渲染各种页面;
>>js: 动态功能;

>>外部框架/资源: jQuery, Bootstrap

>>数据库: MySQL

>>服务器: Tomcat 9.53