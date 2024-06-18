Return-Path: <bpf+bounces-32410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFA490D714
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B33B1F24989
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 15:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F77487BC;
	Tue, 18 Jun 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MIqa03u4"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97236AFE
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724024; cv=none; b=fC28AEWbQZZwe6uXuIGnbbVuM8jptvT2yI4sp2CGBwgOoHTJjsY9wSRo7F4Zfv/hKv3TYbB5dJaNNGIm1OXosnCAHrMNfrk4AlKyhNFNwtioDBiccI1hsB2g3Bi3KmOso0BfmQFfrixs0Ic5vSTEMR1MO40gJUkXO75Tk6noD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724024; c=relaxed/simple;
	bh=d5Ry2q8GAmT/40XkyUle0F1u7Wgf64Odj4ff1HHYErE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cExdrFkr8XYakfiyWr7EGfTXGDwKB6TiV+Yzf16t4D6nyVK4F2jHGzHN2SX5yScUDWy7R/RIDLRB9usvqLCV3laNy4z64NogvJ2f9xF2X/UvvMf/z0Qg0qFu2akek62DDhOGUxUaWZ+GJu//BrRRfRiDmj5+JW4AvBn0Ky8xQTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MIqa03u4; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718724020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpaEnldaTJjxn6NPLdIuUgPNIJXOLWqTxT7oXZxpY7c=;
	b=MIqa03u4oYhIYowgMYe5KA/mPkb9+h2tbJxRA1uTb1C757bE/7L5IjO1UEj8BDxcqvNxpG
	ItLe0UM1n1Hkft/TivtJw5FpVclGkmtcG1ei4dNvLE/DeqrzCc4wrXI3wbxR0FG9IV07om
	pO68a5fhscv/HKZSxMh/4otIloJLFwA=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <07eacf6a-8f67-4c3e-88cb-c362a171b1a2@linux.dev>
Date: Tue, 18 Jun 2024 08:20:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next] bpf: Support shadow stack for bpf progs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240610051839.1296086-1-yonghong.song@linux.dev>
 <CAADnVQ+FwPAbeiiD78xnkRLZAiSDC4ObkKWV+x9bpSK9aM_GsA@mail.gmail.com>
 <707970c5-6bba-450a-be08-adf24d8b9276@linux.dev>
 <CAADnVQL3pLgJJGoQ=cWC7V5wcrMR00Qx-PUDWAA2Yu6igw71gg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL3pLgJJGoQ=cWC7V5wcrMR00Qx-PUDWAA2Yu6igw71gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/17/24 4:19 PM, Alexei Starovoitov wrote:
> On Sat, Jun 15, 2024 at 10:52 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 6/13/24 5:30 PM, Alexei Starovoitov wrote:
>>> On Sun, Jun 9, 2024 at 10:18 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> I think "shadow stack" already has at least two different meanings
>>> in the kernel.
>>> Let's avoid adding 3rd.
>>> How about "divided stack" ?
>> Naming is hard. Maybe "private stack" which suggests the stack is private
>> to that program?
> I like it. "private stack" fits the best.
>
>>>> +static void emit_percpu_shadow_frame_ptr(u8 **pprog, void *shadow_frame_ptr)
>>>> +{
>>>> +       u8 *prog = *pprog;
>>>> +
>>>> +       /* movabs r9, shadow_frame_ptr */
>>>> +       emit_mov_imm32(&prog, false, X86_REG_R9, (u32) (long) shadow_frame_ptr);
>>>> +
>>>> +       /* add <r9>, gs:[<off>] */
>>>> +       EMIT2(0x65, 0x4c);
>>>> +       EMIT3(0x03, 0x0c, 0x25);
>>>> +       EMIT((u32)(unsigned long)&this_cpu_off, 4);
>>> I think this can be one insn:
>>> lea r9, gs:[(u32)shadow_frame_ptr]
>> Apparently, __alloc_percpu_gfp() may return a pointer which is beyond 32bit. That is why my
>> RFC patch failed CI. I later tried to use
>>
>> +       /* movabs r9, shadow_frame_ptr */
>> +       emit_mov_imm64(&prog, X86_REG_R9, (long) shadow_frame_ptr >> 32,
>> +                      (u32) (long) shadow_frame_ptr);
>>
>> and CI is successful. I did some on-demand test (https://github.com/kernel-patches/bpf/pull/7179)
>> and it succeeded with CI.
>>
>> If __alloc_percpu_gfp() returns a pointer beyond 32bit, I am not sure
>> whether we could get r9 with a single insn.
> I see. Ok. Let's keep two insns sequence.
>
>>>> +       if (stack_depth && enable_shadow_stack) {
>>> I think enabling it for progs with small stack usage
>>> is unnecessary.
>>> The definition of "small" is complicated.
>>> I feel stack_depth <= 64 can stay as-is and
>>> all networking progs don't have to use it either,
>>> since they're called from known places.
>>> While tracing progs can be anywhere, so I'd enable
>>> divided stack for
>>> stack_depth > 64 && prog_type == kprobe, tp, raw_tp, tracing, perf_event.
>> This does make sense. It partially aligns what I think for prog type
>> side. We only need to enable 'divided stack' for certain prog types.
>>
>>>> +               if (bpf_prog->percpu_shadow_stack_ptr) {
>>>> +                       percpu_shadow_stack_ptr = bpf_prog->percpu_shadow_stack_ptr;
>>>> +               } else {
>>>> +                       percpu_shadow_stack_ptr = __alloc_percpu_gfp(stack_depth, 8, GFP_KERNEL);
>>>> +                       if (!percpu_shadow_stack_ptr)
>>>> +                               return -ENOMEM;
>>>> +                       bpf_prog->percpu_shadow_stack_ptr = percpu_shadow_stack_ptr;
>>>> +               }
>>>> +               shadow_frame_ptr = percpu_shadow_stack_ptr + round_up(stack_depth, 8);
>>>> +               stack_depth = 0;
>>>> +       } else {
>>>> +               enable_shadow_stack = 0;
>>>> +       }
>>>> +
>>>>           arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
>>>>           user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
>>>>
>>>> @@ -1342,7 +1377,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>>>           /* tail call's presence in current prog implies it is reachable */
>>>>           tail_call_reachable |= tail_call_seen;
>>>>
>>>> -       emit_prologue(&prog, bpf_prog->aux->stack_depth,
>>>> +       emit_prologue(&prog, stack_depth,
>>>>                         bpf_prog_was_classic(bpf_prog), tail_call_reachable,
>>>>                         bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
>>>>           /* Exception callback will clobber callee regs for its own use, and
>>>> @@ -1364,6 +1399,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>>>                   emit_mov_imm64(&prog, X86_REG_R12,
>>>>                                  arena_vm_start >> 32, (u32) arena_vm_start);
>>>>
>>>> +       if (enable_shadow_stack)
>>>> +               emit_percpu_shadow_frame_ptr(&prog, shadow_frame_ptr);
>>>> +
>>>>           ilen = prog - temp;
>>>>           if (rw_image)
>>>>                   memcpy(rw_image + proglen, temp, ilen);
>>>> @@ -1383,6 +1421,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>>>                   u8 *func;
>>>>                   int nops;
>>>>
>>>> +               if (enable_shadow_stack) {
>>>> +                       if (src_reg == BPF_REG_FP)
>>>> +                               src_reg = X86_REG_R9;
>>>> +
>>>> +                       if (dst_reg == BPF_REG_FP)
>>>> +                               dst_reg = X86_REG_R9;
>>> the verifier will reject a prog that attempts to write into R10.
>>> So the above shouldn't be necessary.
>> Actually there is at least one exception, e.g.,
>>     if r10 > r5 goto +5
>> where dst is r10 and src r5.
> Good point. We even have such a selftest to make sure it's rejected in unpriv.
>
> SEC("socket")
> __description("unpriv: cmp of frame pointer")
> __success __failure_unpriv __msg_unpriv("R10 pointer comparison")
> __retval(0)
> __naked void unpriv_cmp_of_frame_pointer(void)
> {
>          asm volatile ("                                 \
>          if r10 == 0 goto l0_%=;                         \
>
>>>> +               }
>>>> +
>>>>                   switch (insn->code) {
>>>>                           /* ALU */
>>>>                   case BPF_ALU | BPF_ADD | BPF_X:
>>>> @@ -2014,6 +2060,7 @@ st:                       if (is_imm8(insn->off))
>>>>                                   emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
>>>>                                   /* Restore R0 after clobbering RAX */
>>>>                                   emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
>>>> +
>>>>                                   break;
>>>>                           }
>>>>
>>>> @@ -2038,14 +2085,20 @@ st:                     if (is_imm8(insn->off))
>>>>
>>>>                           func = (u8 *) __bpf_call_base + imm32;
>>>>                           if (tail_call_reachable) {
>>>> -                               RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
>>>> +                               RESTORE_TAIL_CALL_CNT(stack_depth);
>>>>                                   ip += 7;
>>>>                           }
>>>>                           if (!imm32)
>>>>                                   return -EINVAL;
>>>> +                       if (enable_shadow_stack) {
>>>> +                               EMIT2(0x41, 0x51);
>>>> +                               ip += 2;
>>>> +                       }
>>>>                           ip += x86_call_depth_emit_accounting(&prog, func, ip);
>>>>                           if (emit_call(&prog, func, ip))
>>>>                                   return -EINVAL;
>>>> +                       if (enable_shadow_stack)
>>>> +                               EMIT2(0x41, 0x59);
>>> push/pop around calls are load/store plus math on %rsp.
>>> I think it's cheaper to reload r9 after the call with
>>> a single insn.
>>> The reload of r9 is effectively gs+const.
>>> There is no memory access. So it should be faster.
>> Two insn may be necessary since __alloc_percpu_gfp()
>> may return a pointer beyond 32 bits.
>>
>>> Technically we can replace all uses of R10==rbp with
>>> 'gs:' based instructions.
>>> Like:
>>> r1 = r10
>>> can be jitted into
>>> lea rdi, gs + (u32)shadow_frame_ptr
>>>
>>> and r0 = *(u32 *)(r10 - 64)
>>> can be jitted into:
>>> mov rax, dword ptr gs:[(u32)shadow_frame_ptr - 64]
>>>
>>> but that is probably a bunch of jit changes.
>>> So I'd start with a simple reload of r9 after each call.
>> This is a good idea. We might need this so we only have
>> one extra insn per call.
> Since reload of r9 is a two insn sequence of 64-bit mov immediate,
> and load from gs:this_cpu_off, I suspect, push/pop r9
> might be faster. So I'd stick to what you have already.
>
> Interesting though that static per-cpu vars have 32-bit pointers,
> but dynamic per-cpu alloc returns full 64-bit? hmm.

Not always. This RFC works in my local qemu run as dynamic per-cpu
allocation returns 32-bit. But CI failed since in CI 64-bit ptr val
is returned. Later on, with different code based, my local qemu
can also return 64-bit per-cpu ptr. In the next revision, I will
use 64-bit value to hold shadow_frame_ptr (to be named private_frame_ptr).


