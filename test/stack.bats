#!/usr/bin/env bats

source ~/.ledocc_work_export/shocc/shocc.sh

##----------------------------------------------------------------------------------------------------------##
##-- shocc__stack__exists ----------------------------------------------------------------------------------##
##----------------------------------------------------------------------------------------------------------##

@test "check not existing stack" {
    run shocc__stack__exists no_stack
    [[ $status -eq 1 ]]
    [[ "x$output" == "x" ]]
}

@test "check existing stack" {
    shocc__stack__new my_stack
    run shocc__stack__exists my_stack
    [[ $status -eq 0 ]]
}

##----------------------------------------------------------------------------------------------------------##
##-- shocc__stack__new -------------------------------------------------------------------------------------##
##----------------------------------------------------------------------------------------------------------##

@test "create already existing stack" {
    shocc__stack__new my_stack
    run shocc__stack__new my_stack
    [[ $status -eq 1 ]]
}

@test "create deleted stack" {
    shocc__stack__new my_stack
    shocc__stack__delete my_stack
    run shocc__stack__new my_stack
}

@test "create new stack" {
    run shocc__stack__new my_stack
}

##----------------------------------------------------------------------------------------------------------##
##-- shocc__stack__delete ----------------------------------------------------------------------------------##
##----------------------------------------------------------------------------------------------------------##

@test "delete not existing stack" {
    run shocc__stack__delete my_no_existing_stack
    [[ $status -eq 1 ]]
}

@test "delete existing stack" {
    shocc__stack__new my_stack
    shocc__stack__delete my_stack
}

##----------------------------------------------------------------------------------------------------------##
##-- shocc__stack__push ------------------------------------------------------------------------------------##
##----------------------------------------------------------------------------------------------------------##

@test "push in not existing stack" {
    run shocc__stack__push my_stack "value"
    [[ $status -eq 1 ]]
}

@test "push in deleted stack" {
    shocc__stack__new my_stack
    shocc__stack__delete my_stack
    run shocc__stack__push my_stack "value"
    [[ $status -eq 1 ]]
}

@test "push in existing stack" {
    shocc__stack__new my_stack
    shocc__stack__push my_stack "value"
}

##----------------------------------------------------------------------------------------------------------##
##-- shocc__stack__pop -------------------------------------------------------------------------------------##
##----------------------------------------------------------------------------------------------------------##

@test "pop in not existing stack" {
    run shocc__stack__pop my_stack "value"
    [[ $status -eq 1 ]]
}

@test "pop in deleted stack" {
    shocc__stack__new my_stack
    shocc__stack__delete my_stack
    run shocc__stack__pop my_stack "value"
    [[ $status -eq 1 ]]
}

@test "pop from empty stack" {
    shocc__stack__new my_stack
    run shocc__stack__pop my_stack
    [[ $status -eq 1 ]]
}

@test "pop from stack" {
    shocc__stack__new my_stack
    shocc__stack__push my_stack "value"
    run shocc__stack__pop my_stack
    [[ $status -eq 0 ]]
    [[ $output == "value" ]]
}

##----------------------------------------------------------------------------------------------------------##
##-- shocc__stack__size ------------------------------------------------------------------------------------##
##----------------------------------------------------------------------------------------------------------##

@test "size of not existing stack" {
    run shocc__stack__size my_stack
    [[ $status -eq 1 ]]
}

@test "size of deleted stack" {
    shocc__stack__new my_stack
    shocc__stack__delete my_stack
    run shocc__stack__size my_stack
    [[ $status -eq 1 ]]
}

@test "size of empty stack" {
    shocc__stack__new my_stack
    run shocc__stack__size my_stack
    [[ $status -eq 0 ]]
    [[ $output == "0" ]]
}

@test "size of stack" {
    shocc__stack__new my_stack
    shocc__stack__push my_stack "value"
    run shocc__stack__size my_stack
    [[ $status -eq 0 ]]
    [[ $output == "1" ]]
}
