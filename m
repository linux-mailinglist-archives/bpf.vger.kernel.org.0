Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B627F3DCCBF
	for <lists+bpf@lfdr.de>; Sun,  1 Aug 2021 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhHAQsQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Aug 2021 12:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhHAQsP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Aug 2021 12:48:15 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D415FC06175F
        for <bpf@vger.kernel.org>; Sun,  1 Aug 2021 09:48:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so16860554plr.13
        for <bpf@vger.kernel.org>; Sun, 01 Aug 2021 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0CWBFU/df7D52R1rtNqUbfGY0GzICTPGIKR60t6R3iQ=;
        b=Ua9oGGsIYu5t+AXvlyRd6HNXY15JQCCMIFPV5L+MHjfnvkvkdel7lyReAKgqOCu54j
         uw+rCzhfzMbgWkEcRXGnt7+X1cuawNJJDqqIW+xBQDqjfJGLZXGqVJ0JcYHGsVoWerGE
         N8fRLdPMrq0zjSUAMksktnfKzb+c3IWP1pI6KQGuXjJSjkRMIl2x+qgJCGQrreWZdWur
         YzBE8KsX8kzPHnjPB46kYzQxrKlENzDmTNyeQ+rYQvTaODNQgH1JTSD6Z4r/R9snQPYL
         GoyI09l/JfNNVnMuiE7xhJCJVXknKf+k1YcZufnphhU/A1PkaT82hGwIgFq8LltOfV67
         q8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0CWBFU/df7D52R1rtNqUbfGY0GzICTPGIKR60t6R3iQ=;
        b=bAI8rRmARYIpGZ9SKVkQLN/KRVcZ4MqfR4+UfR2/PJh6MePgNJ+okA3aIkx97A9sjA
         ajhVx1jN3cWEUdSvznGWpeYOKcvgfVeiPyXgXcfeqBIwmkwGCQvC8fYI8eo/MPkPM2zW
         D0unFHBIRfFOHMvYaCIo6A8aLlBfwxwNQe+qJfNTqDLUFGAxT+UGpwII5nXGQdzMDigY
         bsZBOxRA1VhNzh03ZegvgLN3y0AwoPOd+CDO/CofNQG00xcYzKCzzfQNg2dIUdN4R7MX
         j/ljvt6cRxz0l2dYj919HaUDqm6p193XsnJOQ3jJID10JMs9CvI7OyehIbg5XGF9+uOQ
         ViwA==
X-Gm-Message-State: AOAM533zxgm3oino1+OO/0D6E5dU3fm4C2Fzn01Di8VYWhwANSzy1fBH
        KUCng+agCtPl6+p0XrPNFMJuBoVP8kZIiRWhyBKCX8hQpvfPlDUr
X-Google-Smtp-Source: ABdhPJwfFXj+fWT2Qdg4coC+ZnhYLMnav2Bwaqc4JUwjb45jQgyCZigI/671Q5awWR7NPGUIguu9BRvEsUQ9igiOaGo=
X-Received: by 2002:a17:90a:bd04:: with SMTP id y4mr13620281pjr.127.1627836486118;
 Sun, 01 Aug 2021 09:48:06 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Date:   Mon, 2 Aug 2021 00:47:55 +0800
Message-ID: <CAEEdnKGefYJtcPCX-yxzFCA6F2_vq7oNiHg8yR5A=8soTSc6MQ@mail.gmail.com>
Subject: Failed to build bpf selftest testcases based on upstream master branch
To:     bpf <bpf@vger.kernel.org>
Cc:     daniel <daniel@iogearbox.net>, ast <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

I failed to make bpf selftest testcases based on the upstream master
branch. And I need help to fix it.

After installing the new kernel and modules,  I have tried following
commands to build bpf testcases:
"
cd ~/dev/linux/tools/testing/selftests/bpf
make
"

Then error message shows up as follows:
"
INSTALL bpftool
  GEN      vmlinux.h
  CLNG-BPF [test_maps] btf__core_reloc_primitives___err_non_ptr.o
  CLNG-BPF [test_maps] test_global_data.o
  CLNG-BPF [test_maps] test_global_func8.o
  CLNG-BPF [test_maps] test_ksyms_btf_null_check.o
  CLNG-BPF [test_maps] linked_funcs2.o
  CLNG-BPF [test_maps] bpf_iter_test_kern5.o
  CLNG-BPF [test_maps] test_static_linked2.o
  CLNG-BPF [test_maps] test_global_func13.o
  CLNG-BPF [test_maps] test_cls_redirect_subprogs.o
  CLNG-BPF [test_maps] test_core_reloc_nesting.o
  CLNG-BPF [test_maps] tailcall_bpf2bpf1.o
  CLNG-BPF [test_maps] test_endian.o
  CLNG-BPF [test_maps] test_cls_redirect.o
  CLNG-BPF [test_maps] btf__core_reloc_type_based___incompat.o
  CLNG-BPF [test_maps] test_btf_newkv.o
  CLNG-BPF [test_maps] pyperf600.o
  CLNG-BPF [test_maps] test_btf_nokv.o
  CLNG-BPF [test_maps] atomics.o
fatal error: error in backend: line 27: Invalid usage of the XADD return value
PLEASE submit a bug report to https://bugs.llvm.org/ and include the
crash backtrace, preprocessed source, and associated run script.
Stack dump:
0.        Program arguments: clang -g -D__TARGET_ARCH_x86
-mlittle-endian
-I/root/dev/linux/tools/testing/selftests/bpf/tools/include
-I/root/dev/linux/tools/testing/selftests/bpf
-I/root/dev/linux/tools/include/uapi
-I/root/dev/linux/tools/testing/selftests/usr/include -idirafter
/usr/local/include -idirafter
/usr/lib/llvm-11/lib/clang/11.1.0/include -idirafter
/usr/include/x86_64-linux-gnu -idirafter /usr/include
-Wno-compare-distinct-pointer-types -DENABLE_ATOMICS_TESTS -O2 -target
bpf -c progs/atomics.c -o
/root/dev/linux/tools/testing/selftests/bpf/atomics.o -mcpu=v3
1.        <eof> parser at end of file
2.        Code generation
3.        Running pass 'Function Pass Manager' on module 'progs/atomics.c'.
4.        Running pass 'BPF PreEmit Checking' on function '@add'
 #0 0x00007f81ec29ee8f llvm::sys::PrintStackTrace(llvm::raw_ostream&)
(/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xbbae8f)
 #1 0x00007f81ec29d200 llvm::sys::RunSignalHandlers()
(/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xbb9200)
 #2 0x00007f81ec29e5dd llvm::sys::CleanupOnSignal(unsigned long)
(/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xbba5dd)
 #3 0x00007f81ec1e6d2a (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xb02d2a)
 #4 0x00007f81ec1e6ccb (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xb02ccb)
 #5 0x00007f81ec299d4e (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xbb5d4e)
 #6 0x00000000004134f2 (/usr/lib/llvm-11/bin/clang+0x4134f2)
 #7 0x00007f81ec1f2d4f llvm::report_fatal_error(llvm::Twine const&,
bool) (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xb0ed4f)
 #8 0x00007f81ec1f2e27 (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xb0ee27)
 #9 0x00007f81edd55595 (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0x2671595)
#10 0x00007f81ec57339e
llvm::MachineFunctionPass::runOnFunction(llvm::Function&)
(/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xe8f39e)
#11 0x00007f81ec3ae889
llvm::FPPassManager::runOnFunction(llvm::Function&)
(/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xcca889)
#12 0x00007f81ec3b3eb3 llvm::FPPassManager::runOnModule(llvm::Module&)
(/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xccfeb3)
#13 0x00007f81ec3aeea0
llvm::legacy::PassManagerImpl::run(llvm::Module&)
(/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xccaea0)
#14 0x00007f81ea068e96
clang::EmitBackendOutput(clang::DiagnosticsEngine&,
clang::HeaderSearchOptions const&, clang::CodeGenOptions const&,
clang::TargetOptions const&, clang::LangOptions const&,
llvm::DataLayout const&, llvm::Module*, clang::BackendAction,
std::unique_ptr<llvm::raw_pwrite_stream,
std::default_delete<llvm::raw_pwrite_stream> >)
(/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x164de96)
#15 0x00007f81ea329a36 (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x190ea36)
#16 0x00007f81e93e9093 clang::ParseAST(clang::Sema&, bool, bool)
(/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x9ce093)
#17 0x00007f81ea9c9c38 clang::FrontendAction::Execute()
(/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1faec38)
#18 0x00007f81ea97ff11
clang::CompilerInstance::ExecuteAction(clang::FrontendAction&)
(/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1f64f11)
#19 0x00007f81eaa2f6b0
clang::ExecuteCompilerInvocation(clang::CompilerInstance*)
(/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x20146b0)
#20 0x00000000004131bf cc1_main(llvm::ArrayRef<char const*>, char
const*, void*) (/usr/lib/llvm-11/bin/clang+0x4131bf)
#21 0x00000000004115fe (/usr/lib/llvm-11/bin/clang+0x4115fe)
#22 0x00007f81ea6a9a02 (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1c8ea02)
#23 0x00007f81ec1e6cad
llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>)
(/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xb02cad)
#24 0x00007f81ea6a8f2f
clang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringRef>
>, std::__cxx11::basic_string<char, std::char_traits<char>,
std::allocator<char> >*, bool*) const
(/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1c8df2f)
#25 0x00007f81ea680d5f
clang::driver::Compilation::ExecuteCommand(clang::driver::Command
const&, clang::driver::Command const*&) const
(/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1c65d5f)
#26 0x00007f81ea680f07
clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&,
llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*>
>&) const (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1c65f07)
#27 0x00007f81ea694a7c
clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&,
llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*>
>&) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1c79a7c)
#28 0x00000000004110a3 main (/usr/lib/llvm-11/bin/clang+0x4110a3)
#29 0x00007f81e855b09b __libc_start_main
(/lib/x86_64-linux-gnu/libc.so.6+0x2409b)
#30 0x000000000040e89a _start (/usr/lib/llvm-11/bin/clang+0x40e89a)
make: *** [Makefile:470:
/root/dev/linux/tools/testing/selftests/bpf/atomics.o] Error 1
"

I am using a virtual machine with 8 cpus. The kernel and clang version are:
"
kernel: 5.14.0-rc3.bm.1-amd64 #4 SMP Sun Aug 1 23:28:24 CST 2021
x86_64 GNU/Linux
clang: Debian clang version
11.1.0-++20210622113218+1fdec59bffc1-1~exp1~20210622213839.163
"
