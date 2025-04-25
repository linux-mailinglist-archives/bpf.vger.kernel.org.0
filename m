Return-Path: <bpf+bounces-56758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AA0A9D666
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 01:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3501B88389
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266EE297A73;
	Fri, 25 Apr 2025 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kb8qEv9Y"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7042E267F75
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745625017; cv=none; b=E48CEjrrO8cNOJZy4GtqfHYXvsh6WKuCX1UNIMIOyldt9qrDnVExShmJDyCRURa/IC47eu7oiENS/RlIZtfbiFXSFvAfLpSJtWGMD7vciInS9Q2yvFJYN+ISfVOTLUAyI3+pUEWd6WJp+fY2K1ASFfiKx/SeeX11XIuVflpBiFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745625017; c=relaxed/simple;
	bh=UTmbn+xqiqScqymuL4THXdR258xcURBEP1xhkPTpwYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brad/cYlrQRGDCp1y6ydsXzeN30l0IgcPhez+dBF8cTML51wySCz15GMY4pmFL+WrjwbbjuM55hvKf14HFoCQH3KDE+wiUEu/TG3HExyIU33s0Tpjy2IL1eszrjcJBIu1845YIbk+XTOE/qgIy0BdF3ZLVPpotDYaPMCB7P0tHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kb8qEv9Y; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <33e512c1-fc06-4ef9-b607-eff3c58a5d8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745625012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IapKBy2JqUuietg4LessIwILiqYn1cZ8VeHFS6U5po4=;
	b=kb8qEv9Yeht2KrJK2BIagtOB5AzYAXXiYnns8M+8UqmlBhG4tp0KhhmxkgLWE1b8noers7
	pyjc3AOK4B74BVEJQNGV45FFweALwUwodiCcRjEQ7GSrTxRXfYgdMqskDXrZFOLAtxuDoe
	63p4VE+pSfLTq+692Rgmif+LL3Rnha8=
Date: Fri, 25 Apr 2025 16:50:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 12/12] selftests/bpf: A bpf fq implementation
 similar to the kernel sch_fq
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Network Development <netdev@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>, Amery Hung <ameryhung@gmail.com>
References: <20250418224652.105998-1-martin.lau@linux.dev>
 <20250418224652.105998-13-martin.lau@linux.dev>
 <CAADnVQJTfUyxkZTZHgL8yqwu7VU2Ssbao8B_sw6Q16wJ1hVK7A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQJTfUyxkZTZHgL8yqwu7VU2Ssbao8B_sw6Q16wJ1hVK7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/24/25 5:13 PM, Alexei Starovoitov wrote:
> On Fri, Apr 18, 2025 at 3:47 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> This patch adds a fuller fq qdisc implementation that is comparable
>> to the kernel fq implementation. The code is mostly borrowed
>> from the sch_fq.c before the WRR addition. The WRR should be
>> doable as a followup.
>>
>> Some highlights:
>> * The current struct_ops does not support the qdisc_priv() concept.
>>    qdisc_priv() is the additional private data allocated by the
>>    qdisc subsystem at the end of a struct_ops object.
>>
>>    The patch is using a map-in-map approach to do the qdisc_priv.
>>    The outer map is an arraymap. When a qdisc instance starts,
>>    it grabs an available index (idx) in the ".init" ops.
>>    This idx will be the key to lookup the outer arraymap.
>>
>>    The inner map will then serve as the qdisc_priv which is
>>    the 'struct fq_sched_data'
>>
>> * Each qdisc instance has a hash table of rbtrees. This patch
>>    also uses map-in-map to do this. The outer arraymap's key is the
>>    qdisc "idx". The inner map is the array of bpf_rb_root.
>>
>> * With bpf_rbtree_{root,left,right} and bpf_list_{front,back},
>>    the fq_classify/enqueue/dequeue should be more recognizable when
>>    comparing with the sch_fq.c. Like, searching the flow and doing gc.
>>
>> * Most of the code deviation from sch_fq.c is because of
>>    the lock requirement and the refcount requirement.
> 
> This is a very impressive bpf prog.
> Quite amazing what qdisc-bpf can do.
> 
> Few questions:
> 
>> bpf_probe_read_kernel(&sk_long
> 
> Will the following work ?
> *bpf_core_cast(skb->sk, long)
> 
> or if verifier needs struct type (I don't recall)
> struct long_wrap {
>    long l;
> };
> bpf_core_cast(skb->sk, struct long_wrap)->l

Ah. I didn't think about bpf_core_cast.

As you suspected, adding "struct long_wrap" to the kernel works.

The verifier enforces the bpf_rdonly_cast return type must be a pointer to a 
struct. Thus, a plain "long" pointer won't work. btf_struct_access() will need 
some changes to support long pointer. I haven't checked other places yet.

> 
>> bpf_spin_lock(&root->lock);
> 
> have you considered "if (bpf_res_spin_lock(&root->lock))" ?

No but mostly because I started this set a little earlier, so it was not in my 
mind. Thanks for the suggestion.

> It can also protect rbtree and lists,
> and allows arbitrary calls inside, so the algorithm
> might be easier to implement?

Yes, it will make the implementation easier. e.g. it can call bpf_obj_{drop,new} 
without releasing the lock. It is a huge plus. I will use the res_spin_lock in 
the next revision.

Thanks for the review!


