Return-Path: <bpf+bounces-3416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEABD73D658
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 05:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDEF1C20828
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 03:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B529CEA3;
	Mon, 26 Jun 2023 03:34:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2C7F;
	Mon, 26 Jun 2023 03:34:25 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA4D137;
	Sun, 25 Jun 2023 20:34:22 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VluNlcp_1687750457;
Received: from 30.221.149.158(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VluNlcp_1687750457)
          by smtp.aliyun-inc.com;
          Mon, 26 Jun 2023 11:34:18 +0800
Message-ID: <03312236-b67d-b408-2da0-78129817b0fb@linux.alibaba.com>
Date: Mon, 26 Jun 2023 11:34:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2 1/3] virtio-net: reprobe csum related fields
 for skb passed by XDP
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
References: <20230624122604.110958-1-hengqi@linux.alibaba.com>
 <20230624122604.110958-2-hengqi@linux.alibaba.com>
 <CACGkMEuVT2C8A9Oe508pUWpCmTDgnvpHGDhLm822hvThwQiD9Q@mail.gmail.com>
 <20230625072753.GA102374@h68b04307.sqa.eu95>
 <CACGkMEtKdYX8SFC1VKZAwWAwr2C0Xgg54=j7P6bQCA+0y-Bh3g@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEtKdYX8SFC1VKZAwWAwr2C0Xgg54=j7P6bQCA+0y-Bh3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/6/26 上午10:09, Jason Wang 写道:
> On Sun, Jun 25, 2023 at 3:28 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> On Sun, Jun 25, 2023 at 02:44:07PM +0800, Jason Wang wrote:
>>> On Sat, Jun 24, 2023 at 8:26 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>> Currently, the VIRTIO_NET_F_GUEST_CSUM (corresponds to NETIF_F_RXCSUM
>>>> for netdev) feature of the virtio-net driver conflicts with the loading
>>>> of XDP, which is caused by the problem described in [1][2], that is,
>>>> XDP may cause errors in partial csumed-related fields which can lead
>>>> to packet dropping.
>>>>
>>>> In addition, when communicating between vm and vm on the same host, the
>>>> receiving side vm will receive packets marked as
>>>> VIRTIO_NET_HDR_F_NEEDS_CSUM, but after these packets are processed by
>>>> XDP, the VIRTIO_NET_HDR_F_NEEDS_CSUM and skb CHECKSUM_PARTIAL flags will
>>>> be cleared, causing the packet dropping.
>>>>
>>>> This patch introduces a helper:
>>>> 1. It will try to solve the above problems in the subsequent patch.
>>>> 2. It parses UDP/TCP and calculates the pseudo-header checksum
>>>> for virtio-net. virtio-net currently does not resolve VLANs nor
>>>> SCTP CRC checksum offloading.
>>> Do we need to bother? Can we simply use skb_probe_transport_header()
>>> and skb_checksum_help() which can simplify a lot of things?
>> We need to. We only compute partial checksums (not complete checksums) for
>> packets marked as NEEDS_CSUM. Please see skb_csum_unnecessary(), which will
>> consider packets with the partial checksum to be valid by the
>> protocol stack (Because it believes that the communication between the
>> VMs of the same host is reliable.).
>>
>> In order to calculate the pseudo-header checksum, we need the IP address and the
>> \field{check} position of the transport layer header.
>> skb_probe_transport_header() only finds out the location of the
>> transport header and does not provide us with other information we
>> need. skb_checksum_help() is to calculate the complete checksum on the
>> tx path, which is not our purpose.
> A typo in my previous reply, actually, I meant skb_checksum_setup().

I think this could work for us! I'm going to modify some of the code to 
make it work for us. ^^

>
> I think the point is to have a general purpose helper in the core
> instead of duplicating codes in any specific driver.

Absolutely.

Thanks!

>
> Thanks
>
>> Thanks!
>>
>>> Thanks
>>>
>>>> [1] commit 18ba58e1c234 ("virtio-net: fail XDP set if guest csum is negotiated")
>>>> [2] commit e59ff2c49ae1 ("virtio-net: disable guest csum during XDP set")
>>>>
>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>> ---
>>>>   drivers/net/virtio_net.c | 136 +++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 136 insertions(+)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 5a7f7a76b920..83ab9257043a 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -22,6 +22,7 @@
>>>>   #include <net/route.h>
>>>>   #include <net/xdp.h>
>>>>   #include <net/net_failover.h>
>>>> +#include <net/ip6_checksum.h>
>>>>
>>>>   static int napi_weight = NAPI_POLL_WEIGHT;
>>>>   module_param(napi_weight, int, 0444);
>>>> @@ -1568,6 +1569,141 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
>>>>          skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
>>>>   }
>>>>
>>>> +static int virtnet_flow_dissect_udp_tcp(struct virtnet_info *vi, struct sk_buff *skb)
>>>> +{
>>>> +       struct net_device *dev = vi->dev;
>>>> +       struct flow_keys_basic keys;
>>>> +       struct udphdr *uh;
>>>> +       struct tcphdr *th;
>>>> +       int len, offset;
>>>> +
>>>> +       /* The flow dissector needs this information. */
>>>> +       skb->dev = dev;
>>>> +       skb_reset_mac_header(skb);
>>>> +       skb->protocol = dev_parse_header_protocol(skb);
>>>> +       /* virtio-net does not need to resolve VLAN. */
>>>> +       skb_set_network_header(skb, ETH_HLEN);
>>>> +       if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
>>>> +                                             NULL, 0, 0, 0, 0))
>>>> +               return -EINVAL;
>>>> +
>>>> +       /* 1. Pseudo-header checksum calculation requires:
>>>> +        *    (1) saddr/daddr (2) IP_PROTO (3) length of transport payload
>>>> +        * 2. We don't parse SCTP because virtio-net currently doesn't
>>>> +        *    support CRC checksum offloading for SCTP.
>>>> +        */
>>>> +       if (keys.basic.n_proto == htons(ETH_P_IP)) {
>>>> +               struct iphdr *iph;
>>>> +
>>>> +               /* Flow dissector has verified that there is an IP header.
>>>> +                * So we do not need a pskb_may_pull().
>>>> +                */
>>>> +               iph = ip_hdr(skb);
>>>> +               if (iph->version != 4)
>>>> +                       return -EINVAL;
>>>> +
>>>> +               skb->transport_header = skb->mac_header + keys.control.thoff;
>>>> +               offset = skb_transport_offset(skb);
>>>> +               len = skb->len - offset;
>>>> +               if (keys.basic.ip_proto == IPPROTO_UDP) {
>>>> +                       if (!pskb_may_pull(skb, offset + sizeof(struct udphdr)))
>>>> +                               return -EINVAL;
>>>> +
>>>> +                       uh = udp_hdr(skb);
>>>> +                       skb->csum_offset = offsetof(struct udphdr, check);
>>>> +                       /* Although uh->len is already the 3rd parameter for the calculation
>>>> +                        * of the pseudo-header checksum, we have already calculated the
>>>> +                        * length of the transport layer, so use 'len' here directly.
>>>> +                        */
>>>> +                       uh->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr, len,
>>>> +                                       IPPROTO_UDP, 0);
>>>> +               } else if (keys.basic.ip_proto == IPPROTO_TCP) {
>>>> +                       if (!pskb_may_pull(skb, offset + sizeof(struct tcphdr)))
>>>> +                               return -EINVAL;
>>>> +
>>>> +                       th = tcp_hdr(skb);
>>>> +                       skb->csum_offset = offsetof(struct tcphdr, check);
>>>> +                       th->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr, len,
>>>> +                                       IPPROTO_TCP, 0);
>>>> +               } /* virtio-net doesn't support checksums for SCTP crc hw offloading.*/
>>>> +       } else if (keys.basic.n_proto == htons(ETH_P_IPV6)) {
>>>> +               struct ipv6hdr *ip6h;
>>>> +
>>>> +               ip6h = ipv6_hdr(skb);
>>>> +               if (ip6h->version != 6)
>>>> +                       return -EINVAL;
>>>> +
>>>> +               /* We have skipped the possible extension headers for IPv6.
>>>> +                * If there is a Routing Header, the tx's check value is calculated by
>>>> +                * final_dst, and that value is the rx's daddr.
>>>> +                */
>>>> +               skb->transport_header = skb->mac_header + keys.control.thoff;
>>>> +               offset = skb_transport_offset(skb);
>>>> +               len = skb->len - offset;
>>>> +               if (keys.basic.ip_proto == IPPROTO_UDP) {
>>>> +                       if (!pskb_may_pull(skb, offset + sizeof(struct udphdr)))
>>>> +                               return -EINVAL;
>>>> +
>>>> +                       uh = udp_hdr(skb);
>>>> +                       skb->csum_offset = offsetof(struct udphdr, check);
>>>> +                       uh->check = ~csum_ipv6_magic((const struct in6_addr *)&ip6h->saddr,
>>>> +                                       (const struct in6_addr *)&ip6h->daddr,
>>>> +                                       len, IPPROTO_UDP, 0);
>>>> +               } else if (keys.basic.ip_proto == IPPROTO_TCP) {
>>>> +                       if (!pskb_may_pull(skb, offset + sizeof(struct tcphdr)))
>>>> +                               return -EINVAL;
>>>> +
>>>> +                       th = tcp_hdr(skb);
>>>> +                       skb->csum_offset = offsetof(struct tcphdr, check);
>>>> +                       th->check = ~csum_ipv6_magic((const struct in6_addr *)&ip6h->saddr,
>>>> +                                       (const struct in6_addr *)&ip6h->daddr,
>>>> +                                       len, IPPROTO_TCP, 0);
>>>> +               }
>>>> +       }
>>>> +
>>>> +       skb->csum_start = skb->transport_header;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
>>>> +                                     struct sk_buff *skb,
>>>> +                                     __u8 flags)
>>>> +{
>>>> +       int err;
>>>> +
>>>> +       /* When XDP program is loaded, for example, the vm-vm scenario
>>>> +        * on the same host, packets marked as VIRTIO_NET_HDR_F_NEEDS_CSUM
>>>> +        * will travel. Although these packets are safe from the point of
>>>> +        * view of the vm, to avoid modification by XDP and successful
>>>> +        * forwarding in the upper layer, we re-probe the necessary checksum
>>>> +        * related information: skb->csum_{start, offset}, pseudo-header csum.
>>>> +        *
>>>> +        * This benefits us:
>>>> +        * 1. XDP can be loaded when there's _F_GUEST_CSUM.
>>>> +        * 2. The device verifies the checksum of packets , especially
>>>> +        *    benefiting for large packets.
>>>> +        * 3. In the same-host vm-vm scenario, packets marked as
>>>> +        *    VIRTIO_NET_HDR_F_NEEDS_CSUM are no longer dropped after being
>>>> +        *    processed by XDP.
>>>> +        */
>>>> +       if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
>>>> +               err = virtnet_flow_dissect_udp_tcp(vi, skb);
>>>> +               if (err < 0)
>>>> +                       return -EINVAL;
>>>> +
>>>> +               skb->ip_summed = CHECKSUM_PARTIAL;
>>>> +       } else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
>>>> +               /* We want to benefit from this: XDP guarantees that packets marked
>>>> +                * as VIRTIO_NET_HDR_F_DATA_VALID still have correct csum after they
>>>> +                * are processed.
>>>> +                */
>>>> +               skb->ip_summed = CHECKSUM_UNNECESSARY;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>   static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>>>                          void *buf, unsigned int len, void **ctx,
>>>>                          unsigned int *xdp_xmit,
>>>> --
>>>> 2.19.1.6.gb485710b
>>>>


