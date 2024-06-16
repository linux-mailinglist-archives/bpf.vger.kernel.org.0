Return-Path: <bpf+bounces-32240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1856C909BB2
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 07:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4381F21FE3
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 05:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC79D16D4DF;
	Sun, 16 Jun 2024 05:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dGLPK+oG"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF79E16D320
	for <bpf@vger.kernel.org>; Sun, 16 Jun 2024 05:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718517148; cv=none; b=OfnnzoppH1Lds/wkog5HdzGsme8WdAiV+dx0TGxUdBloYNhAX0ok3QmYtN32PJL4czCA7FAhtCscqtON983fbJwDaicw+xTl2mZBsU6CEfl03DOp8uX0xyj97pOkZo2r3FyrYVLo3zOnhWhAPcOfmblUnY2u3dOfn761cJhll18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718517148; c=relaxed/simple;
	bh=nvm1E3lM/qUg+5jZ9k2vL6bEX1chVe9vS6BUXixGauw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXxerCJg+uXUMgDbc9WUxKM1ccyF++hax2EHYZ6jNubUNNrSd0fkvZfybV+5dBDTsOUf+t5uMdlcoo14x7ohnaGwR7QS/pcrgY0mLfcH3aheuy7GaleM1AskFxXN0icGmeh/Vr5punNlrstPjpdVluwNtIF5hXBDYiqKvOZj6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dGLPK+oG; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718517143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDogVRAm8gWbhwUlmrZXDrc9QRSv7pvpe8sqeqUtcQs=;
	b=dGLPK+oGnaeMlZyj+gFiJL+GN1j6VepywQajA9HUjPib9y5ZV+Rmsn/SD/Wg3kHy1lZn8V
	QTy29MXvzEiZy4x2/QIJHzIro/hHKcTtjsmP8LTQHVziAnoQwFbdY0WzAzwYWoV92jlgUH
	chxRSTHVXdx6dNaRjpRETGjGQ3Dc7iw=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <707970c5-6bba-450a-be08-adf24d8b9276@linux.dev>
Date: Sat, 15 Jun 2024 22:52:15 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+FwPAbeiiD78xnkRLZAiSDC4ObkKWV+x9bpSK9aM_GsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/13/24 5:30 PM, Alexei Starovoitov wrote:
> On Sun, Jun 9, 2024 at 10:18 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> I think "shadow stack" already has at least two different meanings
> in the kernel.
> Let's avoid adding 3rd.
> How about "divided stack" ?

Naming is hard. Maybe "private stack" which suggests the stack is private
to that program?

>
>> +static void emit_percpu_shadow_frame_ptr(u8 **pprog, void *shadow_frame_ptr)
>> +{
>> +       u8 *prog = *pprog;
>> +
>> +       /* movabs r9, shadow_frame_ptr */
>> +       emit_mov_imm32(&prog, false, X86_REG_R9, (u32) (long) shadow_frame_ptr);
>> +
>> +       /* add <r9>, gs:[<off>] */
>> +       EMIT2(0x65, 0x4c);
>> +       EMIT3(0x03, 0x0c, 0x25);
>> +       EMIT((u32)(unsigned long)&this_cpu_off, 4);
> I think this can be one insn:
> lea r9, gs:[(u32)shadow_frame_ptr]

Apparently, __alloc_percpu_gfp() may return a pointer which is beyond 32bit. That is why my
RFC patch failed CI. I later tried to use

+       /* movabs r9, shadow_frame_ptr */
+       emit_mov_imm64(&prog, X86_REG_R9, (long) shadow_frame_ptr >> 32,
+                      (u32) (long) shadow_frame_ptr);

and CI is successful. I did some on-demand test (https://github.com/kernel-patches/bpf/pull/7179)
and it succeeded with CI.

If __alloc_percpu_gfp() returns a pointer beyond 32bit, I am not sure
whether we could get r9 with a single insn.

>
>> +       if (stack_depth && enable_shadow_stack) {
> I think enabling it for progs with small stack usage
> is unnecessary.
> The definition of "small" is complicated.
> I feel stack_depth <= 64 can stay as-is and
> all networking progs don't have to use it either,
> since they're called from known places.
> While tracing progs can be anywhere, so I'd enable
> divided stack for
> stack_depth > 64 && prog_type == kprobe, tp, raw_tp, tracing, perf_event.

This does make sense. It partially aligns what I think for prog type
side. We only need to enable 'divided stack' for certain prog types.

>
>> +               if (bpf_prog->percpu_shadow_stack_ptr) {
>> +                       percpu_shadow_stack_ptr = bpf_prog->percpu_shadow_stack_ptr;
>> +               } else {
>> +                       percpu_shadow_stack_ptr = __alloc_percpu_gfp(stack_depth, 8, GFP_KERNEL);
>> +                       if (!percpu_shadow_stack_ptr)
>> +                               return -ENOMEM;
>> +                       bpf_prog->percpu_shadow_stack_ptr = percpu_shadow_stack_ptr;
>> +               }
>> +               shadow_frame_ptr = percpu_shadow_stack_ptr + round_up(stack_depth, 8);
>> +               stack_depth = 0;
>> +       } else {
>> +               enable_shadow_stack = 0;
>> +       }
>> +
>>          arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
>>          user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
>>
>> @@ -1342,7 +1377,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>          /* tail call's presence in current prog implies it is reachable */
>>          tail_call_reachable |= tail_call_seen;
>>
>> -       emit_prologue(&prog, bpf_prog->aux->stack_depth,
>> +       emit_prologue(&prog, stack_depth,
>>                        bpf_prog_was_classic(bpf_prog), tail_call_reachable,
>>                        bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
>>          /* Exception callback will clobber callee regs for its own use, and
>> @@ -1364,6 +1399,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>                  emit_mov_imm64(&prog, X86_REG_R12,
>>                                 arena_vm_start >> 32, (u32) arena_vm_start);
>>
>> +       if (enable_shadow_stack)
>> +               emit_percpu_shadow_frame_ptr(&prog, shadow_frame_ptr);
>> +
>>          ilen = prog - temp;
>>          if (rw_image)
>>                  memcpy(rw_image + proglen, temp, ilen);
>> @@ -1383,6 +1421,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>                  u8 *func;
>>                  int nops;
>>
>> +               if (enable_shadow_stack) {
>> +                       if (src_reg == BPF_REG_FP)
>> +                               src_reg = X86_REG_R9;
>> +
>> +                       if (dst_reg == BPF_REG_FP)
>> +                               dst_reg = X86_REG_R9;
> the verifier will reject a prog that attempts to write into R10.
> So the above shouldn't be necessary.

Actually there is at least one exception, e.g.,
   if r10 > r5 goto +5
where dst is r10 and src r5.

For some insn where dst is intended to write with r10
like r10 = 10, and verifier will reject the program before
jit, as you mentioned in the above.

>
>> +               }
>> +
>>                  switch (insn->code) {
>>                          /* ALU */
>>                  case BPF_ALU | BPF_ADD | BPF_X:
>> @@ -2014,6 +2060,7 @@ st:                       if (is_imm8(insn->off))
>>                                  emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
>>                                  /* Restore R0 after clobbering RAX */
>>                                  emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
>> +
>>                                  break;
>>                          }
>>
>> @@ -2038,14 +2085,20 @@ st:                     if (is_imm8(insn->off))
>>
>>                          func = (u8 *) __bpf_call_base + imm32;
>>                          if (tail_call_reachable) {
>> -                               RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
>> +                               RESTORE_TAIL_CALL_CNT(stack_depth);
>>                                  ip += 7;
>>                          }
>>                          if (!imm32)
>>                                  return -EINVAL;
>> +                       if (enable_shadow_stack) {
>> +                               EMIT2(0x41, 0x51);
>> +                               ip += 2;
>> +                       }
>>                          ip += x86_call_depth_emit_accounting(&prog, func, ip);
>>                          if (emit_call(&prog, func, ip))
>>                                  return -EINVAL;
>> +                       if (enable_shadow_stack)
>> +                               EMIT2(0x41, 0x59);
> push/pop around calls are load/store plus math on %rsp.
> I think it's cheaper to reload r9 after the call with
> a single insn.
> The reload of r9 is effectively gs+const.
> There is no memory access. So it should be faster.

Two insn may be necessary since __alloc_percpu_gfp()
may return a pointer beyond 32 bits.

>
> Technically we can replace all uses of R10==rbp with
> 'gs:' based instructions.
> Like:
> r1 = r10
> can be jitted into
> lea rdi, gs + (u32)shadow_frame_ptr
>
> and r0 = *(u32 *)(r10 - 64)
> can be jitted into:
> mov rax, dword ptr gs:[(u32)shadow_frame_ptr - 64]
>
> but that is probably a bunch of jit changes.
> So I'd start with a simple reload of r9 after each call.

This is a good idea. We might need this so we only have
one extra insn per call.

>
> We need to micro-benchmark it to make sure there is no perf overhead.

Sure. Will do!


