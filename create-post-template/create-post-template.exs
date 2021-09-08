arg = System.argv() |> Enum.join("-")

date  = Date.utc_today()
year  = Integer.to_string(date.year)
month = Integer.to_string(date.month)
date  = Integer.to_string(date.day)

root_folder = File.cwd!()
filename = Path.join(root_folder, arg) <> ".mdx"


to_title_case = fn arg ->
  arg
  |> String.split("-")
  |> Enum.join(" ")
  |> String.capitalize
end


post_template = """
---
title: '#{to_title_case.(arg)}'
publishedAt: '#{year}-#{month}-#{date}'
summary: '---'
---


"""

unless File.exists?(filename) do
  File.open(filename, [:write], fn file ->

    IO.write(file, post_template)

  end)
end

success_message = """
> New post created #{Path.relative_to_cwd(filename)}
"""


IO.puts(success_message)
