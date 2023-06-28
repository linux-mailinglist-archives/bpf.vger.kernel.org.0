Return-Path: <bpf+bounces-3637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DA1740905
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 05:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DAF281188
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 03:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6064C97;
	Wed, 28 Jun 2023 03:41:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D43D74;
	Wed, 28 Jun 2023 03:41:53 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7808F1BE9;
	Tue, 27 Jun 2023 20:41:51 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vm89kP9_1687923707;
Received: from 30.221.150.33(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vm89kP9_1687923707)
          by smtp.aliyun-inc.com;
          Wed, 28 Jun 2023 11:41:48 +0800
Message-ID: <c6411922-51ad-3d8f-88aa-28883b44573d@linux.alibaba.com>
Date: Wed, 28 Jun 2023 11:41:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v4 1/2] virtio-net: support coexistence of XDP
 and GUEST_CSUM
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230628030506.2213-1-hengqi@linux.alibaba.com>
 <20230628030506.2213-2-hengqi@linux.alibaba.com>
 <CACGkMEv7aVH0dgdd6N3RMH+57BWuxnq9NR8sPzD9wRQZ5TZRFQ@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEv7aVH0dgdd6N3RMH+57BWuxnq9NR8sPzD9wRQZ5TZRFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/6/28 上午11:22, Jason Wang 写道:
> On Wed, Jun 28, 2023 at 11:05 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> We are now re-probing the csum related fields and trying
>> to have XDP and RX hw checksum capabilities coexist on the
>> XDP path. For the benefit of:
>> 1. RX hw checksum capability can be used if XDP is loaded.
>> 2. Avoid packet loss when loading XDP in the vm-vm scenario.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> v3->v4:
>>    - Rewrite some comments.
>>
>> v2->v3:
>>    - Use skb_checksum_setup() instead of virtnet_flow_dissect_udp_tcp().
>>      Essentially equivalent.
>>
>>   drivers/net/virtio_net.c | 82 +++++++++++++++++++++++++++++++++-------
>>   1 file changed, 69 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 5a7f7a76b920..a47342f972b5 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1568,6 +1568,41 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
>>          skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
>>   }
>>
>> +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
>> +                                     struct sk_buff *skb,
>> +                                     __u8 flags)
>> +{
>> +       int err = 0;
>> +
>> +       /* When XDP program is loaded, the vm-vm scenario on the same host,
>> +        * packets marked VIRTIO_NET_HDR_F_NEEDS_CSUM without a complete checksum
>> +        * will travel. Although these packets are safe from the point of
>> +        * view of the vm, in order to be successfully forwarded on the upper
>> +        * layer and to avoid packet loss caused by XDP modification,
>> +        * we re-probe the necessary checksum related information:
>> +        * skb->csum_{start, offset}, pseudo-header checksum.
>> +        *
>> +        * If the received packet is marked VIRTIO_NET_HDR_F_DATA_VALID:
>> +        * when _F_GUEST_CSUM is negotiated, the device validates the checksum
>> +        * and virtio-net sets skb->ip_summed to CHECKSUM_UNNECESSARY;
>> +        * otherwise, virtio-net hands over to the stack to validate the checksum.
>> +        */
>> +       if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
>> +               /* No need to care about SCTP because virtio-net currently doesn't
>> +                * support SCTP CRC checksum offloading, that is, SCTP packets have
>> +                * complete checksums.
>> +                */
>> +               err = skb_checksum_setup(skb, true);
> A second thought, any reason why a checksum is a must here. Could we simply:

When net.ipv4.ip_forward sysctl is enabled, such packets may be 
forwarded (return to the tx path) at the IP layer.
If the device has the tx hw checksum offloading cap, packets will have 
complete checksums based on our calculated 'check' value.

>
> 1) probe the csum_start/offset
> 2) leave it as CHECKSUM_PARTIAL
>
> ?

The reason is as I explained above.

>
>> +       } else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
>> +               /* XDP guarantees that packets marked as VIRTIO_NET_HDR_F_DATA_VALID
>> +                * still have correct checksum after they are processed.
>> +                */
> Do you mean it's the charge of the XDP program to calculate the csum
> in this case? Seems strange.

Packet with complete checksum (and has been verified by rx device 
because it has VIRTIO_NET_HDR_F_DATA_VALID)
when modified by XDP, XDP program should use the helper provided by XDP 
core to make the checksum correct,
otherwise, VIRTIO_NET_HDR_F_DATA_VALID has been cleared and skb 
->ip_summed=CHECKSUM_NONE, so the stack
will re-verify the checksum, causing packet loss due to wrong checksum.

Thanks.

>
> Thanks
>
>> +               skb->ip_summed = CHECKSUM_UNNECESSARY;
>> +       }
>> +
>> +       return err;
>> +}
>> +
>>   static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>                          void *buf, unsigned int len, void **ctx,
>>                          unsigned int *xdp_xmit,
>> @@ -1576,6 +1611,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>          struct net_device *dev = vi->dev;
>>          struct sk_buff *skb;
>>          struct virtio_net_hdr_mrg_rxbuf *hdr;
>> +       __u8 flags;
>>
>>          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>>                  pr_debug("%s: short packet %i\n", dev->name, len);
>> @@ -1584,6 +1620,12 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>                  return;
>>          }
>>
>> +       /* XDP may modify/overwrite the packet, including the virtnet hdr,
>> +        * so save the flags of the virtnet hdr before XDP processing.
>> +        */
>> +       if (unlikely(vi->xdp_enabled))
>> +               flags = ((struct virtio_net_hdr_mrg_rxbuf *)buf)->hdr.flags;
>> +
>>          if (vi->mergeable_rx_bufs)
>>                  skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>>                                          stats);
>> @@ -1595,23 +1637,37 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>          if (unlikely(!skb))
>>                  return;
>>
>> -       hdr = skb_vnet_hdr(skb);
>> -       if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
>> -               virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
>> -
>> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>> -               skb->ip_summed = CHECKSUM_UNNECESSARY;
>> +       if (unlikely(vi->xdp_enabled)) {
>> +               /* Required to do this before re-probing and calculating
>> +                * the pseudo-header checksum.
>> +                */
>> +               skb->protocol = eth_type_trans(skb, dev);
>> +               skb_reset_network_header(skb);
>> +               if (virtnet_set_csum_after_xdp(vi, skb, flags) < 0) {
>> +                       pr_debug("%s: errors occurred in setting partial csum",
>> +                                dev->name);
>> +                       goto frame_err;
>> +               }
>> +       } else {
>> +               hdr = skb_vnet_hdr(skb);
>> +               if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
>> +                       virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
>> +
>> +               if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>> +                       skb->ip_summed = CHECKSUM_UNNECESSARY;
>> +
>> +               if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
>> +                                         virtio_is_little_endian(vi->vdev))) {
>> +                       net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
>> +                                            dev->name, hdr->hdr.gso_type,
>> +                                            hdr->hdr.gso_size);
>> +                       goto frame_err;
>> +               }
>>
>> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
>> -                                 virtio_is_little_endian(vi->vdev))) {
>> -               net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
>> -                                    dev->name, hdr->hdr.gso_type,
>> -                                    hdr->hdr.gso_size);
>> -               goto frame_err;
>> +               skb->protocol = eth_type_trans(skb, dev);
>>          }
>>
>>          skb_record_rx_queue(skb, vq2rxq(rq->vq));
>> -       skb->protocol = eth_type_trans(skb, dev);
>>          pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
>>                   ntohs(skb->protocol), skb->len, skb->pkt_type);
>>
>> --
>> 2.19.1.6.gb485710b
>>


