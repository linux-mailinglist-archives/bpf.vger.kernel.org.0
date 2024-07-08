Return-Path: <bpf+bounces-34046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74480929DD0
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 10:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31881C21FF3
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 08:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DF039AFD;
	Mon,  8 Jul 2024 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uw1YSUll"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB531F95A;
	Mon,  8 Jul 2024 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425594; cv=none; b=KZJJxpmEtsbQis7bW/2paKw0+Q/LKTr55HMkcHgEZfUS22GEp4gAgJo/tzVKwOLCFY58qOxdp312grLcQTFnFM+xYaZio4LDarDDlckKfxi9t0zqlg1bnmP7NO1DPvncUCcHAb1aRuI6K2ALBKIg65pLKEzr72haMymdsIvfreM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425594; c=relaxed/simple;
	bh=5ROnfIXHaAgax2cShWnRx8zmRty0ektpFcEoopjaTvY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=lu+pgEwnPyBEA2/virPFL7TghPUZQfUd6hmLtwdKs07kAU4A7E5bVI5zS5wuR9j4jPuOgDbLYbrRGlndIN73JxwkQ3yUQ4NOLP+kzY9pXc3LxKb8LgHWnJlFI09Bzi/+UmOUtrE5P/RIzekWwWoUavxt4UCaDewyGlrQ6zmGXh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uw1YSUll; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720425581; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=7r3mwGW9GdsFIq1Kb50dKba6FdBmn+tKTm7vsJMnREs=;
	b=uw1YSUll8MWhXBCXFGunFrd54aRo8uVyz4ZSf6h2fubhNQYx1C3PbB1irYm7frPqGq8R9P3+uDuDK5skBWy9cP5VSt3/4TFfzHYXLPFJjS1TrNRBUmQNxSY/1Fc59pNrnDTCkirhlD+Ar3o3vhPMXMag3wcAKo0a3hQbCj0nz34=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0WA2TuyG_1720425580;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WA2TuyG_1720425580)
          by smtp.aliyun-inc.com;
          Mon, 08 Jul 2024 15:59:41 +0800
Message-ID: <1720425461.7776186-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v7 08/10] virtio_net: xsk: rx: support fill with xsk buffer
Date: Mon, 8 Jul 2024 15:57:41 +0800
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
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
 <20240705073734.93905-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEvW72oG-HsLiOwKdUkdOdKCFiyUAU6Nhj8Q4FFbnXAAqA@mail.gmail.com>
In-Reply-To: <CACGkMEvW72oG-HsLiOwKdUkdOdKCFiyUAU6Nhj8Q4FFbnXAAqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 8 Jul 2024 14:49:35 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Jul 5, 2024 at 3:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > Implement the logic of filling rq with XSK buffers.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >
> > v7:
> >    1. some small fixes
> >
> >  drivers/net/virtio_net.c | 70 +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 66 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 29fa25ce1a7f..2b27f5ada64a 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -354,6 +354,8 @@ struct receive_queue {
> >
> >         /* xdp rxq used by xsk */
> >         struct xdp_rxq_info xsk_rxq_info;
> > +
> > +       struct xdp_buff **xsk_buffs;
> >  };
> >
> >  /* This structure can contain rss message with maximum settings for in=
direction table and keysize
> > @@ -1054,6 +1056,53 @@ static void check_sq_full_and_disable(struct vir=
tnet_info *vi,
> >         }
> >  }
> >
> > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 l=
en)
> > +{
> > +       sg->dma_address =3D addr;
> > +       sg->length =3D len;
> > +}
> > +
> > +static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct rec=
eive_queue *rq,
> > +                                  struct xsk_buff_pool *pool, gfp_t gf=
p)
> > +{
> > +       struct xdp_buff **xsk_buffs;
> > +       dma_addr_t addr;
> > +       int err =3D 0;
> > +       u32 len, i;
> > +       int num;
> > +
> > +       xsk_buffs =3D rq->xsk_buffs;
> > +
> > +       num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> > +       if (!num)
> > +               return -ENOMEM;
> > +
> > +       len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> > +
> > +       for (i =3D 0; i < num; ++i) {
> > +               /* use the part of XDP_PACKET_HEADROOM as the virtnet h=
dr space */
>
> It's better to also say we assume hdr->len is larger than
> XDP_PACKET_HEADROOM. (see function xyz).
>
> > +               addr =3D xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_l=
en;
> > +
> > +               sg_init_table(rq->sg, 1);
> > +               sg_fill_dma(rq->sg, addr, len);
> > +
> > +               err =3D virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buff=
s[i], gfp);
> > +               if (err)
> > +                       goto err;
> > +       }
> > +
> > +       return num;
> > +
> > +err:
> > +       if (i)
> > +               err =3D i;
>
> Any reason to assign an index to err here?

I tried to return the num of bufs added to the ring.

But rethink this, we should return the error of virtqueue_add_inbuf() direc=
tly.

Will fix.

Thanks.

>
> Others look good.
>
> Thanks
>

