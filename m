Return-Path: <bpf+bounces-40245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0575398408A
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 10:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E0FB21783
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 08:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DD714D283;
	Tue, 24 Sep 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CtDO6FwC"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735014286;
	Tue, 24 Sep 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166762; cv=none; b=Ul/J27XYRfZMbBDvcyVy4KlUsego+KRADlG1x6VkPuomjVkEAHV4/7BHTYOpRGc9pqmLCtCYROLnKo5o/bS/JZfi9Fj8S/jd04w+5hhi8+oSYHAV4exvQcz1MpIBlwVOFfFVJXbv84HbxE7FblnleABMNrdzsYLuZZSA8qXe4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166762; c=relaxed/simple;
	bh=LY91Iu2NuynBjwcZ2uVniE4kXIzqBx93I00doiTNWM8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=HJRyVh4I7e7ZHlQUU7Wvs5OLk8Y/TROamV2slpabjQBWgVuzix42Q7RJh6TIiZhOhOfwlBG+muvwnnfzEdevU/g9lKl3ESxSedMV0TM5x9fLsMawZy1VnJlfktw1SC915bqmmhR2YZ4TjK4QHBr4FcM9ONfeOM65rAbuaEIgcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CtDO6FwC; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727166757; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=jX8gDAm2sULz1lUxo8UtQjcn8ilkMlml7DhJscPUXx8=;
	b=CtDO6FwCDVsMNWOe9LlDOwGBOTK4TEzsy+V+d26fQlZmt4bXrgy/A8EdOPYl/gSNbmc33JolhJJDjbk8aZEjNrgODgECw26+11nzI0LCEYm9nScZl3kpR5lxvuEsTbrfymMnRPCoZNd5nxTi7RA5U34DKZ+lWZIgUIrddmBL66A=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFfTLjk_1727166755)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 16:32:36 +0800
Message-ID: <1727166724.3220332-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next v1 02/12] virtio_ring: split: record extras for indirect buffers
Date: Tue, 24 Sep 2024 16:32:04 +0800
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
 <20240924013204.13763-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEsfqOZ6sDzvwMz2Hy5w8NtsK+CZRZRnuEVy_jhXTMsCyw@mail.gmail.com>
In-Reply-To: <CACGkMEsfqOZ6sDzvwMz2Hy5w8NtsK+CZRZRnuEVy_jhXTMsCyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Will fix for all commets in next version.

Thanks.

On Tue, 24 Sep 2024 15:34:57 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The subsequent commit needs to know whether every indirect buffer is
> > premapped or not. So we need to introduce an extra struct for every
> > indirect buffer to record this info.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 126 +++++++++++++++++------------------
> >  1 file changed, 61 insertions(+), 65 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 228e9fbcba3f..62901bee97c0 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -67,9 +67,20 @@
> >  #define LAST_ADD_TIME_INVALID(vq)
> >  #endif
> >
> > +struct vring_desc_extra {
> > +       dma_addr_t addr;                /* Descriptor DMA addr. */
> > +       u32 len;                        /* Descriptor length. */
> > +       u16 flags;                      /* Descriptor flags. */
> > +       u16 next;                       /* The next desc state in a lis=
t. */
> > +};
> > +
> >  struct vring_desc_state_split {
> >         void *data;                     /* Data for callback. */
> > -       struct vring_desc *indir_desc;  /* Indirect descriptor, if any.=
 */
> > +
> > +       /* Indirect extra table and desc table, if any. These two will =
be
> > +        * allocated together. So we won't stress more to the memory al=
locator.
> > +        */
> > +       struct vring_desc_extra *indir;
> >  };
> >
> >  struct vring_desc_state_packed {
> > @@ -79,13 +90,6 @@ struct vring_desc_state_packed {
> >         u16 last;                       /* The last desc state in a lis=
t. */
> >  };
> >
> > -struct vring_desc_extra {
> > -       dma_addr_t addr;                /* Descriptor DMA addr. */
> > -       u32 len;                        /* Descriptor length. */
> > -       u16 flags;                      /* Descriptor flags. */
> > -       u16 next;                       /* The next desc state in a lis=
t. */
> > -};
> > -
> >  struct vring_virtqueue_split {
> >         /* Actual memory layout for this queue. */
> >         struct vring vring;
> > @@ -440,38 +444,20 @@ static void virtqueue_init(struct vring_virtqueue=
 *vq, u32 num)
> >   * Split ring specific functions - *_split().
> >   */
> >
> > -static void vring_unmap_one_split_indirect(const struct vring_virtqueu=
e *vq,
> > -                                          const struct vring_desc *des=
c)
> > -{
> > -       u16 flags;
> > -
> > -       if (!vring_need_unmap_buffer(vq))
> > -               return;
> > -
> > -       flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
> > -
> > -       dma_unmap_page(vring_dma_dev(vq),
> > -                      virtio64_to_cpu(vq->vq.vdev, desc->addr),
> > -                      virtio32_to_cpu(vq->vq.vdev, desc->len),
> > -                      (flags & VRING_DESC_F_WRITE) ?
> > -                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > -}
> > -
> >  static unsigned int vring_unmap_one_split(const struct vring_virtqueue=
 *vq,
> > -                                         unsigned int i)
> > +                                         struct vring_desc_extra *extr=
a)
> >  {
> > -       struct vring_desc_extra *extra =3D vq->split.desc_extra;
> >         u16 flags;
> >
> > -       flags =3D extra[i].flags;
> > +       flags =3D extra->flags;
> >
> >         if (flags & VRING_DESC_F_INDIRECT) {
> >                 if (!vq->use_dma_api)
> >                         goto out;
> >
> >                 dma_unmap_single(vring_dma_dev(vq),
> > -                                extra[i].addr,
> > -                                extra[i].len,
> > +                                extra->addr,
> > +                                extra->len,
> >                                  (flags & VRING_DESC_F_WRITE) ?
> >                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >         } else {
> > @@ -479,20 +465,22 @@ static unsigned int vring_unmap_one_split(const s=
truct vring_virtqueue *vq,
> >                         goto out;
> >
> >                 dma_unmap_page(vring_dma_dev(vq),
> > -                              extra[i].addr,
> > -                              extra[i].len,
> > +                              extra->addr,
> > +                              extra->len,
> >                                (flags & VRING_DESC_F_WRITE) ?
> >                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >         }
> >
> >  out:
> > -       return extra[i].next;
> > +       return extra->next;
> >  }
> >
> >  static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> >                                                unsigned int total_sg,
> > +                                              struct vring_desc_extra =
**pextra,
>
> This kind of API seems a little bit strange. In the caller we had:
>
> if (desc) {
> ...
> } else {
> extra =3D vq->split.desc_extra;
> }
>
> I'd move the assignment of the extra there to make the code more readable.
>
> >                                                gfp_t gfp)
> >  {
> > +       struct vring_desc_extra *extra;
> >         struct vring_desc *desc;
> >         unsigned int i;
> >
> > @@ -503,40 +491,45 @@ static struct vring_desc *alloc_indirect_split(st=
ruct virtqueue *_vq,
> >          */
> >         gfp &=3D ~__GFP_HIGHMEM;
> >
> > -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_desc), gfp=
);
> > -       if (!desc)
> > +       extra =3D kmalloc_array(total_sg, sizeof(*desc) + sizeof(*extra=
), gfp);
>
> I'd suggest using kmalloc() directly, as it seems not an array where
> each descriptor is followed by one extra.
>
> > +       if (!extra)
> >                 return NULL;
> >
> > -       for (i =3D 0; i < total_sg; i++)
> > +       desc =3D (struct vring_desc *)&extra[total_sg];
>
> Still seems strange, I would rather make the descriptor come first
> then. This makes code more readable. And we can keep the indir_desc
> variable name.
>
> > +
> > +       for (i =3D 0; i < total_sg; i++) {
> >                 desc[i].next =3D cpu_to_virtio16(_vq->vdev, i + 1);
> > +               extra[i].next =3D i + 1;
> > +       }
> > +
> > +       *pextra =3D extra;
> > +
> >         return desc;
> >  }
> >
> >  static inline unsigned int virtqueue_add_desc_split(struct virtqueue *=
vq,
> >                                                     struct vring_desc *=
desc,
> > +                                                   struct vring_desc_e=
xtra *extra,
> >                                                     unsigned int i,
> >                                                     dma_addr_t addr,
> >                                                     unsigned int len,
> >                                                     u16 flags,
> >                                                     bool indirect)
> >  {
> > -       struct vring_virtqueue *vring =3D to_vvq(vq);
> > -       struct vring_desc_extra *extra =3D vring->split.desc_extra;
> >         u16 next;
> >
> >         desc[i].flags =3D cpu_to_virtio16(vq->vdev, flags);
> >         desc[i].addr =3D cpu_to_virtio64(vq->vdev, addr);
> >         desc[i].len =3D cpu_to_virtio32(vq->vdev, len);
> >
> > -       if (!indirect) {
> > -               next =3D extra[i].next;
> > -               desc[i].next =3D cpu_to_virtio16(vq->vdev, next);
> > +       extra[i].addr =3D addr;
> > +       extra[i].len =3D len;
> > +       extra[i].flags =3D flags;
> > +
> > +       next =3D extra[i].next;
> >
> > -               extra[i].addr =3D addr;
> > -               extra[i].len =3D len;
> > -               extra[i].flags =3D flags;
> > -       } else
> > -               next =3D virtio16_to_cpu(vq->vdev, desc[i].next);
> > +       if (!indirect)
> > +               desc[i].next =3D cpu_to_virtio16(vq->vdev, next);
>
> Any chance we can remove the check for indirect here? For example,
> remove the assignment in alloc_indirect_split(). This would be more
> consistent with the way when we want to use desc_extra for both
> indirect and direct descriptors.
>
> >
> >         return next;
> >  }
> > @@ -551,6 +544,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                                       gfp_t gfp)
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> > +       struct vring_desc_extra *extra;
> >         struct scatterlist *sg;
> >         struct vring_desc *desc;
> >         unsigned int i, n, avail, descs_used, prev, err_idx;
> > @@ -574,7 +568,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >         head =3D vq->free_head;
> >
> >         if (virtqueue_use_indirect(vq, total_sg))
> > -               desc =3D alloc_indirect_split(_vq, total_sg, gfp);
> > +               desc =3D alloc_indirect_split(_vq, total_sg, &extra, gf=
p);
> >         else {
> >                 desc =3D NULL;
> >                 WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->ind=
irect);
> > @@ -589,6 +583,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >         } else {
> >                 indirect =3D false;
> >                 desc =3D vq->split.vring.desc;
> > +               extra =3D vq->split.desc_extra;
> >                 i =3D head;
> >                 descs_used =3D total_sg;
> >         }
> > @@ -618,7 +613,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                         /* Note that we trust indirect descriptor
> >                          * table since it use stream DMA mapping.
> >                          */
> > -                       i =3D virtqueue_add_desc_split(_vq, desc, i, ad=
dr, sg->length,
> > +                       i =3D virtqueue_add_desc_split(_vq, desc, extra=
, i, addr, sg->length,
> >                                                      VRING_DESC_F_NEXT,
> >                                                      indirect);
> >                 }
> > @@ -634,7 +629,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                         /* Note that we trust indirect descriptor
> >                          * table since it use stream DMA mapping.
> >                          */
> > -                       i =3D virtqueue_add_desc_split(_vq, desc, i, ad=
dr,
> > +                       i =3D virtqueue_add_desc_split(_vq, desc, extra=
, i, addr,
> >                                                      sg->length,
> >                                                      VRING_DESC_F_NEXT |
> >                                                      VRING_DESC_F_WRITE,
> > @@ -660,6 +655,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                 }
> >
> >                 virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> > +                                        vq->split.desc_extra,
> >                                          head, addr,
> >                                          total_sg * sizeof(struct vring=
_desc),
> >                                          VRING_DESC_F_INDIRECT,
> > @@ -678,9 +674,9 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >         /* Store token and indirect buffer state. */
> >         vq->split.desc_state[head].data =3D data;
> >         if (indirect)
> > -               vq->split.desc_state[head].indir_desc =3D desc;
> > +               vq->split.desc_state[head].indir =3D extra;
> >         else
> > -               vq->split.desc_state[head].indir_desc =3D ctx;
> > +               vq->split.desc_state[head].indir =3D ctx;
> >
> >         /* Put entry in available array (but don't update avail->idx un=
til they
> >          * do sync). */
> > @@ -716,11 +712,8 @@ static inline int virtqueue_add_split(struct virtq=
ueue *_vq,
> >         for (n =3D 0; n < total_sg; n++) {
> >                 if (i =3D=3D err_idx)
> >                         break;
> > -               if (indirect) {
> > -                       vring_unmap_one_split_indirect(vq, &desc[i]);
> > -                       i =3D virtio16_to_cpu(_vq->vdev, desc[i].next);
> > -               } else
> > -                       i =3D vring_unmap_one_split(vq, i);
> > +
> > +               i =3D vring_unmap_one_split(vq, &extra[i]);
> >         }
> >
> >  free_indirect:
> > @@ -765,22 +758,25 @@ static bool virtqueue_kick_prepare_split(struct v=
irtqueue *_vq)
> >  static void detach_buf_split(struct vring_virtqueue *vq, unsigned int =
head,
> >                              void **ctx)
> >  {
> > +       struct vring_desc_extra *extra;
> >         unsigned int i, j;
> >         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DESC=
_F_NEXT);
> >
> >         /* Clear data ptr. */
> >         vq->split.desc_state[head].data =3D NULL;
> >
> > +       extra =3D vq->split.desc_extra;
> > +
> >         /* Put back on free list: unmap first-level descriptors and fin=
d end */
> >         i =3D head;
> >
> >         while (vq->split.vring.desc[i].flags & nextflag) {
> > -               vring_unmap_one_split(vq, i);
> > +               vring_unmap_one_split(vq, &extra[i]);
> >                 i =3D vq->split.desc_extra[i].next;
> >                 vq->vq.num_free++;
> >         }
> >
> > -       vring_unmap_one_split(vq, i);
> > +       vring_unmap_one_split(vq, &extra[i]);
> >         vq->split.desc_extra[i].next =3D vq->free_head;
> >         vq->free_head =3D head;
> >
> > @@ -788,12 +784,12 @@ static void detach_buf_split(struct vring_virtque=
ue *vq, unsigned int head,
> >         vq->vq.num_free++;
> >
> >         if (vq->indirect) {
> > -               struct vring_desc *indir_desc =3D
> > -                               vq->split.desc_state[head].indir_desc;
> >                 u32 len;
> >
> > +               extra =3D vq->split.desc_state[head].indir;
> > +
> >                 /* Free the indirect table, if any, now that it's unmap=
ped. */
> > -               if (!indir_desc)
> > +               if (!extra)
> >                         return;
> >
> >                 len =3D vq->split.desc_extra[head].len;
> > @@ -804,13 +800,13 @@ static void detach_buf_split(struct vring_virtque=
ue *vq, unsigned int head,
> >
> >                 if (vring_need_unmap_buffer(vq)) {
> >                         for (j =3D 0; j < len / sizeof(struct vring_des=
c); j++)
> > -                               vring_unmap_one_split_indirect(vq, &ind=
ir_desc[j]);
> > +                               vring_unmap_one_split(vq, &extra[j]);
> >                 }
> >
> > -               kfree(indir_desc);
> > -               vq->split.desc_state[head].indir_desc =3D NULL;
> > +               kfree(extra);
> > +               vq->split.desc_state[head].indir =3D NULL;
> >         } else if (ctx) {
> > -               *ctx =3D vq->split.desc_state[head].indir_desc;
> > +               *ctx =3D vq->split.desc_state[head].indir;
> >         }
> >  }
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>
>

