Return-Path: <bpf+bounces-2754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2352733842
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 20:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D3D281755
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 18:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC4219BB0;
	Fri, 16 Jun 2023 18:41:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D6101F6
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 18:41:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0CB2D4D
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686940910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncUHSaugo1pt966Srqti4iXSp2GyLmXVm+6LdG2q0jM=;
	b=ba+CgnlOpFuGan6I84HlNWHUgNWq0B6HfWC+44cfpTYNMszz9sTD40g2hNPz3SXi6WYXZ8
	/NEC8CtYoS9pH6UrBQ9h7jgv48SzxUcOIxwqlE/VhyNeczvlbVJlawJb6iClQbeDqDuQP/
	z6hiomxFcduo6rNs9gy10XSJPtYWOjw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-TEoHFWtzPsSg9exJe7nqTg-1; Fri, 16 Jun 2023 14:41:48 -0400
X-MC-Unique: TEoHFWtzPsSg9exJe7nqTg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-514b3b99882so617126a12.2
        for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 11:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686940907; x=1689532907;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncUHSaugo1pt966Srqti4iXSp2GyLmXVm+6LdG2q0jM=;
        b=YAM8skutYI0Dtph3g6bIMP5rmqrxqi23VjCW4E6pVJleIFoKeWDLzdKrpKidI9AqkY
         tgSJk7augioRUKFGFF1hjtgFinFIAnhgdyZy8N9k3ooNvRR4hhPclZue5qtON61DWtV6
         hrQ2W9XnmdIqEG0trOX29bBH3e6kgH5r4nYZ0nypTjFpU9iBJmkON+BSJrlzfmzmdz0v
         xL04BF7Fycj/oQi8L7gHlLCGVHcT8+/cm+z7mr5uJDCz0fi3geRkvwS+NptoBJ09sHvr
         VOGnM6axAHi9yRj5S+xFnEMcp+dw/gfFB0f38N//fIkDhow5ELdi72PYrPwZjyRAwLJt
         j/Vw==
X-Gm-Message-State: AC+VfDzUkSF8AdnDUI6/zCHqu/Ov4i+eBc0g8MzlgwlIjMiYlA6cffQU
	pbrDn6HfyQ4GsuZ7FyZCtEFl3vkijjuosDOdt8ZZZRA/mJqOSh95iaj1cSlBVX3xWQk0/YDh2nC
	eXjnO3b+DX5Nz
X-Received: by 2002:a05:6402:456:b0:50b:c693:70af with SMTP id p22-20020a056402045600b0050bc69370afmr1802601edw.2.1686940907701;
        Fri, 16 Jun 2023 11:41:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZwlNDrlIPVnLd2ChvWVe+/LR0giMk2yuns4hw25JwyD+9MyGtY4OEvmqNPLU+/IY/BG0hTg==
X-Received: by 2002:a05:6402:456:b0:50b:c693:70af with SMTP id p22-20020a056402045600b0050bc69370afmr1802591edw.2.1686940907364;
        Fri, 16 Jun 2023 11:41:47 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7c40a000000b0051a315d6e1bsm1313091edq.70.2023.06.16.11.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 11:41:46 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <699563f5-c4fa-0246-5e79-61a29e1a8db3@redhat.com>
Date: Fri, 16 Jun 2023 20:41:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, Yunsheng Lin <linyunsheng@huawei.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Maryam Tahhan <mtahhan@redhat.com>,
 bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/4] page_pool: introduce page_pool_alloc()
 API
Content-Language: en-US
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230609131740.7496-1-linyunsheng@huawei.com>
 <20230609131740.7496-4-linyunsheng@huawei.com>
 <CAKgT0UfVwQ=ri7ZDNnsATH2RQpEz+zDBBb6YprvniMEWGdw+dQ@mail.gmail.com>
 <36366741-8df2-1137-0dd9-d498d0f770e4@huawei.com>
 <CAKgT0UdXTSv1fDHBX4UC6Ok9NXKMJ_9F88CEv5TK+mpzy0N21g@mail.gmail.com>
 <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com>
 <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
 <0ba1bf9c-2e45-cd44-60d3-66feeb3268f3@redhat.com>
 <dcc9db4c-207b-e118-3d84-641677cd3d80@huawei.com>
 <f8ce176f-f975-af11-641c-b56c53a8066a@redhat.com>
 <CAKgT0UfzP30OiBQu+YKefLD+=32t+oA6KGzkvsW6k7CMTXU8KA@mail.gmail.com>
In-Reply-To: <CAKgT0UfzP30OiBQu+YKefLD+=32t+oA6KGzkvsW6k7CMTXU8KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 16/06/2023 19.34, Alexander Duyck wrote:
> On Fri, Jun 16, 2023 at 9:31 AM Jesper Dangaard Brouer
> <jbrouer@redhat.com> wrote:
>>
>>
>>
>> On 16/06/2023 13.57, Yunsheng Lin wrote:
>>> On 2023/6/16 0:19, Jesper Dangaard Brouer wrote:
>>>
>>> ...
>>>
>>>> You have mentioned veth as the use-case. I know I acked adding page_pool
>>>> use-case to veth, for when we need to convert an SKB into an
>>>> xdp_buff/xdp-frame, but maybe it was the wrong hammer(?).
>>>> In this case in veth, the size is known at the page allocation time.
>>>> Thus, using the page_pool API is wasting memory.  We did this for
>>>> performance reasons, but we are not using PP for what is was intended
>>>> for.  We mostly use page_pool, because it an existing recycle return
>>>> path, and we were too lazy to add another alloc-type (see enum
>>>> xdp_mem_type).
>>>>
>>>> Maybe you/we can extend veth to use this dynamic size API, to show us
>>>> that this is API is a better approach.  I will signup for benchmarking
>>>> this (and coordinating with CC Maryam as she came with use-case we
>>>> improved on).
>>>
>>> Thanks, let's find out if page pool is the right hammer for the
>>> veth XDP case.
>>>
>>> Below is the change for veth using the new api in this patch.
>>> Only compile test as I am not familiar enough with veth XDP and
>>> testing environment for it.
>>> Please try it if it is helpful.
>>>
>>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>> index 614f3e3efab0..8850394f1d29 100644
>>> --- a/drivers/net/veth.c
>>> +++ b/drivers/net/veth.c
>>> @@ -736,7 +736,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>>>           if (skb_shared(skb) || skb_head_is_locked(skb) ||
>>>               skb_shinfo(skb)->nr_frags ||
>>>               skb_headroom(skb) < XDP_PACKET_HEADROOM) {
>>> -               u32 size, len, max_head_size, off;
>>> +               u32 size, len, max_head_size, off, truesize, page_offset;
>>>                   struct sk_buff *nskb;
>>>                   struct page *page;
>>>                   int i, head_off;
>>> @@ -752,12 +752,15 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>>>                   if (skb->len > PAGE_SIZE * MAX_SKB_FRAGS + max_head_size)
>>>                           goto drop;
>>>
>>> +               size = min_t(u32, skb->len, max_head_size);
>>> +               truesize = size;
>>> +
>>>                   /* Allocate skb head */
>>> -               page = page_pool_dev_alloc_pages(rq->page_pool);
>>> +               page = page_pool_dev_alloc(rq->page_pool, &page_offset, &truesize);
>>
>> Maybe rename API to:
>>
>>    addr = netmem_alloc(rq->page_pool, &truesize);
>>
>>>                   if (!page)
>>>                           goto drop;
>>>
>>> -               nskb = napi_build_skb(page_address(page), PAGE_SIZE);
>>> +               nskb = napi_build_skb(page_address(page) + page_offset, truesize);
>>
>> IMHO this illustrates that API is strange/funky.
>> (I think this is what Alex Duyck is also pointing out).
>>
>> This is the memory (virtual) address "pointer":
>>    addr = page_address(page) + page_offset
>>
>> This is what napi_build_skb() takes as input. (I looked at other users
>> of napi_build_skb() whom all give a mem ptr "va" as arg.)
>> So, why does your new API provide the "page" and not just the address?
>>
>> As proposed above:
>>     addr = netmem_alloc(rq->page_pool, &truesize);
>>
>> Maybe the API should be renamed, to indicate this isn't returning a "page"?
>> We have talked about the name "netmem" before.
> 
> Yeah, this is more-or-less what I was getting at. Keep in mind this is
> likely the most common case since most frames passed and forth aren't
> ever usually much larger than 1500B.
> 

Good to get confirmed this is "more-or-less" your suggestion/direction.


>>>                   if (!nskb) {
>>>                           page_pool_put_full_page(rq->page_pool, page, true);
>>>                           goto drop;
>>> @@ -767,7 +770,6 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>>>                   skb_copy_header(nskb, skb);
>>>                   skb_mark_for_recycle(nskb);
>>>
>>> -               size = min_t(u32, skb->len, max_head_size);
>>>                   if (skb_copy_bits(skb, 0, nskb->data, size)) {
>>>                           consume_skb(nskb);
>>>                           goto drop;
>>> @@ -782,14 +784,17 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>>>                   len = skb->len - off;
>>>
>>>                   for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
>>> -                       page = page_pool_dev_alloc_pages(rq->page_pool);
>>> +                       size = min_t(u32, len, PAGE_SIZE);
>>> +                       truesize = size;
>>> +
>>> +                       page = page_pool_dev_alloc(rq->page_pool, &page_offset,
>>> +                                                  &truesize);
>>>                           if (!page) {
>>>                                   consume_skb(nskb);
>>>                                   goto drop;
>>>                           }
>>>
>>> -                       size = min_t(u32, len, PAGE_SIZE);
>>> -                       skb_add_rx_frag(nskb, i, page, 0, size, PAGE_SIZE);
>>> +                       skb_add_rx_frag(nskb, i, page, page_offset, size, truesize);
>>
>> Guess, this shows the opposite; that the "page" _is_ used by the
>> existing API.
> 
> This is a sort-of. One thing that has come up as of late is that all
> this stuff is being moved over to folios anyway and getting away from
> pages. In addition I am not sure how often we are having to take this
> path as I am not sure how many non-Tx frames end up having to have
> fragments added to them. For something like veth it might be more
> common though since Tx becomes Rx in this case.

I'm thinking, that is it very unlikely that XDP have modified the
fragments.  So, why are we allocating and copying the fragments?
Wouldn't it be possible for this veth code to bump the refcnt on these
fragments? (maybe I missed some detail).

> 
> One thought I had on this is that we could look at adding a new
> function that abstracts this away and makes use of netmem instead.
> Then the whole page/folio thing would be that much further removed.

I like this "thought" of yours :-)

> 
> One other question I have now that I look at this code as well. Why is
> it using page_pool and not just a frag cache allocator, or pages
> themselves? It doesn't seem like it has a DMA mapping to deal with
> since this is essentially copy-break code. Seems problematic that
> there is no DMA involved here at all. This could be more easily
> handled with just a single page_frag_cache style allocator.
> 

Yes, precisely.
I distinctly remember what I tried to poke you and Eric on this approach
earlier, but I cannot find a link to that email.

I would really appreciate, if you Alex, could give the approach in
veth_convert_skb_to_xdp_buff() some review, as I believe that is a huge
potential for improvements that will lead to large performance
improvements. (I'm sure Maryam will be eager to help re-test performance
for her use-cases).

--Jesper


