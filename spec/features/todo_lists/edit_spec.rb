require 'spec_helper'

describe "Editing todo lists" do
  let!(:todo_list) {  TodoList.create(title: "Update", description: "Updates an item successfully.")}

  def edit_todo_list (options={})
    options[:title] ||= "New Title"
    options[:description] ||= "New Description"
    todo_list = options[:todo_list]

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end

  it "updates a todo list successfully with correct information" do
    title = "New Title"
    description = "New Description"
    edit_todo_list todo_list: todo_list, title: title, description: description

  todo_list.reload
  expect(page).to have_content ("Todo list was successfully updated.")
  expect(todo_list.title).to eq(title)
  expect(todo_list.description).to eq(description)
  end

  it "displays an error with no title and remains unchanged" do
      edit_todo_list title: "", todo_list: todo_list
      title = todo_list.title
      todo_list.reload
      expect(todo_list.title).to eq(title)
      expect(page).to have_content("error")
  end

  it "displays an error with a title of less than 3 characters " do
      edit_todo_list title: "hi", todo_list: todo_list
      expect(page).to have_content("error")
  end

  it "displays an error with no description" do
      edit_todo_list description: "", todo_list: todo_list
      expect(page).to have_content("error")
  end

  it "displays an error with a description of less than 5 characters" do
      edit_todo_list description: "h", todo_list: todo_list
      expect(page).to have_content("error")
  end

end
