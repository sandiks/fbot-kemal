require "kemal"
require "pg"
require "./forum_db"
require "./helpers/forum_helper"

class ForumController
  get "/" do
    mforums = Forum.main_forums
    mforums_threads = Hash(Int32, Array({Int32, Int32, Int32, String, Time, Int32})).new

    mforums.each do |mf|
      mfid = mf[0] as Int32
      grouped_forums = Forum.grouped_forums(mfid)
      mforums_threads[mfid] = [] of {Int32, Int32, Int32, String, Time, Int32}

      grouped_forums.each do |group|
        threads = Forum.site_threads(group[0], group[1], 3)
        mforums_threads[mfid] = mforums_threads[mf[0]] + threads
      end
    end
    render "src/views/grouped_all_threads.ecr", "src/views/layout.ecr"
  end

  get "/group/:gid" do |env|
    gid = 0
    gid = env.params.url["gid"]
    forums = Forum.all
    site_group = Forum.main_forums
    grouped_forums = Forum.grouped_forums(gid)
    group_threads = [] of {Int32, Int32, Int32, String, Time, Int32}

    grouped_forums.each do |group|
      threads = Forum.site_threads(group[0], group[1], 20)
      # site_forum_threads = threads.map { |thr| {thr[0], thr[1], thr[2], thr[3], thr[4]} }
      group_threads = group_threads + threads
    end
    render "src/views/grouped_threads.ecr", "src/views/layout.ecr"
  end
  get "/site/:sid/forums" do |env|
    sid = env.params.url["sid"].to_s.to_i
    # sid = env.request.url_params["sid"].to_i
    forums = Forum.site_forums(sid)
    render "src/views/nav2.ecr", "src/views/layout.ecr"
  end

  get "/site/:sid/forum/:fid" do |env|
    # sid = env.request.url_params["sid"].to_i
    sid = env.params.url["sid"].to_s.to_i
    fid = env.params.url["fid"].to_s.to_i

    forums = Forum.site_forums(sid)
    threads = Forum.site_threads(sid, fid)
    fname = Forum.forum_name(sid, fid)
    render "src/views/forum_threads.ecr", "src/views/layout.ecr"
    # env.redirect "/"
  end
end
