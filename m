Return-Path: <bpf+bounces-20302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC25C83B954
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 06:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13DCAB20F14
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 05:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4710976;
	Thu, 25 Jan 2024 05:58:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E100101D4;
	Thu, 25 Jan 2024 05:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706162325; cv=none; b=UbG5sN3XsV3OhQuhDn11IeneJ5lXZvbYR+cgRTug1mhaDOSGNjISxmM4hEaDE252ziEl1ynhH2vSI2wPkVYI3qe54z15cSj36l7wzdbfW6TY7Q5roNwdFYn+bfP5sMEpZG5QuZAREgYzmc4KCdcts/KqZXe1x+m4L3ZsS0xupIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706162325; c=relaxed/simple;
	bh=ZGxsE8qFWoRMF23r2zSVoCe4SCiewAlLLPWr+eKG6SM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=Z0nZE+ejvYSNa+YZJmB0t39GQflZRhN0zIPDUNoB1AfuvJwEk0NBxUA6fRjQVcXqxCAgADycSsjVApp3yngoIeGNO+QWFYNKrUvd0xx/63THotQWnEYXqi6xTftpKcaUZyfTbi8KFeKYYrmdERIdMtF5T9dUnnJwSkREWYdHMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.JFBNx_1706162318;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.JFBNx_1706162318)
          by smtp.aliyun-inc.com;
          Thu, 25 Jan 2024 13:58:39 +0800
Message-ID: <1706162276.5311615-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 4/5] virtio_ring: introduce virtqueue_get_dma_premapped()
Date: Thu, 25 Jan 2024 13:57:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <20240116075924.42798-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEtSnuo6yAsiFZkrv6bMaJtLXuLQtL-qvKn-Y_L_PLHdcw@mail.gmail.com>
In-Reply-To: <CACGkMEtSnuo6yAsiFZkrv6bMaJtLXuLQtL-qvKn-Y_L_PLHdcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 25 Jan 2024 11:39:03 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Introduce helper virtqueue_get_dma_premapped(), then the driver
> > can know whether dma unmap is needed.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/main.c       | 22 +++++++++-------------
> >  drivers/net/virtio/virtio_net.h |  3 ---
> >  drivers/virtio/virtio_ring.c    | 22 ++++++++++++++++++++++
> >  include/linux/virtio.h          |  1 +
> >  4 files changed, 32 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index 186b2cf5d8fc..4fbf612da235 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -483,7 +483,7 @@ static void *virtnet_rq_get_buf(struct virtnet_rq *=
rq, u32 *len, void **ctx)
> >         void *buf;
> >
> >         buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > -       if (buf && rq->do_dma)
> > +       if (buf && virtqueue_get_dma_premapped(rq->vq))
> >                 virtnet_rq_unmap(rq, buf, *len);
> >
> >         return buf;
> > @@ -496,7 +496,7 @@ static void virtnet_rq_init_one_sg(struct virtnet_r=
q *rq, void *buf, u32 len)
> >         u32 offset;
> >         void *head;
> >
> > -       if (!rq->do_dma) {
> > +       if (!virtqueue_get_dma_premapped(rq->vq)) {
> >                 sg_init_one(rq->sg, buf, len);
> >                 return;
> >         }
> > @@ -526,7 +526,7 @@ static void *virtnet_rq_alloc(struct virtnet_rq *rq=
, u32 size, gfp_t gfp)
> >
> >         head =3D page_address(alloc_frag->page);
> >
> > -       if (rq->do_dma) {
> > +       if (virtqueue_get_dma_premapped(rq->vq)) {
> >                 dma =3D head;
> >
> >                 /* new pages */
> > @@ -580,12 +580,8 @@ static void virtnet_rq_set_premapped(struct virtne=
t_info *vi)
> >         if (!vi->mergeable_rx_bufs && vi->big_packets)
> >                 return;
> >
> > -       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > -                       continue;
> > -
> > -               vi->rq[i].do_dma =3D true;
> > -       }
> > +       for (i =3D 0; i < vi->max_queue_pairs; i++)
> > +               virtqueue_set_dma_premapped(vi->rq[i].vq);
> >  }
> >
> >  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> > @@ -1643,7 +1639,7 @@ static int add_recvbuf_small(struct virtnet_info =
*vi, struct virtnet_rq *rq,
> >
> >         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gf=
p);
> >         if (err < 0) {
> > -               if (rq->do_dma)
> > +               if (virtqueue_get_dma_premapped(rq->vq))
> >                         virtnet_rq_unmap(rq, buf, 0);
> >                 put_page(virt_to_head_page(buf));
> >         }
> > @@ -1758,7 +1754,7 @@ static int add_recvbuf_mergeable(struct virtnet_i=
nfo *vi,
> >         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> >         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gf=
p);
> >         if (err < 0) {
> > -               if (rq->do_dma)
> > +               if (virtqueue_get_dma_premapped(rq->vq))
> >                         virtnet_rq_unmap(rq, buf, 0);
> >                 put_page(virt_to_head_page(buf));
> >         }
> > @@ -4007,7 +4003,7 @@ static void free_receive_page_frags(struct virtne=
t_info *vi)
> >         int i;
> >         for (i =3D 0; i < vi->max_queue_pairs; i++)
> >                 if (vi->rq[i].alloc_frag.page) {
> > -                       if (vi->rq[i].do_dma && vi->rq[i].last_dma)
> > +                       if (virtqueue_get_dma_premapped(vi->rq[i].vq) &=
& vi->rq[i].last_dma)
> >                                 virtnet_rq_unmap(&vi->rq[i], vi->rq[i].=
last_dma, 0);
> >                         put_page(vi->rq[i].alloc_frag.page);
> >                 }
> > @@ -4035,7 +4031,7 @@ static void virtnet_rq_free_unused_bufs(struct vi=
rtqueue *vq)
> >         rq =3D &vi->rq[i];
> >
> >         while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL) {
> > -               if (rq->do_dma)
> > +               if (virtqueue_get_dma_premapped(rq->vq))
> >                         virtnet_rq_unmap(rq, buf, 0);
> >
> >                 virtnet_rq_free_buf(vi, rq, buf);
> > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virti=
o_net.h
> > index b28a4d0a3150..066a2b9d2b3c 100644
> > --- a/drivers/net/virtio/virtio_net.h
> > +++ b/drivers/net/virtio/virtio_net.h
> > @@ -115,9 +115,6 @@ struct virtnet_rq {
> >
> >         /* Record the last dma info to free after new pages is allocate=
d. */
> >         struct virtnet_rq_dma *last_dma;
> > -
> > -       /* Do dma by self */
> > -       bool do_dma;
> >  };
> >
> >  struct virtnet_info {
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 2c5089d3b510..9092bcdebb53 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2905,6 +2905,28 @@ int virtqueue_set_dma_premapped(struct virtqueue=
 *_vq)
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
> >
> > +/**
> > + * virtqueue_get_dma_premapped - get the vring premapped mode
> > + * @_vq: the struct virtqueue we're talking about.
> > + *
> > + * Get the premapped mode of the vq.
> > + *
> > + * Returns bool for the vq premapped mode.
> > + */
> > +bool virtqueue_get_dma_premapped(struct virtqueue *_vq)
> > +{
> > +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > +       bool premapped;
> > +
> > +       START_USE(vq);
> > +       premapped =3D vq->premapped;
> > +       END_USE(vq);
>
> Why do we need to protect premapped like this? Is the user allowed to
> change it on the fly?


Just protect before accessing vq.

Thanks.
>
> Thanks
>

