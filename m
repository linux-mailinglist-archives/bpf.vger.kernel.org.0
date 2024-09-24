Return-Path: <bpf+bounces-40246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7470B9841F7
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 11:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364E6282A4D
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 09:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F28D15665E;
	Tue, 24 Sep 2024 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mj5hF09H"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59884A50;
	Tue, 24 Sep 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169760; cv=none; b=axCurHn39LBlL5CVzeo/ZoDvymNK1v3PvJRb92PlfCbinDFNsgF3nxdv4hhN2NXXkWmCqqfnYErHFAQQakXthGnoI7fU7rkPZxURy/18Dcej2leUWFq28ra4wKYkyIQtPV7fGRw6O8Jtt4mfthjwVSV2OiuUaAuSGSB5R0hB8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169760; c=relaxed/simple;
	bh=6Vj11S6HdMJuiRm1aLSSlE7/927+AYxpKwgCgumPXbE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=gGu+klSCXUsD5/LaWLECvet5sjJbnFq+dIMBzsJjxFvnunE8/X3rh5QY53QGq0i66ZPf7UaJDlm6sh5qnR5uQZdPZ6wncof177uH+Ck9XWrlIfD3u64xyM2kwFvskb06+tnINij+/ySgdVf3sR3DqnnzmBC2Na0qXQCkLWoD250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mj5hF09H; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727169754; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=lTTh98SEm+9t4NZHOlfMXI3Szo21fHMqd5Hby1i8RH8=;
	b=mj5hF09HOkd/N9E1lnKsJXgsjFwMC+MorD6297h9AyOoqfamRZuVJDZOBSQQEoiZ5tx18SsMvjzjQaeHObuJokcYlJEiK8Sh0h19IW0gtpHcd9r/piilgFfP4eM6Ij/i8QgGdU9T9teFM0ef+DYkHB0qLJIOxmBpToRtLfg/L98=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFflEn5_1727169752)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 17:22:33 +0800
Message-ID: <1727169724.035726-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next v1 08/12] virtio_net: xsk: bind/unbind xsk for tx
Date: Tue, 24 Sep 2024 17:22:04 +0800
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
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
 <20240924013204.13763-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEsTpJV=dQUHMWTnzuSmGTqdEKz4jYygHtbXGtA0q3HnoA@mail.gmail.com>
In-Reply-To: <CACGkMEsTpJV=dQUHMWTnzuSmGTqdEKz4jYygHtbXGtA0q3HnoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 24 Sep 2024 15:35:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > This patch implement the logic of bind/unbind xsk pool to sq and rq.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 41a5ea9b788d..7c379614fd22 100644
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
> > @@ -497,6 +501,8 @@ struct virtio_net_common_hdr {
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
> > @@ -5488,6 +5494,29 @@ static int virtnet_rq_bind_xsk_pool(struct virtn=
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
> > @@ -5496,6 +5525,7 @@ static int virtnet_xsk_pool_enable(struct net_dev=
ice *dev,
> >         struct receive_queue *rq;
> >         struct device *dma_dev;
> >         struct send_queue *sq;
> > +       dma_addr_t hdr_dma;
> >         int err, size;
> >
> >         if (vi->hdr_len > xsk_pool_get_headroom(pool))
> > @@ -5533,6 +5563,11 @@ static int virtnet_xsk_pool_enable(struct net_de=
vice *dev,
> >         if (!rq->xsk_buffs)
> >                 return -ENOMEM;
> >
> > +       hdr_dma =3D virtqueue_dma_map_single_attrs(sq->vq, &xsk_hdr, vi=
->hdr_len,
> > +                                                DMA_TO_DEVICE, 0);
> > +       if (virtqueue_dma_mapping_error(sq->vq, hdr_dma))
> > +               return -ENOMEM;
> > +
> >         err =3D xsk_pool_dma_map(pool, dma_dev, 0);
> >         if (err)
> >                 goto err_xsk_map;
> > @@ -5541,11 +5576,24 @@ static int virtnet_xsk_pool_enable(struct net_d=
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
>
> What did you mean by "tx offset" here? (Or I don't see the connection
> with vnet hdr).

Sorry, should be tx offload(such as tx csum).

Will fix.

Thanks.


>
> Anyhow the patch looks good.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>

