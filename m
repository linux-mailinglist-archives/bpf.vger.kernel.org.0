Return-Path: <bpf+bounces-39620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5451A9756A4
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F8F2843B9
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B02C1ABECA;
	Wed, 11 Sep 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mt9uNK37"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EB319755E
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067704; cv=none; b=QRdLqeMlhVT0LlboEz+cWMhj/loWlIuXQS7xqlQHXdG6uy5AUdFjYm40hWgqeTVMTCe0dqIA7DJnhaDLFULOo30k8cy5SqGZ1gSvPuhqXzNan8I4PNtdH2a8gdyi0GArE1dR2EpgXf9Pr5O6oqcRfeoQRf4CjX6r44HKgNa5pYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067704; c=relaxed/simple;
	bh=OoWoV8eDEUuV8LgpMPEp9VSrXiPCH7zgP4MR8eYo9Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKINhyL7xuoRVuPjQtJokKxTaQMFlmFRcIg0rOnElJJCxSJbLBQ/LoDppwUDM/R9qqdFiZfoSEUQitWtFKI9tAjllY4/DTFz7utMn4poIMSQVjUWizNqtpeAlLSasAp6d6+zCOtg6RvejrNGeOemvSfvCYrh6EnvOhNcHANAolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mt9uNK37; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1013fea7-b913-480c-a642-b8aaa71e3ac1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726067699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLZzYXqKjI6JGI6nPb/prSGgwFiSf2/aeGquh+CqmwI=;
	b=Mt9uNK37ZiSKfOOyNq3caUpDINz0jFAhA395kQrv4mC+32VDoWA8/jK3s4ajy+Zr8DHixZ
	ZwPsiJuhQsvvsGnw8LEywUfG4H8GgfD06VeaiJb5iYjoKOQavNb1CE9dA7tjyXXPy50P7O
	09ERM3SqLjzc5X2kXTGpHFqKVerH7Kk=
Date: Wed, 11 Sep 2024 08:14:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix a sdiv overflow issue
Content-Language: en-GB
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Zac Ecob <zacecob@protonmail.com>, dthaler1968@googlemail.com
References: <20240911044017.2261738-1-yonghong.song@linux.dev>
 <bf721309-0bf7-667c-16c9-b2601e033fe7@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <bf721309-0bf7-667c-16c9-b2601e033fe7@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/11/24 7:18 AM, Daniel Borkmann wrote:
> On 9/11/24 6:40 AM, Yonghong Song wrote:
>> Zac Ecob reported a problem where a bpf program may cause kernel 
>> crash due
>> to the following error:
>>    Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
>>
>> The failure is due to the below signed divide:
>>    LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
>> LLONG_MIN/-1 is supposed to give a positive number 
>> 9,223,372,036,854,775,808,
>> but it is impossible since for 64-bit system, the maximum positive
>> number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
>> cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
>> LLONG_MIN.
>>
>> So for 64-bit signed divide (sdiv), some additional insns are patched
>> to check LLONG_MIN/-1 pattern. If such a pattern does exist, the result
>> will be LLONG_MIN. Otherwise, it follows normal sdiv operation.
>
> I presume this could be follow-up but it would also need an update to [0]
> to describe the behavior.
>
>   [0] Documentation/bpf/standardization/instruction-set.rst

I will do this as a follow-up. Will cover all cases including this patch
plus existing patched insn to handle r1/r2 and r1%r2 where runtime check r2
could be 0.

>
>>    [1] 
>> https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com/
>>
>> Reported-by: Zac Ecob <zacecob@protonmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++---
>>   1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f35b80c16cda..d77f1a05a065 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20506,6 +20506,7 @@ static int do_misc_fixups(struct 
>> bpf_verifier_env *env)
>>               insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
>>               bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
>>               bool isdiv = BPF_OP(insn->code) == BPF_DIV;
>> +            bool is_sdiv64 = is64 && isdiv && insn->off == 1;
>>               struct bpf_insn *patchlet;
>>               struct bpf_insn chk_and_div[] = {
>>                   /* [R,W]x div 0 -> 0 */
>> @@ -20525,10 +20526,32 @@ static int do_misc_fixups(struct 
>> bpf_verifier_env *env)
>>                   BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>>                   BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
>>               };
>> +            struct bpf_insn chk_and_sdiv64[] = {
>> +                /* Rx sdiv 0 -> 0 */
>> +                BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg,
>> +                         0, 2, 0),
>> +                BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
>> +                BPF_JMP_IMM(BPF_JA, 0, 0, 8),
>> +                /* LLONG_MIN sdiv -1 -> LLONG_MIN */
>> +                BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg,
>> +                         0, 6, -1),
>> +                BPF_LD_IMM64(insn->src_reg, LLONG_MIN),
>> +                BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_X, insn->dst_reg,
>> +                         insn->src_reg, 2, 0),
>> +                BPF_MOV64_IMM(insn->src_reg, -1),
>> +                BPF_JMP_IMM(BPF_JA, 0, 0, 2),
>> +                BPF_MOV64_IMM(insn->src_reg, -1),
>
> Looks good, we could probably shrink this snippet via BPF_REG_AX ?
> Untested, like below:
>
> +                /* Rx sdiv 0 -> 0 */
> +                BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, 
> insn->src_reg, 0, 2, 0),
> +                BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
> +                BPF_JMP_IMM(BPF_JA, 0, 0, 5),
> +                /* LLONG_MIN sdiv -1 -> LLONG_MIN */
> +                BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, 
> insn->src_reg, 0, 2, -1),
> +                BPF_LD_IMM64(BPF_REG_AX, LLONG_MIN),
> +                BPF_RAW_INSN(BPF_JMP | BPF_JEQ | BPF_X, 
> insn->dst_reg, BPF_REG_AX, 1, 0),
> +                *insn,
>
> Then we don't need to restore the src_reg in both paths.

Indeed, this is much simpler. I forgot to use BPF_REG_AX somehow...

>
>> +                *insn,
>> +            };
>
> Have you also looked into rejecting this pattern upfront on load when 
> its a known
> constant as we do with div by 0 in check_alu_op()?

We probably cannot do this for this sdiv case. For example,
r1/0 or r1%0 can be rejected by verifier.
But r1/-1 cannot be rejected as most likely r1 is not a constant LLONG_MIN.
But if the divisor is constant -1, we can patch insn to handle case r1/-1.

>
> Otherwise lgtm if this is equivalent to arm64 as you describe.
>
>> -            patchlet = isdiv ? chk_and_div : chk_and_mod;
>> -            cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
>> -                      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
>> +            if (is_sdiv64) {
>> +                patchlet = chk_and_sdiv64;
>> +                cnt = ARRAY_SIZE(chk_and_sdiv64);
>> +            } else {
>> +                patchlet = isdiv ? chk_and_div : chk_and_mod;
>> +                cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
>> +                          ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
>> +            }
>>                 new_prog = bpf_patch_insn_data(env, i + delta, 
>> patchlet, cnt);
>>               if (!new_prog)
>>
>

