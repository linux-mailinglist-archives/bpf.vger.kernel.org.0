Return-Path: <bpf+bounces-49159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EBCA14892
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 04:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB083A5277
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 03:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E6A1F63E0;
	Fri, 17 Jan 2025 03:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qC8h4UEJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14D1F561F
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737085404; cv=none; b=lTv8k8XzCMPn+KDRwFqvgs5TlaRUd+XQqY8ulvVge+tIW/QDHPovpF3gYZ2UL/E+ksdb5LTdE8BklcScIDNi9QLbOjTV2CCsk83i+oNYneBvGrvy7MBBgC+jQH0j3tnf8y4Gu+XhXJwNJGPZvYQKDzhsu+TucpGm7SAUxslH/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737085404; c=relaxed/simple;
	bh=h0EDYqB7v9EjmiS3bvTo7pyBhZIGLkqG25zeOMMU+bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHBe9mXL4y7NCZRX9wj3AoGiGBj7pKyRhfP11wid7yJpG6e+BWfmYZxkEAVdxRNmg1MMTNQDG6Gu0PYAXTaGgDIZqaI4oHgQY7hTXYUD1FLS04avf1xSEgfxNZ/VNHwAcvLSup52D/19uKYWwG01AEmvtDkYhohZB+iti8px1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qC8h4UEJ; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea125a8d-9804-4dd9-983b-1e741a1a4f1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737085395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSjrlBpbyYAmEKT5oV37/3z2T5zVN2aHy7cK1JA1lLs=;
	b=qC8h4UEJdC7gNvt8WanXG+Fu85VYLb7ZWhKIseHiS/rJc4M2AevhOCFZ2shxOgWByebySB
	7rifp1ClJRd6fuDGlwdRl4ZnEpBDk7wrrETpSWyACMVmLiZTd/nhbsofctIVsBjEC1VZZB
	/iYKrq5HUtx4sUaRqHX6rLLQmd7NIsQ=
Date: Thu, 16 Jan 2025 19:43:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Remove 'may_goto 0' instruction
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250116055123.603790-1-yonghong.song@linux.dev>
 <20250116055134.604867-1-yonghong.song@linux.dev>
 <75bfa14917a3475f60c6fac9d6480320d6f5f005.camel@gmail.com>
 <CAADnVQ+4ZJNdBU0D8kwe75VOp5x9xLrueEQk4hD1RDR_CJ63Fg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+4ZJNdBU0D8kwe75VOp5x9xLrueEQk4hD1RDR_CJ63Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 1/16/25 5:45 PM, Alexei Starovoitov wrote:
> On Thu, Jan 16, 2025 at 11:42 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> On Wed, 2025-01-15 at 21:51 -0800, Yonghong Song wrote:
>>> Since 'may_goto 0' insns are actually no-op, let us remove them.
>>> Otherwise, verifier will generate code like
>>>     /* r10 - 8 stores the implicit loop count */
>>>     r11 = *(u64 *)(r10 -8)
>>>     if r11 == 0x0 goto pc+2
>>>     r11 -= 1
>>>     *(u64 *)(r10 -8) = r11
>>>
>>> which is the pure overhead.
>>>
>>> The following code patterns (from the previous commit) are also
>>> handled:
>>>     may_goto 2
>>>     may_goto 1
>>>     may_goto 0
>>>
>>> With this commit, the above three 'may_goto' insns are all
>>> eliminated.
>>>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>> Technically this is a side-effect, it subtracts 1 from total loop budget.
>> An alternative transformation might be:
>>
>>      r11 = *(u64 *)(r10 -8)
>>      if r11 == 0x0 goto pc+2
>>      r11 -= 3     <---------------- note 3 here
>>      *(u64 *)(r10 -8) = r11
>>
>> On the other hand, it looks like there is no way to trick verifier
>> into an infinite loop by removing these statements, so this should be
>> safe modulo exceeding the 8M iterations budget.
>>
>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>>
>>>   kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 36 insertions(+)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index edf3cc42a220..72b474bfba2d 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -20133,6 +20133,40 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
>>>        return 0;
>>>   }
>>>
>>> +static int opt_remove_useless_may_gotos(struct bpf_verifier_env *env)
>>> +{
>>> +     struct bpf_insn *insn = env->prog->insnsi;
>>> +     int i, j, err, last_may_goto, removed_cnt;
>>> +     int insn_cnt = env->prog->len;
>>> +
>>> +     for (i = 0; i < insn_cnt; i++) {
>>> +             if (!is_may_goto_insn(&insn[i]))
>>> +                     continue;
>>> +
>>> +             for (j = i + 1; j < insn_cnt; j++) {
>>> +                     if (!is_may_goto_insn(&insn[j]))
>>> +                             break;
>>> +             }
>>> +
>>> +             last_may_goto = --j;
>>> +             removed_cnt = 0;
>>> +             while (j >= i) {
>>> +                     if (insn[j].off == 0) {
>>> +                             err = verifier_remove_insns(env, j, 1);
>> Nit: given how ineffective the verifier_remove_insns() is I'd count
>>       the number of matching may_goto's and removed them using one call
>>       to verifier_remove_insns().
> True,
> but more generally I don't see why may_goto needs special treatment.
> opt_remove_nops() should handle both.
>
> if (memcmp(&insn[i], &ja, sizeof(ja)) &&
>      memcmp(&insn[i], &may_goto0, sizeof(ja)))
>   continue;
>
> will almost work.
> In the sequence of may_goto +2, +1, +0
> only the last one will be removed, I think,
> but opt_remove_nops() can be tweaked to achieve that as well.
> -                 i--;
> +                 i -= 2;
>
> will do ?

Okay. Let me give a try.

>
> pw-bot: cr


