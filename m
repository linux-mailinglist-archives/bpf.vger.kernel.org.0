Return-Path: <bpf+bounces-3687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32F3741F21
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98821280D2C
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 04:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC82C4C90;
	Thu, 29 Jun 2023 04:03:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D41FD9
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 04:03:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E83D5257
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 21:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688011423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUGhJh/aeY611hrSpw3XXKMz6r4b/RXoT5/SOTsqPd4=;
	b=Yx6ywqpbT8+y6dUupzvHbtktjrYoRWHwhSNJoyYHXgSctkXToKIvb6oibTKaOKlRBGAFfc
	3DVoXT/ncx9tXbjFV6XuW0PEmmgDGQjZRy4QxqJVHyS9y3045cJMdwD/vxtt0rgaxzRuEP
	nQUK9OQOe7k4qup2DmsaFGgNxOi8CsY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-pHR0neaAOVSVZiGVsHJfUQ-1; Thu, 29 Jun 2023 00:03:41 -0400
X-MC-Unique: pHR0neaAOVSVZiGVsHJfUQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb9364b320so241531e87.3
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 21:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688011420; x=1690603420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUGhJh/aeY611hrSpw3XXKMz6r4b/RXoT5/SOTsqPd4=;
        b=eKb4E789GQmnxHhCmyeVmLdDuLn0S5VgmVUxVN1BPVzuZNbGnEewfN+FTkFsZsrcV+
         mPF+9xHKSfCFjruzQE6FrE4CKQUyUDXByJfpwYiZpmt6hgy3Yxt458jbFtpItjQTgCR1
         1U1HN1MPCocB0E352ZO9XEnEZlh52bJd+6E6nPKvdQEqs37V0J+A8gN5GY5H3vlGsyy2
         mwJCriy8UzTHFyXEPMETQvt9jDUl+Xtva2HcPceXBU1Uwm+jJ0uvCecX+7ixlAzFk2vK
         /RCfh7v7JoiulPYRKMsM0RoiT1Q1A6n9dGlLICJj8GnVmKVhOaE1kRO2RfWC6L34Maex
         rCWQ==
X-Gm-Message-State: AC+VfDz9dGorlkLRRfM2aaSCHqlPtaYKX3jZzhUd5B4iHATrVKWvQY/4
	XmPT+EC1bqzN8q3k5a0yRfpFgj1iZ4IpNi9SxEsG0Y5lvPbNJVs3Vbo2WebjW2Rp5u0QeH2FErR
	Dm5UPb2aj08cU6VD5EQihAfq1FBhD
X-Received: by 2002:a05:6512:1284:b0:4f9:5ca5:f1a6 with SMTP id u4-20020a056512128400b004f95ca5f1a6mr16579237lfs.17.1688011419914;
        Wed, 28 Jun 2023 21:03:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cOU/Tnj/eLR/sZgklaTn/EVtga+wp/aB7vWCUL+nGkc6R0sHNaT8XmjsRJg3rQcPm4vXaIZRcJR0pJIQiN/A=
X-Received: by 2002:a05:6512:1284:b0:4f9:5ca5:f1a6 with SMTP id
 u4-20020a056512128400b004f95ca5f1a6mr16579220lfs.17.1688011419513; Wed, 28
 Jun 2023 21:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628030506.2213-1-hengqi@linux.alibaba.com>
 <20230628030506.2213-2-hengqi@linux.alibaba.com> <CACGkMEv7aVH0dgdd6N3RMH+57BWuxnq9NR8sPzD9wRQZ5TZRFQ@mail.gmail.com>
 <c6411922-51ad-3d8f-88aa-28883b44573d@linux.alibaba.com> <CACGkMEu=Cs5DFP+EFqxUXaiqz7vewhQ5zMMtChGpR_oGjrvMCg@mail.gmail.com>
 <20230628045626.GA32321@h68b04307.sqa.eu95> <CACGkMEt6Kb60Akn=aJjzJQg6Zg8F_24ezqAtwPOZxiu4-f7E3g@mail.gmail.com>
 <620af708-42a0-f711-cd7c-43362751c842@linux.alibaba.com>
In-Reply-To: <620af708-42a0-f711-cd7c-43362751c842@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jun 2023 12:03:28 +0800
Message-ID: <CACGkMEufm08ym32Ft4ss7AzOjFaEoa5_CuZB29xF9qc3B2ZAhA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] virtio-net: support coexistence of XDP
 and GUEST_CSUM
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 6:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2023/6/28 =E4=B8=8B=E5=8D=882:50, Jason Wang =E5=86=99=E9=81=93=
:
> > On Wed, Jun 28, 2023 at 12:56=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> >> On Wed, Jun 28, 2023 at 12:02:17PM +0800, Jason Wang wrote:
> >>> On Wed, Jun 28, 2023 at 11:42=E2=80=AFAM Heng Qi <hengqi@linux.alibab=
a.com> wrote:
> >>>>
> >>>>
> >>>> =E5=9C=A8 2023/6/28 =E4=B8=8A=E5=8D=8811:22, Jason Wang =E5=86=99=E9=
=81=93:
> >>>>> On Wed, Jun 28, 2023 at 11:05=E2=80=AFAM Heng Qi <hengqi@linux.alib=
aba.com> wrote:
> >>>>>> We are now re-probing the csum related fields and trying
> >>>>>> to have XDP and RX hw checksum capabilities coexist on the
> >>>>>> XDP path. For the benefit of:
> >>>>>> 1. RX hw checksum capability can be used if XDP is loaded.
> >>>>>> 2. Avoid packet loss when loading XDP in the vm-vm scenario.
> >>>>>>
> >>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >>>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>>>>> ---
> >>>>>> v3->v4:
> >>>>>>     - Rewrite some comments.
> >>>>>>
> >>>>>> v2->v3:
> >>>>>>     - Use skb_checksum_setup() instead of virtnet_flow_dissect_udp=
_tcp().
> >>>>>>       Essentially equivalent.
> >>>>>>
> >>>>>>    drivers/net/virtio_net.c | 82 +++++++++++++++++++++++++++++++++=
-------
> >>>>>>    1 file changed, 69 insertions(+), 13 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>>>>> index 5a7f7a76b920..a47342f972b5 100644
> >>>>>> --- a/drivers/net/virtio_net.c
> >>>>>> +++ b/drivers/net/virtio_net.c
> >>>>>> @@ -1568,6 +1568,41 @@ static void virtio_skb_set_hash(const struc=
t virtio_net_hdr_v1_hash *hdr_hash,
> >>>>>>           skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), r=
ss_hash_type);
> >>>>>>    }
> >>>>>>
> >>>>>> +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> >>>>>> +                                     struct sk_buff *skb,
> >>>>>> +                                     __u8 flags)
> >>>>>> +{
> >>>>>> +       int err =3D 0;
> >>>>>> +
> >>>>>> +       /* When XDP program is loaded, the vm-vm scenario on the s=
ame host,
> >>>>>> +        * packets marked VIRTIO_NET_HDR_F_NEEDS_CSUM without a co=
mplete checksum
> >>>>>> +        * will travel. Although these packets are safe from the p=
oint of
> >>>>>> +        * view of the vm, in order to be successfully forwarded o=
n the upper
> >>>>>> +        * layer and to avoid packet loss caused by XDP modificati=
on,
> >>>>>> +        * we re-probe the necessary checksum related information:
> >>>>>> +        * skb->csum_{start, offset}, pseudo-header checksum.
> >>>>>> +        *
> >>>>>> +        * If the received packet is marked VIRTIO_NET_HDR_F_DATA_=
VALID:
> >>>>>> +        * when _F_GUEST_CSUM is negotiated, the device validates =
the checksum
> >>>>>> +        * and virtio-net sets skb->ip_summed to CHECKSUM_UNNECESS=
ARY;
> >>>>>> +        * otherwise, virtio-net hands over to the stack to valida=
te the checksum.
> >>>>>> +        */
> >>>>>> +       if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> >>>>>> +               /* No need to care about SCTP because virtio-net c=
urrently doesn't
> >>>>>> +                * support SCTP CRC checksum offloading, that is, =
SCTP packets have
> >>>>>> +                * complete checksums.
> >>>>>> +                */
> >>>>>> +               err =3D skb_checksum_setup(skb, true);
> >>>>> A second thought, any reason why a checksum is a must here. Could w=
e simply:
> >>>> When net.ipv4.ip_forward sysctl is enabled, such packets may be
> >>>> forwarded (return to the tx path) at the IP layer.
> >>>> If the device has the tx hw checksum offloading cap, packets will ha=
ve
> >>>> complete checksums based on our calculated 'check' value.
> >>> Actually, I mean why can't we offload the checksum to the hardware in=
 this case?
> >> Yes that's what I explained:)
> >>
> >> Checksum of udp/tcp includes the pseudo-header checksum and the checks=
um of the entire udp/tcp payload.
> >> When tx checksum offloading is enabled, the upper layer will only calc=
ulate the pseudo-header checksum,
> >> and the rest of the checksum of the entire udp/tcp payload will be cal=
culated by hardware.
> >>
> >>
> >> Please see udp_send_skb():
> >>
> >> "
> >>          } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) { /* UDP h=
ardware csum */
> >> csum_partial:
> >>
> >>                  udp4_hwcsum(skb, fl4->saddr, fl4->daddr);
> >>                  goto send;
> >>
> >>          } else
> >>                  csum =3D udp_csum(skb);
> >>
> >>          /* add protocol-dependent pseudo-header */
> >>          uh->check =3D csum_tcpudp_magic(fl4->saddr, fl4->daddr, len,
> >>                                        sk->sk_protocol, csum);
> >>          if (uh->check =3D=3D 0)
> >>                  uh->check =3D CSUM_MANGLED_0;
> >>
> >> send:
> >>          err =3D ip_send_skb(sock_net(sk), skb);
> >> "
> > Ok, so I think what I missed is that the CHECKSUM_PARTIAL is set up by
> > skb_checksum_setup() so we don't even need to care about that.
>
> Yes. It works fine after skb_checksum_setup().
>
> >
> >>>>> 1) probe the csum_start/offset
> >>>>> 2) leave it as CHECKSUM_PARTIAL
> >>>>>
> >>>>> ?
> >>>> The reason is as I explained above.
> >>>>
> >>>>>> +       } else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
> >>>>>> +               /* XDP guarantees that packets marked as VIRTIO_NE=
T_HDR_F_DATA_VALID
> >>>>>> +                * still have correct checksum after they are proc=
essed.
> >>>>>> +                */
> >>>>> Do you mean it's the charge of the XDP program to calculate the csu=
m
> >>>>> in this case? Seems strange.
> >>>> Packet with complete checksum (and has been verified by rx device
> >>>> because it has VIRTIO_NET_HDR_F_DATA_VALID)
> >>>> when modified by XDP, XDP program should use the helper provided by =
XDP
> >>>> core to make the checksum correct,
> >>> Could you give me a pointer to that helper?
> >> bpf_csum_diff(),
> > Ok.
> >
> >> bpf_{l3,l4}_csum_replace()
> > This seems not to be a helpr for XDP but for other bpf like cls.
>
> Yes.
>
> >
> >>> Btw, is there a way for
> >>> the XDP program to know whether the csum has been verified by the
> >>> device? ( I guess not).
> >>>
> >> Not. But we only do this (mark skb->ip_summed =3D CHECKSUM_UNNECESSARY=
) for packets with VIRTIO_NET_HDR_F_DATA_VALID now.
> > So if I understand you correctly, you meant for the XDP program that
> > wants to modify the packet:
> >
> > 1) check whether the checksum is valid
> > 2) if yes, recalculate the checksum after the modification
> > 3) if not, just do nothing for the checksum and the driver need to
> > re-probe the csum_start/offset
> >
> > ?
>
> I don't think we need to make many assumptions about the behavior of XDP
> programs.
> Because we are out of control for various users using XDP.

Exactly, but this patch seems to assume the XDP behaviour as you said previ=
ously

"""
> >>>> Packet with complete checksum (and has been verified by rx device
> >>>> because it has VIRTIO_NET_HDR_F_DATA_VALID)
> >>>> when modified by XDP, XDP program should use the helper provided by =
XDP
> >>>> core to make the checksum correct,
"""

?

>
> The core purpose of this patch is to:
> #1 Solve the packet loss problem caused by loading XDP between vm-vm on
> the same host (scenario with partial checksum).

So we disabled guest_csum and the host (e.g TAP) will do checksum for
us. Otherwise it should be a bug of the host.

Thanks

> #2 For scenarios other than #1, virtio-net with this patch is already
> consistent with other existing NIC drivers (simple such as
> ixgbe[1]/bnxt[2]/mvneta[3]/..):
> the rx side only needs to have NETIF_F_RXCSUM and the device has
> verified the packet has a valid checksum.
> Then skb converted from xdp_buff (XDP returns XDP_PASS) can have
> skb->ip_summed =3D CHECKSUM_UNNECESSARY.
>
> If the comment for DATA_VALID is confusing, I'll just remove it.
>
> [1] ixgbe_clean_rx_irq()-> ixgbe_run_xdp()-> ixgbe_process_skb_fields()
> ->ixgbe_rx_checksum()
> [2] bnxt_xdp_build_skb()
> [3] mvneta_swbm_build_skb
>
> Thanks.
>
> >
> > Thanks
> >
> >> Thanks.
> >>
> >>> Thanks
> >>>
> >>>
> >>>> otherwise, VIRTIO_NET_HDR_F_DATA_VALID has been cleared and skb
> >>>> ->ip_summed=3DCHECKSUM_NONE, so the stack
> >>>> will re-verify the checksum, causing packet loss due to wrong checks=
um.
> >>>>
> >>>> Thanks.
> >>>>
> >>>>> Thanks
> >>>>>
> >>>>>> +               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       return err;
> >>>>>> +}
> >>>>>> +
> >>>>>>    static void receive_buf(struct virtnet_info *vi, struct receive=
_queue *rq,
> >>>>>>                           void *buf, unsigned int len, void **ctx,
> >>>>>>                           unsigned int *xdp_xmit,
> >>>>>> @@ -1576,6 +1611,7 @@ static void receive_buf(struct virtnet_info =
*vi, struct receive_queue *rq,
> >>>>>>           struct net_device *dev =3D vi->dev;
> >>>>>>           struct sk_buff *skb;
> >>>>>>           struct virtio_net_hdr_mrg_rxbuf *hdr;
> >>>>>> +       __u8 flags;
> >>>>>>
> >>>>>>           if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >>>>>>                   pr_debug("%s: short packet %i\n", dev->name, len=
);
> >>>>>> @@ -1584,6 +1620,12 @@ static void receive_buf(struct virtnet_info=
 *vi, struct receive_queue *rq,
> >>>>>>                   return;
> >>>>>>           }
> >>>>>>
> >>>>>> +       /* XDP may modify/overwrite the packet, including the virt=
net hdr,
> >>>>>> +        * so save the flags of the virtnet hdr before XDP process=
ing.
> >>>>>> +        */
> >>>>>> +       if (unlikely(vi->xdp_enabled))
> >>>>>> +               flags =3D ((struct virtio_net_hdr_mrg_rxbuf *)buf)=
->hdr.flags;
> >>>>>> +
> >>>>>>           if (vi->mergeable_rx_bufs)
> >>>>>>                   skb =3D receive_mergeable(dev, vi, rq, buf, ctx,=
 len, xdp_xmit,
> >>>>>>                                           stats);
> >>>>>> @@ -1595,23 +1637,37 @@ static void receive_buf(struct virtnet_inf=
o *vi, struct receive_queue *rq,
> >>>>>>           if (unlikely(!skb))
> >>>>>>                   return;
> >>>>>>
> >>>>>> -       hdr =3D skb_vnet_hdr(skb);
> >>>>>> -       if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_rep=
ort)
> >>>>>> -               virtio_skb_set_hash((const struct virtio_net_hdr_v=
1_hash *)hdr, skb);
> >>>>>> -
> >>>>>> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >>>>>> -               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >>>>>> +       if (unlikely(vi->xdp_enabled)) {
> >>>>>> +               /* Required to do this before re-probing and calcu=
lating
> >>>>>> +                * the pseudo-header checksum.
> >>>>>> +                */
> >>>>>> +               skb->protocol =3D eth_type_trans(skb, dev);
> >>>>>> +               skb_reset_network_header(skb);
> >>>>>> +               if (virtnet_set_csum_after_xdp(vi, skb, flags) < 0=
) {
> >>>>>> +                       pr_debug("%s: errors occurred in setting p=
artial csum",
> >>>>>> +                                dev->name);
> >>>>>> +                       goto frame_err;
> >>>>>> +               }
> >>>>>> +       } else {
> >>>>>> +               hdr =3D skb_vnet_hdr(skb);
> >>>>>> +               if (dev->features & NETIF_F_RXHASH && vi->has_rss_=
hash_report)
> >>>>>> +                       virtio_skb_set_hash((const struct virtio_n=
et_hdr_v1_hash *)hdr, skb);
> >>>>>> +
> >>>>>> +               if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >>>>>> +                       skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >>>>>> +
> >>>>>> +               if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> >>>>>> +                                         virtio_is_little_endian(=
vi->vdev))) {
> >>>>>> +                       net_warn_ratelimited("%s: bad gso: type: %=
u, size: %u\n",
> >>>>>> +                                            dev->name, hdr->hdr.g=
so_type,
> >>>>>> +                                            hdr->hdr.gso_size);
> >>>>>> +                       goto frame_err;
> >>>>>> +               }
> >>>>>>
> >>>>>> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> >>>>>> -                                 virtio_is_little_endian(vi->vdev=
))) {
> >>>>>> -               net_warn_ratelimited("%s: bad gso: type: %u, size:=
 %u\n",
> >>>>>> -                                    dev->name, hdr->hdr.gso_type,
> >>>>>> -                                    hdr->hdr.gso_size);
> >>>>>> -               goto frame_err;
> >>>>>> +               skb->protocol =3D eth_type_trans(skb, dev);
> >>>>>>           }
> >>>>>>
> >>>>>>           skb_record_rx_queue(skb, vq2rxq(rq->vq));
> >>>>>> -       skb->protocol =3D eth_type_trans(skb, dev);
> >>>>>>           pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
> >>>>>>                    ntohs(skb->protocol), skb->len, skb->pkt_type);
> >>>>>>
> >>>>>> --
> >>>>>> 2.19.1.6.gb485710b
> >>>>>>
>


