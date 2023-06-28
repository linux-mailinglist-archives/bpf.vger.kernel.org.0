Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2186C740C7E
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjF1JSN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 05:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233109AbjF1IxK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Jun 2023 04:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687942326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXCI3qKnurs1UEjuJv9pVttQOMgZLyOnnsesFREOiJ8=;
        b=PCNxuwMLrkhHADJ4k+SMer/LWCGd2UoCLbF4o/yMCmOafqY/Iv/q9dXkmk1qWmNew9sVqQ
        71pSX5buSGT024kbmSaO/DlmmBBFqbY+2Ww1L4XtwcLKnJE1+Vrf5CBPxsbXdXbyo6Yvrl
        dNpnOI9fphf4xl5goWlxg63+CS0Jg30=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-nfo_Z3cOO466JCMv_iSWiQ-1; Wed, 28 Jun 2023 02:50:18 -0400
X-MC-Unique: nfo_Z3cOO466JCMv_iSWiQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b6a47b59a5so27519021fa.3
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 23:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687935016; x=1690527016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXCI3qKnurs1UEjuJv9pVttQOMgZLyOnnsesFREOiJ8=;
        b=ZpkLKBZGJtuwtfGswyou5tqICy2fZpDRB2tRhJZtdDcPthYKIIUf7GURX192OsPr2y
         KQy1B3PCG1JQ4BsX/NKMBXgU6RcsOVKmktUxUTHrr30BO2lsfprO9jLW3meyQHvebnqy
         lqsPauaqc525jppQCwC9R4HTrL9aZVc/z/mK3GyXdD9WSz5+fbsoAbzdnsZfWTSkUPud
         71apiJy/7BA/+yujyTaJpzI2JkfHLu5+lMEwlrZb9RDXc6U8F2+ahQYF4MYsa+/g8i5P
         5xrDPm0YRBYiGISWR/G+r9Zb5VIZjIt8BUTZjIk33ZfqeT5tlGpy/0iuU5SlNrxrLZDA
         a1Iw==
X-Gm-Message-State: AC+VfDxrAR2AM7sYwNaqhTgnArfIwoz7aqj360+odVt1dTPBM/DyR7iq
        zVRNQfE+SrOsTGQK9qRm7hU+rHxuSFtMPJjluyaCIdLg5RsgO00O3AA8AR7SVsd7CBcqF1M1K9W
        5Mxox1CqKHsnf+poWRnpCrp1Vx6e5
X-Received: by 2002:a2e:8702:0:b0:2b4:7f2e:a430 with SMTP id m2-20020a2e8702000000b002b47f2ea430mr18052890lji.17.1687935016596;
        Tue, 27 Jun 2023 23:50:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5sBJ4sm1BY+IgjV7r7Zdq4CAcFiFIyLILWBqFeSDpdE+LwZnhmv0tlA986ntAitm0JwxiNuNLLhal/DjWO0m0=
X-Received: by 2002:a2e:8702:0:b0:2b4:7f2e:a430 with SMTP id
 m2-20020a2e8702000000b002b47f2ea430mr18052874lji.17.1687935016250; Tue, 27
 Jun 2023 23:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230628030506.2213-1-hengqi@linux.alibaba.com>
 <20230628030506.2213-2-hengqi@linux.alibaba.com> <CACGkMEv7aVH0dgdd6N3RMH+57BWuxnq9NR8sPzD9wRQZ5TZRFQ@mail.gmail.com>
 <c6411922-51ad-3d8f-88aa-28883b44573d@linux.alibaba.com> <CACGkMEu=Cs5DFP+EFqxUXaiqz7vewhQ5zMMtChGpR_oGjrvMCg@mail.gmail.com>
 <20230628045626.GA32321@h68b04307.sqa.eu95>
In-Reply-To: <20230628045626.GA32321@h68b04307.sqa.eu95>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Jun 2023 14:50:05 +0800
Message-ID: <CACGkMEt6Kb60Akn=aJjzJQg6Zg8F_24ezqAtwPOZxiu4-f7E3g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] virtio-net: support coexistence of XDP
 and GUEST_CSUM
To:     Heng Qi <hengqi@linux.alibaba.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 28, 2023 at 12:56=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
> On Wed, Jun 28, 2023 at 12:02:17PM +0800, Jason Wang wrote:
> > On Wed, Jun 28, 2023 at 11:42=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> > >
> > >
> > >
> > > =E5=9C=A8 2023/6/28 =E4=B8=8A=E5=8D=8811:22, Jason Wang =E5=86=99=E9=
=81=93:
> > > > On Wed, Jun 28, 2023 at 11:05=E2=80=AFAM Heng Qi <hengqi@linux.alib=
aba.com> wrote:
> > > >> We are now re-probing the csum related fields and trying
> > > >> to have XDP and RX hw checksum capabilities coexist on the
> > > >> XDP path. For the benefit of:
> > > >> 1. RX hw checksum capability can be used if XDP is loaded.
> > > >> 2. Avoid packet loss when loading XDP in the vm-vm scenario.
> > > >>
> > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >> ---
> > > >> v3->v4:
> > > >>    - Rewrite some comments.
> > > >>
> > > >> v2->v3:
> > > >>    - Use skb_checksum_setup() instead of virtnet_flow_dissect_udp_=
tcp().
> > > >>      Essentially equivalent.
> > > >>
> > > >>   drivers/net/virtio_net.c | 82 +++++++++++++++++++++++++++++++++-=
------
> > > >>   1 file changed, 69 insertions(+), 13 deletions(-)
> > > >>
> > > >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > >> index 5a7f7a76b920..a47342f972b5 100644
> > > >> --- a/drivers/net/virtio_net.c
> > > >> +++ b/drivers/net/virtio_net.c
> > > >> @@ -1568,6 +1568,41 @@ static void virtio_skb_set_hash(const struc=
t virtio_net_hdr_v1_hash *hdr_hash,
> > > >>          skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rs=
s_hash_type);
> > > >>   }
> > > >>
> > > >> +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> > > >> +                                     struct sk_buff *skb,
> > > >> +                                     __u8 flags)
> > > >> +{
> > > >> +       int err =3D 0;
> > > >> +
> > > >> +       /* When XDP program is loaded, the vm-vm scenario on the s=
ame host,
> > > >> +        * packets marked VIRTIO_NET_HDR_F_NEEDS_CSUM without a co=
mplete checksum
> > > >> +        * will travel. Although these packets are safe from the p=
oint of
> > > >> +        * view of the vm, in order to be successfully forwarded o=
n the upper
> > > >> +        * layer and to avoid packet loss caused by XDP modificati=
on,
> > > >> +        * we re-probe the necessary checksum related information:
> > > >> +        * skb->csum_{start, offset}, pseudo-header checksum.
> > > >> +        *
> > > >> +        * If the received packet is marked VIRTIO_NET_HDR_F_DATA_=
VALID:
> > > >> +        * when _F_GUEST_CSUM is negotiated, the device validates =
the checksum
> > > >> +        * and virtio-net sets skb->ip_summed to CHECKSUM_UNNECESS=
ARY;
> > > >> +        * otherwise, virtio-net hands over to the stack to valida=
te the checksum.
> > > >> +        */
> > > >> +       if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> > > >> +               /* No need to care about SCTP because virtio-net c=
urrently doesn't
> > > >> +                * support SCTP CRC checksum offloading, that is, =
SCTP packets have
> > > >> +                * complete checksums.
> > > >> +                */
> > > >> +               err =3D skb_checksum_setup(skb, true);
> > > > A second thought, any reason why a checksum is a must here. Could w=
e simply:
> > >
> > > When net.ipv4.ip_forward sysctl is enabled, such packets may be
> > > forwarded (return to the tx path) at the IP layer.
> > > If the device has the tx hw checksum offloading cap, packets will hav=
e
> > > complete checksums based on our calculated 'check' value.
> >
> > Actually, I mean why can't we offload the checksum to the hardware in t=
his case?
>
> Yes that's what I explained:)
>
> Checksum of udp/tcp includes the pseudo-header checksum and the checksum =
of the entire udp/tcp payload.
> When tx checksum offloading is enabled, the upper layer will only calcula=
te the pseudo-header checksum,
> and the rest of the checksum of the entire udp/tcp payload will be calcul=
ated by hardware.
>
>
> Please see udp_send_skb():
>
> "
>         } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) { /* UDP hardw=
are csum */
> csum_partial:
>
>                 udp4_hwcsum(skb, fl4->saddr, fl4->daddr);
>                 goto send;
>
>         } else
>                 csum =3D udp_csum(skb);
>
>         /* add protocol-dependent pseudo-header */
>         uh->check =3D csum_tcpudp_magic(fl4->saddr, fl4->daddr, len,
>                                       sk->sk_protocol, csum);
>         if (uh->check =3D=3D 0)
>                 uh->check =3D CSUM_MANGLED_0;
>
> send:
>         err =3D ip_send_skb(sock_net(sk), skb);
> "

Ok, so I think what I missed is that the CHECKSUM_PARTIAL is set up by
skb_checksum_setup() so we don't even need to care about that.

>
> >
> > >
> > > >
> > > > 1) probe the csum_start/offset
> > > > 2) leave it as CHECKSUM_PARTIAL
> > > >
> > > > ?
> > >
> > > The reason is as I explained above.
> > >
> > > >
> > > >> +       } else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
> > > >> +               /* XDP guarantees that packets marked as VIRTIO_NE=
T_HDR_F_DATA_VALID
> > > >> +                * still have correct checksum after they are proc=
essed.
> > > >> +                */
> > > > Do you mean it's the charge of the XDP program to calculate the csu=
m
> > > > in this case? Seems strange.
> > >
> > > Packet with complete checksum (and has been verified by rx device
> > > because it has VIRTIO_NET_HDR_F_DATA_VALID)
> > > when modified by XDP, XDP program should use the helper provided by X=
DP
> > > core to make the checksum correct,
> >
> > Could you give me a pointer to that helper?
>
> bpf_csum_diff(),

Ok.

> bpf_{l3,l4}_csum_replace()

This seems not to be a helpr for XDP but for other bpf like cls.

>
> >Btw, is there a way for
> > the XDP program to know whether the csum has been verified by the
> > device? ( I guess not).
> >
>
> Not. But we only do this (mark skb->ip_summed =3D CHECKSUM_UNNECESSARY) f=
or packets with VIRTIO_NET_HDR_F_DATA_VALID now.

So if I understand you correctly, you meant for the XDP program that
wants to modify the packet:

1) check whether the checksum is valid
2) if yes, recalculate the checksum after the modification
3) if not, just do nothing for the checksum and the driver need to
re-probe the csum_start/offset

?

Thanks

>
> Thanks.
>
> > Thanks
> >
> >
> > > otherwise, VIRTIO_NET_HDR_F_DATA_VALID has been cleared and skb
> > > ->ip_summed=3DCHECKSUM_NONE, so the stack
> > > will re-verify the checksum, causing packet loss due to wrong checksu=
m.
> > >
> > > Thanks.
> > >
> > > >
> > > > Thanks
> > > >
> > > >> +               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > > >> +       }
> > > >> +
> > > >> +       return err;
> > > >> +}
> > > >> +
> > > >>   static void receive_buf(struct virtnet_info *vi, struct receive_=
queue *rq,
> > > >>                          void *buf, unsigned int len, void **ctx,
> > > >>                          unsigned int *xdp_xmit,
> > > >> @@ -1576,6 +1611,7 @@ static void receive_buf(struct virtnet_info =
*vi, struct receive_queue *rq,
> > > >>          struct net_device *dev =3D vi->dev;
> > > >>          struct sk_buff *skb;
> > > >>          struct virtio_net_hdr_mrg_rxbuf *hdr;
> > > >> +       __u8 flags;
> > > >>
> > > >>          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > > >>                  pr_debug("%s: short packet %i\n", dev->name, len)=
;
> > > >> @@ -1584,6 +1620,12 @@ static void receive_buf(struct virtnet_info=
 *vi, struct receive_queue *rq,
> > > >>                  return;
> > > >>          }
> > > >>
> > > >> +       /* XDP may modify/overwrite the packet, including the virt=
net hdr,
> > > >> +        * so save the flags of the virtnet hdr before XDP process=
ing.
> > > >> +        */
> > > >> +       if (unlikely(vi->xdp_enabled))
> > > >> +               flags =3D ((struct virtio_net_hdr_mrg_rxbuf *)buf)=
->hdr.flags;
> > > >> +
> > > >>          if (vi->mergeable_rx_bufs)
> > > >>                  skb =3D receive_mergeable(dev, vi, rq, buf, ctx, =
len, xdp_xmit,
> > > >>                                          stats);
> > > >> @@ -1595,23 +1637,37 @@ static void receive_buf(struct virtnet_inf=
o *vi, struct receive_queue *rq,
> > > >>          if (unlikely(!skb))
> > > >>                  return;
> > > >>
> > > >> -       hdr =3D skb_vnet_hdr(skb);
> > > >> -       if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_rep=
ort)
> > > >> -               virtio_skb_set_hash((const struct virtio_net_hdr_v=
1_hash *)hdr, skb);
> > > >> -
> > > >> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > > >> -               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > > >> +       if (unlikely(vi->xdp_enabled)) {
> > > >> +               /* Required to do this before re-probing and calcu=
lating
> > > >> +                * the pseudo-header checksum.
> > > >> +                */
> > > >> +               skb->protocol =3D eth_type_trans(skb, dev);
> > > >> +               skb_reset_network_header(skb);
> > > >> +               if (virtnet_set_csum_after_xdp(vi, skb, flags) < 0=
) {
> > > >> +                       pr_debug("%s: errors occurred in setting p=
artial csum",
> > > >> +                                dev->name);
> > > >> +                       goto frame_err;
> > > >> +               }
> > > >> +       } else {
> > > >> +               hdr =3D skb_vnet_hdr(skb);
> > > >> +               if (dev->features & NETIF_F_RXHASH && vi->has_rss_=
hash_report)
> > > >> +                       virtio_skb_set_hash((const struct virtio_n=
et_hdr_v1_hash *)hdr, skb);
> > > >> +
> > > >> +               if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > > >> +                       skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > > >> +
> > > >> +               if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > > >> +                                         virtio_is_little_endian(=
vi->vdev))) {
> > > >> +                       net_warn_ratelimited("%s: bad gso: type: %=
u, size: %u\n",
> > > >> +                                            dev->name, hdr->hdr.g=
so_type,
> > > >> +                                            hdr->hdr.gso_size);
> > > >> +                       goto frame_err;
> > > >> +               }
> > > >>
> > > >> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > > >> -                                 virtio_is_little_endian(vi->vdev=
))) {
> > > >> -               net_warn_ratelimited("%s: bad gso: type: %u, size:=
 %u\n",
> > > >> -                                    dev->name, hdr->hdr.gso_type,
> > > >> -                                    hdr->hdr.gso_size);
> > > >> -               goto frame_err;
> > > >> +               skb->protocol =3D eth_type_trans(skb, dev);
> > > >>          }
> > > >>
> > > >>          skb_record_rx_queue(skb, vq2rxq(rq->vq));
> > > >> -       skb->protocol =3D eth_type_trans(skb, dev);
> > > >>          pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
> > > >>                   ntohs(skb->protocol), skb->len, skb->pkt_type);
> > > >>
> > > >> --
> > > >> 2.19.1.6.gb485710b
> > > >>
> > >
>

