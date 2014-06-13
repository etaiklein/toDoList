require 'spec_helper'

describe "Editing todo lists" do
  let!(:todo_list) {  TodoList.create(title: "Edit", description: "Edits an item successfully.")}
  let!(:todo_item) {  todo_list.todo_items.create(content: "To be Edited")}

it "is successful when marking an item complete" do
  expect(todo_item.completed_at).to be_nil
  visit_todo_list todo_list
  within dom_id_for(todo_item) do
    click_link "Mark Complete"
  end
  todo_item.reload
  expect(todo_item.completed_at).to_not be_nil
end
end
