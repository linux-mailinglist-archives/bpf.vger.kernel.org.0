Return-Path: <bpf+bounces-58659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB232ABF90E
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 17:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E767188C47A
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED4F1E3769;
	Wed, 21 May 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gHDfyP2m"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0962CCC9
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840786; cv=none; b=GrcBclpdYGsmlzvDxjcl6KztMly0I5TYqiYw8p7f2xJ5AVJSH/3q4gAX8M1PblitrhbWHAdgzX/vtIfKIdQPfovDMME7LmFFZQ0+jSNjXytF36m/cY3cd5JKXzVOstgNSnjmnoHNF7JWCWlQGG9gj1Do4M6frYlbu/Y/+JY2qJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840786; c=relaxed/simple;
	bh=oCfVWgdWRCeCE4//r4fcKcIyFvjroLNqhpDhykdXSjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLMZHE372JOpRUMml73BXmdMxhyuBA2+DPypl+9f1c0HV6l/AWMG/nFJFfTNmoL93eyf15ZLgdlkCh6wBlwyutMrBZhcrGbXRlL/hltHsYb/Trv3JTbHU8BcqzdXsomuCv+GPocZj2/oEoqwo3WMRThQj/T0TMcIAeWka2+dFws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gHDfyP2m; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d012b6b-9c6b-4542-8521-b2d3bd822c72@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747840779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6tlw4Ytm8MhVtp96IozRkB9YB+qwDfSogLdnUPAGV4=;
	b=gHDfyP2mGXANBfZsB1fgHXeoEEUqdaG6sq75fbPcmNXTyzYJJumv5YJ+P6fDdd/LQFQMRj
	hYd1a4gJAeFvtYYqcRqVf06thpSyFrsoGMYKooR1XlJh5yC0KeiPV6E7wmS7F3yDT/o97R
	QAzppx3YdMGzEXJ+ptCIvNGgzADa0bM=
Date: Wed, 21 May 2025 08:19:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Do not include r10 in precision
 backtracking bookkeeping
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250516161029.962760-1-yonghong.song@linux.dev>
 <CAEf4Bzb=ajQxWUL82H0sxTd-OxHYWXCVPzzcwv3snEShHiVuQQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bzb=ajQxWUL82H0sxTd-OxHYWXCVPzzcwv3snEShHiVuQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/20/25 7:16 AM, Andrii Nakryiko wrote:
> On Fri, May 16, 2025 at 9:10 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Yi Lai reported an issue ([1]) where the following warning appears
>> in kernel dmesg:
>>    [   60.643604] verifier backtracking bug
>>    [   60.643635] WARNING: CPU: 10 PID: 2315 at kernel/bpf/verifier.c:4302 __mark_chain_precision+0x3a6c/0x3e10
>>    [   60.648428] Modules linked in: bpf_testmod(OE)
>>    [   60.650471] CPU: 10 UID: 0 PID: 2315 Comm: test_progs Tainted: G           OE       6.15.0-rc4-gef11287f8289-dirty #327 PREEMPT(full)
>>    [   60.654385] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>    [   60.656682] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>    [   60.660475] RIP: 0010:__mark_chain_precision+0x3a6c/0x3e10
>>    [   60.662814] Code: 5a 30 84 89 ea e8 c4 d9 01 00 80 3d 3e 7d d8 04 00 0f 85 60 fa ff ff c6 05 31 7d d8 04
>>                         01 48 c7 c7 00 58 30 84 e8 c4 06 a5 ff <0f> 0b e9 46 fa ff ff 48 ...
>>    [   60.668720] RSP: 0018:ffff888116cc7298 EFLAGS: 00010246
>>    [   60.671075] RAX: 54d70e82dfd31900 RBX: ffff888115b65e20 RCX: 0000000000000000
>>    [   60.673659] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000ffffffff
>>    [   60.676241] RBP: 0000000000000400 R08: ffff8881f6f23bd3 R09: 1ffff1103ede477a
>>    [   60.678787] R10: dffffc0000000000 R11: ffffed103ede477b R12: ffff888115b60ae8
>>    [   60.681420] R13: 1ffff11022b6cbc4 R14: 00000000fffffff2 R15: 0000000000000001
>>    [   60.684030] FS:  00007fc2aedd80c0(0000) GS:ffff88826fa8a000(0000) knlGS:0000000000000000
>>    [   60.686837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>    [   60.689027] CR2: 000056325369e000 CR3: 000000011088b002 CR4: 0000000000370ef0
>>    [   60.691623] Call Trace:
>>    [   60.692821]  <TASK>
>>    [   60.693960]  ? __pfx_verbose+0x10/0x10
>>    [   60.695656]  ? __pfx_disasm_kfunc_name+0x10/0x10
>>    [   60.697495]  check_cond_jmp_op+0x16f7/0x39b0
>>    [   60.699237]  do_check+0x58fa/0xab10
>>    ...
>>
>> Further analysis shows the warning is at line 4302 as below:
>>
>>    4294                 /* static subprog call instruction, which
>>    4295                  * means that we are exiting current subprog,
>>    4296                  * so only r1-r5 could be still requested as
>>    4297                  * precise, r0 and r6-r10 or any stack slot in
>>    4298                  * the current frame should be zero by now
>>    4299                  */
>>    4300                 if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
>>    4301                         verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
>>    4302                         WARN_ONCE(1, "verifier backtracking bug");
>>    4303                         return -EFAULT;
>>    4304                 }
>>
>> With the below test (also in the next patch):
>>    __used __naked static void __bpf_jmp_r10(void)
>>    {
>>          asm volatile (
>>          "r2 = 2314885393468386424 ll;"
>>          "goto +0;"
>>          "if r2 <= r10 goto +3;"
>>          "if r1 >= -1835016 goto +0;"
>>          "if r2 <= 8 goto +0;"
>>          "if r3 <= 0 goto +0;"
>>          "exit;"
>>          ::: __clobber_all);
>>    }
>>
>>    SEC("?raw_tp")
>>    __naked void bpf_jmp_r10(void)
>>    {
>>          asm volatile (
>>          "r3 = 0 ll;"
>>          "call __bpf_jmp_r10;"
>>          "r0 = 0;"
>>          "exit;"
>>          ::: __clobber_all);
>>    }
>>
>> The following is the verifier failure log:
>>    0: (18) r3 = 0x0                      ; R3_w=0
>>    2: (85) call pc+2
>>    caller:
>>     R10=fp0
>>    callee:
>>     frame1: R1=ctx() R3_w=0 R10=fp0
>>    5: frame1: R1=ctx() R3_w=0 R10=fp0
>>    ; asm volatile ("                                 \ @ verifier_precision.c:184
>>    5: (18) r2 = 0x20202000256c6c78       ; frame1: R2_w=0x20202000256c6c78
>>    7: (05) goto pc+0
>>    8: (bd) if r2 <= r10 goto pc+3        ; frame1: R2_w=0x20202000256c6c78 R10=fp0
>>    9: (35) if r1 >= 0xffe3fff8 goto pc+0         ; frame1: R1=ctx()
>>    10: (b5) if r2 <= 0x8 goto pc+0
>>    mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1
>>    mark_precise: frame1: regs=r2 stack= before 9: (35) if r1 >= 0xffe3fff8 goto pc+0
>>    mark_precise: frame1: regs=r2 stack= before 8: (bd) if r2 <= r10 goto pc+3
>>    mark_precise: frame1: regs=r2,r10 stack= before 7: (05) goto pc+0
>>    mark_precise: frame1: regs=r2,r10 stack= before 5: (18) r2 = 0x20202000256c6c78
>>    mark_precise: frame1: regs=r10 stack= before 2: (85) call pc+2
>>    BUG regs 400
>>
>> The main failure reason is due to r10 in precision backtracking bookkeeping.
>> Actually r10 is always precise and there is no need to add it the precision
>> backtracking bookkeeping.
>>
>> One way to fix the issue is to prevent bt_set_reg() if any src/dst reg is
>> r10. Andrii suggested to go with push_insn_history() approach to avoid
>> explicitly checking r10 in backtrack_insn().
>>
>> This patch added push_insn_history() support for cond_jmp like 'rX <op> rY'
>> operations. In check_cond_jmp_op(), if any of rX or rY is r10, push_insn_history()
>> will not record that register, and later backtrack_insn() will not do
>> bt_set_reg() for those registers.
>>
>>    [1] https://lore.kernel.org/bpf/Z%2F8q3xzpU59CIYQE@ly-workstation/
>>
>> Reported by: Yi Lai <yi1.lai@linux.intel.com>
>> Fixes: 407958a0e980 ("bpf: encapsulate precision backtracking bookkeeping")
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf_verifier.h |  7 ++++
>>   kernel/bpf/verifier.c        | 69 +++++++++++++++++++++++++++++-------
>>   2 files changed, 64 insertions(+), 12 deletions(-)
>>
>> Changelogs:
>>    v1 -> v2:
>>      - v1: https://lore.kernel.org/bpf/20250511162758.281071-1-yonghong.song@linux.dev/
>>      - In v1, we check r10 register explicitly in backtrack_insn() to decide
>>        whether we should do bt_set_reg() or not. Andrii suggested to do
>>        push_insn_history() instead. Whether a particular register (r10 in this case)
>>        should be available for backtracking or not is in check_cond_jmp_op(),
>>        and such information is pushed with push_insn_history(). Later in backtrack_insn(),
>>        such info is retrieved to decide whether precision marking should be
>>        done or not. This apporach can avoid explicit checking for r10 in backtrack_insn().
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index cedd66867ecf..9d3fdabeeaf4 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -357,6 +357,8 @@ enum {
>>          INSN_F_SPI_SHIFT = 3, /* shifted 3 bits to the left */
>>
>>          INSN_F_STACK_ACCESS = BIT(9), /* we need 10 bits total */
>> +
>> +       INSN_F_REG_ACCESS = BIT(4), /* we need 5 bits total */
> hm... you are actually clashing with INSN_F_SPI_MASK here, bits 3
> through 8 are used to record stack slot index.

The reason I did this is that INSN_F_REG_ACCESS is used for
later struct bpf_insn_hist_entry sreg_flag and dreg_flag.
But as you mentioned later, there is no need to save register
numbers in sreg_flag/dreg_flag as insn already has it ...

>
> I think we should go with
>
> INSN_F_DST_REG_STACK = BIT(10), /* dst_reg is PTR_TO_STACK */
> INSN_F_SRC_REG_STACK = BIT(11), /* src_reg is PTR_TO_STACK */
> /* total 12 bits total can used now */
>
> also note that all this stuff needs to fit into
> bpf_insn_hist_entry.flags, which is currently set to be 10 bits, and
> so now we need two extra bits.
>
> Luckily, prev_idx: 22 doesn't really need 22 bits, so we can steal two
> bits there and still be able to express 1 million instructions
> indices:
>
> u32 prev_idx : 20;
> u32 flags : 12;

The above works since we do not need to save register numbers
in bpf_insn_hist_entry. I will rework along this line.

>
> pw-bot: cr
>
>>   };
>>
>>   static_assert(INSN_F_FRAMENO_MASK + 1 >= MAX_CALL_FRAMES);
>> @@ -372,6 +374,11 @@ struct bpf_insn_hist_entry {
>>           * jump is backtracked, vector of six 10-bit records
>>           */
>>          u64 linked_regs;
>> +       /* special flag, e.g., whether reg is used for non-load/store insns
>> +        * during precision backtracking.
>> +        */
>> +       u8 sreg_flag;
>> +       u8 dreg_flag;
> this is not necessary, src_reg and dst_reg number itself is coming
> from the bpf_insn itself?

You are correct. sreg_flag/dreg_flag is not needed.
INSN_F_{DST,SRC}_REG_STACK should be enough.

>
> [...]
>
>> @@ -4414,8 +4425,16 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>                           * before it would be equally necessary to
>>                           * propagate it to dreg.
>>                           */
>> -                       bt_set_reg(bt, dreg);
>> -                       bt_set_reg(bt, sreg);
>> +                       if (!hist)
>> +                               return 0;
>> +                       dreg_precise = hist->dreg_flag == insn_reg_with_access_flag(dreg);
>> +                       sreg_precise = hist->sreg_flag == insn_reg_with_access_flag(sreg);
> As I mentioned above, we don't need to store dst_reg and src_reg
> numbers themselves, we are getting them from bpf_insn. We just need
> those two flags, INSN_F_DST_REG_STACK and INSN_F_SRC_REG_STACK, to
> know which registers were PTR_TO_STACK at the time when we validated
> that instruction

Ack.

>
>> +                       if (!dreg_precise && !sreg_precise)
>> +                               return 0;
>> +                       if (dreg_precise)
>> +                               bt_set_reg(bt, dreg);
>> +                       if (sreg_precise)
>> +                               bt_set_reg(bt, sreg);
>>                  } else if (BPF_SRC(insn->code) == BPF_K) {
>>                           /* dreg <cond> K
>>                            * Only dreg still needs precision before
>> @@ -5115,7 +5134,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>>          }
>>
>>          if (insn_flags)
>> -               return push_insn_history(env, env->cur_state, insn_flags, 0);
>> +               return push_insn_history(env, env->cur_state, insn_flags, 0, 0, 0);
>>          return 0;
>>   }
>>
>> @@ -5422,7 +5441,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>>                  insn_flags = 0; /* we are not restoring spilled register */
>>          }
>>          if (insn_flags)
>> -               return push_insn_history(env, env->cur_state, insn_flags, 0);
>> +               return push_insn_history(env, env->cur_state, insn_flags, 0, 0, 0);
>>          return 0;
>>   }
>>
>> @@ -16414,6 +16433,27 @@ static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_s
>>          }
>>   }
>>
>> +static int push_cond_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *state,
>> +                                struct bpf_insn *insn, u64 linked_regs)
>> +{
>> +       int err;
>> +
>> +       if ((BPF_SRC(insn->code) != BPF_X ||
>> +            (insn->src_reg == BPF_REG_FP && insn->dst_reg == BPF_REG_FP)) &&
> we shouldn't be checking for BPF_REG_FP here either. Look up
> bpf_reg_state by insn->src_reg, and check that it's PTR_TO_STACK

Correct. Will check reg->type == PTR_TO_STACK instead.

>
>> +           !linked_regs)
>> +               return 0;
>> +
>> +       err = push_insn_history(env, state, 0, linked_regs,
>> +               BPF_SRC(insn->code) == BPF_X && insn->src_reg != BPF_REG_FP
>> +                       ? insn_reg_with_access_flag(insn->src_reg)
>> +                       : 0,
>> +               BPF_SRC(insn->code) == BPF_X && insn->dst_reg != BPF_REG_FP
>> +                       ? insn_reg_with_access_flag(insn->dst_reg)
>> +                       : 0);
>> +
>> +       return err;
>> +}
>> +
> [...]


