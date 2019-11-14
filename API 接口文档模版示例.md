# ⚠️注意

接口文档中，每个接口都要包含全部的正案例，与部分的反案例，请按如下示例中格式填写。

# 正案例 -- 成功创建用户

## 接口描述

作为用户，当我输入正确格式的参数与字段时，我可以成功创建用户，并返回创建成功信息

**接口调用**

| url          | https://jsonplaceholder.typicode.com/users |
| ------------ | ------------------------------------------ |
| **url 示例** | https://jsonplaceholder.typicode.com/users |
| **请求方式** | POST                                       |

**header**

| key          | value            |
| ------------ | ---------------- |
| Content-Type | application/json |

## 输入参数

### 格式：JSON

| 参数名   | 参数说明 | 参数类型    | 参数规则                    | 示例                                                         | 是否必选 |
| -------- | -------- | ----------- | --------------------------- | ------------------------------------------------------------ | -------- |
| name     | 用户姓名 | string      | 不能超过128位               | User Name Example                                            | 是       |
| username | 用户名   | string      | 不能有特殊字符              | usernameExample                                              | 是       |
| email    | 邮箱地址 | string      | 符合邮箱地址格式规范        | example@example.com                                          | 是       |
| address  | 地址     | json object | 必须包含字段：street，suite | {<br/>  "street": "Has No Name",<br/>  "suite": "Apt. 123",<br/>  "city": "Electri",<br/>  "zipcode": "54321-6789"<br/>} | 是       |

## 输出

HTTP Code：201

**输出参数**

| 参数名   | 参数说明 | 参数类型    | 示例                                                         |
| -------- | -------- | ----------- | ------------------------------------------------------------ |
| name     | 用户姓名 | string      | User Name Example                                            |
| username | 用户名   | string      | usernameExample                                              |
| email    | 邮件地址 | string      | example@example.com                                          |
| address  | 地址     | json object | {<br/>  "street": "Has No Name",<br/>  "suite": "Apt. 123",<br/>  "city": "Electri",<br/>  "zipcode": "54321-6789"<br/>} |
| id       | 用户 id  | int         | 11                                                           |



---

# 反案例 -- 查询不存在的用户

## 接口描述

当我输入一个不存在的用户 ID 为“11” 时，会返回查询不到 404 的 HTTP 返回值

**接口调用**

| url          | https://jsonplaceholder.typicode.com/users/{userId} |
| ------------ | --------------------------------------------------- |
| **url 示例** | https://jsonplaceholder.typicode.com/users/11       |
| **请求方式** | GET                                                 |

**header**

| key  | value |
| ---- | ----- |
| null | null  |

## 输入参数

### 格式：JSON

| 参数名 | 参数说明 | 参数类型 | 参数规则 | 示例 | 是否必选 |
| ------ | -------- | -------- | -------- | ---- | -------- |
| null   | null     | null     | null     | null | null     |

## 输出

HTTP Code：404

**输出参数**

| 参数名 | 参数说明 | 参数类型 | 示例 |
| ------ | -------- | -------- | ---- |
|        |          |          |      |