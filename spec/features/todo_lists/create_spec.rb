require 'spec_helper'

describe "Creating todo lists" do
    def create_todo_list(options={})
        options[:title] ||= "My todo list"
        options[:description] ||= "This is my todo description"

        visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content(:title)

        fill_in "Title", with: options[:title]
        fill_in "Description", with: options[:description]
        click_button "Create Todo list"

    end

    def error_check_todo_list(options={})
        options[:title] ||= "My todo list"
        options[:description] ||= "This is my todo description"

        expect (TodoList.count).should eq(0)

        create_todo_list title: options[:title], description: options[:description]

        expect(page).to have_content("error")
        expect (TodoList.count).should eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content(options[:description]) if options[:description] != ""


    end

  it "redirects to the todo list index page on success" do
    create_todo_list

    expect(page).to have_content("My todo list")
  end

  it "displays an error when the todo list has no title" do
    error_check_todo_list title: ""
  end

  it "displays an error when the todo list has a title less than 3 char" do
   error_check_todo_list title: "hi"
  end

  it "displays an error when the todo list has a description is blank" do
    error_check_todo_list description: ""
  end

  it "displays an error when the todo list has a description less than 5 char" do
   error_check_todo_list description: "hi"
  end
end

