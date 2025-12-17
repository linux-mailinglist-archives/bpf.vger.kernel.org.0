Return-Path: <bpf+bounces-76844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E958CC6DAD
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6F0830ACCBC
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94533D6D9;
	Wed, 17 Dec 2025 09:34:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05E33CEAF;
	Wed, 17 Dec 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964066; cv=none; b=eTlDcrr1WYx1HT/6ME8nw8FSiivphVP30bHGb0dSt8k+4u6zDw704IOlsiSzT6/egLBGzAYJFu+UWy3PbCuZohm3JwqrtJ7LSS3VtkR93TmTu68E5stkxzl6Wdnj4dhdHVhZJZQSVSfwwRWdZXmxFK97ELfxBj5Bf0nYPLJrLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964066; c=relaxed/simple;
	bh=pA6OyNOPqic2PU25XHzrUn7XCNr0QY2cPEtn3K+4NLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXd8wYwekDpPzHOHI+Rz3lJYwhe1HPp8aGhmd7J0bcUCBZT9uQyTRducOjdhHkHPWVZfXMA9Hd+X9HIMDITeIKCcNKDjI7iEB8L+MC6mZjwtayCVFr8vE4POfGOlzYl7dT2mjpCBzh5QOWyF5ZTmYAwNUrtTqTb80FpiyLUKDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9305914BF;
	Wed, 17 Dec 2025 01:34:16 -0800 (PST)
Received: from [10.57.91.77] (unknown [10.57.91.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 894773F73B;
	Wed, 17 Dec 2025 01:34:17 -0800 (PST)
Message-ID: <100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com>
Date: Wed, 17 Dec 2025 09:34:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] introduce pagetable_alloc_nolock()
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, catalin.marinas@arm.com,
 will@kernel.org, kevin.brodsky@arm.com, dev.jain@arm.com,
 yang@os.amperecomputing.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
 <aUGOPd7gNRf1xHEc@e129823.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aUGOPd7gNRf1xHEc@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/12/2025 16:52, Yeoreum Yun wrote:
> Hi Ryan,
> 
>> On 12/12/2025 16:18, Yeoreum Yun wrote:
>>> Some architectures invoke pagetable_alloc() or __get_free_pages()
>>> with preemption disabled.
>>> For example, in arm64, linear_map_split_to_ptes() calls pagetable_alloc()
>>> while spliting block entry to ptes and __kpti_install_ng_mappings()
>>> calls __get_free_pages() to create kpti pagetable.
>>>
>>> Under PREEMPT_RT, calling pagetable_alloc() with
>>> preemption disabled is not allowed, because it may acquire
>>> a spin lock that becomes sleepable on RT, potentially
>>> causing a sleep during page allocation.
>>>
>>> Since above two functions is called as callback of stop_machine()
>>> where its callback is called in preemption disabled,
>>> They could make a potential problem. (sleeping in preemption disabled).
>>>
>>> To address this, introduce pagetable_alloc_nolock() API.
>>
>> I don't really understand what the problem is that you're trying to fix. As I
>> see it, there are 2 call sites in arm64 arch code that are calling into the page
>> allocator from stop_machine() - one via via pagetable_alloc() and another via
>> __get_free_pages(). But both of those calls are passing in GFP_ATOMIC. It was my
>> understanding that the page allocator would ensure it never sleeps when
>> GFP_ATOMIC is passed in, (even for PREEMPT_RT)?
> 
> Although GFP_ATOMIC is specify, it only affects of "water mark" of the
> page with __GFP_HIGH. and to get a page, it must grab the lock --
> zone->lock or pcp_lock in the rmqueue().
> 
> This zone->lock and pcp_lock is spin_lock and it's a sleepable in
> PREEMPT_RT that's why the memory allocation/free using general API
> except nolock() version couldn't be called since
> if "contention" happens they'll sleep while waiting to get the lock.
> 
> The reason why "nolock()" can use, it always uses "trylock" with
> ALLOC_TRYLOCK flags. otherwise GFP_ATOMIC also can be sleepable in
> PREEMPT_RT.
> 
>>
>> What is the actual symptom you are seeing?
> 
> Since the place where called while smp_cpus_done() and there seems no
> contention, there seems no problem. However as I mention in another
> thread
> (https://lore.kernel.org/all/aT%2FdrjN1BkvyAGoi@e129823.arm.com/),
> This gives a the false impression --
> GFP_ATOMIC are “safe to use in preemption disabled”
> even though they are not in PREEMPT_RT case, I've changed it.
> 
>>
>> If the page allocator is somehow ignoring the GFP_ATOMIC request for PREEMPT_RT,
>> then isn't that a bug in the page allocator? I'm not sure why you would change
>> the callsites? Can't you just change the page allocator based on GFP_ATOMIC?
> 
> It doesn't ignore the GFP_ATOMIC feature:
>   - __GFP_HIGH: use water mark till min reserved
>   - __GFP_KSWAPD_RECLAIM: wake up kswapd if reclaim required.
> 
> But, it's a restriction -- "page allocation / free" API cannot be called
> in preempt-disabled context at PREEMPT_RT.
> 
> That's why I think it's wrong usage not a page allocator bug.

I've taken a look at this and I agree with your analysis. Thanks for explaining.

Looking at other stop_machine() callbacks, there are some that call printk() and
I would assume that spinlocks could be taken there which may present the same
kind of issue or PREEMPT_RT? (I'm guessing). I don't see any others that attempt
to allocate memory though.

Anyway, to fix the 2 arm64 callsites, I see 2 possible approaches:

- Call the nolock variant (as you are doing). But that would just convert a
deadlock to a panic; if the lock is held when stop_machine() runs, without your
change, we now have a deadlock due to waiting on the lock inside stop_machine().
With your change, we notice the lock is already taken and panic. I guess it is
marginally better, but not by much. Certainly I would just _always_ call the
nolock variant regardless of PREEMPT_RT if we take this route; For !PREEMPT_RT,
the lock is guarranteed to be free so nolock will always succeed.

- Preallocate the memory before entering stop_machine(). I think this would be
much more robust. For kpti_install_ng_mappings() I think you could hoist the
allocation/free out of stop_machine() and pass the pointer in pretty easily. For
linear_map_split_to_ptes() its a bit more complex; Perhaps, we need to walk the
pgtable to figure out how much to preallocate, allocate it, then set it up as a
special allocator, wrapped by an allocation function and modify the callchain to
take a callback function instead of gfp flags.

What do you think?

Thanks,
Ryan

> 
> [...]
> 
> --
> Sincerely,
> Yeoreum Yun


