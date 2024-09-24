Return-Path: <bpf+bounces-40237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609C8983F28
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 09:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17686282882
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF45C148308;
	Tue, 24 Sep 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXotju9s"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F0145B39
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163316; cv=none; b=ZxopE/IvLF3RyMeze5bFSR6ZTOUlOvYewxhu937qJszWQi3VT0iAsvIPncDqPp+1QnacE+bTx1KiBvsXQW34g6wFteh7qxoKkr/ZfYEI99FqNT8QBj2iODmifWMukvi01W8BTI4HmMhmahFHzAK6NQ/raqBofNy+fY732TEO+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163316; c=relaxed/simple;
	bh=g/PdGsTF9uBLcBlJSjXpjfiBs22DWQecxiBKWXh5j3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlWzxZTtk67WCAP5LznB8LmpYhgbxqsWk/ZVhIEjk4elke3nGyhlppEqTUphAJXnPhE0LB5XtjvV7zhK4L5C/tWntJHVeXui7pzi4EjRvF2MqROaHnC2fE5OGbQ9MPOO5OLdbv6o8CPJaOw3SdSLSeDQKw+6LTQHg5HTmUIT3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXotju9s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEV8l1EiB7QOFW/IhM3VVdNozsdJXLNLZWg2kCGUJd4=;
	b=XXotju9sqg4gS947WfbfXPuRMupXGfQOYApobgGgpgE7JmuvfL47eA3J0UblO8RAj/1fbT
	5n2fVnJxw/rDDRV20QQ1sm4abeTy0vEDvPcqoDu56xhllkRx9mod3x+rUAUMCACaYxzEo5
	92nHJCndnRgNnHSLFPEHULnmut31x+s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-TfQjqpIIPWSqfF_37kbK-w-1; Tue, 24 Sep 2024 03:35:11 -0400
X-MC-Unique: TfQjqpIIPWSqfF_37kbK-w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d8a1e91afaso4876985a91.1
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 00:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163310; x=1727768110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEV8l1EiB7QOFW/IhM3VVdNozsdJXLNLZWg2kCGUJd4=;
        b=Y/kB0eyuzmT9zOS9TtZxq3mYbHFeGQHI6i+9hJomlj7nchiLCqSbnmAH8eY+R5Zg+1
         9SX3sKLP/qtHFTHYklcf3G7vSt6sa59N4P2pb1YQIzjKcQBgPc0WFQ8p1rzbpk2aJVBs
         jsQmJO3eYrgtp4P7WLqrU5jMWamiq0OKT9oS7WUo/FoepQGB3v3cIyI2dWnSB0pWqv95
         LbB2otgBdcScZBPo/4uI2jHeFLxgXJtlIwyO2gkOULmY+1qvAywqeC0Ltp/VRFHXjIuI
         Ps6RkXAL5ySUB8wKc7prNAory4U2+g06h4EHPsmbRWe+c9O0b3LhuVqrkWd33QfPfUTG
         NIIg==
X-Forwarded-Encrypted: i=1; AJvYcCVtDHzvizN96tkorWr61gdrGSshjoQFXefVKt6/5VJbCyJvnH5bwePz9JPYkuJpEP5TrEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb2dM8/hKE8ZYtx/h6kEzdC4ksblvudOkaosZHjO1ThwdRSv4L
	W/0jpu2N9xmUacn9dwGc+StugM7nNeau6qNB2OOLD7C7h6oGryYye9lEmBeIDjLCUS7wMFc6M/T
	c9l9CN2Fh44CKA1ypIy+HVALJJ/19O7CCorYVTgmLLDXGDAdej9AUEKtY3iTOqa4nZrdXsWwKSO
	pdIM0w4CiO3Pnn365Bukiv3yix
X-Received: by 2002:a17:90a:734c:b0:2d8:8d62:a0c with SMTP id 98e67ed59e1d1-2dd80bfd61emr15292632a91.3.1727163310304;
        Tue, 24 Sep 2024 00:35:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgfqeikURZmUla4jRWm36dAbSqJisQu86xWig2Rkf25HaBcMNXSmJDfaOC+dSw1nU7v02KSjpAR1t9KCS5hC8=
X-Received: by 2002:a17:90a:734c:b0:2d8:8d62:a0c with SMTP id
 98e67ed59e1d1-2dd80bfd61emr15292618a91.3.1727163309749; Tue, 24 Sep 2024
 00:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com> <20240924013204.13763-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240924013204.13763-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Sep 2024 15:34:57 +0800
Message-ID: <CACGkMEsfqOZ6sDzvwMz2Hy5w8NtsK+CZRZRnuEVy_jhXTMsCyw@mail.gmail.com>
Subject: Re: [RFC net-next v1 02/12] virtio_ring: split: record extras for
 indirect buffers
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The subsequent commit needs to know whether every indirect buffer is
> premapped or not. So we need to introduce an extra struct for every
> indirect buffer to record this info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 126 +++++++++++++++++------------------
>  1 file changed, 61 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 228e9fbcba3f..62901bee97c0 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -67,9 +67,20 @@
>  #define LAST_ADD_TIME_INVALID(vq)
>  #endif
>
> +struct vring_desc_extra {
> +       dma_addr_t addr;                /* Descriptor DMA addr. */
> +       u32 len;                        /* Descriptor length. */
> +       u16 flags;                      /* Descriptor flags. */
> +       u16 next;                       /* The next desc state in a list.=
 */
> +};
> +
>  struct vring_desc_state_split {
>         void *data;                     /* Data for callback. */
> -       struct vring_desc *indir_desc;  /* Indirect descriptor, if any. *=
/
> +
> +       /* Indirect extra table and desc table, if any. These two will be
> +        * allocated together. So we won't stress more to the memory allo=
cator.
> +        */
> +       struct vring_desc_extra *indir;
>  };
>
>  struct vring_desc_state_packed {
> @@ -79,13 +90,6 @@ struct vring_desc_state_packed {
>         u16 last;                       /* The last desc state in a list.=
 */
>  };
>
> -struct vring_desc_extra {
> -       dma_addr_t addr;                /* Descriptor DMA addr. */
> -       u32 len;                        /* Descriptor length. */
> -       u16 flags;                      /* Descriptor flags. */
> -       u16 next;                       /* The next desc state in a list.=
 */
> -};
> -
>  struct vring_virtqueue_split {
>         /* Actual memory layout for this queue. */
>         struct vring vring;
> @@ -440,38 +444,20 @@ static void virtqueue_init(struct vring_virtqueue *=
vq, u32 num)
>   * Split ring specific functions - *_split().
>   */
>
> -static void vring_unmap_one_split_indirect(const struct vring_virtqueue =
*vq,
> -                                          const struct vring_desc *desc)
> -{
> -       u16 flags;
> -
> -       if (!vring_need_unmap_buffer(vq))
> -               return;
> -
> -       flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
> -
> -       dma_unmap_page(vring_dma_dev(vq),
> -                      virtio64_to_cpu(vq->vq.vdev, desc->addr),
> -                      virtio32_to_cpu(vq->vq.vdev, desc->len),
> -                      (flags & VRING_DESC_F_WRITE) ?
> -                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -}
> -
>  static unsigned int vring_unmap_one_split(const struct vring_virtqueue *=
vq,
> -                                         unsigned int i)
> +                                         struct vring_desc_extra *extra)
>  {
> -       struct vring_desc_extra *extra =3D vq->split.desc_extra;
>         u16 flags;
>
> -       flags =3D extra[i].flags;
> +       flags =3D extra->flags;
>
>         if (flags & VRING_DESC_F_INDIRECT) {
>                 if (!vq->use_dma_api)
>                         goto out;
>
>                 dma_unmap_single(vring_dma_dev(vq),
> -                                extra[i].addr,
> -                                extra[i].len,
> +                                extra->addr,
> +                                extra->len,
>                                  (flags & VRING_DESC_F_WRITE) ?
>                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         } else {
> @@ -479,20 +465,22 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
>                         goto out;
>
>                 dma_unmap_page(vring_dma_dev(vq),
> -                              extra[i].addr,
> -                              extra[i].len,
> +                              extra->addr,
> +                              extra->len,
>                                (flags & VRING_DESC_F_WRITE) ?
>                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         }
>
>  out:
> -       return extra[i].next;
> +       return extra->next;
>  }
>
>  static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
>                                                unsigned int total_sg,
> +                                              struct vring_desc_extra **=
pextra,

This kind of API seems a little bit strange. In the caller we had:

if (desc) {
...
} else {
extra =3D vq->split.desc_extra;
}

I'd move the assignment of the extra there to make the code more readable.

>                                                gfp_t gfp)
>  {
> +       struct vring_desc_extra *extra;
>         struct vring_desc *desc;
>         unsigned int i;
>
> @@ -503,40 +491,45 @@ static struct vring_desc *alloc_indirect_split(stru=
ct virtqueue *_vq,
>          */
>         gfp &=3D ~__GFP_HIGHMEM;
>
> -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
> -       if (!desc)
> +       extra =3D kmalloc_array(total_sg, sizeof(*desc) + sizeof(*extra),=
 gfp);

I'd suggest using kmalloc() directly, as it seems not an array where
each descriptor is followed by one extra.

> +       if (!extra)
>                 return NULL;
>
> -       for (i =3D 0; i < total_sg; i++)
> +       desc =3D (struct vring_desc *)&extra[total_sg];

Still seems strange, I would rather make the descriptor come first
then. This makes code more readable. And we can keep the indir_desc
variable name.

> +
> +       for (i =3D 0; i < total_sg; i++) {
>                 desc[i].next =3D cpu_to_virtio16(_vq->vdev, i + 1);
> +               extra[i].next =3D i + 1;
> +       }
> +
> +       *pextra =3D extra;
> +
>         return desc;
>  }
>
>  static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq=
,
>                                                     struct vring_desc *de=
sc,
> +                                                   struct vring_desc_ext=
ra *extra,
>                                                     unsigned int i,
>                                                     dma_addr_t addr,
>                                                     unsigned int len,
>                                                     u16 flags,
>                                                     bool indirect)
>  {
> -       struct vring_virtqueue *vring =3D to_vvq(vq);
> -       struct vring_desc_extra *extra =3D vring->split.desc_extra;
>         u16 next;
>
>         desc[i].flags =3D cpu_to_virtio16(vq->vdev, flags);
>         desc[i].addr =3D cpu_to_virtio64(vq->vdev, addr);
>         desc[i].len =3D cpu_to_virtio32(vq->vdev, len);
>
> -       if (!indirect) {
> -               next =3D extra[i].next;
> -               desc[i].next =3D cpu_to_virtio16(vq->vdev, next);
> +       extra[i].addr =3D addr;
> +       extra[i].len =3D len;
> +       extra[i].flags =3D flags;
> +
> +       next =3D extra[i].next;
>
> -               extra[i].addr =3D addr;
> -               extra[i].len =3D len;
> -               extra[i].flags =3D flags;
> -       } else
> -               next =3D virtio16_to_cpu(vq->vdev, desc[i].next);
> +       if (!indirect)
> +               desc[i].next =3D cpu_to_virtio16(vq->vdev, next);

Any chance we can remove the check for indirect here? For example,
remove the assignment in alloc_indirect_split(). This would be more
consistent with the way when we want to use desc_extra for both
indirect and direct descriptors.

>
>         return next;
>  }
> @@ -551,6 +544,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                                       gfp_t gfp)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       struct vring_desc_extra *extra;
>         struct scatterlist *sg;
>         struct vring_desc *desc;
>         unsigned int i, n, avail, descs_used, prev, err_idx;
> @@ -574,7 +568,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         head =3D vq->free_head;
>
>         if (virtqueue_use_indirect(vq, total_sg))
> -               desc =3D alloc_indirect_split(_vq, total_sg, gfp);
> +               desc =3D alloc_indirect_split(_vq, total_sg, &extra, gfp)=
;
>         else {
>                 desc =3D NULL;
>                 WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indir=
ect);
> @@ -589,6 +583,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         } else {
>                 indirect =3D false;
>                 desc =3D vq->split.vring.desc;
> +               extra =3D vq->split.desc_extra;
>                 i =3D head;
>                 descs_used =3D total_sg;
>         }
> @@ -618,7 +613,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
> -                       i =3D virtqueue_add_desc_split(_vq, desc, i, addr=
, sg->length,
> +                       i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr, sg->length,
>                                                      VRING_DESC_F_NEXT,
>                                                      indirect);
>                 }
> @@ -634,7 +629,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
> -                       i =3D virtqueue_add_desc_split(_vq, desc, i, addr=
,
> +                       i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr,
>                                                      sg->length,
>                                                      VRING_DESC_F_NEXT |
>                                                      VRING_DESC_F_WRITE,
> @@ -660,6 +655,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                 }
>
>                 virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> +                                        vq->split.desc_extra,
>                                          head, addr,
>                                          total_sg * sizeof(struct vring_d=
esc),
>                                          VRING_DESC_F_INDIRECT,
> @@ -678,9 +674,9 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         /* Store token and indirect buffer state. */
>         vq->split.desc_state[head].data =3D data;
>         if (indirect)
> -               vq->split.desc_state[head].indir_desc =3D desc;
> +               vq->split.desc_state[head].indir =3D extra;
>         else
> -               vq->split.desc_state[head].indir_desc =3D ctx;
> +               vq->split.desc_state[head].indir =3D ctx;
>
>         /* Put entry in available array (but don't update avail->idx unti=
l they
>          * do sync). */
> @@ -716,11 +712,8 @@ static inline int virtqueue_add_split(struct virtque=
ue *_vq,
>         for (n =3D 0; n < total_sg; n++) {
>                 if (i =3D=3D err_idx)
>                         break;
> -               if (indirect) {
> -                       vring_unmap_one_split_indirect(vq, &desc[i]);
> -                       i =3D virtio16_to_cpu(_vq->vdev, desc[i].next);
> -               } else
> -                       i =3D vring_unmap_one_split(vq, i);
> +
> +               i =3D vring_unmap_one_split(vq, &extra[i]);
>         }
>
>  free_indirect:
> @@ -765,22 +758,25 @@ static bool virtqueue_kick_prepare_split(struct vir=
tqueue *_vq)
>  static void detach_buf_split(struct vring_virtqueue *vq, unsigned int he=
ad,
>                              void **ctx)
>  {
> +       struct vring_desc_extra *extra;
>         unsigned int i, j;
>         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F=
_NEXT);
>
>         /* Clear data ptr. */
>         vq->split.desc_state[head].data =3D NULL;
>
> +       extra =3D vq->split.desc_extra;
> +
>         /* Put back on free list: unmap first-level descriptors and find =
end */
>         i =3D head;
>
>         while (vq->split.vring.desc[i].flags & nextflag) {
> -               vring_unmap_one_split(vq, i);
> +               vring_unmap_one_split(vq, &extra[i]);
>                 i =3D vq->split.desc_extra[i].next;
>                 vq->vq.num_free++;
>         }
>
> -       vring_unmap_one_split(vq, i);
> +       vring_unmap_one_split(vq, &extra[i]);
>         vq->split.desc_extra[i].next =3D vq->free_head;
>         vq->free_head =3D head;
>
> @@ -788,12 +784,12 @@ static void detach_buf_split(struct vring_virtqueue=
 *vq, unsigned int head,
>         vq->vq.num_free++;
>
>         if (vq->indirect) {
> -               struct vring_desc *indir_desc =3D
> -                               vq->split.desc_state[head].indir_desc;
>                 u32 len;
>
> +               extra =3D vq->split.desc_state[head].indir;
> +
>                 /* Free the indirect table, if any, now that it's unmappe=
d. */
> -               if (!indir_desc)
> +               if (!extra)
>                         return;
>
>                 len =3D vq->split.desc_extra[head].len;
> @@ -804,13 +800,13 @@ static void detach_buf_split(struct vring_virtqueue=
 *vq, unsigned int head,
>
>                 if (vring_need_unmap_buffer(vq)) {
>                         for (j =3D 0; j < len / sizeof(struct vring_desc)=
; j++)
> -                               vring_unmap_one_split_indirect(vq, &indir=
_desc[j]);
> +                               vring_unmap_one_split(vq, &extra[j]);
>                 }
>
> -               kfree(indir_desc);
> -               vq->split.desc_state[head].indir_desc =3D NULL;
> +               kfree(extra);
> +               vq->split.desc_state[head].indir =3D NULL;
>         } else if (ctx) {
> -               *ctx =3D vq->split.desc_state[head].indir_desc;
> +               *ctx =3D vq->split.desc_state[head].indir;
>         }
>  }
>
> --
> 2.32.0.3.g01195cf9f
>

Thanks


