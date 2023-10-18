Return-Path: <bpf+bounces-12493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95AE7CD195
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 03:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088E81C209AC
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 01:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF76D15BF;
	Wed, 18 Oct 2023 01:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3Sjo+lJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8A15A2
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 01:02:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D5998
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 18:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697590964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=708yCv54P4JVoCiQ6JH8cSx49ZwY8SdV/TaMd4E7cYs=;
	b=P3Sjo+lJoGGOojyu1lN4FJdpjBXkEhMBmaC+hzlOeNHVOz2D1fJ0x431o+15rjK5UyDxHW
	LlifJl8hnN1hCtbPmLJpTsUQ2iO04MxXcpYQmAXmCCbXB46X/vnv4K9fZbGnnOrQLe5+fx
	QaSLi7tSZyLYVdf/kzT9+gyRvYcBINU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-WpdDL8TyNJ6IDDPxQgS5Mg-1; Tue, 17 Oct 2023 21:02:32 -0400
X-MC-Unique: WpdDL8TyNJ6IDDPxQgS5Mg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507b0270b7fso2948231e87.3
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 18:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697590951; x=1698195751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=708yCv54P4JVoCiQ6JH8cSx49ZwY8SdV/TaMd4E7cYs=;
        b=Q0cwAoUuUT9Khm81pjQFQv7+EOCnkb8+P2DgPM36KWj0mEjLsOOy9YwdbAfjKbOkiu
         IoCPACgB5V72kMbpGYU59cr5ysuii/u15b21jl/fWa5Zq7OTb5bOyF0WnL1V612PmrKH
         hy1UyBY/ykHNJyGZG3jHcfewBXAeTtQ1wRgLYZkwPwPBTlWia95nariebYfuyY9s0r3W
         guL8V3xNaZA9K+CK0HdukMd0xLPIA/HYQfA/r4bCCiN07U6BTjHwMNnsBLPMGcd9ZYEg
         0oxWKoFbQzI+M11J1E2wbh5lHDXuysotTSvSK9VovTNv4F21Fo0Xz+VpyMQqJIxsoE+j
         qUJA==
X-Gm-Message-State: AOJu0Yz53W+24lQdo8KExaFx4ZWnGo2oKHheY6EPU+eTWDfs0Q2Opz82
	5WymJpY15Rvs8gze59A5+aZ+XOfkdZTlnNNW/HGxdvu+8QvscGKEvF7FKZ8JIDoVQNKp9ANkkCh
	sXXo4yg8aw6/A1UPzBrfgMuqKE4SB
X-Received: by 2002:ac2:4a82:0:b0:4f3:9136:9cd0 with SMTP id l2-20020ac24a82000000b004f391369cd0mr3051541lfp.44.1697590951277;
        Tue, 17 Oct 2023 18:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO/0ZMWi3AR3AtyvO2i9CNQlIt3P4oJVby8gdM1h61xPGgGF6aNEsia2aJ7+8Rv/FxVufGvZ1ClVSop6SbMCI=
X-Received: by 2002:ac2:4a82:0:b0:4f3:9136:9cd0 with SMTP id
 l2-20020ac24a82000000b004f391369cd0mr3051527lfp.44.1697590950887; Tue, 17 Oct
 2023 18:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
 <1697511725.2037013-1-xuanzhuo@linux.alibaba.com> <CACGkMEskfXDo+bnx5hbGU3JRwOgBRwOC-bYDdFYSmEO2jjgPnA@mail.gmail.com>
 <1697512950.0813534-1-xuanzhuo@linux.alibaba.com> <CACGkMEtppjoX_WAM+vjzkMKaMQQ0iZL=C_xS4RObuoLbm0udUw@mail.gmail.com>
 <CACGkMEvWAhH3uj2DEo=m7qWg3-pQjE-EtEBvTT8JXzqZ+RYEXQ@mail.gmail.com>
 <1697522771.0390663-2-xuanzhuo@linux.alibaba.com> <CACGkMEu4tSHd4RVo0zEp1A6uM-6h42y+yAB2xzHTv8SzYdZPXQ@mail.gmail.com>
 <1697525013.7650406-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1697525013.7650406-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Oct 2023 09:02:19 +0800
Message-ID: <CACGkMEs2Z1Cc7dV8cO9NsQn-FH=yKkggPHerS_hKoaC0-_iyUw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 3:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 17 Oct 2023 14:26:01 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Oct 17, 2023 at 2:17=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Tue, 17 Oct 2023 13:27:47 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Oct 17, 2023 at 11:28=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > >
> > > > > On Tue, Oct 17, 2023 at 11:26=E2=80=AFAM Xuan Zhuo <xuanzhuo@linu=
x.alibaba.com> wrote:
> > > > > >
> > > > > > On Tue, 17 Oct 2023 11:20:41 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Tue, Oct 17, 2023 at 11:11=E2=80=AFAM Xuan Zhuo <xuanzhuo@=
linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, 17 Oct 2023 10:53:44 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Mon, Oct 16, 2023 at 8:00=E2=80=AFPM Xuan Zhuo <xuanzh=
uo@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > ## AF_XDP
> > > > > > > > > >
> > > > > > > > > > XDP socket(AF_XDP) is an excellent bypass kernel networ=
k framework. The zero
> > > > > > > > > > copy feature of xsk (XDP socket) needs to be supported =
by the driver. The
> > > > > > > > > > performance of zero copy is very good. mlx5 and intel i=
xgbe already support
> > > > > > > > > > this feature, This patch set allows virtio-net to suppo=
rt xsk's zerocopy xmit
> > > > > > > > > > feature.
> > > > > > > > > >
> > > > > > > > > > At present, we have completed some preparation:
> > > > > > > > > >
> > > > > > > > > > 1. vq-reset (virtio spec and kernel code)
> > > > > > > > > > 2. virtio-core premapped dma
> > > > > > > > > > 3. virtio-net xdp refactor
> > > > > > > > > >
> > > > > > > > > > So it is time for Virtio-Net to complete the support fo=
r the XDP Socket
> > > > > > > > > > Zerocopy.
> > > > > > > > > >
> > > > > > > > > > Virtio-net can not increase the queue num at will, so x=
sk shares the queue with
> > > > > > > > > > kernel.
> > > > > > > > > >
> > > > > > > > > > On the other hand, Virtio-Net does not support generate=
 interrupt from driver
> > > > > > > > > > manually, so when we wakeup tx xmit, we used some tips.=
 If the CPU run by TX
> > > > > > > > > > NAPI last time is other CPUs, use IPI to wake up NAPI o=
n the remote CPU. If it
> > > > > > > > > > is also the local CPU, then we wake up napi directly.
> > > > > > > > > >
> > > > > > > > > > This patch set includes some refactor to the virtio-net=
 to let that to support
> > > > > > > > > > AF_XDP.
> > > > > > > > > >
> > > > > > > > > > ## performance
> > > > > > > > > >
> > > > > > > > > > ENV: Qemu with vhost-user(polling mode).
> > > > > > > > > >
> > > > > > > > > > Sockperf: https://github.com/Mellanox/sockperf
> > > > > > > > > > I use this tool to send udp packet by kernel syscall.
> > > > > > > > > >
> > > > > > > > > > xmit command: sockperf tp -i 10.0.3.1 -t 1000
> > > > > > > > > >
> > > > > > > > > > I write a tool that sends udp packets or recvs udp pack=
ets by AF_XDP.
> > > > > > > > > >
> > > > > > > > > >                   | Guest APP CPU |Guest Softirq CPU | =
UDP PPS
> > > > > > > > > > ------------------|---------------|------------------|-=
-----------
> > > > > > > > > > xmit by syscall   |   100%        |                  | =
  676,915
> > > > > > > > > > xmit by xsk       |   59.1%       |   100%           | =
5,447,168
> > > > > > > > > > recv by syscall   |   60%         |   100%           | =
  932,288
> > > > > > > > > > recv by xsk       |   35.7%       |   100%           | =
3,343,168
> > > > > > > > >
> > > > > > > > > Any chance we can get a testpmd result (which I guess sho=
uld be better
> > > > > > > > > than PPS above)?
> > > > > > > >
> > > > > > > > Do you mean testpmd + DPDK + AF_XDP?
> > > > > > >
> > > > > > > Yes.
> > > > > > >
> > > > > > > >
> > > > > > > > Yes. This is probably better because my tool does more work=
. That is not a
> > > > > > > > complete testing tool used by our business.
> > > > > > >
> > > > > > > Probably, but it would be appealing for others. Especially co=
nsidering
> > > > > > > DPDK supports AF_XDP PMD now.
> > > > > >
> > > > > > OK.
> > > > > >
> > > > > > Let me try.
> > > > > >
> > > > > > But could you start to review firstly?
> > > > >
> > > > > Yes, it's in my todo list.
> > > >
> > > > Speaking too fast, I think if it doesn't take too long time, I woul=
d
> > > > wait for the result first as netdim series. One reason is that I
> > > > remember claims to be only 10% to 20% loss comparing to wire speed,=
 so
> > > > I'd expect it should be much faster. I vaguely remember, even a vho=
st
> > > > can gives us more than 3M PPS if we disable SMAP, so the numbers he=
re
> > > > are not as impressive as expected.
> > >
> > >
> > > What is SMAP? Cloud you give me more info?
> >
> > Supervisor Mode Access Prevention
> >
> > Vhost suffers from this.
> >
> > >
> > > So if we think the 3M as the wire speed, you expect the result
> > > can reach 2.8M pps/core, right?
> >
> > It's AF_XDP that claims to be 80% if my memory is correct. So a
> > correct AF_XDP implementation should not sit behind this too much.
> >
> > > Now the recv result is 2.5M(2463646) pps/core.
> > > Do you think there is a huge gap?
> >
> > You never describe your testing environment in details. For example,
> > is this a virtual environment? What's the CPU model and frequency etc.
> >
> > Because I never see a NIC whose wire speed is 3M.
> >
> > >
> > > My tool makes udp packet and lookup route, so it take more much cpu.
> >
> > That's why I suggest you to test raw PPS.
>
> OK. Let's align some info.
>
> 1. My test env is vhost-user. Qemu + vhost-user(polling mode).
>    I do not use the DPDK, because that there is some trouble for me.
>    I use the VAPP (https://github.com/fengidri/vapp) as the vhost-user de=
vice.
>    That has two threads all are busy mode for tx and rx.
>    tx thread consumes the tx ring and drop the packet.
>    rx thread put the packet to the rx ring.
>
> 2. My Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
>
> 3. From this http://fast.dpdk.org/doc/perf/DPDK_23_03_Intel_virtio_perfor=
mance_report.pdf
>    I think we can align that the vhost max speed is 8.5 MPPS.
>    Is that ok?

Let's have an apple to apple comparison.

Firstly, I would test AF_XDP on virtio-net hardware which I guess you
should have some. Then we don't need any test as baseline but the wire
speed.

Secondly, if it can't be done, let's do something much more simple:

1) Boot Qemu with vhost-user and wire it to testpmd
2) Testing
2.1) virtio PMD in guest with testpmd
2.2) AF_XDP PMD in guest with testpmd

Then let's compare.

Thanks


>    And the expected AF_XDP pps is about 6 MPPS.
>
> 4. About the raw PPS, I agree that. I will test with testpmd.
>
>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > I am confused.
> > >
> > >
> > > What is SMAP? Could you give me more information?
> > >
> > > So if we use 3M as the wire speed, you would expect the result to be =
2.8M
> > > pps/core, right?
> > >
> > > Now the recv result is 2.5M (2463646 =3D 3,343,168/1.357) pps/core. D=
o you think
> > > the difference is big?
> > >
> > > My tool makes udp packets and looks up routes, so it requires more CP=
U.
> > >
> > > I'm confused. Is there something I misunderstood?
> > >
> > > Thanks.
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > What I noticed is that the hotspot is the driver writing vi=
rtio desc. Because
> > > > > > > > the device is in busy mode. So there is race between driver=
 and device.
> > > > > > > > So I modified the virtio core and lazily updated avail idx.=
 Then pps can reach
> > > > > > > > 10,000,000.
> > > > > > >
> > > > > > > Care to post a draft for this?
> > > > > >
> > > > > > YES, I is thinking for this.
> > > > > > But maybe that is just work for split. The packed mode has some=
 troubles.
> > > > >
> > > > > Ok.
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > ## maintain
> > > > > > > > > >
> > > > > > > > > > I am currently a reviewer for virtio-net. I commit to m=
aintain AF_XDP support in
> > > > > > > > > > virtio-net.
> > > > > > > > > >
> > > > > > > > > > Please review.
> > > > > > > > > >
> > > > > > > > > > Thanks.
> > > > > > > > > >
> > > > > > > > > > v1:
> > > > > > > > > >     1. remove two virtio commits. Push this patchset to=
 net-next
> > > > > > > > > >     2. squash "virtio_net: virtnet_poll_tx support resc=
heduled" to xsk: support tx
> > > > > > > > > >     3. fix some warnings
> > > > > > > > > >
> > > > > > > > > > Xuan Zhuo (19):
> > > > > > > > > >   virtio_net: rename free_old_xmit_skbs to free_old_xmi=
t
> > > > > > > > > >   virtio_net: unify the code for recycling the xmit ptr
> > > > > > > > > >   virtio_net: independent directory
> > > > > > > > > >   virtio_net: move to virtio_net.h
> > > > > > > > > >   virtio_net: add prefix virtnet to all struct/api insi=
de virtio_net.h
> > > > > > > > > >   virtio_net: separate virtnet_rx_resize()
> > > > > > > > > >   virtio_net: separate virtnet_tx_resize()
> > > > > > > > > >   virtio_net: sq support premapped mode
> > > > > > > > > >   virtio_net: xsk: bind/unbind xsk
> > > > > > > > > >   virtio_net: xsk: prevent disable tx napi
> > > > > > > > > >   virtio_net: xsk: tx: support tx
> > > > > > > > > >   virtio_net: xsk: tx: support wakeup
> > > > > > > > > >   virtio_net: xsk: tx: virtnet_free_old_xmit() distingu=
ishes xsk buffer
> > > > > > > > > >   virtio_net: xsk: tx: virtnet_sq_free_unused_buf() che=
ck xsk buffer
> > > > > > > > > >   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
> > > > > > > > > >   virtio_net: xsk: rx: introduce receive_xsk() to recv =
xsk buffer
> > > > > > > > > >   virtio_net: xsk: rx: virtnet_rq_free_unused_buf() che=
ck xsk buffer
> > > > > > > > > >   virtio_net: update tx timeout record
> > > > > > > > > >   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROC=
OPY
> > > > > > > > > >
> > > > > > > > > >  MAINTAINERS                                 |   2 +-
> > > > > > > > > >  drivers/net/Kconfig                         |   8 +-
> > > > > > > > > >  drivers/net/Makefile                        |   2 +-
> > > > > > > > > >  drivers/net/virtio/Kconfig                  |  13 +
> > > > > > > > > >  drivers/net/virtio/Makefile                 |   8 +
> > > > > > > > > >  drivers/net/{virtio_net.c =3D> virtio/main.c} | 652 ++=
+++++++-----------
> > > > > > > > > >  drivers/net/virtio/virtio_net.h             | 359 ++++=
+++++++
> > > > > > > > > >  drivers/net/virtio/xsk.c                    | 545 ++++=
++++++++++++
> > > > > > > > > >  drivers/net/virtio/xsk.h                    |  32 +
> > > > > > > > > >  9 files changed, 1247 insertions(+), 374 deletions(-)
> > > > > > > > > >  create mode 100644 drivers/net/virtio/Kconfig
> > > > > > > > > >  create mode 100644 drivers/net/virtio/Makefile
> > > > > > > > > >  rename drivers/net/{virtio_net.c =3D> virtio/main.c} (=
91%)
> > > > > > > > > >  create mode 100644 drivers/net/virtio/virtio_net.h
> > > > > > > > > >  create mode 100644 drivers/net/virtio/xsk.c
> > > > > > > > > >  create mode 100644 drivers/net/virtio/xsk.h
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.32.0.3.g01195cf9f
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > >
> > >
> >
>


