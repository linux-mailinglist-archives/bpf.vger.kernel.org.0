Return-Path: <bpf+bounces-43999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C42F9BC3F8
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 04:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A98F1F21DF7
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 03:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC6183CC9;
	Tue,  5 Nov 2024 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeqLnHPr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E503C39
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730778147; cv=none; b=oTM+LyUPZjhfGUwSMmxOsuokzo+wvZpOcVnt8Q9iNN5kucC0K7fxXmXhORcdsVqo67+WZJpdOCyuOzIeCGuuoy0Cvj9LAW5tIxAomfP171kV/24AQteHQtJkl4xdWef4eLy8EhTYNsCJiRxtCICdQP/+/u/fA6UDzUa8Foo6ltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730778147; c=relaxed/simple;
	bh=ygegP4/EZoqtocpMOZdBPIHwz+SNXnXFjP+cUm9YUVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGtgr2uxysoxt/Ab+NiFEHxVgB6X0OGjrRLE++qIWCWLQ/f3eNW6dZh3zrxsxaEVrG3POJnZXmxwfcCEbKGGhASdlAqX7gEbFRIhl4wWY4lwLRVReLUslWRLEVkm3/9ckHLeN47ivF53eJXAdbNq5IxNomrA+8nZo5jiQtG0leg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EeqLnHPr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730778144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyxHlyIyRzdEB3EvTChHeDLyL5KwnAWLFwDJsqk/g3Q=;
	b=EeqLnHPr2jHJ54Rq4tfKmaocPjHmHpihuoDboJ/xZYdsDtQombd3BaQ9xUvm3MHqC/zugx
	JcjHogHg39OrQfB7/2p+GOMkXHbOLeTg+o4D2SA3bgueMKs4gIs1dHIJ0pME8TFkorl3BM
	8lOufUQegYfcEwcHuGhr0mN2OqF0bQE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-x5CB24U8MaO0EEePCyE2vA-1; Mon, 04 Nov 2024 22:42:23 -0500
X-MC-Unique: x5CB24U8MaO0EEePCyE2vA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e2eba0efc6so4797121a91.3
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 19:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730778142; x=1731382942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyxHlyIyRzdEB3EvTChHeDLyL5KwnAWLFwDJsqk/g3Q=;
        b=cgsRMJ6GNlEbX01BMHWoR6dDQRIZRJmfY2n7Gd8KRKrgdBb99zUHItFrjvyShrNmn3
         6A3xkzCzwcuEYX/wQ5+/lf3oWnPVOQnHaLw+WK+GgEuuMCF0J/5/IjRwfNrXRdsU5ueV
         dFzL3xL5jVJxouaD9JVc8JMmCVIx556Hp/i+wru8HY6sJCcy+3FXzw7HvkOGp0ulm3pX
         WZbh3GvYnrNGGDUj/DnZ8ULYB+fpByGJ/dSWsY0mPw0nx5e3xxlgkMCp3LMHArHpzl8t
         1WLiJUNYfBm5CA/6g4m+/CVr0xbQmGiAqtAxHvCtXUpYVSqpKB+8N0+tt60mL2FYiAnX
         pvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoR/iCvM97d0QA+oFNYHLhz7Q2HLjlCT5or6sCR0jyJVClSZ2dpOKD9lHUyvcK+hZDy+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAyvqejBMRGGzpT6BJ3d2ZbLhRQH7fyQtWYVsO0JFIy1zntpG
	OL8D6O36K1hbcOUc6sEqPQIm/r5deP5GHYapGEElEO0V7CRpJSsxiTanuS2F7KfpgVJTOcg5l/V
	OKwNGj6nUlKC0YkXHDmdXXMyCOBp6dDl4A9pBakL9yslSSlGwzKDRR9xxZs4xiDDlxMQCWu+3z5
	iaN8Mllf3F5GxTzAj4Gsa1xzbU
X-Received: by 2002:a17:90b:1a90:b0:2e2:f044:caaa with SMTP id 98e67ed59e1d1-2e94c52a9c3mr22236463a91.37.1730778141669;
        Mon, 04 Nov 2024 19:42:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEKKE4AkzhqLs89skeBOJ9+eTo4h/Ix2m898YS3Im1U5+6nobYHvuGr4+eAwz1uNaLTMgkDLamsWwIszH96eY=
X-Received: by 2002:a17:90b:1a90:b0:2e2:f044:caaa with SMTP id
 98e67ed59e1d1-2e94c52a9c3mr22236414a91.37.1730778141095; Mon, 04 Nov 2024
 19:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com> <20241030082453.97310-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241030082453.97310-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 11:42:09 +0800
Message-ID: <CACGkMEtP7tdxxLOtDArNCqO5b=A=a7X2NimK8be2aWuaKG6Xfw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/13] virtio_ring: split: record extras for
 indirect buffers
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The subsequent commit needs to know whether every indirect buffer is
> premapped or not. So we need to introduce an extra struct for every
> indirect buffer to record this info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 112 ++++++++++++++++-------------------
>  1 file changed, 52 insertions(+), 60 deletions(-)

Do we have a performance impact for this patch?

>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 97590c201aa2..dca093744fe1 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -69,7 +69,11 @@
>
>  struct vring_desc_state_split {
>         void *data;                     /* Data for callback. */
> -       struct vring_desc *indir_desc;  /* Indirect descriptor, if any. *=
/
> +
> +       /* Indirect extra table and desc table, if any. These two will be
> +        * allocated together. So we won't stress more to the memory allo=
cator.
> +        */
> +       struct vring_desc *indir_desc;

So it looks like we put a descriptor table after the extra table. Can
this lead to more crossing page mappings for the indirect descriptors?

If yes, it seems expensive so we probably need to make the descriptor
table come first.

>  };
>
>  struct vring_desc_state_packed {
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
> @@ -479,22 +465,23 @@ static unsigned int vring_unmap_one_split(const str=
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
>                                                gfp_t gfp)
>  {
> +       struct vring_desc_extra *extra;
>         struct vring_desc *desc;
> -       unsigned int i;
> +       unsigned int i, size;
>
>         /*
>          * We require lowmem mappings for the descriptors because
> @@ -503,40 +490,41 @@ static struct vring_desc *alloc_indirect_split(stru=
ct virtqueue *_vq,
>          */
>         gfp &=3D ~__GFP_HIGHMEM;
>
> -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
> +       size =3D sizeof(*desc) * total_sg + sizeof(*extra) * total_sg;
> +
> +       desc =3D kmalloc(size, gfp);
>         if (!desc)
>                 return NULL;
>
> +       extra =3D (struct vring_desc_extra *)&desc[total_sg];
> +
>         for (i =3D 0; i < total_sg; i++)
> -               desc[i].next =3D cpu_to_virtio16(_vq->vdev, i + 1);
> +               extra[i].next =3D i + 1;
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
> -                                                   u16 flags,
> -                                                   bool indirect)
> +                                                   u16 flags)
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
> +       desc[i].next =3D cpu_to_virtio16(vq->vdev, next);
>
>         return next;
>  }
> @@ -551,6 +539,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                                       gfp_t gfp)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       struct vring_desc_extra *extra;
>         struct scatterlist *sg;
>         struct vring_desc *desc;
>         unsigned int i, n, avail, descs_used, prev, err_idx;
> @@ -586,9 +575,11 @@ static inline int virtqueue_add_split(struct virtque=
ue *_vq,
>                 /* Set up rest to use this indirect table. */
>                 i =3D 0;
>                 descs_used =3D 1;
> +               extra =3D (struct vring_desc_extra *)&desc[total_sg];
>         } else {
>                 indirect =3D false;
>                 desc =3D vq->split.vring.desc;
> +               extra =3D vq->split.desc_extra;
>                 i =3D head;
>                 descs_used =3D total_sg;
>         }
> @@ -618,9 +609,8 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
> -                       i =3D virtqueue_add_desc_split(_vq, desc, i, addr=
, sg->length,
> -                                                    VRING_DESC_F_NEXT,
> -                                                    indirect);
> +                       i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr, sg->length,
> +                                                    VRING_DESC_F_NEXT);
>                 }
>         }
>         for (; n < (out_sgs + in_sgs); n++) {
> @@ -634,11 +624,10 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
> -                       i =3D virtqueue_add_desc_split(_vq, desc, i, addr=
,
> +                       i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr,
>                                                      sg->length,
>                                                      VRING_DESC_F_NEXT |
> -                                                    VRING_DESC_F_WRITE,
> -                                                    indirect);
> +                                                    VRING_DESC_F_WRITE);
>                 }
>         }
>         /* Last one doesn't continue. */
> @@ -660,10 +649,10 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                 }
>
>                 virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> +                                        vq->split.desc_extra,
>                                          head, addr,
>                                          total_sg * sizeof(struct vring_d=
esc),
> -                                        VRING_DESC_F_INDIRECT,
> -                                        false);
> +                                        VRING_DESC_F_INDIRECT);
>         }
>
>         /* We're using some buffers from the free list. */
> @@ -716,11 +705,8 @@ static inline int virtqueue_add_split(struct virtque=
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
> @@ -765,22 +751,25 @@ static bool virtqueue_kick_prepare_split(struct vir=
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

Not sure if I've asked this before. But this part seems to deserve an
independent fix for -stable.

>                 i =3D vq->split.desc_extra[i].next;
>                 vq->vq.num_free++;
>         }
>
> -       vring_unmap_one_split(vq, i);
> +       vring_unmap_one_split(vq, &extra[i]);
>         vq->split.desc_extra[i].next =3D vq->free_head;
>         vq->free_head =3D head;
>
> @@ -790,21 +779,24 @@ static void detach_buf_split(struct vring_virtqueue=
 *vq, unsigned int head,
>         if (vq->indirect) {
>                 struct vring_desc *indir_desc =3D
>                                 vq->split.desc_state[head].indir_desc;
> -               u32 len;
> +               u32 len, num;
>
>                 /* Free the indirect table, if any, now that it's unmappe=
d. */
>                 if (!indir_desc)
>                         return;
> -
>                 len =3D vq->split.desc_extra[head].len;
>
>                 BUG_ON(!(vq->split.desc_extra[head].flags &
>                                 VRING_DESC_F_INDIRECT));
>                 BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc));
>
> +               num =3D len / sizeof(struct vring_desc);
> +
> +               extra =3D (struct vring_desc_extra *)&indir_desc[num];
> +
>                 if (vring_need_unmap_buffer(vq)) {
> -                       for (j =3D 0; j < len / sizeof(struct vring_desc)=
; j++)
> -                               vring_unmap_one_split_indirect(vq, &indir=
_desc[j]);
> +                       for (j =3D 0; j < num; j++)
> +                               vring_unmap_one_split(vq, &extra[j]);
>                 }
>
>                 kfree(indir_desc);
> --
> 2.32.0.3.g01195cf9f
>

Thanks


