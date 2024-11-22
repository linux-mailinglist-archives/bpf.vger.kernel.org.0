Return-Path: <bpf+bounces-45472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB749D6176
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BB9160459
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4A41DF970;
	Fri, 22 Nov 2024 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VYLbc2or"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5A1DE2A2
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290071; cv=none; b=I5oR/0RS2ys9Ac21ihIT2W+ArrwMNdUi+/2gfeDA+qPPK/cBeGr1LkM6vlBMG2D5n0ludSZckU7E9cXkfjqaioE48iQg3lMLEkR4MIMQYh+HgUnqX8uu9LF5D6rRqcA0jLoChmYzfupOjKm6r5EYky5nZpSEEQbwK5l46C+/8SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290071; c=relaxed/simple;
	bh=XLD+hDJ+pI5hMg5OdYLBoJ3qV765S66CniFZTuU/3LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=td8Bxieoo/W8iDT2i+VnaIV/JQSPulazxe7HWsE963bewDUF7QSvHbySHrTJNliFGiS+nzEECS6k85kGUKLL8CjwD9bI12GCw7BoJpglBrVDmf/4a1auNzShuvxnR1SGgmqRN/z0zLdC+kxq15GvMV5Laviwzw3QImlOpstHXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VYLbc2or; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ef82652-25f4-43d4-bad5-f3766aafcc1f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732290064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFPSclUZkv19c0ljNhkyouPklMoXEK1Msn9XWFloIng=;
	b=VYLbc2orAto9T6CU3SKAzROIqdKeuEGOIMpADcoUb1goNBrcveUBSK+6+/JXpmw2INtKvt
	ncNc095jH1E3qiiuQrvSyyrMRF+w5l/YL6lOWZ1UMA7GntLkwXKlxnoN1wSTQm9ywdWdYu
	lGPDQz4sjUXKPTsSrEBuVVpe+bjN/DI=
Date: Fri, 22 Nov 2024 07:40:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 0/4] bpf: add cpu cycles kfuncss
To: Peter Zijlstra <peterz@infradead.org>, Vadim Fedorenko <vadfed@meta.com>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241121000814.3821326-1-vadfed@meta.com>
 <20241122113409.GV24774@noisy.programming.kicks-ass.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241122113409.GV24774@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/11/2024 03:34, Peter Zijlstra wrote:
> On Wed, Nov 20, 2024 at 04:08:10PM -0800, Vadim Fedorenko wrote:
>> This patchset adds 2 kfuncs to provide a way to precisely measure the
>> time spent running some code. The first patch provides a way to get cpu
>> cycles counter which is used to feed CLOCK_MONOTONIC_RAW. On x86
>> architecture it is effectively rdtsc_ordered() function while on other
>> architectures it falls back to __arch_get_hw_counter(). The second patch
>> adds a kfunc to convert cpu cycles to nanoseconds using shift/mult
>> constants discovered by kernel. The main use-case for this kfunc is to
>> convert deltas of timestamp counter values into nanoseconds. It is not
>> supposed to get CLOCK_MONOTONIC_RAW values as offset part is skipped.
>> JIT version is done for x86 for now, on other architectures it falls
>> back to slightly simplified version of vdso_calc_ns.
> 
> So having now read this. I'm still left wondering why you would want to
> do this.
> 
> Is this just debug stuff, for when you're doing a poor man's profile
> run? If it is, why do we care about all the precision or the ns. And why
> aren't you using perf?
> 
> Is it something else?
> 
> Again, what are you going to do with this information?

We do a lot of benchmarking at scale. We benchmark kernel function as
well as our own BPF programs. We already do it using bpf_ktime_get_ns().
And this patchset optimizes benchmark use-case by removing overhead
created double conversion from tsc to ns in case when we only need delta
value as a result of benchmarks. Another optimization, which has even
better effect, is to remove the overhead of function calls. As you can
see, both helpers are fully inlined for x86, reducing the amount of 
instructions from hundreds to single digit number and removing function
calls. The precision comes next, now we can better understand the effect
of fast-exits of some programs, but it's more like micro-benchmarking
and may have less benefits.

