# Karate for coaching
## 一、使用工具、依赖
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

## 四、规范
1. 团队统一命名规范并对案例保持维护
2. 请使用合理命名的方式对你的测试案例命名，如 `example_name_for_test_case` 或 `exampleNameForTestCase`
3. 每次提交前都要保证自己的测试是可以通过的
4. 写测试案例时请勿使用你电脑中的绝对路径
5. 时刻关注团队的 CI 构建、测试情况
6. 要与团队合作紧密
7. etc.

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