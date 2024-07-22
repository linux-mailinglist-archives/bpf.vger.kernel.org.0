Return-Path: <bpf+bounces-35242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B9B9392AD
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47C41C2151B
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 16:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54FD16EBE4;
	Mon, 22 Jul 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gueXNHhD"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519916EB71
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666593; cv=none; b=JxkN6vU4t7ENBMzPhKdbJpIvVH8OPyOTuovjlmJxAG5hS1EbFtKoekSehK2gFfqSuUL5yA1uW9BIGM5PMvkZrhqcsGzyb18E4/XfW8UK9ERJsmwWG/x923kjLfQnJcW3e74ads7D+jgB2CrqvKmu2ALbv2nx0dt8IKQjve928jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666593; c=relaxed/simple;
	bh=lyXhLKXPe/KSQMjLrI3m4hH6Gbn/gikbORszc7633T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdM6gRM9t4m0otV9qaT8rrqQltfEREdBpLtiTImhY6cVRNGHXu9sxKdzEeIdoWczia13/Gwmur5r+eQBZ601qUZ2BmlRrhusK6QuNJwU4spaJ4YsxToBCDODiIC2NwdoSd4LIxvKTVSkKktD6kSNTVQGIzH9/VJxQzjZbF7l57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gueXNHhD; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: andrii.nakryiko@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721666588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82Ch8UPv3ZF915xu78U4Fur+9krC3N6cdVmrXlEOmJY=;
	b=gueXNHhDpMRRLh20tcmlifnuIixplJ0ejB+p0tHxKKYa4nY7n7bZ5o7XeJEIU7JfbrOVMM
	xdBiPcNOSPnjjuZn2IseqOt0N7JqIy2xuWoZvAAcZzVmvVDBpJVEaWz8cWd7hQCv5LFc50
	3vDaCDXuhjbpvG55vPN7ORpHlNQZ6KU=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <036e4320-1e22-4066-bfa5-42b1fa290a39@linux.dev>
Date: Mon, 22 Jul 2024 09:43:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/19/24 8:28 PM, Andrii Nakryiko wrote:
> On Thu, Jul 18, 2024 at 1:52 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> The main motivation for private stack comes from nested
>> scheduler in sched-ext from Tejun. The basic idea is that
>>   - each cgroup will its own associated bpf program,
>>   - bpf program with parent cgroup will call bpf programs
>>     in immediate child cgroups.
>>
>> Let us say we have the following cgroup hierarchy:
>>    root_cg (prog0):
>>      cg1 (prog1):
>>        cg11 (prog11):
>>          cg111 (prog111)
>>          cg112 (prog112)
>>        cg12 (prog12):
>>          cg121 (prog121)
>>          cg122 (prog122)
>>      cg2 (prog2):
>>        cg21 (prog21)
>>        cg22 (prog22)
>>        cg23 (prog23)
>>
>> In the above example, prog0 will call a kfunc which will
>> call prog1 and prog2 to get sched info for cg1 and cg2 and
>> then the information is summarized and sent back to prog0.
>> Similarly, prog11 and prog12 will be invoked in the kfunc
>> and the result will be summarized and sent back to prog1, etc.
>>
>> Currently, for each thread, the x86 kernel allocate 8KB stack.
>> The each bpf program (including its subprograms) has maximum
>> 512B stack size to avoid potential stack overflow.
>> And nested bpf programs increase the risk of stack overflow.
>> To avoid potential stack overflow caused by bpf programs,
>> this patch implemented a private stack so bpf program stack
>> space is allocated dynamically when the program is jited.
>> Such private stack is applied to tracing programs like
>> kprobe/uprobe, perf_event, tracepoint, raw tracepoint and
>> tracing.
>>
>> But more than one instance of the same bpf program may
>> run in the system. To make things simple, percpu private
>> stack is allocated for each program, so if the same program
>> is running on different cpus concurrently, we won't have
>> any issue. Note that the kernel already have logic to prevent
>> the recursion for the same bpf program on the same cpu
>> (kprobe, fentry, etc.).
>>
>> The patch implemented a percpu private stack based approach
>> for x86 arch.
>>    - The stack size will be 0 and any stack access is from
>>      jit-time allocated percpu storage.
>>    - In the beginning of jit, r9 is used to save percpu
>>      private stack pointer.
>>    - Each rbp in the bpf asm insn is replaced by r9.
>>    - For each call, push r9 before the call and pop r9
>>      after the call to preserve r9 value.
>>
>> Compared to previous RFC patch [1], this patch added
>> some conditions to enable private stack, e.g., verifier
>> calculated stack size, prog type, etc. The new patch
>> also added a performance test to compare private stack
>> vs. no private stack.
>>
>> The following are some code example to illustrate the idea
>> for selftest cgroup_skb_sk_lookup:
>>
>>     the existing code                        the private-stack approach code
>>     endbr64                                  endbr64
>>     nop    DWORD PTR [rax+rax*1+0x0]         nop    DWORD PTR [rax+rax*1+0x0]
>>     xchg   ax,ax                             xchg   ax,ax
>>     push   rbp                               push   rbp
>>     mov    rbp,rsp                           mov    rbp,rsp
>>     endbr64                                  endbr64
>>     sub    rsp,0x68
>>     push   rbx                               push   rbx
>>     ...                                      ...
>>     ...                                      mov    r9d,0x8c1c860
>>     ...                                      add    r9,QWORD PTR gs:0x21a00
>>     ...                                      ...
>>     mov    rdx,rbp                           mov    rdx, r9
>>     add    rdx,0xffffffffffffffb4            rdx,0xffffffffffffffb4
>>     ...                                      ...
>>     mov    ecx,0x28                          mov    ecx,0x28
>>                                              push   r9
>>     call   0xffffffffe305e474                call   0xffffffffe305e524
>>                                              pop    r9
>>     mov    rdi,rax                           mov    rdi,rax
>>     ...                                      ...
>>     movzx  rdi,BYTE PTR [rbp-0x46]           movzx  rdi,BYTE PTR [r9-0x46]
>>     ...                                      ...
>>
> Eduard nerd-sniped me today with this a bit... :)
>
> I have a few questions and suggestions.
>
> So it seems like each *subprogram* (not the entire BPF program) gets
> its own per-CPU private stack allocation. Is that intentional? That

Currently yes. The reason is the same prog could be run on different
cpus at the same time.

> seems a bit unnecessary. It also prevents any sort of actual
> recursion. Not sure if it's possible to write recursive BPF subprogram
> today, verifier seems to reject obvious limited recursion cases, but
> still, eventually we might need/want to support that, and this will be
> just another hurdle to overcome (so it's best to avoid adding it in
> the first place).
>
> I'm sure Eduard is going to try something like below and it will
> probably break badly (I haven't tried, sorry):
>
> int entry(void *ctx);
>
> struct {
>          __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>          __uint(max_entries, 1);
>          __uint(key_size, sizeof(__u32));
>          __array(values, int (void *));
> } prog_array_init SEC(".maps") = {
>          .values = {
>                  [0] = (void *)&entry,
>          },
> };
>
> static __noinline int subprog1(void)
> {
>      <some state on the stack>
>
>      /* here entry will replace subprog1, and so we'll have
>       * entry -> entry -> entry -> ..... <tail call limit> -> subprog1
>       */
>      bpf_tail_call(ctx, &prog_array_init, 0);
>
>      return 0;
> }
>
>
> SEC("raw_tp/sys_enter")
> int entry(void *ctx)
> {
>       <some state on the stack>
>
>       subprog1();
> }
>
> And we effectively have limited recursion where the entry's stack
> state is clobbered, no?
>
> So it seems like we need to support recursion.
>
>
> So, the question I have is. Why not do the following:
> a) only setup r9 *once* in entry program's prologue (before tail call
> jump target)
> b) before each call we can adjust r9 with current prog/subprog's
> maximum *own* stack, something like:
>
> push r9;
> r9 += 128; // 128 is subprog's stack usage
> call <some-subprog>
> pop r9;
>
> The idea being that on tail call or in subprog call we assume r9 is
> already pointing to the right place. We can probably also figure out
> how to avoid push/pop r9 if we make sure that subprogram always
> restores r9 (taking tail calls into account and all that, of course)?
>
> Is this feasible?

This is possible. I actually hacked such an idea easily. The basic
idea is push frame pointer as an additional argument to the bpf
static sub-prog. This is a little bit complicated. It will probably
save some stack size but I am not sure how much it is.

>
> Another question I have is whether it would be possible to just plain
> set rbp to private stack and keep using rbp in such a way that stack
> traces are preserved? I.e., save return address on private stack to
> unwinders can correctly jump back to kernel's stack?

I also tried this approach earlier. But it is very trickly we need to
modify rbp/rsp and additional jit code will be added
If interrupts happens, we will not be able to get reliable stack trace.

>
> How stupid is what I propose above?
>
>
>> So the number of insns is increased by 1 + num_of_calls * 2.
>> Here the number of calls are those calls in the final jited binary.
>> Comparing function call itself, the push/pop overhead should be
>> minimum in most common cases.
>>
>> Our original use case is for sched-ext nested scheduler. This will be done
>> in the future.
>>
>>    [1] https://lore.kernel.org/bpf/707970c5-6bba-450a-be08-adf24d8b9276@linux.dev/T/
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 63 ++++++++++++++++++++++++++++++++++---
>>   include/linux/bpf.h         |  2 ++
>>   kernel/bpf/core.c           | 20 ++++++++++++
>>   kernel/bpf/syscall.c        |  1 +
>>   4 files changed, 82 insertions(+), 4 deletions(-)
>>
> [...]

