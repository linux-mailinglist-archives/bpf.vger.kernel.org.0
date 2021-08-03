Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464C03DED27
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 13:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhHCLs5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Aug 2021 07:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbhHCLsw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Aug 2021 07:48:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C748C03544A
        for <bpf@vger.kernel.org>; Tue,  3 Aug 2021 04:46:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so3402125pjb.3
        for <bpf@vger.kernel.org>; Tue, 03 Aug 2021 04:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2MFdlHfNN/2Kl0BX3g2w3qS4FMDL46x9PWSUeVhOQug=;
        b=OAthuXW430lH7Eu/jdmtwPhe8U6kY30FANM9JTkGYE8aV1RufnyxurZmUCZCJKGuAA
         WfnZUel6GBGg2atRZPdDArVYB1spjCIpPiMY0ZVkRP+VSrBlmdroN2J3LyicmJFuNtih
         C9nZm30LMIbc5P0l9RxSsTr8JOrTArvxP07OTe4ovHWWQSwop0WIm+u/JaZhWIWVZzyS
         gkzFoiiM54xdiaoXeirtBK6QPgNL9RJda5FYl1lkUOT8CQ5wMnLQ193xj22+59C8s3Um
         vxaP2hvs0JRCfOwjNz5kT8FwT32hqKvFBE7wkyFs9GJJAqhGPLKApVRvdZ02fMj1Sdlv
         X9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2MFdlHfNN/2Kl0BX3g2w3qS4FMDL46x9PWSUeVhOQug=;
        b=uZHtncuJTaLt90jI2xE1GGYitiUGX0wgOUnYE+PUaSAJ0ekgAC93mMe29t/FED5zDB
         0s+5YekzwWtuNOmZWwbVaKr3NfBZl5RYMo+s/gDmYxc6N1enhxKpwhej6PWhsfRaLQVi
         gBL/P7qM0pAdYobdgWexebbfcGfFqlCRfjNJzwVgkvafrXhJd1TVMwNIOp69d8JDu+yP
         CDKyvgDuXHOPDcOYzY/leViWTct22yRwrXFFxUdQ3QWlZP1A2Bxp/HwJbL5uTrb+LN3j
         PB/ukQkk/xSXdNjhbRhyef7QEqv7xZZeIrBp3SMLzBgY3m1hP4qTazgxKFrwFS44Q+Hx
         vOxA==
X-Gm-Message-State: AOAM533ZLxr5PGI9o/9n906XoyoGkqg8D0BpqUX/U7XNlKGSRtykbWE0
        xhdPZiDCpEyNwu/tVKvZMDN7GJCW7UZSg5AQaB46tw==
X-Google-Smtp-Source: ABdhPJxrsZEp+ga+x3wT1djHWqamSEpVaKfXomH0ICyHbWVakhxJk6m3ChppPLJ12otpEUaziWw4x7KEnlxZn6pp5mU=
X-Received: by 2002:a17:903:308b:b029:12b:c7ec:998d with SMTP id
 u11-20020a170903308bb029012bc7ec998dmr18146533plc.78.1627991191967; Tue, 03
 Aug 2021 04:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAEEdnKGefYJtcPCX-yxzFCA6F2_vq7oNiHg8yR5A=8soTSc6MQ@mail.gmail.com>
 <CAK3+h2yanFA2c0qgy80juvAVuueiTqFXqx5HNjzX9JCAKEJOzA@mail.gmail.com>
In-Reply-To: <CAK3+h2yanFA2c0qgy80juvAVuueiTqFXqx5HNjzX9JCAKEJOzA@mail.gmail.com>
From:   =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Date:   Tue, 3 Aug 2021 19:46:21 +0800
Message-ID: <CAEEdnKFc-=hrQAtUgwNgrxCwe2bPLTrQLN8pD_eBN1kWLt5wWA@mail.gmail.com>
Subject: Re: [External] Re: Failed to build bpf selftest testcases based on
 upstream master branch
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, daniel <daniel@iogearbox.net>,
        ast <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Vincent Li <vincent.mc.li@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=885:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Aug 1, 2021 at 9:48 AM =E8=8C=83=E5=BC=80=E5=96=9C <fankaixi.li@b=
ytedance.com> wrote:
> >
> > Hi all,
> >
> > I failed to make bpf selftest testcases based on the upstream master
> > branch. And I need help to fix it.
> >
> > After installing the new kernel and modules,  I have tried following
> > commands to build bpf testcases:
> > "
> > cd ~/dev/linux/tools/testing/selftests/bpf
> > make
> > "
> >
> > Then error message shows up as follows:
> > "
> > INSTALL bpftool
> >   GEN      vmlinux.h
> >   CLNG-BPF [test_maps] btf__core_reloc_primitives___err_non_ptr.o
> >   CLNG-BPF [test_maps] test_global_data.o
> >   CLNG-BPF [test_maps] test_global_func8.o
> >   CLNG-BPF [test_maps] test_ksyms_btf_null_check.o
> >   CLNG-BPF [test_maps] linked_funcs2.o
> >   CLNG-BPF [test_maps] bpf_iter_test_kern5.o
> >   CLNG-BPF [test_maps] test_static_linked2.o
> >   CLNG-BPF [test_maps] test_global_func13.o
> >   CLNG-BPF [test_maps] test_cls_redirect_subprogs.o
> >   CLNG-BPF [test_maps] test_core_reloc_nesting.o
> >   CLNG-BPF [test_maps] tailcall_bpf2bpf1.o
> >   CLNG-BPF [test_maps] test_endian.o
> >   CLNG-BPF [test_maps] test_cls_redirect.o
> >   CLNG-BPF [test_maps] btf__core_reloc_type_based___incompat.o
> >   CLNG-BPF [test_maps] test_btf_newkv.o
> >   CLNG-BPF [test_maps] pyperf600.o
> >   CLNG-BPF [test_maps] test_btf_nokv.o
> >   CLNG-BPF [test_maps] atomics.o
> > fatal error: error in backend: line 27: Invalid usage of the XADD retur=
n value
> > PLEASE submit a bug report to https://bugs.llvm.org/ and include the
> > crash backtrace, preprocessed source, and associated run script.
> > Stack dump:
> > 0.        Program arguments: clang -g -D__TARGET_ARCH_x86
> > -mlittle-endian
> > -I/root/dev/linux/tools/testing/selftests/bpf/tools/include
> > -I/root/dev/linux/tools/testing/selftests/bpf
> > -I/root/dev/linux/tools/include/uapi
> > -I/root/dev/linux/tools/testing/selftests/usr/include -idirafter
> > /usr/local/include -idirafter
> > /usr/lib/llvm-11/lib/clang/11.1.0/include -idirafter
> > /usr/include/x86_64-linux-gnu -idirafter /usr/include
> > -Wno-compare-distinct-pointer-types -DENABLE_ATOMICS_TESTS -O2 -target
> > bpf -c progs/atomics.c -o
> > /root/dev/linux/tools/testing/selftests/bpf/atomics.o -mcpu=3Dv3
> > 1.        <eof> parser at end of file
> > 2.        Code generation
> > 3.        Running pass 'Function Pass Manager' on module 'progs/atomics=
.c'.
> > 4.        Running pass 'BPF PreEmit Checking' on function '@add'
> >  #0 0x00007f81ec29ee8f llvm::sys::PrintStackTrace(llvm::raw_ostream&)
> > (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xbbae8f)
> >  #1 0x00007f81ec29d200 llvm::sys::RunSignalHandlers()
> > (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xbb9200)
> >  #2 0x00007f81ec29e5dd llvm::sys::CleanupOnSignal(unsigned long)
> > (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xbba5dd)
> >  #3 0x00007f81ec1e6d2a (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xb02d2a)
> >  #4 0x00007f81ec1e6ccb (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xb02ccb)
> >  #5 0x00007f81ec299d4e (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xbb5d4e)
> >  #6 0x00000000004134f2 (/usr/lib/llvm-11/bin/clang+0x4134f2)
> >  #7 0x00007f81ec1f2d4f llvm::report_fatal_error(llvm::Twine const&,
> > bool) (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xb0ed4f)
> >  #8 0x00007f81ec1f2e27 (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xb0ee27)
> >  #9 0x00007f81edd55595 (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0x2671595=
)
> > #10 0x00007f81ec57339e
> > llvm::MachineFunctionPass::runOnFunction(llvm::Function&)
> > (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xe8f39e)
> > #11 0x00007f81ec3ae889
> > llvm::FPPassManager::runOnFunction(llvm::Function&)
> > (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xcca889)
> > #12 0x00007f81ec3b3eb3 llvm::FPPassManager::runOnModule(llvm::Module&)
> > (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xccfeb3)
> > #13 0x00007f81ec3aeea0
> > llvm::legacy::PassManagerImpl::run(llvm::Module&)
> > (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xccaea0)
> > #14 0x00007f81ea068e96
> > clang::EmitBackendOutput(clang::DiagnosticsEngine&,
> > clang::HeaderSearchOptions const&, clang::CodeGenOptions const&,
> > clang::TargetOptions const&, clang::LangOptions const&,
> > llvm::DataLayout const&, llvm::Module*, clang::BackendAction,
> > std::unique_ptr<llvm::raw_pwrite_stream,
> > std::default_delete<llvm::raw_pwrite_stream> >)
> > (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x164de96)
> > #15 0x00007f81ea329a36 (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x190e=
a36)
> > #16 0x00007f81e93e9093 clang::ParseAST(clang::Sema&, bool, bool)
> > (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x9ce093)
> > #17 0x00007f81ea9c9c38 clang::FrontendAction::Execute()
> > (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1faec38)
> > #18 0x00007f81ea97ff11
> > clang::CompilerInstance::ExecuteAction(clang::FrontendAction&)
> > (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1f64f11)
> > #19 0x00007f81eaa2f6b0
> > clang::ExecuteCompilerInvocation(clang::CompilerInstance*)
> > (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x20146b0)
> > #20 0x00000000004131bf cc1_main(llvm::ArrayRef<char const*>, char
> > const*, void*) (/usr/lib/llvm-11/bin/clang+0x4131bf)
> > #21 0x00000000004115fe (/usr/lib/llvm-11/bin/clang+0x4115fe)
> > #22 0x00007f81ea6a9a02 (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1c8e=
a02)
> > #23 0x00007f81ec1e6cad
> > llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>)
> > (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0xb02cad)
> > #24 0x00007f81ea6a8f2f
> > clang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::=
StringRef>
> > >, std::__cxx11::basic_string<char, std::char_traits<char>,
> > std::allocator<char> >*, bool*) const
> > (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1c8df2f)
> > #25 0x00007f81ea680d5f
> > clang::driver::Compilation::ExecuteCommand(clang::driver::Command
> > const&, clang::driver::Command const*&) const
> > (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1c65d5f)
> > #26 0x00007f81ea680f07
> > clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&,
> > llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*>
> > >&) const (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1c65f07)
> > #27 0x00007f81ea694a7c
> > clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&,
> > llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*>
> > >&) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1c79a7c)
> > #28 0x00000000004110a3 main (/usr/lib/llvm-11/bin/clang+0x4110a3)
> > #29 0x00007f81e855b09b __libc_start_main
> > (/lib/x86_64-linux-gnu/libc.so.6+0x2409b)
> > #30 0x000000000040e89a _start (/usr/lib/llvm-11/bin/clang+0x40e89a)
> > make: *** [Makefile:470:
> > /root/dev/linux/tools/testing/selftests/bpf/atomics.o] Error 1
> > "
> >
> > I am using a virtual machine with 8 cpus. The kernel and clang version =
are:
> > "
> > kernel: 5.14.0-rc3.bm.1-amd64 #4 SMP Sun Aug 1 23:28:24 CST 2021
> > x86_64 GNU/Linux
> > clang: Debian clang version
> > 11.1.0-++20210622113218+1fdec59bffc1-1~exp1~20210622213839.163
> > "
>
> I think I ran into same issue if I recall correctly, I downloaded
> llvm-project 12.0.1 and follow the instruction in kernel
> Documentation/bpf/bpf_devel_QA.rst
>
> "
> Q: Got it, so how do I build LLVM manually anyway?
> ....You need ninja, cmake and gcc-c++ as build requisites for LLVM.
> Once you
> have that set up, proceed with building the latest LLVM and clang
> version
> from the git repositories::
>
>     $ git clone https://github.com/llvm/llvm-project.git
>      $ mkdir -p llvm-project/llvm/build
>      $ cd llvm-project/llvm/build
>      $ cmake .. -G "Ninja" -DLLVM_TARGETS_TO_BUILD=3D"BPF;X86" \
>                 -DLLVM_ENABLE_PROJECTS=3D"clang"    \
>                 -DCMAKE_BUILD_TYPE=3DRelease        \
>                 -DLLVM_BUILD_RUNTIME=3DOFF
>      $ ninja
> "

Thanks. I have tried on branch v5.10 and it works. I found some issues:
1. On debian 10 default clang version is 7.0 which is not compatible.
I need to update clang to newer version like clang 12. You could
download newer version from clang repo.
2.  After updating clang version, I need to rebuild kernel and install
it. Then I could build bpf selftest cases successfully.
