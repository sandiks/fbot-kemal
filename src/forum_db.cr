DB = PG.connect("postgres://postgres:12345@localhost:5432/fbot")

class Forum
  def self.all
    result = DB.exec("select siteid, fid, name from forums").rows
  end

  def self.main_forums
    DB.exec("select * from main_forums").rows
  end

  def self.grouped_forums(group_id)
    DB.exec("select siteid, fid from site_forums where mfid=$1", [group_id]).rows
  end

  def self.site_forums(sid)
    DB.exec("select * from forums where siteid=$1 order by fid", [sid]).rows
  end

  def self.site_threads(sid, fid, size = 50)
    DB.exec({Int32, Int32, Int32, String, Time, Int32},
      "select siteid,fid,tid,title,updated,responses from threads where siteid=$1 and fid=$2 order by updated desc  limit $3", [sid, fid, size]).rows
  end

  def self.forum_name(sid, fid)
    DB.exec("select title from forums where siteid=$1 and fid=$2", [sid, fid]).rows.first[0]
  end
end
