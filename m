Return-Path: <bpf+bounces-3857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65062745580
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 08:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F84280CAD
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 06:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F55A53;
	Mon,  3 Jul 2023 06:34:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC68803
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 06:34:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C704BCD
	for <bpf@vger.kernel.org>; Sun,  2 Jul 2023 23:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688366051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6a669b1x2J6LgBeA73rHbee6DDL5OZtWTQgOJrhA/s=;
	b=a1cM6lHxVYgVjF3Gi7BVP+KsUwDFrilA+KVoxEDCcLiIGHt2Wq/XDB0EAlxr4wKn7UVOjo
	TVfaGl0emZhw1pZjYl67/tbbDCJxx7pkiffPMidqjo+QGqO452/utYcQfA9/E4rMeQM0ae
	oBBrbK15xPIEu50PM5syLzMlX96FsQI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-9mF2D0NCPCSToh6I6bAQVg-1; Mon, 03 Jul 2023 02:34:09 -0400
X-MC-Unique: 9mF2D0NCPCSToh6I6bAQVg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b69fa936e2so32793961fa.1
        for <bpf@vger.kernel.org>; Sun, 02 Jul 2023 23:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688366048; x=1690958048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6a669b1x2J6LgBeA73rHbee6DDL5OZtWTQgOJrhA/s=;
        b=XnmDkH41G1rmU/r3QC2D5ejhvvu7s9m6AaSyL3X+iUCR/JmUzcHyCXcihLJplbkycR
         6ve60QmAJk7rlOmVl5tuIWMO1S04NGMufMbcdTwruMl5thkX7qTvzYGpjbrWH0Xpzarg
         StArDTo1494VxEz8Tg094qAmlK6E0Tf+rb7TKskUjKFUphlR7eVdFoiFZvFhnmIwXs3L
         aG8Kv+wC4+ZDfGPIS23xN6SWknw/mp83NKsU2rV/GcIV1czAvi5IRcEFGzq0BKWO8H5b
         0o1kVAzCFcpmJw4jXMlorEypAoi8FO59nz1Co3KZUpQSlOMbfZR0MeofLNLjXfYJmq2X
         VHsg==
X-Gm-Message-State: ABy/qLaG65+G0a0JXUsSPmyvQlmdrCo22hzWTYoikQjoPHbCgyjcJ9a9
	DHlRWY730aQLnnMjn1JD1iVGiL0frcOdn4W+73uBmSQFbGyMkI2o+qIbi2Uk9/rovDX/ANbnPnw
	QArwBIFwqcrIVSAsZGDlTclKyQys2
X-Received: by 2002:a2e:98c7:0:b0:2b6:c8e8:915f with SMTP id s7-20020a2e98c7000000b002b6c8e8915fmr6968182ljj.22.1688366048360;
        Sun, 02 Jul 2023 23:34:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFjPw63sIYXwLDTKxPyJP0e4YboN3IYduWPT5CnDwlh52J8sjQnK+uf+JMHxN/ydWWJoWHnxbHP51we787AfRk=
X-Received: by 2002:a2e:98c7:0:b0:2b6:c8e8:915f with SMTP id
 s7-20020a2e98c7000000b002b6c8e8915fmr6968159ljj.22.1688366047941; Sun, 02 Jul
 2023 23:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628030506.2213-2-hengqi@linux.alibaba.com>
 <CACGkMEv7aVH0dgdd6N3RMH+57BWuxnq9NR8sPzD9wRQZ5TZRFQ@mail.gmail.com>
 <c6411922-51ad-3d8f-88aa-28883b44573d@linux.alibaba.com> <CACGkMEu=Cs5DFP+EFqxUXaiqz7vewhQ5zMMtChGpR_oGjrvMCg@mail.gmail.com>
 <20230628045626.GA32321@h68b04307.sqa.eu95> <CACGkMEt6Kb60Akn=aJjzJQg6Zg8F_24ezqAtwPOZxiu4-f7E3g@mail.gmail.com>
 <620af708-42a0-f711-cd7c-43362751c842@linux.alibaba.com> <CACGkMEufm08ym32Ft4ss7AzOjFaEoa5_CuZB29xF9qc3B2ZAhA@mail.gmail.com>
 <20230629054740.GA77232@h68b04307.sqa.eu95> <CACGkMEtASF=yFBroLadN=qeMhHZndwydM76xMshED50UzH8Z8w@mail.gmail.com>
 <20230630095754.GA66468@h68b04307.sqa.eu95> <8ba4d3fc-08e0-4796-5045-f6a8600df84b@linux.alibaba.com>
In-Reply-To: <8ba4d3fc-08e0-4796-5045-f6a8600df84b@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Jul 2023 14:33:55 +0800
Message-ID: <CACGkMEt_2kW9Z4i_qe-wNbDQe4W5VnTSFDmAgCfx5nTiGy2VWg@mail.gmail.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 3, 2023 at 12:48=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2023/6/30 =E4=B8=8B=E5=8D=885:57, Heng Qi =E5=86=99=E9=81=93:
> > On Fri, Jun 30, 2023 at 03:35:08PM +0800, Jason Wang wrote:
> >> On Thu, Jun 29, 2023 at 1:47=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> >>> On Thu, Jun 29, 2023 at 12:03:28PM +0800, Jason Wang wrote:
> >>>> On Wed, Jun 28, 2023 at 6:02=E2=80=AFPM Heng Qi <hengqi@linux.alibab=
a.com> wrote:
> >>>>>
> >>>>>
> >>>>> =E5=9C=A8 2023/6/28 =E4=B8=8B=E5=8D=882:50, Jason Wang =E5=86=99=E9=
=81=93:
> >>>>>> On Wed, Jun 28, 2023 at 12:56=E2=80=AFPM Heng Qi <hengqi@linux.ali=
baba.com> wrote:
> >>>>>>> On Wed, Jun 28, 2023 at 12:02:17PM +0800, Jason Wang wrote:
> >>>>>>>> On Wed, Jun 28, 2023 at 11:42=E2=80=AFAM Heng Qi <hengqi@linux.a=
libaba.com> wrote:
> >>>>>>>>>
> >>>>>>>>> =E5=9C=A8 2023/6/28 =E4=B8=8A=E5=8D=8811:22, Jason Wang =E5=86=
=99=E9=81=93:
> >>>>>>>>>> On Wed, Jun 28, 2023 at 11:05=E2=80=AFAM Heng Qi <hengqi@linux=
.alibaba.com> wrote:
> >>>>>>>>>>> We are now re-probing the csum related fields and trying
> >>>>>>>>>>> to have XDP and RX hw checksum capabilities coexist on the
> >>>>>>>>>>> XDP path. For the benefit of:
> >>>>>>>>>>> 1. RX hw checksum capability can be used if XDP is loaded.
> >>>>>>>>>>> 2. Avoid packet loss when loading XDP in the vm-vm scenario.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >>>>>>>>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>> v3->v4:
> >>>>>>>>>>>      - Rewrite some comments.
> >>>>>>>>>>>
> >>>>>>>>>>> v2->v3:
> >>>>>>>>>>>      - Use skb_checksum_setup() instead of virtnet_flow_disse=
ct_udp_tcp().
> >>>>>>>>>>>        Essentially equivalent.
> >>>>>>>>>>>
> >>>>>>>>>>>     drivers/net/virtio_net.c | 82 +++++++++++++++++++++++++++=
++++++-------
> >>>>>>>>>>>     1 file changed, 69 insertions(+), 13 deletions(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_ne=
t.c
> >>>>>>>>>>> index 5a7f7a76b920..a47342f972b5 100644
> >>>>>>>>>>> --- a/drivers/net/virtio_net.c
> >>>>>>>>>>> +++ b/drivers/net/virtio_net.c
> >>>>>>>>>>> @@ -1568,6 +1568,41 @@ static void virtio_skb_set_hash(const =
struct virtio_net_hdr_v1_hash *hdr_hash,
> >>>>>>>>>>>            skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_val=
ue), rss_hash_type);
> >>>>>>>>>>>     }
> >>>>>>>>>>>
> >>>>>>>>>>> +static int virtnet_set_csum_after_xdp(struct virtnet_info *v=
i,
> >>>>>>>>>>> +                                     struct sk_buff *skb,
> >>>>>>>>>>> +                                     __u8 flags)
> >>>>>>>>>>> +{
> >>>>>>>>>>> +       int err =3D 0;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       /* When XDP program is loaded, the vm-vm scenario on =
the same host,
> >>>>>>>>>>> +        * packets marked VIRTIO_NET_HDR_F_NEEDS_CSUM without=
 a complete checksum
> >>>>>>>>>>> +        * will travel. Although these packets are safe from =
the point of
> >>>>>>>>>>> +        * view of the vm, in order to be successfully forwar=
ded on the upper
> >>>>>>>>>>> +        * layer and to avoid packet loss caused by XDP modif=
ication,
> >>>>>>>>>>> +        * we re-probe the necessary checksum related informa=
tion:
> >>>>>>>>>>> +        * skb->csum_{start, offset}, pseudo-header checksum.
> >>>>>>>>>>> +        *
> >>>>>>>>>>> +        * If the received packet is marked VIRTIO_NET_HDR_F_=
DATA_VALID:
> >>>>>>>>>>> +        * when _F_GUEST_CSUM is negotiated, the device valid=
ates the checksum
> >>>>>>>>>>> +        * and virtio-net sets skb->ip_summed to CHECKSUM_UNN=
ECESSARY;
> >>>>>>>>>>> +        * otherwise, virtio-net hands over to the stack to v=
alidate the checksum.
> >>>>>>>>>>> +        */
> >>>>>>>>>>> +       if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> >>>>>>>>>>> +               /* No need to care about SCTP because virtio-=
net currently doesn't
> >>>>>>>>>>> +                * support SCTP CRC checksum offloading, that=
 is, SCTP packets have
> >>>>>>>>>>> +                * complete checksums.
> >>>>>>>>>>> +                */
> >>>>>>>>>>> +               err =3D skb_checksum_setup(skb, true);
> >>>>>>>>>> A second thought, any reason why a checksum is a must here. Co=
uld we simply:
> >>>>>>>>> When net.ipv4.ip_forward sysctl is enabled, such packets may be
> >>>>>>>>> forwarded (return to the tx path) at the IP layer.
> >>>>>>>>> If the device has the tx hw checksum offloading cap, packets wi=
ll have
> >>>>>>>>> complete checksums based on our calculated 'check' value.
> >>>>>>>> Actually, I mean why can't we offload the checksum to the hardwa=
re in this case?
> >>>>>>> Yes that's what I explained:)
> >>>>>>>
> >>>>>>> Checksum of udp/tcp includes the pseudo-header checksum and the c=
hecksum of the entire udp/tcp payload.
> >>>>>>> When tx checksum offloading is enabled, the upper layer will only=
 calculate the pseudo-header checksum,
> >>>>>>> and the rest of the checksum of the entire udp/tcp payload will b=
e calculated by hardware.
> >>>>>>>
> >>>>>>>
> >>>>>>> Please see udp_send_skb():
> >>>>>>>
> >>>>>>> "
> >>>>>>>           } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) { /*=
 UDP hardware csum */
> >>>>>>> csum_partial:
> >>>>>>>
> >>>>>>>                   udp4_hwcsum(skb, fl4->saddr, fl4->daddr);
> >>>>>>>                   goto send;
> >>>>>>>
> >>>>>>>           } else
> >>>>>>>                   csum =3D udp_csum(skb);
> >>>>>>>
> >>>>>>>           /* add protocol-dependent pseudo-header */
> >>>>>>>           uh->check =3D csum_tcpudp_magic(fl4->saddr, fl4->daddr,=
 len,
> >>>>>>>                                         sk->sk_protocol, csum);
> >>>>>>>           if (uh->check =3D=3D 0)
> >>>>>>>                   uh->check =3D CSUM_MANGLED_0;
> >>>>>>>
> >>>>>>> send:
> >>>>>>>           err =3D ip_send_skb(sock_net(sk), skb);
> >>>>>>> "
> >>>>>> Ok, so I think what I missed is that the CHECKSUM_PARTIAL is set u=
p by
> >>>>>> skb_checksum_setup() so we don't even need to care about that.
> >>>>> Yes. It works fine after skb_checksum_setup().
> >>>>>
> >>>>>>>>>> 1) probe the csum_start/offset
> >>>>>>>>>> 2) leave it as CHECKSUM_PARTIAL
> >>>>>>>>>>
> >>>>>>>>>> ?
> >>>>>>>>> The reason is as I explained above.
> >>>>>>>>>
> >>>>>>>>>>> +       } else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
> >>>>>>>>>>> +               /* XDP guarantees that packets marked as VIRT=
IO_NET_HDR_F_DATA_VALID
> >>>>>>>>>>> +                * still have correct checksum after they are=
 processed.
> >>>>>>>>>>> +                */
> >>>>>>>>>> Do you mean it's the charge of the XDP program to calculate th=
e csum
> >>>>>>>>>> in this case? Seems strange.
> >>>>>>>>> Packet with complete checksum (and has been verified by rx devi=
ce
> >>>>>>>>> because it has VIRTIO_NET_HDR_F_DATA_VALID)
> >>>>>>>>> when modified by XDP, XDP program should use the helper provide=
d by XDP
> >>>>>>>>> core to make the checksum correct,
> >>>>>>>> Could you give me a pointer to that helper?
> >>>>>>> bpf_csum_diff(),
> >>>>>> Ok.
> >>>>>>
> >>>>>>> bpf_{l3,l4}_csum_replace()
> >>>>>> This seems not to be a helpr for XDP but for other bpf like cls.
> >>>>> Yes.
> >>>>>
> >>>>>>>> Btw, is there a way for
> >>>>>>>> the XDP program to know whether the csum has been verified by th=
e
> >>>>>>>> device? ( I guess not).
> >>>>>>>>
> >>>>>>> Not. But we only do this (mark skb->ip_summed =3D CHECKSUM_UNNECE=
SSARY) for packets with VIRTIO_NET_HDR_F_DATA_VALID now.
> >>>>>> So if I understand you correctly, you meant for the XDP program th=
at
> >>>>>> wants to modify the packet:
> >>>>>>
> >>>>>> 1) check whether the checksum is valid
> >>>>>> 2) if yes, recalculate the checksum after the modification
> >>>>>> 3) if not, just do nothing for the checksum and the driver need to
> >>>>>> re-probe the csum_start/offset
> >>>>>>
> >>>>>> ?
> >>>>> I don't think we need to make many assumptions about the behavior o=
f XDP
> >>>>> programs.
> >>>>> Because we are out of control for various users using XDP.
> >>>> Exactly, but this patch seems to assume the XDP behaviour as you sai=
d previously
> >>>>
> >>> Let me sum it up:
> >>> When getting a skb from XDP_PASS, rx virtio-net will have the followi=
ng
> >>> scenarios:
> >>> 1. In a virtualized environment such as vm-vhost_user-vm, vhost-user =
or
> >>> some backends find that no physical link is required to reach the
> >>> destination, then they will save the cost of calculating the complete
> >>> checksum on the tx device side. That is, the device
> >>> directly sends the packet with the pseudo-header checksum, and the
> >>> rx side directly receives the packet with the pseudo-header checksum.
> >>> This is a problem we have to deal with, but other hardware
> >>> NICs don't have this problem (veth actually also has this problem,
> >>> which I mentioned in the proposal).
> >>>
> >>> 2. If the packet has passed through the physical link, it means
> >>> that the received packet has a complete checksum and not only a
> >>> pseudo-header checksum. At this time, virtio-net only needs to be
> >>> consistent with other NIC driver behaviors:
> >>>
> >>>    2.1 If the device has verified the checksum, mark
> >>>        skb->ip_summend=3DCHECKSUM_UNNECESSARY after XDP processing;
> >>>    2.2 If the device does not verify the checksum, after XDP processi=
ng,
> >>>        skb->ip_summend=3DCHECKSUM_NONE, the checksum is verified by t=
he stack.
> >> This doesn't answer my question, let me ask you differently.
> >>
> >> Let's take xdp_tx_iptunnel_kern.c as an example. With your patch, can
> >> it work when we receive a packet with partial csum? If not, it breaks
> > It works fine.
>
> Oh! Sorry for the noise, I misunderstood your scenario. The answer is
> that XDP_TX will cause packet loss in this scenario.
>
> For XDP_TX, flags in virtnet hdr are reset to 0, so if there is XDP on
> the rx side, the process of converting xdp_buff (if XDP_PASS)
> to skb will reset skb->csum_{start, offset} to 0. Therefore, the packets
> carrying partial csum sent out by XDP_TX will be lost
> (with or without this patch, the result is the same).

Without this patch, we won't receive a partial csum packet since
guest_csum is disabled.

> This situation is actually similar to XDP_PASS without this patch: all
> XDP_PASS packets carrying partial csum will also be dropped.
>
> Therefore, I think the XDP program is mainly designed for packets with
> complete checksums (XDP does not have a design for packets
> with partial csum, which brings about the problem that this patch is
> trying to solve). This test(xdp_tx_iptunnel_kern.c) causes no packet
> loss when the packet has a complete checksum.
>
> The XDP_TX situation is complicated when the checksum of the packet is
> partial csum.
> So the problem temporarily solved by this patch is: the packet loss
> problem when the checksum of the data packet is partial csum
> (flags in virtnethdr is marked as NEEDS_CSUM ) and XDP_PASS is converted
> to skb.

I'm not sure I get this, do you mean we fallback to xdp generic? Looks
like one way to go.

Thanks

>
> Thanks!
>
> >
> > When XDP (mean xdp_tx_iptunnel_kern.c) encapsulates the qualified
> > (by querying vip2tnl maps) packets into IPIP tunnel packets. And
> > it calculates the checksum for its new outer IP header (IP checksum
> > verification is always done by the stack, without unloading, see
> > ip_rcv_core()->ip_fast_csum())
> >       for (i =3D 0; i < sizeof(*iph) >> 1; i++)
> >            csum +=3D *next_iph_u16++;
> >        iph->check =3D ~((csum & 0xffff) + (csum >> 16));
> >
> > Finally, in the packet sent out by XDP_TX:
> > 1. flags in virtio_net_hdr is 0.
> > 2. The inner IP checksum (old_ip->check) in the original payload remain=
s unchanged.
> > 3. The checksum of the inner transport (udp/tcp->check) remains unchang=
ed.
> > 4. skb->ip_summed remains unchanged. Still CHECKSUM_PARTIAL.
> >
> > After the receiving side (with this patch) receives this IP tunnel pack=
et,
> > it finds that the flags of virtio_net_hdr is 0, and submits it to the
> > stack. Then the stack verifies that:
> > 1. the outer ip checksum is correct (the XDP program calculated the che=
cksum of the outer IP before).
> > 2. The inner IP is correct.
> > 3. udp/tcp is verified by skb_csum_unnecessary() and passed to continue
> > to pass.
> >
> > In fact, this patch does not affect the behavior of XDP_TX.
> >
> > Thanks!
> >
> >> existing applications.
> >>
> >> Thanks
> >>
> >>> Thanks.
> >>>
> >>>
> >>>> """
> >>>>>>>>> Packet with complete checksum (and has been verified by rx devi=
ce
> >>>>>>>>> because it has VIRTIO_NET_HDR_F_DATA_VALID)
> >>>>>>>>> when modified by XDP, XDP program should use the helper provide=
d by XDP
> >>>>>>>>> core to make the checksum correct,
> >>>> """
> >>>>
> >>>> ?
> >>>>
> >>>>> The core purpose of this patch is to:
> >>>>> #1 Solve the packet loss problem caused by loading XDP between vm-v=
m on
> >>>>> the same host (scenario with partial checksum).
> >>>> So we disabled guest_csum and the host (e.g TAP) will do checksum fo=
r
> >>>> us. Otherwise it should be a bug of the host.
> >>>>
> >>>> Thanks
> >>>>
> >>>>> #2 For scenarios other than #1, virtio-net with this patch is alrea=
dy
> >>>>> consistent with other existing NIC drivers (simple such as
> >>>>> ixgbe[1]/bnxt[2]/mvneta[3]/..):
> >>>>> the rx side only needs to have NETIF_F_RXCSUM and the device has
> >>>>> verified the packet has a valid checksum.
> >>>>> Then skb converted from xdp_buff (XDP returns XDP_PASS) can have
> >>>>> skb->ip_summed =3D CHECKSUM_UNNECESSARY.
> >>>>>
> >>>>> If the comment for DATA_VALID is confusing, I'll just remove it.
> >>>>>
> >>>>> [1] ixgbe_clean_rx_irq()-> ixgbe_run_xdp()-> ixgbe_process_skb_fiel=
ds()
> >>>>> ->ixgbe_rx_checksum()
> >>>>> [2] bnxt_xdp_build_skb()
> >>>>> [3] mvneta_swbm_build_skb
> >>>>>
> >>>>> Thanks.
> >>>>>
> >>>>>> Thanks
> >>>>>>
> >>>>>>> Thanks.
> >>>>>>>
> >>>>>>>> Thanks
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> otherwise, VIRTIO_NET_HDR_F_DATA_VALID has been cleared and skb
> >>>>>>>>> ->ip_summed=3DCHECKSUM_NONE, so the stack
> >>>>>>>>> will re-verify the checksum, causing packet loss due to wrong c=
hecksum.
> >>>>>>>>>
> >>>>>>>>> Thanks.
> >>>>>>>>>
> >>>>>>>>>> Thanks
> >>>>>>>>>>
> >>>>>>>>>>> +               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >>>>>>>>>>> +       }
> >>>>>>>>>>> +
> >>>>>>>>>>> +       return err;
> >>>>>>>>>>> +}
> >>>>>>>>>>> +
> >>>>>>>>>>>     static void receive_buf(struct virtnet_info *vi, struct r=
eceive_queue *rq,
> >>>>>>>>>>>                            void *buf, unsigned int len, void =
**ctx,
> >>>>>>>>>>>                            unsigned int *xdp_xmit,
> >>>>>>>>>>> @@ -1576,6 +1611,7 @@ static void receive_buf(struct virtnet_=
info *vi, struct receive_queue *rq,
> >>>>>>>>>>>            struct net_device *dev =3D vi->dev;
> >>>>>>>>>>>            struct sk_buff *skb;
> >>>>>>>>>>>            struct virtio_net_hdr_mrg_rxbuf *hdr;
> >>>>>>>>>>> +       __u8 flags;
> >>>>>>>>>>>
> >>>>>>>>>>>            if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >>>>>>>>>>>                    pr_debug("%s: short packet %i\n", dev->nam=
e, len);
> >>>>>>>>>>> @@ -1584,6 +1620,12 @@ static void receive_buf(struct virtnet=
_info *vi, struct receive_queue *rq,
> >>>>>>>>>>>                    return;
> >>>>>>>>>>>            }
> >>>>>>>>>>>
> >>>>>>>>>>> +       /* XDP may modify/overwrite the packet, including the=
 virtnet hdr,
> >>>>>>>>>>> +        * so save the flags of the virtnet hdr before XDP pr=
ocessing.
> >>>>>>>>>>> +        */
> >>>>>>>>>>> +       if (unlikely(vi->xdp_enabled))
> >>>>>>>>>>> +               flags =3D ((struct virtio_net_hdr_mrg_rxbuf *=
)buf)->hdr.flags;
> >>>>>>>>>>> +
> >>>>>>>>>>>            if (vi->mergeable_rx_bufs)
> >>>>>>>>>>>                    skb =3D receive_mergeable(dev, vi, rq, buf=
, ctx, len, xdp_xmit,
> >>>>>>>>>>>                                            stats);
> >>>>>>>>>>> @@ -1595,23 +1637,37 @@ static void receive_buf(struct virtne=
t_info *vi, struct receive_queue *rq,
> >>>>>>>>>>>            if (unlikely(!skb))
> >>>>>>>>>>>                    return;
> >>>>>>>>>>>
> >>>>>>>>>>> -       hdr =3D skb_vnet_hdr(skb);
> >>>>>>>>>>> -       if (dev->features & NETIF_F_RXHASH && vi->has_rss_has=
h_report)
> >>>>>>>>>>> -               virtio_skb_set_hash((const struct virtio_net_=
hdr_v1_hash *)hdr, skb);
> >>>>>>>>>>> -
> >>>>>>>>>>> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >>>>>>>>>>> -               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >>>>>>>>>>> +       if (unlikely(vi->xdp_enabled)) {
> >>>>>>>>>>> +               /* Required to do this before re-probing and =
calculating
> >>>>>>>>>>> +                * the pseudo-header checksum.
> >>>>>>>>>>> +                */
> >>>>>>>>>>> +               skb->protocol =3D eth_type_trans(skb, dev);
> >>>>>>>>>>> +               skb_reset_network_header(skb);
> >>>>>>>>>>> +               if (virtnet_set_csum_after_xdp(vi, skb, flags=
) < 0) {
> >>>>>>>>>>> +                       pr_debug("%s: errors occurred in sett=
ing partial csum",
> >>>>>>>>>>> +                                dev->name);
> >>>>>>>>>>> +                       goto frame_err;
> >>>>>>>>>>> +               }
> >>>>>>>>>>> +       } else {
> >>>>>>>>>>> +               hdr =3D skb_vnet_hdr(skb);
> >>>>>>>>>>> +               if (dev->features & NETIF_F_RXHASH && vi->has=
_rss_hash_report)
> >>>>>>>>>>> +                       virtio_skb_set_hash((const struct vir=
tio_net_hdr_v1_hash *)hdr, skb);
> >>>>>>>>>>> +
> >>>>>>>>>>> +               if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VA=
LID)
> >>>>>>>>>>> +                       skb->ip_summed =3D CHECKSUM_UNNECESSA=
RY;
> >>>>>>>>>>> +
> >>>>>>>>>>> +               if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> >>>>>>>>>>> +                                         virtio_is_little_en=
dian(vi->vdev))) {
> >>>>>>>>>>> +                       net_warn_ratelimited("%s: bad gso: ty=
pe: %u, size: %u\n",
> >>>>>>>>>>> +                                            dev->name, hdr->=
hdr.gso_type,
> >>>>>>>>>>> +                                            hdr->hdr.gso_siz=
e);
> >>>>>>>>>>> +                       goto frame_err;
> >>>>>>>>>>> +               }
> >>>>>>>>>>>
> >>>>>>>>>>> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> >>>>>>>>>>> -                                 virtio_is_little_endian(vi-=
>vdev))) {
> >>>>>>>>>>> -               net_warn_ratelimited("%s: bad gso: type: %u, =
size: %u\n",
> >>>>>>>>>>> -                                    dev->name, hdr->hdr.gso_=
type,
> >>>>>>>>>>> -                                    hdr->hdr.gso_size);
> >>>>>>>>>>> -               goto frame_err;
> >>>>>>>>>>> +               skb->protocol =3D eth_type_trans(skb, dev);
> >>>>>>>>>>>            }
> >>>>>>>>>>>
> >>>>>>>>>>>            skb_record_rx_queue(skb, vq2rxq(rq->vq));
> >>>>>>>>>>> -       skb->protocol =3D eth_type_trans(skb, dev);
> >>>>>>>>>>>            pr_debug("Receiving skb proto 0x%04x len %i type %=
i\n",
> >>>>>>>>>>>                     ntohs(skb->protocol), skb->len, skb->pkt_=
type);
> >>>>>>>>>>>
> >>>>>>>>>>> --
> >>>>>>>>>>> 2.19.1.6.gb485710b
> >>>>>>>>>>>
>


