Return-Path: <bpf+bounces-26257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F90489D3A5
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42F81F225A7
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14427E0E8;
	Tue,  9 Apr 2024 07:59:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD87D3E8;
	Tue,  9 Apr 2024 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649575; cv=none; b=BcH4FHSYDAP2aDLLB5Ou0pnjO0QkKsHNqdTLSduYA6JvzUO0Wvv7VnVZODviM/FIjyVWNM+6fvvlzgvkjP4fp57RaD8qdHNaGzksATwkBw8jWdQwEH+FnPdypZz7UN0V2ydWSv5zmWgvDXihMcK9432BH9oYQmY12btCd8K1bkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649575; c=relaxed/simple;
	bh=pGrpGhF4OZnic13uk2B/nAUpYO45gRr1m6ALeHsP9/Y=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=s1FYQsdZsJukAttI1z7FaTxm2eOpZEnsJcyQQtcaMHRwTGeWJbYiJ2UwghDKOfxa+Ev9PAxWoTAouv+DDfzH4YZYQzoE3KjvCfQZRxPPdj4b3l4y0PnYTtyC7YoGoyqUsv6ukxwtNiFGC+iJdrzvcMIYPb8pyFYu4FOGSKEurJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VDJG2641gz1ym5t;
	Tue,  9 Apr 2024 15:57:14 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 5163F1A016C;
	Tue,  9 Apr 2024 15:59:29 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 9 Apr
 2024 15:59:29 +0800
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
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e3e3ad18-8ed0-4bd3-8126-2f60e8d3ae28@huawei.com>
Date: Tue, 9 Apr 2024 15:59:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdjBXguCudxM9-tzKx2qWYg18xp5cG2xaeY893rVbw5qQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/8 23:09, Alexander Duyck wrote:
> On Mon, Apr 8, 2024 at 6:38 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/4/8 1:02, Alexander Duyck wrote:
>>> On Sun, Apr 7, 2024 at 6:10 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>>
>>>> After [1], Only there are two implementations for page frag:
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
>>>> in net/core/sock.c doesn't seems matter that much now have
>>>> have pcp support for high-order pages in commit 44042b449872
>>>> ("mm/page_alloc: allow high-order pages to be stored on the
>>>> per-cpu lists").
>>>>
>>>> As the related change is mostly related to networking, so
>>>> targeting the net-next. And will try to replace the rest
>>>> of page_frag in the follow patchset.
>>>>
>>>> After this patchset, we are not only able to unify the page
>>>> frag implementation a little, but seems able to have about
>>>> 0.5+% performance boost testing by using the vhost_net_test
>>>> introduced in [1] and page_frag_test.ko introduced in this
>>>> patch.
>>>
>>> One question that jumps out at me for this is "why?". No offense but
>>> this is a pretty massive set of changes with over 1400 additions and
>>> 500+ deletions and I can't help but ask why, and this cover page
>>> doesn't give me any good reason to think about accepting this set.
>>
>> There are 375 + 256 additions for testing module and the documentation
>> update in the last two patches, and there is 198 additions and 176
>> deletions for moving the page fragment allocator from page_alloc into
>> its own file in patch 1.
>> Without above number, there are above 600+ additions and 300+ deletions,
>> deos that seems reasonable considering 140+ additions are needed to for
>> the new API, 300+ additions and deletions for updating the users to use
>> the new API as there are many users using the old API?
> 
> Maybe it would make more sense to break this into 2 sets. The first
> one adding your testing, and the second one consolidating the API.
> With that we would have a clearly defined test infrastructure in place
> for the second set which is making significant changes to the API. In
> addition it would provide the opportunity for others to point out any
> other test that they might want pulled in since this is likely to have
> impact outside of just the tests you have proposed.

Do you have someone might want pulled in some test in mind, if yes, then
it might make sense to work together to minimise some possible duplicated
work. If no, it does not make much sense to break this into 2 sets just to
introduce a testing in the first set.

If it helps you or someone to do the comparing test before and after patchset
easier, I would reorder the patch adding the micro-benchmark ko to the first
patch.

> 
>>> What is meant to be the benefit to the community for adding this? All
>>> I am seeing is a ton of extra code to have to review as this
>>> unification is adding an additional 1000+ lines without a good
>>> explanation as to why they are needed.
>>
>> Some benefits I see for now:
>> 1. Improve the maintainability of page frag's implementation:
>>    (1) future bugfix and performance can be done in one place.
>>        For example, we may able to save some space for the
>>        'page_frag_cache' API user, and avoid 'get_page()' for
>>        the old 'page_frag' API user.
> 
> The problem as I see it is it is consolidating all the consumers down
> to the least common denominator in terms of performance. You have
> already demonstrated that with patch 2 which enforces that all drivers
> have to work from the bottom up instead of being able to work top down
> in the page.

I am agreed that consolidating 'the least common denominator' is what we
do when we design a subsystem/libary and sometimes we may need to have a
trade off between maintainability and perfromance.

But your argument 'having to load two registers with the values and then
compare them which saves us a few cycles' in [1] does not seems to justify
that we need to have it's own implementation of page_frag, not to mention
the 'work top down' way has its own disadvantages as mentioned in patch 2.

Also, in patch 5 & 6, we need to load 'size' to a register anyway so that we
can remove 'pagecnt_bias' and 'pfmemalloc' from 'struct page_frag_cache', it
would be better you can work through the whole patchset to get a bigger picture.

1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com/

> 
> This eventually leads you down the path where every time somebody has
> a use case for it that may not be optimal for others it is going to be
> a fight to see if the new use case can degrade the performance of the
> other use cases.

I think it is always better to have a disscusion[or 'fight'] about how to
support a new use case:
1. refoctor the existing implementation to support the new use case, and
   introduce a new API for it if have to.
2. if the above does not work, and the use case is important enough that
   we might create/design a subsystem/libary for it.

But from updating page_frag API, I do not see that we need the second
option yet.

> 
>>    (2) Provide a proper API so that caller does not need to access
>>        internal data field. Exposing the internal data field may
>>        enable the caller to do some unexpcted implementation of
>>        its own like below, after this patchset the API user is not
>>        supposed to do access the data field of 'page_frag_cache'
>>        directly[Currently it is still acessable from API caller if
>>        the caller is not following the rule, I am not sure how to
>>        limit the access without any performance impact yet].
>> https://elixir.bootlin.com/linux/v6.9-rc3/source/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c#L1141
> 
> This just makes the issue I point out in 1 even worse. The problem is
> this code has to be used at the very lowest of levels and is as
> tightly optimized as it is since it is called at least once per packet
> in the case of networking. Networking that is still getting faster
> mind you and demanding even fewer cycles per packet to try and keep
> up. I just see this change as taking us in the wrong direction.

Yes, I am agreed with your point about 'demanding even fewer cycles per
packet', but not so with 'tightly optimized'.

'tightly optimized' may mean everybody inventing their own wheels.

> 
>> 2. page_frag API may provide a central point for netwroking to allocate
>>    memory instead of calling page allocator directly in the future, so
>>    that we can decouple 'struct page' from networking.
> 
> I hope not. The fact is the page allocator serves a very specific
> purpose, and the page frag API was meant to serve a different one and
> not be a replacement for it. One thing that has really irked me is the
> fact that I have seen it abused as much as it has been where people
> seem to think it is just a page allocator when it was really meant to
> just provide a way to shard order 0 pages into sizes that are half a
> page or less in size. I really meant for it to be a quick-n-dirty slab
> allocator for sizes 2K or less where ideally we are working with
> powers of 2.
> 
> It concerns me that you are talking about taking this down a path that
> will likely lead to further misuse of the code as a backdoor way to
> allocate order 0 pages using this instead of just using the page
> allocator.

Let's not get to a conclusion here and wait to see how thing evolve
in the future.

> 
>>>
>>> Also I wouldn't bother mentioning the 0.5+% performance gain as a
>>> "bonus". Changes of that amount usually mean it is within the margin
>>> of error. At best it likely means you haven't introduced a noticeable
>>> regression.
>>
>> For micro-benchmark ko added in this patchset, performance gain seems quit
>> stable from testing in system without any other load.
> 
> Again, that doesn't mean anything. It could just be that the code
> shifted somewhere due to all the code moved so a loop got more aligned
> than it was before. To give you an idea I have seen performance gains
> in the past from turning off Rx checksum for some workloads and that
> was simply due to the fact that the CPUs were staying awake longer
> instead of going into deep sleep states as such we could handle more
> packets per second even though we were using more cycles. Without
> significantly more context it is hard to say that the gain is anything
> real at all and a 0.5% gain is well within that margin of error.

As vhost_net_test added in [2] is heavily invovled with tun and virtio
handling, the 0.5% gain does seems within that margin of error, there is
why I added a micro-benchmark specificly for page_frag in this patchset.

It is tested five times, three times with this patchset and two times without
this patchset, the complete log is as below, even there is some noise, all
the result with this patchset is better than the result without this patchset:

with this patchset:
 Performance counter stats for 'insmod ./page_frag_test.ko nr_test=99999999' (30 runs):

             40.09 msec task-clock                       #    0.001 CPUs utilized               ( +-  4.60% )
                 5      context-switches                 #  124.722 /sec                        ( +-  3.45% )
                 1      cpu-migrations                   #   24.944 /sec                        ( +- 12.62% )
               197      page-faults                      #    4.914 K/sec                       ( +-  0.11% )
          10221721      cycles                           #    0.255 GHz                         ( +-  9.05% )  (27.73%)
           2459009      stalled-cycles-frontend          #   24.06% frontend cycles idle        ( +- 10.80% )  (29.05%)
           5148423      stalled-cycles-backend           #   50.37% backend cycles idle         ( +-  7.30% )  (82.47%)
           5889929      instructions                     #    0.58  insn per cycle
                                                  #    0.87  stalled cycles per insn     ( +- 11.85% )  (87.75%)
           1276667      branches                         #   31.846 M/sec                       ( +- 11.48% )  (89.80%)
             50631      branch-misses                    #    3.97% of all branches             ( +-  8.72% )  (83.20%)

            29.341 +- 0.300 seconds time elapsed  ( +-  1.02% )

Performance counter stats for 'insmod ./page_frag_test.ko nr_test=99999999' (30 runs):

             36.56 msec task-clock                       #    0.001 CPUs utilized               ( +-  4.29% )
                 6      context-switches                 #  164.130 /sec                        ( +-  2.65% )
                 1      cpu-migrations                   #   27.355 /sec                        ( +- 15.67% )
               197      page-faults                      #    5.389 K/sec                       ( +-  0.12% )
          10006308      cycles                           #    0.274 GHz                         ( +-  8.36% )  (81.62%)
           2928275      stalled-cycles-frontend          #   29.26% frontend cycles idle        ( +- 11.50% )  (82.62%)
           5321882      stalled-cycles-backend           #   53.19% backend cycles idle         ( +-  8.39% )  (32.25%)
           6653737      instructions                     #    0.66  insn per cycle
                                                  #    0.80  stalled cycles per insn     ( +- 14.95% )  (37.23%)
           1301600      branches                         #   35.605 M/sec                       ( +- 14.24% )  (86.14%)
             47880      branch-misses                    #    3.68% of all branches             ( +- 10.70% )  (80.16%)

            28.683 +- 0.253 seconds time elapsed  ( +-  0.88% )

 Performance counter stats for 'insmod ./page_frag_test.ko nr_test=99999999' (30 runs):

             39.02 msec task-clock                       #    0.001 CPUs utilized               ( +-  4.13% )
                 6      context-switches                 #  153.753 /sec                        ( +-  2.98% )
                 1      cpu-migrations                   #   25.626 /sec                        ( +- 14.50% )
               197      page-faults                      #    5.048 K/sec                       ( +-  0.08% )
          10184452      cycles                           #    0.261 GHz                         ( +-  8.30% )  (40.64%)
           2756400      stalled-cycles-frontend          #   27.06% frontend cycles idle        ( +- 10.82% )  (71.70%)
           5127852      stalled-cycles-backend           #   50.35% backend cycles idle         ( +-  8.95% )  (78.94%)
           6353385      instructions                     #    0.62  insn per cycle
                                                  #    0.81  stalled cycles per insn     ( +- 18.79% )  (84.34%)
           1409873      branches                         #   36.129 M/sec                       ( +- 23.85% )  (80.42%)
             52044      branch-misses                    #    3.69% of all branches             ( +- 10.68% )  (43.96%)

            28.730 +- 0.201 seconds time elapsed  ( +-  0.70% )

-----------------------------------------------------------------------------------------------------------

without this patchset:
 Performance counter stats for 'insmod ./page_frag_test.ko nr_test=99999999' (30 runs):

             39.12 msec task-clock                       #    0.001 CPUs utilized               ( +-  4.51% )
                 5      context-switches                 #  127.805 /sec                        ( +-  3.76% )
                 1      cpu-migrations                   #   25.561 /sec                        ( +- 15.52% )
               197      page-faults                      #    5.035 K/sec                       ( +-  0.10% )
          10689913      cycles                           #    0.273 GHz                         ( +-  9.46% )  (72.72%)
           2821237      stalled-cycles-frontend          #   26.39% frontend cycles idle        ( +- 12.04% )  (76.23%)
           5035549      stalled-cycles-backend           #   47.11% backend cycles idle         ( +-  9.69% )  (49.40%)
           5439395      instructions                     #    0.51  insn per cycle
                                                  #    0.93  stalled cycles per insn     ( +- 11.58% )  (51.45%)
           1274419      branches                         #   32.575 M/sec                       ( +- 12.69% )  (77.88%)
             49562      branch-misses                    #    3.89% of all branches             ( +-  9.91% )  (72.32%)

            30.309 +- 0.305 seconds time elapsed  ( +-  1.01% )

 Performance counter stats for 'insmod ./page_frag_test.ko nr_test=99999999' (30 runs):

             37.40 msec task-clock                       #    0.001 CPUs utilized               ( +-  4.72% )
                 5      context-switches                 #  133.691 /sec                        ( +-  3.65% )
                 1      cpu-migrations                   #   26.738 /sec                        ( +- 14.13% )
               197      page-faults                      #    5.267 K/sec                       ( +-  0.12% )
          10196250      cycles                           #    0.273 GHz                         ( +-  9.37% )  (79.84%)
           2579562      stalled-cycles-frontend          #   25.30% frontend cycles idle        ( +- 13.05% )  (48.29%)
           4833236      stalled-cycles-backend           #   47.40% backend cycles idle         ( +-  9.84% )  (45.64%)
           5992762      instructions                     #    0.59  insn per cycle
                                                  #    0.81  stalled cycles per insn     ( +- 11.01% )  (76.56%)
           1274592      branches                         #   34.080 M/sec                       ( +- 12.88% )  (74.52%)
             51015      branch-misses                    #    4.00% of all branches             ( +- 10.60% )  (75.15%)

            29.958 +- 0.314 seconds time elapsed  ( +-  1.05% )



2. https://lore.kernel.org/all/20240228093013.8263-6-linyunsheng@huawei.com/

> .
> 

