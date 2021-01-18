Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31282FA1EB
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 14:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404740AbhARNnA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 08:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404728AbhARNmq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Jan 2021 08:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610977279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7TPBEwVnqJ79ZnolUqmuqdhs8Wq75X7BO1WvPH5WhcQ=;
        b=Af6x/HxSa+9uEM65BhJxv2kjx/+zQoGMA9f6sXjifINXXYCyQapn7JTbfoXLDenGAAd3Jn
        sYQwpEln4f7eq5o5+V/mi86f74KEL8/TohQw9xhH3Q3e1kj+p0DnSqGBbVdf/2T7vmd+Ro
        vijMPKil7IZsru12OhgVRsuNGOuR080=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-cBW4OtNvOVWHQ4nu8cNU6Q-1; Mon, 18 Jan 2021 08:41:15 -0500
X-MC-Unique: cBW4OtNvOVWHQ4nu8cNU6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3564190A7BC;
        Mon, 18 Jan 2021 13:41:13 +0000 (UTC)
Received: from carbon (unknown [10.36.110.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F2836267E;
        Mon, 18 Jan 2021 13:41:02 +0000 (UTC)
Date:   Mon, 18 Jan 2021 14:41:01 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Brendan Jackman <jackmanb@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     brouer@redhat.com, BPF-dev-list <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>
Subject: Issues compiling selftests XADD - "Invalid usage of the XADD return
 value"
Message-ID: <20210118144101.01a5d410@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi All,

After rebasing (my MTU patchset) to bpf-next (232164e041e925a) I'm
getting this error when compiling selftests (full error below signature):

  "CLNG-BPF [test_maps] atomics.o"
  "fatal error: error in backend: line 27: Invalid usage of the XADD return value"
  "PLEASE submit a bug report to https://bugs.llvm.org/ [...]"

It looked like a LLVM bug, so I compiled llvm-11.1.0-rc1, but it still fails.

I noticed Brendan Jackman changes... could this be related?

- - 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

 dirs
 ~/git/kernel/bpf-next/tools/testing/selftests/bpf

  CLNG-BPF [test_maps] atomics.o
fatal error: error in backend: line 27: Invalid usage of the XADD return value
PLEASE submit a bug report to https://bugs.llvm.org/ and include the crash backtrace, preprocessed source, and associated run script.
Stack dump:
0.	Program arguments: /usr/local/bin/clang -g -mlittle-endian -Wno-compare-distinct-pointer-types -O2 -target bpf -mcpu=v3 -fcolor-diagnostics -D__TARGET_ARCH_x86 -I/home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/tools/include -I/home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf -I/home/jbrouer/git/kernel/bpf-next/tools/include/uapi -I/home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/usr/include -idirafter /usr/local/include -idirafter /usr/local/stow/llvm-11.1.0-rc1-git-9bbcb554cdbf/lib/clang/11.1.0/include -idirafter /usr/include -DENABLE_ATOMICS_TESTS -c -o /home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/atomics.o progs/atomics.c 
1.	<eof> parser at end of file
2.	Code generation
3.	Running pass 'Function Pass Manager' on module 'progs/atomics.c'.
4.	Running pass 'BPF PreEmit Checking' on function '@add'
 #0 0x0000000001969e8a llvm::sys::PrintStackTrace(llvm::raw_ostream&) (/usr/local/bin/clang+0x1969e8a)
 #1 0x0000000001967f84 llvm::sys::RunSignalHandlers() (/usr/local/bin/clang+0x1967f84)
 #2 0x0000000001968478 llvm::sys::CleanupOnSignal(unsigned long) (/usr/local/bin/clang+0x1968478)
 #3 0x00000000018f2b34 llvm::CrashRecoveryContext::HandleExit(int) (/usr/local/bin/clang+0x18f2b34)
 #4 0x0000000001961ea7 llvm::sys::Process::Exit(int) (/usr/local/bin/clang+0x1961ea7)
 #5 0x000000000095ca03 LLVMErrorHandler(void*, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, bool) (/usr/local/bin/clang+0x95ca03)
 #6 0x00000000018f7ca5 llvm::report_fatal_error(llvm::Twine const&, bool) (/usr/local/bin/clang+0x18f7ca5)
 #7 0x00000000018f7dfe (/usr/local/bin/clang+0x18f7dfe)
 #8 0x000000000096d5d1 (anonymous namespace)::BPFMIPreEmitChecking::runOnMachineFunction(llvm::MachineFunction&) (/usr/local/bin/clang+0x96d5d1)
 #9 0x0000000000f68484 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) (/usr/local/bin/clang+0xf68484)
#10 0x0000000001348a68 llvm::FPPassManager::runOnFunction(llvm::Function&) (/usr/local/bin/clang+0x1348a68)
#11 0x00000000013490e3 llvm::FPPassManager::runOnModule(llvm::Module&) (/usr/local/bin/clang+0x13490e3)
#12 0x0000000001347dc3 llvm::legacy::PassManagerImpl::run(llvm::Module&) (/usr/local/bin/clang+0x1347dc3)
#13 0x0000000001bd2514 (anonymous namespace)::EmitAssemblyHelper::EmitAssembly(clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >) (/usr/local/bin/clang+0x1bd2514)
#14 0x0000000001bd32d1 clang::EmitBackendOutput(clang::DiagnosticsEngine&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::TargetOptions const&, clang::LangOptions const&, llvm::DataLayout const&, llvm::Module*, clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >) (/usr/local/bin/clang+0x1bd32d1)
#15 0x00000000027798ce clang::BackendConsumer::HandleTranslationUnit(clang::ASTContext&) (/usr/local/bin/clang+0x27798ce)
#16 0x00000000032c7449 clang::ParseAST(clang::Sema&, bool, bool) (/usr/local/bin/clang+0x32c7449)
#17 0x0000000002176081 clang::FrontendAction::Execute() (/usr/local/bin/clang+0x2176081)
#18 0x000000000212e21b clang::CompilerInstance::ExecuteAction(clang::FrontendAction&) (/usr/local/bin/clang+0x212e21b)
#19 0x00000000022307a0 clang::ExecuteCompilerInvocation(clang::CompilerInstance*) (/usr/local/bin/clang+0x22307a0)
#20 0x000000000095d153 cc1_main(llvm::ArrayRef<char const*>, char const*, void*) (/usr/local/bin/clang+0x95d153)
#21 0x000000000095b03b ExecuteCC1Tool(llvm::SmallVectorImpl<char const*>&) (/usr/local/bin/clang+0x95b03b)
#22 0x0000000002011215 void llvm::function_ref<void ()>::callback_fn<clang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*, bool*) const::'lambda'()>(long) (/usr/local/bin/clang+0x2011215)
#23 0x00000000018f29c3 llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>) (/usr/local/bin/clang+0x18f29c3)
#24 0x0000000002011c71 clang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*, bool*) const (.part.0) (/usr/local/bin/clang+0x2011c71)
#25 0x0000000001fe9d21 clang::driver::Compilation::ExecuteCommand(clang::driver::Command const&, clang::driver::Command const*&) const (/usr/local/bin/clang+0x1fe9d21)
#26 0x0000000001fea54d clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*> >&) const (/usr/local/bin/clang+0x1fea54d)
#27 0x0000000001ff571f clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*> >&) (/usr/local/bin/clang+0x1ff571f)
#28 0x00000000008ee422 main (/usr/local/bin/clang+0x8ee422)
#29 0x00007f2417f0b1a3 __libc_start_main (/lib64/libc.so.6+0x271a3)
#30 0x000000000095abee _start (/usr/local/bin/clang+0x95abee)
make: *** [Makefile:417: /home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/atomics.o] Error 1

