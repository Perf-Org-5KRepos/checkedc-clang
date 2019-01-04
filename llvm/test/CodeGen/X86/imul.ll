; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-pc-linux-gnu | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=x86_64-pc-linux-gnux32 | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=i686-pc-linux | FileCheck %s --check-prefix=X86

define i32 @mul4_32(i32 %A) {
; X64-LABEL: mul4_32:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal (,%rdi,4), %eax
; X64-NEXT:    retq
;
; X86-LABEL: mul4_32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shll $2, %eax
; X86-NEXT:    retl
    %mul = mul i32 %A, 4
    ret i32 %mul
}

define i64 @mul4_64(i64 %A) {
; X64-LABEL: mul4_64:
; X64:       # %bb.0:
; X64-NEXT:    leaq (,%rdi,4), %rax
; X64-NEXT:    retq
;
; X86-LABEL: mul4_64:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    shldl $2, %eax, %edx
; X86-NEXT:    shll $2, %eax
; X86-NEXT:    retl
    %mul = mul i64 %A, 4
    ret i64 %mul
}

define i32 @mul4096_32(i32 %A) {
; X64-LABEL: mul4096_32:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shll $12, %eax
; X64-NEXT:    retq
;
; X86-LABEL: mul4096_32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shll $12, %eax
; X86-NEXT:    retl
    %mul = mul i32 %A, 4096
    ret i32 %mul
}

define i64 @mul4096_64(i64 %A) {
; X64-LABEL: mul4096_64:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    shlq $12, %rax
; X64-NEXT:    retq
;
; X86-LABEL: mul4096_64:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    shldl $12, %eax, %edx
; X86-NEXT:    shll $12, %eax
; X86-NEXT:    retl
    %mul = mul i64 %A, 4096
    ret i64 %mul
}

define i32 @mulmin4096_32(i32 %A) {
; X64-LABEL: mulmin4096_32:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shll $12, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    retq
;
; X86-LABEL: mulmin4096_32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shll $12, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    retl
    %mul = mul i32 %A, -4096
    ret i32 %mul
}

define i64 @mulmin4096_64(i64 %A) {
; X64-LABEL: mulmin4096_64:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    shlq $12, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    retq
;
; X86-LABEL: mulmin4096_64:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    shldl $12, %eax, %ecx
; X86-NEXT:    shll $12, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    negl %eax
; X86-NEXT:    sbbl %ecx, %edx
; X86-NEXT:    retl
    %mul = mul i64 %A, -4096
    ret i64 %mul
}

define i32 @mul3_32(i32 %A) {
; X64-LABEL: mul3_32:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal (%rdi,%rdi,2), %eax
; X64-NEXT:    retq
;
; X86-LABEL: mul3_32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    leal (%eax,%eax,2), %eax
; X86-NEXT:    retl
; But why?!
    %mul = mul i32 %A, 3
    ret i32 %mul
}

define i64 @mul3_64(i64 %A) {
; X64-LABEL: mul3_64:
; X64:       # %bb.0:
; X64-NEXT:    leaq (%rdi,%rdi,2), %rax
; X64-NEXT:    retq
;
; X86-LABEL: mul3_64:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    leal (%eax,%eax,2), %ecx
; X86-NEXT:    movl $3, %eax
; X86-NEXT:    mull {{[0-9]+}}(%esp)
; X86-NEXT:    addl %ecx, %edx
; X86-NEXT:    retl
    %mul = mul i64 %A, 3
    ret i64 %mul
}

define i32 @mul40_32(i32 %A) {
; X64-LABEL: mul40_32:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    shll $3, %edi
; X64-NEXT:    leal (%rdi,%rdi,4), %eax
; X64-NEXT:    retq
;
; X86-LABEL: mul40_32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shll $3, %eax
; X86-NEXT:    leal (%eax,%eax,4), %eax
; X86-NEXT:    retl
    %mul = mul i32 %A, 40
    ret i32 %mul
}

define i64 @mul40_64(i64 %A) {
; X64-LABEL: mul40_64:
; X64:       # %bb.0:
; X64-NEXT:    shlq $3, %rdi
; X64-NEXT:    leaq (%rdi,%rdi,4), %rax
; X64-NEXT:    retq
;
; X86-LABEL: mul40_64:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    leal (%eax,%eax,4), %ecx
; X86-NEXT:    movl $40, %eax
; X86-NEXT:    mull {{[0-9]+}}(%esp)
; X86-NEXT:    leal (%edx,%ecx,8), %edx
; X86-NEXT:    retl
    %mul = mul i64 %A, 40
    ret i64 %mul
}

define i32 @mul4_32_minsize(i32 %A) minsize {
; X64-LABEL: mul4_32_minsize:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal (,%rdi,4), %eax
; X64-NEXT:    retq
;
; X86-LABEL: mul4_32_minsize:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shll $2, %eax
; X86-NEXT:    retl
    %mul = mul i32 %A, 4
    ret i32 %mul
}

define i32 @mul40_32_minsize(i32 %A) minsize {
; X64-LABEL: mul40_32_minsize:
; X64:       # %bb.0:
; X64-NEXT:    imull $40, %edi, %eax
; X64-NEXT:    retq
;
; X86-LABEL: mul40_32_minsize:
; X86:       # %bb.0:
; X86-NEXT:    imull $40, {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
    %mul = mul i32 %A, 40
    ret i32 %mul
}

define i32 @mul33_32(i32 %A) {
; X64-LABEL: mul33_32:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shll $5, %eax
; X64-NEXT:    leal (%rax,%rdi), %eax
; X64-NEXT:    retq
;
; X86-LABEL: mul33_32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    shll $5, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    retl
    %mul = mul i32 %A, 33
    ret i32 %mul
}

define i32 @mul31_32(i32 %A) {
; X64-LABEL: mul31_32:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shll $5, %eax
; X64-NEXT:    subl %edi, %eax
; X64-NEXT:    retq
;
; X86-LABEL: mul31_32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    shll $5, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    retl
    %mul = mul i32 %A, 31
    ret i32 %mul
}

define i32 @mul0_32(i32 %A) {
; X64-LABEL: mul0_32:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    retq
;
; X86-LABEL: mul0_32:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    retl
    %mul = mul i32 %A, 0
    ret i32 %mul
}

define i32 @mul4294967295_32(i32 %A) {
; X64-LABEL: mul4294967295_32:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    retq
;
; X86-LABEL: mul4294967295_32:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
    %mul = mul i32 %A, 4294967295
    ret i32 %mul
}

define i64 @mul18446744073709551615_64(i64 %A) {
; X64-LABEL: mul18446744073709551615_64:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    retq
;
; X86-LABEL: mul18446744073709551615_64:
; X86:       # %bb.0:
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    retl
    %mul = mul i64 %A, 18446744073709551615
    ret i64 %mul
}

define i32 @test(i32 %a) {
; X64-LABEL: test:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shll $5, %eax
; X64-NEXT:    subl %edi, %eax
; X64-NEXT:    retq
;
; X86-LABEL: test:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    shll $5, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    retl
entry:
	%tmp3 = mul i32 %a, 31
	ret i32 %tmp3
}

define i32 @test1(i32 %a) {
; X64-LABEL: test1:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    shll $5, %ecx
; X64-NEXT:    subl %ecx, %eax
; X64-NEXT:    retq
;
; X86-LABEL: test1:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    shll $5, %ecx
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    retl
entry:
	%tmp3 = mul i32 %a, -31
	ret i32 %tmp3
}


define i32 @test2(i32 %a) {
; X64-LABEL: test2:
; X64:       # %bb.0: # %entry
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shll $5, %eax
; X64-NEXT:    leal (%rax,%rdi), %eax
; X64-NEXT:    retq
;
; X86-LABEL: test2:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    shll $5, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    retl
entry:
	%tmp3 = mul i32 %a, 33
	ret i32 %tmp3
}

define i32 @test3(i32 %a) {
; X64-LABEL: test3:
; X64:       # %bb.0: # %entry
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shll $5, %eax
; X64-NEXT:    leal (%rax,%rdi), %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    retq
;
; X86-LABEL: test3:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    shll $5, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    retl
entry:
	%tmp3 = mul i32 %a, -33
	ret i32 %tmp3
}

define i64 @test4(i64 %a) {
; X64-LABEL: test4:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    shlq $5, %rax
; X64-NEXT:    subq %rdi, %rax
; X64-NEXT:    retq
;
; X86-LABEL: test4:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    shll $5, %ecx
; X86-NEXT:    subl %eax, %ecx
; X86-NEXT:    movl $31, %eax
; X86-NEXT:    mull {{[0-9]+}}(%esp)
; X86-NEXT:    addl %ecx, %edx
; X86-NEXT:    retl
entry:
	%tmp3 = mul i64 %a, 31
	ret i64 %tmp3
}

define i64 @test5(i64 %a) {
; X64-LABEL: test5:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    shlq $5, %rcx
; X64-NEXT:    subq %rcx, %rax
; X64-NEXT:    retq
;
; X86-LABEL: test5:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %esi, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:    shll $5, %eax
; X86-NEXT:    subl %eax, %esi
; X86-NEXT:    movl $-31, %edx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    mull %edx
; X86-NEXT:    subl %ecx, %edx
; X86-NEXT:    addl %esi, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
entry:
	%tmp3 = mul i64 %a, -31
	ret i64 %tmp3
}


define i64 @test6(i64 %a) {
; X64-LABEL: test6:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    shlq $5, %rax
; X64-NEXT:    leaq (%rax,%rdi), %rax
; X64-NEXT:    retq
;
; X86-LABEL: test6:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    shll $5, %ecx
; X86-NEXT:    addl %eax, %ecx
; X86-NEXT:    movl $33, %eax
; X86-NEXT:    mull {{[0-9]+}}(%esp)
; X86-NEXT:    addl %ecx, %edx
; X86-NEXT:    retl
entry:
	%tmp3 = mul i64 %a, 33
	ret i64 %tmp3
}

define i64 @test7(i64 %a) {
; X64-LABEL: test7:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    shlq $5, %rax
; X64-NEXT:    leaq (%rax,%rdi), %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    retq
;
; X86-LABEL: test7:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %esi, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    shll $5, %esi
; X86-NEXT:    addl %eax, %esi
; X86-NEXT:    movl $-33, %edx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    mull %edx
; X86-NEXT:    subl %ecx, %edx
; X86-NEXT:    subl %esi, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
entry:
	%tmp3 = mul i64 %a, -33
	ret i64 %tmp3
}

define i64 @testOverflow(i64 %a) {
; X64-LABEL: testOverflow:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    shlq $63, %rax
; X64-NEXT:    subq %rdi, %rax
; X64-NEXT:    retq
;
; X86-LABEL: testOverflow:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %esi, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl $-1, %edx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    mull %edx
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    shll $31, %esi
; X86-NEXT:    subl %ecx, %esi
; X86-NEXT:    addl %esi, %edx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
entry:
	%tmp3 = mul i64 %a, 9223372036854775807
	ret i64 %tmp3
}

define i64 @testNegOverflow(i64 %a) {
; X64-LABEL: testNegOverflow:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    shlq $63, %rcx
; X64-NEXT:    subq %rcx, %rax
; X64-NEXT:    retq
;
; X86-LABEL: testNegOverflow:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl $1, %edx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    mull %edx
; X86-NEXT:    shll $31, %ecx
; X86-NEXT:    addl %ecx, %edx
; X86-NEXT:    addl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    retl
entry:
	%tmp3 = mul i64 %a, -9223372036854775807
	ret i64 %tmp3
}