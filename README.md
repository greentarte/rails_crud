### Rails CRUD

* ORM(Object Relational Mapper)

  * rails에서는 [ActiveRecord](https://guides.rorlab.org/active_record_basics.html)를 활용한다.

* Controller 생성

  ```console
  $ rails g controller posts index new create show edit update destroy
  ```

* Model 생성

  ```console
  $ rails generate model post
  ```

  * `app/model/post.rb`
  * `db/migrate/20180619_create_posts.rb`

* `migration 파일` 변경

  ```ruby
  # db/migrate/20180619_create_posts.rb
  class CreatePosts < ActiveRecord::Migration
    def change
      create_table :posts do |t|
        t.string :title
        t.text :body

        t.timestamps null: false
      end
    end
  end
  ```

  ```console
  $ rake db:migrate
  == 20180619044117 CreatePosts: migrating ======================================
  -- create_table(:posts)
     -> 0.0131s
  == 20180619044117 CreatePosts: migrated (0.0132s) =============================
  ```

  * `db/schema.rb` 에 반영이 되었는지 확인!!

* CRUD

  * Create : `new`, `create`
  * Read : `show`
  * Update : `edit` , `update`
  * Destroy : `destroy`

* Create

  ```
  irb(main):001:0 > Post.create(title: "제목", body: "내용")
     (0.1ms)  begin transaction
    SQL (5.3ms)  INSERT INTO "posts" ("title", "body", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "제목"], ["body", "내용"], ["created_at", "2018-06-19 08:29:59.313013"], ["updated_at", "2018-06-19 08:29:59.313013"]]
     (3.9ms)  commit transaction
  => #<Post id: 1, title: "제목", body: "내용", created_at: "2018-06-19 08:29:59", updated_at: "2018-06-19 08:29:59">

  ```

* Read

  ```
  irb(main):001:0 > Post.find(id)
     (0.1ms)  begin transaction
    SQL (5.3ms)  INSERT INTO "posts" ("title", "body", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "제목"], ["body", "내용"], ["created_at", "2018-06-19 08:29:59.313013"], ["updated_at", "2018-06-19 08:29:59.313013"]]
     (3.9ms)  commit transaction
  => #<Post id: 1, title: "제목", body: "내용", created_at: "2018-06-19 08:29:59", updated_at: "2018-06-19 08:29:59">
  irb(main):002:0> Post.find(1)
    Post Load (1.9ms)  SELECT  "posts".* FROM "posts" WHERE "posts"."id" = ? LIMIT 1  [["id", 1]]
  => #<Post id: 1, title: "제목", body: "내용", created_at: "2018-06-19 08:29:59", updated_at: "2018-06-19 08:29:59">


  ```



* Update

  ```
  irb(main):001:0 > post = Post.find(id)
  irb(main):002:0 > post.update(title: "변경", body: "변경")
  irb(main):003:0> Post.find(1).update(title: "변경", body: " 변경")
    Post Load (1.8ms)  SELECT  "posts".* FROM "posts" WHERE "posts"."id" = ? LIMIT 1  [["id", 1]]
     (0.1ms)  begin transaction
    SQL (8.1ms)  UPDATE "posts" SET "title" = ?, "body" = ?, "updated_at" = ? WHERE "posts"."id" = ?  [["title", "변경"], ["body", "변경"], ["updated_at", "2018-06-19 08:31:14.239322"], ["id", 1]]
     (5.7ms)  commit transaction
  => true
  ```

* Destroy

  ```
  irb(main):001:0 > Post.find(id).destroy
    Post Load (1.9ms)  SELECT  "posts".* FROM "posts" WHERE "posts"."id" = ? LIMIT 1  [["id", 1]]
     (0.1ms)  begin transaction
    SQL (6.5ms)  DELETE FROM "posts" WHERE "posts"."id" = ?  [["id", 1]]
     (5.6ms)  commit transaction
  => #<Post id: 1, title: "변경", body: "변경", created_at: "2018-06-19 08:29:59", updated_at: "2018-06-19 08:31:14">
  ```



### [Rails flash message](https://guides.rorlab.org/action_controller_overview.html#flash)

```ruby
def destroy
   flash[:alert] = "삭제되었습니다."
end
```

```erb
<%= flash[:alert] %>
```

### [Rails partial](https://guides.rorlab.org/layouts_and_rendering.html#%ED%8C%8C%EC%85%9C-partial-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0)

`app/views/layout/_flash.html.erb`

```erb
<%= render 'layout/flash' %>
```

### Rails CRUD



`$ rails g controller index`

` $ rails g model post`

```ruby
#db\migrate\~~~_posts.db
class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title #추가 부분
      t.text :body #추가 부분
      t.timestamps
    end
  end
end
```

반드시 위 추가 이후 migrate를 해야 schema가 최신화 됨!! 반드시!!

`rake db:migrate`

```ruby
#db\migrate\schema.rb
ActiveRecord::Schema.define(version: 2018_06_19_011308) do

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
```



DB 삭제(window환경에서는 drop error 발생함)

- db/migrate/developmetn.sqlite3 지우고 ~~~_posts.rb 수정 후 다시 `rake db:migrate`

` rake db:drop`



##### Cosole로 DB관리

`rails console`

```cmd
##In rails console

##Post model 확인
> Post.all

#irb(main):001:0> Post.all
#  Post Load (13.5ms)  SELECT  "posts".* FROM "posts" LIMIT ?  
# [["LIMIT", 11]]
#=> #<ActiveRecord::Relation []>

## insert test data
> Post.create(title:"test",body:"test")

#irb(main):002:0> Post.create(title:"test",body:"test")
#   (0.3ms)  begin transaction
#  Post Create (22.9ms)  INSERT INTO "posts" ("title", "body", #"created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "test"],
#["body", "test"], ["created_at", "2018-06-19 01:39:44.133587"],
#["updated_at", "2018-06-19 01:39:44.133587"]]
#   (34.4ms)  commit transaction
#=> #<Post id: 1, title: "test", body: "test", created_at: "2018-06-19 #01:39:44", updated_at: "2018-06-19 01:39:44">


```



#### DB GUI에서 관리하기

- Gemfile

```ruby
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rails_db'  ### 이gem 추가
end

```

항상 gem 추가 후

`bundle install`

`http://localhost:3000/rails/db`



##### Data visualization

```ruby
#routes.rb
root 'post#index'
get 'post/index' => 'post#index'
```

```erb
<!--Index.html.erb-->

<h1>Post#index</h1>

<% @posts.each do |post|%>
    <p><%= post.id%></p>
    <p><%= post.title%></p>
    <p><%= post.body%></p>
    <p><%= post.created_at%></p>
<%end%>
```

```ruby
#post_controller.rb
def index
    @posts = Post.all
end
```
