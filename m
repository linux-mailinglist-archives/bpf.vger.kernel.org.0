Return-Path: <bpf+bounces-35026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD95937030
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 23:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824321F22751
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84593145355;
	Thu, 18 Jul 2024 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VjrmjgXZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B275808
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339093; cv=none; b=V80s+C2w5W3E1U/sRXD58oNxUacV87NuquoaTpT1RTFsKbYkvC+z1oKpxGX6eQZsWDRrkwtyaeCgGDZ9q+NFJ0VxC0Tl81VTnYgWLdwWGCvuUdxqwbqJyWCUv9VgGWbYvhxsxJYy0wDhr+zKl2Zo56KOw4gi1J0a6FZuxGAwCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339093; c=relaxed/simple;
	bh=nXz+Py2MHYnlFenHpSpHtzkVVu/15qvYqSOtaHpHd/A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SOfU0vferdN3cIUBz+z0qrbg86Y4MLqbyHGCfe2t0Y3BVQHIF6rd+FXxGaHyu/Jo5B+5hfXI0x6x+2E9SPB5eMnwNPJwmOn4b2Pp539P4OjzenJ8+YeN9uJybf/kD32p0FpH2FXfXi0dVMLWxRAdB/mYD3+X/S1354LtzJFaneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VjrmjgXZ; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721339089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyLMKc0NicWMR+oKr2bwJtqPusoXSr/G2Av8rSLMjbw=;
	b=VjrmjgXZT+gROdGLvNVVCZ14lY8eVJv2/mz9kbPI5uM2oTuo8vhfn+APScsbpoHNYmk2zz
	aQxKnKlTNk9nPCRdDeNX+vDKD0NcPcDT2cnWlD3VFDBsljDJmIwBZsPHg87PuGtgp1S4TY
	EmRjq6YaNbzOWwNd8xm1lGO7htl+MCY=
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <1297da19-18a7-4727-8dab-e45ef0651e14@linux.dev>
Date: Thu, 18 Jul 2024 14:44:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <20240718205203.3652080-1-yonghong.song@linux.dev>
Content-Language: en-GB
In-Reply-To: <20240718205203.3652080-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/18/24 1:52 PM, Yonghong Song wrote:
> This patch intends to show some benchmark results comparing a bpf
> program with vs. without private stack. The patch is not intended
> to land since it hacks existing kernel interface in order to
> do proper comparison. The bpf program is similar to
> 7df4e597ea2c ("selftests/bpf: add batched, mostly in-kernel BPF triggering benchmarks")
> where a raw_tp program is triggered with bpf_prog_test_run_opts() and
> the raw_tp program has a loop of helper bpf_get_numa_node_id() which
> will enable a fentry prog to run. The fentry prog calls three
> do-nothing functions to maximumly expose the cost of private stack.
>
> The following is the jited code for bpf prog in progs/private_stack.c
> without private stack. The number of batch iterations is 4096.
>
> subprog:
> 0:  f3 0f 1e fa             endbr64
> 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
> 9:  66 90                   xchg   ax,ax
> b:  55                      push   rbp
> c:  48 89 e5                mov    rbp,rsp
> f:  f3 0f 1e fa             endbr64
> 13: 31 c0                   xor    eax,eax
> 15: c9                      leave
> 16: c3                      ret
>
> main prog:
> 0:  f3 0f 1e fa             endbr64
> 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
> 9:  66 90                   xchg   ax,ax
> b:  55                      push   rbp
> c:  48 89 e5                mov    rbp,rsp
> f:  f3 0f 1e fa             endbr64
> 13: 48 bf 00 e0 57 00 00    movabs rdi,0xffffc9000057e000
> 1a: c9 ff ff
> 1d: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> 21: 48 83 c6 01             add    rsi,0x1
> 25: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
> 29: e8 6e 00 00 00          call   0x9c
> 2e: e8 69 00 00 00          call   0x9c
> 33: e8 64 00 00 00          call   0x9c
> 38: 31 c0                   xor    eax,eax
> 3a: c9                      leave
> 3b: c3                      ret
>
> The following are the jited progs with private stack:
>
> subprog:
> 0:  f3 0f 1e fa             endbr64
> 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
> 9:  66 90                   xchg   ax,ax
> b:  55                      push   rbp
> c:  48 89 e5                mov    rbp,rsp
> f:  f3 0f 1e fa             endbr64
> 13: 49 b9 70 a6 c1 08 7e    movabs r9,0x607e08c1a670
> 1a: 60 00 00
> 1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
> 24: 02 00
> 26: 31 c0                   xor    eax,eax
> 28: c9                      leave
> 29: c3                      ret
>
> main prog:
> 0:  f3 0f 1e fa             endbr64
> 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
> 9:  66 90                   xchg   ax,ax
> b:  55                      push   rbp
> c:  48 89 e5                mov    rbp,rsp
> f:  f3 0f 1e fa             endbr64
> 13: 49 b9 88 a6 c1 08 7e    movabs r9,0x607e08c1a688
> 1a: 60 00 00
> 1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
> 24: 02 00
> 26: 48 bf 00 d0 5b 00 00    movabs rdi,0xffffc900005bd000
> 2d: c9 ff ff
> 30: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> 34: 48 83 c6 01             add    rsi,0x1
> 38: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
> 3c: 41 51                   push   r9
> 3e: e8 46 23 51 e1          call   0xffffffffe1512389
> 43: 41 59                   pop    r9
> 45: 41 51                   push   r9
> 47: e8 3d 23 51 e1          call   0xffffffffe1512389
> 4c: 41 59                   pop    r9
> 4e: 41 51                   push   r9
> 50: e8 34 23 51 e1          call   0xffffffffe1512389
> 55: 41 59                   pop    r9
> 57: 31 c0                   xor    eax,eax
> 59: c9                      leave
> 5a: c3                      ret
>
>  From the above, it is clear for subprog and main prog,
> we have some r9 related overhead including retriving the stack
> in the jit prelog code:
>    movabs r9,0x607e08c1a688
>    add    r9,QWORD PTR gs:0x21a00
> and 'push r9' and 'pop r9' around subprog calls.
>
> I did some benchmarking on an intel box (Intel(R) Xeon(R) D-2191A CPU @ 1.60GHz)
> which has 20 cores and 80 cpus. The number of hits are in the unit
> of loop iterations.
>
> The following are two benchmark results and a few other tries show
> similar results in terms of variation.
>    $ ./benchs/run_bench_private_stack.sh
>    no-private-stack-1:  2.152 ± 0.004M/s (drops 0.000 ± 0.000M/s)
>    private-stack-1:     2.226 ± 0.003M/s (drops 0.000 ± 0.000M/s)
>    no-private-stack-8:  89.086 ± 0.674M/s (drops 0.000 ± 0.000M/s)
>    private-stack-8:     90.023 ± 0.117M/s (drops 0.000 ± 0.000M/s)
>    no-private-stack-64:  1545.383 ± 3.574M/s (drops 0.000 ± 0.000M/s)
>    private-stack-64:    1534.630 ± 2.063M/s (drops 0.000 ± 0.000M/s)
>    no-private-stack-512:  14591.591 ± 15.202M/s (drops 0.000 ± 0.000M/s)
>    private-stack-512:   14323.796 ± 13.165M/s (drops 0.000 ± 0.000M/s)
>    no-private-stack-2048:  58680.977 ± 46.116M/s (drops 0.000 ± 0.000M/s)
>    private-stack-2048:  58614.699 ± 22.031M/s (drops 0.000 ± 0.000M/s)
>    no-private-stack-4096:  119974.497 ± 90.985M/s (drops 0.000 ± 0.000M/s)
>    private-stack-4096:  114841.949 ± 59.514M/s (drops 0.000 ± 0.000M/s)
>    $ ./benchs/run_bench_private_stack.sh
>    no-private-stack-1:  2.246 ± 0.002M/s (drops 0.000 ± 0.000M/s)
>    private-stack-1:     2.232 ± 0.005M/s (drops 0.000 ± 0.000M/s)
>    no-private-stack-8:  91.446 ± 0.055M/s (drops 0.000 ± 0.000M/s)
>    private-stack-8:     90.120 ± 0.069M/s (drops 0.000 ± 0.000M/s)
>    no-private-stack-64:  1578.374 ± 1.508M/s (drops 0.000 ± 0.000M/s)
>    private-stack-64:    1514.909 ± 3.898M/s (drops 0.000 ± 0.000M/s)
>    no-private-stack-512:  14767.811 ± 22.399M/s (drops 0.000 ± 0.000M/s)
>    private-stack-512:   14232.382 ± 227.217M/s (drops 0.000 ± 0.000M/s)
>    no-private-stack-2048:  58342.372 ± 81.519M/s (drops 0.000 ± 0.000M/s)
>    private-stack-2048:  54503.335 ± 160.199M/s (drops 0.000 ± 0.000M/s)
>    no-private-stack-4096:  117262.975 ± 179.802M/s (drops 0.000 ± 0.000M/s)
>    private-stack-4096:  114643.523 ± 146.956M/s (drops 0.000 ± 0.000M/s)
>
> It is is clear that private-stack is worse than non-private stack up to close 5 percents.
> This can be roughly estimated based on the above jit code with no-private-stack vs. private-stack.
>
> Although the benchmark shows up to 5% potential slowdown with private stack.
> In reality, the kernel enables private stack only after stack size 64 which means
> the bpf prog will do some useful things. If bpf prog uses any helper/kfunc, the
> push/pop r9 overhead should be minimum compared to the overhead of helper/kfunc.
> if the prog does not use a lot of helper/kfunc, there is no push/pop r9 and
> the performance should be reasonable too.
>
> With 4096 loop ierations per program run, I got
>    $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=4096 no-private-stack
>    18.47%  bench                                              [k]
>    17.29%  bench    bpf_trampoline_6442522961                 [k] bpf_trampoline_6442522961
>    13.33%  bench    bpf_prog_bcf7977d3b93787c_func1           [k] bpf_prog_bcf7977d3b93787c_func1
>    11.86%  bench    [kernel.vmlinux]                          [k] migrate_enable
>    11.60%  bench    [kernel.vmlinux]                          [k] __bpf_prog_enter_recur
>    11.42%  bench    [kernel.vmlinux]                          [k] __bpf_prog_exit_recur
>     7.87%  bench    [kernel.vmlinux]                          [k] migrate_disable
>     3.71%  bench    [kernel.vmlinux]                          [k] bpf_get_numa_node_id
>     3.67%  bench    bpf_prog_d9703036495d54b0_trigger_driver  [k] bpf_prog_d9703036495d54b0_trigger_driver
>     0.04%  bench    bench                                     [.] btf_validate_type
>
>    $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=4096 private-stack
>      18.94%  bench                                              [k]
>      16.88%  bench    bpf_prog_bcf7977d3b93787c_func1           [k] bpf_prog_bcf7977d3b93787c_func1
>      15.77%  bench    bpf_trampoline_6442522961                 [k] bpf_trampoline_6442522961
>      11.70%  bench    [kernel.vmlinux]                          [k] __bpf_prog_enter_recur
>      11.48%  bench    [kernel.vmlinux]                          [k] migrate_enable
>      11.30%  bench    [kernel.vmlinux]                          [k] __bpf_prog_exit_recur
>       5.85%  bench    [kernel.vmlinux]                          [k] migrate_disable
>       3.69%  bench    bpf_prog_d9703036495d54b0_trigger_driver  [k] bpf_prog_d9703036495d54b0_trigger_driver
>       3.56%  bench    [kernel.vmlinux]                          [k] bpf_get_numa_node_id
>       0.06%  bench    bench                                     [.] bpf_prog_test_run_opts
>
> NOTE: I tried 6.4 perf and 6.10 perf, both of which have issues. I will investigate this further.

I tried with perf built with latest bpf-next and with no-private-stack, the issue still
exists. Will debug more.

>
> I suspect top 18.47%/18.94% perf run probably due to fentry prog bench_trigger_fentry_batch,
> considering even subprog func1 takes 13.33%/16.88% time.
> Overall bpf prog include trampoline takes more than 50% of the time.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   arch/x86/net/bpf_jit_comp.c                   |   5 +-
>   include/linux/bpf.h                           |   3 +-
>   include/uapi/linux/bpf.h                      |   3 +
>   kernel/bpf/core.c                             |   3 +-
>   kernel/bpf/syscall.c                          |   4 +-
>   kernel/bpf/verifier.c                         |   1 +
>   tools/include/uapi/linux/bpf.h                |   3 +
>   tools/testing/selftests/bpf/Makefile          |   2 +
>   tools/testing/selftests/bpf/bench.c           |   6 +
>   .../bpf/benchs/bench_private_stack.c          | 149 ++++++++++++++++++
>   .../bpf/benchs/run_bench_private_stack.sh     |  11 ++
>   .../selftests/bpf/progs/private_stack.c       |  37 +++++
>   12 files changed, 222 insertions(+), 5 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/benchs/bench_private_stack.c
>   create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_private_stack.sh
>   create mode 100644 tools/testing/selftests/bpf/progs/private_stack.c
[...]

