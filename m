Return-Path: <bpf+bounces-32362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE790C14B
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 03:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98942B21C8F
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 01:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C34FC19;
	Tue, 18 Jun 2024 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="smsfpPqC"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DECA175A6;
	Tue, 18 Jun 2024 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674341; cv=none; b=OWAc6YGPBQTz25IWfkQODSaaFimIRfBjRQu1YiKZeBhU9KFGBdVgj0UeSlrsjVT2VvK2FQlZvIcqAvyo7yeMYh3HqsAIBFjcegmGH86UrsRZ2BrPvXTdb897HfBOLEZTZBmuBRaFbWTe0fRAIvYHSTI7ZB2hswwLmQta7NI4N04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674341; c=relaxed/simple;
	bh=8bPICOkByOjXh/x9mA2P1KCZbuDXrtdWJtPasH+ur20=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=D0AD55EfIrpFnMzR3OFMpNNbvvrvaic3VNuRcxfXdeZxkXl4Z6Bb5B1HBO6uAc0FM/1qgm36pH45I36MuVlCVPdUELWMyfiuu3URE0AXrb4fW4CDftj3dD4CFsI76MKrx/sea+SlNZ2pyOtySSnpRtJEiPqTX/r4gJkCxWVdZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=smsfpPqC; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718674336; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=BWUhTV3Zm6iFVVs+V5kMxGQhSefJSSIyFuiZxxlTTfo=;
	b=smsfpPqClQBVCmQrWM9BK/JuFfHyniCdDnSpJ81Sx9Q/v9E5ARO8SZ0MYw6PpD7Oe0MV9IS+wqmgdHq/uYk4ALry+NZQDfggdwZU/qozljebzyg2hjcjqeABgfPKEMn2A7UrGGqvesrEd+9pIuOYU6bOI0PKW7tqyuoQUq2GkvI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8hvQ89_1718674335;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8hvQ89_1718674335)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 09:32:15 +0800
Message-ID: <1718674285.282276-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 08/15] virtio_net: sq support premapped mode
Date: Tue, 18 Jun 2024 09:31:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
 <CACGkMEuxhaPcSyvNnZH3q1uvSUTbpRMr+YuK4r0x6zG_SKesbg@mail.gmail.com>
 <1718610035.6750584-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEuWCYdvYkxPBodw4cuxDhkszJkA0h9rwDOKVLJFjaxyEw@mail.gmail.com>
In-Reply-To: <CACGkMEuWCYdvYkxPBodw4cuxDhkszJkA0h9rwDOKVLJFjaxyEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 18 Jun 2024 09:00:56 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jun 17, 2024 at 3:41=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Mon, 17 Jun 2024 14:28:05 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Mon, Jun 17, 2024 at 1:00=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > > > But the xsk requires that the send queue use the premapped mode.
> > > > > So the send queue must support premapped mode when it is bound to
> > > > > af-xdp.
> > > > >
> > > > > * virtnet_sq_set_premapped(sq, true) is used to enable premapped =
mode.
> > > > >
> > > > >     In this mode, the driver will record the dma info when skb or=
 xdp
> > > > >     frame is sent.
> > > > >
> > > > >     Currently, the SQ premapped mode is operational only with af-=
xdp. In
> > > > >     this mode, af-xdp, the kernel stack, and xdp tx/redirect will=
 share
> > > > >     the same SQ. Af-xdp independently manages its DMA. The kernel=
 stack
> > > > >     and xdp tx/redirect utilize this DMA metadata to manage the D=
MA
> > > > >     info.
> > > > >
> > >
> > > Note that there's indeed a mode when we have exclusive XDP TX queue:
> > >
> > >         /* XDP requires extra queues for XDP_TX */
> > >         if (curr_qp + xdp_qp > vi->max_queue_pairs) {
> > >                 netdev_warn_once(dev, "XDP request %i queues but max
> > > is %i. XDP_TX and XDP_REDIRECT will operate in a slower locked tx
> > > mode.\n",
> > >                                  curr_qp + xdp_qp, vi->max_queue_pair=
s);
> > >                 xdp_qp =3D 0;
> > >         }
> > >
> > > So we need to mention how the code works in this patch.
> >
> > Sorry, I do not get it.
> >
> > Could you say more?
>
> I meant in the commit log, you said:
>
> """
> In this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
> the same SQ.
> """
>
> is not correct if we have sufficient queue pairs.
>
> We need to tweak it and explain if the code can still work if we have
> exclusive XDP TX queues.


YES, it can work.

I will explain in next version.

Thanks.


>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > > Thanks
> > >
> >
>

