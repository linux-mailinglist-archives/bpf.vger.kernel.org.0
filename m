Return-Path: <bpf+bounces-20671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A6841A4B
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 04:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2860F282EEF
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 03:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E3637707;
	Tue, 30 Jan 2024 03:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UzGvEXro"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE86376FC;
	Tue, 30 Jan 2024 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584453; cv=none; b=qVt7PunpNFmKYNN9Xh2/+drzk3EDWvwyEA77opVDJECfBCSKkrPNo2n+QysJ5ssprLJg2gVEY2ybsfp5ItbsLp9rJweMT735jcEjn50clG9bTRUH+7hTri24WwsIFiFsRLynkyVY59vjhsKRYKsS2trABn39kQC4Jh+IwPBkWnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584453; c=relaxed/simple;
	bh=uJ9t3A1yKBSRYYm+D7IbrFIT41vtiSlknO3BvyE82jY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=tD+GKQUHhwPxmrGzvRtoSn+xLOfPYnKtskvh4pv95LYyQv8UOLclWb77PK/cTVTPtBFP5NOvrI83IgJ5EYkTkRJoSP4XMhViErEYCr2XUV4v5ylj3ziFpvxPslN89DP7ImKGL/FhMNhYdFnpGO3HKD62eq/vOJk0cy2k3ASxAK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UzGvEXro; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706584443; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=KZFTcrvJ0dICOxtHOtbx0pV+BSophGl3eRC4YMAAlhQ=;
	b=UzGvEXroJzApkGn7dyKgF/72Q/WnFXvxhip+PJmD+vS8i9GBLdNWWhzSymfE2NhD+M78Pjjg05WByle5BaeCCHhBkG72LGuaZ1S7+Cbo/x7cMtS1wYK6HSKmVlOsrAOQgX5DuKGv/g433jqckS0/U79QTFRANtNiF6UCa+xbdKA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.efLUa_1706584442;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.efLUa_1706584442)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 11:14:03 +0800
Message-ID: <1706584427.927847-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 4/5] virtio_ring: introduce virtqueue_get_dma_premapped()
Date: Tue, 30 Jan 2024 11:13:47 +0800
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
 <1706162276.5311615-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEsfVQzb1jDXE=-LABot=3Cd1+kPX6oF+g8z_68s8zMWuQ@mail.gmail.com>
 <1706499019.7011588-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsueyFnFBCBm_8TkBW+rhRzkjJmAw6X-7R2dC1po2BMaQ@mail.gmail.com>
In-Reply-To: <CACGkMEsueyFnFBCBm_8TkBW+rhRzkjJmAw6X-7R2dC1po2BMaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 30 Jan 2024 10:54:25 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jan 29, 2024 at 11:33=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > On Mon, 29 Jan 2024 11:07:50 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Thu, Jan 25, 2024 at 1:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Thu, 25 Jan 2024 11:39:03 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > Introduce helper virtqueue_get_dma_premapped(), then the driver
> > > > > > can know whether dma unmap is needed.
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > > >  drivers/net/virtio/main.c       | 22 +++++++++-------------
> > > > > >  drivers/net/virtio/virtio_net.h |  3 ---
> > > > > >  drivers/virtio/virtio_ring.c    | 22 ++++++++++++++++++++++
> > > > > >  include/linux/virtio.h          |  1 +
> > > > > >  4 files changed, 32 insertions(+), 16 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/mai=
n.c
> > > > > > index 186b2cf5d8fc..4fbf612da235 100644
> > > > > > --- a/drivers/net/virtio/main.c
> > > > > > +++ b/drivers/net/virtio/main.c
> > > > > > @@ -483,7 +483,7 @@ static void *virtnet_rq_get_buf(struct virt=
net_rq *rq, u32 *len, void **ctx)
> > > > > >         void *buf;
> > > > > >
> > > > > >         buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > > > -       if (buf && rq->do_dma)
> > > > > > +       if (buf && virtqueue_get_dma_premapped(rq->vq))
> > > > > >                 virtnet_rq_unmap(rq, buf, *len);
> > > > > >
> > > > > >         return buf;
> > > > > > @@ -496,7 +496,7 @@ static void virtnet_rq_init_one_sg(struct v=
irtnet_rq *rq, void *buf, u32 len)
> > > > > >         u32 offset;
> > > > > >         void *head;
> > > > > >
> > > > > > -       if (!rq->do_dma) {
> > > > > > +       if (!virtqueue_get_dma_premapped(rq->vq)) {
> > > > > >                 sg_init_one(rq->sg, buf, len);
> > > > > >                 return;
> > > > > >         }
> > > > > > @@ -526,7 +526,7 @@ static void *virtnet_rq_alloc(struct virtne=
t_rq *rq, u32 size, gfp_t gfp)
> > > > > >
> > > > > >         head =3D page_address(alloc_frag->page);
> > > > > >
> > > > > > -       if (rq->do_dma) {
> > > > > > +       if (virtqueue_get_dma_premapped(rq->vq)) {
> > > > > >                 dma =3D head;
> > > > > >
> > > > > >                 /* new pages */
> > > > > > @@ -580,12 +580,8 @@ static void virtnet_rq_set_premapped(struc=
t virtnet_info *vi)
> > > > > >         if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > > > >                 return;
> > > > > >
> > > > > > -       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > > > -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > > > > > -                       continue;
> > > > > > -
> > > > > > -               vi->rq[i].do_dma =3D true;
> > > > > > -       }
> > > > > > +       for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > > > > +               virtqueue_set_dma_premapped(vi->rq[i].vq);
> > > > > >  }
> > > > > >
> > > > > >  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> > > > > > @@ -1643,7 +1639,7 @@ static int add_recvbuf_small(struct virtn=
et_info *vi, struct virtnet_rq *rq,
> > > > > >
> > > > > >         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf,=
 ctx, gfp);
> > > > > >         if (err < 0) {
> > > > > > -               if (rq->do_dma)
> > > > > > +               if (virtqueue_get_dma_premapped(rq->vq))
> > > > > >                         virtnet_rq_unmap(rq, buf, 0);
> > > > > >                 put_page(virt_to_head_page(buf));
> > > > > >         }
> > > > > > @@ -1758,7 +1754,7 @@ static int add_recvbuf_mergeable(struct v=
irtnet_info *vi,
> > > > > >         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> > > > > >         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf,=
 ctx, gfp);
> > > > > >         if (err < 0) {
> > > > > > -               if (rq->do_dma)
> > > > > > +               if (virtqueue_get_dma_premapped(rq->vq))
> > > > > >                         virtnet_rq_unmap(rq, buf, 0);
> > > > > >                 put_page(virt_to_head_page(buf));
> > > > > >         }
> > > > > > @@ -4007,7 +4003,7 @@ static void free_receive_page_frags(struc=
t virtnet_info *vi)
> > > > > >         int i;
> > > > > >         for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > > > >                 if (vi->rq[i].alloc_frag.page) {
> > > > > > -                       if (vi->rq[i].do_dma && vi->rq[i].last_=
dma)
> > > > > > +                       if (virtqueue_get_dma_premapped(vi->rq[=
i].vq) && vi->rq[i].last_dma)
> > > > > >                                 virtnet_rq_unmap(&vi->rq[i], vi=
->rq[i].last_dma, 0);
> > > > > >                         put_page(vi->rq[i].alloc_frag.page);
> > > > > >                 }
> > > > > > @@ -4035,7 +4031,7 @@ static void virtnet_rq_free_unused_bufs(s=
truct virtqueue *vq)
> > > > > >         rq =3D &vi->rq[i];
> > > > > >
> > > > > >         while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D N=
ULL) {
> > > > > > -               if (rq->do_dma)
> > > > > > +               if (virtqueue_get_dma_premapped(rq->vq))
> > > > > >                         virtnet_rq_unmap(rq, buf, 0);
> > > > > >
> > > > > >                 virtnet_rq_free_buf(vi, rq, buf);
> > > > > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virt=
io/virtio_net.h
> > > > > > index b28a4d0a3150..066a2b9d2b3c 100644
> > > > > > --- a/drivers/net/virtio/virtio_net.h
> > > > > > +++ b/drivers/net/virtio/virtio_net.h
> > > > > > @@ -115,9 +115,6 @@ struct virtnet_rq {
> > > > > >
> > > > > >         /* Record the last dma info to free after new pages is =
allocated. */
> > > > > >         struct virtnet_rq_dma *last_dma;
> > > > > > -
> > > > > > -       /* Do dma by self */
> > > > > > -       bool do_dma;
> > > > > >  };
> > > > > >
> > > > > >  struct virtnet_info {
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virt=
io_ring.c
> > > > > > index 2c5089d3b510..9092bcdebb53 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -2905,6 +2905,28 @@ int virtqueue_set_dma_premapped(struct v=
irtqueue *_vq)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
> > > > > >
> > > > > > +/**
> > > > > > + * virtqueue_get_dma_premapped - get the vring premapped mode
> > > > > > + * @_vq: the struct virtqueue we're talking about.
> > > > > > + *
> > > > > > + * Get the premapped mode of the vq.
> > > > > > + *
> > > > > > + * Returns bool for the vq premapped mode.
> > > > > > + */
> > > > > > +bool virtqueue_get_dma_premapped(struct virtqueue *_vq)
> > > > > > +{
> > > > > > +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > > > +       bool premapped;
> > > > > > +
> > > > > > +       START_USE(vq);
> > > > > > +       premapped =3D vq->premapped;
> > > > > > +       END_USE(vq);
> > > > >
> > > > > Why do we need to protect premapped like this? Is the user allowe=
d to
> > > > > change it on the fly?
> > > >
> > > >
> > > > Just protect before accessing vq.
> > >
> > > I meant how did that differ from other booleans? E.g use_dma_api, do_=
unmap etc.
> >
> > Sorry, maybe I misunderstanded you.
> >
> > Do you mean, should we put "premapped" to the struct virtqueue?
> > Then the user can read/write by the struct virtqueue directly?
> >
> > If that, the reason is that when set premapped, we must check
> > use_dma_api.
>
> I may not be very clear.
>
> I meant why we should protect premapped with START_USE()/END_USER() here.
>
> If it is set once during init_vqs we should not need that.


OK. I see.

Thanks.


>
> Thanks
>

