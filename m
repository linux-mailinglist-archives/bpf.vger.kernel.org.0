Return-Path: <bpf+bounces-12388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB397CBB1D
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 08:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8798B2107E
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 06:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE7E11C8C;
	Tue, 17 Oct 2023 06:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyEWzQfH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9B1172F
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 06:26:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8128F
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 23:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697523991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcaG2z5+seD02JuJsqXV0toO2m3nASDln19wJdTBNSA=;
	b=IyEWzQfHfcZ3whLikydnGgn5QeNPF6xsizr/DQjJKszfel83AqffKpxG8o5IifKuOYGdQT
	8J7nOcMNphipaUIosA323xAVAIQqFpxzEBo7+XK4zhsDt7905fsbmQsViRuBHbO4NUa8+y
	i0iWOA5WeUH6MG0O9ueEBdCVcxKUKv4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-Jj7GVLKZM9qLl536Tgdw3Q-1; Tue, 17 Oct 2023 02:26:14 -0400
X-MC-Unique: Jj7GVLKZM9qLl536Tgdw3Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5079641031aso4532045e87.1
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 23:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697523973; x=1698128773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcaG2z5+seD02JuJsqXV0toO2m3nASDln19wJdTBNSA=;
        b=fQIxNxWTOol0CSseHok1gaOd2XNWT2YsLxip/+nwhixb4p85R5VyQRbyHj7KFrPqKx
         9u7PbrG8gR2/SsMUeyqw4iWUHeWflgexqTkMiElwMB9uAsr2aqdKKIu/OmcHyftiMsmQ
         Ldp8k88vxZnHhUNvKwZ75Zk51jnbyKyD5kMjuix2GXwijQU2KXZh980X133hwd3Bayni
         FR0vOImKXNjk+iQWdnvaKY5/mCwVjvApcTIiQrdAF9t/b5GccOKXVHm/c/dih++aZJ79
         PXct3+wsu2jOWzXI6N/3x44a0ziYAoufhEfrsk+LL5cbFSoBPHD60FB2JYsfNt9ZUON1
         /3GA==
X-Gm-Message-State: AOJu0YzWOnVVhuc6siuIYOUgxCQcIXYDsDXIr1qJ07juFm1YlXsN4Jt8
	CVlxtwPCh5f8spofCcZcxfiDWdL6XrQP13DBpE/aycDCvHN/FehzJGEPvq/RZTsD4NJD4UpcAW2
	uhAoqFAm6JsDZtxh1OOY+YrlN2clq
X-Received: by 2002:a05:6512:3136:b0:4fd:c715:5667 with SMTP id p22-20020a056512313600b004fdc7155667mr868627lfd.20.1697523973056;
        Mon, 16 Oct 2023 23:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSUPTSuD1Jm/V+aUhJ3uWkN9SjF1Cht6y1EuRCE2wfX219UUhHhdkSeSqL7RFBkaej7beIxS8ohJcnqrYRbkI=
X-Received: by 2002:a05:6512:3136:b0:4fd:c715:5667 with SMTP id
 p22-20020a056512313600b004fdc7155667mr868609lfd.20.1697523972644; Mon, 16 Oct
 2023 23:26:12 -0700 (PDT)
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
 <CACGkMEvWAhH3uj2DEo=m7qWg3-pQjE-EtEBvTT8JXzqZ+RYEXQ@mail.gmail.com> <1697522771.0390663-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1697522771.0390663-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Oct 2023 14:26:01 +0800
Message-ID: <CACGkMEu4tSHd4RVo0zEp1A6uM-6h42y+yAB2xzHTv8SzYdZPXQ@mail.gmail.com>
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

On Tue, Oct 17, 2023 at 2:17=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 17 Oct 2023 13:27:47 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Oct 17, 2023 at 11:28=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Tue, Oct 17, 2023 at 11:26=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > On Tue, 17 Oct 2023 11:20:41 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Tue, Oct 17, 2023 at 11:11=E2=80=AFAM Xuan Zhuo <xuanzhuo@linu=
x.alibaba.com> wrote:
> > > > > >
> > > > > > On Tue, 17 Oct 2023 10:53:44 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Mon, Oct 16, 2023 at 8:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > ## AF_XDP
> > > > > > > >
> > > > > > > > XDP socket(AF_XDP) is an excellent bypass kernel network fr=
amework. The zero
> > > > > > > > copy feature of xsk (XDP socket) needs to be supported by t=
he driver. The
> > > > > > > > performance of zero copy is very good. mlx5 and intel ixgbe=
 already support
> > > > > > > > this feature, This patch set allows virtio-net to support x=
sk's zerocopy xmit
> > > > > > > > feature.
> > > > > > > >
> > > > > > > > At present, we have completed some preparation:
> > > > > > > >
> > > > > > > > 1. vq-reset (virtio spec and kernel code)
> > > > > > > > 2. virtio-core premapped dma
> > > > > > > > 3. virtio-net xdp refactor
> > > > > > > >
> > > > > > > > So it is time for Virtio-Net to complete the support for th=
e XDP Socket
> > > > > > > > Zerocopy.
> > > > > > > >
> > > > > > > > Virtio-net can not increase the queue num at will, so xsk s=
hares the queue with
> > > > > > > > kernel.
> > > > > > > >
> > > > > > > > On the other hand, Virtio-Net does not support generate int=
errupt from driver
> > > > > > > > manually, so when we wakeup tx xmit, we used some tips. If =
the CPU run by TX
> > > > > > > > NAPI last time is other CPUs, use IPI to wake up NAPI on th=
e remote CPU. If it
> > > > > > > > is also the local CPU, then we wake up napi directly.
> > > > > > > >
> > > > > > > > This patch set includes some refactor to the virtio-net to =
let that to support
> > > > > > > > AF_XDP.
> > > > > > > >
> > > > > > > > ## performance
> > > > > > > >
> > > > > > > > ENV: Qemu with vhost-user(polling mode).
> > > > > > > >
> > > > > > > > Sockperf: https://github.com/Mellanox/sockperf
> > > > > > > > I use this tool to send udp packet by kernel syscall.
> > > > > > > >
> > > > > > > > xmit command: sockperf tp -i 10.0.3.1 -t 1000
> > > > > > > >
> > > > > > > > I write a tool that sends udp packets or recvs udp packets =
by AF_XDP.
> > > > > > > >
> > > > > > > >                   | Guest APP CPU |Guest Softirq CPU | UDP =
PPS
> > > > > > > > ------------------|---------------|------------------|-----=
-------
> > > > > > > > xmit by syscall   |   100%        |                  |   67=
6,915
> > > > > > > > xmit by xsk       |   59.1%       |   100%           | 5,44=
7,168
> > > > > > > > recv by syscall   |   60%         |   100%           |   93=
2,288
> > > > > > > > recv by xsk       |   35.7%       |   100%           | 3,34=
3,168
> > > > > > >
> > > > > > > Any chance we can get a testpmd result (which I guess should =
be better
> > > > > > > than PPS above)?
> > > > > >
> > > > > > Do you mean testpmd + DPDK + AF_XDP?
> > > > >
> > > > > Yes.
> > > > >
> > > > > >
> > > > > > Yes. This is probably better because my tool does more work. Th=
at is not a
> > > > > > complete testing tool used by our business.
> > > > >
> > > > > Probably, but it would be appealing for others. Especially consid=
ering
> > > > > DPDK supports AF_XDP PMD now.
> > > >
> > > > OK.
> > > >
> > > > Let me try.
> > > >
> > > > But could you start to review firstly?
> > >
> > > Yes, it's in my todo list.
> >
> > Speaking too fast, I think if it doesn't take too long time, I would
> > wait for the result first as netdim series. One reason is that I
> > remember claims to be only 10% to 20% loss comparing to wire speed, so
> > I'd expect it should be much faster. I vaguely remember, even a vhost
> > can gives us more than 3M PPS if we disable SMAP, so the numbers here
> > are not as impressive as expected.
>
>
> What is SMAP? Cloud you give me more info?

Supervisor Mode Access Prevention

Vhost suffers from this.

>
> So if we think the 3M as the wire speed, you expect the result
> can reach 2.8M pps/core, right?

It's AF_XDP that claims to be 80% if my memory is correct. So a
correct AF_XDP implementation should not sit behind this too much.

> Now the recv result is 2.5M(2463646) pps/core.
> Do you think there is a huge gap?

You never describe your testing environment in details. For example,
is this a virtual environment? What's the CPU model and frequency etc.

Because I never see a NIC whose wire speed is 3M.

>
> My tool makes udp packet and lookup route, so it take more much cpu.

That's why I suggest you to test raw PPS.

Thanks

>
> I am confused.
>
>
> What is SMAP? Could you give me more information?
>
> So if we use 3M as the wire speed, you would expect the result to be 2.8M
> pps/core, right?
>
> Now the recv result is 2.5M (2463646 =3D 3,343,168/1.357) pps/core. Do yo=
u think
> the difference is big?
>
> My tool makes udp packets and looks up routes, so it requires more CPU.
>
> I'm confused. Is there something I misunderstood?
>
> Thanks.
>
> >
> > Thanks
> >
> > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > What I noticed is that the hotspot is the driver writing virtio=
 desc. Because
> > > > > > the device is in busy mode. So there is race between driver and=
 device.
> > > > > > So I modified the virtio core and lazily updated avail idx. The=
n pps can reach
> > > > > > 10,000,000.
> > > > >
> > > > > Care to post a draft for this?
> > > >
> > > > YES, I is thinking for this.
> > > > But maybe that is just work for split. The packed mode has some tro=
ubles.
> > >
> > > Ok.
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
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
> > > > > > > > ## maintain
> > > > > > > >
> > > > > > > > I am currently a reviewer for virtio-net. I commit to maint=
ain AF_XDP support in
> > > > > > > > virtio-net.
> > > > > > > >
> > > > > > > > Please review.
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > > v1:
> > > > > > > >     1. remove two virtio commits. Push this patchset to net=
-next
> > > > > > > >     2. squash "virtio_net: virtnet_poll_tx support reschedu=
led" to xsk: support tx
> > > > > > > >     3. fix some warnings
> > > > > > > >
> > > > > > > > Xuan Zhuo (19):
> > > > > > > >   virtio_net: rename free_old_xmit_skbs to free_old_xmit
> > > > > > > >   virtio_net: unify the code for recycling the xmit ptr
> > > > > > > >   virtio_net: independent directory
> > > > > > > >   virtio_net: move to virtio_net.h
> > > > > > > >   virtio_net: add prefix virtnet to all struct/api inside v=
irtio_net.h
> > > > > > > >   virtio_net: separate virtnet_rx_resize()
> > > > > > > >   virtio_net: separate virtnet_tx_resize()
> > > > > > > >   virtio_net: sq support premapped mode
> > > > > > > >   virtio_net: xsk: bind/unbind xsk
> > > > > > > >   virtio_net: xsk: prevent disable tx napi
> > > > > > > >   virtio_net: xsk: tx: support tx
> > > > > > > >   virtio_net: xsk: tx: support wakeup
> > > > > > > >   virtio_net: xsk: tx: virtnet_free_old_xmit() distinguishe=
s xsk buffer
> > > > > > > >   virtio_net: xsk: tx: virtnet_sq_free_unused_buf() check x=
sk buffer
> > > > > > > >   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
> > > > > > > >   virtio_net: xsk: rx: introduce receive_xsk() to recv xsk =
buffer
> > > > > > > >   virtio_net: xsk: rx: virtnet_rq_free_unused_buf() check x=
sk buffer
> > > > > > > >   virtio_net: update tx timeout record
> > > > > > > >   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
> > > > > > > >
> > > > > > > >  MAINTAINERS                                 |   2 +-
> > > > > > > >  drivers/net/Kconfig                         |   8 +-
> > > > > > > >  drivers/net/Makefile                        |   2 +-
> > > > > > > >  drivers/net/virtio/Kconfig                  |  13 +
> > > > > > > >  drivers/net/virtio/Makefile                 |   8 +
> > > > > > > >  drivers/net/{virtio_net.c =3D> virtio/main.c} | 652 ++++++=
+++-----------
> > > > > > > >  drivers/net/virtio/virtio_net.h             | 359 ++++++++=
+++
> > > > > > > >  drivers/net/virtio/xsk.c                    | 545 ++++++++=
++++++++
> > > > > > > >  drivers/net/virtio/xsk.h                    |  32 +
> > > > > > > >  9 files changed, 1247 insertions(+), 374 deletions(-)
> > > > > > > >  create mode 100644 drivers/net/virtio/Kconfig
> > > > > > > >  create mode 100644 drivers/net/virtio/Makefile
> > > > > > > >  rename drivers/net/{virtio_net.c =3D> virtio/main.c} (91%)
> > > > > > > >  create mode 100644 drivers/net/virtio/virtio_net.h
> > > > > > > >  create mode 100644 drivers/net/virtio/xsk.c
> > > > > > > >  create mode 100644 drivers/net/virtio/xsk.h
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.32.0.3.g01195cf9f
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> >
>


