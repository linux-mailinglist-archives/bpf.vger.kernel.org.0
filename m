Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C651868244B
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 07:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjAaGGl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 01:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjAaGGk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 01:06:40 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CA33B3E5
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 22:06:39 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 144so9487321pfv.11
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 22:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGAVQqa8Y5M61rBsJJuSDw9l073QzNEWTldSMTvVAZ0=;
        b=DtQkn8ahxh8Q/vglRT+FYYzxq8GbJdGzicd8ZsQzYoWymdGoRmeMlBzxJERm71gzfe
         lRKImIyXOElxq7QjcsAV/c1Hti+hv3JbsxZNmqbo82LlRPp+CmgvZaL5ZgFS17GY225N
         VjPxLMaKWa1YUBZe0oAwIei/rb9V4nSuIzQNqen1N+UvmkcSvdDynHBN3yEfVHAQgfs3
         25IpkXUxGYoO754WkV5/NLQK1v9JqnvbQyoFmvK4e8KjQ5eUROiUcFJJcSUe7o05K2I4
         X3zyslx+jGikRNQFIJnyyA8UdWj3yboiBpV8xL+UjM6Ut335bqnAKq+y9VsGTH+EEw9d
         CCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGAVQqa8Y5M61rBsJJuSDw9l073QzNEWTldSMTvVAZ0=;
        b=6HQRsnkR+4y72wM4QY2KwPrSavNU1ypBlzxMsC+pQn+eI7Nd51K6p2UF1uXp0Bo5dU
         oSwE7Fvj2keEVGixwe2aA5LX9+gaDGmemxk57F0IGvVdj0scPM0RJ1PXBmB6wYr2nMN+
         S4Io0nCONfqEz1lPpxyN/GIWX7v6o+ayZscLtoZBNDSREPVmCkx6I32uKbr3ywRhL2Oh
         rqsbjp7Va4R/kLSrIRPpZ+qNtYRs9YdGSt3gN3whu8vJetQKUs66oBZWajrDK3o/S+WY
         OD6/+S6D+cNkn2mm/WFzaiYWW3J5tcfprNgUHeySco12iNOpurNJIK/JU6AYhktktpIh
         lhYQ==
X-Gm-Message-State: AO0yUKX2Um01d5Z8lTiC8WDWM8WiV66HClr7d8EzKGQIfwlRaCSmHIRd
        3+Cin0+3TC5ZNVeDT/iLPu0=
X-Google-Smtp-Source: AK7set93jQUdHl2XP6dXES4tM+HY0a0Et0hMAi4q7t+ve1n6hDyXp/0VHaFsW3CVNqjoW0l13BImXQ==
X-Received: by 2002:a62:1715:0:b0:593:b169:ae51 with SMTP id 21-20020a621715000000b00593b169ae51mr8017210pfx.32.1675145198421;
        Mon, 30 Jan 2023 22:06:38 -0800 (PST)
Received: from google.com ([2601:647:6780:ff0:5043:e7ed:e642:f4d2])
        by smtp.gmail.com with ESMTPSA id t1-20020aa79461000000b0058da7e58008sm8497837pfq.36.2023.01.30.22.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 22:06:37 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Mon, 30 Jan 2023 22:06:34 -0800
From:   Namhyung Kim <namhyung@kernel.org>
To:     Hao Luo <haoluo@google.com>
Cc:     Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@meta.com
Subject: Re: CORE feature request: support checking field type directly
Message-ID: <Y9iv6i8GBIvT/wPQ@google.com>
References: <CA+khW7ju-gewZVNxopBi3Uvhiv8Wb=a-D4gaW3MD-NkUg0WSSg@mail.gmail.com>
 <20230117215658.xec7cirlfx2z7z2m@muellerd-fedora-PC2BDTX9>
 <20230117222158.uyezr5ab72ck5fhv@muellerd-fedora-PC2BDTX9>
 <CA+khW7gFq3VKEvF7hZXQsLJagz=HMZ4kJwh=QdmFG1pFbq1xRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+khW7gFq3VKEvF7hZXQsLJagz=HMZ4kJwh=QdmFG1pFbq1xRw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hao,

On Tue, Jan 17, 2023 at 04:55:44PM -0800, Hao Luo wrote:
> Hi Daniel,
> 
> On Tue, Jan 17, 2023 at 2:22 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > I apologize for the response. Somehow Andrii's reply and the entire thread was
> > lost on me. Anyway, glad it's working for you.
> >
> 
> Andrii helped me get it work. TYPE_MATCHES is a solution to my
> problem. Now I have a better understanding on how
> bpf_core_type_matches works.
> 
> For the record, the following works on my old kernel and new kernels:
> 
> struct rw_semaphore___old {
>         struct task_struct *owner;
> };
> 
> struct rw_semaphore___new {
>         atomic_long_t owner;
> };
> 
> u64 owner;
> if (bpf_core_type_matches(struct rw_semaphore___old)) { /* owner is
> task_struct pointer */
>         struct rw_semaphore___old *old = (struct rw_semaphore___old *)sem;
>         owner = (u64)sem->owner;
> } else if (bpf_core_type_matches(struct rw_semaphore___new)) { /*
> owner field is atomic_long_t */
>         struct rw_semaphore___new *new = (struct rw_semaphore___new *)sem;
>         owner = (u64)new->owner.counter;
> }
 
Thanks for taking care of this.  It looks good!

But I'm seeing a compiler error with this change like below.
("Incorrect flag for llvm.bpf.preserve.type.info intrinsic")
Maybe we need to check if the compiler supports it?

Thanks,
Namhyung


    CLANG   /home/namhyung/project/linux/tools/perf/util/bpf_skel/.tmp/lock_contention.bpf.o
  fatal error: error in backend: Incorrect flag for llvm.bpf.preserve.type.info intrinsic
  PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace, preprocessed source, and associated run script.
  Stack dump:
  0.	Program arguments: clang -g -O2 -target bpf -Wall -Werror -I/home/namhyung/project/linux/tools/perf/util/bpf_skel/.tmp/.. -I/home/namhyung/project/linux/tools/perf/libbpf/include -c util/bpf_skel/lock_contention.bpf.c -o /home/namhyung/project/linux/tools/perf/util/bpf_skel/.tmp/lock_contention.bpf.o
  1.	<eof> parser at end of file
  2.	Optimizer
   #0 0x00007f1a070a5291 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xea5291)
   #1 0x00007f1a070a2fbe llvm::sys::RunSignalHandlers() (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xea2fbe)
   #2 0x00007f1a070a464b llvm::sys::CleanupOnSignal(unsigned long) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xea464b)
   #3 0x00007f1a06fcb62a (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xdcb62a)
   #4 0x00007f1a06fcb5cb (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xdcb5cb)
   #5 0x00007f1a0709f627 llvm::sys::Process::Exit(int, bool) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xe9f627)
   #6 0x00000000004142c2 (/usr/lib/llvm-14/bin/clang+0x4142c2)
   #7 0x00007f1a06fda393 llvm::report_fatal_error(llvm::Twine const&, bool) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xdda393)
   #8 0x00007f1a06fda276 (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xdda276)
   #9 0x00007f1a091d4d54 (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x2fd4d54)
  #10 0x00007f1a091d0434 (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x2fd0434)
  #11 0x00007f1a091d01a5 (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x2fd01a5)
  #12 0x00007f1a091e431d (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x2fe431d)
  #13 0x00007f1a07214d8e llvm::PassManager<llvm::Function, llvm::AnalysisManager<llvm::Function> >::run(llvm::Function&, llvm::AnalysisManager<llvm::Function>&) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x1014d8e)
  #14 0x00007f1a08e0ec0d (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x2c0ec0d)
  #15 0x00007f1a07218cb1 llvm::ModuleToFunctionPassAdaptor::run(llvm::Module&, llvm::AnalysisManager<llvm::Module>&) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x1018cb1)
  #16 0x00007f1a08e0ea3d (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x2c0ea3d)
  #17 0x00007f1a072139ae llvm::PassManager<llvm::Module, llvm::AnalysisManager<llvm::Module> >::run(llvm::Module&, llvm::AnalysisManager<llvm::Module>&) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0x10139ae)
  #18 0x00007f1a0e4938ee (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x18938ee)
  #19 0x00007f1a0e4890e6 clang::EmitBackendOutput(clang::DiagnosticsEngine&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::TargetOptions const&, clang::LangOptions const&, llvm::StringRef, llvm::Module*, clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >) (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x18890e6)
  #20 0x00007f1a0e7adf95 (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x1badf95)
  #21 0x00007f1a0d634914 clang::ParseAST(clang::Sema&, bool, bool) (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0xa34914)
  #22 0x00007f1a0e7aa261 clang::CodeGenAction::ExecuteAction() (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x1baa261)
  #23 0x00007f1a0f14b887 clang::FrontendAction::Execute() (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x254b887)
  #24 0x00007f1a0f0a11f6 clang::CompilerInstance::ExecuteAction(clang::FrontendAction&) (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x24a11f6)
  #25 0x00007f1a0f1c563b clang::ExecuteCompilerInvocation(clang::CompilerInstance*) (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x25c563b)
  #26 0x0000000000413e93 cc1_main(llvm::ArrayRef<char const*>, char const*, void*) (/usr/lib/llvm-14/bin/clang+0x413e93)
  #27 0x00000000004120cc (/usr/lib/llvm-14/bin/clang+0x4120cc)
  #28 0x00007f1a0ed1d052 (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x211d052)
  #29 0x00007f1a06fcb5ad llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>) (/lib/x86_64-linux-gnu/libLLVM-14.so.1+0xdcb5ad)
  #30 0x00007f1a0ed1cb50 clang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*, bool*) const (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x211cb50)
  #31 0x00007f1a0ece70f3 clang::driver::Compilation::ExecuteCommand(clang::driver::Command const&, clang::driver::Command const*&) const (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x20e70f3)
  #32 0x00007f1a0ece737a clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*> >&) const (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x20e737a)
  #33 0x00007f1a0ed01677 clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*> >&) (/lib/x86_64-linux-gnu/libclang-cpp.so.14+0x2101677)
  #34 0x0000000000411b36 main (/usr/lib/llvm-14/bin/clang+0x411b36)
  #35 0x00007f1a0604618a __libc_start_call_main ./csu/../sysdeps/nptl/libc_start_call_main.h:74:3
  #36 0x00007f1a06046245 call_init ./csu/../csu/libc-start.c:128:20
  #37 0x00007f1a06046245 __libc_start_main ./csu/../csu/libc-start.c:368:5
  #38 0x000000000040efb1 _start (/usr/lib/llvm-14/bin/clang+0x40efb1)
  clang: error: clang frontend command failed with exit code 70 (use -v to see invocation)
  Debian clang version 14.0.6
  Target: bpf
  Thread model: posix
  InstalledDir: /usr/bin

