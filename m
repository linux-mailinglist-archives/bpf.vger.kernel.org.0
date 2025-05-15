Return-Path: <bpf+bounces-58351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDCCAB8FAC
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D195188F31E
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127D025C6FA;
	Thu, 15 May 2025 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iq0hoDdM"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB441C71
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336042; cv=none; b=GPuyOqD+49pyBvvNJx/9fRHT7LPI4uYvTmBqKlwu2Gig4fvfuYBeoVNTsCnCXsauDinygZz2Us1U8E/vKX8r+4xHkJJw3gNXGb7GX7WWIaM54BuWEOLvvqlp+YhuwwNf6kITpeQAoAwYvWPMQTkO+TwPJZw2s/83tsrstj2DRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336042; c=relaxed/simple;
	bh=uxEUxgQ4WOV9QollLV0Hs/AhuwhArQZEHE+MGB6KqaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGor6DDqI9RADkI3IdIS/fHZ/VKt02WDmUH4Uw89TrXa7/Zfiy1R/K0MoVFbpksdlUFBstwUnTCkcweTjEI1W2nHc7JWSHOBwafzEUH95OlpHVKB5xqcUiOXdA0nFsOFjsw6RZUp+ZJl3SgKtLUJpy22/faXUdkG0C/Liw7kDrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iq0hoDdM; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <81fc184d-04e1-4eb6-9a90-e380da5d218c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747336036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZ7bu4Vfdh8VExOuflfIOg/DoxJHmdG1oVHQ241WGw0=;
	b=Iq0hoDdMIiQZgQ999DCLeBJMr/ZOfMAuU0F/WV6PXHNrF6Yc0stYNoKfy5VvnxrqdSJSFD
	z+Nb25hHVx8Fb2ELg/vHHip5sG2vLrppq1TOrhILQRPpaV1yXaiq2N7uPyZhRPsezOiIXT
	nPgRXDKqx7ZNof/rdTTafTmQU71HVBI=
Date: Thu, 15 May 2025 12:07:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Do not include r10 in precision
 backtracking bookkeeping
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250511162758.281071-1-yonghong.song@linux.dev>
 <CAEf4BzaXB=hJNtpg7aUE67skjhuxDnG_oWHRULnmMNJwc9dRcQ@mail.gmail.com>
 <CAEf4BzbTzvapqEjExcOffOfwV=BKLL=ep1azp6VXdyLBgChZtg@mail.gmail.com>
 <3097e48c-a1ef-45f5-a445-c2a3c171fa81@linux.dev>
 <CAEf4BzaozHcBLhXzZAfbLRrNmx95d0DsMGjoBM9TvX7SDqujOg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzaozHcBLhXzZAfbLRrNmx95d0DsMGjoBM9TvX7SDqujOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/15/25 1:47 AM, Andrii Nakryiko wrote:
> On Wed, May 14, 2025 at 6:44 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 5/12/25 6:05 AM, Andrii Nakryiko wrote:
>>> On Mon, May 12, 2025 at 9:26 AM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>> On Sun, May 11, 2025 at 9:28 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>> Yi Lai reported an issue ([1]) where the following warning appears
>>>>> in kernel dmesg:
>>>>>     [   60.643604] verifier backtracking bug
>>>>>     [   60.643635] WARNING: CPU: 10 PID: 2315 at kernel/bpf/verifier.c:4302 __mark_chain_precision+0x3a6c/0x3e10
>>>>>     [   60.648428] Modules linked in: bpf_testmod(OE)
>>>>>     [   60.650471] CPU: 10 UID: 0 PID: 2315 Comm: test_progs Tainted: G           OE       6.15.0-rc4-gef11287f8289-dirty #327 PREEMPT(full)
>>>>>     [   60.654385] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>>>>     [   60.656682] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>>>>     [   60.660475] RIP: 0010:__mark_chain_precision+0x3a6c/0x3e10
>>>>>     [   60.662814] Code: 5a 30 84 89 ea e8 c4 d9 01 00 80 3d 3e 7d d8 04 00 0f 85 60 fa ff ff c6 05 31 7d d8 04
>>>>>                          01 48 c7 c7 00 58 30 84 e8 c4 06 a5 ff <0f> 0b e9 46 fa ff ff 48 ...
>>>>>     [   60.668720] RSP: 0018:ffff888116cc7298 EFLAGS: 00010246
>>>>>     [   60.671075] RAX: 54d70e82dfd31900 RBX: ffff888115b65e20 RCX: 0000000000000000
>>>>>     [   60.673659] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000ffffffff
>>>>>     [   60.676241] RBP: 0000000000000400 R08: ffff8881f6f23bd3 R09: 1ffff1103ede477a
>>>>>     [   60.678787] R10: dffffc0000000000 R11: ffffed103ede477b R12: ffff888115b60ae8
>>>>>     [   60.681420] R13: 1ffff11022b6cbc4 R14: 00000000fffffff2 R15: 0000000000000001
>>>>>     [   60.684030] FS:  00007fc2aedd80c0(0000) GS:ffff88826fa8a000(0000) knlGS:0000000000000000
>>>>>     [   60.686837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>     [   60.689027] CR2: 000056325369e000 CR3: 000000011088b002 CR4: 0000000000370ef0
>>>>>     [   60.691623] Call Trace:
>>>>>     [   60.692821]  <TASK>
>>>>>     [   60.693960]  ? __pfx_verbose+0x10/0x10
>>>>>     [   60.695656]  ? __pfx_disasm_kfunc_name+0x10/0x10
>>>>>     [   60.697495]  check_cond_jmp_op+0x16f7/0x39b0
>>>>>     [   60.699237]  do_check+0x58fa/0xab10
>>>>>     ...
>>>>>
>>>>> Further analysis shows the warning is at line 4302 as below:
>>>>>
>>>>>     4294                         /* static subprog call instruction, which
>>>>>     4295                          * means that we are exiting current subprog,
>>>>>     4296                          * so only r1-r5 could be still requested as
>>>>>     4297                          * precise, r0 and r6-r10 or any stack slot in
>>>>>     4298                          * the current frame should be zero by now
>>>>>     4299                          */
>>>>>     4300                         if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
>>>>>     4301                                 verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
>>>>>     4302                                 WARN_ONCE(1, "verifier backtracking bug");
>>>>>     4303                                 return -EFAULT;
>>>>>     4304                         }
>>>>>
>>>>> With the below test (also in the next patch):
>>>>>     __used __naked static void __bpf_jmp_r10(void)
>>>>>     {
>>>>>           asm volatile (
>>>>>           "r2 = 2314885393468386424 ll;"
>>>>>           "goto +0;"
>>>>>           "if r2 <= r10 goto +3;"
>>>>>           "if r1 >= -1835016 goto +0;"
>>>>>           "if r2 <= 8 goto +0;"
>>>>>           "if r3 <= 0 goto +0;"
>>>>>           "exit;"
>>>>>           ::: __clobber_all);
>>>>>     }
>>>>>
>>>>>     SEC("?raw_tp")
>>>>>     __naked void bpf_jmp_r10(void)
>>>>>     {
>>>>>           asm volatile (
>>>>>           "r3 = 0 ll;"
>>>>>           "call __bpf_jmp_r10;"
>>>>>           "r0 = 0;"
>>>>>           "exit;"
>>>>>           ::: __clobber_all);
>>>>>     }
>>>>>
>>>>> The following is the verifier failure log:
>>>>>     0: (18) r3 = 0x0                      ; R3_w=0
>>>>>     2: (85) call pc+2
>>>>>     caller:
>>>>>      R10=fp0
>>>>>     callee:
>>>>>      frame1: R1=ctx() R3_w=0 R10=fp0
>>>>>     5: frame1: R1=ctx() R3_w=0 R10=fp0
>>>>>     ; asm volatile ("                                 \ @ verifier_precision.c:184
>>>>>     5: (18) r2 = 0x20202000256c6c78       ; frame1: R2_w=0x20202000256c6c78
>>>>>     7: (05) goto pc+0
>>>>>     8: (bd) if r2 <= r10 goto pc+3        ; frame1: R2_w=0x20202000256c6c78 R10=fp0
>>>> For stacks spill/fill we use INSN_F_STACK_ACCESS because not just r10
>>>> can be used to point to the stack. I wonder if we need to handle r10
>>>> more generically here?
>>>>
>>>> E.g., if here we had something like
>>>>
>>>> r1 = r10
>>>> r1 += -8
>>>> if r2 <= r1 goto pc +3
>>>>
>>>> is it fine to track r1 as precise or we need to know that r1 is an alias to r10?
>>>>
>>>> Not sure myself yet, but I thought I'd bring this up as a concern.
>> In backtrack_insn, we have:
>>
>>                   } else if (opcode == BPF_MOV) {
>>                           if (BPF_SRC(insn->code) == BPF_X) {
>>                                   /* dreg = sreg or dreg = (s8, s16, s32)sreg
>>                                    * dreg needs precision after this insn
>>                                    * sreg needs precision before this insn
>>                                    */
>>                                   bt_clear_reg(bt, dreg);
>>                                   if (sreg != BPF_REG_FP)
>>                                           bt_set_reg(bt, sreg);
>>                           } else {
>>                                   /* dreg = K
>>                                    * dreg needs precision after this insn.
>>                                    * Corresponding register is already marked
>>                                    * as precise=true in this verifier state.
>>                                    * No further markings in parent are necessary
>>                                    */
>>                                   bt_clear_reg(bt, dreg);
>>                           }
>>
>> So for insn 'r1 = r10', even if r1 is marked precise, but based on the above
>> code r1 will be cleared and r10 will not be added to bt_set_reg due to
>> 'sreg != BPF_REG_FP'. So the current implementation should be okay.
>>
>>
>>> After discussing this with Eduard offline, I think that we should
>>> generalize this a bit and not hard-code r10 handling like this.
>>>
>>> Note how we use INSN_F_STACK_ACCESS to mark LDX and STX instructions
>>> as "accesses stack through register", regardless of whether that
>>> register is r10 or any other rx after `rX = r10; rX += <offset>`. I
>>> think we should do the same here more generally for all instructions,
>>> especially for conditional jumps.
>>>
>>> The only complication is that with INSN_F_STACK_ACCESS we have only
>>> one possible register within LDX/STX, while with conditional jumps we
>>> can have two registers (and both might be PTR_TO_STACK registers!).
>>>
>>> So I propose we split INSN_F_STACK_ACCESS into INSN_F_STACK_SRC and
>>> INSN_F_STACK_DST and use that to mark either src or dst register as
>>> being a PTR_TO_STACK. Then we can generically ignore any register that
>>> was a PTR_TO_STACK, because any such register is already implicitly
>>> precise.
>>>
>>> We'd need to slightly update existing code to use either
>>> INSN_F_STACK_SRC or INSN_F_STACK_DST, depending on LDX or STX, and
>>> then generalize all that to conditionals (and, technically, any other
>>> instruction).
>>>
>>> WDYT? Does it make sense?
>> I tried to prototype based on the above idea. But ultimately I gave up.
>> The following are some of my analysis.
>>
>> The INSN_F_STACK_ACCESS is used for stack access (load and store).
>> See:
>>
>> /* instruction history flags, used in bpf_insn_hist_entry.flags field */
>> enum {
>>           /* instruction references stack slot through PTR_TO_STACK register;
>>            * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES is 8)
>>            * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK is 512,
>>            * 8 bytes per slot, so slot index (spi) is [0, 63])
>>            */
>>           INSN_F_FRAMENO_MASK = 0x7, /* 3 bits */
>>
>>           INSN_F_SPI_MASK = 0x3f, /* 6 bits */
>>           INSN_F_SPI_SHIFT = 3, /* shifted 3 bits to the left */
>>
>>           INSN_F_STACK_ACCESS = BIT(9), /* we need 10 bits total */
>> };
>>
>> static int insn_stack_access_flags(int frameno, int spi)
>> {
>>           return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
>> }
>>
>> insn_stack_access_flags() is used by check_stack_read_fixed_off()
>> and check_stack_write_fixed_off(). For these two functions,
>> eventually a push_insn_history()
>>      push_insn_history(env, env->cur_state, insn_flags, 0)
>> is done to record related insn_flags info. Note that
>> insn_flags could be 0 or could be a actual insn_stack_access_flags()
>> which depends on other contexts.
>>
>> For cond op's like 'rX <op> rY', it is similar to other ALU{32,64} operations.
>> The decision can be made on the spot about to either clear or add related
>> registers to bt_reg_set.
>>
>> I understand that it is desirable to avoid explicit checking BPF_REG_FP
>> register. But this seems the simplest workable approach without
>> involving push_insn_history().
>>
>> The more complex option is to do push_insn_history() for 'rX <op> rY'
>> conditions with information about how to deal with r10 register, e.g.,
>> to enforce the register must be one of r0-r9. That way, in backtrack_insn,
>> the code can simply to
>>      if (hist->dst_reg_mask & dreg)
>>         bt_set_reg(bt, dreg);
>>      if (hist->src_reg_mask & sreg)
>>         bt_set_reg(bt, sreg);
>>
>> But this seems more complex than current simple approach.
>>
>> WDYT?
> Doing the push_insn_history() is exactly what I had in mind from the
> very beginning. I'd do that. It's a bit more code, but it sets us up
> better for generic handling of  PTR_TO_STACK registers, regardless if
> they are r10 or any other rX. This is the general direction we started
> on with INSN_F_STACK_ACCESS, so I think it makes sense to take another
> step in that direction, instead of reverting back to hacky BPF_REG_FP
> handling.

Okay, I will take a stab on this.

>
>>
>>>>>     9: (35) if r1 >= 0xffe3fff8 goto pc+0         ; frame1: R1=ctx()
>>>>>     10: (b5) if r2 <= 0x8 goto pc+0
>>>>>     mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1
>>>>>     mark_precise: frame1: regs=r2 stack= before 9: (35) if r1 >= 0xffe3fff8 goto pc+0
>>>>>     mark_precise: frame1: regs=r2 stack= before 8: (bd) if r2 <= r10 goto pc+3
>>>>>     mark_precise: frame1: regs=r2,r10 stack= before 7: (05) goto pc+0
>>>>>     mark_precise: frame1: regs=r2,r10 stack= before 5: (18) r2 = 0x20202000256c6c78
>>>>>     mark_precise: frame1: regs=r10 stack= before 2: (85) call pc+2
>>>>>     BUG regs 400
>>>>>
>>>>> The main failure reason is due to r10 in precision backtracking bookkeeping.
>>>>> Actually r10 is always precise and there is no need to add it the precision
>>>>> backtracking bookkeeping.
>>>>>
>>>>> This patch fixed the problem by not adding r10 to prevision backtracking bookkeeping.
>>>>>
>>>>>     [1] https://lore.kernel.org/bpf/Z%2F8q3xzpU59CIYQE@ly-workstation/
>>>>>
>>>>> Reported by: Yi Lai <yi1.lai@linux.intel.com>
>>>>> Fixes: 407958a0e980 ("bpf: encapsulate precision backtracking bookkeeping")
>>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>>> ---
>>>>>    kernel/bpf/verifier.c | 6 ++++--
>>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>> index 28f5a7899bd6..1cb4d80d15c1 100644
>>>>> --- a/kernel/bpf/verifier.c
>>>>> +++ b/kernel/bpf/verifier.c
>>>>> @@ -4413,8 +4413,10 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>>>>                            * before it would be equally necessary to
>>>>>                            * propagate it to dreg.
>>>>>                            */
>>>>> -                       bt_set_reg(bt, dreg);
>>>>> -                       bt_set_reg(bt, sreg);
>>>>> +                       if (dreg != BPF_REG_FP)
>>>>> +                               bt_set_reg(bt, dreg);
>>>>> +                       if (sreg != BPF_REG_FP)
>>>>> +                               bt_set_reg(bt, sreg);
>>>>>                   } else if (BPF_SRC(insn->code) == BPF_K) {
>>>>>                            /* dreg <cond> K
>>>>>                             * Only dreg still needs precision before
>>>>> --
>>>>> 2.47.1
>>>>>


