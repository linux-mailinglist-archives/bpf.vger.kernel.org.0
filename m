Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ECF657334
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 07:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiL1G2L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 01:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiL1G2G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 01:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF3AC77B
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 22:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672208836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZhnhwsCsqiTBlDzCxScbr8G6znvrEy+rp6SgZEzfiI8=;
        b=bZBvxyvbVvq1G1UIPBL6pDrGVUqV9PnyHJvFBl+5n4WoujLl1eERjqGM8gvFcF/CMr74Qb
        iICLng6RXN/bqljmRTD7WMOtFT2vWBc021KpEy+GVToCf3J08ziHvvze1xwI3jzumOJEXQ
        uOQpZFo+lvWx0cTRDpzd2m0VCz6H2+k=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-18-ZmPGrI5lO9WaD5131z0Spw-1; Wed, 28 Dec 2022 01:27:12 -0500
X-MC-Unique: ZmPGrI5lO9WaD5131z0Spw-1
Received: by mail-pj1-f71.google.com with SMTP id k2-20020a17090a514200b002198214abdcso6384407pjm.8
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 22:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhnhwsCsqiTBlDzCxScbr8G6znvrEy+rp6SgZEzfiI8=;
        b=aTZBbMAU8ZhP9/y0K8LAsjOCV7KtszU3sv5QiM5/GqREfgJnXsRr1GVRKzyLu8fBZP
         NVjKYk7Q3GDR451QhsZwYaSGN9s9MRNV9vg4LtV+U/OlNHkiXrhsqQcER3sBaVQw0JUy
         rklE1DhEaMhfUwSlYJyBOEpOmtdFQBDs8KxT/5X8dJRM7M0XLPig4DDELTmq3nB0TP1Q
         F7nyRSyFKSA9gbznoPs3s7vKvqUXQh85DbvhdpYscJZHw6PLivsXDvVi8dMvU/6PyAEJ
         lqs3SR5k1BWvn1uYP/jUz1wxRfUx6kAI1wDDI089+rjj1og/tdvFTs7N+T/EFYLYEs6F
         I/ug==
X-Gm-Message-State: AFqh2ko6XRN1q6PLId6XwKC3vYb/AqVqMz0yGl7YVOrvT8PGmtXU1cd0
        +3GBZhARURE3XPfOugI6PhmXyP4sDVfSPFpb6baHs+/5NtDSxYcY7rBIQ0APmv4pZR8/45C/5Lf
        QcpD54N3Gc2w8
X-Received: by 2002:a17:903:32cc:b0:189:129e:92af with SMTP id i12-20020a17090332cc00b00189129e92afmr37585384plr.14.1672208831715;
        Tue, 27 Dec 2022 22:27:11 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsxmviCwBKxPdR53d6TC6QsJ/zE4i/cQT054O4zkssSgbF68ohT2s8YpthNwgUNk4IEx8LLxQ==
X-Received: by 2002:a17:903:32cc:b0:189:129e:92af with SMTP id i12-20020a17090332cc00b00189129e92afmr37585370plr.14.1672208831458;
        Tue, 27 Dec 2022 22:27:11 -0800 (PST)
Received: from [10.72.13.7] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f7cb00b001869f2120a6sm10167184plw.108.2022.12.27.22.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 22:27:11 -0800 (PST)
Message-ID: <219fae4f-6ab6-7241-2597-267e426c8a3c@redhat.com>
Date:   Wed, 28 Dec 2022 14:27:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/9] virtio_net: build xdp_buff with multi buffers
Content-Language: en-US
To:     Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
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
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <8aa5b8fb-d766-ac84-dfc1-4f9947e86e27@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/12/27 17:10, Heng Qi 写道:
>
>
> 在 2022/12/27 下午2:46, Jason Wang 写道:
>>
>> 在 2022/12/20 22:14, Heng Qi 写道:
>>> Support xdp for multi buffer packets in mergeable mode.
>>>
>>> Putting the first buffer as the linear part for xdp_buff,
>>> and the rest of the buffers as non-linear fragments to struct
>>> skb_shared_info in the tailroom belonging to xdp_buff.
>>>
>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> ---
>>>   drivers/net/virtio_net.c | 78 
>>> ++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 78 insertions(+)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index 08f209d7b0bf..8fc3b1841d92 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -931,6 +931,84 @@ static struct sk_buff *receive_big(struct 
>>> net_device *dev,
>>>       return NULL;
>>>   }
>>>   +/* TODO: build xdp in big mode */
>>> +static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>> +                      struct virtnet_info *vi,
>>> +                      struct receive_queue *rq,
>>> +                      struct xdp_buff *xdp,
>>> +                      void *buf,
>>> +                      unsigned int len,
>>> +                      unsigned int frame_sz,
>>> +                      u16 *num_buf,
>>> +                      unsigned int *xdp_frags_truesize,
>>> +                      struct virtnet_rq_stats *stats)
>>> +{
>>> +    unsigned int tailroom = SKB_DATA_ALIGN(sizeof(struct 
>>> skb_shared_info));
>>> +    struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
>>> +    unsigned int truesize, headroom;
>>> +    struct skb_shared_info *shinfo;
>>> +    unsigned int xdp_frags_truesz = 0;
>>> +    unsigned int cur_frag_size;
>>> +    struct page *page;
>>> +    skb_frag_t *frag;
>>> +    int offset;
>>> +    void *ctx;
>>> +
>>> +    xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
>>> +    xdp_prepare_buff(xdp, buf - VIRTIO_XDP_HEADROOM,
>>> +             VIRTIO_XDP_HEADROOM + vi->hdr_len, len - vi->hdr_len, 
>>> true);
>>> +
>>> +    if (*num_buf > 1) {
>>> +        shinfo = xdp_get_shared_info_from_buff(xdp);
>>> +        shinfo->nr_frags = 0;
>>> +        shinfo->xdp_frags_size = 0;
>>> +    }
>>> +
>>> +    if ((*num_buf - 1) > MAX_SKB_FRAGS)
>>> +        return -EINVAL;
>>> +
>>> +    while ((--*num_buf) >= 1) {
>>> +        buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
>>> +        if (unlikely(!buf)) {
>>> +            pr_debug("%s: rx error: %d buffers out of %d missing\n",
>>> +                 dev->name, *num_buf,
>>> +                 virtio16_to_cpu(vi->vdev, hdr->num_buffers));
>>> +            dev->stats.rx_length_errors++;
>>> +            return -EINVAL;
>>> +        }
>>> +
>>> +        if (!xdp_buff_has_frags(xdp))
>>> +            xdp_buff_set_frags_flag(xdp);
>>
>>
>> Any reason to put this inside the loop?
>
> I'll move it outside the loop in the next version.
>
>>
>>
>>> +
>>> +        stats->bytes += len;
>>> +        page = virt_to_head_page(buf);
>>> +        offset = buf - page_address(page);
>>> +        truesize = mergeable_ctx_to_truesize(ctx);
>>> +        headroom = mergeable_ctx_to_headroom(ctx);
>>> +
>>> +        cur_frag_size = truesize + (headroom ? (headroom + 
>>> tailroom) : 0);
>>> +        xdp_frags_truesz += cur_frag_size;
>>
>>
>> Not related to this patch, but it would easily confuse the future 
>> readers that the we need another math for truesize. I think at least 
>> we need some comments for this or
>
> Yes it might, I'll add more comments on this.
>
>>
>> I guess the root cause is in get_mergeable_buf_len:
>>
>> static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>>                                       struct ewma_pkt_len *avg_pkt_len,
>>                                           unsigned int room)
>> {
>>         struct virtnet_info *vi = rq->vq->vdev->priv;
>>         const size_t hdr_len = vi->hdr_len;
>>         unsigned int len;
>>
>>         if (room)
>>         return PAGE_SIZE - room;
>>
>> And we do
>>
>>     len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>
>>     ...
>>
>>     ctx = mergeable_len_to_ctx(len, headroom);
>>
>>
>> I wonder if it's better to pack the real truesize (PAGE_SIZE) here. 
>> This may ease a lot of things.
>
> I don't know the historical reason for not packing, but I guess this 
> is for the convenience of
> comparing the actual length len given by the device with truesize. 
> Therefore, I think it would
> be better to keep the above practice for now?


The problem is:

We had

static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)

It means the truesize should be calculated before packing into the 
context. So having another math to get truesize is very confusing, I 
think it's better to fix that. Otherwise we may end up code that is hard 
to be reviewed even with the help of comments.

Thanks


> Perhaps, I can add more explanation to the
> above code to help future readers try not to get confused.
>
> Thanks.
>
>>
>> Thanks
>>
>>
>>> +        if (unlikely(len > truesize || cur_frag_size > PAGE_SIZE)) {
>>> +            pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
>>> +                 dev->name, len, (unsigned long)ctx);
>>> +            dev->stats.rx_length_errors++;
>>> +            return -EINVAL;
>>> +        }
>>> +
>>> +        frag = &shinfo->frags[shinfo->nr_frags++];
>>> +        __skb_frag_set_page(frag, page);
>>> +        skb_frag_off_set(frag, offset);
>>> +        skb_frag_size_set(frag, len);
>>> +        if (page_is_pfmemalloc(page))
>>> +            xdp_buff_set_frag_pfmemalloc(xdp);
>>> +
>>> +        shinfo->xdp_frags_size += len;
>>> +    }
>>> +
>>> +    *xdp_frags_truesize = xdp_frags_truesz;
>>> +    return 0;
>>> +}
>>> +
>>>   static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>                        struct virtnet_info *vi,
>>>                        struct receive_queue *rq,
>

