Return-Path: <bpf+bounces-35474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C3D93AC2C
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 07:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636F11C22CBC
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 05:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124AB446AF;
	Wed, 24 Jul 2024 05:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hybjE/Fj"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CADC2572
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 05:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721797744; cv=none; b=ocRINXNWHX8csVjX1ZY9+9NaGZ49zeb99Of+T2WQUH13Tmqh/GJCaAEaL1u6gYThyHCgnC6Mf8Fh4aV13klk3porxJwQ1dosIUjV9SCuofdSRd1TSvVPKXHPzUB+glbHK6FoNRlEQzNgOpLJfnjqJzNkrZNpKi3h5w98ci7sABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721797744; c=relaxed/simple;
	bh=ly5c7loEnxQmYw/p1FC0dAcXFx4G5xI2rSV5AN2/a08=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=phmCmAAeoyxOuYfneg4xt2/sfWXrVumUMeAcXS4E42bk2hzJeokRRXwr4L0HeYYCYUhEE5h6VP+0n+fCwVfNqR4fSlSitleSUsoO+0d/qfQDuA6bOAo6SjBIj9KmeKxqQZUkXoWlxeA3hIYKRcldTDis50LXzEgtpGm5Z93ji3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hybjE/Fj; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f12db0b4-bcd4-4fb3-a0cf-35c96c2b549c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721797740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/wNpT78kMp+PpU/gU1bLRG2jstkFHRB4fgftvtHik4=;
	b=hybjE/FjHLnCtyYmzn47XWwZnu5fHgAax3GIhM+Vp2iribbhew+xdig1BDhLaWLcJJoUNy
	28ivyKMiOvnCQjSVIa3DH1DJ2ExfXQWy3V5LLIKbmS2s6RpxMmdbMPgGv4VFcxa0wex+UJ
	FWD9PJ1HijeSxqZSbOLOUVspUIty+Vo=
Date: Tue, 23 Jul 2024 22:08:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
 <036e4320-1e22-4066-bfa5-42b1fa290a39@linux.dev>
In-Reply-To: <036e4320-1e22-4066-bfa5-42b1fa290a39@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/22/24 9:43 AM, Yonghong Song wrote:
>
> On 7/19/24 8:28 PM, Andrii Nakryiko wrote:
>> On Thu, Jul 18, 2024 at 1:52 PM Yonghong Song 
>> <yonghong.song@linux.dev> wrote:
>>> The main motivation for private stack comes from nested
>>> scheduler in sched-ext from Tejun. The basic idea is that
>>>   - each cgroup will its own associated bpf program,
>>>   - bpf program with parent cgroup will call bpf programs
>>>     in immediate child cgroups.
>>>
>>> Let us say we have the following cgroup hierarchy:
>>>    root_cg (prog0):
>>>      cg1 (prog1):
>>>        cg11 (prog11):
>>>          cg111 (prog111)
>>>          cg112 (prog112)
>>>        cg12 (prog12):
>>>          cg121 (prog121)
>>>          cg122 (prog122)
>>>      cg2 (prog2):
>>>        cg21 (prog21)
>>>        cg22 (prog22)
>>>        cg23 (prog23)
>>>
>>> In the above example, prog0 will call a kfunc which will
>>> call prog1 and prog2 to get sched info for cg1 and cg2 and
>>> then the information is summarized and sent back to prog0.
>>> Similarly, prog11 and prog12 will be invoked in the kfunc
>>> and the result will be summarized and sent back to prog1, etc.
>>>
>>> Currently, for each thread, the x86 kernel allocate 8KB stack.
>>> The each bpf program (including its subprograms) has maximum
>>> 512B stack size to avoid potential stack overflow.
>>> And nested bpf programs increase the risk of stack overflow.
>>> To avoid potential stack overflow caused by bpf programs,
>>> this patch implemented a private stack so bpf program stack
>>> space is allocated dynamically when the program is jited.
>>> Such private stack is applied to tracing programs like
>>> kprobe/uprobe, perf_event, tracepoint, raw tracepoint and
>>> tracing.
>>>
>>> But more than one instance of the same bpf program may
>>> run in the system. To make things simple, percpu private
>>> stack is allocated for each program, so if the same program
>>> is running on different cpus concurrently, we won't have
>>> any issue. Note that the kernel already have logic to prevent
>>> the recursion for the same bpf program on the same cpu
>>> (kprobe, fentry, etc.).
>>>
>>> The patch implemented a percpu private stack based approach
>>> for x86 arch.
>>>    - The stack size will be 0 and any stack access is from
>>>      jit-time allocated percpu storage.
>>>    - In the beginning of jit, r9 is used to save percpu
>>>      private stack pointer.
>>>    - Each rbp in the bpf asm insn is replaced by r9.
>>>    - For each call, push r9 before the call and pop r9
>>>      after the call to preserve r9 value.
>>>
>>> Compared to previous RFC patch [1], this patch added
>>> some conditions to enable private stack, e.g., verifier
>>> calculated stack size, prog type, etc. The new patch
>>> also added a performance test to compare private stack
>>> vs. no private stack.
>>>
>>> The following are some code example to illustrate the idea
>>> for selftest cgroup_skb_sk_lookup:
>>>
>>>     the existing code                        the private-stack 
>>> approach code
>>>     endbr64                                  endbr64
>>>     nop    DWORD PTR [rax+rax*1+0x0]         nop    DWORD PTR 
>>> [rax+rax*1+0x0]
>>>     xchg   ax,ax                             xchg   ax,ax
>>>     push   rbp                               push   rbp
>>>     mov    rbp,rsp                           mov    rbp,rsp
>>>     endbr64                                  endbr64
>>>     sub    rsp,0x68
>>>     push   rbx                               push   rbx
>>>     ...                                      ...
>>>     ...                                      mov r9d,0x8c1c860
>>>     ...                                      add    r9,QWORD PTR 
>>> gs:0x21a00
>>>     ...                                      ...
>>>     mov    rdx,rbp                           mov    rdx, r9
>>>     add    rdx,0xffffffffffffffb4 rdx,0xffffffffffffffb4
>>>     ...                                      ...
>>>     mov    ecx,0x28                          mov    ecx,0x28
>>>                                              push   r9
>>>     call   0xffffffffe305e474                call 0xffffffffe305e524
>>>                                              pop    r9
>>>     mov    rdi,rax                           mov    rdi,rax
>>>     ...                                      ...
>>>     movzx  rdi,BYTE PTR [rbp-0x46]           movzx  rdi,BYTE PTR 
>>> [r9-0x46]
>>>     ...                                      ...
>>>
>> Eduard nerd-sniped me today with this a bit... :)
>>
>> I have a few questions and suggestions.
>>
>> So it seems like each *subprogram* (not the entire BPF program) gets
>> its own per-CPU private stack allocation. Is that intentional? That
>
> Currently yes. The reason is the same prog could be run on different
> cpus at the same time.
>
>> seems a bit unnecessary. It also prevents any sort of actual
>> recursion. Not sure if it's possible to write recursive BPF subprogram
>> today, verifier seems to reject obvious limited recursion cases, but
>> still, eventually we might need/want to support that, and this will be
>> just another hurdle to overcome (so it's best to avoid adding it in
>> the first place).
>>
>> I'm sure Eduard is going to try something like below and it will
>> probably break badly (I haven't tried, sorry):
>>
>> int entry(void *ctx);
>>
>> struct {
>>          __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>>          __uint(max_entries, 1);
>>          __uint(key_size, sizeof(__u32));
>>          __array(values, int (void *));
>> } prog_array_init SEC(".maps") = {
>>          .values = {
>>                  [0] = (void *)&entry,
>>          },
>> };
>>
>> static __noinline int subprog1(void)
>> {
>>      <some state on the stack>
>>
>>      /* here entry will replace subprog1, and so we'll have
>>       * entry -> entry -> entry -> ..... <tail call limit> -> subprog1
>>       */
>>      bpf_tail_call(ctx, &prog_array_init, 0);
>>
>>      return 0;
>> }
>>
>>
>> SEC("raw_tp/sys_enter")
>> int entry(void *ctx)
>> {
>>       <some state on the stack>
>>
>>       subprog1();
>> }
>>
>> And we effectively have limited recursion where the entry's stack
>> state is clobbered, no?
>>
>> So it seems like we need to support recursion.
>>
>>
>> So, the question I have is. Why not do the following:
>> a) only setup r9 *once* in entry program's prologue (before tail call
>> jump target)
>> b) before each call we can adjust r9 with current prog/subprog's
>> maximum *own* stack, something like:
>>
>> push r9;
>> r9 += 128; // 128 is subprog's stack usage
>> call <some-subprog>
>> pop r9;
>>
>> The idea being that on tail call or in subprog call we assume r9 is
>> already pointing to the right place. We can probably also figure out
>> how to avoid push/pop r9 if we make sure that subprogram always
>> restores r9 (taking tail calls into account and all that, of course)?
>>
>> Is this feasible?
>
> This is possible. I actually hacked such an idea easily. The basic
> idea is push frame pointer as an additional argument to the bpf
> static sub-prog. This is a little bit complicated. It will probably
> save some stack size but I am not sure how much it is.

Discussed with Andrii. I think the following approach should work.
For each non-static prog, the private stack is allocated including
that non-static prog and the called static progs. For example,
     main_prog
        static_prog_1
          static_prog_11
          global_prog
             static_prog_12
        static_prog_2

So in verifier we calculate stack size for
     main_prog
        static_prog_1
           static_prog_11
        static_prog_2
  and
     global_prog
       static_prog_12

Let us say the stack size for main_prog like below for each (sub)prog
     main_prog // stack size 100
        static_prog_1 // stack size 100
          static_prog_11 // stack size 100
        static_prog_2 // static size 100
so total static size is 300 so the private stack size will be 300.
So R9 is calculated like below
     main_prog
       R9 = ... // for tailcall reachable, R9 may be original R9 + offset
                // for non-tailcall reachable, R9 equals the original R9 (based on jit-time allocation).
       ...  R9 ...
       R9 += 100
       static_prog_1
          ... R9 ...
          R9 += 100
          static_prog_11
            ... R9 ...
          R9 -= 100
       R9 -= 100
       ... R9 ...
       R9 += 100
       static_prog_2
          ... R9 ...
       R9 -= 100

Similary, we can calculate R9 offset for
     global_prog
       static_prog_12
as well.


