require 'spec_helper'

describe "Editing todo lists" do
  let!(:todo_list) {  TodoList.create(title: "Edit", description: "Edits an item successfully.")}
  let!(:todo_item) {  todo_list.todo_items.create(content: "To be Edited")}

it "is successful with valid content" do
  visit_todo_list(todo_list)
  within("#todo_item_#{todo_item.id}") do
    click_link "Edit"
  end
  fill_in "Content", with: "Edited item"
  click_button "Save"
  expect(page).to have_content("Saved todo list")
  todo_item.reload
  expect(todo_item.content).to eq("Edited item")
end

it "is unsuccessful with no content" do
  visit_todo_list(todo_list)
  within("#todo_item_#{todo_item.id}") do
    click_link "Edit"
  end
  fill_in "Content", with: ""
  click_button "Save"
  expect(page).to have_content("Content can't be blank")
  todo_item.reload
  expect(todo_item.content).to eq("To be Edited")
end

it "is unsuccessful with not enough content" do
  visit_todo_list(todo_list)
  within("#todo_item_#{todo_item.id}") do
    click_link "Edit"
  end
  fill_in "Content", with: "1"
  click_button "Save"
  expect(page).to have_content("Content is too short")
  todo_item.reload
  expect(todo_item.content).to eq("To be Edited")
end


end
