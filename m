Return-Path: <bpf+bounces-44016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4989D9BC616
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 07:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3E71C21AAF
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 06:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DFE1FCC64;
	Tue,  5 Nov 2024 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tNhl0CGf"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244171714A0;
	Tue,  5 Nov 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789625; cv=none; b=Qtu+lrwO01SKaQsGsSluKc0XYLWCEruU4sKI+LELV3IcoxNrvSxTALnFVlD7POjDq165P1/BC6+Xl6Te5KSj2679e/UV+pxf4IpFeVzusAXPcGBvlas0UEJzCSteOPCRrLGHPCXmq7ynvbWljFnlU6RnHDmIebXmlNKJ281mRVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789625; c=relaxed/simple;
	bh=3g70oboNxf9ic+u/JXav+rhEYJ1+/hLAaKwYFrKxbb0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=iw/XEb2rgYUIszRB/9RhZolG7MyYJKQnLORz39UxCSHNzbigK4Lm9wPDI6xgnJaZhJItm5z5YMcRYurpUpMPULJlY8nlH6S+1lV3TZcIxMppGJ9MvtfwJ9J5lcDEPDNKlya1u7W7RGmeL1G2oehJtucQquVo1rRIYKyoy/ZPWf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tNhl0CGf; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730789613; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=eie5OBxH14u+is3YHNIr3XaDhvx263iB9jHWR5vY3VE=;
	b=tNhl0CGflFfOk2jb5VYmubOLEztB7nc1lOJZ4QfR11obyETj5DK54rEPvjHbhrGooLU7rpJM5ucH4HjAnBoCYfWMcF1uPRiI3Cwa9TmAEot7TJYhr6kEaY60VERCaPWnX43Z4jnmd+cMe3J1YtqXdWAU3FNjCzAtdWPfck4KzTI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIm5lp3_1730789612 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 14:53:33 +0800
Message-ID: <1730789499.0809722-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 02/13] virtio_ring: split: record extras for indirect buffers
Date: Tue, 5 Nov 2024 14:51:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
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
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
 <20241030082453.97310-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtP7tdxxLOtDArNCqO5b=A=a7X2NimK8be2aWuaKG6Xfw@mail.gmail.com>
In-Reply-To: <CACGkMEtP7tdxxLOtDArNCqO5b=A=a7X2NimK8be2aWuaKG6Xfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 5 Nov 2024 11:42:09 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The subsequent commit needs to know whether every indirect buffer is
> > premapped or not. So we need to introduce an extra struct for every
> > indirect buffer to record this info.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 112 ++++++++++++++++-------------------
> >  1 file changed, 52 insertions(+), 60 deletions(-)
>
> Do we have a performance impact for this patch?
>
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 97590c201aa2..dca093744fe1 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -69,7 +69,11 @@
> >
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
> > +       struct vring_desc *indir_desc;
>
> So it looks like we put a descriptor table after the extra table. Can
> this lead to more crossing page mappings for the indirect descriptors?
>
> If yes, it seems expensive so we probably need to make the descriptor
> table come first.

No, the descriptors are before extra table.
So, there is not performance impact.


>
> >  };
> >
> >  struct vring_desc_state_packed {
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
> > @@ -479,22 +465,23 @@ static unsigned int vring_unmap_one_split(const s=
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
> >                                                gfp_t gfp)
> >  {
> > +       struct vring_desc_extra *extra;
> >         struct vring_desc *desc;
> > -       unsigned int i;
> > +       unsigned int i, size;
> >
> >         /*
> >          * We require lowmem mappings for the descriptors because
> > @@ -503,40 +490,41 @@ static struct vring_desc *alloc_indirect_split(st=
ruct virtqueue *_vq,
> >          */
> >         gfp &=3D ~__GFP_HIGHMEM;
> >
> > -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_desc), gfp=
);
> > +       size =3D sizeof(*desc) * total_sg + sizeof(*extra) * total_sg;
> > +
> > +       desc =3D kmalloc(size, gfp);
> >         if (!desc)
> >                 return NULL;
> >
> > +       extra =3D (struct vring_desc_extra *)&desc[total_sg];
> > +
> >         for (i =3D 0; i < total_sg; i++)
> > -               desc[i].next =3D cpu_to_virtio16(_vq->vdev, i + 1);
> > +               extra[i].next =3D i + 1;
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
> > -                                                   u16 flags,
> > -                                                   bool indirect)
> > +                                                   u16 flags)
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
> > +       desc[i].next =3D cpu_to_virtio16(vq->vdev, next);
> >
> >         return next;
> >  }
> > @@ -551,6 +539,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                                       gfp_t gfp)
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> > +       struct vring_desc_extra *extra;
> >         struct scatterlist *sg;
> >         struct vring_desc *desc;
> >         unsigned int i, n, avail, descs_used, prev, err_idx;
> > @@ -586,9 +575,11 @@ static inline int virtqueue_add_split(struct virtq=
ueue *_vq,
> >                 /* Set up rest to use this indirect table. */
> >                 i =3D 0;
> >                 descs_used =3D 1;
> > +               extra =3D (struct vring_desc_extra *)&desc[total_sg];
> >         } else {
> >                 indirect =3D false;
> >                 desc =3D vq->split.vring.desc;
> > +               extra =3D vq->split.desc_extra;
> >                 i =3D head;
> >                 descs_used =3D total_sg;
> >         }
> > @@ -618,9 +609,8 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                         /* Note that we trust indirect descriptor
> >                          * table since it use stream DMA mapping.
> >                          */
> > -                       i =3D virtqueue_add_desc_split(_vq, desc, i, ad=
dr, sg->length,
> > -                                                    VRING_DESC_F_NEXT,
> > -                                                    indirect);
> > +                       i =3D virtqueue_add_desc_split(_vq, desc, extra=
, i, addr, sg->length,
> > +                                                    VRING_DESC_F_NEXT);
> >                 }
> >         }
> >         for (; n < (out_sgs + in_sgs); n++) {
> > @@ -634,11 +624,10 @@ static inline int virtqueue_add_split(struct virt=
queue *_vq,
> >                         /* Note that we trust indirect descriptor
> >                          * table since it use stream DMA mapping.
> >                          */
> > -                       i =3D virtqueue_add_desc_split(_vq, desc, i, ad=
dr,
> > +                       i =3D virtqueue_add_desc_split(_vq, desc, extra=
, i, addr,
> >                                                      sg->length,
> >                                                      VRING_DESC_F_NEXT |
> > -                                                    VRING_DESC_F_WRITE,
> > -                                                    indirect);
> > +                                                    VRING_DESC_F_WRITE=
);
> >                 }
> >         }
> >         /* Last one doesn't continue. */
> > @@ -660,10 +649,10 @@ static inline int virtqueue_add_split(struct virt=
queue *_vq,
> >                 }
> >
> >                 virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> > +                                        vq->split.desc_extra,
> >                                          head, addr,
> >                                          total_sg * sizeof(struct vring=
_desc),
> > -                                        VRING_DESC_F_INDIRECT,
> > -                                        false);
> > +                                        VRING_DESC_F_INDIRECT);
> >         }
> >
> >         /* We're using some buffers from the free list. */
> > @@ -716,11 +705,8 @@ static inline int virtqueue_add_split(struct virtq=
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
> > @@ -765,22 +751,25 @@ static bool virtqueue_kick_prepare_split(struct v=
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
>
> Not sure if I've asked this before. But this part seems to deserve an
> independent fix for -stable.

What fix?

Thanks.

>
> >                 i =3D vq->split.desc_extra[i].next;
> >                 vq->vq.num_free++;
> >         }
> >
> > -       vring_unmap_one_split(vq, i);
> > +       vring_unmap_one_split(vq, &extra[i]);
> >         vq->split.desc_extra[i].next =3D vq->free_head;
> >         vq->free_head =3D head;
> >
> > @@ -790,21 +779,24 @@ static void detach_buf_split(struct vring_virtque=
ue *vq, unsigned int head,
> >         if (vq->indirect) {
> >                 struct vring_desc *indir_desc =3D
> >                                 vq->split.desc_state[head].indir_desc;
> > -               u32 len;
> > +               u32 len, num;
> >
> >                 /* Free the indirect table, if any, now that it's unmap=
ped. */
> >                 if (!indir_desc)
> >                         return;
> > -
> >                 len =3D vq->split.desc_extra[head].len;
> >
> >                 BUG_ON(!(vq->split.desc_extra[head].flags &
> >                                 VRING_DESC_F_INDIRECT));
> >                 BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc));
> >
> > +               num =3D len / sizeof(struct vring_desc);
> > +
> > +               extra =3D (struct vring_desc_extra *)&indir_desc[num];
> > +
> >                 if (vring_need_unmap_buffer(vq)) {
> > -                       for (j =3D 0; j < len / sizeof(struct vring_des=
c); j++)
> > -                               vring_unmap_one_split_indirect(vq, &ind=
ir_desc[j]);
> > +                       for (j =3D 0; j < num; j++)
> > +                               vring_unmap_one_split(vq, &extra[j]);
> >                 }
> >
> >                 kfree(indir_desc);
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>

