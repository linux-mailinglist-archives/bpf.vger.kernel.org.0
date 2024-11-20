Return-Path: <bpf+bounces-45295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 541979D41AF
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 18:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A68EB3521F
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CB419E82A;
	Wed, 20 Nov 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oZA+a+++"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88685A4D5
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123209; cv=none; b=hk1kdZ6WYZDkZWdYNqfOx4qaBhl2AV18pJiYQoednpp+blnFdmpa+bIUPmWXAKrhoOPV9g1gUD1wej7Wecc3fQplJUgtNE9KC9TbfI7DflHxv4opdaofnEjf29xsEo9ep8qn2Y1Hg3c2msgkej6WkjzGA+7Ke5bdxGMSFFHKyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123209; c=relaxed/simple;
	bh=TwlEUO1djPRoIcwSrPG46uNGrt+C2Av7Kxm8t/b3tYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXi5d+oUNcJLHypKGmYqiSq1gX4z4185B6VYAV8pETXF01gooWTHvCVentKbut+2Xhjk8C06jF1tP8eeC/5Kc4eaMQLm6iER0hufBNdKr6HrCj6baPMJwyY5GB9+XDimBsjosABiPlEaVwCjK4wwXKslrDFUH8DiM+wAfi+bTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oZA+a+++; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ca4feab-c63c-4d86-8213-26cca774d4b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732123204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osC62syVo+J2rIxGsRvQhiPOqdUv1do/2hu4dHlnaTc=;
	b=oZA+a+++G1vKhbyG8CCI/QcrYdjKA1joid8Dl/CXQQEJMDlDuQRhbkqnWmZymcWBXeUS+4
	Cfvyz86TU+hZwYXEc9kaKVNIXgIdJosUXPgIg4JJDyRT8MX4rQOaV2UhzaJ7vT1XEgt/mV
	dYOjs046B5THlTSdaGUJq4Cc76ywm6A=
Date: Wed, 20 Nov 2024 09:19:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 4/4] selftests/bpf: add usage example for cpu
 cycles kfuncs
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241118185245.1065000-1-vadfed@meta.com>
 <20241118185245.1065000-5-vadfed@meta.com>
 <20241119114714.GD2328@noisy.programming.kicks-ass.net>
 <de9a2138-39ee-46ce-9838-f6d6a4dde747@linux.dev>
 <20241120085117.GC19989@noisy.programming.kicks-ass.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241120085117.GC19989@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/11/2024 00:51, Peter Zijlstra wrote:
> On Tue, Nov 19, 2024 at 06:45:57AM -0800, Vadim Fedorenko wrote:
>> On 19/11/2024 03:47, Peter Zijlstra wrote:
>>> On Mon, Nov 18, 2024 at 10:52:45AM -0800, Vadim Fedorenko wrote:
>>>
>>>> +int bpf_cpu_cycles(void)
>>>> +{
>>>> +	struct bpf_pidns_info pidns;
>>>> +	__u64 start;
>>>> +
>>>> +	start = bpf_get_cpu_cycles();
>>>> +	bpf_get_ns_current_pid_tgid(0, 0, &pidns, sizeof(struct bpf_pidns_info));
>>>> +	cycles = bpf_get_cpu_cycles() - start;
>>>> +	ns = bpf_cpu_cycles_to_ns(cycles);
>>>> +	return 0;
>>>> +}
>>>
>>> Oh, the intent is to use that cycles_to_ns() on deltas. That wasn't at
>>> all clear.
>>
>> Yep, that's the main use case, it was discussed in the previous
>> versions of the patchset.
> 
> Should bloody well be in the changelogs then. As is I'm tempted to NAK
> the entire series because there is not a single word on WHY for any of
> this.

Sure, I'll add this info in the next version.

>>> Anyway, the above has more problems than just bad naming. TSC is
>>> constant and not affected by DVFS, so depending on the DVFS state of
>>> things your function will return wildly different readings.
>>
>> Why should I care about DVFS? The use case is to measure the time spent
>> in some code. If we replace it with bpf_ktime_get_ns(), it will also be
>> affected by DVFS, and it's fine. We will be able to see the difference
>> for different DVFS states.
> 
> Again, this goes to usage, why do you want this, what are you going to
> do with the results?
> 
> Run-ro-run numbers will be absolutely useless because of DVFS.

We do a lot of measurements of bpf programs and kernel stack functions
at scale. We can filter out variations due to DVFS as well as slice the
results by the HW generations, etc. In general, we do see benefits of
the values we gather. The goal of this patchset is to optimize the
overhead added by bpf_ktime_get_ns(). Andrii has already shown the
benefit in [1]. TL;DR - it's about 35-40% faster than the pair of
bpf_ktime_get_ns(). And helps to save a lot of CPU at scale.

[1] 
https://lore.kernel.org/bpf/CAEf4BzaRb+fUK17wrj4sWnYM5oKxTvwZC=U-GjvsdUtF94PqrA@mail.gmail.com/

