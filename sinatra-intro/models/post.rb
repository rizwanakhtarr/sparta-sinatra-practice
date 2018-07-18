class Post
  attr_accessor :id, :title, :body

  def self.open_connection
    conn = PG.connect(dbname: "blog", user: "postgres", password: "rizwanakhtar786.")
  end

  def self.all
    conn = self.open_connection

    sql = "SELECT * FROM post ORDER BY id"

    results = conn.exec(sql)

    posts = results.map do |data|
      self.hydrate data
    end

    return posts
  end

  def self.hydrate post_data
    post = Post.new

    post.id = post_data["id"]
    post.title = post_data["title"]
    post.body = post_data["body"]

    return post
  end

  def self.find id
    conn = self.open_connection

    sql = "SELECT * FROM post WHERE id = #{id}"

    posts = conn.exec(sql)

    return self.hydrate posts[0]
  end

  def save
    conn = Post.open_connection

    if !self.id
      sql = "INSERT INTO post (title, body) VALUES ('#{self.title}', '#{self.body}')"
    else
      sql = "UPDATE post SET title='#{self.title}', body='#{self.body}' WHERE id = #{self.id}"
    end
    conn.exec(sql)
  end

  def self.destroy id
    conn = self.open_connection

    sql = "DELETE FROM post WHERE id = #{id}"

    conn.exec(sql)
  end







end
