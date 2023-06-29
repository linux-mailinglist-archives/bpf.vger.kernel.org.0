Return-Path: <bpf+bounces-3688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97529741F2F
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F88280D11
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 04:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCED4C99;
	Thu, 29 Jun 2023 04:12:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070521FDC
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 04:12:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091C7E5
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 21:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688011932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2lvn2f3fSywVKS/t8Shh/i/6f1hWmUUtSOwlDUdoDk=;
	b=hM11UU7Yb+WHnWukw4P3we3b5IFYnBBnBR0N+wFYuKGg1QTUXpBmVX16T9kmTFflTJdmxr
	IusZlj4+rwee7bgpRGbb6pjINdg+pMUtp4Pj8Qso8q98SKUgGdyAT6o1gUV9jmqKyUPBTo
	h9qNiBEw3uY8yf2mf18AgyYd0edoL3Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-tcCsoZELOxeTg3E0oW6XVQ-1; Thu, 29 Jun 2023 00:12:10 -0400
X-MC-Unique: tcCsoZELOxeTg3E0oW6XVQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4edc7ab63ccso239475e87.3
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 21:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688011929; x=1690603929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2lvn2f3fSywVKS/t8Shh/i/6f1hWmUUtSOwlDUdoDk=;
        b=M+SDJwocOJg47po63gqDZHsXMsrXoyoGqHuMJicRImW7QpDTTSJLr612Czqriiy9EY
         h2avF+geJuASt8mvRQGzarJ493yF4n+KU8RZ7JgE1T0iL6kc9N1asG/INz8F3sLvO0b9
         Ul0COJUA/xMtla6xon5uG00MrpRWUQOghymhfx2m8hIEPmWfirrnM74rFFfRNG12RI0H
         9mW8d0zvvZbYndmwHJVd6cojJp8fviphI6s4ASkAXK/0mxr6cT/Rd7zgLKH5rGaHz5MH
         QZw+/jEhQ8llaBPNi8FpGfuxInhNxGxbRllCeDX3hBAYNmB7NgKGMhy8g5tSk0dfCxQd
         aytw==
X-Gm-Message-State: AC+VfDzE85qpUav+2351SGvEhIu/aa+bex3Uky3hZh1o0ZfrSe4F/H9M
	RTGNhnk1rZr+974BvC1r6cvFehz88A8Nygspsk8DMQJTA5eMPHB8DZGdhGcaydMEmMDW2nkaSYr
	dqISTAVYZc8mnf8Lc+GH1M7pz9tUc
X-Received: by 2002:a2e:7209:0:b0:2b4:5a0b:9290 with SMTP id n9-20020a2e7209000000b002b45a0b9290mr24625438ljc.21.1688011928823;
        Wed, 28 Jun 2023 21:12:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5u3PrnrPX8kMdIoSNLOrVU0PdqDS9luxCp+4Shjgnj2nu9IFLRt12sr0/3xZJQ8PseZdefYxSZgNRHnnGGOWM=
X-Received: by 2002:a2e:7209:0:b0:2b4:5a0b:9290 with SMTP id
 n9-20020a2e7209000000b002b45a0b9290mr24625422ljc.21.1688011928440; Wed, 28
 Jun 2023 21:12:08 -0700 (PDT)
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
 <620af708-42a0-f711-cd7c-43362751c842@linux.alibaba.com> <CACGkMEufm08ym32Ft4ss7AzOjFaEoa5_CuZB29xF9qc3B2ZAhA@mail.gmail.com>
In-Reply-To: <CACGkMEufm08ym32Ft4ss7AzOjFaEoa5_CuZB29xF9qc3B2ZAhA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jun 2023 12:11:57 +0800
Message-ID: <CACGkMEukz+XZcNb4xrjV=jcUcpJsQQtkDphaapbVU5jz-wRcsg@mail.gmail.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 12:03=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Jun 28, 2023 at 6:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> >
> >
> > =E5=9C=A8 2023/6/28 =E4=B8=8B=E5=8D=882:50, Jason Wang =E5=86=99=E9=81=
=93:
> > > On Wed, Jun 28, 2023 at 12:56=E2=80=AFPM Heng Qi <hengqi@linux.alibab=
a.com> wrote:
> > >> On Wed, Jun 28, 2023 at 12:02:17PM +0800, Jason Wang wrote:
> > >>> On Wed, Jun 28, 2023 at 11:42=E2=80=AFAM Heng Qi <hengqi@linux.alib=
aba.com> wrote:
> > >>>>
> > >>>>
> > >>>> =E5=9C=A8 2023/6/28 =E4=B8=8A=E5=8D=8811:22, Jason Wang =E5=86=99=
=E9=81=93:
> > >>>>> On Wed, Jun 28, 2023 at 11:05=E2=80=AFAM Heng Qi <hengqi@linux.al=
ibaba.com> wrote:
> > >>>>>> We are now re-probing the csum related fields and trying
> > >>>>>> to have XDP and RX hw checksum capabilities coexist on the
> > >>>>>> XDP path. For the benefit of:
> > >>>>>> 1. RX hw checksum capability can be used if XDP is loaded.
> > >>>>>> 2. Avoid packet loss when loading XDP in the vm-vm scenario.
> > >>>>>>
> > >>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > >>>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >>>>>> ---
> > >>>>>> v3->v4:
> > >>>>>>     - Rewrite some comments.
> > >>>>>>
> > >>>>>> v2->v3:
> > >>>>>>     - Use skb_checksum_setup() instead of virtnet_flow_dissect_u=
dp_tcp().
> > >>>>>>       Essentially equivalent.
> > >>>>>>
> > >>>>>>    drivers/net/virtio_net.c | 82 +++++++++++++++++++++++++++++++=
++-------
> > >>>>>>    1 file changed, 69 insertions(+), 13 deletions(-)
> > >>>>>>
> > >>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > >>>>>> index 5a7f7a76b920..a47342f972b5 100644
> > >>>>>> --- a/drivers/net/virtio_net.c
> > >>>>>> +++ b/drivers/net/virtio_net.c
> > >>>>>> @@ -1568,6 +1568,41 @@ static void virtio_skb_set_hash(const str=
uct virtio_net_hdr_v1_hash *hdr_hash,
> > >>>>>>           skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value),=
 rss_hash_type);
> > >>>>>>    }
> > >>>>>>
> > >>>>>> +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> > >>>>>> +                                     struct sk_buff *skb,
> > >>>>>> +                                     __u8 flags)
> > >>>>>> +{
> > >>>>>> +       int err =3D 0;
> > >>>>>> +
> > >>>>>> +       /* When XDP program is loaded, the vm-vm scenario on the=
 same host,
> > >>>>>> +        * packets marked VIRTIO_NET_HDR_F_NEEDS_CSUM without a =
complete checksum
> > >>>>>> +        * will travel. Although these packets are safe from the=
 point of
> > >>>>>> +        * view of the vm, in order to be successfully forwarded=
 on the upper
> > >>>>>> +        * layer and to avoid packet loss caused by XDP modifica=
tion,
> > >>>>>> +        * we re-probe the necessary checksum related informatio=
n:
> > >>>>>> +        * skb->csum_{start, offset}, pseudo-header checksum.
> > >>>>>> +        *
> > >>>>>> +        * If the received packet is marked VIRTIO_NET_HDR_F_DAT=
A_VALID:
> > >>>>>> +        * when _F_GUEST_CSUM is negotiated, the device validate=
s the checksum
> > >>>>>> +        * and virtio-net sets skb->ip_summed to CHECKSUM_UNNECE=
SSARY;
> > >>>>>> +        * otherwise, virtio-net hands over to the stack to vali=
date the checksum.
> > >>>>>> +        */
> > >>>>>> +       if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> > >>>>>> +               /* No need to care about SCTP because virtio-net=
 currently doesn't
> > >>>>>> +                * support SCTP CRC checksum offloading, that is=
, SCTP packets have
> > >>>>>> +                * complete checksums.
> > >>>>>> +                */
> > >>>>>> +               err =3D skb_checksum_setup(skb, true);
> > >>>>> A second thought, any reason why a checksum is a must here. Could=
 we simply:
> > >>>> When net.ipv4.ip_forward sysctl is enabled, such packets may be
> > >>>> forwarded (return to the tx path) at the IP layer.
> > >>>> If the device has the tx hw checksum offloading cap, packets will =
have
> > >>>> complete checksums based on our calculated 'check' value.
> > >>> Actually, I mean why can't we offload the checksum to the hardware =
in this case?
> > >> Yes that's what I explained:)
> > >>
> > >> Checksum of udp/tcp includes the pseudo-header checksum and the chec=
ksum of the entire udp/tcp payload.
> > >> When tx checksum offloading is enabled, the upper layer will only ca=
lculate the pseudo-header checksum,
> > >> and the rest of the checksum of the entire udp/tcp payload will be c=
alculated by hardware.
> > >>
> > >>
> > >> Please see udp_send_skb():
> > >>
> > >> "
> > >>          } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) { /* UDP=
 hardware csum */
> > >> csum_partial:
> > >>
> > >>                  udp4_hwcsum(skb, fl4->saddr, fl4->daddr);
> > >>                  goto send;
> > >>
> > >>          } else
> > >>                  csum =3D udp_csum(skb);
> > >>
> > >>          /* add protocol-dependent pseudo-header */
> > >>          uh->check =3D csum_tcpudp_magic(fl4->saddr, fl4->daddr, len=
,
> > >>                                        sk->sk_protocol, csum);
> > >>          if (uh->check =3D=3D 0)
> > >>                  uh->check =3D CSUM_MANGLED_0;
> > >>
> > >> send:
> > >>          err =3D ip_send_skb(sock_net(sk), skb);
> > >> "
> > > Ok, so I think what I missed is that the CHECKSUM_PARTIAL is set up b=
y
> > > skb_checksum_setup() so we don't even need to care about that.
> >
> > Yes. It works fine after skb_checksum_setup().
> >
> > >
> > >>>>> 1) probe the csum_start/offset
> > >>>>> 2) leave it as CHECKSUM_PARTIAL
> > >>>>>
> > >>>>> ?
> > >>>> The reason is as I explained above.
> > >>>>
> > >>>>>> +       } else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
> > >>>>>> +               /* XDP guarantees that packets marked as VIRTIO_=
NET_HDR_F_DATA_VALID
> > >>>>>> +                * still have correct checksum after they are pr=
ocessed.
> > >>>>>> +                */
> > >>>>> Do you mean it's the charge of the XDP program to calculate the c=
sum
> > >>>>> in this case? Seems strange.
> > >>>> Packet with complete checksum (and has been verified by rx device
> > >>>> because it has VIRTIO_NET_HDR_F_DATA_VALID)
> > >>>> when modified by XDP, XDP program should use the helper provided b=
y XDP
> > >>>> core to make the checksum correct,
> > >>> Could you give me a pointer to that helper?
> > >> bpf_csum_diff(),
> > > Ok.
> > >
> > >> bpf_{l3,l4}_csum_replace()
> > > This seems not to be a helpr for XDP but for other bpf like cls.
> >
> > Yes.
> >
> > >
> > >>> Btw, is there a way for
> > >>> the XDP program to know whether the csum has been verified by the
> > >>> device? ( I guess not).
> > >>>
> > >> Not. But we only do this (mark skb->ip_summed =3D CHECKSUM_UNNECESSA=
RY) for packets with VIRTIO_NET_HDR_F_DATA_VALID now.
> > > So if I understand you correctly, you meant for the XDP program that
> > > wants to modify the packet:
> > >
> > > 1) check whether the checksum is valid
> > > 2) if yes, recalculate the checksum after the modification
> > > 3) if not, just do nothing for the checksum and the driver need to
> > > re-probe the csum_start/offset
> > >
> > > ?
> >
> > I don't think we need to make many assumptions about the behavior of XD=
P
> > programs.
> > Because we are out of control for various users using XDP.
>
> Exactly, but this patch seems to assume the XDP behaviour as you said pre=
viously
>
> """
> > >>>> Packet with complete checksum (and has been verified by rx device
> > >>>> because it has VIRTIO_NET_HDR_F_DATA_VALID)
> > >>>> when modified by XDP, XDP program should use the helper provided b=
y XDP
> > >>>> core to make the checksum correct,
> """
>
> ?
>
> >
> > The core purpose of this patch is to:
> > #1 Solve the packet loss problem caused by loading XDP between vm-vm on
> > the same host (scenario with partial checksum).
>
> So we disabled guest_csum and the host (e.g TAP) will do checksum for
> us. Otherwise it should be a bug of the host.
>
> Thanks

Btw, it looks to me that this patch doesn't fix the XDP_TX path?
Should we do that or it's not related at all?

Thanks

>
> > #2 For scenarios other than #1, virtio-net with this patch is already
> > consistent with other existing NIC drivers (simple such as
> > ixgbe[1]/bnxt[2]/mvneta[3]/..):
> > the rx side only needs to have NETIF_F_RXCSUM and the device has
> > verified the packet has a valid checksum.
> > Then skb converted from xdp_buff (XDP returns XDP_PASS) can have
> > skb->ip_summed =3D CHECKSUM_UNNECESSARY.
> >
> > If the comment for DATA_VALID is confusing, I'll just remove it.
> >
> > [1] ixgbe_clean_rx_irq()-> ixgbe_run_xdp()-> ixgbe_process_skb_fields()
> > ->ixgbe_rx_checksum()
> > [2] bnxt_xdp_build_skb()
> > [3] mvneta_swbm_build_skb
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > >> Thanks.
> > >>
> > >>> Thanks
> > >>>
> > >>>
> > >>>> otherwise, VIRTIO_NET_HDR_F_DATA_VALID has been cleared and skb
> > >>>> ->ip_summed=3DCHECKSUM_NONE, so the stack
> > >>>> will re-verify the checksum, causing packet loss due to wrong chec=
ksum.
> > >>>>
> > >>>> Thanks.
> > >>>>
> > >>>>> Thanks
> > >>>>>
> > >>>>>> +               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > >>>>>> +       }
> > >>>>>> +
> > >>>>>> +       return err;
> > >>>>>> +}
> > >>>>>> +
> > >>>>>>    static void receive_buf(struct virtnet_info *vi, struct recei=
ve_queue *rq,
> > >>>>>>                           void *buf, unsigned int len, void **ct=
x,
> > >>>>>>                           unsigned int *xdp_xmit,
> > >>>>>> @@ -1576,6 +1611,7 @@ static void receive_buf(struct virtnet_inf=
o *vi, struct receive_queue *rq,
> > >>>>>>           struct net_device *dev =3D vi->dev;
> > >>>>>>           struct sk_buff *skb;
> > >>>>>>           struct virtio_net_hdr_mrg_rxbuf *hdr;
> > >>>>>> +       __u8 flags;
> > >>>>>>
> > >>>>>>           if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > >>>>>>                   pr_debug("%s: short packet %i\n", dev->name, l=
en);
> > >>>>>> @@ -1584,6 +1620,12 @@ static void receive_buf(struct virtnet_in=
fo *vi, struct receive_queue *rq,
> > >>>>>>                   return;
> > >>>>>>           }
> > >>>>>>
> > >>>>>> +       /* XDP may modify/overwrite the packet, including the vi=
rtnet hdr,
> > >>>>>> +        * so save the flags of the virtnet hdr before XDP proce=
ssing.
> > >>>>>> +        */
> > >>>>>> +       if (unlikely(vi->xdp_enabled))
> > >>>>>> +               flags =3D ((struct virtio_net_hdr_mrg_rxbuf *)bu=
f)->hdr.flags;
> > >>>>>> +
> > >>>>>>           if (vi->mergeable_rx_bufs)
> > >>>>>>                   skb =3D receive_mergeable(dev, vi, rq, buf, ct=
x, len, xdp_xmit,
> > >>>>>>                                           stats);
> > >>>>>> @@ -1595,23 +1637,37 @@ static void receive_buf(struct virtnet_i=
nfo *vi, struct receive_queue *rq,
> > >>>>>>           if (unlikely(!skb))
> > >>>>>>                   return;
> > >>>>>>
> > >>>>>> -       hdr =3D skb_vnet_hdr(skb);
> > >>>>>> -       if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_r=
eport)
> > >>>>>> -               virtio_skb_set_hash((const struct virtio_net_hdr=
_v1_hash *)hdr, skb);
> > >>>>>> -
> > >>>>>> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > >>>>>> -               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > >>>>>> +       if (unlikely(vi->xdp_enabled)) {
> > >>>>>> +               /* Required to do this before re-probing and cal=
culating
> > >>>>>> +                * the pseudo-header checksum.
> > >>>>>> +                */
> > >>>>>> +               skb->protocol =3D eth_type_trans(skb, dev);
> > >>>>>> +               skb_reset_network_header(skb);
> > >>>>>> +               if (virtnet_set_csum_after_xdp(vi, skb, flags) <=
 0) {
> > >>>>>> +                       pr_debug("%s: errors occurred in setting=
 partial csum",
> > >>>>>> +                                dev->name);
> > >>>>>> +                       goto frame_err;
> > >>>>>> +               }
> > >>>>>> +       } else {
> > >>>>>> +               hdr =3D skb_vnet_hdr(skb);
> > >>>>>> +               if (dev->features & NETIF_F_RXHASH && vi->has_rs=
s_hash_report)
> > >>>>>> +                       virtio_skb_set_hash((const struct virtio=
_net_hdr_v1_hash *)hdr, skb);
> > >>>>>> +
> > >>>>>> +               if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID=
)
> > >>>>>> +                       skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > >>>>>> +
> > >>>>>> +               if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > >>>>>> +                                         virtio_is_little_endia=
n(vi->vdev))) {
> > >>>>>> +                       net_warn_ratelimited("%s: bad gso: type:=
 %u, size: %u\n",
> > >>>>>> +                                            dev->name, hdr->hdr=
.gso_type,
> > >>>>>> +                                            hdr->hdr.gso_size);
> > >>>>>> +                       goto frame_err;
> > >>>>>> +               }
> > >>>>>>
> > >>>>>> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > >>>>>> -                                 virtio_is_little_endian(vi->vd=
ev))) {
> > >>>>>> -               net_warn_ratelimited("%s: bad gso: type: %u, siz=
e: %u\n",
> > >>>>>> -                                    dev->name, hdr->hdr.gso_typ=
e,
> > >>>>>> -                                    hdr->hdr.gso_size);
> > >>>>>> -               goto frame_err;
> > >>>>>> +               skb->protocol =3D eth_type_trans(skb, dev);
> > >>>>>>           }
> > >>>>>>
> > >>>>>>           skb_record_rx_queue(skb, vq2rxq(rq->vq));
> > >>>>>> -       skb->protocol =3D eth_type_trans(skb, dev);
> > >>>>>>           pr_debug("Receiving skb proto 0x%04x len %i type %i\n"=
,
> > >>>>>>                    ntohs(skb->protocol), skb->len, skb->pkt_type=
);
> > >>>>>>
> > >>>>>> --
> > >>>>>> 2.19.1.6.gb485710b
> > >>>>>>
> >


