Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2395F740E32
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 12:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjF1KHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 06:07:06 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124]:20465 "EHLO
        out30-124.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235394AbjF1KCp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Jun 2023 06:02:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vm9ReOA_1687946560;
Received: from 30.221.150.33(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vm9ReOA_1687946560)
          by smtp.aliyun-inc.com;
          Wed, 28 Jun 2023 18:02:41 +0800
Message-ID: <620af708-42a0-f711-cd7c-43362751c842@linux.alibaba.com>
Date:   Wed, 28 Jun 2023 18:02:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v4 1/2] virtio-net: support coexistence of XDP
 and GUEST_CSUM
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230628030506.2213-1-hengqi@linux.alibaba.com>
 <20230628030506.2213-2-hengqi@linux.alibaba.com>
 <CACGkMEv7aVH0dgdd6N3RMH+57BWuxnq9NR8sPzD9wRQZ5TZRFQ@mail.gmail.com>
 <c6411922-51ad-3d8f-88aa-28883b44573d@linux.alibaba.com>
 <CACGkMEu=Cs5DFP+EFqxUXaiqz7vewhQ5zMMtChGpR_oGjrvMCg@mail.gmail.com>
 <20230628045626.GA32321@h68b04307.sqa.eu95>
 <CACGkMEt6Kb60Akn=aJjzJQg6Zg8F_24ezqAtwPOZxiu4-f7E3g@mail.gmail.com>
From:   Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEt6Kb60Akn=aJjzJQg6Zg8F_24ezqAtwPOZxiu4-f7E3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



在 2023/6/28 下午2:50, Jason Wang 写道:
> On Wed, Jun 28, 2023 at 12:56 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> On Wed, Jun 28, 2023 at 12:02:17PM +0800, Jason Wang wrote:
>>> On Wed, Jun 28, 2023 at 11:42 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>
>>>>
>>>> 在 2023/6/28 上午11:22, Jason Wang 写道:
>>>>> On Wed, Jun 28, 2023 at 11:05 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>> We are now re-probing the csum related fields and trying
>>>>>> to have XDP and RX hw checksum capabilities coexist on the
>>>>>> XDP path. For the benefit of:
>>>>>> 1. RX hw checksum capability can be used if XDP is loaded.
>>>>>> 2. Avoid packet loss when loading XDP in the vm-vm scenario.
>>>>>>
>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>>> ---
>>>>>> v3->v4:
>>>>>>     - Rewrite some comments.
>>>>>>
>>>>>> v2->v3:
>>>>>>     - Use skb_checksum_setup() instead of virtnet_flow_dissect_udp_tcp().
>>>>>>       Essentially equivalent.
>>>>>>
>>>>>>    drivers/net/virtio_net.c | 82 +++++++++++++++++++++++++++++++++-------
>>>>>>    1 file changed, 69 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>> index 5a7f7a76b920..a47342f972b5 100644
>>>>>> --- a/drivers/net/virtio_net.c
>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>> @@ -1568,6 +1568,41 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
>>>>>>           skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
>>>>>>    }
>>>>>>
>>>>>> +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
>>>>>> +                                     struct sk_buff *skb,
>>>>>> +                                     __u8 flags)
>>>>>> +{
>>>>>> +       int err = 0;
>>>>>> +
>>>>>> +       /* When XDP program is loaded, the vm-vm scenario on the same host,
>>>>>> +        * packets marked VIRTIO_NET_HDR_F_NEEDS_CSUM without a complete checksum
>>>>>> +        * will travel. Although these packets are safe from the point of
>>>>>> +        * view of the vm, in order to be successfully forwarded on the upper
>>>>>> +        * layer and to avoid packet loss caused by XDP modification,
>>>>>> +        * we re-probe the necessary checksum related information:
>>>>>> +        * skb->csum_{start, offset}, pseudo-header checksum.
>>>>>> +        *
>>>>>> +        * If the received packet is marked VIRTIO_NET_HDR_F_DATA_VALID:
>>>>>> +        * when _F_GUEST_CSUM is negotiated, the device validates the checksum
>>>>>> +        * and virtio-net sets skb->ip_summed to CHECKSUM_UNNECESSARY;
>>>>>> +        * otherwise, virtio-net hands over to the stack to validate the checksum.
>>>>>> +        */
>>>>>> +       if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
>>>>>> +               /* No need to care about SCTP because virtio-net currently doesn't
>>>>>> +                * support SCTP CRC checksum offloading, that is, SCTP packets have
>>>>>> +                * complete checksums.
>>>>>> +                */
>>>>>> +               err = skb_checksum_setup(skb, true);
>>>>> A second thought, any reason why a checksum is a must here. Could we simply:
>>>> When net.ipv4.ip_forward sysctl is enabled, such packets may be
>>>> forwarded (return to the tx path) at the IP layer.
>>>> If the device has the tx hw checksum offloading cap, packets will have
>>>> complete checksums based on our calculated 'check' value.
>>> Actually, I mean why can't we offload the checksum to the hardware in this case?
>> Yes that's what I explained:)
>>
>> Checksum of udp/tcp includes the pseudo-header checksum and the checksum of the entire udp/tcp payload.
>> When tx checksum offloading is enabled, the upper layer will only calculate the pseudo-header checksum,
>> and the rest of the checksum of the entire udp/tcp payload will be calculated by hardware.
>>
>>
>> Please see udp_send_skb():
>>
>> "
>>          } else if (skb->ip_summed == CHECKSUM_PARTIAL) { /* UDP hardware csum */
>> csum_partial:
>>
>>                  udp4_hwcsum(skb, fl4->saddr, fl4->daddr);
>>                  goto send;
>>
>>          } else
>>                  csum = udp_csum(skb);
>>
>>          /* add protocol-dependent pseudo-header */
>>          uh->check = csum_tcpudp_magic(fl4->saddr, fl4->daddr, len,
>>                                        sk->sk_protocol, csum);
>>          if (uh->check == 0)
>>                  uh->check = CSUM_MANGLED_0;
>>
>> send:
>>          err = ip_send_skb(sock_net(sk), skb);
>> "
> Ok, so I think what I missed is that the CHECKSUM_PARTIAL is set up by
> skb_checksum_setup() so we don't even need to care about that.

Yes. It works fine after skb_checksum_setup().

>
>>>>> 1) probe the csum_start/offset
>>>>> 2) leave it as CHECKSUM_PARTIAL
>>>>>
>>>>> ?
>>>> The reason is as I explained above.
>>>>
>>>>>> +       } else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
>>>>>> +               /* XDP guarantees that packets marked as VIRTIO_NET_HDR_F_DATA_VALID
>>>>>> +                * still have correct checksum after they are processed.
>>>>>> +                */
>>>>> Do you mean it's the charge of the XDP program to calculate the csum
>>>>> in this case? Seems strange.
>>>> Packet with complete checksum (and has been verified by rx device
>>>> because it has VIRTIO_NET_HDR_F_DATA_VALID)
>>>> when modified by XDP, XDP program should use the helper provided by XDP
>>>> core to make the checksum correct,
>>> Could you give me a pointer to that helper?
>> bpf_csum_diff(),
> Ok.
>
>> bpf_{l3,l4}_csum_replace()
> This seems not to be a helpr for XDP but for other bpf like cls.

Yes.

>
>>> Btw, is there a way for
>>> the XDP program to know whether the csum has been verified by the
>>> device? ( I guess not).
>>>
>> Not. But we only do this (mark skb->ip_summed = CHECKSUM_UNNECESSARY) for packets with VIRTIO_NET_HDR_F_DATA_VALID now.
> So if I understand you correctly, you meant for the XDP program that
> wants to modify the packet:
>
> 1) check whether the checksum is valid
> 2) if yes, recalculate the checksum after the modification
> 3) if not, just do nothing for the checksum and the driver need to
> re-probe the csum_start/offset
>
> ?

I don't think we need to make many assumptions about the behavior of XDP 
programs.
Because we are out of control for various users using XDP.

The core purpose of this patch is to:
#1 Solve the packet loss problem caused by loading XDP between vm-vm on 
the same host (scenario with partial checksum).
#2 For scenarios other than #1, virtio-net with this patch is already 
consistent with other existing NIC drivers (simple such as 
ixgbe[1]/bnxt[2]/mvneta[3]/..):
the rx side only needs to have NETIF_F_RXCSUM and the device has 
verified the packet has a valid checksum.
Then skb converted from xdp_buff (XDP returns XDP_PASS) can have 
skb->ip_summed = CHECKSUM_UNNECESSARY.

If the comment for DATA_VALID is confusing, I'll just remove it.

[1] ixgbe_clean_rx_irq()-> ixgbe_run_xdp()-> ixgbe_process_skb_fields() 
->ixgbe_rx_checksum()
[2] bnxt_xdp_build_skb()
[3] mvneta_swbm_build_skb

Thanks.

>
> Thanks
>
>> Thanks.
>>
>>> Thanks
>>>
>>>
>>>> otherwise, VIRTIO_NET_HDR_F_DATA_VALID has been cleared and skb
>>>> ->ip_summed=CHECKSUM_NONE, so the stack
>>>> will re-verify the checksum, causing packet loss due to wrong checksum.
>>>>
>>>> Thanks.
>>>>
>>>>> Thanks
>>>>>
>>>>>> +               skb->ip_summed = CHECKSUM_UNNECESSARY;
>>>>>> +       }
>>>>>> +
>>>>>> +       return err;
>>>>>> +}
>>>>>> +
>>>>>>    static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>>>>>                           void *buf, unsigned int len, void **ctx,
>>>>>>                           unsigned int *xdp_xmit,
>>>>>> @@ -1576,6 +1611,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>>>>>           struct net_device *dev = vi->dev;
>>>>>>           struct sk_buff *skb;
>>>>>>           struct virtio_net_hdr_mrg_rxbuf *hdr;
>>>>>> +       __u8 flags;
>>>>>>
>>>>>>           if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>>>>>>                   pr_debug("%s: short packet %i\n", dev->name, len);
>>>>>> @@ -1584,6 +1620,12 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>>>>>                   return;
>>>>>>           }
>>>>>>
>>>>>> +       /* XDP may modify/overwrite the packet, including the virtnet hdr,
>>>>>> +        * so save the flags of the virtnet hdr before XDP processing.
>>>>>> +        */
>>>>>> +       if (unlikely(vi->xdp_enabled))
>>>>>> +               flags = ((struct virtio_net_hdr_mrg_rxbuf *)buf)->hdr.flags;
>>>>>> +
>>>>>>           if (vi->mergeable_rx_bufs)
>>>>>>                   skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>>>>>>                                           stats);
>>>>>> @@ -1595,23 +1637,37 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>>>>>           if (unlikely(!skb))
>>>>>>                   return;
>>>>>>
>>>>>> -       hdr = skb_vnet_hdr(skb);
>>>>>> -       if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
>>>>>> -               virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
>>>>>> -
>>>>>> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>>>>>> -               skb->ip_summed = CHECKSUM_UNNECESSARY;
>>>>>> +       if (unlikely(vi->xdp_enabled)) {
>>>>>> +               /* Required to do this before re-probing and calculating
>>>>>> +                * the pseudo-header checksum.
>>>>>> +                */
>>>>>> +               skb->protocol = eth_type_trans(skb, dev);
>>>>>> +               skb_reset_network_header(skb);
>>>>>> +               if (virtnet_set_csum_after_xdp(vi, skb, flags) < 0) {
>>>>>> +                       pr_debug("%s: errors occurred in setting partial csum",
>>>>>> +                                dev->name);
>>>>>> +                       goto frame_err;
>>>>>> +               }
>>>>>> +       } else {
>>>>>> +               hdr = skb_vnet_hdr(skb);
>>>>>> +               if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
>>>>>> +                       virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
>>>>>> +
>>>>>> +               if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>>>>>> +                       skb->ip_summed = CHECKSUM_UNNECESSARY;
>>>>>> +
>>>>>> +               if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
>>>>>> +                                         virtio_is_little_endian(vi->vdev))) {
>>>>>> +                       net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
>>>>>> +                                            dev->name, hdr->hdr.gso_type,
>>>>>> +                                            hdr->hdr.gso_size);
>>>>>> +                       goto frame_err;
>>>>>> +               }
>>>>>>
>>>>>> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
>>>>>> -                                 virtio_is_little_endian(vi->vdev))) {
>>>>>> -               net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
>>>>>> -                                    dev->name, hdr->hdr.gso_type,
>>>>>> -                                    hdr->hdr.gso_size);
>>>>>> -               goto frame_err;
>>>>>> +               skb->protocol = eth_type_trans(skb, dev);
>>>>>>           }
>>>>>>
>>>>>>           skb_record_rx_queue(skb, vq2rxq(rq->vq));
>>>>>> -       skb->protocol = eth_type_trans(skb, dev);
>>>>>>           pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
>>>>>>                    ntohs(skb->protocol), skb->len, skb->pkt_type);
>>>>>>
>>>>>> --
>>>>>> 2.19.1.6.gb485710b
>>>>>>

