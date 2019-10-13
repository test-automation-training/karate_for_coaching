Feature: This is a my test for karate

  Scenario: This is a test for `calling function` in Karate test scenario
#    You can use call function in karate
    Given def x_not_contains_y =
    """
    function(x, y) {
      return x.indexOf(y) == -1
    }
    """

    And def nesting_func =
    """
    function(x, y) {
      return x_not_contains_y(x, y)
    }
    """
    And def foo = [1, 2, 3]

    Then match foo contains 2
    And match x_not_contains_y(foo, 2) == '#boolean? _ == false'
    And match nesting_func(foo, 2) == '#boolean? _ == false'

    Then match foo !contains 4
    And match x_not_contains_y(foo, 4) == '#boolean? _ == true'
    And match nesting_func(foo, 4) == '#boolean? _ == true'

  Scenario: This is a test for `table` keyword
    * def one = 'hello'
    * def two = { baz: 'world' }
    * table json
      | foo     | bar            |
      | one     | { baz: 1 }     |
      | two.baz | ['baz', 'ban'] |
    * match json == [{foo: 'hello', bar: {baz: 1}}, {foo: 'world', bar: ['baz', 'ban']}]

  Scenario: This is a test for `set` keyword
    * set search
      | path       | 0       | 1      | 2       |
      | name.first | 'John'  | 'Jane' |         |
      | name.last  | 'Smith' | 'Doe'  | 'Waldo' |
      | age        | 20      |        |         |
    * match search[0] == { name: { first: John, last: Smith }, age: 20 }
    * match search[1] == { name: { first: Jane, last: Doe }}
    * match search[2] == { name: { last: Waldo }}

  Scenario Outline: This is a test for `example` keyword
#    remember you need to use 'Scenario Outline' if you want to use 'Examples' keyword
    * text example_keyword_test =
    """
    {
      name: "<name>"
    }
    """

    * print example_keyword_test

    Examples:
      | name  |
      | John  |
      | Smith |


  Scenario Outline: This is a test for `Template` keyword
#     from the document you can see that the Scenario Outline and Scenario Template are the same keyword
    * def json =
    """
    {
      id: <id>,
      name: "<name>"
    }
    """
    * match json == {id: '#number? _ < 10', name: '#string? _.length >= 3'}

    Examples:
      | id | name  |
      | 1  | user1 |
      | 2  | user2 |

  Scenario Outline: 这是一个关于汉语支持程度的测试
#     从当前测试出的结果来看，变量名不能使用汉语，但是在 Example 中可以使用汉语，并且能成功替换，测试名字也可以是汉语的
    * def json =
    """
    {
      编号: <编号>,
      名字: "<名字>"
    }
    """
    * match json == {编号: '#number? _ < 10', 名字: '#string? _.length >= 3'}

    Examples:
      | 编号 | 名字  |
      | 1  | 用户1 |
      | 2  | 用户2 |

  Scenario: This is a test for `replace` keyword
#    if you want to use 'replace' keyword you need to match the text first, and then use quote if you want to replace it with string
    * def text = 'hello <one> world ${two} bye <three>'
    * def first = 'cruel'
    * def json = { second: 'good' }

    * replace text
      | token  | value       |
      | one    | first       |
      | ${two} | json.second |
      | three  | '!'         |

    * match text == "hello cruel world good bye !"

    * def greeting = 'hello <someone>!'
    * replace greeting.someone = 'world'
    * print greeting
    Then match greeting == "hello world!"

  Scenario: This is a test for `csv` keyword
#    1. you need to set a rich text to a text var, and then make it as a csv
#       * which means csv cannot accept a rich text
#    2. you cannot enter a ' ' in the text, or it will make your text to become a value with space like " LOL" instead of "LOL"
    * text foo =
    """
    name,type
    Billie,LOL
    Bob,Wild
    """
    * csv bar = foo
    * match bar == [{name: Billie, type: LOL}, {name: Bob, type: Wild}]

  Scenario: This is a test for `read` keyword which will read file from dir
#    1. txt file can be read as string format
#    2. json & yaml & csv file can be read as json format
#    3. xml file can be read as xml format
#    4. js & java & feature file can be eval automatically, by using `call read("*.js")` or `call read("*.feature")`
#    * the reason you may need to call *.feature file is because there maybe some steps that need to be setup first or reuse as a result,
#    * which means this is a dependency test
    * def my_text = read("this:resources/first.txt") + " " + read('this:resources/second.txt')
    * match my_text == "hello world"

  Scenario: This is a test for `type` feature
#    1. you cannot use variable in eval code: java or js, this is because it will eval it directly instead of replace var
#    2. you can use code like below, define a function first and then you can use your var
#    3. since code like `def big = 123123123123123123123`, karate will recognize it as a js code, if its long enough, then it will already be a scientific format, you cannot use bigdecimal to help you.
    * def big = 123123123123123123123
    * string json = { num: '#(big)' }
    * match json == '{"num":1.2312312312312313E20}'

    * def to_big_decimal =
    """
    function(s) {
      return new java.math.BigDecimal(s)
    }
    """
    * def big_string = "123123123123123123123"
    * def new_big = call to_big_decimal big_string
    * string json = { num: '#(new_big)' }
    * match json == '{"num":123123123123123123123}'

  Scenario: This is a test for `JSON` using
#    Actually, Karate will create new field for user automatically, so if the field does not exist, it will create
    Given def json = {foo: 'bar'}
    When set json.hey = 'hello'
    And set json.who = 'world'
    And set json.person = ['user1', 'user2']
    And set json.info =
    """
    {
      createdBy: 'Edward',
      date: 2019-10-12
    }
    """

    When remove json.foo
    Then match json ==
    """
    {
      hey: "hello",
      who: "world",
      person: ["user1", "user2"],
      info: {
        createdBy: "Edward",
        date: 2019-10-12
      }
    }
    """

  Scenario: This is a test for `compare json`
#    You can find that when you use '==' to compare json's content, it doesn't care about order of the json content
    * def json1 = {foo: "hello", bar: "world"}
    * def json2 = {bar: "world", foo: "hello"}

    * match json1 == json2

  Scenario: This is a test for `Set collection`
#    You can find that when you declare an array and said that its index starts from 1, then it will be set to index of 0
#    By the way, if you are trying to create something like this, you can also get successfully created notation
#    So that means, not just for creating new fields, but also will create new json for you
    * set foo.bar
      | path   | value |
      | one    | 1     |
      | two[1] | 21    |
      | two[3] | 22    |
    * print "this is a log for json foo: ", foo
    * match foo == {bar:{one: 1, two: [21, 22]}}

  Scenario: This is a test for `#?` expression
    * def date = {month: 3}
    * match date == {month: '#? _ > 0'}
    * match date == {month: '#number? _ > 0'}

    * def is_valid_month_num = function(m) { return 0 < m && 12 >= m }
    * match date == {month: '#number? is_valid_month_num(_)'}
    * match is_valid_month_num(3) == '#boolean'

  Scenario: This is a test for `json path's .. operator`
#    You can use '..' operator to go through the json path find all fields name is like ***
#    You can use contains only for matching content without order, but the elements should be the same
    * def cat =
    """
    {
      name: 'Billie',
      kittens: [
        {
          id: 23,
          name: "Bob"
        },
        {
          id: 42,
          name: "Wild"
        },
        {
          id: 51,
          name: "Truffle"
        }
      ]
    }
    """
    * match cat..name contains only ["Billie", "Wild", "Bob", "Truffle"]

  Scenario: This is a test for `match each` function
    * def data = {foo: [{bar: 1, baz: "1"}, {bar: 2, baz: "2"}, {bar: 3, baz: "3"}]}
    * match each data.foo == {bar: '#number', baz: '#string'}

  Scenario: This is a test for `array schema`
#    You need to use '#string? ...' as expression if you want to check the length of each element is 3 or others
    * def foo = ['bar', 'baz']
    * match foo == '##[2] #string? _.length >= 3'

    * def users = ['user1', 'user2', 'user3']
    * def user_info_validator = function(user) { return user.length >= 3 }
    * match users == '##[3] #string? user_info_validator(_)'

  Scenario: This is a test for `Karate object`
    * print "OS: ", karate.os
