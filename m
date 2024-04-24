Return-Path: <bpf+bounces-27653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E878B043D
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 10:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A8A28422B
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 08:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744D6158A01;
	Wed, 24 Apr 2024 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k2ttFWZu"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949BE15886A;
	Wed, 24 Apr 2024 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947016; cv=none; b=KKq3QpE8PaV0yL2xDM6aQ9Jnxfu6LlJeS7ql0b0CQqEiJFVRP9d7pPLy1R2Uq7EcsNS4E+JkdKrEvlqn+ALE7Njs5NnjOyNRg3QbQ0+SYnuN8m4lgMzvRatfCpytIR/LMBfIVL63EMk7Y7zM/QYdhdHW0TwcsfjXqcllIIyxAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947016; c=relaxed/simple;
	bh=3ARAWoBtxebwEsPBwnDklTrDSSkghbxUEWf1tljbbII=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=FY8KYiC+QR7BvoXuYEM3Q+Mt9AKI56GLZFez8KFkMVG+lLU8EmlUfEux/l9ml3sw916vSxAP/YMTQi34jANw53ipNHb56I+7TJF2U4/CY3WHOH5cDc/eMwhriVvuLU0Sk8X7JT4hNoLVaAjvWwhOSH9GX7NkgQ/Q/XhouakmPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k2ttFWZu; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713947010; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=y8Gj3JVfYe7P540GKPgrPDv5i5w7zuz2gXJ/tyV3XKM=;
	b=k2ttFWZuf1wwrtewlPQtWJNinoZo6LubVF3Y19NmXjXZI8vE+hLHDJUFN0siph0T8dYGvSKQAZdYIuulcXihzQcnpB6WwXOak2Xo2bT47sEZmZk9FQCPmx8QnY1nuXB7k5gjmR5qA+QoXdmk7bp5TYgLrr1DPdjdjeCFfFG6swY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5Bjkwb_1713947007;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5Bjkwb_1713947007)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 16:23:28 +0800
Message-ID: <1713946991.7525542-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 6/8] virtio_net: rename stat tx_timeout to timeout
Date: Wed, 24 Apr 2024 16:23:11 +0800
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
 Stanislav Fomichev <sdf@google.com>,
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 Jiri Pirko <jiri@nvidia.com>
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
 <20240423113141.1752-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEvoOqcazXxAt6KwShwJxtn=Z-sF7-yZr+JcUGL3Vk=S7g@mail.gmail.com>
In-Reply-To: <CACGkMEvoOqcazXxAt6KwShwJxtn=Z-sF7-yZr+JcUGL3Vk=S7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 24 Apr 2024 11:55:24 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Apr 23, 2024 at 7:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Now, we have this:
> >
> >     tx_queue_0_tx_timeouts
> >
> > This is used to record the tx schedule timeout.
> > But this has two "tx". I think the below is enough.
> >
> >     tx_queue_0_timeouts
> >
> > So I rename this field.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > ---
> >  drivers/net/virtio_net.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 8a4d22f5f5b1..51ce2308f4f5 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -87,7 +87,7 @@ struct virtnet_sq_stats {
> >         u64_stats_t xdp_tx;
> >         u64_stats_t xdp_tx_drops;
> >         u64_stats_t kicks;
> > -       u64_stats_t tx_timeouts;
> > +       u64_stats_t timeouts;
> >  };
> >
> >  struct virtnet_rq_stats {
> > @@ -111,7 +111,7 @@ static const struct virtnet_stat_desc virtnet_sq_st=
ats_desc[] =3D {
> >         VIRTNET_SQ_STAT("xdp_tx",       xdp_tx),
> >         VIRTNET_SQ_STAT("xdp_tx_drops", xdp_tx_drops),
> >         VIRTNET_SQ_STAT("kicks",        kicks),
> > -       VIRTNET_SQ_STAT("tx_timeouts",  tx_timeouts),
> > +       VIRTNET_SQ_STAT("timeouts",     timeouts),
>
> Not sure if it is too late to do this as it is noticeable by the userspac=
e.

OK. I remove this in next version.

Thanks.


>
> Thanks
>
> >  };
> >
> >  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] =3D {
> > @@ -2691,7 +2691,7 @@ static void virtnet_stats(struct net_device *dev,
> >                         start =3D u64_stats_fetch_begin(&sq->stats.sync=
p);
> >                         tpackets =3D u64_stats_read(&sq->stats.packets);
> >                         tbytes   =3D u64_stats_read(&sq->stats.bytes);
> > -                       terrors  =3D u64_stats_read(&sq->stats.tx_timeo=
uts);
> > +                       terrors  =3D u64_stats_read(&sq->stats.timeouts=
);
> >                 } while (u64_stats_fetch_retry(&sq->stats.syncp, start)=
);
> >
> >                 do {
> > @@ -4639,7 +4639,7 @@ static void virtnet_tx_timeout(struct net_device =
*dev, unsigned int txqueue)
> >         struct netdev_queue *txq =3D netdev_get_tx_queue(dev, txqueue);
> >
> >         u64_stats_update_begin(&sq->stats.syncp);
> > -       u64_stats_inc(&sq->stats.tx_timeouts);
> > +       u64_stats_inc(&sq->stats.timeouts);
> >         u64_stats_update_end(&sq->stats.syncp);
> >
> >         netdev_err(dev, "TX timeout on queue: %u, sq: %s, vq: 0x%x, nam=
e: %s, %u usecs ago\n",
> > --
> > 2.32.0.3.g01195cf9f
> >
>

