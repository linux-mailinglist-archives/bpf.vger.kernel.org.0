Return-Path: <bpf+bounces-52315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7685A414D9
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 06:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD271892292
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 05:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301FD1AAE28;
	Mon, 24 Feb 2025 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P1x5K1Ny"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08093C14
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 05:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740375660; cv=none; b=Mcjnl8+OUVKD9RHhLKbHNdMAY5QbyZMro9P9cteZLyZPZmmlBc2TqkG76LQ/U49RhkaCEYrbOL2Li9HCLpQFav1BAWrLQFFljVidIMNfpoh/SFEvOumax23F9OPXIWc797ar44UONn3roschu9TKRx8gajblRQzw1BTUSwqyq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740375660; c=relaxed/simple;
	bh=jMcA56KJwEHclgUwtOGYMANjMFFjMies+cV5xQzcugc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHbR9GaBflOjlryVUgledHTVoE78Y3yNArM+eLFEPzvTuNAptRNILvQZRyVhBDdAKqzXQADtlmrWzDhUpmwjKKym5bb+fet0eNFFmnsHJHJFuG7bpbs9zII74xI1HhqxeXV8jV8cXFZ0bPJnz8ZDPA6FoMQ+3vX5rfLDGzoc/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P1x5K1Ny; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd1b3f58-c27f-403d-ad99-644b7d06ecb3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740375655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01oUB3Hx0EMkqmDUIVAPSxjx9UqeOLB8efrLNoiUG6Y=;
	b=P1x5K1Ny8MA487aqy8uzujeG5u+J+xual4N83UvCL9sRfJs4nUEMyTMeMfNzu9czYtusAZ
	wVdWi/GO7XIoUKadMgDTgPVCPsOscCAc/jtNDODQ9hc7NgUlXu6AB/Zqt2yg7ClDAl21Wm
	gia11eZ/c2TlPKo2NeTTGjn5JzOHa4E=
Date: Mon, 24 Feb 2025 13:40:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH bpf-next v2 4/4] selftests/bpf: Add cases to test
 global percpu data
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Eddy Z <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
References: <20250213161931.46399-1-leon.hwang@linux.dev>
 <20250213161931.46399-5-leon.hwang@linux.dev>
 <CAADnVQKtNg898X-n+LrRQ+1RHnTiEWGTppfm=QLauyjne24-8Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQKtNg898X-n+LrRQ+1RHnTiEWGTppfm=QLauyjne24-8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/2/19 09:54, Alexei Starovoitov wrote:
> On Thu, Feb 13, 2025 at 8:20 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]

>> +
>> +       ASSERT_EQ(skel->percpu->data, -1, "skel->percpu->data");
>> +       ASSERT_FALSE(skel->percpu->run, "skel->percpu->run");
>> +       ASSERT_EQ(skel->percpu->data2, 0, "skel->percpu->data2");
> 
> this will only check the value on cpu0, right?
> Let's check it on all ?
> 

skel->percpu keeps only one image of the initial .percpu data for all CPUs.

Then, before .percpu map's bpf_map_update_elem(), libbpf prepares a
def.value_sz*num_cpus bytes buffer and fills the buffer with
skel->percpu, which is same as map->mmaped.

>> +       map = skel->maps.percpu;
>> +       if (!ASSERT_EQ(bpf_map__type(map), BPF_MAP_TYPE_PERCPU_ARRAY, "bpf_map__type"))
>> +               goto out;
>> +       if (!ASSERT_TRUE(bpf_map__is_internal_percpu(map), "bpf_map__is_internal_percpu"))
>> +               goto out;
>> +
>> +       init_value.data = 2;
>> +       init_value.run = false;
>> +       err = bpf_map__set_initial_value(map, &init_value, sizeof(init_value));
>> +       if (!ASSERT_OK(err, "bpf_map__set_initial_value"))
>> +               goto out;
>> +
>> +       init_data = bpf_map__initial_value(map, &init_data_sz);
>> +       if (!ASSERT_OK_PTR(init_data, "bpf_map__initial_value"))
>> +               goto out;
>> +

[...]

>> +
>> +       comm_fd = open("/proc/self/comm", O_WRONLY|O_TRUNC);
>> +       if (!ASSERT_GE(comm_fd, 0, "open /proc/self/comm"))
>> +               goto out;
>> +
>> +       err = write(comm_fd, buf, sizeof(buf));
>> +       if (!ASSERT_GE(err, 0, "task rename"))
>> +               goto out;
> 
> why this odd double run of bpf prog?
> First via task_rename and then directly?
> Only use bpf_prog_test_run_opts() and avoiding attaching to a tracepoint?
> 

Oh, sorry. I copied it from raw_tp blindly.

I'll remove task_rename in patch v3.

>> +
>> +       prog_fd = lskel->progs.update_percpu_data.prog_fd;
>> +
>> +       /* run on every CPU */
>> +       for (i = 0; i < num_online; i++) {
>> +               if (!online[i])
>> +                       continue;
>> +
>> +               topts.cpu = i;
>> +               topts.retval = 0;
>> +               err = bpf_prog_test_run_opts(prog_fd, &topts);
>> +               ASSERT_OK(err, "bpf_prog_test_run_opts");
>> +               ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval");
>> +       }
>> +
>> +       key = 0;
>> +       map_fd = lskel->maps.percpu.map_fd;
>> +       err = bpf_map_lookup_elem(map_fd, &key, percpu_data);
>> +       if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
>> +               goto out;
>> +
>> +       for (i = 0; i < num_online; i++) {
>> +               if (!online[i])
>> +                       continue;
>> +
>> +               data = percpu_data + i;
>> +               ASSERT_EQ(data->data, 1, "percpu_data->data");
>> +               ASSERT_TRUE(data->run, "percpu_data->run");
>> +               ASSERT_EQ(data->data2, 0xc0de, "percpu_data->data2");
>> +       }
>> +
>> +out:
>> +       close(comm_fd);
>> +       test_global_percpu_data_lskel__destroy(lskel);
>> +       if (percpu_data)
>> +               free(percpu_data);
>> +       free(online);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
>> new file mode 100644
>> index 0000000000000..ada292d3a164c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright Leon Hwang */
> 
> Are you sure you can do it in your country?
> Often enough copyright belongs to the company you work for.
> 

I don't think I should put my company name here, because this patch is
done at my spare time, not for my company at work time.

>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +int data SEC(".percpu") = -1;
>> +int run SEC(".percpu") = 0;
>> +int data2 SEC(".percpu");
> 
> Pls add u8, array of ints and struct { .. } vars for completeness.
> 

After adding char, it hits a clang-17 BUG:

2025-02-23T13:32:30.6128324Z fatal error: error in backend: unable to
write nop sequence of 3 bytes
2025-02-23T13:32:30.6129623Z PLEASE submit a bug report to
https://github.com/llvm/llvm-project/issues/ and include the crash
backtrace, preprocessed source, and associated run script.
2025-02-23T13:32:30.6130688Z Stack dump:
2025-02-23T13:32:30.6135010Z 0.	Program arguments: clang-17 -g -Wall
-Werror -D__TARGET_ARCH_arm64 -mlittle-endian
-I/tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include
-I/tmp/work/bpf/bpf/tools/testing/selftests/bpf
-I/tmp/work/bpf/bpf/tools/include/uapi
-I/tmp/work/bpf/bpf/tools/testing/selftests/usr/include -std=gnu11
-fno-strict-aliasing -Wno-compare-distinct-pointer-types -idirafter
/usr/lib/llvm-17/lib/clang/17/include -idirafter /usr/local/include
-idirafter /usr/include/aarch64-linux-gnu -idirafter /usr/include
-DENABLE_ATOMICS_TESTS -O2 --target=bpfel -c
progs/test_global_percpu_data.c -mcpu=v3 -o
/tmp/work/bpf/bpf/tools/testing/selftests/bpf/test_global_percpu_data.bpf.o
2025-02-23T13:32:30.6139287Z 1.	<eof> parser at end of file
2025-02-23T13:32:30.6139669Z 2.	Code generation
2025-02-23T13:32:30.6140548Z Stack dump without symbol names (ensure you
have llvm-symbolizer in your PATH or set the environment var
`LLVM_SYMBOLIZER_PATH` to point to it):
2025-02-23T13:32:30.6155286Z   CLNG-BPF [test_progs]
test_ksyms_btf_null_check.bpf.o
2025-02-23T13:32:30.6183127Z   CLNG-BPF [test_progs]
test_ksyms_btf_write_check.bpf.o
2025-02-23T13:32:30.6246698Z 0  libLLVM-17.so.1    0x0000ffffb2b64654
llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 84
2025-02-23T13:32:30.6250241Z 1  libLLVM-17.so.1    0x0000ffffb2b62890
llvm::sys::RunSignalHandlers() + 116
2025-02-23T13:32:30.6253698Z 2  libLLVM-17.so.1    0x0000ffffb2ab73a0
2025-02-23T13:32:30.6257316Z 3  libLLVM-17.so.1    0x0000ffffb2ab734c
2025-02-23T13:32:30.6261230Z 4  libLLVM-17.so.1    0x0000ffffb2b5f3dc
llvm::sys::Process::Exit(int, bool) + 52
2025-02-23T13:32:30.6261860Z 5  clang-17           0x0000aaaae8ff2210
2025-02-23T13:32:30.6265004Z 6  libLLVM-17.so.1    0x0000ffffb2ac4ea0
llvm::report_fatal_error(llvm::Twine const&, bool) + 252
2025-02-23T13:32:30.6270377Z 7  libLLVM-17.so.1    0x0000ffffb3fb92c8
llvm::MCAssembler::writeSectionData(llvm::raw_ostream&, llvm::MCSection
const*, llvm::MCAsmLayout const&) const + 3324
2025-02-23T13:32:30.6274705Z 8  libLLVM-17.so.1    0x0000ffffb3fa44fc
2025-02-23T13:32:30.6279671Z 9  libLLVM-17.so.1    0x0000ffffb3fa2fc8
2025-02-23T13:32:30.6284761Z 10 libLLVM-17.so.1    0x0000ffffb3fb9af0
llvm::MCAssembler::Finish() + 92
2025-02-23T13:32:30.6289758Z 11 libLLVM-17.so.1    0x0000ffffb3fd73e4
llvm::MCELFStreamer::finishImpl() + 204
2025-02-23T13:32:30.6294422Z 12 libLLVM-17.so.1    0x0000ffffb337f408
llvm::AsmPrinter::doFinalization(llvm::Module&) + 4812
2025-02-23T13:32:30.6298295Z 13 libLLVM-17.so.1    0x0000ffffb2cb79e4
llvm::FPPassManager::doFinalization(llvm::Module&) + 76
2025-02-23T13:32:30.6302285Z 14 libLLVM-17.so.1    0x0000ffffb2cb2564
llvm::legacy::PassManagerImpl::run(llvm::Module&) + 1004
2025-02-23T13:32:30.6308831Z 15 libclang-cpp.so.17 0x0000ffffbabaacdc
clang::EmitBackendOutput(clang::DiagnosticsEngine&,
clang::HeaderSearchOptions const&, clang::CodeGenOptions const&,
clang::TargetOptions const&, clang::LangOptions const&, llvm::StringRef,
llvm::Module*, clang::BackendAction,
llvm::IntrusiveRefCntPtr<llvm::vfs::FileSystem>,
std::unique_ptr<llvm::raw_pwrite_stream,
std::default_delete<llvm::raw_pwrite_stream>>) + 2560
2025-02-23T13:32:30.6311547Z 16 libclang-cpp.so.17 0x0000ffffbaeb387c
2025-02-23T13:32:30.6314141Z 17 libclang-cpp.so.17 0x0000ffffb9be5240
clang::ParseAST(clang::Sema&, bool, bool) + 572
2025-02-23T13:32:30.6318163Z 18 libclang-cpp.so.17 0x0000ffffbb8744a4
clang::FrontendAction::Execute() + 116
2025-02-23T13:32:30.6322561Z 19 libclang-cpp.so.17 0x0000ffffbb804cb8
clang::CompilerInstance::ExecuteAction(clang::FrontendAction&) + 768
2025-02-23T13:32:30.6326549Z 20 libclang-cpp.so.17 0x0000ffffbb8edc44
clang::ExecuteCompilerInvocation(clang::CompilerInstance*) + 528
2025-02-23T13:32:30.6327641Z 21 clang-17           0x0000aaaae8ff1e44
cc1_main(llvm::ArrayRef<char const*>, char const*, void*) + 2016
2025-02-23T13:32:30.6328373Z 22 clang-17           0x0000aaaae8fefe7c
2025-02-23T13:32:30.6330474Z 23 libclang-cpp.so.17 0x0000ffffbb50776c
2025-02-23T13:32:30.6333026Z   CLNG-BPF [test_progs] test_ksyms.bpf.o
2025-02-23T13:32:30.6334773Z 24 libLLVM-17.so.1    0x0000ffffb2ab731c
llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>) + 168
2025-02-23T13:32:30.6339524Z 25 libclang-cpp.so.17 0x0000ffffbb506e74
clang::driver::CC1Command::Execute(llvm::ArrayRef<std::optional<llvm::StringRef>>,
std::__cxx11::basic_string<char, std::char_traits<char>,
std::allocator<char>>*, bool*) const + 348
2025-02-23T13:32:30.6343604Z 26 libclang-cpp.so.17 0x0000ffffbb4d5d08
clang::driver::Compilation::ExecuteCommand(clang::driver::Command
const&, clang::driver::Command const*&, bool) const + 760
2025-02-23T13:32:30.6348046Z 27 libclang-cpp.so.17 0x0000ffffbb4d5f18
clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&,
llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*>>&,
bool) const + 140
2025-02-23T13:32:30.6352317Z 28 libclang-cpp.so.17 0x0000ffffbb4edc18
clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&,
llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*>>&) + 340
2025-02-23T13:32:30.6353837Z 29 clang-17           0x0000aaaae8fef5f0
clang_main(int, char**, llvm::ToolContext const&) + 9904
2025-02-23T13:32:30.6354564Z 30 clang-17           0x0000aaaae8ffa868
main + 52
2025-02-23T13:32:30.6355047Z 31 libc.so.6          0x0000ffffb19784c4
2025-02-23T13:32:30.6355559Z 32 libc.so.6          0x0000ffffb1978598
__libc_start_main + 152
2025-02-23T13:32:30.6356118Z 33 clang-17           0x0000aaaae8fecb70
_start + 48
2025-02-23T13:32:30.6356859Z clang-17: error: clang frontend command
failed with exit code 70 (use -v to see invocation)

For more details, pls check the failed jobs at
https://github.com/kernel-patches/bpf/pull/8543

Thanks,
Leon



