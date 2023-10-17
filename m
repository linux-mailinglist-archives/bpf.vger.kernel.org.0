Return-Path: <bpf+bounces-12371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3110B7CB94C
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 05:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F743B20D8E
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 03:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13A88F4D;
	Tue, 17 Oct 2023 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqhrL2t+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8686BE4E
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 03:28:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94548F
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 20:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697513317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYCSQYqds4DMd4Ao7B2IRHBxioxzzukKv5sP1PTQE00=;
	b=cqhrL2t+qM0nHV8E+DIJfd9dhqzFI5H/BHgIx1KbONNB49n59fPXMeILDlOayxuIeJcyFU
	c3ZErOJ9eOsVUeggFlMTianpsR3GsbmyH+FXrA2uUUSXZLCQW5jcL0DN6B/PHpiZqJmTdl
	/VP3pbE5UzbOjLWVRC2o9If+8w5n/q4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-IRwYn4SOMAK4U4EAslYo-A-1; Mon, 16 Oct 2023 23:28:25 -0400
X-MC-Unique: IRwYn4SOMAK4U4EAslYo-A-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507b9078aaaso858157e87.2
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 20:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697513304; x=1698118104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYCSQYqds4DMd4Ao7B2IRHBxioxzzukKv5sP1PTQE00=;
        b=tqEWK4uOCYiqSS9Xao5UW/tbVrQz9b4u+bV+NDI/TkyeB9uBgxcY1Mthmk486WY+3m
         yJ4lM0w/MMcFper7/rsYUTWNxGFmL9kLoBo5fow20tOlhaSwgN4EFDtbZ2mQVOdPpm1L
         EGoER+IWTratDN40hANGyqqazuMnhOWBGgoRf/FYWtVEH4NC/Er5XWz9o9TIAgFWD5ft
         MK5xSEIKe3m3Bihy+QM1HmRAN5khEJx5r7mZ49hNRkIELf2OqBQIsguW4MjOT1lVfHQT
         R7uSQ8h4z4kytkaUh/LHIInrA49g0qcZJNDZRIYyoNjtuTBMpUgdBifaeh1XlgEr9opT
         RBEA==
X-Gm-Message-State: AOJu0YzlE6aUxZ3cc1YjsJNIDWX8Y45uAmGHvkx7PKtE4bqXEetLWXYs
	NDCIspHXZfYM8V2XjJahujhbF1ZSC6uRKnbXSB2QyF5KyvAFaa36nBnx5NsaefHAsbZBhcdBUtC
	+KjinQtUqVwKyIO11w0NYb5Q63VrW
X-Received: by 2002:a05:6512:3281:b0:507:a58f:79ac with SMTP id p1-20020a056512328100b00507a58f79acmr855131lfe.33.1697513304260;
        Mon, 16 Oct 2023 20:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN/Ezj+KzyQRY+7SW6mUopH1XVyGqOf/FfIJffqbAIFRJiAxwNowEknkKLe3v6Jc6d+Q8HGNfc2VdeLRLYIeA=
X-Received: by 2002:a05:6512:3281:b0:507:a58f:79ac with SMTP id
 p1-20020a056512328100b00507a58f79acmr855123lfe.33.1697513303922; Mon, 16 Oct
 2023 20:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
 <1697511725.2037013-1-xuanzhuo@linux.alibaba.com> <CACGkMEskfXDo+bnx5hbGU3JRwOgBRwOC-bYDdFYSmEO2jjgPnA@mail.gmail.com>
 <1697512950.0813534-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1697512950.0813534-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Oct 2023 11:28:12 +0800
Message-ID: <CACGkMEtppjoX_WAM+vjzkMKaMQQ0iZL=C_xS4RObuoLbm0udUw@mail.gmail.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 11:26=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Tue, 17 Oct 2023 11:20:41 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Oct 17, 2023 at 11:11=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > On Tue, 17 Oct 2023 10:53:44 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Oct 16, 2023 at 8:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > ## AF_XDP
> > > > >
> > > > > XDP socket(AF_XDP) is an excellent bypass kernel network framewor=
k. The zero
> > > > > copy feature of xsk (XDP socket) needs to be supported by the dri=
ver. The
> > > > > performance of zero copy is very good. mlx5 and intel ixgbe alrea=
dy support
> > > > > this feature, This patch set allows virtio-net to support xsk's z=
erocopy xmit
> > > > > feature.
> > > > >
> > > > > At present, we have completed some preparation:
> > > > >
> > > > > 1. vq-reset (virtio spec and kernel code)
> > > > > 2. virtio-core premapped dma
> > > > > 3. virtio-net xdp refactor
> > > > >
> > > > > So it is time for Virtio-Net to complete the support for the XDP =
Socket
> > > > > Zerocopy.
> > > > >
> > > > > Virtio-net can not increase the queue num at will, so xsk shares =
the queue with
> > > > > kernel.
> > > > >
> > > > > On the other hand, Virtio-Net does not support generate interrupt=
 from driver
> > > > > manually, so when we wakeup tx xmit, we used some tips. If the CP=
U run by TX
> > > > > NAPI last time is other CPUs, use IPI to wake up NAPI on the remo=
te CPU. If it
> > > > > is also the local CPU, then we wake up napi directly.
> > > > >
> > > > > This patch set includes some refactor to the virtio-net to let th=
at to support
> > > > > AF_XDP.
> > > > >
> > > > > ## performance
> > > > >
> > > > > ENV: Qemu with vhost-user(polling mode).
> > > > >
> > > > > Sockperf: https://github.com/Mellanox/sockperf
> > > > > I use this tool to send udp packet by kernel syscall.
> > > > >
> > > > > xmit command: sockperf tp -i 10.0.3.1 -t 1000
> > > > >
> > > > > I write a tool that sends udp packets or recvs udp packets by AF_=
XDP.
> > > > >
> > > > >                   | Guest APP CPU |Guest Softirq CPU | UDP PPS
> > > > > ------------------|---------------|------------------|-----------=
-
> > > > > xmit by syscall   |   100%        |                  |   676,915
> > > > > xmit by xsk       |   59.1%       |   100%           | 5,447,168
> > > > > recv by syscall   |   60%         |   100%           |   932,288
> > > > > recv by xsk       |   35.7%       |   100%           | 3,343,168
> > > >
> > > > Any chance we can get a testpmd result (which I guess should be bet=
ter
> > > > than PPS above)?
> > >
> > > Do you mean testpmd + DPDK + AF_XDP?
> >
> > Yes.
> >
> > >
> > > Yes. This is probably better because my tool does more work. That is =
not a
> > > complete testing tool used by our business.
> >
> > Probably, but it would be appealing for others. Especially considering
> > DPDK supports AF_XDP PMD now.
>
> OK.
>
> Let me try.
>
> But could you start to review firstly?

Yes, it's in my todo list.

>
>
> >
> > >
> > > What I noticed is that the hotspot is the driver writing virtio desc.=
 Because
> > > the device is in busy mode. So there is race between driver and devic=
e.
> > > So I modified the virtio core and lazily updated avail idx. Then pps =
can reach
> > > 10,000,000.
> >
> > Care to post a draft for this?
>
> YES, I is thinking for this.
> But maybe that is just work for split. The packed mode has some troubles.

Ok.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > ## maintain
> > > > >
> > > > > I am currently a reviewer for virtio-net. I commit to maintain AF=
_XDP support in
> > > > > virtio-net.
> > > > >
> > > > > Please review.
> > > > >
> > > > > Thanks.
> > > > >
> > > > > v1:
> > > > >     1. remove two virtio commits. Push this patchset to net-next
> > > > >     2. squash "virtio_net: virtnet_poll_tx support rescheduled" t=
o xsk: support tx
> > > > >     3. fix some warnings
> > > > >
> > > > > Xuan Zhuo (19):
> > > > >   virtio_net: rename free_old_xmit_skbs to free_old_xmit
> > > > >   virtio_net: unify the code for recycling the xmit ptr
> > > > >   virtio_net: independent directory
> > > > >   virtio_net: move to virtio_net.h
> > > > >   virtio_net: add prefix virtnet to all struct/api inside virtio_=
net.h
> > > > >   virtio_net: separate virtnet_rx_resize()
> > > > >   virtio_net: separate virtnet_tx_resize()
> > > > >   virtio_net: sq support premapped mode
> > > > >   virtio_net: xsk: bind/unbind xsk
> > > > >   virtio_net: xsk: prevent disable tx napi
> > > > >   virtio_net: xsk: tx: support tx
> > > > >   virtio_net: xsk: tx: support wakeup
> > > > >   virtio_net: xsk: tx: virtnet_free_old_xmit() distinguishes xsk =
buffer
> > > > >   virtio_net: xsk: tx: virtnet_sq_free_unused_buf() check xsk buf=
fer
> > > > >   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
> > > > >   virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
> > > > >   virtio_net: xsk: rx: virtnet_rq_free_unused_buf() check xsk buf=
fer
> > > > >   virtio_net: update tx timeout record
> > > > >   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
> > > > >
> > > > >  MAINTAINERS                                 |   2 +-
> > > > >  drivers/net/Kconfig                         |   8 +-
> > > > >  drivers/net/Makefile                        |   2 +-
> > > > >  drivers/net/virtio/Kconfig                  |  13 +
> > > > >  drivers/net/virtio/Makefile                 |   8 +
> > > > >  drivers/net/{virtio_net.c =3D> virtio/main.c} | 652 +++++++++---=
--------
> > > > >  drivers/net/virtio/virtio_net.h             | 359 +++++++++++
> > > > >  drivers/net/virtio/xsk.c                    | 545 ++++++++++++++=
++
> > > > >  drivers/net/virtio/xsk.h                    |  32 +
> > > > >  9 files changed, 1247 insertions(+), 374 deletions(-)
> > > > >  create mode 100644 drivers/net/virtio/Kconfig
> > > > >  create mode 100644 drivers/net/virtio/Makefile
> > > > >  rename drivers/net/{virtio_net.c =3D> virtio/main.c} (91%)
> > > > >  create mode 100644 drivers/net/virtio/virtio_net.h
> > > > >  create mode 100644 drivers/net/virtio/xsk.c
> > > > >  create mode 100644 drivers/net/virtio/xsk.h
> > > > >
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > > >
> > > >
> > >
> >
>


