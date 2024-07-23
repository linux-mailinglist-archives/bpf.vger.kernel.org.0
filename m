Return-Path: <bpf+bounces-35345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F252893992C
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 07:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7333E1F228A2
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 05:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD34B13A24A;
	Tue, 23 Jul 2024 05:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A5sy34Z+"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403D367
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 05:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721712621; cv=none; b=M3+GfiejkWz6YDH76rbkI1ch82oKtptUYaPsqPj6FbuHJdJQzqRHEuHhDjFcnDtOIo9cqv55kCEAsUYOrapYte3TETRlgG7eiM9HeNxEpgmdyGrA4aLP+9FX9lzE5R0+9nh71fGii+CmJTUHqr0m+vNp2bvVlsHugcPq5Xow+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721712621; c=relaxed/simple;
	bh=SgqVasERNOlIhP/o4CO6INSDTxmYHCkfGVA2dpnM/6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6XiJ62pSp2nXYEv/h3g0NmOlEq7lfjt93/gpjf4amnlvoqlQN2Jttdg0+70pxptAsnvxF1hH8Lx7DSMjBufW7C39EgBm8P3JCBTexQCITNH3WiRPZD1CzugjfQ463uIG8f80Sg3LzN940sDEaUZF+VpSxm/hH7wxlPatn42PHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A5sy34Z+; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721712616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xe9kMv1yx11RJ+Pbtwfb0oAQYsRqhW16N7iaQMY29K8=;
	b=A5sy34Z+60X2sy7LjyVnTaL4sOCc9+Xm8R7TtUbuI91TIK7VAr/+XFIe0JScMp2dqaWZ+C
	b9hL09yIQYrKdv7D4691jh5c96hqQQTAUp3ZGhDHdTBebUG1GU/ET7UCsJsnvhhxVA7L5b
	12TUTqUgSQScnnjPqmRYsshnIO465OE=
X-Envelope-To: andrii.nakryiko@gmail.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <7dce9923-2a18-4b41-8b40-420e1cfa82e8@linux.dev>
Date: Mon, 22 Jul 2024 22:30:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
 <CAEf4BzYktUDhfASrD0dhyBWUH4QkoRksX7JacYQ9bhC0H9gesw@mail.gmail.com>
 <CAADnVQJDE24HQD7KYRRu1Nsz9965op=62dhx7HqW2QZRzHGBKQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJDE24HQD7KYRRu1Nsz9965op=62dhx7HqW2QZRzHGBKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/22/24 6:05 PM, Alexei Starovoitov wrote:
> On Mon, Jul 22, 2024 at 1:58 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Fri, Jul 19, 2024 at 8:28 PM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>> On Thu, Jul 18, 2024 at 1:52 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> The main motivation for private stack comes from nested
>>>> scheduler in sched-ext from Tejun. The basic idea is that
>>>>   - each cgroup will its own associated bpf program,
>>>>   - bpf program with parent cgroup will call bpf programs
>>>>     in immediate child cgroups.
>>>>
>>>> Let us say we have the following cgroup hierarchy:
>>>>    root_cg (prog0):
>>>>      cg1 (prog1):
>>>>        cg11 (prog11):
>>>>          cg111 (prog111)
>>>>          cg112 (prog112)
>>>>        cg12 (prog12):
>>>>          cg121 (prog121)
>>>>          cg122 (prog122)
>>>>      cg2 (prog2):
>>>>        cg21 (prog21)
>>>>        cg22 (prog22)
>>>>        cg23 (prog23)
>>>>
>>>> In the above example, prog0 will call a kfunc which will
>>>> call prog1 and prog2 to get sched info for cg1 and cg2 and
>>>> then the information is summarized and sent back to prog0.
>>>> Similarly, prog11 and prog12 will be invoked in the kfunc
>>>> and the result will be summarized and sent back to prog1, etc.
>>>>
>>>> Currently, for each thread, the x86 kernel allocate 8KB stack.
>>>> The each bpf program (including its subprograms) has maximum
>>>> 512B stack size to avoid potential stack overflow.
>>>> And nested bpf programs increase the risk of stack overflow.
>>>> To avoid potential stack overflow caused by bpf programs,
>>>> this patch implemented a private stack so bpf program stack
>>>> space is allocated dynamically when the program is jited.
>>>> Such private stack is applied to tracing programs like
>>>> kprobe/uprobe, perf_event, tracepoint, raw tracepoint and
>>>> tracing.
>>>>
>>>> But more than one instance of the same bpf program may
>>>> run in the system. To make things simple, percpu private
>>>> stack is allocated for each program, so if the same program
>>>> is running on different cpus concurrently, we won't have
>>>> any issue. Note that the kernel already have logic to prevent
>>>> the recursion for the same bpf program on the same cpu
>>>> (kprobe, fentry, etc.).
>>>>
>>>> The patch implemented a percpu private stack based approach
>>>> for x86 arch.
>>>>    - The stack size will be 0 and any stack access is from
>>>>      jit-time allocated percpu storage.
>>>>    - In the beginning of jit, r9 is used to save percpu
>>>>      private stack pointer.
>>>>    - Each rbp in the bpf asm insn is replaced by r9.
>>>>    - For each call, push r9 before the call and pop r9
>>>>      after the call to preserve r9 value.
>>>>
>>>> Compared to previous RFC patch [1], this patch added
>>>> some conditions to enable private stack, e.g., verifier
>>>> calculated stack size, prog type, etc. The new patch
>>>> also added a performance test to compare private stack
>>>> vs. no private stack.
>>>>
>>>> The following are some code example to illustrate the idea
>>>> for selftest cgroup_skb_sk_lookup:
>>>>
>>>>     the existing code                        the private-stack approach code
>>>>     endbr64                                  endbr64
>>>>     nop    DWORD PTR [rax+rax*1+0x0]         nop    DWORD PTR [rax+rax*1+0x0]
>>>>     xchg   ax,ax                             xchg   ax,ax
>>>>     push   rbp                               push   rbp
>>>>     mov    rbp,rsp                           mov    rbp,rsp
>>>>     endbr64                                  endbr64
>>>>     sub    rsp,0x68
>>>>     push   rbx                               push   rbx
>>>>     ...                                      ...
>>>>     ...                                      mov    r9d,0x8c1c860
>>>>     ...                                      add    r9,QWORD PTR gs:0x21a00
>>>>     ...                                      ...
>>>>     mov    rdx,rbp                           mov    rdx, r9
>>>>     add    rdx,0xffffffffffffffb4            rdx,0xffffffffffffffb4
>>>>     ...                                      ...
>>>>     mov    ecx,0x28                          mov    ecx,0x28
>>>>                                              push   r9
>>>>     call   0xffffffffe305e474                call   0xffffffffe305e524
>>>>                                              pop    r9
>>>>     mov    rdi,rax                           mov    rdi,rax
>>>>     ...                                      ...
>>>>     movzx  rdi,BYTE PTR [rbp-0x46]           movzx  rdi,BYTE PTR [r9-0x46]
>>>>     ...                                      ...
>>>>
>>> Eduard nerd-sniped me today with this a bit... :)
>>>
>>> I have a few questions and suggestions.
>>>
>>> So it seems like each *subprogram* (not the entire BPF program) gets
>>> its own per-CPU private stack allocation. Is that intentional? That
>>> seems a bit unnecessary. It also prevents any sort of actual
>>> recursion. Not sure if it's possible to write recursive BPF subprogram
>>> today, verifier seems to reject obvious limited recursion cases, but
>>> still, eventually we might need/want to support that, and this will be
>>> just another hurdle to overcome (so it's best to avoid adding it in
>>> the first place).
>>>
>>> I'm sure Eduard is going to try something like below and it will
>>> probably break badly (I haven't tried, sorry):
>>>
>>> int entry(void *ctx);
>>>
>>> struct {
>>>          __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>>>          __uint(max_entries, 1);
>>>          __uint(key_size, sizeof(__u32));
>>>          __array(values, int (void *));
>>> } prog_array_init SEC(".maps") = {
>>>          .values = {
>>>                  [0] = (void *)&entry,
>>>          },
>>> };
>>>
>>> static __noinline int subprog1(void)
>>> {
>>>      <some state on the stack>
>>>
>>>      /* here entry will replace subprog1, and so we'll have
>>>       * entry -> entry -> entry -> ..... <tail call limit> -> subprog1
>>>       */
>>>      bpf_tail_call(ctx, &prog_array_init, 0);
>>>
>>>      return 0;
>>> }
>>>
>>>
>>> SEC("raw_tp/sys_enter")
>>> int entry(void *ctx)
>>> {
>>>       <some state on the stack>
>>>
>>>       subprog1();
>>> }
>>>
>>> And we effectively have limited recursion where the entry's stack
>>> state is clobbered, no?
>>>
>>> So it seems like we need to support recursion.
>>>
>> How come everyone just completely ignored the main point of my entire
>> email and a real problem that has to be solved?...
>>
>> Anyways, I did write a below program:
>>
>> $ cat minimal.bpf.c
>> // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> /* Copyright (c) 2020 Facebook */
>> #include <linux/bpf.h>
>> #include <bpf/bpf_helpers.h>
>>
>> char LICENSE[] SEC("license") = "Dual BSD/GPL";
>>
>> int my_pid = 0;
>>
>> int handle_tp(void *ctx);
>>
>> struct {
>>          __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>>          __uint(max_entries, 1);
>>          __uint(key_size, sizeof(__u32));
>>          __array(values, int (void *));
>> } prog_array_init SEC(".maps") = {
>>          .values = {
>>                  [0] = (void *)&handle_tp,
>>          },
>> };
>>
>> static __noinline int subprog(void *ctx)
>> {
>>          static int cnt;
>>
>>          cnt++;
>>
>>          bpf_printk("SUBPROG - BEFORE %d", cnt);
>>
>>          bpf_tail_call(ctx, &prog_array_init, 0);
>>
>>          bpf_printk("SUBPROG - AFTER %d", cnt);
>>
>>      return 0;
>> }
>>
>> SEC("tp/syscalls/sys_enter_write")
>> int handle_tp(void *ctx)
>> {
>>          static int cnt;
>>          int pid = bpf_get_current_pid_tgid() >> 32;
>>
>>          if (pid != my_pid)
>>                  return 0;
>>
>>          cnt++;
>>
>>          bpf_printk("ENTRY - BEFORE %d", cnt);
>>
>>          subprog(ctx);
>>
>>          bpf_printk("ENTRY - AFTER %d", cnt);
>>
>>          return 0;
>> }
>>
>>
>> And triggered one write syscall, getting the log above. You can see
>> that only subprogs are replaced (we only get "SUBPROG - AFTER 34" due
>> to the tail call limit). And we do indeed get lots of entry program
>> recurrence.
>>
>> We *need to support recursion* is my main point.
> Not quite.
> It's not a recursion. The stack collapsed/gone/wiped out before tail_call.
> static int cnt counts stuff because it's static.
>
> So we don't need to support recursion with private stack,
> but tail_calls and private stack are buggy indeed.
>
> emit_bpf_tail_call*() shouldn't be adjusting 'rsp' when the private
> stack is used.

Right, stack_depth argument in emit_bpf_tail_call_direct()/emit_bpf_tail_call_indirect()
should be 0 if private stack is used. Will fix in next revision.


