Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A40D2FA20D
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 14:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392436AbhARNs6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 08:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404822AbhARNs3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 08:48:29 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB025C061573
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 05:47:48 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q1so32803149ion.8
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 05:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9sKXj88R+9uv83LJgK1cuY/6OafcX0kfxqOGAwBhPzk=;
        b=QRa85HvtnSw2qMq7wURs7V3CrWOtzXsoi5efztFT7+wofI3iIs9ZcA0A/E7zJ+9EsS
         qqpFS4SJ/JTZZGgQybTBUg0UMrKKD2gSsdwaoSp527OQ5lfS7EVu5UvCKU9w682AlUwc
         STImLHSQlKJtbO9fimyAEYR5jHCTBMdPduz/FHHTBFcrkrzzWV4xBEpXkrlJ2TVRyhvJ
         KvbpLXMLZpIJFW8mAoZpgBi9WYfj1WCNwQqKbESJRkq6PmgD7zXb3ZyDpn/XsUt4XGSD
         EJTSvjBLwLkkHAKbKo2pNRa7TH1rqj2Sd+Tp2tDAM35xbOI9T1sHaoR9bBvhjEhYde9+
         lU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9sKXj88R+9uv83LJgK1cuY/6OafcX0kfxqOGAwBhPzk=;
        b=KrjdEY5v03GdYsvHE81rYsJrUtkHywsrf9/uIKCOfTCA2n/DYXivEYCWfXK0ekZSIJ
         sKqkKPGuqqTYumatKi39XBNRL/GfrIWb3EldYFDhewITHW0wBOqoL/JdEipajr0JBbjv
         Gvq97vob3bIQSuwBMnGDn5NEaspMxMnotv/e+yaTJ/Qp6TlBLQ7Bhz7CHCTj8OvHIDdK
         VKAWFH6ep4QCkGr9GpwhdUs11H6Ck5qX9/gYGEbg4NaYlFM8812kg7nCFP4mgl7WHiTf
         Oki/51zMTvibEJ9qTGOta1/RSRgnICVOOprZUmaKCXZhetNMMCqG3LpJw+N5oR98Bcjh
         Ei2A==
X-Gm-Message-State: AOAM532m/SRKMrOeg5cPUQs4Ylsn+kHVZBa8+7C5QUd4+wKYO9+9shh3
        1ZiKrux8wCUkvTl0STKW+ja9Gtldip8oH+zw68vgrQ==
X-Google-Smtp-Source: ABdhPJyle6nkRylZi4tO3iKICxpOYwCSb9LsWKxPDPzsygnNwUnp7+aB4umaQUMD2b+lExpzhrNDEE37pF2XTE+nUYg=
X-Received: by 2002:a92:c24b:: with SMTP id k11mr22106937ilo.276.1610977667515;
 Mon, 18 Jan 2021 05:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20210118144101.01a5d410@carbon>
In-Reply-To: <20210118144101.01a5d410@carbon>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 18 Jan 2021 14:47:36 +0100
Message-ID: <CA+i-1C1Te+c876s3JYSE6o7fw+TaTbC7TnMmyw8kx5Tg1jUxNw@mail.gmail.com>
Subject: Re: Issues compiling selftests XADD - "Invalid usage of the XADD
 return value"
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jesper,

On Mon, 18 Jan 2021 at 14:41, Jesper Dangaard Brouer <brouer@redhat.com> wr=
ote:
>
> Hi All,
>
> After rebasing (my MTU patchset) to bpf-next (232164e041e925a) I'm
> getting this error when compiling selftests (full error below signature):
>
>   "CLNG-BPF [test_maps] atomics.o"
>   "fatal error: error in backend: line 27: Invalid usage of the XADD retu=
rn value"
>   "PLEASE submit a bug report to https://bugs.llvm.org/ [...]"
>
> It looked like a LLVM bug, so I compiled llvm-11.1.0-rc1, but it still fa=
ils.
>
> I noticed Brendan Jackman changes... could this be related?

Yes, since bpf-next commit 98d666d05a1d970 ("bpf: Add tests for new
BPF atomic operations") you need llvm-project commit 286daafd6512 (was
https://reviews.llvm.org/D72184) for the selftests, which will be in
Clang 12. You'll need to build LLVM from master.

> - -
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>
>  dirs
>  ~/git/kernel/bpf-next/tools/testing/selftests/bpf
>
>   CLNG-BPF [test_maps] atomics.o
> fatal error: error in backend: line 27: Invalid usage of the XADD return =
value
> PLEASE submit a bug report to https://bugs.llvm.org/ and include the cras=
h backtrace, preprocessed source, and associated run script.
> Stack dump:
> 0.      Program arguments: /usr/local/bin/clang -g -mlittle-endian -Wno-c=
ompare-distinct-pointer-types -O2 -target bpf -mcpu=3Dv3 -fcolor-diagnostic=
s -D__TARGET_ARCH_x86 -I/home/jbrouer/git/kernel/bpf-next/tools/testing/sel=
ftests/bpf/tools/include -I/home/jbrouer/git/kernel/bpf-next/tools/testing/=
selftests/bpf -I/home/jbrouer/git/kernel/bpf-next/tools/include/uapi -I/hom=
e/jbrouer/git/kernel/bpf-next/tools/testing/selftests/usr/include -idirafte=
r /usr/local/include -idirafter /usr/local/stow/llvm-11.1.0-rc1-git-9bbcb55=
4cdbf/lib/clang/11.1.0/include -idirafter /usr/include -DENABLE_ATOMICS_TES=
TS -c -o /home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/atom=
ics.o progs/atomics.c
> 1.      <eof> parser at end of file
> 2.      Code generation
> 3.      Running pass 'Function Pass Manager' on module 'progs/atomics.c'.
> 4.      Running pass 'BPF PreEmit Checking' on function '@add'
>  #0 0x0000000001969e8a llvm::sys::PrintStackTrace(llvm::raw_ostream&) (/u=
sr/local/bin/clang+0x1969e8a)
>  #1 0x0000000001967f84 llvm::sys::RunSignalHandlers() (/usr/local/bin/cla=
ng+0x1967f84)
>  #2 0x0000000001968478 llvm::sys::CleanupOnSignal(unsigned long) (/usr/lo=
cal/bin/clang+0x1968478)
>  #3 0x00000000018f2b34 llvm::CrashRecoveryContext::HandleExit(int) (/usr/=
local/bin/clang+0x18f2b34)
>  #4 0x0000000001961ea7 llvm::sys::Process::Exit(int) (/usr/local/bin/clan=
g+0x1961ea7)
>  #5 0x000000000095ca03 LLVMErrorHandler(void*, std::__cxx11::basic_string=
<char, std::char_traits<char>, std::allocator<char> > const&, bool) (/usr/l=
ocal/bin/clang+0x95ca03)
>  #6 0x00000000018f7ca5 llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/usr/local/bin/clang+0x18f7ca5)
>  #7 0x00000000018f7dfe (/usr/local/bin/clang+0x18f7dfe)
>  #8 0x000000000096d5d1 (anonymous namespace)::BPFMIPreEmitChecking::runOn=
MachineFunction(llvm::MachineFunction&) (/usr/local/bin/clang+0x96d5d1)
>  #9 0x0000000000f68484 llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (/usr/local/bin/clang+0xf68484)
> #10 0x0000000001348a68 llvm::FPPassManager::runOnFunction(llvm::Function&=
) (/usr/local/bin/clang+0x1348a68)
> #11 0x00000000013490e3 llvm::FPPassManager::runOnModule(llvm::Module&) (/=
usr/local/bin/clang+0x13490e3)
> #12 0x0000000001347dc3 llvm::legacy::PassManagerImpl::run(llvm::Module&) =
(/usr/local/bin/clang+0x1347dc3)
> #13 0x0000000001bd2514 (anonymous namespace)::EmitAssemblyHelper::EmitAss=
embly(clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::d=
efault_delete<llvm::raw_pwrite_stream> >) (/usr/local/bin/clang+0x1bd2514)
> #14 0x0000000001bd32d1 clang::EmitBackendOutput(clang::DiagnosticsEngine&=
, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::T=
argetOptions const&, clang::LangOptions const&, llvm::DataLayout const&, ll=
vm::Module*, clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream,=
 std::default_delete<llvm::raw_pwrite_stream> >) (/usr/local/bin/clang+0x1b=
d32d1)
> #15 0x00000000027798ce clang::BackendConsumer::HandleTranslationUnit(clan=
g::ASTContext&) (/usr/local/bin/clang+0x27798ce)
> #16 0x00000000032c7449 clang::ParseAST(clang::Sema&, bool, bool) (/usr/lo=
cal/bin/clang+0x32c7449)
> #17 0x0000000002176081 clang::FrontendAction::Execute() (/usr/local/bin/c=
lang+0x2176081)
> #18 0x000000000212e21b clang::CompilerInstance::ExecuteAction(clang::Fron=
tendAction&) (/usr/local/bin/clang+0x212e21b)
> #19 0x00000000022307a0 clang::ExecuteCompilerInvocation(clang::CompilerIn=
stance*) (/usr/local/bin/clang+0x22307a0)
> #20 0x000000000095d153 cc1_main(llvm::ArrayRef<char const*>, char const*,=
 void*) (/usr/local/bin/clang+0x95d153)
> #21 0x000000000095b03b ExecuteCC1Tool(llvm::SmallVectorImpl<char const*>&=
) (/usr/local/bin/clang+0x95b03b)
> #22 0x0000000002011215 void llvm::function_ref<void ()>::callback_fn<clan=
g::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringRe=
f> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocat=
or<char> >*, bool*) const::'lambda'()>(long) (/usr/local/bin/clang+0x201121=
5)
> #23 0x00000000018f29c3 llvm::CrashRecoveryContext::RunSafely(llvm::functi=
on_ref<void ()>) (/usr/local/bin/clang+0x18f29c3)
> #24 0x0000000002011c71 clang::driver::CC1Command::Execute(llvm::ArrayRef<=
llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::ch=
ar_traits<char>, std::allocator<char> >*, bool*) const (.part.0) (/usr/loca=
l/bin/clang+0x2011c71)
> #25 0x0000000001fe9d21 clang::driver::Compilation::ExecuteCommand(clang::=
driver::Command const&, clang::driver::Command const*&) const (/usr/local/b=
in/clang+0x1fe9d21)
> #26 0x0000000001fea54d clang::driver::Compilation::ExecuteJobs(clang::dri=
ver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::Co=
mmand const*> >&) const (/usr/local/bin/clang+0x1fea54d)
> #27 0x0000000001ff571f clang::driver::Driver::ExecuteCompilation(clang::d=
river::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::Co=
mmand const*> >&) (/usr/local/bin/clang+0x1ff571f)
> #28 0x00000000008ee422 main (/usr/local/bin/clang+0x8ee422)
> #29 0x00007f2417f0b1a3 __libc_start_main (/lib64/libc.so.6+0x271a3)
> #30 0x000000000095abee _start (/usr/local/bin/clang+0x95abee)
> make: *** [Makefile:417: /home/jbrouer/git/kernel/bpf-next/tools/testing/=
selftests/bpf/atomics.o] Error 1
>
