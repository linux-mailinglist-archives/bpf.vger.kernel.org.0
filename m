Return-Path: <bpf+bounces-67958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53C2B50AA9
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C3E7AD406
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69627226D02;
	Wed, 10 Sep 2025 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bH3/bdEj"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBAE14F9FB
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469756; cv=none; b=Msw+RVVqC0jgFz5SHnSctbrqircq3jivOLLVqR1wi+JmMzWin5hre9fn2MRQPOLgYagR+rSzHrdLIIcH7LSRRstVQ6p+wNh/LRR82bVxRyC+tNlpQuor8DK8NwXWIHHx8U65sdFCQ5WvzjZInwVim+t0vK8MVjsCjQXW9Ojghbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469756; c=relaxed/simple;
	bh=pVmbK8J4si5LngJZ5ZUFrG+XMJShaozl+Tn46gxnhnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6mlkgO0jCS4DJJyrhYze83XjMK91i9RfgIP+yHbWDmYM6pU6sVMQ2dI81S60a/9x3Q+YmaMiLN1Vr8PRJeygXjQevBa89JzLIxa2GuM5kE9aSxtFX/YUDzP9yMXuiJPsD6GWuiegJs2GTc/b1zVsG4S8P4s17sGS39vyGVDuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bH3/bdEj; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cad23151-7039-4a7f-b4ea-030ec161b2ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757469751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbZBpvJHmrp9ZqkqfrSPBvBdDLi4xALRJYXwjCDGskE=;
	b=bH3/bdEjPQj0dcgU4LdytD+ovDAFOkLVTpZEnWvjtoPDyxtXIJKNx85TMcz4RPSXgmyHHs
	HdbNmW0ZuoKX8+QqnkXCdh5f6tRvrikp3/0Jjbst+erbwVXHqIFcgRnBh28DsErDd1XNqC
	WgODq1UdlspPatWGJuYycAcqogWrA0U=
Date: Wed, 10 Sep 2025 10:02:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject bpf_timer for PREEMPT_RT
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Peilin Ye <yepeilin@google.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>,
 Barret Rhoden <brho@google.com>
References: <20250908044025.77519-1-leon.hwang@linux.dev>
 <20250908044025.77519-2-leon.hwang@linux.dev>
 <b0505a919d39e8151d0e14d9e41950f19d3807e0.camel@gmail.com>
 <603b37f4ef1a3ccbb661eaf11f56da9144bdcb66.camel@gmail.com>
 <aL9bvqeEfDLBiv5U@google.com>
 <CAADnVQ+G4u1vM7OUUKaos+jyG6FF8-72t8rMKyqRoa7nuF8xFA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+G4u1vM7OUUKaos+jyG6FF8-72t8rMKyqRoa7nuF8xFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/9/25 06:49, Alexei Starovoitov wrote:
> On Mon, Sep 8, 2025 at 3:42 PM Peilin Ye <yepeilin@google.com> wrote:
>>
>> Hi all,
>>
>>>>> [   35.955287] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>>
>> FWIW, I was able to reproduce this pr_err() after enabling
>> CONFIG_PREEMPT_RT and CONFIG_DEBUG_ATOMIC_SLEEP.
>>
>> On Mon, Sep 08, 2025 at 12:29:42PM -0700, Eduard Zingerman wrote:
>>> On Mon, 2025-09-08 at 12:20 -0700, Eduard Zingerman wrote:
>>>> On Mon, 2025-09-08 at 12:40 +0800, Leon Hwang wrote:
>>>>> When enable CONFIG_PREEMPT_RT, the kernel will panic when run timer
>>>>> selftests by './test_progs -t timer':
>>>
>>> Related discussions:
>>
>> [1]
>>> - https://lore.kernel.org/bpf/b634rejnvxqu6knjqlijosxrcnxbbpagt4de4pl6env6dwldz2@hoofqufparh5/T/
>>> - https://lore.kernel.org/bpf/lhmdi6npaxqeuaumjhmq24ckpul7ufopwzxjbsezhepguqkxag@wolz4r2fazu2/T/
>>
>> [...]
>>
>>>> The error is reported because of the kmalloc call in the __bpf_async_init, right?
>>>> Instead of disabling timers for PREEMPT_RT, would it be possible to
>>>> switch implementation to use kernel/bpf/memalloc.c:bpf_mem_alloc() instead?
>>
>> Just in case - actually there was a patch that does this:
>>
>> [2] https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@google.com/
> 
> Though switch to bpf_mem_alloc() kinda fixes it,
> it's too late for this release and it's not a complete fix for RT,
> so I think it's better to disable it in the verifier like this patch does.
> 
> Leon, pls respin targeting bpf tree.

My original intention for targeting the bpf-next tree was to ensure that
the new 'timer_interrupt' selftest is skipped when PREEMPT_RT is enabled.

If I respin the patch for the bpf tree, I have to drop the part that
skips the timer_interrupt test case. Should I?

> Also trim the commit log. It's too verbose and not quite correct.
> "kernel will panic"
> That's true only if you have panic-on-warn set.
> Just say that the kernel will warn.
> 

Sure.

I’ll make it more concise and clarify that "the kernel will warn",
rather than saying it will always panic.

Thanks,
Leon


