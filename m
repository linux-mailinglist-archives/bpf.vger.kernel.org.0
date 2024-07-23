Return-Path: <bpf+bounces-35389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 264E793A125
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 15:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDE6283C57
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D681534EF;
	Tue, 23 Jul 2024 13:17:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA1314E2D0;
	Tue, 23 Jul 2024 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740634; cv=none; b=O06QllAhSmxPrlBE+wjfaEpHDC8FTRjofqZS0H2gsJOiJCc8KNl0xJdbbVnaO1ijLekEQO9i9kH1EUHwsCAKme8L2uaLg5KVYggP8SQO29ebv7oZZLHdoDQyNJR3X+9Sh5U2vJxP3w6Jx/sNwZ0kBbHzwvd8c5ZXzHdBI2tHCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740634; c=relaxed/simple;
	bh=8x0BMzASdj/3prOMIv75Km1kQh7FEY3pTpL8LPOaeHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L/pAkWAsLjuNIVVPCvlnuIdgcZNJt/95rK+Hd4XJvgyFYoibgrBhnGJzlH1x6s5/7tM5/CW2SN5xIyzBukil+243tBe6G0m0Qz2zCXNAho4LAdZ3RsE0ys2WIo+yhsVBzjHyDldvN0+KoogHRUTD6kSnYmF5hMbz/a0bZcg1sNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WSyHm3TBtzQmnM;
	Tue, 23 Jul 2024 21:12:52 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B2EFF14011D;
	Tue, 23 Jul 2024 21:17:02 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Jul 2024 21:17:02 +0800
Message-ID: <d59e79c7-19d2-4252-b695-107bb501b055@huawei.com>
Date: Tue, 23 Jul 2024 21:17:02 +0800
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
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
 <CAKgT0UcGvrS7=r0OCGZipzBv8RuwYtRwb2QDXqiF4qW5CNws4g@mail.gmail.com>
 <b2001dba-a2d2-4b49-bc9f-59e175e7bba1@huawei.com>
 <CAKgT0UdhO+DJKzwyzqvo7npQcgE3ZXSognnv0RhKyF9AjMUc1g@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UdhO+DJKzwyzqvo7npQcgE3ZXSognnv0RhKyF9AjMUc1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

+cc Andrew Morton

On 2024/7/22 23:21, Alexander Duyck wrote:
> On Mon, Jul 22, 2024 at 5:41 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/7/22 7:49, Alexander Duyck wrote:
>>> On Fri, Jul 19, 2024 at 2:36 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>>
>>>> After [1], there are still two implementations for page frag:
>>>>
>>>> 1. mm/page_alloc.c: net stack seems to be using it in the
>>>>    rx part with 'struct page_frag_cache' and the main API
>>>>    being page_frag_alloc_align().
>>>> 2. net/core/sock.c: net stack seems to be using it in the
>>>>    tx part with 'struct page_frag' and the main API being
>>>>    skb_page_frag_refill().
>>>>
>>>> This patchset tries to unfiy the page frag implementation
>>>> by replacing page_frag with page_frag_cache for sk_page_frag()
>>>> first. net_high_order_alloc_disable_key for the implementation
>>>> in net/core/sock.c doesn't seems matter that much now as pcp
>>>> is also supported for high-order pages:
>>>> commit 44042b449872 ("mm/page_alloc: allow high-order pages to
>>>> be stored on the per-cpu lists")
>>>>
>>>> As the related change is mostly related to networking, so
>>>> targeting the net-next. And will try to replace the rest
>>>> of page_frag in the follow patchset.
>>>
>>> So in reality I would say something like the first 4 patches are
>>> probably more applicable to mm than they are to the net-next tree.
>>> Especially given that we are having to deal with the mm_task_types.h
>>> in order to sort out the include order issues.
>>>
>>> Given that I think it might make more sense to look at breaking this
>>> into 2 or more patch sets with the first being more mm focused since
>>> the test module and pulling the code out of page_alloc.c, gfp.h, and
>>> mm_types.h would be pretty impactful on mm more than it is on the
>>> networking stack. After those changes then I would agree that we are
>>> mostly just impacting the network stack.
>>
>> I am sure there are plenty of good precedents about how to handling a
>> patchset that affecting multi subsystems.
>> Let's be more specific about what are the options here:
>> 1. Keeping all changing as one patchset targetting the net-next tree
>>    as this version does.
>> 2. Breaking all changing into two patchsets, the one affecting current APIs
>>    targetting the mm tree and the one supporting new APIs targetting
>>    net-next tree.
>> 3. Breaking all changing into two patchset as option 2 does, but both patchsets
>>    targetting net-next tree to aovid waiting for the changing in mm tree
>>    to merged back to net-next tree for adding supporting of new APIs.
>>
>> I am not sure your perference is option 2 or option 3 here, or there are others
>> options here, it would be better to be more specific about your option here. As
>> option 2 doesn't seems to make much sense if all the existing users/callers of
>> page_frag seems to be belonged to networking for testing reasons, and the original
>> code seemed to go through net-next tree too:
>> https://github.com/torvalds/linux/commit/b63ae8ca096dfdbfeef6a209c30a93a966518853
> 
> I am suggesting option 2. The main issue is that this patch set has
> had a number of issues that fall into the realm of mm more than
> netdev. The issue is that I only have a limited amount of time for
> review and I feel like having this be reviewed as a submission for mm
> would bring in more people familiar with that side of things to review
> it.

I am agreed with the 'bring in more people familiar with that side of things
to review it' part, but I am just not sure about your asking for option 2 is
reasonable or fair enough ask, as breaking this patchset into two patchsets
may make it harder to discuss the reason behind the refactoring affecting the
current APIs, and may make the reviewing harder too.

It seems we might need to consider option 4 too:
4. Keeping all changing as one patchset targetting the mm tree.

One of the problem I see with option 4 is that it makes it harder to use CI
from netdev.

> 
> As it stands, trying to submit this through netdev is eating up a
> significant amount of my time as there aren't many people on the
> netdev side of things that can review the mm bits. If you insist on
> this needing to go through net-next my inclination would be to just
> reject the set as it is bound to introduce a number of issues due to
> the sheer size of the refactor and the fact that it is providing
> little if any benefit.
> 
>> And the main reason I chose option 1 over option 2 is: it is hard to tell how
>> much changing needed to support the new usecase, so it is better to keep them
>> in one patchset to have a bigger picture here. Yes, it may make the patchset
>> harder to review, but that is the tradeoff we need to make here. As my
>> understanding, option 1 seem to be the common practice to handle the changing
>> affecting multi subsystems. Especially you had similar doubt about the changing
>> affecting current APIs as below, it seems hard to explain it without a new case:
>>
>> https://lore.kernel.org/all/68d1c7d3dfcd780fa3bed0bb71e41d7fb0a8c15d.camel@gmail.com/
> 
> The issue as I see it is that you aren't getting any engagement from
> the folks on the mm side. In fact from what I can tell it looks like
> you didn't even CC this patch set to them. The patches I called out

Below is the gitconfig and cmd used to send the patchset, I am not sure
if there is someone specifically that is your mind that need CC'ing, as
the maillist for mm subsystem seems to be cc'ed for each mm focused patch
you mentioned, and Andrew Morton is CC'ed most of the mm focused patch too.

[sendemail.netdev]
        to = "davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com"
        cc = "netdev@vger.kernel.org, linux-kernel@vger.kernel.org"
        cccmd ="/home/*/net-next/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats"

git send-email --identity=netdev

> below are very memory subsystem centric. I would say this patchset has
> no way forward if the patches I called out below aren't reviewed by
> folks from the memory subsystem maintainers.

Andrew Morton is the maintainer of mm subsystem according to MAINTAINERS file,
Let's see if we can have some feedback about what is prefer option for him
to handling this patchset by CC'ing him.

> 
>>>
>>
>> ...
>>
>>>
>>> So specifically I would like to see patches 1 (refactored as
>>> selftest), 2, 3, 5, 7, 8, 13 (current APIs), and 14 done as more of an
>>> mm focused set since many of the issues you seem to have are problems
>>> building due to mm build issues, dependencies, and the like. That is
>>> the foundation for this patch set and it seems like we keep seeing
>>> issues there so that needs to be solid before we can do the new API
>>> work. If focused on mm you might get more eyes on it as not many
>>> networking folks are that familiar with the memory management side of
>>> things.
>>
>> I am not sure if breaking it into more patchset is the common practice
>> to 'get more eyes' here.
>> Anyways, it is fair enough ask if there is more concrete reasoning
>> behind the asking and it is common practice to do that, and I would
>> love to break it to more patchsets to perhaps make the discussion
>> easier.
> 
> The issue here is that this patchset is 2/3 memory subsystem, and you
> didn't seem to include anyone from the memory subsystem side of things
> on the Cc list.

I am not familiar enough with mm subsystem yet, so I depended on the
get_maintainer.pl to sort out the CC list. If there is a CC list in your
mind, please give a list, and I would be very graceful and happy to include
them in the next version.

> 
>>>
>>> As for the other patches, specifically 10, 11, 12, and 13 (prepare,
>>> probe, commit API), they could then be spun up as a netdev centered
>>> set. I took a brief look at them but they need some serious refactor
>>> as I think they are providing page as a return value in several cases
>>> where they don't need to.
>>
>> The above is one of the reason I am not willing to do the spliting.
>> It is hard for someone to tell if the refactoring affecting current APIs
>> will be enough for the new usecase without supporting the new usecase,
>> isn't it possible that some refactoring may be proved to be unnecessary
>> or wrong?
>>
>> It would be better to be more specific about what do you mean by
>> 'they are providing page as a return value in several cases where they
>> don't need to' as above.
> 
> This patchset isn't moving forward in its current state. Part of the
> issue is that it is kind of an unwieldy mess and has been difficult to
> review due to things like refactoring code you had already refactored.
> Ideally each change should be self contained and you shouldn't have to
> change things more than once. That is why I have suggested splitting
> things the way I did. It would give you a logical set where you do the
> initial refactor to enable your changes, and then you make those
> changes. It is not uncommon to see this done within the kernel
> community. For example if I recall correctly the folio changes when in
> as a few patch sets in order to take care of the necessary enabling
> and then enable their use in the various subsystems.

The first folio changes did seem come with use case for it as below"
"  This converts just parts of the core MM and the page cache. For 5.17,
  we intend to convert various filesystems (XFS and AFS are ready; other
  filesystems may make it) and also convert more of the MM and page
  cache to folios. For 5.18, multi-page folios should be ready."

It is just that the use case for folio happen to be in mm subsystem, but
it seems we can't do that for page_frag, as the current and future possible
usecases are mostly networking related, I suppose that is one of the reason
there are no much engagement from the mm side and I am suspecting there will
be not much engagement as we expected even if we target the mm tree.

https://github.com/torvalds/linux/commit/49f8275c7d92?spm=a2c65.11461447.0.0.68003853lUiVcA

> 
>>>
>>> In my opinion with a small bit of refactoring patch 4 can just be
>>> dropped. I don't think the renaming is necessary and it just adds
>>> noise to the commit logs for the impacted drivers. It will require
>>> tweaks to the other patches but I think it will be better that way in
>>> the long run.
>>
>> It would be better to be more specific about above too so that we don't
>> have to have more refactoring patchsets for the current APIs.
> 
> I provided the review feedback in the patch. Specifically, don't
> rename existing APIs. It would be better to just come up with an
> alternative scheme such as a double underscore that would represent
> the page based version while the regular version stays the same.

It seems you provided a similar feedback in v2, but we seems we need
three APIs for the different usecases at least from the allocation
side:

"Depending on different use cases, callers expecting to deal with va, page or
both va and page for them may call page_frag_alloc_va*, page_frag_alloc_pg*,
or page_frag_alloc* API accordingly."

https://lore.kernel.org/all/18ca19fa64267b84bee10473a81cbc63f53104a0.camel@gmail.com/

And yes, you suggested dropping it, but it does not make the disagreement
disapear, we still need to figure out a appropriate naming we are both ok
with the new APIs.

> 
>>>
>>> Looking at patch 6 I am left scratching my head and wondering if you
>>> have another build issue of some sort that you haven't mentioned. I
>>> really don't think it belongs in this patch set and should probably be
>>> a fix on its own if you have some reason to justify it. Otherwise you
>>> might also just look at refactoring it to take
>>> "__builtin_constant_p(size)" into account by copying/pasting the first
>>> bits from the generic version into the function since I am assuming
>>> there is a performance benefit to doing it in assembler. It should be
>>> a net win if you just add the accounting for constants.
>>
>> I am not sure if the commit log in patch 6 needs some rephasing to
>> answer your question above:
>> "As the get_order() implemented by xtensa supporting 'nsau'
>> instruction seems be the same as the generic implementation
>> in include/asm-generic/getorder.h when size is not a constant
>> value as the generic implementation calling the fls*() is also
>> utilizing the 'nsau' instruction for xtensa.
>>
>> So remove the get_order() implemented by xtensa, as using the
>> generic implementation may enable the compiler to do the
>> computing when size is a constant value instead of runtime
>> computing and enable the using of get_order() in BUILD_BUG_ON()
>> macro in next patch."
>>
>> See the below in the next patch, as the PAGE_FRAG_CACHE_MAX_ORDER
>> is using the get_order():
>> BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);
> 
> Are you saying that the compiler translates the get_order call into
> the nsau instruction? I'm still not entirely convinced and would
> really like to see a review by the maintainer for that architecture to
> be comfortable with it.

That patch does carry an Acked-by tag from Max Filippov, which is the
maintainer for xtensa architecture according to MAINTAINERS file:

https://lore.kernel.org/all/CAMo8BfJ5KwXjFDKGs2oBSTH1C7Vnnsbvcm6-qfV5gYh30+VvUQ@mail.gmail.com/

> 
> Otherwise as I said before my thought would be to simply copy over the
> bits for __builtin_constant_p from the generic version of get_order so
> that we don't run the risk of somehow messing up the non-constant
> case.
> 
>>>
>>> Patch 9 could probably be a standalone patch or included in the more
>>> mm centered set. However it would need to be redone to fix the
>>> underlying issue rather than working around it by changing the
>>> function called rather than fixing the function. No point in improving
>>> it for one case when you can cover multiple cases with a single
>>> change.
>>
>> Sure, it is just that there is only 24h a day for me to do things
>> more generically. So perhaps I should remove patch 9 for now so
>> that we can improve thing more generically.
> 
> I'm not sure what that is supposed to mean. The change I am suggesting
> is no bigger than what you have already done. It would just mean
> fixing the issue at the source instead of working around the issue.
> Taking that approach would yield a much better return than just doing
> the workaround.
> 
> I could make the same argument about reviewing this patch set. I feel
> like a I only have so much time in the day. I have already caught a

Yes, I think we need to consider thing from each other'prespection. We
can always slow thing down by sending a message to notify each other when
there are some busy days.

> few places where you were circumventing issues instead of addressing
> them such as using macros to cover up #include ordering issues
> resulting in static inline functions blowing up. It feels like
> labeling this as a networking patch set is an attempt to circumvent

Circumventing is always not my intention. In fact, I think it is better
to catch some mistake during review instead of having to debug in the
field and better idea may sometimes come out during discussion. As the
matter of fact, the idea of reusing the existing space to reduce the
size of 'page_frag_cache' came out during the discussion with you in
the 'remove page frag implementation in vhost_net' patchset.

> working with the mm tree by going in and touching as much networking
> code as you can to claim this is a networking patch when only 3
> patches(5, 10 and 12) really need to touch anything in networking.
> 
> I am asking you to consider my suggestions for your own benefit as
> otherwise I am pretty much the only reviewer for these patches and the

Thanks for the time and effort reviewing, but there are still other
reviewers, mainly Mat, Subbaraya and Max.

> fact is I am not a regular contributor within the mm subsystem myself.
> I would really like to have input from the mm subsystem maintainer on
> things like your first patch which is adding a new test module to the
> mm tree currently. I am assuming that they wouldn't want us to place
> the test module in there, but I could be wrong. That is why I am
> suggesting breaking this up and submitting the mm bits as more mm
> focused so that we can get that additional input.

