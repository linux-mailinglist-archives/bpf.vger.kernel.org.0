Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BAB396D36
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 08:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhFAGTS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 02:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229477AbhFAGTR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Jun 2021 02:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622528256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=enybrQ/dLg4DwTtxWWLNNtD7Qa94WazVTzOjB6L1kbs=;
        b=A5xZcCpLQb3eebYPuMHq4jqv3xt5FmebAD+4DaD+188FZuoP9czKe6/Cwr2/fa8d++X4Ad
        CaipsdiVKR5lyaRooqnQXyxzGcO8/8hkZqcNF+v+BK/CbL4pJi1O6nJ1REwCN7Hkj47D05
        eiYe2N1FLQOMalDXRC8LtJF59UEMZBs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-hPmM2jrfNJqt7koCpkdraQ-1; Tue, 01 Jun 2021 02:17:35 -0400
X-MC-Unique: hPmM2jrfNJqt7koCpkdraQ-1
Received: by mail-pl1-f198.google.com with SMTP id x7-20020a1709027c07b02900e6489d6231so4049215pll.6
        for <bpf@vger.kernel.org>; Mon, 31 May 2021 23:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=enybrQ/dLg4DwTtxWWLNNtD7Qa94WazVTzOjB6L1kbs=;
        b=een4/+Y29P+YjhS+l63fOpcIEXxZJkF0vo4KxeBTMZEIwrUSIzRhhvJ4y3O63pAbLQ
         TeApCRXaOm1BKAF5jVBDxhCLuY6l/qen4vzFeOHpVVtfjOM+Ht98JQ0ed8Z3qH3sl+e6
         q2+euDD3/jQK1CeAk4cQeVL1J1wbRAfMMNBAWQQRyeH+stNDQpg9MhECHhPHlIRa/lZT
         JEBMf16qCG/tB+Gei2CnQcAWoWOycTMWDCpsSLRsJb5hf+an1/QRrtxU3nm7VQGAlUsM
         emI4yacp3qhIdjjwemwrZYHXy+ljGdGo44dR67w7hWM+eCZBPv4pcdKGz4EtM31Ynx+u
         yOcw==
X-Gm-Message-State: AOAM531dZ+fJttE7cI8aX2M7SysJbPeQf0cwDR0upOc7OEWgPGI4VFBC
        ZLu7leI4axdSCcj9gQwTCeq3yeUn2lGMfe+UC91JTJhs0cFir+rlGcHeAvdDMgL/9yw+3xK8rBa
        Pc2Jr7Bh5Ovfy
X-Received: by 2002:a62:1547:0:b029:2e9:f6d7:776a with SMTP id 68-20020a6215470000b02902e9f6d7776amr2589746pfv.14.1622528253932;
        Mon, 31 May 2021 23:17:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyARS+L1qKbMKnCk9SWMeyLcmqdjqkmCDtc4ng4Xld6vqUKHV0CxJ/aenivQw4SLHkcmQismQ==
X-Received: by 2002:a62:1547:0:b029:2e9:f6d7:776a with SMTP id 68-20020a6215470000b02902e9f6d7776amr2589722pfv.14.1622528253625;
        Mon, 31 May 2021 23:17:33 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m1sm13661936pgd.78.2021.05.31.23.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 23:17:32 -0700 (PDT)
Subject: Re: [PATCH net 2/2] virtio-net: get build_skb() buf by data ptr
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <1622527177.2087624-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <24aee726-83a9-9741-23bb-1f8be0e775e6@redhat.com>
Date:   Tue, 1 Jun 2021 14:17:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622527177.2087624-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2021/6/1 下午1:59, Xuan Zhuo 写道:
> On Tue, 1 Jun 2021 11:27:12 +0800, Jason Wang <jasowang@redhat.com> wrote:
>> 在 2021/6/1 上午11:08, Xuan Zhuo 写道:
>>> On Tue, 1 Jun 2021 11:03:37 +0800, Jason Wang <jasowang@redhat.com> wrote:
>>>> 在 2021/5/31 下午6:58, Xuan Zhuo 写道:
>>>>> On Mon, 31 May 2021 14:10:55 +0800, Jason Wang <jasowang@redhat.com> wrote:
>>>>>> 在 2021/5/14 下午11:16, Xuan Zhuo 写道:
>>>>>>> In the case of merge, the page passed into page_to_skb() may be a head
>>>>>>> page, not the page where the current data is located.
>>>>>> I don't get how this can happen?
>>>>>>
>>>>>> Maybe you can explain a little bit more?
>>>>>>
>>>>>> receive_mergeable() call page_to_skb() in two places:
>>>>>>
>>>>>> 1) XDP_PASS for linearized page , in this case we use xdp_page
>>>>>> 2) page_to_skb() for "normal" page, in this case the page contains the data
>>>>> The offset may be greater than PAGE_SIZE, because page is obtained by
>>>>> virt_to_head_page(), not the page where buf is located. And "offset" is the offset
>>>>> of buf relative to page.
>>>>>
>>>>> 	tailroom = truesize - len - offset;
>>>>>
>>>>> In this case, the tailroom must be less than 0. Although there may be enough
>>>>> content on this page to save skb_shared_info.
>>>> Interesting, I think we don't use compound pages for virtio-net. (We
>>>> don't define SKB_FRAG_PAGE_ORDER).
>>>>
>>>> Am I wrong?
>>> It seems to me that it seems to be a fixed setting, not for us to configure
>>> independently
>>
>> Looks like you are right.
>>
>> See comments below.
>>
>>
>>> Thanks.
>>>
>>> ==========================================
>>>
>>> net/sock.c
>>>
>>> #define SKB_FRAG_PAGE_ORDER	get_order(32768)
>>> DEFINE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
>>>
>>> /**
>>>    * skb_page_frag_refill - check that a page_frag contains enough room
>>>    * @sz: minimum size of the fragment we want to get
>>>    * @pfrag: pointer to page_frag
>>>    * @gfp: priority for memory allocation
>>>    *
>>>    * Note: While this allocator tries to use high order pages, there is
>>>    * no guarantee that allocations succeed. Therefore, @sz MUST be
>>>    * less or equal than PAGE_SIZE.
>>>    */
>>> bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
>>> {
>>> 	if (pfrag->page) {
>>> 		if (page_ref_count(pfrag->page) == 1) {
>>> 			pfrag->offset = 0;
>>> 			return true;
>>> 		}
>>> 		if (pfrag->offset + sz <= pfrag->size)
>>> 			return true;
>>> 		put_page(pfrag->page);
>>> 	}
>>>
>>> 	pfrag->offset = 0;
>>> 	if (SKB_FRAG_PAGE_ORDER &&
>>> 	    !static_branch_unlikely(&net_high_order_alloc_disable_key)) {
>>> 		/* Avoid direct reclaim but allow kswapd to wake */
>>> 		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
>>> 					  __GFP_COMP | __GFP_NOWARN |
>>> 					  __GFP_NORETRY,
>>> 					  SKB_FRAG_PAGE_ORDER);
>>> 		if (likely(pfrag->page)) {
>>> 			pfrag->size = PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
>>> 			return true;
>>> 		}
>>> 	}
>>> 	pfrag->page = alloc_page(gfp);
>>> 	if (likely(pfrag->page)) {
>>> 		pfrag->size = PAGE_SIZE;
>>> 		return true;
>>> 	}
>>> 	return false;
>>> }
>>> EXPORT_SYMBOL(skb_page_frag_refill);
>>>
>>>
>>>> Thanks
>>>>
>>>>
>>>>> Thanks.
>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>
>>>>>>> So when trying to
>>>>>>> get the buf where the data is located, you should directly use the
>>>>>>> pointer(p) to get the address corresponding to the page.
>>>>>>>
>>>>>>> At the same time, the offset of the data in the page should also be
>>>>>>> obtained using offset_in_page().
>>>>>>>
>>>>>>> This patch solves this problem. But if you don’t use this patch, the
>>>>>>> original code can also run, because if the page is not the page of the
>>>>>>> current data, the calculated tailroom will be less than 0, and will not
>>>>>>> enter the logic of build_skb() . The significance of this patch is to
>>>>>>> modify this logical problem, allowing more situations to use
>>>>>>> build_skb().
>>>>>>>
>>>>>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>>> ---
>>>>>>>      drivers/net/virtio_net.c | 8 ++++++--
>>>>>>>      1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>>> index 3e46c12dde08..073fec4c0df1 100644
>>>>>>> --- a/drivers/net/virtio_net.c
>>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>>> @@ -407,8 +407,12 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>>>>>>      		 * see add_recvbuf_mergeable() + get_mergeable_buf_len()
>>>>>>>      		 */
>>>>>>>      		truesize = PAGE_SIZE;
>>>>>>> -		tailroom = truesize - len - offset;
>>>>>>> -		buf = page_address(page);
>>>>>>> +
>>>>>>> +		/* page maybe head page, so we should get the buf by p, not the
>>>>>>> +		 * page
>>>>>>> +		 */
>>>>>>> +		tailroom = truesize - len - offset_in_page(p);
>>
>> I wonder why offset_in_page(p) is correct? I guess it should be:
>>
>> tailroom = truesize - len - headroom;
>>
>> The reason is that the buffer is not necessarily allocated at the page
>> boundary.
> In my understanding, offset_in_page(p) is the offset of p in the page where it
> is located. In this case, the two should be equal.


I think not, if the frag is not page aligned. offset_in_page(p) doesn't 
equal to headroom.

Consider the case that the frag start from page offset 1500.


>   This has nothing to do with
> which page is allocated.
>
> Of course I think using headroom is a good idea, and it is semantically better.
>
> Thanks.


Thanks


>
>> Thanks
>>
>>
>>>>>>> +		buf = (char *)((unsigned long)p & PAGE_MASK);
>>>>>>>      	} else {
>>>>>>>      		tailroom = truesize - len;
>>>>>>>      		buf = p;

