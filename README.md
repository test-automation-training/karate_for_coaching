# Karate for coaching
## 前言
推荐使用 IDE：Intellij IDEA
## 一、使用工具、依赖
使用 Maven 管理依赖
1. [karate](https://intuit.github.io/karate/)
2. junit 5
3. cucumber report

## 二、运行
1. `mvn test` 运行全部测试（或`mvn test -Dtest=*test`，详情请见 Karate 文档）
2. Intellij 中直接运行测试会使用 Junit 引擎运行测试

## 三、内容
1. cases 包下包含了 Karate 常用的一些表达式示例
2. users 包下包含了两个连接 jsonplaceholder 进行 mock api 测试的连通示例

⚠️注意：测试 users 案例是请连接网络

## 附1：新建项目
如果想新建一个项目，可使用命令：
```shell script
mvn archetype:generate \
-DarchetypeGroupId=com.intuit.karate \
-DarchetypeArtifactId=karate-archetype \
-DarchetypeVersion=0.9.4 \
-DgroupId=com.mycompany \
-DartifactId=myproject
```
但是，本身构建出的项目在运行测试时会报错，这是因为 pom 文件并没有完全配置好
详情请见：[‘mvn test’ doesn’t run tests · Issue #823 · intuit/karate · GitHub](https://github.com/intuit/karate/issues/823)

## 附2：目录结构
```.
├── main
│   ├── java
│   └── resources
└── test
    └── java
        ├── examples
        │   ├── ExamplesTest.java
        │   ├── cases
        │   │   ├── CasesRunner.java
        │   │   ├── cases.feature
        │   │   └── resources/
        │   └── users
        │       ├── UsersRunner.java
        │       └── users.feature
        └── karate-config.js
```