require 'spec_helper'

describe "Creating todo lists" do
  it "redirects to the todo list index page on success" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "My todo list"
    fill_in "Description", with: "run an rspec test"
    click_button "Create Todo list"


    expect(page).to have_content("My todo list")
  end

  it "displays an error when the todo list has no title" do
    expect (TodoList.count).should eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: ""
    fill_in "Description", with: "run an rspec test"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect (TodoList.count).should eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("run an rspec test")


  end

  it "displays an error when the todo list has a title less than 3 char" do
    expect (TodoList.count).should eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "hi"
    fill_in "Description", with: "run an rspec test"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect (TodoList.count).should eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("run an rspec test")

  end

  it "displays an error when the todo list has a description is blank" do
    expect (TodoList.count).should eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "Valid Title"
    fill_in "Description", with: ""
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect (TodoList.count).should eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("hi")


  end

  it "displays an error when the todo list has a description less than 5 char" do
    expect (TodoList.count).should eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "Valid Title"
    fill_in "Description", with: "hi"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect (TodoList.count).should eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("hi")


  end
end

