Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C447F6B18E7
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 02:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCIBth (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 20:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCIBtg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 20:49:36 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F364C7040A;
        Wed,  8 Mar 2023 17:49:33 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PXBqP0GCKzSkgm;
        Thu,  9 Mar 2023 09:46:25 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 9 Mar
 2023 09:49:30 +0800
Subject: Re: [PATCH net, stable v1 3/3] virtio_net: add checking sq is full
 inside xdp xmit
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        <virtualization@lists.linux-foundation.org>, <bpf@vger.kernel.org>,
        Yichun Zhang <yichun@openresty.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        <netdev@vger.kernel.org>
References: <20230308024935.91686-1-xuanzhuo@linux.alibaba.com>
 <20230308024935.91686-4-xuanzhuo@linux.alibaba.com>
 <7eea924e-5cc3-8584-af95-04587f303f8f@huawei.com>
 <1678259647.118581-1-xuanzhuo@linux.alibaba.com>
 <5a4564dc-af93-4305-49a4-5ca16d737bc3@huawei.com>
 <20230308071921-mutt-send-email-mst@kernel.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <c7952f87-bb9c-7613-44fb-8c5015d9ef4f@huawei.com>
Date:   Thu, 9 Mar 2023 09:49:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230308071921-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2023/3/8 20:21, Michael S. Tsirkin wrote:
> On Wed, Mar 08, 2023 at 04:13:12PM +0800, Yunsheng Lin wrote:
>> On 2023/3/8 15:14, Xuan Zhuo wrote:
>>> On Wed, 8 Mar 2023 14:59:36 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>> On 2023/3/8 10:49, Xuan Zhuo wrote:
>>>>> If the queue of xdp xmit is not an independent queue, then when the xdp
>>>>> xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
>>>>> the following error.
>>>>>
>>>>> net ens4: Unexpected TXQ (0) queue failure: -28
>>>>>
>>>>> This patch adds a check whether sq is full in xdp xmit.
>>>>>
>>>>> Fixes: 56434a01b12e ("virtio_net: add XDP_TX support")
>>>>> Reported-by: Yichun Zhang <yichun@openresty.com>
>>>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> ---
>>>>>  drivers/net/virtio_net.c | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>> index 46bbddaadb0d..1a309cfb4976 100644
>>>>> --- a/drivers/net/virtio_net.c
>>>>> +++ b/drivers/net/virtio_net.c
>>>>> @@ -767,6 +767,9 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>>>>>  	}
>>>>>  	ret = nxmit;
>>>>>
>>>>> +	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
>>>>> +		check_sq_full_and_disable(vi, dev, sq);
>>>>> +
>>>>
>>>> Sorry if I missed something obvious here.
>>>>
>>>> As the comment in start_xmit(), the current skb is added to the sq->vq, so
>>>> NETDEV_TX_BUSY can not be returned.
>>>>
>>>> 	/* If running out of space, stop queue to avoid getting packets that we
>>>> 	 * are then unable to transmit.
>>>> 	 * An alternative would be to force queuing layer to requeue the skb by
>>>> 	 * returning NETDEV_TX_BUSY. However, NETDEV_TX_BUSY should not be
>>>> 	 * returned in a normal path of operation: it means that driver is not
>>>> 	 * maintaining the TX queue stop/start state properly, and causes
>>>> 	 * the stack to do a non-trivial amount of useless work.
>>>> 	 * Since most packets only take 1 or 2 ring slots, stopping the queue
>>>> 	 * early means 16 slots are typically wasted.
>>>> 	 */
>>>>
>>>> It there any reason not to check the sq->vq->num_free at the begin of start_xmit(),
>>>> if the space is not enough for the current skb, TX queue is stopped and NETDEV_TX_BUSY
>>>> is return to the stack to requeue the current skb.
>>>>
>>>> It seems it is the pattern that most network driver follow, and it seems we can avoid
>>>> calling check_sq_full_and_disable() in this patch and not wasting 16 slots as mentioned
>>>> in the comment above.
>>>>
>>>
>>>
>>>
>>>  * netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb,
>>>  *                               struct net_device *dev);
>>>  *	Called when a packet needs to be transmitted.
>>>  *	Returns NETDEV_TX_OK.  Can return NETDEV_TX_BUSY, but you should stop
>>>  *	the queue before that can happen; it's for obsolete devices and weird
>>>  *	corner cases, but the stack really does a non-trivial amount
>>>  *	of useless work if you return NETDEV_TX_BUSY.
>>>  *	Required; cannot be NULL.
>>
>> Thanks for the pointer. It is intersting, it seems most driver is not flollowing
>> the suggestion.
> 
> Yes - I don't know why.

I digged a little deeper. And there was a long discussion about this.

https://patchwork.ozlabs.org/project/netdev/patch/200906031247.05591.rusty@rustcorp.com.au/#70283

> 
>> I found out why the above comment was added, but I am not sure I understand
>> what does "non-trivial amount of useless work" means yet.
>> https://lists.linuxfoundation.org/pipermail/virtualization/2015-April/029718.html
> 
> dev_requeue_skb
> 

That's the part I did not understand, the implemention of dev_requeue_skb() does not seem
"non-trivial" to me, maybe the implemention before dev_requeue_skb() was non-trivial.
But now "non-trivial amount of useless work" just seems to add confusion here.

Anyway, according to the discussion between Herbert and Rusty, the problems seems to be:
1. tcpdump may see the packet twice due to requeuing.
2. higher priority skb is not able to preempt the requeued low priority skb.

For 1, it seems fixable.
For 2, I am not a QoS expert, but does the big TCP support added recently and the batching
support in dev_hard_start_xmit() adds more noise to this qos problem?
