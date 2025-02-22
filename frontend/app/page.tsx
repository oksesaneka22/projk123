import { TodoList } from "./components/todo-list"

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <div className="z-10 max-w-5xl w-full items-center justify-center font-mono text-sm">
        <h1 className="mb-8 text-4xl font-bold text-center">To-Do List</h1>
        <TodoList />
      </div>
    </main>
  )
}

