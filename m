Return-Path: <bpf+bounces-76719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE3ACC42A8
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73B313078A5D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 16:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACE1350D5D;
	Tue, 16 Dec 2025 15:11:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A59350D46;
	Tue, 16 Dec 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897883; cv=none; b=cT4NNsLhk8ZwKP09crHE+9f3m8r6IKQptcRGDH5tkyDamrWLyTtWeYYBpLcICcliMAlDXRmWBaSK2zqGuWZqTWPQYdio3k5+J70B7cX8qnUQeIsCP9GXYg6+pORkjWve+ew7TIpmu/zOUg40+XwfZc+Hl2GKIOpHo7sNi07E8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897883; c=relaxed/simple;
	bh=KhhJgJhJW0hZNvZ0BUVgdisR4C81vSTGkFkdwm1Ki/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mb74q4SctTLJwot/v0uAW1fisFdmpUZwWlTfPhBRvOHvBMLfB/fhdV1Ki0EaC6MhhKes/X9Pu1K69uxaeknvepwqkLZmfvQTEyWb/r59b491wHGOj+Ie5fBx2BLYm8DI14JFuet0Mv3QJGeYZAeaXPYbhW7wbJ8K4CAVLeHewIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312BAFEC;
	Tue, 16 Dec 2025 07:11:14 -0800 (PST)
Received: from [10.57.91.77] (unknown [10.57.91.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 241FA3F73B;
	Tue, 16 Dec 2025 07:11:14 -0800 (PST)
Message-ID: <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
Date: Tue, 16 Dec 2025 15:11:13 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] introduce pagetable_alloc_nolock()
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>, akpm@linux-foundation.org,
 david@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, catalin.marinas@arm.com,
 will@kernel.org, kevin.brodsky@arm.com, dev.jain@arm.com,
 yang@os.amperecomputing.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251212161832.2067134-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/2025 16:18, Yeoreum Yun wrote:
> Some architectures invoke pagetable_alloc() or __get_free_pages()
> with preemption disabled.
> For example, in arm64, linear_map_split_to_ptes() calls pagetable_alloc()
> while spliting block entry to ptes and __kpti_install_ng_mappings()
> calls __get_free_pages() to create kpti pagetable.
> 
> Under PREEMPT_RT, calling pagetable_alloc() with
> preemption disabled is not allowed, because it may acquire
> a spin lock that becomes sleepable on RT, potentially
> causing a sleep during page allocation.
> 
> Since above two functions is called as callback of stop_machine()
> where its callback is called in preemption disabled,
> They could make a potential problem. (sleeping in preemption disabled).
> 
> To address this, introduce pagetable_alloc_nolock() API.

I don't really understand what the problem is that you're trying to fix. As I
see it, there are 2 call sites in arm64 arch code that are calling into the page
allocator from stop_machine() - one via via pagetable_alloc() and another via
__get_free_pages(). But both of those calls are passing in GFP_ATOMIC. It was my
understanding that the page allocator would ensure it never sleeps when
GFP_ATOMIC is passed in, (even for PREEMPT_RT)?

What is the actual symptom you are seeing?

If the page allocator is somehow ignoring the GFP_ATOMIC request for PREEMPT_RT,
then isn't that a bug in the page allocator? I'm not sure why you would change
the callsites? Can't you just change the page allocator based on GFP_ATOMIC?

Thanks,
Ryan

> 
> Yeoreum Yun (2):
>   mm: introduce pagetable_alloc_nolock()
>   arm64: mmu: use pagetable_alloc_nolock() while stop_machine()
> 
>  arch/arm64/mm/mmu.c  | 23 ++++++++++++++++++-----
>  include/linux/mm.h   | 18 ++++++++++++++++++
>  kernel/bpf/stream.c  |  2 +-
>  kernel/bpf/syscall.c |  2 +-
>  mm/page_alloc.c      | 10 +++-------
>  5 files changed, 41 insertions(+), 14 deletions(-)
> 
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 


