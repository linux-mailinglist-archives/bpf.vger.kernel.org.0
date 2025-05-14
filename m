Return-Path: <bpf+bounces-58264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53FDAB796F
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 01:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCFB4C42DC
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 23:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B0B211A3D;
	Wed, 14 May 2025 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jXZ09ZBI"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18854C9F
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747265447; cv=none; b=Y2V4SYqdVvyTiMd3ZWUaJFb0iYRKHOmXndUr5bhtW2Izr65VPLUrfTyr5EbWTxjNckUS5fcbg0AiVe91eTrFmuxBvkvVpkJOrfuCnuoXpkAMUSAP0FbxqsKRokKtFdyaYk4TukGTTdRf8aLVDsEZH8JHVuIoyeUT6TojIL06I4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747265447; c=relaxed/simple;
	bh=RPYQqw42dd/kOPLEFjfMLusr0I2u0kPT7uqvjsdzLxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aK1974zSQZZWlB0ADtDi7W6ursPSIni2K8hOL3ITeuKa9d62yJqHffrE3MeQrsw9kfaUF5BTNNFYktmW0/NFAthf4VrtUabaRvhfraV9UTL9urDlBT0K+hqHQmQFCj+gH/okGqcCYqdDvwsVDDyJ4JYC8Om2nCLQCIzRg+tpY+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jXZ09ZBI; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d3f8fe35-201f-453e-bac0-48db2c901283@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747265442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCnVQmby+Lhwy/7E4/uS25UMiiipKqWnvneM1sIoa1U=;
	b=jXZ09ZBIGbUVKMai857bsVv2G9gyXB6nT23cZR627OK6Do5JJhZwmnT0aNqGoaGt9BwF9d
	3REx/jpCjB+D6MzhQPPJRddeYN7a9cSK+bVICm5LOnFGT+wVGxkajJnEC+V72KFb6b9auf
	xXf44+7hGziOcJV5fE15b7mv29c6SpA=
Date: Wed, 14 May 2025 16:30:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Pass the same orig_call value to
 trampoline functions
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250512221911.61314-1-iii@linux.ibm.com>
 <20250512221911.61314-2-iii@linux.ibm.com>
 <ab1d5047-7926-43ae-9dd7-0824b75af8b7@linux.dev>
 <07d1180a55dc2a589bc0df0895447ba52284cabc.camel@linux.ibm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <07d1180a55dc2a589bc0df0895447ba52284cabc.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/14/25 3:46 PM, Ilya Leoshkevich wrote:
> On Wed, 2025-05-14 at 14:26 -0700, Martin KaFai Lau wrote:
>> On 5/12/25 1:57 PM, Ilya Leoshkevich wrote:
>>> There is currently some confusion in the s390x JIT regarding
>>> whether
>>> orig_call can be NULL and what that means. Originally the NULL
>>> value
>>> was used to distinguish the struct_ops case, but this was
>>> superseded by
>>> BPF_TRAMP_F_INDIRECT (see commit 0c970ed2f87c ("s390/bpf: Fix
>>> indirect
>>> trampoline generation").
>>>
>>> The remaining reason to have this check is that NULL can actually
>>> be
>>> passed to the arch_bpf_trampoline_size() call - but not to the
>>> respective arch_prepare_bpf_trampoline()! call - by
>>> bpf_struct_ops_prepare_trampoline().
>>>
>>> Remove this asymmetry by passing stub_func to both functions, so
>>> that
>>> JITs may rely on orig_call never being NULL.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    kernel/bpf/bpf_struct_ops.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/bpf_struct_ops.c
>>> b/kernel/bpf/bpf_struct_ops.c
>>> index db13ee70d94d..96113633e391 100644
>>> --- a/kernel/bpf/bpf_struct_ops.c
>>> +++ b/kernel/bpf/bpf_struct_ops.c
>>> @@ -601,7 +601,7 @@ int bpf_struct_ops_prepare_trampoline(struct
>>> bpf_tramp_links *tlinks,
>>>    	if (model->ret_size > 0)
>>>    		flags |= BPF_TRAMP_F_RET_FENTRY_RET;
>>>    
>>> -	size = arch_bpf_trampoline_size(model, flags, tlinks,
>>> NULL);
>>> +	size = arch_bpf_trampoline_size(model, flags, tlinks,
>>> stub_func);
>>
>> The change looks ok but not sure why it is needed.
>>
>> I can see why stub_func is needed to generate the final image in
>> arch_prepare_bpf_trampoline() in x86. The
>> "arch_bpf_trampoline_size()" here is
>> generating a temporary image, so NULL or not doesn't seem to matter.
>>
>> Does the s390 jit need to use the actual stub_func address somewhere
>> in the
>> temporary and/or final image?
> 
> Not right now, however, in the future I would like to check whether
> orig_call points to a BPF prog. I have explained the rationale behind
> this in the series description.
> 
> Purely practical issues aside, currently it's unclear what
> orig_func == NULL means. It had meaning in the past, but not anymore.
> I think it would be good to remove this uncertainty and state that
> today orig_func is never NULL.

For the bpf_struct_ops trampoline image, there is no need to invoke the 
orig_call, so it had been NULL for both temporary and final image cases until 
the recent cfi fix in x86.

I was asking because it feels like the jit might be doing something incorrect 
(or at least unnecessary) for the bpf_struct_ops if it needs to use the 
orig_call address. I don't know much of the s390 jit though.

The change looks fine from the bpf_struct_ops pov. Always pass "stub_func" is 
more consistent also, so

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

I don't know enough about the tailcall_bpf2bpf_hierarchy as stated in the commit 
message, so I will defer to others to comment.

> Furthermore, a hypothetical JIT may produce different instruction
> sequences for loading certain constants. Suppose we wanted to load
> the value of orig_call into a register. Then in the NULL case a JIT
> could generate:
> 
>    xgr %r1,%r1
> 
> and in the non-NULL case:
> 
>    llihf %r1,<high>
>    oilf %r1,<low>
> 
> As you mentioned, arch_bpf_trampoline_size() generates a temporary
> image, and in this case it would have a different size. So this
> asymmetry can be a potential footgun.


