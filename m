Return-Path: <bpf+bounces-35226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E1938F33
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 14:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0CC281C8F
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 12:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3CC16D4E2;
	Mon, 22 Jul 2024 12:42:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113A6322E;
	Mon, 22 Jul 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652120; cv=none; b=HUjsTsVGkCDLHeHeffiq7TrWfEC69qhMEWNJ8csKvoRlwc2teKw1SErwhumR6kVTdlwWm3tQNA9qJCCNIoLlf54/n0hDU+nUo9il8mc8QQXwEAxkQY2lXsEQE3NPTArVhPvbqupphwwcwsgHtwujySNU9GtI8mN/7mIto8Q1Aaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652120; c=relaxed/simple;
	bh=BgTHV7f7uopEBd1ylKIhwkxnAdoM0WKrrdM4R87NDxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T7gp3EDrnGvoDM4kTaasa05cU02IX9YnBtQtPq70xeN2xqsAoyS3a6RP7TLBKBLCATg8B2Sy/parNhJMIFJOJuMyu79+qKh4qkOQgQwjasOn/waFdzhchzzoqu/dDt9trQ7XRYPJZOGWKZAu42dtTvdHUgbYlGfOYjK8rrnh1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WSKXm07sdzxTln;
	Mon, 22 Jul 2024 20:36:56 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A3AFB140414;
	Mon, 22 Jul 2024 20:41:54 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Jul 2024 20:41:54 +0800
Message-ID: <b2001dba-a2d2-4b49-bc9f-59e175e7bba1@huawei.com>
Date: Mon, 22 Jul 2024 20:41:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v11 00/14] Replace page_frag with page_frag_cache for
 sk_page_frag()
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
 <CAKgT0UcGvrS7=r0OCGZipzBv8RuwYtRwb2QDXqiF4qW5CNws4g@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UcGvrS7=r0OCGZipzBv8RuwYtRwb2QDXqiF4qW5CNws4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/22 7:49, Alexander Duyck wrote:
> On Fri, Jul 19, 2024 at 2:36 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> After [1], there are still two implementations for page frag:
>>
>> 1. mm/page_alloc.c: net stack seems to be using it in the
>>    rx part with 'struct page_frag_cache' and the main API
>>    being page_frag_alloc_align().
>> 2. net/core/sock.c: net stack seems to be using it in the
>>    tx part with 'struct page_frag' and the main API being
>>    skb_page_frag_refill().
>>
>> This patchset tries to unfiy the page frag implementation
>> by replacing page_frag with page_frag_cache for sk_page_frag()
>> first. net_high_order_alloc_disable_key for the implementation
>> in net/core/sock.c doesn't seems matter that much now as pcp
>> is also supported for high-order pages:
>> commit 44042b449872 ("mm/page_alloc: allow high-order pages to
>> be stored on the per-cpu lists")
>>
>> As the related change is mostly related to networking, so
>> targeting the net-next. And will try to replace the rest
>> of page_frag in the follow patchset.
> 
> So in reality I would say something like the first 4 patches are
> probably more applicable to mm than they are to the net-next tree.
> Especially given that we are having to deal with the mm_task_types.h
> in order to sort out the include order issues.
> 
> Given that I think it might make more sense to look at breaking this
> into 2 or more patch sets with the first being more mm focused since
> the test module and pulling the code out of page_alloc.c, gfp.h, and
> mm_types.h would be pretty impactful on mm more than it is on the
> networking stack. After those changes then I would agree that we are
> mostly just impacting the network stack.

I am sure there are plenty of good precedents about how to handling a
patchset that affecting multi subsystems.
Let's be more specific about what are the options here:
1. Keeping all changing as one patchset targetting the net-next tree
   as this version does.
2. Breaking all changing into two patchsets, the one affecting current APIs
   targetting the mm tree and the one supporting new APIs targetting
   net-next tree.
3. Breaking all changing into two patchset as option 2 does, but both patchsets
   targetting net-next tree to aovid waiting for the changing in mm tree
   to merged back to net-next tree for adding supporting of new APIs.

I am not sure your perference is option 2 or option 3 here, or there are others
options here, it would be better to be more specific about your option here. As
option 2 doesn't seems to make much sense if all the existing users/callers of
page_frag seems to be belonged to networking for testing reasons, and the original
code seemed to go through net-next tree too:
https://github.com/torvalds/linux/commit/b63ae8ca096dfdbfeef6a209c30a93a966518853

And the main reason I chose option 1 over option 2 is: it is hard to tell how
much changing needed to support the new usecase, so it is better to keep them
in one patchset to have a bigger picture here. Yes, it may make the patchset
harder to review, but that is the tradeoff we need to make here. As my
understanding, option 1 seem to be the common practice to handle the changing
affecting multi subsystems. Especially you had similar doubt about the changing
affecting current APIs as below, it seems hard to explain it without a new case:

https://lore.kernel.org/all/68d1c7d3dfcd780fa3bed0bb71e41d7fb0a8c15d.camel@gmail.com/

> 

...

> 
> So specifically I would like to see patches 1 (refactored as
> selftest), 2, 3, 5, 7, 8, 13 (current APIs), and 14 done as more of an
> mm focused set since many of the issues you seem to have are problems
> building due to mm build issues, dependencies, and the like. That is
> the foundation for this patch set and it seems like we keep seeing
> issues there so that needs to be solid before we can do the new API
> work. If focused on mm you might get more eyes on it as not many
> networking folks are that familiar with the memory management side of
> things.

I am not sure if breaking it into more patchset is the common practice
to 'get more eyes' here.
Anyways, it is fair enough ask if there is more concrete reasoning
behind the asking and it is common practice to do that, and I would
love to break it to more patchsets to perhaps make the discussion
easier.

> 
> As for the other patches, specifically 10, 11, 12, and 13 (prepare,
> probe, commit API), they could then be spun up as a netdev centered
> set. I took a brief look at them but they need some serious refactor
> as I think they are providing page as a return value in several cases
> where they don't need to.

The above is one of the reason I am not willing to do the spliting.
It is hard for someone to tell if the refactoring affecting current APIs
will be enough for the new usecase without supporting the new usecase,
isn't it possible that some refactoring may be proved to be unnecessary
or wrong?

It would be better to be more specific about what do you mean by
'they are providing page as a return value in several cases where they
don't need to' as above.

> 
> In my opinion with a small bit of refactoring patch 4 can just be
> dropped. I don't think the renaming is necessary and it just adds
> noise to the commit logs for the impacted drivers. It will require
> tweaks to the other patches but I think it will be better that way in
> the long run.

It would be better to be more specific about above too so that we don't
have to have more refactoring patchsets for the current APIs.

> 
> Looking at patch 6 I am left scratching my head and wondering if you
> have another build issue of some sort that you haven't mentioned. I
> really don't think it belongs in this patch set and should probably be
> a fix on its own if you have some reason to justify it. Otherwise you
> might also just look at refactoring it to take
> "__builtin_constant_p(size)" into account by copying/pasting the first
> bits from the generic version into the function since I am assuming
> there is a performance benefit to doing it in assembler. It should be
> a net win if you just add the accounting for constants.

I am not sure if the commit log in patch 6 needs some rephasing to
answer your question above:
"As the get_order() implemented by xtensa supporting 'nsau'
instruction seems be the same as the generic implementation
in include/asm-generic/getorder.h when size is not a constant
value as the generic implementation calling the fls*() is also
utilizing the 'nsau' instruction for xtensa.

So remove the get_order() implemented by xtensa, as using the
generic implementation may enable the compiler to do the
computing when size is a constant value instead of runtime
computing and enable the using of get_order() in BUILD_BUG_ON()
macro in next patch."

See the below in the next patch, as the PAGE_FRAG_CACHE_MAX_ORDER
is using the get_order():
BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);

> 
> Patch 9 could probably be a standalone patch or included in the more
> mm centered set. However it would need to be redone to fix the
> underlying issue rather than working around it by changing the
> function called rather than fixing the function. No point in improving
> it for one case when you can cover multiple cases with a single
> change.

Sure, it is just that there is only 24h a day for me to do things
more generically. So perhaps I should remove patch 9 for now so
that we can improve thing more generically.

