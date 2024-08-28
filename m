Return-Path: <bpf+bounces-38321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF69634FD
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 00:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED061F23801
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 22:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F09D1ACE0F;
	Wed, 28 Aug 2024 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nhTZk34C"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866915A858
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885252; cv=none; b=AjIRnwgW24nFaH8hkuGNBdqNqrcmk/IIHD9BGGPnPXUPq5YA0ipsuvq77+Djpbp1YO1OcGxpqqe1CnfqFej3Gpi1q1ahJAPuc4qEtBq5bwYkTC8/gjyQ18atGxkhIBu68g+SZf6sHkLiao/boP5Ln3RrYCTTebnrEMU/SEKIwV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885252; c=relaxed/simple;
	bh=JgUoRbFenP7vs8Wa6ItRUTXZr40k2I8duWk+Pou17ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYDqsKUmEDKC4169UorvaZMDHIbR610r2CBWvtHsqWcQu4a0ddCGz1dhk0TxlovSgFDznQ7BuG8hgSVoephFd3T2TrXfNvkj29vqnKKZf/c0kj9fUjwLcEnypUbD7ZuVQkmneJ+EBENVGOXc1OaVl3nDKSZc0GcSGxic/VVcudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nhTZk34C; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e2ad37e-e750-4cbd-8305-bf16bbebcc53@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724885247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYTWcigkIiAne3TySTUR7PgX18rfHUfqg1rg2LiWIAY=;
	b=nhTZk34CDWvAJti1DBsCV7L+4cYB4HdJrhEWAAqnUW2jFayd9v7iQaNfHPD/lOd0Lmt3sr
	G/fQKaqOaFEOsP8DRiev8V4HNWUAN5Em9CRjSdBrrmqB2SnY7WxqTBWDngBYQEOsuC2DQj
	9GlgG4FkVY25vhoZMAsNYHRpJ92lwoQ=
Date: Wed, 28 Aug 2024 15:47:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf, x64: Fix a jit convergence issue
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Hodges <hodgesd@meta.com>
References: <20240825200406.1874982-1-yonghong.song@linux.dev>
 <CAADnVQ+5HD1ZxBqpDgNuwPkO1+VGzm1yqhxuDD4HYtkRYHwXiA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+5HD1ZxBqpDgNuwPkO1+VGzm1yqhxuDD4HYtkRYHwXiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/27/24 7:24 PM, Alexei Starovoitov wrote:
> On Sun, Aug 25, 2024 at 1:04 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Daniel Hodges reported a jit error when playing with a sched-ext
>> program. The error message is:
>>    unexpected jmp_cond padding: -4 bytes
>>
>> But further investigation shows the error is actual due to failed
>> convergence. The following are some analysis:
>>
>>    ...
>>    pass4, final_proglen=4391:
>>      ...
>>      20e:    48 85 ff                test   rdi,rdi
>>      211:    74 7d                   je     0x290
>>      213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>      ...
>>      289:    48 85 ff                test   rdi,rdi
>>      28c:    74 17                   je     0x2a5
>>      28e:    e9 7f ff ff ff          jmp    0x212
>>      293:    bf 03 00 00 00          mov    edi,0x3
>>
>> Note that insn at 0x211 is 2-byte cond jump insn for offset 0x7d (-125)
>> and insn at 0x28e is 5-byte jmp insn with offset -129.
>>
>>    pass5, final_proglen=4392:
>>      ...
>>      20e:    48 85 ff                test   rdi,rdi
>>      211:    0f 84 80 00 00 00       je     0x297
>>      217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>      ...
>>      28d:    48 85 ff                test   rdi,rdi
>>      290:    74 1a                   je     0x2ac
>>      292:    eb 84                   jmp    0x218
>>      294:    bf 03 00 00 00          mov    edi,0x3
>>
>> Note that insn at 0x211 is 5-byte cond jump insn now since its offset
>> becomes 0x80 based on previous round (0x293 - 0x213 = 0x80).
>> At the same time, insn at 0x292 is a 2-byte insn since its offset is
>> -124.
>>
>> pass6 will repeat the same code as in pass4. pass7 will repeat the same
>> code as in pass5, and so on. This will prevent eventual convergence.
>>
>> Passes 1-14 are with padding = 0. At pass15, padding is 1 and related
>> insn looks like:
>>
>>      211:    0f 84 80 00 00 00       je     0x297
>>      217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>      ...
>>      24d:    48 85 d2                test   rdx,rdx
>>
>> The similar code in pass14:
>>      211:    74 7d                   je     0x290
>>      213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>      ...
>>      249:    48 85 d2                test   rdx,rdx
>>      24c:    74 21                   je     0x26f
>>      24e:    48 01 f7                add    rdi,rsi
>>      ...
>>
>> Before generating the following insn,
>>    250:    74 21                   je     0x273
>> "padding = 1" enables some checking to ensure nops is either 0 or 4
>> where
>>    #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>>    nops = INSN_SZ_DIFF - 2
>>
>> In this specific case,
>>    addrs[i] = 0x24e // from pass14
>>    addrs[i-1] = 0x24d // from pass15
>>    prog - temp = 3 // from 'test rdx,rdx' in pass15
>> so
>>    nops = -4
>> and this triggers the failure.
>> Making jit prog convergable can fix the above error.
>>
>> Reported-by: Daniel Hodges <hodgesd@meta.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 47 ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 074b41fafbe3..ec541aae5d9b 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -64,6 +64,51 @@ static bool is_imm8(int value)
>>          return value <= 127 && value >= -128;
>>   }
>>
>> +/*
>> + * Let us limit the positive offset to be <= 124.
>> + * This is to ensure eventual jit convergence For the following patterns:
>> + * ...
>> + * pass4, final_proglen=4391:
>> + *   ...
>> + *   20e:    48 85 ff                test   rdi,rdi
>> + *   211:    74 7d                   je     0x290
>> + *   213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>> + *   ...
>> + *   289:    48 85 ff                test   rdi,rdi
>> + *   28c:    74 17                   je     0x2a5
>> + *   28e:    e9 7f ff ff ff          jmp    0x212
>> + *   293:    bf 03 00 00 00          mov    edi,0x3
>> + * Note that insn at 0x211 is 2-byte cond jump insn for offset 0x7d (-125)
>> + * and insn at 0x28e is 5-byte jmp insn with offset -129.
>> + *
>> + * pass5, final_proglen=4392:
>> + *   ...
>> + *   20e:    48 85 ff                test   rdi,rdi
>> + *   211:    0f 84 80 00 00 00       je     0x297
>> + *   217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>> + *   ...
>> + *   28d:    48 85 ff                test   rdi,rdi
>> + *   290:    74 1a                   je     0x2ac
>> + *   292:    eb 84                   jmp    0x218
>> + *   294:    bf 03 00 00 00          mov    edi,0x3
>> + * Note that insn at 0x211 is 5-byte cond jump insn now since its offset
>> + * becomes 0x80 based on previous round (0x293 - 0x213 = 0x80).
>> + * At the same time, insn at 0x292 is a 2-byte insn since its offset is
>> + * -124.
>> + *
>> + * pass6 will repeat the same code as in pass4 and this will prevent
>> + * eventual convergence.
>> + *
>> + * To fix this issue, we need to break je (2->6 bytes) <-> jmp (5->2 bytes)
>> + * cycle in the above. Let us limit the positive offset for 8bit cond jump
>> + * insn to mamximum 124 (0x7c). This way, the jmp insn will be always 2-bytes,
>> + * and the jit pass can eventually converge.
>> + */
> je<->jmp
>
> It can be je/je too, no?

Yes. It is possible.

>
> so 128 - 4 instead of 128 - 3 ?

You probably mean "127 - 4 instead of 127 - 3" since
the maximum value is 127.

I checked 127 - 4 = 0x7c and indeed we should. See below examples:

    20e:    48 85 ff                test   rdi,rdi
    211:    XX XX                   je     0x291
    213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    28d:    XX XX XX XX XX XX       je     0x212
    293:    bf 03 00 00 00          mov    edi,0x3

=>

    20e:    48 85 ff                test   rdi,rdi
    211:    XX XX XX XX XX XX       je     0x297 (0x293 - 0x213)
    217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    291:    XX XX                   je     0x217 (0x217 - 0x293)
    293:    bf 03 00 00 00          mov    edi,0x3

=>

    20e:    48 85 ff                test   rdi,rdi
    211:    XX XX                   je     0x28f (0x293 - 0x217)
    213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    28d:    XX XX                   je     0x213 (0x213 - 0x293)  // -0x80 allowed
    293:    bf 03 00 00 00          mov    edi,0x3

=>

    20e:    48 85 ff                test   rdi,rdi
    211:    XX XX XX XX XX XX       je     0x28f (0x293 - 0x213)
    217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    291:    XX XX                   je     0x217 (0x217 - 0x293)
    293:    bf 03 00 00 00          mov    edi,0x3

=>
    ...


Here 0x293 - 0x217 = 0x7c

>
>> +static bool is_imm8_cond_offset(int value)
>> +{
>> +       return value <= 124 && value >= -128;
> the other side needs the same treatment, no ?

good question. From my understanding, the non-convergence in the
above needs both forward and backport conditions. The solution we
are using is based on putting a limitation on forward conditions
w.r.t. jit code gen.

Another solution is actually to put a limitation on backward
conditions. For example, let us say the above is_imm8_cond_offset()
has
	return value <= 127 && value > -124

See below example:

    20e:    48 85 ff                test   rdi,rdi
    211:    XX XX                   je     0x291
    213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    28d:    XX XX XX XX XX XX       je     0x212
    293:    bf 03 00 00 00          mov    edi,0x3

=>

    20e:    48 85 ff                test   rdi,rdi
    211:    XX XX XX XX XX XX       je     0x297 (0x293 - 0x213)
    217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    291:    XX XX XX XX XX XX       je     0x21b (0x217 - 0x293)
    297:    bf 03 00 00 00          mov    edi,0x3
  
=>

    20e:    48 85 ff                test   rdi,rdi
    211:    XX XX XX XX XX XX       je     0x297 (0x297 - 0x217)
    217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    291:    XX XX XX XX XX XX       je     0x217 (0x217 - 0x297)
    297:    bf 03 00 00 00          mov    edi,0x3

converged here.

So I think we do not need to limit both sides. One side should be enough.

>
>> +}
>> +
>>   static bool is_simm32(s64 value)
>>   {
>>          return value == (s64)(s32)value;
>> @@ -2231,7 +2276,7 @@ st:                       if (is_imm8(insn->off))
>>                                  return -EFAULT;
>>                          }
>>                          jmp_offset = addrs[i + insn->off] - addrs[i];
>> -                       if (is_imm8(jmp_offset)) {
>> +                       if (is_imm8_cond_offset(jmp_offset)) {
>>                                  if (jmp_padding) {
>>                                          /* To keep the jmp_offset valid, the extra bytes are
>>                                           * padded before the jump insn, so we subtract the
>> --
>> 2.43.5
>>

