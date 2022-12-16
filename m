Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AB764E8C0
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 10:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLPJmg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 04:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLPJmf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 04:42:35 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C7F2FBED;
        Fri, 16 Dec 2022 01:42:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VXQWMPN_1671183747;
Received: from 30.221.146.235(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VXQWMPN_1671183747)
          by smtp.aliyun-inc.com;
          Fri, 16 Dec 2022 17:42:28 +0800
Message-ID: <a3fa0618-1301-6b21-4ebd-72e5f27d01c0@linux.alibaba.com>
Date:   Fri, 16 Dec 2022 17:42:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:108.0)
 Gecko/20100101 Thunderbird/108.0
Subject: Re: [RFC PATCH 6/9] virtio_net: construct multi-buffer xdp in
 mergeable
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>
References: <20221122074348.88601-1-hengqi@linux.alibaba.com>
 <20221122074348.88601-7-hengqi@linux.alibaba.com>
 <CACGkMEsbX8w1wuU+954zVwNT5JvCHX7a9baKRytVb641UmNsuw@mail.gmail.com>
 <8b143235-2e74-eddf-4c22-a36d679d093e@linux.alibaba.com>
 <CACGkMEsX=p4VM0yW0E3oaO=hBJx6y2x8fDkChh=ju13Y_tmjVA@mail.gmail.com>
 <20221214083750.GB56694@h68b04307.sqa.eu95>
 <CACGkMEu4a0B8_3sWisnQ4PjAURfqTa8mWC8HWWHaW3QFv4EBjA@mail.gmail.com>
From:   Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEu4a0B8_3sWisnQ4PjAURfqTa8mWC8HWWHaW3QFv4EBjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



在 2022/12/16 上午11:46, Jason Wang 写道:
> On Wed, Dec 14, 2022 at 4:38 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> On Tue, Dec 13, 2022 at 03:08:46PM +0800, Jason Wang wrote:
>>> On Thu, Dec 8, 2022 at 4:30 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>
>>>>
>>>> 在 2022/12/6 下午2:33, Jason Wang 写道:
>>>>> On Tue, Nov 22, 2022 at 3:44 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>> Build multi-buffer xdp using virtnet_build_xdp_buff() in mergeable.
>>>>>>
>>>>>> For the prefilled buffer before xdp is set, vq reset can be
>>>>>> used to clear it, but most devices do not support it at present.
>>>>>> In order not to bother users who are using xdp normally, we do
>>>>>> not use vq reset for the time being.
>>>>> I guess to tweak the part to say we will probably use vq reset in the future.
>>>> OK, it works.
>>>>
>>>>>> At the same time, virtio
>>>>>> net currently uses comp pages, and bpf_xdp_frags_increase_tail()
>>>>>> needs to calculate the tailroom of the last frag, which will
>>>>>> involve the offset of the corresponding page and cause a negative
>>>>>> value, so we disable tail increase by not setting xdp_rxq->frag_size.
>>>>>>
>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>>> ---
>>>>>>    drivers/net/virtio_net.c | 67 +++++++++++++++++++++++-----------------
>>>>>>    1 file changed, 38 insertions(+), 29 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>> index 20784b1d8236..83e6933ae62b 100644
>>>>>> --- a/drivers/net/virtio_net.c
>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>> @@ -994,6 +994,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>>>                                            unsigned int *xdp_xmit,
>>>>>>                                            struct virtnet_rq_stats *stats)
>>>>>>    {
>>>>>> +       unsigned int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>>>>>           struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
>>>>>>           u16 num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>>>>>>           struct page *page = virt_to_head_page(buf);
>>>>>> @@ -1024,53 +1025,50 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>>>           rcu_read_lock();
>>>>>>           xdp_prog = rcu_dereference(rq->xdp_prog);
>>>>>>           if (xdp_prog) {
>>>>>> +               unsigned int xdp_frags_truesz = 0;
>>>>>> +               struct skb_shared_info *shinfo;
>>>>>>                   struct xdp_frame *xdpf;
>>>>>>                   struct page *xdp_page;
>>>>>>                   struct xdp_buff xdp;
>>>>>>                   void *data;
>>>>>>                   u32 act;
>>>>>> +               int i;
>>>>>>
>>>>>> -               /* Transient failure which in theory could occur if
>>>>>> -                * in-flight packets from before XDP was enabled reach
>>>>>> -                * the receive path after XDP is loaded.
>>>>>> -                */
>>>>>> -               if (unlikely(hdr->hdr.gso_type))
>>>>>> -                       goto err_xdp;
>>>>> Two questions:
>>>>>
>>>>> 1) should we keep this check for the XDP program that can't deal with XDP frags?
>>>> Yes, the problem is the same as the xdp program without xdp.frags when
>>>> GRO_HW, I will correct it.
>>>>
>>>>> 2) how could we guarantee that the vnet header (gso_type/csum_start
>>>>> etc) is still valid after XDP (where XDP program can choose to
>>>>> override the header)?
>>>> We can save the vnet headr before the driver receives the packet and
>>>> build xdp_buff, and then use
>>>> the pre-saved value in the subsequent process.
>>> The problem is that XDP may modify the packet (header) so some fields
>>> are not valid any more (e.g csum_start/offset ?).
>>>
>>> If I was not wrong, there's no way for the XDP program to access those
>>> fields or does it support it right now?
>>>
>> When guest_csum feature is negotiated, xdp cannot be set, because the metadata
>> of xdp_{buff, frame} may be adjusted by the bpf program, therefore,
>> csum_{start, offset} itself is invalid. And at the same time,
>> multi-buffer xdp programs should only Receive packets over larger MTU, so
>> we don't need gso related information anymore and need to disable GRO_HW.
> Ok, that's fine.
>
> (But it requires a large pMTU).

Yes. Like a jumbo frame that larger than 4K.

Thanks.

>
> Thanks
>
>> Thanks.
>>
>>>>>> -
>>>>>> -               /* Buffers with headroom use PAGE_SIZE as alloc size,
>>>>>> -                * see add_recvbuf_mergeable() + get_mergeable_buf_len()
>>>>>> +               /* Now XDP core assumes frag size is PAGE_SIZE, but buffers
>>>>>> +                * with headroom may add hole in truesize, which
>>>>>> +                * make their length exceed PAGE_SIZE. So we disabled the
>>>>>> +                * hole mechanism for xdp. See add_recvbuf_mergeable().
>>>>>>                    */
>>>>>>                   frame_sz = headroom ? PAGE_SIZE : truesize;
>>>>>>
>>>>>> -               /* This happens when rx buffer size is underestimated
>>>>>> -                * or headroom is not enough because of the buffer
>>>>>> -                * was refilled before XDP is set. This should only
>>>>>> -                * happen for the first several packets, so we don't
>>>>>> -                * care much about its performance.
>>>>>> +               /* This happens when headroom is not enough because
>>>>>> +                * of the buffer was prefilled before XDP is set.
>>>>>> +                * This should only happen for the first several packets.
>>>>>> +                * In fact, vq reset can be used here to help us clean up
>>>>>> +                * the prefilled buffers, but many existing devices do not
>>>>>> +                * support it, and we don't want to bother users who are
>>>>>> +                * using xdp normally.
>>>>>>                    */
>>>>>> -               if (unlikely(num_buf > 1 ||
>>>>>> -                            headroom < virtnet_get_headroom(vi))) {
>>>>>> -                       /* linearize data for XDP */
>>>>>> -                       xdp_page = xdp_linearize_page(rq, &num_buf,
>>>>>> -                                                     page, offset,
>>>>>> -                                                     VIRTIO_XDP_HEADROOM,
>>>>>> -                                                     &len);
>>>>>> -                       frame_sz = PAGE_SIZE;
>>>>>> +               if (unlikely(headroom < virtnet_get_headroom(vi))) {
>>>>>> +                       if ((VIRTIO_XDP_HEADROOM + len + tailroom) > PAGE_SIZE)
>>>>>> +                               goto err_xdp;
>>>>>>
>>>>>> +                       xdp_page = alloc_page(GFP_ATOMIC);
>>>>>>                           if (!xdp_page)
>>>>>>                                   goto err_xdp;
>>>>>> +
>>>>>> +                       memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM,
>>>>>> +                              page_address(page) + offset, len);
>>>>>> +                       frame_sz = PAGE_SIZE;
>>>>> How can we know a single page is sufficient here? (before XDP is set,
>>>>> we reserve neither headroom nor tailroom).
>>>> This is only for the first buffer, refer to add_recvbuf_mergeable() and
>>>> get_mergeable_buf_len() A buffer is always no larger than a page.
>>> Ok.
>>>
>>> Thanks
>>>
>>>>>>                           offset = VIRTIO_XDP_HEADROOM;
>>>>> I think we should still try to do linearization for the XDP program
>>>>> that doesn't support XDP frags.
>>>> Yes, you are right.
>>>>
>>>> Thanks.
>>>>
>>>>> Thanks
>>>>>
>>>>>>                   } else {
>>>>>>                           xdp_page = page;
>>>>>>                   }
>>>>>> -
>>>>>> -               /* Allow consuming headroom but reserve enough space to push
>>>>>> -                * the descriptor on if we get an XDP_TX return code.
>>>>>> -                */
>>>>>>                   data = page_address(xdp_page) + offset;
>>>>>> -               xdp_init_buff(&xdp, frame_sz - vi->hdr_len, &rq->xdp_rxq);
>>>>>> -               xdp_prepare_buff(&xdp, data - VIRTIO_XDP_HEADROOM + vi->hdr_len,
>>>>>> -                                VIRTIO_XDP_HEADROOM, len - vi->hdr_len, true);
>>>>>> +               err = virtnet_build_xdp_buff(dev, vi, rq, &xdp, data, len, frame_sz,
>>>>>> +                                            &num_buf, &xdp_frags_truesz, stats);
>>>>>> +               if (unlikely(err))
>>>>>> +                       goto err_xdp_frags;
>>>>>>
>>>>>>                   act = bpf_prog_run_xdp(xdp_prog, &xdp);
>>>>>>                   stats->xdp_packets++;
>>>>>> @@ -1164,6 +1162,17 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>>>                                   __free_pages(xdp_page, 0);
>>>>>>                           goto err_xdp;
>>>>>>                   }
>>>>>> +err_xdp_frags:
>>>>>> +               shinfo = xdp_get_shared_info_from_buff(&xdp);
>>>>>> +
>>>>>> +               if (unlikely(xdp_page != page))
>>>>>> +                       __free_pages(xdp_page, 0);
>>>>>> +
>>>>>> +               for (i = 0; i < shinfo->nr_frags; i++) {
>>>>>> +                       xdp_page = skb_frag_page(&shinfo->frags[i]);
>>>>>> +                       put_page(xdp_page);
>>>>>> +               }
>>>>>> +               goto err_xdp;
>>>>>>           }
>>>>>>           rcu_read_unlock();
>>>>>>
>>>>>> --
>>>>>> 2.19.1.6.gb485710b
>>>>>>

