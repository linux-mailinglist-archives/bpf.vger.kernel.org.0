Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC02B396BBC
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 05:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhFADFb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 May 2021 23:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232268AbhFADFb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 31 May 2021 23:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622516629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=REw0v4febqRmEtFGcSxpH//nxKz4Tay3APYlxK2qeL0=;
        b=ZYoGSZba+wiOlv8G7D04wh5VifQUSp1meRw5hMqR9NOfCL4Uo7fYYxXFj8d5dsau87fvY2
        SQsueg50hh0m8yvu8y/t4iww752oTadTrGb0U6vlA5uIuY9oDd+dHHFpU5lnH4F4p9NeUa
        x2/hclKJCcM194w4DkmbiAYcCeYj1SY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-wCvk41emNnukdm3nproCLg-1; Mon, 31 May 2021 23:03:48 -0400
X-MC-Unique: wCvk41emNnukdm3nproCLg-1
Received: by mail-pl1-f199.google.com with SMTP id x15-20020a170902e04fb02900f5295925dbso3881684plx.9
        for <bpf@vger.kernel.org>; Mon, 31 May 2021 20:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=REw0v4febqRmEtFGcSxpH//nxKz4Tay3APYlxK2qeL0=;
        b=Vh+G08VHw5TdWezPJ46NcH9SIRsO29QQQrr7zLwSx+RMVFe4yA0eB8AmESeF7LX41V
         8dk9miiwbDvjTHA1L8LdZ5NB5QMiJkrUzwGln4S5RLjj2K6OQlCJemHd5yjmEl2cV5VG
         16BLBvV/ikENZ2081t3Drg04DA9Uojg/DCm3WQHDAXZZfMel0SN3OygPQV92om8A+tuo
         JBtmbzL80Y2JydtiuoLpKeqT/9sOMbG6kXmOEIl1A6ZLqDBY1vg6EtObW6Kn00nN3AJn
         /5tLUGoVYzsiTRLSTarlMQ/qgAxIQr26WL8QTGhyhaQe/CWo4V8Bz1RFDDfs1vB+BVS9
         iNSQ==
X-Gm-Message-State: AOAM532fUueck+kB8Bnm3eEYnq+/NNX7E2J9tz317AhhCoL+F3VMy/IU
        N+eS9OBUdnMvJImSbIm2w+itXkKZlMlEj2rKA+LR4g5JJhII0oy41CoQL4xucHSRI5WUkXDY3Ig
        Ul5VrMKHx2ppL
X-Received: by 2002:a62:b419:0:b029:2e8:e879:5d1e with SMTP id h25-20020a62b4190000b02902e8e8795d1emr19485922pfn.3.1622516627550;
        Mon, 31 May 2021 20:03:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwijnmAPYgjp24Pwd1POSPKg866XSvy+/QLq5Mw1wyVqQP2ac01uC1sNGM6GQWkFNmElLpNQQ==
X-Received: by 2002:a62:b419:0:b029:2e8:e879:5d1e with SMTP id h25-20020a62b4190000b02902e8e8795d1emr19485904pfn.3.1622516627295;
        Mon, 31 May 2021 20:03:47 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 76sm2669467pfy.82.2021.05.31.20.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 20:03:46 -0700 (PDT)
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
References: <1622458734.837168-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b7dde035-b770-35c2-5e08-d81df4023a90@redhat.com>
Date:   Tue, 1 Jun 2021 11:03:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622458734.837168-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2021/5/31 下午6:58, Xuan Zhuo 写道:
> On Mon, 31 May 2021 14:10:55 +0800, Jason Wang <jasowang@redhat.com> wrote:
>> 在 2021/5/14 下午11:16, Xuan Zhuo 写道:
>>> In the case of merge, the page passed into page_to_skb() may be a head
>>> page, not the page where the current data is located.
>>
>> I don't get how this can happen?
>>
>> Maybe you can explain a little bit more?
>>
>> receive_mergeable() call page_to_skb() in two places:
>>
>> 1) XDP_PASS for linearized page , in this case we use xdp_page
>> 2) page_to_skb() for "normal" page, in this case the page contains the data
> The offset may be greater than PAGE_SIZE, because page is obtained by
> virt_to_head_page(), not the page where buf is located. And "offset" is the offset
> of buf relative to page.
>
> 	tailroom = truesize - len - offset;
>
> In this case, the tailroom must be less than 0. Although there may be enough
> content on this page to save skb_shared_info.


Interesting, I think we don't use compound pages for virtio-net. (We 
don't define SKB_FRAG_PAGE_ORDER).

Am I wrong?

Thanks


>
> Thanks.
>
>> Thanks
>>
>>
>>> So when trying to
>>> get the buf where the data is located, you should directly use the
>>> pointer(p) to get the address corresponding to the page.
>>>
>>> At the same time, the offset of the data in the page should also be
>>> obtained using offset_in_page().
>>>
>>> This patch solves this problem. But if you don’t use this patch, the
>>> original code can also run, because if the page is not the page of the
>>> current data, the calculated tailroom will be less than 0, and will not
>>> enter the logic of build_skb() . The significance of this patch is to
>>> modify this logical problem, allowing more situations to use
>>> build_skb().
>>>
>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>    drivers/net/virtio_net.c | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index 3e46c12dde08..073fec4c0df1 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -407,8 +407,12 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>>    		 * see add_recvbuf_mergeable() + get_mergeable_buf_len()
>>>    		 */
>>>    		truesize = PAGE_SIZE;
>>> -		tailroom = truesize - len - offset;
>>> -		buf = page_address(page);
>>> +
>>> +		/* page maybe head page, so we should get the buf by p, not the
>>> +		 * page
>>> +		 */
>>> +		tailroom = truesize - len - offset_in_page(p);
>>> +		buf = (char *)((unsigned long)p & PAGE_MASK);
>>>    	} else {
>>>    		tailroom = truesize - len;
>>>    		buf = p;

