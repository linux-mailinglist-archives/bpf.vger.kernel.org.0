Return-Path: <bpf+bounces-38322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE379963505
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 00:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A34D1F25B75
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 22:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDAA1AD407;
	Wed, 28 Aug 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O54mfeYU"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C901AC446
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885432; cv=none; b=iwoaEmU0+RK0gtFM59kugMWKO7PVxpId/79AmvQm3RCbaev7y6rXtI0dXQUfoGWOjvCxpG6H0BJgL/tVDu0Ff6H6pN03PbS4lyfFHnGDIJyDHO0Mc3ZKblPf5AVWWkIb80HFqmmWkeYHfMNq6qsh7rIvz7Wt16qWfNTuCJ/bT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885432; c=relaxed/simple;
	bh=JZeNBdQ1W+c0wIK+rjCIf0iRTTCgv2KKKhRaQz4LtrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mz3WKxMZTwyrtvbtbU03u/BBldmJjoP7baD0yOCt8dH72wpPyMGYjqDVG8a/oq5jnGGQrILX/gnF5VX9CSWCnIJIZ+k+Z3vOo+OHPgCcgODcNqw57hf7N8WLjekPHN4zsHD2x52YRp2Gln751YS2OtWu6tXe3BS0Fgox+0tL2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O54mfeYU; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0ad6d232-5385-40e4-b138-1b9ec383884a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724885425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/1sk2w9xBZtuXH+iDRjthRNgcriI6Gytp/4gTszyr0=;
	b=O54mfeYUWgLRqIAdTH+3n3GGtwnErQc8VrKzMUp3YhiFqChUKhUNpgEVFp9l3zlF1PMfRC
	aNCrp+gTv5K9sMlhydX52FLUHrDG9JCFyAmX/k6KlTmdMMJKD6xj99cAbCTc6199q3RQcD
	+1Owot40y5rOaQYMzRfBNR7NKYWLWAs=
Date: Wed, 28 Aug 2024 15:50:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf, x64: Fix a jit convergence issue
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Hodges <hodgesd@meta.com>
References: <20240825200406.1874982-1-yonghong.song@linux.dev>
 <CAEf4BzbCZ3daW_yo14E1fG_x=ciMggAuAMBSHs5E6iq9zE8NAQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzbCZ3daW_yo14E1fG_x=ciMggAuAMBSHs5E6iq9zE8NAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/27/24 4:44 PM, Andrii Nakryiko wrote:
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
> Probably a stupid question. But instead of hacking things like this to
> help convergence in some particular cases, why not just add a
> condition that we should stop jitting as soon as jitted length stops
> shrinking (and correct the comment that claims "JITed image shrinks
> with every pass" because that's not true).
>
> We have `if (proglen == oldproglen)` condition right now. What will
> happen if we just change it to `if (proglen >= oldproglen)`? That
> might be sup-optimal for these rare non-convergent cases, but that
> seems fine. We can of course do one extra pass to hopefully get back
> the second-to-last shorter image if proglen > oldproglen, but that
> seems excessive to me.

We need convergence. Looks at some comments below:

+ * pass5, final_proglen=4392:
+ *   ...
+ *   20e:    48 85 ff                test   rdi,rdi
+ *   211:    0f 84 80 00 00 00       je     0x297
+ *   217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
+ *   ...
+ *   28d:    48 85 ff                test   rdi,rdi
+ *   290:    74 1a                   je     0x2ac
+ *   292:    eb 84                   jmp    0x218
+ *   294:    bf 03 00 00 00          mov    edi,0x3

Without convergence, you can see je/jmp target may not be correct.

>
>
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
>> +static bool is_imm8_cond_offset(int value)
>> +{
>> +       return value <= 124 && value >= -128;
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

