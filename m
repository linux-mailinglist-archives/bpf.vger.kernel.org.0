Return-Path: <bpf+bounces-12391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F647CBBD2
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 09:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF921C20BB2
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 07:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE8E15AF9;
	Tue, 17 Oct 2023 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439AF156F9;
	Tue, 17 Oct 2023 07:00:17 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B494BAB;
	Tue, 17 Oct 2023 00:00:13 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuM1tfj_1697526008;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuM1tfj_1697526008)
          by smtp.aliyun-inc.com;
          Tue, 17 Oct 2023 15:00:09 +0800
Message-ID: <1697525013.7650406-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
Date: Tue, 17 Oct 2023 14:43:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
 <1697511725.2037013-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskfXDo+bnx5hbGU3JRwOgBRwOC-bYDdFYSmEO2jjgPnA@mail.gmail.com>
 <1697512950.0813534-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtppjoX_WAM+vjzkMKaMQQ0iZL=C_xS4RObuoLbm0udUw@mail.gmail.com>
 <CACGkMEvWAhH3uj2DEo=m7qWg3-pQjE-EtEBvTT8JXzqZ+RYEXQ@mail.gmail.com>
 <1697522771.0390663-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEu4tSHd4RVo0zEp1A6uM-6h42y+yAB2xzHTv8SzYdZPXQ@mail.gmail.com>
In-Reply-To: <CACGkMEu4tSHd4RVo0zEp1A6uM-6h42y+yAB2xzHTv8SzYdZPXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 17 Oct 2023 14:26:01 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Oct 17, 2023 at 2:17=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Tue, 17 Oct 2023 13:27:47 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Oct 17, 2023 at 11:28=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Tue, Oct 17, 2023 at 11:26=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > >
> > > > > On Tue, 17 Oct 2023 11:20:41 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Tue, Oct 17, 2023 at 11:11=E2=80=AFAM Xuan Zhuo <xuanzhuo@li=
nux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Tue, 17 Oct 2023 10:53:44 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Mon, Oct 16, 2023 at 8:00=E2=80=AFPM Xuan Zhuo <xuanzhuo=
@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > ## AF_XDP
> > > > > > > > >
> > > > > > > > > XDP socket(AF_XDP) is an excellent bypass kernel network =
framework. The zero
> > > > > > > > > copy feature of xsk (XDP socket) needs to be supported by=
 the driver. The
> > > > > > > > > performance of zero copy is very good. mlx5 and intel ixg=
be already support
> > > > > > > > > this feature, This patch set allows virtio-net to support=
 xsk's zerocopy xmit
> > > > > > > > > feature.
> > > > > > > > >
> > > > > > > > > At present, we have completed some preparation:
> > > > > > > > >
> > > > > > > > > 1. vq-reset (virtio spec and kernel code)
> > > > > > > > > 2. virtio-core premapped dma
> > > > > > > > > 3. virtio-net xdp refactor
> > > > > > > > >
> > > > > > > > > So it is time for Virtio-Net to complete the support for =
the XDP Socket
> > > > > > > > > Zerocopy.
> > > > > > > > >
> > > > > > > > > Virtio-net can not increase the queue num at will, so xsk=
 shares the queue with
> > > > > > > > > kernel.
> > > > > > > > >
> > > > > > > > > On the other hand, Virtio-Net does not support generate i=
nterrupt from driver
> > > > > > > > > manually, so when we wakeup tx xmit, we used some tips. I=
f the CPU run by TX
> > > > > > > > > NAPI last time is other CPUs, use IPI to wake up NAPI on =
the remote CPU. If it
> > > > > > > > > is also the local CPU, then we wake up napi directly.
> > > > > > > > >
> > > > > > > > > This patch set includes some refactor to the virtio-net t=
o let that to support
> > > > > > > > > AF_XDP.
> > > > > > > > >
> > > > > > > > > ## performance
> > > > > > > > >
> > > > > > > > > ENV: Qemu with vhost-user(polling mode).
> > > > > > > > >
> > > > > > > > > Sockperf: https://github.com/Mellanox/sockperf
> > > > > > > > > I use this tool to send udp packet by kernel syscall.
> > > > > > > > >
> > > > > > > > > xmit command: sockperf tp -i 10.0.3.1 -t 1000
> > > > > > > > >
> > > > > > > > > I write a tool that sends udp packets or recvs udp packet=
s by AF_XDP.
> > > > > > > > >
> > > > > > > > >                   | Guest APP CPU |Guest Softirq CPU | UD=
P PPS
> > > > > > > > > ------------------|---------------|------------------|---=
---------
> > > > > > > > > xmit by syscall   |   100%        |                  |   =
676,915
> > > > > > > > > xmit by xsk       |   59.1%       |   100%           | 5,=
447,168
> > > > > > > > > recv by syscall   |   60%         |   100%           |   =
932,288
> > > > > > > > > recv by xsk       |   35.7%       |   100%           | 3,=
343,168
> > > > > > > >
> > > > > > > > Any chance we can get a testpmd result (which I guess shoul=
d be better
> > > > > > > > than PPS above)?
> > > > > > >
> > > > > > > Do you mean testpmd + DPDK + AF_XDP?
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > >
> > > > > > > Yes. This is probably better because my tool does more work. =
That is not a
> > > > > > > complete testing tool used by our business.
> > > > > >
> > > > > > Probably, but it would be appealing for others. Especially cons=
idering
> > > > > > DPDK supports AF_XDP PMD now.
> > > > >
> > > > > OK.
> > > > >
> > > > > Let me try.
> > > > >
> > > > > But could you start to review firstly?
> > > >
> > > > Yes, it's in my todo list.
> > >
> > > Speaking too fast, I think if it doesn't take too long time, I would
> > > wait for the result first as netdim series. One reason is that I
> > > remember claims to be only 10% to 20% loss comparing to wire speed, so
> > > I'd expect it should be much faster. I vaguely remember, even a vhost
> > > can gives us more than 3M PPS if we disable SMAP, so the numbers here
> > > are not as impressive as expected.
> >
> >
> > What is SMAP? Cloud you give me more info?
>
> Supervisor Mode Access Prevention
>
> Vhost suffers from this.
>
> >
> > So if we think the 3M as the wire speed, you expect the result
> > can reach 2.8M pps/core, right?
>
> It's AF_XDP that claims to be 80% if my memory is correct. So a
> correct AF_XDP implementation should not sit behind this too much.
>
> > Now the recv result is 2.5M(2463646) pps/core.
> > Do you think there is a huge gap?
>
> You never describe your testing environment in details. For example,
> is this a virtual environment? What's the CPU model and frequency etc.
>
> Because I never see a NIC whose wire speed is 3M.
>
> >
> > My tool makes udp packet and lookup route, so it take more much cpu.
>
> That's why I suggest you to test raw PPS.

OK. Let's align some info.

1. My test env is vhost-user. Qemu + vhost-user(polling mode).
   I do not use the DPDK, because that there is some trouble for me.
   I use the VAPP (https://github.com/fengidri/vapp) as the vhost-user devi=
ce.
   That has two threads all are busy mode for tx and rx.
   tx thread consumes the tx ring and drop the packet.
   rx thread put the packet to the rx ring.

2. My Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz

3. From this http://fast.dpdk.org/doc/perf/DPDK_23_03_Intel_virtio_performa=
nce_report.pdf
   I think we can align that the vhost max speed is 8.5 MPPS.
   Is that ok?
   And the expected AF_XDP pps is about 6 MPPS.

4. About the raw PPS, I agree that. I will test with testpmd.


Thanks.


>
> Thanks
>
> >
> > I am confused.
> >
> >
> > What is SMAP? Could you give me more information?
> >
> > So if we use 3M as the wire speed, you would expect the result to be 2.=
8M
> > pps/core, right?
> >
> > Now the recv result is 2.5M (2463646 =3D 3,343,168/1.357) pps/core. Do =
you think
> > the difference is big?
> >
> > My tool makes udp packets and looks up routes, so it requires more CPU.
> >
> > I'm confused. Is there something I misunderstood?
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > What I noticed is that the hotspot is the driver writing virt=
io desc. Because
> > > > > > > the device is in busy mode. So there is race between driver a=
nd device.
> > > > > > > So I modified the virtio core and lazily updated avail idx. T=
hen pps can reach
> > > > > > > 10,000,000.
> > > > > >
> > > > > > Care to post a draft for this?
> > > > >
> > > > > YES, I is thinking for this.
> > > > > But maybe that is just work for split. The packed mode has some t=
roubles.
> > > >
> > > > Ok.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > > ## maintain
> > > > > > > > >
> > > > > > > > > I am currently a reviewer for virtio-net. I commit to mai=
ntain AF_XDP support in
> > > > > > > > > virtio-net.
> > > > > > > > >
> > > > > > > > > Please review.
> > > > > > > > >
> > > > > > > > > Thanks.
> > > > > > > > >
> > > > > > > > > v1:
> > > > > > > > >     1. remove two virtio commits. Push this patchset to n=
et-next
> > > > > > > > >     2. squash "virtio_net: virtnet_poll_tx support resche=
duled" to xsk: support tx
> > > > > > > > >     3. fix some warnings
> > > > > > > > >
> > > > > > > > > Xuan Zhuo (19):
> > > > > > > > >   virtio_net: rename free_old_xmit_skbs to free_old_xmit
> > > > > > > > >   virtio_net: unify the code for recycling the xmit ptr
> > > > > > > > >   virtio_net: independent directory
> > > > > > > > >   virtio_net: move to virtio_net.h
> > > > > > > > >   virtio_net: add prefix virtnet to all struct/api inside=
 virtio_net.h
> > > > > > > > >   virtio_net: separate virtnet_rx_resize()
> > > > > > > > >   virtio_net: separate virtnet_tx_resize()
> > > > > > > > >   virtio_net: sq support premapped mode
> > > > > > > > >   virtio_net: xsk: bind/unbind xsk
> > > > > > > > >   virtio_net: xsk: prevent disable tx napi
> > > > > > > > >   virtio_net: xsk: tx: support tx
> > > > > > > > >   virtio_net: xsk: tx: support wakeup
> > > > > > > > >   virtio_net: xsk: tx: virtnet_free_old_xmit() distinguis=
hes xsk buffer
> > > > > > > > >   virtio_net: xsk: tx: virtnet_sq_free_unused_buf() check=
 xsk buffer
> > > > > > > > >   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
> > > > > > > > >   virtio_net: xsk: rx: introduce receive_xsk() to recv xs=
k buffer
> > > > > > > > >   virtio_net: xsk: rx: virtnet_rq_free_unused_buf() check=
 xsk buffer
> > > > > > > > >   virtio_net: update tx timeout record
> > > > > > > > >   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
> > > > > > > > >
> > > > > > > > >  MAINTAINERS                                 |   2 +-
> > > > > > > > >  drivers/net/Kconfig                         |   8 +-
> > > > > > > > >  drivers/net/Makefile                        |   2 +-
> > > > > > > > >  drivers/net/virtio/Kconfig                  |  13 +
> > > > > > > > >  drivers/net/virtio/Makefile                 |   8 +
> > > > > > > > >  drivers/net/{virtio_net.c =3D> virtio/main.c} | 652 ++++=
+++++-----------
> > > > > > > > >  drivers/net/virtio/virtio_net.h             | 359 ++++++=
+++++
> > > > > > > > >  drivers/net/virtio/xsk.c                    | 545 ++++++=
++++++++++
> > > > > > > > >  drivers/net/virtio/xsk.h                    |  32 +
> > > > > > > > >  9 files changed, 1247 insertions(+), 374 deletions(-)
> > > > > > > > >  create mode 100644 drivers/net/virtio/Kconfig
> > > > > > > > >  create mode 100644 drivers/net/virtio/Makefile
> > > > > > > > >  rename drivers/net/{virtio_net.c =3D> virtio/main.c} (91=
%)
> > > > > > > > >  create mode 100644 drivers/net/virtio/virtio_net.h
> > > > > > > > >  create mode 100644 drivers/net/virtio/xsk.c
> > > > > > > > >  create mode 100644 drivers/net/virtio/xsk.h
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.32.0.3.g01195cf9f
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > >
> >
>

