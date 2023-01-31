Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ACE6836EC
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 20:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjAaT6f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 31 Jan 2023 14:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaT6f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 14:58:35 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB355649E
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 11:58:33 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id t18so15330649wro.1
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 11:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbGe4/RppDm6V+X3zcL4A3Ros7S1gwNHtbyAFPMbjEc=;
        b=ceA/6fX3s7mXUkUHh4/7ogCj3Btk+AARHnjKgmia5Xb/x9UP0CKOca/rOXWm0AUVCH
         BHBMPP+3R+z5gpl1MSXVT1OvHYjL68P5EozZW6BOVq51BKOq7fngFUGMPHrygfT8HSYv
         AC4w9CXzemDgr9zuKHSmSB7ZPNGSWVYgcfZ8egVNL5BixSWxmPByNUdBYeXWK/9rNSbz
         eCcpqjaVveDw7pzJH3P+8fTb4LQk+AmU7/dzgOzG1QFRYMqIXpuUblCtLZlmgTbLY0on
         sGOFQKRg3wi/YuUv+6XXujQn45G+MsVtkDojZe8IzS33etMUV+FEBrNdTbHbTgo4oOcP
         /B1w==
X-Gm-Message-State: AO0yUKVgV6+uif1E9yZFkArbrzno1fGDrilyPEqMMtPz07iggxfM46Td
        Q+JlkKXWv72smQ5GFS480Cm16k/6K5J0xTUfmOM=
X-Google-Smtp-Source: AK7set9K5Vd8EyxBCaT5pN90g/BcaJ2cZ2HnSSVySw6UCESU//OAcj/Ko2bPbvY4HHuC9uLuDyGd1WS2mmKtFMBJnkI=
X-Received: by 2002:adf:df84:0:b0:2bf:d6c8:2b60 with SMTP id
 z4-20020adfdf84000000b002bfd6c82b60mr9534wrl.685.1675195111485; Tue, 31 Jan
 2023 11:58:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7ju-gewZVNxopBi3Uvhiv8Wb=a-D4gaW3MD-NkUg0WSSg@mail.gmail.com>
 <20230117215658.xec7cirlfx2z7z2m@muellerd-fedora-PC2BDTX9>
 <20230117222158.uyezr5ab72ck5fhv@muellerd-fedora-PC2BDTX9>
 <CA+khW7gFq3VKEvF7hZXQsLJagz=HMZ4kJwh=QdmFG1pFbq1xRw@mail.gmail.com>
 <Y9iv6i8GBIvT/wPQ@google.com> <20230131164618.yguxtmxh753aga3f@nuc>
In-Reply-To: <20230131164618.yguxtmxh753aga3f@nuc>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 31 Jan 2023 11:58:19 -0800
Message-ID: <CAM9d7ciaQyv9Z26P34fVjbD01W7+0fpPyKrXoPQz-E3pm04-4w@mail.gmail.com>
Subject: Re: CORE feature request: support checking field type directly
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Daniel,

On Tue, Jan 31, 2023 at 8:46 AM Daniel Müller <deso@posteo.net> wrote:
>
> Hi Namhyung,
>
> On Mon, Jan 30, 2023 at 10:06:34PM -0800, Namhyung Kim wrote:
> > Thanks for taking care of this.  It looks good!
> >
> > But I'm seeing a compiler error with this change like below.
> > ("Incorrect flag for llvm.bpf.preserve.type.info intrinsic")
> > Maybe we need to check if the compiler supports it?
> >
> > Thanks,
> > Namhyung
> >
> >
> >     CLANG   /home/namhyung/project/linux/tools/perf/util/bpf_skel/.tmp/lock_contention.bpf.o
> >   fatal error: error in backend: Incorrect flag for llvm.bpf.preserve.type.info intrinsic
> >   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace, preprocessed source, and associated run script.
> >   Stack dump:
> >   0.  Program arguments: clang -g -O2 -target bpf -Wall -Werror -I/home/namhyung/project/linux/tools/perf/util/bpf_skel/.tmp/.. -I/home/namhyung/project/linux/tools/perf/libbpf/include -c util/bpf_skel/lock_contention.bpf.c -o /home/namhyung/project/linux/tools/perf/util/bpf_skel/.tmp/lock_contention.bpf.o
> >   1.  <eof> parser at end of file
> >   2.  Optimizer
> >    #0 0x00007f1a070a5291 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xea5291)
> >    #1 0x00007f1a070a2fbe llvm::sys::RunSignalHandlers() (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xea2fbe)
> >    #2 0x00007f1a070a464b llvm::sys::CleanupOnSignal(unsigned long) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xea464b)
> >    #3 0x00007f1a06fcb62a (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xdcb62a)
> >    #4 0x00007f1a06fcb5cb (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xdcb5cb)
> >    #5 0x00007f1a0709f627 llvm::sys::Process::Exit(int, bool) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xe9f627)
> >    #6 0x00000000004142c2 (/usr/lib/llvm-14/bin/clang+0x4142c2)
> >    #7 0x00007f1a06fda393 llvm::report_fatal_error(llvm::Twine const&, bool) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xdda393)
> >    #8 0x00007f1a06fda276 (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xdda276)
> >    #9 0x00007f1a091d4d54 (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x2fd4d54)
> >   #10 0x00007f1a091d0434 (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x2fd0434)
> >   #11 0x00007f1a091d01a5 (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x2fd01a5)
> >   #12 0x00007f1a091e431d (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x2fe431d)
> >   #13 0x00007f1a07214d8e llvm::PassManager<llvm::Function, llvm::AnalysisManager<llvm::Function> >::run(llvm::Function&, llvm::AnalysisManager<llvm::Function>&) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x1014d8e)
> >   #14 0x00007f1a08e0ec0d (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x2c0ec0d)
> >   #15 0x00007f1a07218cb1 llvm::ModuleToFunctionPassAdaptor::run(llvm::Module&, llvm::AnalysisManager<llvm::Module>&) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x1018cb1)
> >   #16 0x00007f1a08e0ea3d (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x2c0ea3d)
> >   #17 0x00007f1a072139ae llvm::PassManager<llvm::Module, llvm::AnalysisManager<llvm::Module> >::run(llvm::Module&, llvm::AnalysisManager<llvm::Module>&) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x10139ae)
> >   #18 0x00007f1a0e4938ee (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x18938ee)
> >   #19 0x00007f1a0e4890e6 clang::EmitBackendOutput(clang::DiagnosticsEngine&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::TargetOptions const&, clang::LangOptions const&, llvm::StringRef, llvm::Module*, clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >) (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x18890e6)
> >   #20 0x00007f1a0e7adf95 (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x1badf95)
> >   #21 0x00007f1a0d634914 clang::ParseAST(clang::Sema&, bool, bool) (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0xa34914)
> >   #22 0x00007f1a0e7aa261 clang::CodeGenAction::ExecuteAction() (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x1baa261)
> >   #23 0x00007f1a0f14b887 clang::FrontendAction::Execute() (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x254b887)
> >   #24 0x00007f1a0f0a11f6 clang::CompilerInstance::ExecuteAction(clang::FrontendAction&) (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x24a11f6)
> >   #25 0x00007f1a0f1c563b clang::ExecuteCompilerInvocation(clang::CompilerInstance*) (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x25c563b)
> >   #26 0x0000000000413e93 cc1_main(llvm::ArrayRef<char const*>, char const*, void*) (/usr/lib/llvm-14/bin/clang+0x413e93)
> >   #27 0x00000000004120cc (/usr/lib/llvm-14/bin/clang+0x4120cc)
> >   #28 0x00007f1a0ed1d052 (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x211d052)
> >   #29 0x00007f1a06fcb5ad llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xdcb5ad)
> >   #30 0x00007f1a0ed1cb50 clang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*, bool*) const (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x211cb50)
> >   #31 0x00007f1a0ece70f3 clang::driver::Compilation::ExecuteCommand(clang::driver::Command const&, clang::driver::Command const*&) const (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x20e70f3)
> >   #32 0x00007f1a0ece737a clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*> >&) const (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x20e737a)
> >   #33 0x00007f1a0ed01677 clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*> >&) (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x2101677)
> >   #34 0x0000000000411b36 main (/usr/lib/llvm-14/bin/clang+0x411b36)
> >   #35 0x00007f1a0604618a __libc_start_call_main ./csu/../sysdeps/nptl/libc_start_call_main.h:74:3
> >   #36 0x00007f1a06046245 call_init ./csu/../csu/libc-start.c:128:20
> >   #37 0x00007f1a06046245 __libc_start_main ./csu/../csu/libc-start.c:368:5
> >   #38 0x000000000040efb1 _start (/usr/lib/llvm-14/bin/clang+0x40efb1)
> >   clang: error: clang frontend command failed with exit code 70 (use -v to see invocation)
> >   Debian clang version 14.0.6
> >   Target: bpf
> >   Thread model: posix
> >   InstalledDir: /usr/bin
>
> Not a compiler expert, but I am pretty sure that LLVM 14 does not have
> TYPE_MATCH support (unless I missed a backport somewhere). That's likely
> what "Incorrect flag for llvm.bpf.preserve.type.info intrinsic" refers
> to. If I recall correctly the feature landed somewhere in the
> development cycle of LLVM 15. I recommend you try with version 15 or
> later.

Thanks for the info.  That means I need to add a version check
not to break the user programs with some old compilers.

Thanks,
Namhyung
