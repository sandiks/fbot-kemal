module ForumHelper
  def self.get_thread_link(sid, fname, tid)
    case sid
    when 2
      "http://rsdn.ru/forum/#{fname}/#{tid}.flat.1"
    when 3
      "http://www.linux.org.ru/forum/#{fname}/#{tid}"
    when 4
      "http://www.gamedev.ru/#{fname}/forum/?id=#{tid}"
    when 6
      "http://www.sql.ru/forum/#{tid}"
    when 7
      "http://dxdy.ru/topic#{tid}.html"
    when 8
      "https://damagelab.org/index.php?showtopic=#{tid}"
    when 9
      "https://bitcointalk.org/index.php?topic=#{tid}.0"
    end
  end

  def self.get_site_name(sid)
    sites = ["", "", "rsdn", "lor", "gamedev", "onln", "sqlru", "dxdy", "damagelab", "bitcointalk"]
    sites[sid]
  end
end
