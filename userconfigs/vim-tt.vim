command! Work
  \  call tt#set_timer(25)
  \| call tt#start_timer()
  \| call tt#set_status('working')
  \| call tt#when_done('AfterWork')

command! AfterWork
  \  call tt#play_sound()
  \| call tt#open_tasks()
  \| Break

command! WorkOnTask
  \  if tt#can_be_task(getline('.'))
  \|   call tt#set_task(getline('.'), line('.'))
  \|   execute 'Work'
  \|   echomsg "Current task: " . tt#get_task()
  \|   call tt#when_done('AfterWorkOnTask')
  \| endif

command! AfterWorkOnTask
  \  call tt#play_sound()
  \| call tt#open_tasks()
  \| call tt#mark_last_task()
  \| Break

" Argument: Time (in minutes) for the task timer
command! -nargs=1 Task
  \  if tt#can_be_task(getline('.'))
  \|   call tt#set_task(getline('.'), line('.'))
  \|   call tt#set_timer(<f-args>)
  \|   call tt#start_timer()
  \|   call tt#set_status(tt#get_task())
  \|   call tt#when_done('AfterWork')
  \|   echomsg "Current task: " . tt#get_task()
  \|   call tt#when_done('AfterWorkOnTask')
  \| endif

command! Break call Break()
function! Break()
  let l:count = tt#get_state('break-count', 0)
  if l:count >= 3
    call tt#set_timer(15)
    call tt#set_status('long break')
    call tt#set_state('break-count', 0)
  else
    call tt#set_timer(5)
    call tt#set_status('break')
    call tt#set_state('break-count', l:count + 1)
  endif
  call tt#start_timer()
  call tt#clear_task()
  call tt#when_done('AfterBreak')
endfunction

command! AfterBreak
  \  call tt#play_sound()
  \| call tt#set_status('Ready')
  \| call tt#clear_timer()

command! ClearTimer
  \  call tt#clear_status()
  \| call tt#clear_task()
  \| call tt#clear_timer()

command! -range MarkTask <line1>,<line2>call tt#mark_task()
command! OpenTasks call tt#open_tasks() <Bar> call tt#focus_tasks()
command! -nargs=1 SetTimer call tt#set_timer(<f-args>)
command! ShowTimer echomsg tt#get_remaining_full_format() . " " . tt#get_status_formatted() . " " . tt#get_task()
command! ToggleTimer call tt#toggle_timer()

nnoremap <Leader>tb :Break<cr>
nnoremap <Leader>tm :MarkTask<cr>
xnoremap <Leader>tm :MarkTask<cr>
nnoremap <Leader>tp :ToggleTimer<cr>
nnoremap <Leader>ts :ShowTimer<cr>
nnoremap <Leader>tt :OpenTasks<cr>
nnoremap <Leader>tw :Work<cr>
