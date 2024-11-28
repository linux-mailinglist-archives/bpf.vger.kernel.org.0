Return-Path: <bpf+bounces-45831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9979DB998
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 15:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DE2164029
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F721AE00C;
	Thu, 28 Nov 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hoUdyv+P"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5DF192D77
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804153; cv=none; b=Oelh6P7TqVLHeLP0UvF0IBWgEmhbIh2FDrJP4T1b7yvmFejaR4EL2LcxYWJ6wr4ddf9P8gHCsStQLWCgYTicVePYDMJZKryY4FzZL9IDuaSZcgKP5lovWNt0MC+YJ3wwL28kwu3NO6gYv4RMliEjw9frD+PZjYUe6txSDdo7g6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804153; c=relaxed/simple;
	bh=1xFD0qpzbmDwsVU43Ds1u7QneTvROQDL1r//7ntmPSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PC8TmEXgBrjLL15Sv5IeYbw6tEkb4caxWelaLqno+CQQHzV/Pf5iF7tQ3Wz3KuJT4er+9CczqqjdZAzY9rN2pEV9DKM7oP422iRMWEl28jGvGDMYsqiCSi8OcELLRRkZByl+y33pBjFTjVjpL2p0vHxUzj/28ERy5DtkgKzKoqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hoUdyv+P; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <226f09a7-5e27-45e1-b807-6f9fe15f412c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732804147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHwVGhl5mqpYB9ygic6mM//Gfn3HdsRxk/7+Kr1zyHY=;
	b=hoUdyv+PIEb0Xd6hshP6TwjXaSDzW5hp2sGQb2QQKmMw12hUU/0DYiYWTlPWkJXHPyyylP
	UMl7R80kNDxQKnfUuwYEg8AWbEMXcBlHnhDGRy5jFHC1gQN9Egox+ze5IeRmzvl+whUtmN
	4evqIvxevgy91KQmOGb2mxi9fY0Nz7k=
Date: Thu, 28 Nov 2024 14:28:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 0/4] bpf: add cpu cycles kfuncss
To: Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Vadim Fedorenko <vadfed@meta.com>, Borislav Petkov <bp@alien8.de>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yonghong Song
 <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>, x86@kernel.org,
 bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241121000814.3821326-1-vadfed@meta.com>
 <20241122113409.GV24774@noisy.programming.kicks-ass.net>
 <CAEf4BzYa5_jOhY3oDgJ-R4jhX7K+EmhcKQAt0VdDeNnpXicJ4g@mail.gmail.com>
 <20241128112734.GD35539@noisy.programming.kicks-ass.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241128112734.GD35539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 28/11/2024 11:27, Peter Zijlstra wrote:
> On Tue, Nov 26, 2024 at 10:12:57AM -0800, Andrii Nakryiko wrote:
>> On Fri, Nov 22, 2024 at 3:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Wed, Nov 20, 2024 at 04:08:10PM -0800, Vadim Fedorenko wrote:
>>>> This patchset adds 2 kfuncs to provide a way to precisely measure the
>>>> time spent running some code. The first patch provides a way to get cpu
>>>> cycles counter which is used to feed CLOCK_MONOTONIC_RAW. On x86
>>>> architecture it is effectively rdtsc_ordered() function while on other
>>>> architectures it falls back to __arch_get_hw_counter(). The second patch
>>>> adds a kfunc to convert cpu cycles to nanoseconds using shift/mult
>>>> constants discovered by kernel. The main use-case for this kfunc is to
>>>> convert deltas of timestamp counter values into nanoseconds. It is not
>>>> supposed to get CLOCK_MONOTONIC_RAW values as offset part is skipped.
>>>> JIT version is done for x86 for now, on other architectures it falls
>>>> back to slightly simplified version of vdso_calc_ns.
>>>
>>> So having now read this. I'm still left wondering why you would want to
>>> do this.
>>>
>>> Is this just debug stuff, for when you're doing a poor man's profile
>>> run? If it is, why do we care about all the precision or the ns. And why
>>> aren't you using perf?
>>
>> No, it's not debug stuff. It's meant to be used in production for
>> measuring durations of whatever is needed. Like uprobe entry/exit
>> duration, or time between scheduling switches, etc.
>>
>> Vadim emphasizes benchmarking at scale, but that's a bit misleading.
>> It's not "benchmarking", it's measuring durations of relevant pairs of
>> events. In production and at scale, so the unnecessary overhead all
>> adds up. We'd like to have the minimal possible overhead for this time
>> passage measurement. And some durations are very brief,
> 
> You might want to consider leaving out the LFENCE before the RDTSC on
> some of those, LFENCE isn't exactly cheap.

I was considering this option. Unfortunately, RDTSC without LFENCE may
be executed well out of order by CPU and can easily bring more noise.
We have seen some effects of LFENCE being quite expensive on high core
count machines and we will continue monitor it. I might add another
helper in the future if the situation gets unacceptable.

> 
>> so precision
>> matters as well. And given this is meant to be later used to do
>> aggregation and comparison across large swaths of production hosts, we
>> have to have comparable units, which is why nanoseconds and not some
>> abstract "time cycles".
>>
>> Does this address your concerns?
> 
> Well, it's clearly useful for you guys, but I do worry about it. Even on
> servers DVFS is starting to play a significant role. And the TSC is
> unaffected by it.
> 
> Directly comparing these numbers, esp. across different systems makes no
> sense to me. Yes putting them all in [ns] allows for comparison, but
> you're still comparing fundamentally different things.
> 
> How does it make sense to measure uprobe entry/exit in wall-clock when
> it can vary by at least a factor of 2 depending on DVFS. How does it
> make sense to compare an x86-64 uprobe entry/exit to an aaargh64 one?

I'm going to implement JIT for aarch64 soon and measuring wall-time can 
bring more info about platforms differences.

> 
> Or are you trying to estimate the fraction of overhead spend on
> instrumentation instead of real work? Like, this machine spends 5% of
> its wall-time in instrumentation, which is effectively not doing work?
> 
> The part I'm missing is how using wall-time for these things makes
> sense.
> 
> I mean, if all you're doing is saying, hey, we appear to be spending X
> on this action on this particular system Y doing workload Z (irrespecive
> of you then having like a million Ys) and this patch reduces X by half
> given the same Y and Z. So patch must be awesome.

This is one of the use-cases. Another one is to show differences across
platforms, and that what usually needs ns.

> 
> Then you don't need the conversion to [ns], and the DVFS angle is more
> or less mitigated by the whole 'same workload' thing.

We are thinking of this option too, but another point is that it's
usually easier for people to understand nanoseconds rather then
counter values.


