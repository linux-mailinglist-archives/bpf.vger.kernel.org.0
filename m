Return-Path: <bpf+bounces-32276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0191C90A784
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 09:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DFD2821EE
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 07:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8341190041;
	Mon, 17 Jun 2024 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Oz4D1CeX"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5418F2C2;
	Mon, 17 Jun 2024 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610071; cv=none; b=d62oxGsR9f3qT3KlAuv76aMW9eNEPvxXA6oJuCIZXNev0tWoDVt693FI6MGtWdZS3dmOA+cDXUJf9yxFxYMWwGUYOaA+/xGwutiUe1TjZpb+pNB6L7/Xo0TQpTJSDk4zuxqXq9+JUvWYgtLAgl2qql+RJlLlvwzFfQbx7UpaQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610071; c=relaxed/simple;
	bh=Op8KLxv9dy6woz1lVVmehDhwyx3ccncwUq6AZU5A3wM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=REwdeWd/+Mt0Mo0KDs0g6wTfM9XgMOSGDZ37IUEUedQUm1MqTgmF/lbplymfbdr7ByAIpxSREji1PFJW9CnbTQEJbKG/3JkfJPJTdydHGhoLVJxWqU7XRteiUHlJWLbUuxqDyhaSKwEhHGMTnEMwmitzazuG7GY4eiPe4Jw6nAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Oz4D1CeX; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718610065; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=62Rs5GL8ezDEyN4/r4bZLSJTeWByktNPyALKTS15Xyo=;
	b=Oz4D1CeXLHk6Kc+dI+mSC95zVoDb66ghfjUrvJNw9Tqrqywe4bxPsDm/GTzK7No/A1HiQnUahsYbmC/vK1TWuezmcy4zRVv1rhlYlthVqW++hfcYXFpbUKeMsiPWNeXJAKUvIGk4bdamedHGGcWT3aXqfVGrBsZ66E5hsbXoUSI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8ZoKa7_1718610064;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8ZoKa7_1718610064)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 15:41:05 +0800
Message-ID: <1718610035.6750584-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 08/15] virtio_net: sq support premapped mode
Date: Mon, 17 Jun 2024 15:40:35 +0800
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
In-Reply-To: <CACGkMEuxhaPcSyvNnZH3q1uvSUTbpRMr+YuK4r0x6zG_SKesbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 17 Jun 2024 14:28:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jun 17, 2024 at 1:00=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > If the xsk is enabling, the xsk tx will share the send queue.
> > > But the xsk requires that the send queue use the premapped mode.
> > > So the send queue must support premapped mode when it is bound to
> > > af-xdp.
> > >
> > > * virtnet_sq_set_premapped(sq, true) is used to enable premapped mode.
> > >
> > >     In this mode, the driver will record the dma info when skb or xdp
> > >     frame is sent.
> > >
> > >     Currently, the SQ premapped mode is operational only with af-xdp.=
 In
> > >     this mode, af-xdp, the kernel stack, and xdp tx/redirect will sha=
re
> > >     the same SQ. Af-xdp independently manages its DMA. The kernel sta=
ck
> > >     and xdp tx/redirect utilize this DMA metadata to manage the DMA
> > >     info.
> > >
>
> Note that there's indeed a mode when we have exclusive XDP TX queue:
>
>         /* XDP requires extra queues for XDP_TX */
>         if (curr_qp + xdp_qp > vi->max_queue_pairs) {
>                 netdev_warn_once(dev, "XDP request %i queues but max
> is %i. XDP_TX and XDP_REDIRECT will operate in a slower locked tx
> mode.\n",
>                                  curr_qp + xdp_qp, vi->max_queue_pairs);
>                 xdp_qp =3D 0;
>         }
>
> So we need to mention how the code works in this patch.

Sorry, I do not get it.

Could you say more?

Thanks.


>
> Thanks
>

