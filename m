Return-Path: <bpf+bounces-39702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED76697638E
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 09:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCCF1F22C17
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 07:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D1018E379;
	Thu, 12 Sep 2024 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cGEYbPOx"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387A81552E1;
	Thu, 12 Sep 2024 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127698; cv=none; b=swa9q1239CaKTQ6IilS+aZx0viactBg/NJLYV8Mpb1d8PkoUj0tmJaISmGxb523czZBBidCeIF0J31tTBXb1lN7imA7kiQlUKeRQ1jhy9f6oq6mbqYc+HpMB8h1Rs0tJy0n3dUa9g1as7nr0XBQyLYeXFfq53MdYJj5HFc64fl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127698; c=relaxed/simple;
	bh=sElidT79qVQ7KtOCqREnVwSj8TXMDi0zyUeG+ytS4QI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=RdGoPAdLvDBQpxuP56nNrZjpGA3e53WLhvsHH3ZNquIGhTPTf/etQc2B6nujxdL2ViL5pq6WfPoQ6SM9mGv6MED+6ULOLILAndkzdi2PWG4L88ELWlE9I99NGN6Wo/oiabKoBd8HunjOWR0DqhMbTmCmwqv2HIdqBoEdM0Zctqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cGEYbPOx; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726127693; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=Tu9bJSc7T/p8sXY32nlC4PN7veHBrgOxRQTrewk/iUU=;
	b=cGEYbPOxTR4KOb8Qeww39p3vtuNIau+JPk+Aryox+ZQCr1qoKcFLKASYO56Qgh+zlzgx520rRqKp7ufK0nwb3tk1oEf+Qohh+KPDfVZrKW6sfOBOvEpG8UpOjZ4tWCxTFW/tAnOWEL3c9/Em2ldTxU6r8L0/H4dU2tUFLNomNJk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEqjsid_1726127691)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 15:54:52 +0800
Message-ID: <1726127678.0431764-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 08/13] virtio_net: xsk: bind/unbind xsk for tx
Date: Thu, 12 Sep 2024 15:54:38 +0800
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
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEuD9kp5Mgpqu+zszcYsiAyX_H-A-LfPM+YJPijeUtWJcw@mail.gmail.com>
In-Reply-To: <CACGkMEuD9kp5Mgpqu+zszcYsiAyX_H-A-LfPM+YJPijeUtWJcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 11 Sep 2024 12:08:06 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > This patch implement the logic of bind/unbind xsk pool to sq and rq.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 54 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 96abee36738b..6a36a204e967 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -295,6 +295,10 @@ struct send_queue {
> >
> >         /* Record whether sq is in reset state. */
> >         bool reset;
> > +
> > +       struct xsk_buff_pool *xsk_pool;
> > +
> > +       dma_addr_t xsk_hdr_dma_addr;
> >  };
> >
> >  /* Internal representation of a receive virtqueue */
> > @@ -494,6 +498,8 @@ struct virtio_net_common_hdr {
> >         };
> >  };
> >
> > +static struct virtio_net_common_hdr xsk_hdr;
> > +
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf=
);
> >  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_b=
uff *xdp,
> >                                struct net_device *dev,
> > @@ -5476,6 +5482,29 @@ static int virtnet_rq_bind_xsk_pool(struct virtn=
et_info *vi, struct receive_queu
> >         return err;
> >  }
> >
> > +static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> > +                                   struct send_queue *sq,
> > +                                   struct xsk_buff_pool *pool)
> > +{
> > +       int err, qindex;
> > +
> > +       qindex =3D sq - vi->sq;
> > +
> > +       virtnet_tx_pause(vi, sq);
> > +
> > +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> > +       if (err) {
> > +               netdev_err(vi->dev, "reset tx fail: tx queue index: %d =
err: %d\n", qindex, err);
> > +               pool =3D NULL;
> > +       }
> > +
> > +       sq->xsk_pool =3D pool;
> > +
> > +       virtnet_tx_resume(vi, sq);
> > +
> > +       return err;
> > +}
> > +
> >  static int virtnet_xsk_pool_enable(struct net_device *dev,
> >                                    struct xsk_buff_pool *pool,
> >                                    u16 qid)
> > @@ -5484,6 +5513,7 @@ static int virtnet_xsk_pool_enable(struct net_dev=
ice *dev,
> >         struct receive_queue *rq;
> >         struct device *dma_dev;
> >         struct send_queue *sq;
> > +       dma_addr_t hdr_dma;
> >         int err, size;
> >
> >         if (vi->hdr_len > xsk_pool_get_headroom(pool))
> > @@ -5521,6 +5551,10 @@ static int virtnet_xsk_pool_enable(struct net_de=
vice *dev,
> >         if (!rq->xsk_buffs)
> >                 return -ENOMEM;
> >
> > +       hdr_dma =3D dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_=
TO_DEVICE);
>
> Let's use the virtqueue_dma_xxx() wrappers here.

Will fix.

Thanks.


>
> > +       if (dma_mapping_error(dma_dev, hdr_dma))
> > +               return -ENOMEM;
> > +
> >         err =3D xsk_pool_dma_map(pool, dma_dev, 0);
> >         if (err)
> >                 goto err_xsk_map;
> > @@ -5529,11 +5563,23 @@ static int virtnet_xsk_pool_enable(struct net_d=
evice *dev,
> >         if (err)
> >                 goto err_rq;
> >
> > +       err =3D virtnet_sq_bind_xsk_pool(vi, sq, pool);
> > +       if (err)
> > +               goto err_sq;
> > +
> > +       /* Now, we do not support tx offset, so all the tx virtnet hdr =
is zero.
> > +        * So all the tx packets can share a single hdr.
> > +        */
> > +       sq->xsk_hdr_dma_addr =3D hdr_dma;
> > +
> >         return 0;
> >
> > +err_sq:
> > +       virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> >  err_rq:
> >         xsk_pool_dma_unmap(pool, 0);
> >  err_xsk_map:
> > +       dma_unmap_single(dma_dev, hdr_dma, vi->hdr_len, DMA_TO_DEVICE);
> >         return err;
> >  }
> >
> > @@ -5542,19 +5588,27 @@ static int virtnet_xsk_pool_disable(struct net_=
device *dev, u16 qid)
> >         struct virtnet_info *vi =3D netdev_priv(dev);
> >         struct xsk_buff_pool *pool;
> >         struct receive_queue *rq;
> > +       struct device *dma_dev;
> > +       struct send_queue *sq;
> >         int err;
> >
> >         if (qid >=3D vi->curr_queue_pairs)
> >                 return -EINVAL;
> >
> > +       sq =3D &vi->sq[qid];
> >         rq =3D &vi->rq[qid];
> >
> >         pool =3D rq->xsk_pool;
> >
> >         err =3D virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> > +       err |=3D virtnet_sq_bind_xsk_pool(vi, sq, NULL);
> >
> >         xsk_pool_dma_unmap(pool, 0);
> >
> > +       dma_dev =3D virtqueue_dma_dev(sq->vq);
> > +
> > +       dma_unmap_single(dma_dev, sq->xsk_hdr_dma_addr, vi->hdr_len, DM=
A_TO_DEVICE);
>
> And here.
>
> Thanks
>
> > +
> >         kvfree(rq->xsk_buffs);
> >
> >         return err;
> > --
> > 2.32.0.3.g01195cf9f
> >
>

