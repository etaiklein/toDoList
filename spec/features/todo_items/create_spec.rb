require 'spec_helper'

describe "Adding todo lists" do
  let!(:todo_list) {  TodoList.create(title: "Add", description: "Adds an item successfully.")}

it "is successful with valid content" do
  visit_todo_list(todo_list)
  click_link "New Todo Item"
  fill_in "Content", with: "Added this item"
  click_button "Save"
  expect(page).to have_content ("Added todo list item")
  within ("ul.todo_items") do
    expect(page).to have_content("Added this item")
end
end

it "displays an error with no content" do
  visit_todo_list(todo_list)
  click_link "New Todo Item"
  fill_in "Content", with: ""
  click_button "Save"
  within("div.flash") do
    expect(page).to have_content ("There was a problem adding the todo list item.")
  end
  expect(page).to have_content("Content can't be blank")
end

it "displays an error with content less than 2 characters long" do
  visit_todo_list(todo_list)
  click_link "New Todo Item"
  fill_in "Content", with: "1"
  click_button "Save"
  within("div.flash") do
    expect(page).to have_content ("There was a problem adding the todo list item.")
  end
  expect(page).to have_content("Content is too short")
end

end
