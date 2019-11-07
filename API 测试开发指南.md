## 一、案例设计
1. 需要包含基本的案例
2. 需要包含必要的反案例
3. 需要考量HTTP code的合理性，表意性
4. 参数有取值范围时需要设计边界条件案例
5. 参数中有限取值参数，如布尔型，枚举型等。需要分析等价类并针对性设计案例。
6. 需要考虑空值的情况
7. 需要参考团队的启发式测试列表设计案例。
8. API测试断言完整，需要判断除返回code之外必要的值。
9. 上述所有条件的组合，在符合业务含义的情况下应适当考虑组合测试。

## 二、代码实现
### 1. 依赖管理
使用 Maven/Gradle 管理代码依赖，保证每个测试开发人员都可以在自己的电脑中快速构建起依赖环境

### 2. 命名
团队应共同制定测试用例的命名规范，且命名应当具有业务含义，由于 Karate 使用 Gherkin 语法，因此建议命名采用如
"should return user1 when I get user with id is equal to 1"

### 3. 案例 scenario 的结构规范
请使用 Karate 推荐的 Given、When、Then 的形式组织代码

* Given -- 准备数据
* When -- 被测内容
* Then -- 断言内容

标准测试应该具备断言，以自动完成对测试结果的判断，且断言要具有意义，测试内容如：
* HTTP code 返回值是否正确
* 返回值内容是否符合预期
* etc.

### 4. 包结构设计
建议目前按照被测 API 的名称作为包名，将一个 API 下的测试案例管理起来

### 5. 案例编写
1. 请参见示例代码中，`src/test/java/examples/users/users.feature` 了解 Karate 的真是测试 API 用例的书写方式
2. 请参见示例代码中，`src/test/java/examples/cases/cases.feature` 了解 Karate 的断言表达式
具体细节请见[karate 文档](https://intuit.github.io/karate/)

在案例编写中，务必对每个案例都要进行断言，断言内容：
* HTTP code 返回值
* 返回值内容断言必须具有实际意义

断言具有实际意义，且尽量使用完全匹配，面对如id、时间等难以确认具体值的字段，可使用 karate 的模糊匹配功能，详情请见[karate 文档](https://intuit.github.io/karate/)

### 6. 重构
请在修改/编写 API 测试的时候，一直保持重构的心态：
#### a. 去掉无用的内容
* 删掉 Scenario 中无用代码
* 删掉在提交代码前将代码中测试用的 log 信息
* 删掉无实际意义的注释代码
* 删掉无实际意义的描述代码

#### b. 添加有意义的内容
* 赋予变量有意义的名称
* 添加有描述意义的代码测试场景描述

### 7. 小步提交 & 七步提交法
一般来说，建议 小步提交，即按自己的 Tasking 步骤来的提交，每一小步都有对应的提交信息。这样做的主要目的是：防止一次修改中，修改过多的文件，导致后期修改、维护、撤销等等困难。

请按照以下提交规范提交代码：
* br: 此项特别针对 bug 号，用于向测试反馈 bug 列表的 bug 修改情况
* feat：新功能（feature）
* fix：修补 bug
* docs：文档（documentation）
* style： 格式（不影响代码运行的变动）
* refactor：重构（即不是新增功能，也不是修改 bug 的代码变动）
* test：增加测试
* chore：构建过程或辅助工具的变动
* revert: 撤销之前的 commit

⚠️示例提交规范：

refactor: rename files
feat(#12): add search multi keywords test scenario
