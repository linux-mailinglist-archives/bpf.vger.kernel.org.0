Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2513740A9E
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 10:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjF1IIA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 04:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232389AbjF1IFA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Jun 2023 04:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687939449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=okTCgNevFM4Q9r4XEhG7CpsoJKn2JJ2bnI0cjLYaScs=;
        b=LxKowSO4ood0lqDuJB7V75avfAHitSEj+ek902PU5BO6VWAP2hsX+cbpU9zSbbvdBvGtoK
        LpTsBlCg/yw9AGg1ULTSRyM5W/CCm2CCtrt1tg18s8EFvB1DigZrDqeOs7x50Ve6Yn3w5j
        L2HHq0Q83XHH0Cv0vqOIhnHFAzbf6q4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-HFY6aKkGMIiOUX7jLArBVQ-1; Wed, 28 Jun 2023 00:02:30 -0400
X-MC-Unique: HFY6aKkGMIiOUX7jLArBVQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb774de2d4so2616482e87.1
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 21:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687924948; x=1690516948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okTCgNevFM4Q9r4XEhG7CpsoJKn2JJ2bnI0cjLYaScs=;
        b=ZQSnAEcvFMUmqKMibS0ZzrnWPa9fvjkFsT3ceJLE2DOQyNuy3nYpfMpl8nhBvdqcnO
         0Yan9yn8fALlfXAPiMsyJWtmk489FdfFugQTmqOcqdj4eSyYuZYxn4GENvo5+ia/ea8E
         vto6wuMveh3kYvYmY1wVYrTIE5FZ4g6ZgE5/vnY0KJjsp3XKIz3adBOEkOk2j4w017n1
         d6U5midJi98fEt73nfJME8Q/OcDMwnXkfJX1bGKOOxW6IlFFNzJ54aS+5EknWnkC413E
         BddI4QHEaNfts6WO+Sg0Cu4E4PaMG/Z2es7T7JXnLb3pFP9Jyf7sxa+QguJm5uNGjtlO
         3vbg==
X-Gm-Message-State: AC+VfDw4vZt1Zi7MjUZt2mQIKmiZ+wZRr00aj3Jr29AsF5wMp5zaHMHP
        OLiHmKwDyM0PP6v7TPRBOGVzEDsLeZo+VU36Mys6d2xDvXOgAdFTwVu+HvORwXICfL4wAHyhnPz
        v0y8MhIaAQRLopA6ysUi3YO3DEwHd
X-Received: by 2002:a05:6512:33c4:b0:4fb:89e2:fc27 with SMTP id d4-20020a05651233c400b004fb89e2fc27mr2270866lfg.54.1687924948506;
        Tue, 27 Jun 2023 21:02:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zI16kNAYV0OSTLGcIvbLMh//xqwXP89mPwyBjc+DUycBjq4D81BFpFH6CfEw+o0EFQcJRUN+v8jRnTY8PTp4=
X-Received: by 2002:a05:6512:33c4:b0:4fb:89e2:fc27 with SMTP id
 d4-20020a05651233c400b004fb89e2fc27mr2270855lfg.54.1687924948180; Tue, 27 Jun
 2023 21:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230628030506.2213-1-hengqi@linux.alibaba.com>
 <20230628030506.2213-2-hengqi@linux.alibaba.com> <CACGkMEv7aVH0dgdd6N3RMH+57BWuxnq9NR8sPzD9wRQZ5TZRFQ@mail.gmail.com>
 <c6411922-51ad-3d8f-88aa-28883b44573d@linux.alibaba.com>
In-Reply-To: <c6411922-51ad-3d8f-88aa-28883b44573d@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Jun 2023 12:02:17 +0800
Message-ID: <CACGkMEu=Cs5DFP+EFqxUXaiqz7vewhQ5zMMtChGpR_oGjrvMCg@mail.gmail.com>
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

On Wed, Jun 28, 2023 at 11:42=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
>
> =E5=9C=A8 2023/6/28 =E4=B8=8A=E5=8D=8811:22, Jason Wang =E5=86=99=E9=81=
=93:
> > On Wed, Jun 28, 2023 at 11:05=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> >> We are now re-probing the csum related fields and trying
> >> to have XDP and RX hw checksum capabilities coexist on the
> >> XDP path. For the benefit of:
> >> 1. RX hw checksum capability can be used if XDP is loaded.
> >> 2. Avoid packet loss when loading XDP in the vm-vm scenario.
> >>
> >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >> ---
> >> v3->v4:
> >>    - Rewrite some comments.
> >>
> >> v2->v3:
> >>    - Use skb_checksum_setup() instead of virtnet_flow_dissect_udp_tcp(=
).
> >>      Essentially equivalent.
> >>
> >>   drivers/net/virtio_net.c | 82 +++++++++++++++++++++++++++++++++-----=
--
> >>   1 file changed, 69 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index 5a7f7a76b920..a47342f972b5 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -1568,6 +1568,41 @@ static void virtio_skb_set_hash(const struct vi=
rtio_net_hdr_v1_hash *hdr_hash,
> >>          skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_ha=
sh_type);
> >>   }
> >>
> >> +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> >> +                                     struct sk_buff *skb,
> >> +                                     __u8 flags)
> >> +{
> >> +       int err =3D 0;
> >> +
> >> +       /* When XDP program is loaded, the vm-vm scenario on the same =
host,
> >> +        * packets marked VIRTIO_NET_HDR_F_NEEDS_CSUM without a comple=
te checksum
> >> +        * will travel. Although these packets are safe from the point=
 of
> >> +        * view of the vm, in order to be successfully forwarded on th=
e upper
> >> +        * layer and to avoid packet loss caused by XDP modification,
> >> +        * we re-probe the necessary checksum related information:
> >> +        * skb->csum_{start, offset}, pseudo-header checksum.
> >> +        *
> >> +        * If the received packet is marked VIRTIO_NET_HDR_F_DATA_VALI=
D:
> >> +        * when _F_GUEST_CSUM is negotiated, the device validates the =
checksum
> >> +        * and virtio-net sets skb->ip_summed to CHECKSUM_UNNECESSARY;
> >> +        * otherwise, virtio-net hands over to the stack to validate t=
he checksum.
> >> +        */
> >> +       if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> >> +               /* No need to care about SCTP because virtio-net curre=
ntly doesn't
> >> +                * support SCTP CRC checksum offloading, that is, SCTP=
 packets have
> >> +                * complete checksums.
> >> +                */
> >> +               err =3D skb_checksum_setup(skb, true);
> > A second thought, any reason why a checksum is a must here. Could we si=
mply:
>
> When net.ipv4.ip_forward sysctl is enabled, such packets may be
> forwarded (return to the tx path) at the IP layer.
> If the device has the tx hw checksum offloading cap, packets will have
> complete checksums based on our calculated 'check' value.

Actually, I mean why can't we offload the checksum to the hardware in this =
case?

>
> >
> > 1) probe the csum_start/offset
> > 2) leave it as CHECKSUM_PARTIAL
> >
> > ?
>
> The reason is as I explained above.
>
> >
> >> +       } else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
> >> +               /* XDP guarantees that packets marked as VIRTIO_NET_HD=
R_F_DATA_VALID
> >> +                * still have correct checksum after they are processe=
d.
> >> +                */
> > Do you mean it's the charge of the XDP program to calculate the csum
> > in this case? Seems strange.
>
> Packet with complete checksum (and has been verified by rx device
> because it has VIRTIO_NET_HDR_F_DATA_VALID)
> when modified by XDP, XDP program should use the helper provided by XDP
> core to make the checksum correct,

Could you give me a pointer to that helper? Btw, is there a way for
the XDP program to know whether the csum has been verified by the
device? ( I guess not).

Thanks


> otherwise, VIRTIO_NET_HDR_F_DATA_VALID has been cleared and skb
> ->ip_summed=3DCHECKSUM_NONE, so the stack
> will re-verify the checksum, causing packet loss due to wrong checksum.
>
> Thanks.
>
> >
> > Thanks
> >
> >> +               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >> +       }
> >> +
> >> +       return err;
> >> +}
> >> +
> >>   static void receive_buf(struct virtnet_info *vi, struct receive_queu=
e *rq,
> >>                          void *buf, unsigned int len, void **ctx,
> >>                          unsigned int *xdp_xmit,
> >> @@ -1576,6 +1611,7 @@ static void receive_buf(struct virtnet_info *vi,=
 struct receive_queue *rq,
> >>          struct net_device *dev =3D vi->dev;
> >>          struct sk_buff *skb;
> >>          struct virtio_net_hdr_mrg_rxbuf *hdr;
> >> +       __u8 flags;
> >>
> >>          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >>                  pr_debug("%s: short packet %i\n", dev->name, len);
> >> @@ -1584,6 +1620,12 @@ static void receive_buf(struct virtnet_info *vi=
, struct receive_queue *rq,
> >>                  return;
> >>          }
> >>
> >> +       /* XDP may modify/overwrite the packet, including the virtnet =
hdr,
> >> +        * so save the flags of the virtnet hdr before XDP processing.
> >> +        */
> >> +       if (unlikely(vi->xdp_enabled))
> >> +               flags =3D ((struct virtio_net_hdr_mrg_rxbuf *)buf)->hd=
r.flags;
> >> +
> >>          if (vi->mergeable_rx_bufs)
> >>                  skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len,=
 xdp_xmit,
> >>                                          stats);
> >> @@ -1595,23 +1637,37 @@ static void receive_buf(struct virtnet_info *v=
i, struct receive_queue *rq,
> >>          if (unlikely(!skb))
> >>                  return;
> >>
> >> -       hdr =3D skb_vnet_hdr(skb);
> >> -       if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> >> -               virtio_skb_set_hash((const struct virtio_net_hdr_v1_ha=
sh *)hdr, skb);
> >> -
> >> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >> -               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >> +       if (unlikely(vi->xdp_enabled)) {
> >> +               /* Required to do this before re-probing and calculati=
ng
> >> +                * the pseudo-header checksum.
> >> +                */
> >> +               skb->protocol =3D eth_type_trans(skb, dev);
> >> +               skb_reset_network_header(skb);
> >> +               if (virtnet_set_csum_after_xdp(vi, skb, flags) < 0) {
> >> +                       pr_debug("%s: errors occurred in setting parti=
al csum",
> >> +                                dev->name);
> >> +                       goto frame_err;
> >> +               }
> >> +       } else {
> >> +               hdr =3D skb_vnet_hdr(skb);
> >> +               if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash=
_report)
> >> +                       virtio_skb_set_hash((const struct virtio_net_h=
dr_v1_hash *)hdr, skb);
> >> +
> >> +               if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >> +                       skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >> +
> >> +               if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> >> +                                         virtio_is_little_endian(vi->=
vdev))) {
> >> +                       net_warn_ratelimited("%s: bad gso: type: %u, s=
ize: %u\n",
> >> +                                            dev->name, hdr->hdr.gso_t=
ype,
> >> +                                            hdr->hdr.gso_size);
> >> +                       goto frame_err;
> >> +               }
> >>
> >> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> >> -                                 virtio_is_little_endian(vi->vdev))) =
{
> >> -               net_warn_ratelimited("%s: bad gso: type: %u, size: %u\=
n",
> >> -                                    dev->name, hdr->hdr.gso_type,
> >> -                                    hdr->hdr.gso_size);
> >> -               goto frame_err;
> >> +               skb->protocol =3D eth_type_trans(skb, dev);
> >>          }
> >>
> >>          skb_record_rx_queue(skb, vq2rxq(rq->vq));
> >> -       skb->protocol =3D eth_type_trans(skb, dev);
> >>          pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
> >>                   ntohs(skb->protocol), skb->len, skb->pkt_type);
> >>
> >> --
> >> 2.19.1.6.gb485710b
> >>
>

