Return-Path: <bpf+bounces-49330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A330A1763B
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 04:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C913A794B
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 03:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71D5152514;
	Tue, 21 Jan 2025 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DfUYqw//"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC89126AD0
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737429641; cv=none; b=CDGgWK7B4Pyh5fZqc9eIDPpBEoRfi/WWx1FdC79DMrMLxIRKxPglnlt7pDaPdv0DJWDFit/7PbQma75+Ix1EBI8LuH6c17jAVGKFf4xzDtp8vCikQ1oirJSCya1lfFzjSFtjQEKkC/K3swYvhxDYkw8svhYPAuu1zEJH0QOPDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737429641; c=relaxed/simple;
	bh=CYz7XVjP8b3IEkhJUJD7pdqdK0PMSTL0D1JfbeqyKvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n12XSMfvr+JWDt1eHteciZC79Gky0tyyIVJxyPDbQ5iA58Uu4+vFbOx5ygK9x599GoEinyezZpGr7zxKdKqk6nxuHkLJZLrU9cSi5VJeqTScwi1WZ9OjIqh0wdu7N8cqfYR07fbQbfcvYVRzTEhPfUlwMn8C4HfvGRK0/B/luJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DfUYqw//; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4e621ff0-c40f-44ed-9610-8eadfd9f3cf1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737429632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezIv5DUiIFGbWOz3aydu15SaAqCa4Lro3pk6uWnkLBE=;
	b=DfUYqw//koG3n/yi/Uix1yKNzsjlqzDsmqngNSaE6V8GeaWGaRNSyCSGOUaOqOlByXTL7f
	JRIKlInThkFvUFS2PkI6gPftuGz/QcTuOCdUpGkV6guCh5EYDIzy/fAGuaZnaoR/+zvors
	4f9kjEMobG5XjbhUia0ryjPis/ZSpoM=
Date: Mon, 20 Jan 2025 19:20:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Remove 'may_goto 0' instruction in
 opt_remove_nops()
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250118192019.2123689-1-yonghong.song@linux.dev>
 <20250118192029.2124584-1-yonghong.song@linux.dev>
 <0056055b-338a-49f1-b6bf-fa11440cb959@iogearbox.net>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0056055b-338a-49f1-b6bf-fa11440cb959@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 1/20/25 7:29 AM, Daniel Borkmann wrote:
> On 1/18/25 8:20 PM, Yonghong Song wrote:
>> Since 'may_goto 0' insns are actually no-op, let us remove them.
>> Otherwise, verifier will generate code like
>>     /* r10 - 8 stores the implicit loop count */
>>     r11 = *(u64 *)(r10 -8)
>>     if r11 == 0x0 goto pc+2
>>     r11 -= 1
>>     *(u64 *)(r10 -8) = r11
>>
>> which is the pure overhead.
>>
>> The following code patterns (from the previous commit) are also
>> handled:
>>     may_goto 2
>>     may_goto 1
>>     may_goto 0
>>
>> With this commit, the above three 'may_goto' insns are all
>> eliminated.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 963dfda81c06..784547aa40a8 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20187,20 +20187,25 @@ static const struct bpf_insn NOP = 
>> BPF_JMP_IMM(BPF_JA, 0, 0, 0);
>>     static int opt_remove_nops(struct bpf_verifier_env *env)
>>   {
>> +    const struct bpf_insn may_goto_0 = BPF_RAW_INSN(BPF_JMP | 
>> BPF_JCOND, 0, 0, 0, 0);
>>       const struct bpf_insn ja = NOP;
>>       struct bpf_insn *insn = env->prog->insnsi;
>>       int insn_cnt = env->prog->len;
>> +    bool is_may_goto_0, is_ja;
>>       int i, err;
>>         for (i = 0; i < insn_cnt; i++) {
>> -        if (memcmp(&insn[i], &ja, sizeof(ja)))
>> +        is_may_goto_0 = !memcmp(&insn[i], &may_goto_0, 
>> sizeof(may_goto_0));
>> +        is_ja = !memcmp(&insn[i], &ja, sizeof(ja));
>> +
>> +        if (!is_may_goto_0 && !is_ja)
>>               continue;
>
> Why the extra may_goto_0 stack var?
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 245f1f3f1aec..16ba26295ec7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20185,16 +20185,19 @@ static int opt_remove_dead_code(struct 
> bpf_verifier_env *env)
>  }
>
>  static const struct bpf_insn NOP = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
> +static const struct bpf_insn MAY_GOTO_0 = BPF_RAW_INSN(BPF_JMP | 
> BPF_JCOND, 0, 0, 0, 0);

This actually is what I did initially. I changed to use the stack var because
NOP is used in other functions too while MAY_GOTO_0 is only used in
opt_remove_nops(). Certainly, using MAY_GOTO_0 as static variable works too.

>
>  static int opt_remove_nops(struct bpf_verifier_env *env)
>  {
> -       const struct bpf_insn ja = NOP;
>         struct bpf_insn *insn = env->prog->insnsi;
>         int insn_cnt = env->prog->len;
> +       bool is_ja, is_may_goto_0;
>         int i, err;
>
>         for (i = 0; i < insn_cnt; i++) {
> -               if (memcmp(&insn[i], &ja, sizeof(ja)))
> +               is_may_goto_0 = !memcmp(&insn[i], &MAY_GOTO_0, 
> sizeof(MAY_GOTO_0));
> +               is_ja         = !memcmp(&insn[i], &NOP, sizeof(NOP));
> +               if (!is_may_goto_0 && !is_ja)
>                         continue;
>
>>           err = verifier_remove_insns(env, i, 1);
>>           if (err)
>>               return err;
>>           insn_cnt--;
>> -        i--;
>> +        i -= (is_may_goto_0 && i > 0) ? 2 : 1;
>
> Maybe add a comment for this logic?

Thanks Alexei for adding comments before merging!

>
> Thanks,
> Daniel


