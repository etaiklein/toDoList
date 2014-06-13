require 'spec_helper'

describe "Deleting todo lists" do
  let!(:todo_list) {  TodoList.create(title: "Edit", description: "Edits an item successfully.")}
  let!(:todo_item) {  todo_list.todo_items.create(content: "To be Edited")}

  it "is successful" do
    visit_todo_list(todo_list)
    within "#todo_item_#{todo_item.id}" do
      click_link "Delete"
    end
    expect(page).to have_content("Deleted todo list")
    expect(TodoItem.count).to eq(0)
end

end
