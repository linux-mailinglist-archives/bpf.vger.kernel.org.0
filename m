Return-Path: <bpf+bounces-3413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD0373D5B6
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 04:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA081C20431
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 02:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A80A32;
	Mon, 26 Jun 2023 02:09:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C37F6
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 02:09:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0881AB
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 19:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687745362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69TLTmVRGgyr02EOPiWp/5W6sb7feYLRUb0SmwLU1T4=;
	b=A0VmFO7Yx4hD2VxVsh80u43YoihHeED08NeQtn+3Ro1Judowdq93PeBiYL8qx3aV4U1N8l
	O/1NkQTuynuECxcSHsPBCHG7jSeozUNNOgCbVrzBmAd9WCyWUz8KqmzP0oY/Y5YafZmsMt
	5Ksa3LBX2lWOun3kwBtZgcLDk623508=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-r-KbU7eeOJ6aLeAPrPXWvg-1; Sun, 25 Jun 2023 22:09:21 -0400
X-MC-Unique: r-KbU7eeOJ6aLeAPrPXWvg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6a10a0a76so2747191fa.3
        for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 19:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687745360; x=1690337360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69TLTmVRGgyr02EOPiWp/5W6sb7feYLRUb0SmwLU1T4=;
        b=ZmDcaWUBEdVwCvGXEyX9MVTC7Dex7bha4TPVBqFFHZe9n2AYzzCEQJgI9d+1e1V5Jb
         qbpneUyj59YKAXjIWHfQNRkmFYi0gTbLyiIVi13QYnyeolfTqKXbaNW/LJW3hPyD5XzQ
         FQQrQzJBCQTDRBUfd3JPD7fF2QhNrzSoL1G2kM6AyOQM1/Yps+o9srhcDH+yVPrGetp8
         u8WEyikYTz+mhaWXk4QyFiuDI5i50KH0oPzUeLPoY06WeiDZfToEu43pCUJa2uc1Oybb
         UZfW8f5izu2zdirUhE/0TELFDCtSG4v/tRKpsWhXkrJglmpASzw+JoRqyO26sHx3xR1c
         wp4w==
X-Gm-Message-State: AC+VfDziUTcfs2mPy1LKcf2B4+R6vDVnuHjWjvkryVFqOLJvAWjGvqwk
	Us+c9lQkZfBi9T540ZXoDUHW3XkzGIUeVjCYgwI4lfs57NHreK9JTHhEOw/vc6wDTSwphLbSjzq
	zd5j5X7btVEPY7lL6UtJJBbdYfvZ4
X-Received: by 2002:a05:651c:91:b0:2b4:6b64:6860 with SMTP id 17-20020a05651c009100b002b46b646860mr14618093ljq.25.1687745359915;
        Sun, 25 Jun 2023 19:09:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VSh4izfTYQRqA9sfHcXaWyetmGakOKnEVq4ULl2LgBf7E56UMkBnhfM254v+nFsB26w3lHzhtRO8rjLnd5rY=
X-Received: by 2002:a05:651c:91:b0:2b4:6b64:6860 with SMTP id
 17-20020a05651c009100b002b46b646860mr14618083ljq.25.1687745359541; Sun, 25
 Jun 2023 19:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230624122604.110958-1-hengqi@linux.alibaba.com>
 <20230624122604.110958-2-hengqi@linux.alibaba.com> <CACGkMEuVT2C8A9Oe508pUWpCmTDgnvpHGDhLm822hvThwQiD9Q@mail.gmail.com>
 <20230625072753.GA102374@h68b04307.sqa.eu95>
In-Reply-To: <20230625072753.GA102374@h68b04307.sqa.eu95>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Jun 2023 10:09:07 +0800
Message-ID: <CACGkMEtKdYX8SFC1VKZAwWAwr2C0Xgg54=j7P6bQCA+0y-Bh3g@mail.gmail.com>
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
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 25, 2023 at 3:28=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> On Sun, Jun 25, 2023 at 02:44:07PM +0800, Jason Wang wrote:
> > On Sat, Jun 24, 2023 at 8:26=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > > Currently, the VIRTIO_NET_F_GUEST_CSUM (corresponds to NETIF_F_RXCSUM
> > > for netdev) feature of the virtio-net driver conflicts with the loadi=
ng
> > > of XDP, which is caused by the problem described in [1][2], that is,
> > > XDP may cause errors in partial csumed-related fields which can lead
> > > to packet dropping.
> > >
> > > In addition, when communicating between vm and vm on the same host, t=
he
> > > receiving side vm will receive packets marked as
> > > VIRTIO_NET_HDR_F_NEEDS_CSUM, but after these packets are processed by
> > > XDP, the VIRTIO_NET_HDR_F_NEEDS_CSUM and skb CHECKSUM_PARTIAL flags w=
ill
> > > be cleared, causing the packet dropping.
> > >
> > > This patch introduces a helper:
> > > 1. It will try to solve the above problems in the subsequent patch.
> > > 2. It parses UDP/TCP and calculates the pseudo-header checksum
> > > for virtio-net. virtio-net currently does not resolve VLANs nor
> > > SCTP CRC checksum offloading.
> >
> > Do we need to bother? Can we simply use skb_probe_transport_header()
> > and skb_checksum_help() which can simplify a lot of things?
>
> We need to. We only compute partial checksums (not complete checksums) fo=
r
> packets marked as NEEDS_CSUM. Please see skb_csum_unnecessary(), which wi=
ll
> consider packets with the partial checksum to be valid by the
> protocol stack (Because it believes that the communication between the
> VMs of the same host is reliable.).
>
> In order to calculate the pseudo-header checksum, we need the IP address =
and the
> \field{check} position of the transport layer header.
> skb_probe_transport_header() only finds out the location of the
> transport header and does not provide us with other information we
> need. skb_checksum_help() is to calculate the complete checksum on the
> tx path, which is not our purpose.

A typo in my previous reply, actually, I meant skb_checksum_setup().

I think the point is to have a general purpose helper in the core
instead of duplicating codes in any specific driver.

Thanks

>
> Thanks!
>
> >
> > Thanks
> >
> > >
> > > [1] commit 18ba58e1c234 ("virtio-net: fail XDP set if guest csum is n=
egotiated")
> > > [2] commit e59ff2c49ae1 ("virtio-net: disable guest csum during XDP s=
et")
> > >
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 136 +++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 136 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 5a7f7a76b920..83ab9257043a 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -22,6 +22,7 @@
> > >  #include <net/route.h>
> > >  #include <net/xdp.h>
> > >  #include <net/net_failover.h>
> > > +#include <net/ip6_checksum.h>
> > >
> > >  static int napi_weight =3D NAPI_POLL_WEIGHT;
> > >  module_param(napi_weight, int, 0444);
> > > @@ -1568,6 +1569,141 @@ static void virtio_skb_set_hash(const struct =
virtio_net_hdr_v1_hash *hdr_hash,
> > >         skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_ha=
sh_type);
> > >  }
> > >
> > > +static int virtnet_flow_dissect_udp_tcp(struct virtnet_info *vi, str=
uct sk_buff *skb)
> > > +{
> > > +       struct net_device *dev =3D vi->dev;
> > > +       struct flow_keys_basic keys;
> > > +       struct udphdr *uh;
> > > +       struct tcphdr *th;
> > > +       int len, offset;
> > > +
> > > +       /* The flow dissector needs this information. */
> > > +       skb->dev =3D dev;
> > > +       skb_reset_mac_header(skb);
> > > +       skb->protocol =3D dev_parse_header_protocol(skb);
> > > +       /* virtio-net does not need to resolve VLAN. */
> > > +       skb_set_network_header(skb, ETH_HLEN);
> > > +       if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
> > > +                                             NULL, 0, 0, 0, 0))
> > > +               return -EINVAL;
> > > +
> > > +       /* 1. Pseudo-header checksum calculation requires:
> > > +        *    (1) saddr/daddr (2) IP_PROTO (3) length of transport pa=
yload
> > > +        * 2. We don't parse SCTP because virtio-net currently doesn'=
t
> > > +        *    support CRC checksum offloading for SCTP.
> > > +        */
> > > +       if (keys.basic.n_proto =3D=3D htons(ETH_P_IP)) {
> > > +               struct iphdr *iph;
> > > +
> > > +               /* Flow dissector has verified that there is an IP he=
ader.
> > > +                * So we do not need a pskb_may_pull().
> > > +                */
> > > +               iph =3D ip_hdr(skb);
> > > +               if (iph->version !=3D 4)
> > > +                       return -EINVAL;
> > > +
> > > +               skb->transport_header =3D skb->mac_header + keys.cont=
rol.thoff;
> > > +               offset =3D skb_transport_offset(skb);
> > > +               len =3D skb->len - offset;
> > > +               if (keys.basic.ip_proto =3D=3D IPPROTO_UDP) {
> > > +                       if (!pskb_may_pull(skb, offset + sizeof(struc=
t udphdr)))
> > > +                               return -EINVAL;
> > > +
> > > +                       uh =3D udp_hdr(skb);
> > > +                       skb->csum_offset =3D offsetof(struct udphdr, =
check);
> > > +                       /* Although uh->len is already the 3rd parame=
ter for the calculation
> > > +                        * of the pseudo-header checksum, we have alr=
eady calculated the
> > > +                        * length of the transport layer, so use 'len=
' here directly.
> > > +                        */
> > > +                       uh->check =3D ~csum_tcpudp_magic(iph->saddr, =
iph->daddr, len,
> > > +                                       IPPROTO_UDP, 0);
> > > +               } else if (keys.basic.ip_proto =3D=3D IPPROTO_TCP) {
> > > +                       if (!pskb_may_pull(skb, offset + sizeof(struc=
t tcphdr)))
> > > +                               return -EINVAL;
> > > +
> > > +                       th =3D tcp_hdr(skb);
> > > +                       skb->csum_offset =3D offsetof(struct tcphdr, =
check);
> > > +                       th->check =3D ~csum_tcpudp_magic(iph->saddr, =
iph->daddr, len,
> > > +                                       IPPROTO_TCP, 0);
> > > +               } /* virtio-net doesn't support checksums for SCTP cr=
c hw offloading.*/
> > > +       } else if (keys.basic.n_proto =3D=3D htons(ETH_P_IPV6)) {
> > > +               struct ipv6hdr *ip6h;
> > > +
> > > +               ip6h =3D ipv6_hdr(skb);
> > > +               if (ip6h->version !=3D 6)
> > > +                       return -EINVAL;
> > > +
> > > +               /* We have skipped the possible extension headers for=
 IPv6.
> > > +                * If there is a Routing Header, the tx's check value=
 is calculated by
> > > +                * final_dst, and that value is the rx's daddr.
> > > +                */
> > > +               skb->transport_header =3D skb->mac_header + keys.cont=
rol.thoff;
> > > +               offset =3D skb_transport_offset(skb);
> > > +               len =3D skb->len - offset;
> > > +               if (keys.basic.ip_proto =3D=3D IPPROTO_UDP) {
> > > +                       if (!pskb_may_pull(skb, offset + sizeof(struc=
t udphdr)))
> > > +                               return -EINVAL;
> > > +
> > > +                       uh =3D udp_hdr(skb);
> > > +                       skb->csum_offset =3D offsetof(struct udphdr, =
check);
> > > +                       uh->check =3D ~csum_ipv6_magic((const struct =
in6_addr *)&ip6h->saddr,
> > > +                                       (const struct in6_addr *)&ip6=
h->daddr,
> > > +                                       len, IPPROTO_UDP, 0);
> > > +               } else if (keys.basic.ip_proto =3D=3D IPPROTO_TCP) {
> > > +                       if (!pskb_may_pull(skb, offset + sizeof(struc=
t tcphdr)))
> > > +                               return -EINVAL;
> > > +
> > > +                       th =3D tcp_hdr(skb);
> > > +                       skb->csum_offset =3D offsetof(struct tcphdr, =
check);
> > > +                       th->check =3D ~csum_ipv6_magic((const struct =
in6_addr *)&ip6h->saddr,
> > > +                                       (const struct in6_addr *)&ip6=
h->daddr,
> > > +                                       len, IPPROTO_TCP, 0);
> > > +               }
> > > +       }
> > > +
> > > +       skb->csum_start =3D skb->transport_header;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> > > +                                     struct sk_buff *skb,
> > > +                                     __u8 flags)
> > > +{
> > > +       int err;
> > > +
> > > +       /* When XDP program is loaded, for example, the vm-vm scenari=
o
> > > +        * on the same host, packets marked as VIRTIO_NET_HDR_F_NEEDS=
_CSUM
> > > +        * will travel. Although these packets are safe from the poin=
t of
> > > +        * view of the vm, to avoid modification by XDP and successfu=
l
> > > +        * forwarding in the upper layer, we re-probe the necessary c=
hecksum
> > > +        * related information: skb->csum_{start, offset}, pseudo-hea=
der csum.
> > > +        *
> > > +        * This benefits us:
> > > +        * 1. XDP can be loaded when there's _F_GUEST_CSUM.
> > > +        * 2. The device verifies the checksum of packets , especiall=
y
> > > +        *    benefiting for large packets.
> > > +        * 3. In the same-host vm-vm scenario, packets marked as
> > > +        *    VIRTIO_NET_HDR_F_NEEDS_CSUM are no longer dropped after=
 being
> > > +        *    processed by XDP.
> > > +        */
> > > +       if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> > > +               err =3D virtnet_flow_dissect_udp_tcp(vi, skb);
> > > +               if (err < 0)
> > > +                       return -EINVAL;
> > > +
> > > +               skb->ip_summed =3D CHECKSUM_PARTIAL;
> > > +       } else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
> > > +               /* We want to benefit from this: XDP guarantees that =
packets marked
> > > +                * as VIRTIO_NET_HDR_F_DATA_VALID still have correct =
csum after they
> > > +                * are processed.
> > > +                */
> > > +               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static void receive_buf(struct virtnet_info *vi, struct receive_queu=
e *rq,
> > >                         void *buf, unsigned int len, void **ctx,
> > >                         unsigned int *xdp_xmit,
> > > --
> > > 2.19.1.6.gb485710b
> > >
>


