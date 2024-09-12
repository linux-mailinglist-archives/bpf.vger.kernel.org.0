Return-Path: <bpf+bounces-39778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D3E977491
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 00:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711F91F254D8
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 22:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CBC1C2DBC;
	Thu, 12 Sep 2024 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KP+RqliD"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09419F41A
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181642; cv=none; b=Truijz1nzWlP0fPASa9LfN739/PKU4i2qXfEhVRfjI+fsqXIJuDfK6U9M2O370TfB4YznHp1gRBsNxjdKd1qwKmsyrHQn681efpG/hXKfgb5nY0dyM89I/UKB7KiX0vAEl191UQwUxgM3uW4EyQtabvnZqqW5Kl5CbTFx0ouPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181642; c=relaxed/simple;
	bh=pZwZrt2mEL6hlz+wruQNg1UaPSr1/3f5FBRbKRj5fBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0/0uCZCDEFJ/JrQVMI12EUowafT1moUXRL1w6h6viJHP75zexmBUYYauWwmzYiBud8KsBZce2HADXHImjzjftj7firq9tZweCXHw6GE2d5B2V8BNUBQoB/FNqmEU+cfLcHTXRI+UxF4DxZWgaMRnMc5StsnwQnD6k29yWv9Poo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KP+RqliD; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3386e2fc-5c4a-4576-b761-8b4b60f6c195@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726181637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAzAiaBzDHUqh+aVcLM04K0xAuY7DuCTjVIWkrm5CZ8=;
	b=KP+RqliDcqi43MKH1Tq0ymdzmrH9ai315rwp9BLnrUXHxkydrrU1L+gkea0fKMml2rHqTZ
	VvOFwSfH4VO9zp4JycI3yyVFGQazrnv4Hiru9u17x0bYcrOdOLx9fy+WZJw7voSjfjvhhJ
	IjJpkCy52pz9tVdUhUKF7agCQ1y0qWQ=
Date: Thu, 12 Sep 2024 15:53:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix a sdiv overflow issue
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Zac Ecob <zacecob@protonmail.com>
References: <20240912035945.667426-1-yonghong.song@linux.dev>
 <CAEf4BzYzqG7GYp773Fzmtkbe6EV9TwoYFL2n=OJhzL-=90Jo_w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYzqG7GYp773Fzmtkbe6EV9TwoYFL2n=OJhzL-=90Jo_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/12/24 11:17 AM, Andrii Nakryiko wrote:
> On Wed, Sep 11, 2024 at 9:00 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Zac Ecob reported a problem where a bpf program may cause kernel crash due
>> to the following error:
>>    Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
>>
>> The failure is due to the below signed divide:
>>    LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
>> LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,775,808,
>> but it is impossible since for 64-bit system, the maximum positive
>> number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
>> cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
>> LLONG_MIN.
>>
>> Further investigation found all the following sdiv/smod cases may trigger
>> an exception when bpf program is running on x86_64 platform:
>>    - LLONG_MIN/-1 for 64bit operation
>>    - INT_MIN/-1 for 32bit operation
>>    - LLONG_MIN%-1 for 64bit operation
>>    - INT_MIN%-1 for 32bit operation
>> where -1 can be an immediate or in a register.
>>
>> On arm64, there are no exceptions:
>>    - LLONG_MIN/-1 = LLONG_MIN
>>    - INT_MIN/-1 = INT_MIN
>>    - LLONG_MIN%-1 = 0
>>    - INT_MIN%-1 = 0
>> where -1 can be an immediate or in a register.
>>
>> Insn patching is needed to handle the above cases and the patched codes
>> produced results aligned with above arm64 result.
>>
>>    [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com/
>>
>> Reported-by: Zac Ecob <zacecob@protonmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 84 ++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 80 insertions(+), 4 deletions(-)
>>
>> Changelogs:
>>    v1 -> v2:
>>      - Handle more crash cases like 32bit operation and modules.
>>      - Add more tests to test new cases.
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f35b80c16cda..ad7f51302c70 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20499,13 +20499,46 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>                          /* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
>>                          insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
>>
>> -               /* Make divide-by-zero exceptions impossible. */
>> +               /* Make sdiv/smod divide-by-minus-one exceptions impossible. */
>> +               if ((insn->code == (BPF_ALU64 | BPF_MOD | BPF_K) ||
>> +                    insn->code == (BPF_ALU64 | BPF_DIV | BPF_K) ||
>> +                    insn->code == (BPF_ALU | BPF_MOD | BPF_K) ||
>> +                    insn->code == (BPF_ALU | BPF_DIV | BPF_K)) &&
>> +                   insn->off == 1 && insn->imm == -1) {
>> +                       bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
>> +                       bool isdiv = BPF_OP(insn->code) == BPF_DIV;
>> +                       struct bpf_insn *patchlet;
>> +                       struct bpf_insn chk_and_div[] = {
>> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> +                                            BPF_OP(BPF_NEG) | BPF_K, insn->dst_reg,
>> +                                            0, 0, 0),
>> +                       };
>> +                       struct bpf_insn chk_and_mod[] = {
>> +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
>> +                       };
>> +
>> +                       patchlet = isdiv ? chk_and_div : chk_and_mod;
> nit: "chk_and_" part in the name is misleading, it's more like
> "safe_div" and "safe_mod". Oh, and it's "sdiv" and "smod" specific, so
> probably not a bad idea to have that in the name as well.

good idea. Will use chk_and_sdiv and chk_and_smod.

>
>> +                       cnt = isdiv ? ARRAY_SIZE(chk_and_div) : ARRAY_SIZE(chk_and_mod);
>> +
>> +                       new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
>> +                       if (!new_prog)
>> +                               return -ENOMEM;
>> +
>> +                       delta    += cnt - 1;
>> +                       env->prog = prog = new_prog;
>> +                       insn      = new_prog->insnsi + i + delta;
>> +                       goto next_insn;
>> +               }
>> +
>> +               /* Make divide-by-zero and divide-by-minus-one exceptions impossible. */
>>                  if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
>>                      insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
>>                      insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
>>                      insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
>>                          bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
>>                          bool isdiv = BPF_OP(insn->code) == BPF_DIV;
>> +                       bool is_sdiv = isdiv && insn->off == 1;
>> +                       bool is_smod = !isdiv && insn->off == 1;
>>                          struct bpf_insn *patchlet;
>>                          struct bpf_insn chk_and_div[] = {
>>                                  /* [R,W]x div 0 -> 0 */
>> @@ -20525,10 +20558,53 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>                                  BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>>                                  BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
>>                          };
>> +                       struct bpf_insn chk_and_sdiv[] = {
>> +                               /* [R,W]x sdiv 0 -> 0 */
>> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> +                                            BPF_JNE | BPF_K, insn->src_reg,
>> +                                            0, 2, 0),
>> +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
>> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 4),
>> +                               /* LLONG_MIN sdiv -1 -> LLONG_MIN
>> +                                * INT_MIN sdiv -1 -> INT_MIN
>> +                                */
>> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> +                                            BPF_JNE | BPF_K, insn->src_reg,
>> +                                            0, 2, -1),
>> +                               /* BPF_NEG(LLONG_MIN) == -LLONG_MIN == LLONG_MIN */
>> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> +                                            BPF_OP(BPF_NEG) | BPF_K, insn->dst_reg,
>> +                                            0, 0, 0),
>> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> I don't know how much it actually matters, but it feels like common
> safe case should be as straight-line-executed as possible, no?
>
> So maybe it's better to rearrange to roughly this (where rX is the
> divisor register):
>
>      if rX == 0 goto L1
>      if rX == -1 goto L2
>      rY /= rX
>      goto L3
> L1: /* zero case */
>      rY = 0 /* fallthrough, negation doesn't hurt, but less jumping */
> L2: /* negative one case (or zero) */
>      rY = -rY
> L3:
>      ... the rest of the program code ...

My previous patched insn try to clearly separate rX == 0 and
rX == -1 case. It has 2 insns including 2 cond jmps, 2 uncond jmps and
one 3 alu operations. The above one removed one uncond jmp, which
is indeed better.

>
>
> Those two branches for common case are still annoyingly inefficient, I
> wonder if we should do
>
>      rX += 1 /* [-1, 0] -> [0, 1]
>      if rX <=(unsigned) 1 goto L1
>      rX -= 1 /* restore original divisor */
>      rY /= rX /* common case */
>      goto L3
> L1:
>      if rX == 0 goto L2 /* jump if originally -1 */
>      rY = 0 /* division by zero case */
> L2: /* fallthrough */
>      rY = -rY
>      rX -= 1 /* restore original divisor */
> L3:
>      ... continue with the rest ...
>
>
> It's a bit trickier to follow, but should be faster in a common case.
>
> WDYT? Too much too far?

This is even better. The above rX -= 1 can be removed if we use
BPF_REG_AX as the temporary register. For example,

     tmp = rX
     tmp += 1 /* [-1, 0] -> [0, 1]
     if tmp <=(unsigned) 1 goto L1
     rY /= rX /* common case */
     goto L3
L1:
     if tmp == 0 goto L2 /* jump if originally -1 */
     rY = 0 /* division by zero case */
L2: /* fallthrough */
     rY = -rY
L3:
     ... continue with the rest ...

Maybe we can do even better

     tmp = rX
     tmp += 1 /* [-1, 0] -> [0, 1]
     if tmp >(unsigned) 1 goto L2
     if tmp == 0 goto L1
     rY = 0
L1:
     rY = -rY;
     goto L3
L2:
     rY /= rX
L3:

Could this be even better by reducing one uncond jmp in the fast path?

>
>
>> +                               *insn,
>> +                       };
>> +                       struct bpf_insn chk_and_smod[] = {
>> +                               /* [R,W]x mod 0 -> [R,W]x */
>> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> +                                            BPF_JNE | BPF_K, insn->src_reg,
>> +                                            0, 2, 0),
>> +                               BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
>> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 4),
>> +                               /* [R,W]x mod -1 -> 0 */
>> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> +                                            BPF_JNE | BPF_K, insn->src_reg,
>> +                                            0, 2, -1),
>> +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
>> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>> +                               *insn,
>> +                       };
>>
> Same idea here, keep the common case as straight as possible.

Sure. Will do.

>
>> -                       patchlet = isdiv ? chk_and_div : chk_and_mod;
>> -                       cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
>> -                                     ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
>> +                       if (is_sdiv) {
>> +                               patchlet = chk_and_sdiv;
>> +                               cnt = ARRAY_SIZE(chk_and_sdiv);
>> +                       } else if (is_smod) {
>> +                               patchlet = chk_and_smod;
>> +                               cnt = ARRAY_SIZE(chk_and_smod);
>> +                       } else {
>> +                               patchlet = isdiv ? chk_and_div : chk_and_mod;
>> +                               cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
>> +                                             ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
>> +                       }
>>
>>                          new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
>>                          if (!new_prog)
>> --
>> 2.43.5
>>

