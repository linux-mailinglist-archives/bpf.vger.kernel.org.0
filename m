Return-Path: <bpf+bounces-75644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948EDC8EB24
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 15:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4453A3C4E
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AE3233735;
	Thu, 27 Nov 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9+qCK+M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4A224AF1;
	Thu, 27 Nov 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252062; cv=none; b=dKSk3IFvxD2c1/RfF9NrjMl6ld1Yc5hjrMJB0hNqVmwodbkIfjLvlpzn65db/QZgmUk70rRZvxn2KWyVk09COh4qR+2TZBjVRuzJAdORvWmRfebyG27En5YpVT/vn4RHf03qUWWUFDFyOsd0xRkKpl1W6+N9E6vy7Qxh+9a83BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252062; c=relaxed/simple;
	bh=KGXUj1kvM6a58FkYMQl5WgaFk37luqe5xhEBKypDNK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8j4pSEVff5RyJKPnZirgL1Rhn60BL30dzyKoEMRahT3hVc9j6IyqYLkZy4paEyc4MkIe1bZK/NKD1itdrZOAsL8Y8DkwzZD20rmoLE/uNqelfTk7jcE8QsBUZFIcdN00M1AKTrDotlzhFxVdik5SAWOCeqBrlI+0s0qJc00ptY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9+qCK+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5D5C4CEF8;
	Thu, 27 Nov 2025 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764252060;
	bh=KGXUj1kvM6a58FkYMQl5WgaFk37luqe5xhEBKypDNK4=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B9+qCK+MNe+2KUOE8MINX7ThiGv1jHBXwcjX5cLuQaHUqLohoo/ckM9GucUJ6fnG3
	 Hva2ByD25h2xXX2VXzW1CntAG7HgJI6JzLKpME5iuHOp1Uei6BO8nRo8zgbu+VeYal
	 dQU2fd/HuxTKr+GjMfTWVWSa1NPBBuJAB1Rz29jqt4OhJ1g3H/N/KXmgSYSiTKS4sh
	 n++bva0Xe9JVf7TFDpFpwOZ92RkabxIJA77dZ7f9rQkDSQjkeFDMXejcz6BkgkH8ri
	 SpoPnNduoCjfOiAugW1IytqTnL0q74RBYndotJscMNdgWx/28oqHRkWyQFdGuZDlN3
	 zWbdCwMLa18Sg==
Message-ID: <1c34bf75-0ea3-490d-b412-288c7452904e@kernel.org>
Date: Thu, 27 Nov 2025 15:00:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu()
 operations
To: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-modules@vger.kernel.org,
 bpf@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>
 <0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org> <aQge2rmgRvd1JKxc@harry>
 <1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/11/2025 12.25, Vlastimil Babka wrote:
> On 11/3/25 04:17, Harry Yoo wrote:
>> On Fri, Oct 31, 2025 at 10:32:54PM +0100, Daniel Gomez wrote:
>>>
>>>
>>> On 10/09/2025 10.01, Vlastimil Babka wrote:
>>>> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
>>>> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
>>>> addition to main and spare sheaves.
>>>>
>>>> kfree_rcu() operations will try to put objects on this sheaf. Once full,
>>>> the sheaf is detached and submitted to call_rcu() with a handler that
>>>> will try to put it in the barn, or flush to slab pages using bulk free,
>>>> when the barn is full. Then a new empty sheaf must be obtained to put
>>>> more objects there.
>>>>
>>>> It's possible that no free sheaves are available to use for a new
>>>> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
>>>> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
>>>> kfree_rcu() implementation.
>>>>
>>>> Expected advantages:
>>>> - batching the kfree_rcu() operations, that could eventually replace the
>>>>   existing batching
>>>> - sheaves can be reused for allocations via barn instead of being
>>>>   flushed to slabs, which is more efficient
>>>>   - this includes cases where only some cpus are allowed to process rcu
>>>>     callbacks (Android)
>>>>
>>>> Possible disadvantage:
>>>> - objects might be waiting for more than their grace period (it is
>>>>   determined by the last object freed into the sheaf), increasing memory
>>>>   usage - but the existing batching does that too.
>>>>
>>>> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
>>>> implementation favors smaller memory footprint over performance.
>>>>
>>>> Also for now skip the usage of rcu sheaf for CONFIG_PREEMPT_RT as the
>>>> contexts where kfree_rcu() is called might not be compatible with taking
>>>> a barn spinlock or a GFP_NOWAIT allocation of a new sheaf taking a
>>>> spinlock - the current kfree_rcu() implementation avoids doing that.
>>>>
>>>> Teach kvfree_rcu_barrier() to flush all rcu_free sheaves from all caches
>>>> that have them. This is not a cheap operation, but the barrier usage is
>>>> rare - currently kmem_cache_destroy() or on module unload.
>>>>
>>>> Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
>>>> count how many kfree_rcu() used the rcu_free sheaf successfully and how
>>>> many had to fall back to the existing implementation.
>>>>
>>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>>
>>> Hi Vlastimil,
>>>
>>> This patch increases kmod selftest (stress module loader) runtime by about
>>> ~50-60%, from ~200s to ~300s total execution time. My tested kernel has
>>> CONFIG_KVFREE_RCU_BATCHED enabled. Any idea or suggestions on what might be
>>> causing this, or how to address it?
>>
>> This is likely due to increased kvfree_rcu_barrier() during module unload.
> 
> Hm so there are actually two possible sources of this. One is that the
> module creates some kmem_cache and calls kmem_cache_destroy() on it before
> unloading. That does kvfree_rcu_barrier() which iterates all caches via
> flush_all_rcu_sheaves(), but in this case it shouldn't need to - we could
> have a weaker form of kvfree_rcu_barrier() that only guarantees flushing of
> that single cache.

Thanks for the feedback. And thanks to Jon who has revived this again.

> 
> The other source is codetag_unload_module(), and I'm afraid it's this one as
> it's hooked to evey module unload. Do you have CONFIG_CODE_TAGGING enabled?

Yes, we do have that enabled.

> Disabling it should help in this case, if you don't need memory allocation
> profiling for that stress test. I think there's some space for improvement -
> when compiled in but memalloc profiling never enabled during the uptime,
> this could probably be skipped? Suren?
> 
>> It currently iterates over all CPUs x slab caches (that enabled sheaves,
>> there should be only a few now) pair to make sure rcu sheaf is flushed
>> by the time kvfree_rcu_barrier() returns.
> 
> Yeah, also it's done under slab_mutex. Is the stress test trying to unload
> multiple modules in parallel? That would make things worse, although I'd
> expect there's a lot serialization in this area already.

AFAIK, the kmod stress test does not unload modules in parallel. Module unload
happens one at a time before each test iteration. However, test 0008 and 0009
run 300 total sequential module unloads.

ALL_TESTS="$ALL_TESTS 0008:150:1"
ALL_TESTS="$ALL_TESTS 0009:150:1"

> 
> Unfortunately it will get worse with sheaves extended to all caches. We
> could probably mark caches once they allocate their first rcu_free sheaf
> (should not add visible overhead) and keep skipping those that never did.
>> Just being curious, do you have any serious workload that depends on
>> the performance of module unload?

Can we have a combination of a weaker form of kvfree_rcu_barrier() + tracking?
Happy to test this again if you have a patch or something in mind.

In addition and AFAIK, module unloading is similar to ebpf programs. Ccing bpf
folks in case they have a workload.

But I don't have a particular workload in mind.

