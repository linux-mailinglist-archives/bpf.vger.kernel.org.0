Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854C66573D7
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 09:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiL1IRu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 03:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiL1IRt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 03:17:49 -0500
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B25BDFD4;
        Wed, 28 Dec 2022 00:17:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VYGfiQg_1672215462;
Received: from 30.15.240.205(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VYGfiQg_1672215462)
          by smtp.aliyun-inc.com;
          Wed, 28 Dec 2022 16:17:43 +0800
Message-ID: <38c223b5-7fcf-71bf-279c-bc83e3d86531@linux.alibaba.com>
Date:   Wed, 28 Dec 2022 16:17:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:108.0)
 Gecko/20100101 Thunderbird/108.0
Subject: Re: [PATCH v2 4/9] virtio_net: build xdp_buff with multi buffers
To:     Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221220141449.115918-1-hengqi@linux.alibaba.com>
 <20221220141449.115918-5-hengqi@linux.alibaba.com>
 <e0cf3f23-a173-778b-fc68-27de811f1aab@redhat.com>
 <8aa5b8fb-d766-ac84-dfc1-4f9947e86e27@linux.alibaba.com>
 <219fae4f-6ab6-7241-2597-267e426c8a3c@redhat.com>
From:   Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <219fae4f-6ab6-7241-2597-267e426c8a3c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



在 2022/12/28 下午2:27, Jason Wang 写道:
>
> 在 2022/12/27 17:10, Heng Qi 写道:
>>
>>
>> 在 2022/12/27 下午2:46, Jason Wang 写道:
>>>
>>> 在 2022/12/20 22:14, Heng Qi 写道:
>>>> Support xdp for multi buffer packets in mergeable mode.
>>>>
>>>> Putting the first buffer as the linear part for xdp_buff,
>>>> and the rest of the buffers as non-linear fragments to struct
>>>> skb_shared_info in the tailroom belonging to xdp_buff.
>>>>
>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>> ---
>>>>   drivers/net/virtio_net.c | 78 
>>>> ++++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 78 insertions(+)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 08f209d7b0bf..8fc3b1841d92 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -931,6 +931,84 @@ static struct sk_buff *receive_big(struct 
>>>> net_device *dev,
>>>>       return NULL;
>>>>   }
>>>>   +/* TODO: build xdp in big mode */
>>>> +static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>>> +                      struct virtnet_info *vi,
>>>> +                      struct receive_queue *rq,
>>>> +                      struct xdp_buff *xdp,
>>>> +                      void *buf,
>>>> +                      unsigned int len,
>>>> +                      unsigned int frame_sz,
>>>> +                      u16 *num_buf,
>>>> +                      unsigned int *xdp_frags_truesize,
>>>> +                      struct virtnet_rq_stats *stats)
>>>> +{
>>>> +    unsigned int tailroom = SKB_DATA_ALIGN(sizeof(struct 
>>>> skb_shared_info));
>>>> +    struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
>>>> +    unsigned int truesize, headroom;
>>>> +    struct skb_shared_info *shinfo;
>>>> +    unsigned int xdp_frags_truesz = 0;
>>>> +    unsigned int cur_frag_size;
>>>> +    struct page *page;
>>>> +    skb_frag_t *frag;
>>>> +    int offset;
>>>> +    void *ctx;
>>>> +
>>>> +    xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
>>>> +    xdp_prepare_buff(xdp, buf - VIRTIO_XDP_HEADROOM,
>>>> +             VIRTIO_XDP_HEADROOM + vi->hdr_len, len - vi->hdr_len, 
>>>> true);
>>>> +
>>>> +    if (*num_buf > 1) {
>>>> +        shinfo = xdp_get_shared_info_from_buff(xdp);
>>>> +        shinfo->nr_frags = 0;
>>>> +        shinfo->xdp_frags_size = 0;
>>>> +    }
>>>> +
>>>> +    if ((*num_buf - 1) > MAX_SKB_FRAGS)
>>>> +        return -EINVAL;
>>>> +
>>>> +    while ((--*num_buf) >= 1) {
>>>> +        buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
>>>> +        if (unlikely(!buf)) {
>>>> +            pr_debug("%s: rx error: %d buffers out of %d missing\n",
>>>> +                 dev->name, *num_buf,
>>>> +                 virtio16_to_cpu(vi->vdev, hdr->num_buffers));
>>>> +            dev->stats.rx_length_errors++;
>>>> +            return -EINVAL;
>>>> +        }
>>>> +
>>>> +        if (!xdp_buff_has_frags(xdp))
>>>> +            xdp_buff_set_frags_flag(xdp);
>>>
>>>
>>> Any reason to put this inside the loop?
>>
>> I'll move it outside the loop in the next version.
>>
>>>
>>>
>>>> +
>>>> +        stats->bytes += len;
>>>> +        page = virt_to_head_page(buf);
>>>> +        offset = buf - page_address(page);
>>>> +        truesize = mergeable_ctx_to_truesize(ctx);
>>>> +        headroom = mergeable_ctx_to_headroom(ctx);
>>>> +
>>>> +        cur_frag_size = truesize + (headroom ? (headroom + 
>>>> tailroom) : 0);
>>>> +        xdp_frags_truesz += cur_frag_size;
>>>
>>>
>>> Not related to this patch, but it would easily confuse the future 
>>> readers that the we need another math for truesize. I think at least 
>>> we need some comments for this or
>>
>> Yes it might, I'll add more comments on this.
>>
>>>
>>> I guess the root cause is in get_mergeable_buf_len:
>>>
>>> static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>>>                                       struct ewma_pkt_len *avg_pkt_len,
>>>                                           unsigned int room)
>>> {
>>>         struct virtnet_info *vi = rq->vq->vdev->priv;
>>>         const size_t hdr_len = vi->hdr_len;
>>>         unsigned int len;
>>>
>>>         if (room)
>>>         return PAGE_SIZE - room;
>>>
>>> And we do
>>>
>>>     len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>>
>>>     ...
>>>
>>>     ctx = mergeable_len_to_ctx(len, headroom);
>>>
>>>
>>> I wonder if it's better to pack the real truesize (PAGE_SIZE) here. 
>>> This may ease a lot of things.
>>
>> I don't know the historical reason for not packing, but I guess this 
>> is for the convenience of
>> comparing the actual length len given by the device with truesize. 
>> Therefore, I think it would
>> be better to keep the above practice for now?
>
>
> The problem is:
>
> We had
>
> static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
>
> It means the truesize should be calculated before packing into the 
> context. So having another math to get truesize is very confusing, I 
> think it's better to fix that. Otherwise we may end up code that is 
> hard to be reviewed even with the help of comments.

It is reasonable to let truesize return to its literal meaning, which 
includes the length of
headroom and tailroom, and I will modify this in the next version.

Thanks.

>
> Thanks
>
>
>> Perhaps, I can add more explanation to the
>> above code to help future readers try not to get confused.
>>
>> Thanks.
>>
>>>
>>> Thanks
>>>
>>>
>>>> +        if (unlikely(len > truesize || cur_frag_size > PAGE_SIZE)) {
>>>> +            pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
>>>> +                 dev->name, len, (unsigned long)ctx);
>>>> +            dev->stats.rx_length_errors++;
>>>> +            return -EINVAL;
>>>> +        }
>>>> +
>>>> +        frag = &shinfo->frags[shinfo->nr_frags++];
>>>> +        __skb_frag_set_page(frag, page);
>>>> +        skb_frag_off_set(frag, offset);
>>>> +        skb_frag_size_set(frag, len);
>>>> +        if (page_is_pfmemalloc(page))
>>>> +            xdp_buff_set_frag_pfmemalloc(xdp);
>>>> +
>>>> +        shinfo->xdp_frags_size += len;
>>>> +    }
>>>> +
>>>> +    *xdp_frags_truesize = xdp_frags_truesz;
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>                        struct virtnet_info *vi,
>>>>                        struct receive_queue *rq,
>>

