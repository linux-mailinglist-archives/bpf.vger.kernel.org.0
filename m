Return-Path: <bpf+bounces-35050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDEB9372A5
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 05:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0AC2816B5
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 03:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948A2C13B;
	Fri, 19 Jul 2024 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A8CKuZoY"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D422092
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 03:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721358074; cv=none; b=BQ5MCOgviavZ8N0zAjSOaQkOGtQ8D/B/OWrTOuAZJmsfKltMa1niTryF/ZAycYvfQG7ahqv5P5Zne+I3fyVEkIvucKvFsB5dDwgExyKr7YzWoyUwrvogtmKJIxZbyXHdIfgPfTycvoMkqLUyiVVvnQB8cunMV8XZJpMowHcjBZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721358074; c=relaxed/simple;
	bh=+8koWRGUs2F3dYpmP5jmPDzT+Q4cTDkDWeCYvyoY+JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=My0DBkd1ZiwgdeYAH0wlt9gBUhNlWUUp5jey1exA8bOLPIwWchznCOZoHOJgAolybuB1NonJ91wh0sCJXj0H2LMzJnCkBjOSHQm9vfTN6sa5BzUsaqE1hJYqJfE5jr37CbwT+6Q14KeAXJIk2Jvk4UL0bkLYjfJL3ShhRJ9kkFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A8CKuZoY; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: memxor@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721358069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Q66hW3aIHcQ0lZXlSG6spnOKa8nHd4MzGvIH22pzAE=;
	b=A8CKuZoYjOXO1qZkOQAu35BLepRMQovqK6mrcS4rHE9a7qHQSyQWC59FRCpXp0YZU1zxkk
	1N9peK1TVHDIvDsLgpCEZkQSb4t0b7NM+beTgp8FW08hU4+v6L0Zhjx5EeOerpxZOW5pEP
	MopLSYfkzcw/cXuv8gI4613St8joIBY=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <a714d703-d55b-4425-bfeb-1fef2318fc75@linux.dev>
Date: Thu, 18 Jul 2024 20:01:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
Content-Language: en-GB
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <20240718205203.3652080-1-yonghong.song@linux.dev>
 <1297da19-18a7-4727-8dab-e45ef0651e14@linux.dev>
 <CAP01T74UdrhC3FXbSYzi91r47n=RMj0XR=R+54YVD4jhsCy3Zw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAP01T74UdrhC3FXbSYzi91r47n=RMj0XR=R+54YVD4jhsCy3Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/18/24 2:59 PM, Kumar Kartikeya Dwivedi wrote:
> On Thu, 18 Jul 2024 at 23:44, Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 7/18/24 1:52 PM, Yonghong Song wrote:
>>> This patch intends to show some benchmark results comparing a bpf
>>> program with vs. without private stack. The patch is not intended
>>> to land since it hacks existing kernel interface in order to
>>> do proper comparison. The bpf program is similar to
>>> 7df4e597ea2c ("selftests/bpf: add batched, mostly in-kernel BPF triggering benchmarks")
>>> where a raw_tp program is triggered with bpf_prog_test_run_opts() and
>>> the raw_tp program has a loop of helper bpf_get_numa_node_id() which
>>> will enable a fentry prog to run. The fentry prog calls three
>>> do-nothing functions to maximumly expose the cost of private stack.
>>>
>>> The following is the jited code for bpf prog in progs/private_stack.c
>>> without private stack. The number of batch iterations is 4096.
>>>
>>> subprog:
>>> 0:  f3 0f 1e fa             endbr64
>>> 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
>>> 9:  66 90                   xchg   ax,ax
>>> b:  55                      push   rbp
>>> c:  48 89 e5                mov    rbp,rsp
>>> f:  f3 0f 1e fa             endbr64
>>> 13: 31 c0                   xor    eax,eax
>>> 15: c9                      leave
>>> 16: c3                      ret
>>>
>>> main prog:
>>> 0:  f3 0f 1e fa             endbr64
>>> 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
>>> 9:  66 90                   xchg   ax,ax
>>> b:  55                      push   rbp
>>> c:  48 89 e5                mov    rbp,rsp
>>> f:  f3 0f 1e fa             endbr64
>>> 13: 48 bf 00 e0 57 00 00    movabs rdi,0xffffc9000057e000
>>> 1a: c9 ff ff
>>> 1d: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>> 21: 48 83 c6 01             add    rsi,0x1
>>> 25: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
>>> 29: e8 6e 00 00 00          call   0x9c
>>> 2e: e8 69 00 00 00          call   0x9c
>>> 33: e8 64 00 00 00          call   0x9c
>>> 38: 31 c0                   xor    eax,eax
>>> 3a: c9                      leave
>>> 3b: c3                      ret
>>>
>>> The following are the jited progs with private stack:
>>>
>>> subprog:
>>> 0:  f3 0f 1e fa             endbr64
>>> 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
>>> 9:  66 90                   xchg   ax,ax
>>> b:  55                      push   rbp
>>> c:  48 89 e5                mov    rbp,rsp
>>> f:  f3 0f 1e fa             endbr64
>>> 13: 49 b9 70 a6 c1 08 7e    movabs r9,0x607e08c1a670
>>> 1a: 60 00 00
>>> 1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
>>> 24: 02 00
>>> 26: 31 c0                   xor    eax,eax
>>> 28: c9                      leave
>>> 29: c3                      ret
>>>
>>> main prog:
>>> 0:  f3 0f 1e fa             endbr64
>>> 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
>>> 9:  66 90                   xchg   ax,ax
>>> b:  55                      push   rbp
>>> c:  48 89 e5                mov    rbp,rsp
>>> f:  f3 0f 1e fa             endbr64
>>> 13: 49 b9 88 a6 c1 08 7e    movabs r9,0x607e08c1a688
>>> 1a: 60 00 00
>>> 1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
>>> 24: 02 00
>>> 26: 48 bf 00 d0 5b 00 00    movabs rdi,0xffffc900005bd000
>>> 2d: c9 ff ff
>>> 30: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>> 34: 48 83 c6 01             add    rsi,0x1
>>> 38: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
>>> 3c: 41 51                   push   r9
>>> 3e: e8 46 23 51 e1          call   0xffffffffe1512389
>>> 43: 41 59                   pop    r9
>>> 45: 41 51                   push   r9
>>> 47: e8 3d 23 51 e1          call   0xffffffffe1512389
>>> 4c: 41 59                   pop    r9
>>> 4e: 41 51                   push   r9
>>> 50: e8 34 23 51 e1          call   0xffffffffe1512389
>>> 55: 41 59                   pop    r9
>>> 57: 31 c0                   xor    eax,eax
>>> 59: c9                      leave
>>> 5a: c3                      ret
>>>
>>>   From the above, it is clear for subprog and main prog,
>>> we have some r9 related overhead including retriving the stack
>>> in the jit prelog code:
>>>     movabs r9,0x607e08c1a688
>>>     add    r9,QWORD PTR gs:0x21a00
>>> and 'push r9' and 'pop r9' around subprog calls.
>>>
>>> I did some benchmarking on an intel box (Intel(R) Xeon(R) D-2191A CPU @ 1.60GHz)
>>> which has 20 cores and 80 cpus. The number of hits are in the unit
>>> of loop iterations.
>>>
>>> The following are two benchmark results and a few other tries show
>>> similar results in terms of variation.
>>>     $ ./benchs/run_bench_private_stack.sh
>>>     no-private-stack-1:  2.152 ± 0.004M/s (drops 0.000 ± 0.000M/s)
>>>     private-stack-1:     2.226 ± 0.003M/s (drops 0.000 ± 0.000M/s)
>>>     no-private-stack-8:  89.086 ± 0.674M/s (drops 0.000 ± 0.000M/s)
>>>     private-stack-8:     90.023 ± 0.117M/s (drops 0.000 ± 0.000M/s)
>>>     no-private-stack-64:  1545.383 ± 3.574M/s (drops 0.000 ± 0.000M/s)
>>>     private-stack-64:    1534.630 ± 2.063M/s (drops 0.000 ± 0.000M/s)
>>>     no-private-stack-512:  14591.591 ± 15.202M/s (drops 0.000 ± 0.000M/s)
>>>     private-stack-512:   14323.796 ± 13.165M/s (drops 0.000 ± 0.000M/s)
>>>     no-private-stack-2048:  58680.977 ± 46.116M/s (drops 0.000 ± 0.000M/s)
>>>     private-stack-2048:  58614.699 ± 22.031M/s (drops 0.000 ± 0.000M/s)
>>>     no-private-stack-4096:  119974.497 ± 90.985M/s (drops 0.000 ± 0.000M/s)
>>>     private-stack-4096:  114841.949 ± 59.514M/s (drops 0.000 ± 0.000M/s)
>>>     $ ./benchs/run_bench_private_stack.sh
>>>     no-private-stack-1:  2.246 ± 0.002M/s (drops 0.000 ± 0.000M/s)
>>>     private-stack-1:     2.232 ± 0.005M/s (drops 0.000 ± 0.000M/s)
>>>     no-private-stack-8:  91.446 ± 0.055M/s (drops 0.000 ± 0.000M/s)
>>>     private-stack-8:     90.120 ± 0.069M/s (drops 0.000 ± 0.000M/s)
>>>     no-private-stack-64:  1578.374 ± 1.508M/s (drops 0.000 ± 0.000M/s)
>>>     private-stack-64:    1514.909 ± 3.898M/s (drops 0.000 ± 0.000M/s)
>>>     no-private-stack-512:  14767.811 ± 22.399M/s (drops 0.000 ± 0.000M/s)
>>>     private-stack-512:   14232.382 ± 227.217M/s (drops 0.000 ± 0.000M/s)
>>>     no-private-stack-2048:  58342.372 ± 81.519M/s (drops 0.000 ± 0.000M/s)
>>>     private-stack-2048:  54503.335 ± 160.199M/s (drops 0.000 ± 0.000M/s)
>>>     no-private-stack-4096:  117262.975 ± 179.802M/s (drops 0.000 ± 0.000M/s)
>>>     private-stack-4096:  114643.523 ± 146.956M/s (drops 0.000 ± 0.000M/s)
>>>
>>> It is is clear that private-stack is worse than non-private stack up to close 5 percents.
>>> This can be roughly estimated based on the above jit code with no-private-stack vs. private-stack.
>>>
>>> Although the benchmark shows up to 5% potential slowdown with private stack.
>>> In reality, the kernel enables private stack only after stack size 64 which means
>>> the bpf prog will do some useful things. If bpf prog uses any helper/kfunc, the
>>> push/pop r9 overhead should be minimum compared to the overhead of helper/kfunc.
>>> if the prog does not use a lot of helper/kfunc, there is no push/pop r9 and
>>> the performance should be reasonable too.
>>>
>>> With 4096 loop ierations per program run, I got
>>>     $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=4096 no-private-stack
>>>     18.47%  bench                                              [k]
>>>     17.29%  bench    bpf_trampoline_6442522961                 [k] bpf_trampoline_6442522961
>>>     13.33%  bench    bpf_prog_bcf7977d3b93787c_func1           [k] bpf_prog_bcf7977d3b93787c_func1
>>>     11.86%  bench    [kernel.vmlinux]                          [k] migrate_enable
>>>     11.60%  bench    [kernel.vmlinux]                          [k] __bpf_prog_enter_recur
>>>     11.42%  bench    [kernel.vmlinux]                          [k] __bpf_prog_exit_recur
>>>      7.87%  bench    [kernel.vmlinux]                          [k] migrate_disable
>>>      3.71%  bench    [kernel.vmlinux]                          [k] bpf_get_numa_node_id
>>>      3.67%  bench    bpf_prog_d9703036495d54b0_trigger_driver  [k] bpf_prog_d9703036495d54b0_trigger_driver
>>>      0.04%  bench    bench                                     [.] btf_validate_type
>>>
>>>     $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=4096 private-stack
>>>       18.94%  bench                                              [k]
>>>       16.88%  bench    bpf_prog_bcf7977d3b93787c_func1           [k] bpf_prog_bcf7977d3b93787c_func1
>>>       15.77%  bench    bpf_trampoline_6442522961                 [k] bpf_trampoline_6442522961
>>>       11.70%  bench    [kernel.vmlinux]                          [k] __bpf_prog_enter_recur
>>>       11.48%  bench    [kernel.vmlinux]                          [k] migrate_enable
>>>       11.30%  bench    [kernel.vmlinux]                          [k] __bpf_prog_exit_recur
>>>        5.85%  bench    [kernel.vmlinux]                          [k] migrate_disable
>>>        3.69%  bench    bpf_prog_d9703036495d54b0_trigger_driver  [k] bpf_prog_d9703036495d54b0_trigger_driver
>>>        3.56%  bench    [kernel.vmlinux]                          [k] bpf_get_numa_node_id
>>>        0.06%  bench    bench                                     [.] bpf_prog_test_run_opts
>>>
>>> NOTE: I tried 6.4 perf and 6.10 perf, both of which have issues. I will investigate this further.
>> I tried with perf built with latest bpf-next and with no-private-stack, the issue still
>> exists. Will debug more.
>>
> Just as an aside, but if this doesn't work, I think you can have a
> better signal-to-noise ratio if you try enabling the private stack for
> XDP programs and just set up two machines, with a client sending
> traffic to another and run xdp-bench [0] on the server. I think you
> should observe measurable differences in throughput for
> nanosecond-scale changes, especially in programs like drop which do
> very little.
>
> [0]: https://github.com/xdp-project/xdp-tools

Currently private stack cannot be used for xdp prog since xdp prog is 
really performance critical and we won't want even slightest performance 
loss at this point. So private stack focused on tracing related programs 
as they are easily to have nested bpf progs if there are quite some 
tracing progs at the same time. If we ineed apply private stack to xdp 
programs, I expect some performance loss and how much loss is due to bpf 
prog itself (bpf prog codes and helpers/kfuncs, see below). The example 
in this patch shows overall performance degradation around 5%. But 
considering there around 50% non-bpf programs so overall bpf prog 
degradation might be around 10% comparing to non-private-stack bpf 
programs. But this is an extreme example. In reality, the stack size 
needs to be >= 64 bytes so the bpf programs must do some meaningful work 
which means bpf prog itself will do more work and it may also call some 
helpers/kfuncs. The helpers/kfuncs will introduce push/pop operations. 
But if helper/kfunc do some meaningful work, then the relative 
performance hit with additional push/pop should be small.


