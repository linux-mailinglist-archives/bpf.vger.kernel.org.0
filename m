Return-Path: <bpf+bounces-26409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C178B89F180
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 13:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BA11F2154D
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 11:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47CE15ADBE;
	Wed, 10 Apr 2024 11:55:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D70157E9B;
	Wed, 10 Apr 2024 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750136; cv=none; b=c78b9EGVl7ZkuEblDVuetR8oEr8GudgHgIKOSvx+Fap5Ll43V0scRg4ArxeqYYHTvYEqCeQngV4b4xqbe7gGA6G4R7tH+GqWkKjailu27oMrOGIxmFU941WQty14PUqKK2CP5J431YZM2HP63hoJY3YzCkE3d2OizfeZ69nMxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750136; c=relaxed/simple;
	bh=QbFSrD46MpVlaF30cGhGFPmgcZzJioQRrMxpFuR7I9U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=umxKbYol+0YoqdYAus23NzkjvhPt+LHDRxTcE3jVM99gzLhoyT4cUy5zWauUIsmZWdmUF4DKzovonfQT3O+YWNtyOtQLwAndQ1vYq2xG6HkNqt4kKMuyfPIparZNH6BBgz4+xoCFpddK6/uyUz6kDP/hMbIKgWKrOvHpbh1VNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VF1RM0QQRz1R5SN;
	Wed, 10 Apr 2024 19:52:47 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 642C114037D;
	Wed, 10 Apr 2024 19:55:30 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 19:55:30 +0800
Subject: Re: [PATCH net-next v1 00/12] First try to replace page_frag with
 page_frag_cache
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<bpf@vger.kernel.org>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <CAKgT0Uex+e_g9nyqk6DiB03U4zs_A1z2LoztHnpYbJ9LPm=NFA@mail.gmail.com>
 <05c21500-033b-dfee-6aa7-1ee967616213@huawei.com>
 <CAKgT0UdjBXguCudxM9-tzKx2qWYg18xp5cG2xaeY893rVbw5qQ@mail.gmail.com>
 <e3e3ad18-8ed0-4bd3-8126-2f60e8d3ae28@huawei.com>
 <CAKgT0UdvvwG7-tJLKcH2CZDAtObUbP2KHGaRo+setcq=Q26ieA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <d30f837b-67ba-5ddb-bd2c-ad6b443a4b9e@huawei.com>
Date: Wed, 10 Apr 2024 19:55:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdvvwG7-tJLKcH2CZDAtObUbP2KHGaRo+setcq=Q26ieA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/9 23:29, Alexander Duyck wrote:
...

> 
> Well the socket code will be largely impacted by any changes to this.
> Seems like it might make sense to think about coming up with a socket
> based test for example that might make good use of the allocator
> located there so we can test the consolidating of the page frag code
> out of there.

Does it make sense to use netcat + dummy netdev to test the socket code?
Any better idea in mind?

> 
>>>
>>>>> What is meant to be the benefit to the community for adding this? All
>>>>> I am seeing is a ton of extra code to have to review as this
>>>>> unification is adding an additional 1000+ lines without a good
>>>>> explanation as to why they are needed.
>>>>
>>>> Some benefits I see for now:
>>>> 1. Improve the maintainability of page frag's implementation:
>>>>    (1) future bugfix and performance can be done in one place.
>>>>        For example, we may able to save some space for the
>>>>        'page_frag_cache' API user, and avoid 'get_page()' for
>>>>        the old 'page_frag' API user.
>>>
>>> The problem as I see it is it is consolidating all the consumers down
>>> to the least common denominator in terms of performance. You have
>>> already demonstrated that with patch 2 which enforces that all drivers
>>> have to work from the bottom up instead of being able to work top down
>>> in the page.
>>
>> I am agreed that consolidating 'the least common denominator' is what we
>> do when we design a subsystem/libary and sometimes we may need to have a
>> trade off between maintainability and perfromance.
>>
>> But your argument 'having to load two registers with the values and then
>> compare them which saves us a few cycles' in [1] does not seems to justify
>> that we need to have it's own implementation of page_frag, not to mention
>> the 'work top down' way has its own disadvantages as mentioned in patch 2.
>>
>> Also, in patch 5 & 6, we need to load 'size' to a register anyway so that we
>> can remove 'pagecnt_bias' and 'pfmemalloc' from 'struct page_frag_cache', it
>> would be better you can work through the whole patchset to get a bigger picture.
>>
>> 1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com/
> 
> I haven't had a chance to review the entire patch set yet. I am hoping
> to get to it tomorrow. That said, my main concern is that this becomes
> a slippery slope. Where one thing leads to another and eventually this
> becomes some overgrown setup that is no longer performant and has
> people migrating back to the slab cache.

The problem with slab cache is that it does not have a metadata that
we can take extra reference to it, right?

> 
>>>
>>> This eventually leads you down the path where every time somebody has
>>> a use case for it that may not be optimal for others it is going to be
>>> a fight to see if the new use case can degrade the performance of the
>>> other use cases.
>>
>> I think it is always better to have a disscusion[or 'fight'] about how to
>> support a new use case:
>> 1. refoctor the existing implementation to support the new use case, and
>>    introduce a new API for it if have to.
>> 2. if the above does not work, and the use case is important enough that
>>    we might create/design a subsystem/libary for it.
>>
>> But from updating page_frag API, I do not see that we need the second
>> option yet.
> 
> That is why we are having this discussion right now though. It seems
> like you have your own use case that you want to use this for. So as a
> result you are refactoring all the existing implementations and
> crafting them to support your use case while trying to avoid
> introducing regressions in the others. I would argue that based on
> this set you are already trying to take the existing code and create a
> "new" subsystem/library from it that is based on the original code
> with only a few tweaks.

Yes, in someway. Maybe the plan is something like taking the best out
of all the existing implementations and form a "new" subsystem/library.

> 
>>>
>>>>    (2) Provide a proper API so that caller does not need to access
>>>>        internal data field. Exposing the internal data field may
>>>>        enable the caller to do some unexpcted implementation of
>>>>        its own like below, after this patchset the API user is not
>>>>        supposed to do access the data field of 'page_frag_cache'
>>>>        directly[Currently it is still acessable from API caller if
>>>>        the caller is not following the rule, I am not sure how to
>>>>        limit the access without any performance impact yet].
>>>> https://elixir.bootlin.com/linux/v6.9-rc3/source/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c#L1141
>>>
>>> This just makes the issue I point out in 1 even worse. The problem is
>>> this code has to be used at the very lowest of levels and is as
>>> tightly optimized as it is since it is called at least once per packet
>>> in the case of networking. Networking that is still getting faster
>>> mind you and demanding even fewer cycles per packet to try and keep
>>> up. I just see this change as taking us in the wrong direction.
>>
>> Yes, I am agreed with your point about 'demanding even fewer cycles per
>> packet', but not so with 'tightly optimized'.
>>
>> 'tightly optimized' may mean everybody inventing their own wheels.
> 
> I hate to break this to you but that is the nature of things. If you
> want to perform with decent performance you can only be so abstracted
> away from the underlying implementation. The more generic you go the
> less performance you will get.

But we need to have a balance between performance and maintainability,
I think what we are arguing about is where the balance might be?

> 
>>>
>>>> 2. page_frag API may provide a central point for netwroking to allocate
>>>>    memory instead of calling page allocator directly in the future, so
>>>>    that we can decouple 'struct page' from networking.
>>>
>>> I hope not. The fact is the page allocator serves a very specific
>>> purpose, and the page frag API was meant to serve a different one and
>>> not be a replacement for it. One thing that has really irked me is the
>>> fact that I have seen it abused as much as it has been where people
>>> seem to think it is just a page allocator when it was really meant to
>>> just provide a way to shard order 0 pages into sizes that are half a
>>> page or less in size. I really meant for it to be a quick-n-dirty slab
>>> allocator for sizes 2K or less where ideally we are working with
>>> powers of 2.
>>>
>>> It concerns me that you are talking about taking this down a path that
>>> will likely lead to further misuse of the code as a backdoor way to
>>> allocate order 0 pages using this instead of just using the page
>>> allocator.
>>
>> Let's not get to a conclusion here and wait to see how thing evolve
>> in the future.
> 
> I still have an open mind, but this is a warning on where I will not
> let this go. This is *NOT* an alternative to the page allocator. If we
> need order 0 pages we should be allocating order 0 pages. Ideally this
> is just for cases where we need memory in sizes 2K or less.

If the whole folio plan works, the page allocator may return a single
pointer without the 'struct page' metadata for networking, I am not sure
if I am worrying too much here, but we might need to prepare for that.

> 
>>>
>>>>>
>>>>> Also I wouldn't bother mentioning the 0.5+% performance gain as a
>>>>> "bonus". Changes of that amount usually mean it is within the margin
>>>>> of error. At best it likely means you haven't introduced a noticeable
>>>>> regression.
>>>>
>>>> For micro-benchmark ko added in this patchset, performance gain seems quit
>>>> stable from testing in system without any other load.
>>>
>>> Again, that doesn't mean anything. It could just be that the code
>>> shifted somewhere due to all the code moved so a loop got more aligned
>>> than it was before. To give you an idea I have seen performance gains
>>> in the past from turning off Rx checksum for some workloads and that
>>> was simply due to the fact that the CPUs were staying awake longer
>>> instead of going into deep sleep states as such we could handle more
>>> packets per second even though we were using more cycles. Without
>>> significantly more context it is hard to say that the gain is anything
>>> real at all and a 0.5% gain is well within that margin of error.
>>
>> As vhost_net_test added in [2] is heavily invovled with tun and virtio
>> handling, the 0.5% gain does seems within that margin of error, there is
>> why I added a micro-benchmark specificly for page_frag in this patchset.
>>
>> It is tested five times, three times with this patchset and two times without
>> this patchset, the complete log is as below, even there is some noise, all
>> the result with this patchset is better than the result without this patchset:
> 
> The problem is the vhost_net_test is you optimizing the page fragment
> allocator for *YOUR* use case. I get that you want to show overall
> improvement but that doesn't. You need to provide it with context for
> the current users of the page fragment allocator in the form of
> something other than one synthetic benchmark.
> 
> I could do the same thing by by tweaking the stack and making it drop
> all network packets. The NICs would show a huge performance gain. It
> doesn't mean it is usable by anybody. A benchmark is worthless without
> the context about how it will impact other users.
> 
> Think about testing with real use cases for the areas that are already
> making use of the page frags rather than your new synthetic benchmark
> and the vhost case which you are optimizing for. Arguably this is why
> so many implementations go their own way. It is difficult to optimize
> for one use case without penalizing another and so the community needs
> to be wiling to make that trade-off.
> .
> 

