Return-Path: <bpf+bounces-3393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0748073CEBC
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 08:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0CC280FE4
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 06:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EDF81B;
	Sun, 25 Jun 2023 06:44:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9787C
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 06:44:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59503E4F
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687675462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BaP0fW3qBPn34qx1X/Cw4VgOlWQhQeo2Hzmae3W4EY=;
	b=O6+XsdWruaTVctpn59xLgGlf3iSkECXurmbMKgUXM5s0qN+tqRKM2mNdIUOPooC++gKktq
	oddxB6vdB/4T3epljfPoaoZFRKtBDT8ekZNCcZtFYv9J6h3vjhCM9kinmk8X4rqElwLPSj
	18M8AHE4eegXiPezMmq582/dYGZ1Yqo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-a8mhC4-xMQGC4OMq9_6cPA-1; Sun, 25 Jun 2023 02:44:20 -0400
X-MC-Unique: a8mhC4-xMQGC4OMq9_6cPA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4f9644c213aso1403061e87.1
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 23:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687675458; x=1690267458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BaP0fW3qBPn34qx1X/Cw4VgOlWQhQeo2Hzmae3W4EY=;
        b=djxgjKIgK4wdawQcHkOlG6joVhHKZgah7WZ42Puy+osMEW+YAz2w7S01mocjIFGg0S
         x50aSTfq4ayAms960NSmaVw1a/zvDtXVOkO1LBTvDPhW9R5Oml3AuBNQ1IN/55BONEO3
         E9DdwgqzAS8fH0goLBvsRtHoEQJahQfIzThtljHOpLt4SK83PWD54pwpT3Q1+LXpoSt0
         +9s253KeBazzKcH0sMTg/ZcEnMOMLF+Qim3BnntZtKcBLA0o6EkWIHqrHGl0czgoFyC5
         aMb3iYX3KNBkZuLG96GZOp4AochaEA6ag1Vu99V+60tzvheTdvgDM/pqCp+noHZ+O3U3
         H5JA==
X-Gm-Message-State: AC+VfDyB4eLervdgUYTbEXlxkwX8tOoIWWF3za9pkdI42Ly4LfWgaO6M
	SGAc8EtY1aZcOVdSov8tXsYx7pHKezyXgKHBHDUQHvQLmFFSezJN9rQ3bzxRcFJogIHdqTajPot
	bVYsC+Y8D33NdeJA6mU4g+eycmiwN
X-Received: by 2002:a05:6512:ea7:b0:4f6:3000:94a0 with SMTP id bi39-20020a0565120ea700b004f6300094a0mr15719607lfb.61.1687675458611;
        Sat, 24 Jun 2023 23:44:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/ENphRnB44Ke6FHOxbMQAG6pJPdmdyOAL3lAAj3f7QfUbdxbcoGytUTdrnWIUieR0GBinxayhkM6b3posAZg=
X-Received: by 2002:a05:6512:ea7:b0:4f6:3000:94a0 with SMTP id
 bi39-20020a0565120ea700b004f6300094a0mr15719594lfb.61.1687675458207; Sat, 24
 Jun 2023 23:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230624122604.110958-1-hengqi@linux.alibaba.com> <20230624122604.110958-2-hengqi@linux.alibaba.com>
In-Reply-To: <20230624122604.110958-2-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 25 Jun 2023 14:44:07 +0800
Message-ID: <CACGkMEuVT2C8A9Oe508pUWpCmTDgnvpHGDhLm822hvThwQiD9Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] virtio-net: reprobe csum related fields
 for skb passed by XDP
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 24, 2023 at 8:26=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Currently, the VIRTIO_NET_F_GUEST_CSUM (corresponds to NETIF_F_RXCSUM
> for netdev) feature of the virtio-net driver conflicts with the loading
> of XDP, which is caused by the problem described in [1][2], that is,
> XDP may cause errors in partial csumed-related fields which can lead
> to packet dropping.
>
> In addition, when communicating between vm and vm on the same host, the
> receiving side vm will receive packets marked as
> VIRTIO_NET_HDR_F_NEEDS_CSUM, but after these packets are processed by
> XDP, the VIRTIO_NET_HDR_F_NEEDS_CSUM and skb CHECKSUM_PARTIAL flags will
> be cleared, causing the packet dropping.
>
> This patch introduces a helper:
> 1. It will try to solve the above problems in the subsequent patch.
> 2. It parses UDP/TCP and calculates the pseudo-header checksum
> for virtio-net. virtio-net currently does not resolve VLANs nor
> SCTP CRC checksum offloading.

Do we need to bother? Can we simply use skb_probe_transport_header()
and skb_checksum_help() which can simplify a lot of things?

Thanks

>
> [1] commit 18ba58e1c234 ("virtio-net: fail XDP set if guest csum is negot=
iated")
> [2] commit e59ff2c49ae1 ("virtio-net: disable guest csum during XDP set")
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 136 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5a7f7a76b920..83ab9257043a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -22,6 +22,7 @@
>  #include <net/route.h>
>  #include <net/xdp.h>
>  #include <net/net_failover.h>
> +#include <net/ip6_checksum.h>
>
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -1568,6 +1569,141 @@ static void virtio_skb_set_hash(const struct virt=
io_net_hdr_v1_hash *hdr_hash,
>         skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_t=
ype);
>  }
>
> +static int virtnet_flow_dissect_udp_tcp(struct virtnet_info *vi, struct =
sk_buff *skb)
> +{
> +       struct net_device *dev =3D vi->dev;
> +       struct flow_keys_basic keys;
> +       struct udphdr *uh;
> +       struct tcphdr *th;
> +       int len, offset;
> +
> +       /* The flow dissector needs this information. */
> +       skb->dev =3D dev;
> +       skb_reset_mac_header(skb);
> +       skb->protocol =3D dev_parse_header_protocol(skb);
> +       /* virtio-net does not need to resolve VLAN. */
> +       skb_set_network_header(skb, ETH_HLEN);
> +       if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
> +                                             NULL, 0, 0, 0, 0))
> +               return -EINVAL;
> +
> +       /* 1. Pseudo-header checksum calculation requires:
> +        *    (1) saddr/daddr (2) IP_PROTO (3) length of transport payloa=
d
> +        * 2. We don't parse SCTP because virtio-net currently doesn't
> +        *    support CRC checksum offloading for SCTP.
> +        */
> +       if (keys.basic.n_proto =3D=3D htons(ETH_P_IP)) {
> +               struct iphdr *iph;
> +
> +               /* Flow dissector has verified that there is an IP header=
.
> +                * So we do not need a pskb_may_pull().
> +                */
> +               iph =3D ip_hdr(skb);
> +               if (iph->version !=3D 4)
> +                       return -EINVAL;
> +
> +               skb->transport_header =3D skb->mac_header + keys.control.=
thoff;
> +               offset =3D skb_transport_offset(skb);
> +               len =3D skb->len - offset;
> +               if (keys.basic.ip_proto =3D=3D IPPROTO_UDP) {
> +                       if (!pskb_may_pull(skb, offset + sizeof(struct ud=
phdr)))
> +                               return -EINVAL;
> +
> +                       uh =3D udp_hdr(skb);
> +                       skb->csum_offset =3D offsetof(struct udphdr, chec=
k);
> +                       /* Although uh->len is already the 3rd parameter =
for the calculation
> +                        * of the pseudo-header checksum, we have already=
 calculated the
> +                        * length of the transport layer, so use 'len' he=
re directly.
> +                        */
> +                       uh->check =3D ~csum_tcpudp_magic(iph->saddr, iph-=
>daddr, len,
> +                                       IPPROTO_UDP, 0);
> +               } else if (keys.basic.ip_proto =3D=3D IPPROTO_TCP) {
> +                       if (!pskb_may_pull(skb, offset + sizeof(struct tc=
phdr)))
> +                               return -EINVAL;
> +
> +                       th =3D tcp_hdr(skb);
> +                       skb->csum_offset =3D offsetof(struct tcphdr, chec=
k);
> +                       th->check =3D ~csum_tcpudp_magic(iph->saddr, iph-=
>daddr, len,
> +                                       IPPROTO_TCP, 0);
> +               } /* virtio-net doesn't support checksums for SCTP crc hw=
 offloading.*/
> +       } else if (keys.basic.n_proto =3D=3D htons(ETH_P_IPV6)) {
> +               struct ipv6hdr *ip6h;
> +
> +               ip6h =3D ipv6_hdr(skb);
> +               if (ip6h->version !=3D 6)
> +                       return -EINVAL;
> +
> +               /* We have skipped the possible extension headers for IPv=
6.
> +                * If there is a Routing Header, the tx's check value is =
calculated by
> +                * final_dst, and that value is the rx's daddr.
> +                */
> +               skb->transport_header =3D skb->mac_header + keys.control.=
thoff;
> +               offset =3D skb_transport_offset(skb);
> +               len =3D skb->len - offset;
> +               if (keys.basic.ip_proto =3D=3D IPPROTO_UDP) {
> +                       if (!pskb_may_pull(skb, offset + sizeof(struct ud=
phdr)))
> +                               return -EINVAL;
> +
> +                       uh =3D udp_hdr(skb);
> +                       skb->csum_offset =3D offsetof(struct udphdr, chec=
k);
> +                       uh->check =3D ~csum_ipv6_magic((const struct in6_=
addr *)&ip6h->saddr,
> +                                       (const struct in6_addr *)&ip6h->d=
addr,
> +                                       len, IPPROTO_UDP, 0);
> +               } else if (keys.basic.ip_proto =3D=3D IPPROTO_TCP) {
> +                       if (!pskb_may_pull(skb, offset + sizeof(struct tc=
phdr)))
> +                               return -EINVAL;
> +
> +                       th =3D tcp_hdr(skb);
> +                       skb->csum_offset =3D offsetof(struct tcphdr, chec=
k);
> +                       th->check =3D ~csum_ipv6_magic((const struct in6_=
addr *)&ip6h->saddr,
> +                                       (const struct in6_addr *)&ip6h->d=
addr,
> +                                       len, IPPROTO_TCP, 0);
> +               }
> +       }
> +
> +       skb->csum_start =3D skb->transport_header;
> +
> +       return 0;
> +}
> +
> +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> +                                     struct sk_buff *skb,
> +                                     __u8 flags)
> +{
> +       int err;
> +
> +       /* When XDP program is loaded, for example, the vm-vm scenario
> +        * on the same host, packets marked as VIRTIO_NET_HDR_F_NEEDS_CSU=
M
> +        * will travel. Although these packets are safe from the point of
> +        * view of the vm, to avoid modification by XDP and successful
> +        * forwarding in the upper layer, we re-probe the necessary check=
sum
> +        * related information: skb->csum_{start, offset}, pseudo-header =
csum.
> +        *
> +        * This benefits us:
> +        * 1. XDP can be loaded when there's _F_GUEST_CSUM.
> +        * 2. The device verifies the checksum of packets , especially
> +        *    benefiting for large packets.
> +        * 3. In the same-host vm-vm scenario, packets marked as
> +        *    VIRTIO_NET_HDR_F_NEEDS_CSUM are no longer dropped after bei=
ng
> +        *    processed by XDP.
> +        */
> +       if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> +               err =3D virtnet_flow_dissect_udp_tcp(vi, skb);
> +               if (err < 0)
> +                       return -EINVAL;
> +
> +               skb->ip_summed =3D CHECKSUM_PARTIAL;
> +       } else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
> +               /* We want to benefit from this: XDP guarantees that pack=
ets marked
> +                * as VIRTIO_NET_HDR_F_DATA_VALID still have correct csum=
 after they
> +                * are processed.
> +                */
> +               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +       }
> +
> +       return 0;
> +}
> +
>  static void receive_buf(struct virtnet_info *vi, struct receive_queue *r=
q,
>                         void *buf, unsigned int len, void **ctx,
>                         unsigned int *xdp_xmit,
> --
> 2.19.1.6.gb485710b
>


