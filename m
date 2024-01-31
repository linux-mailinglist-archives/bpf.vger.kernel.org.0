Return-Path: <bpf+bounces-20798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63AE843AC7
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 10:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B95B29B95
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7A37869A;
	Wed, 31 Jan 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTfU7I1Z"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1DF78662
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692368; cv=none; b=AbdPdWDAnWD2es/Tb6Vh0ZQmWkgGdnUKbTBdENH5Q75wByYohefawudcszbK4eglu3HeAq7b+87rQjWqLPVwS0/uQ2Bh4zoxkaXmIuwZm3kT7BwuNJdIgLebnrePcS4dc0jjt/eer6CNDv2yDvfV04NhNRrUvx0UfCmj7DK6i78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692368; c=relaxed/simple;
	bh=iy8IxvqKOpmyszmUICuSRJZdyFyS8a08syYg9oqhiwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAqcudWG11veVNDsnSOos35FLPc+Aga+YMHWhSuMPEuvwg36Up7zgV40iH/Nv7osgsuXU5kjIzrVmN5exsj09UY3DSnkQyksrWZgULJanKeEvkYE6fOTznh7B7U+W6JfxbprWIJI1Fdm3kbYvnZRu/7EiIxwntpHLEA3jCmrhqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTfU7I1Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsqjWW/MnDSmuwoZiRaLj0nDWAmbUu5RXdiCDY/znJM=;
	b=MTfU7I1ZgwyCUSUzGe47QUOwijOmiIpvMNWKjGAW4hPqKC/LsnhmsZPIL7QWO365z/HtFK
	SiDTOc2nuMYWX36NbPE7m4/iOG2sIxZvgqSOfTS3p2cvQCaSi2NuPfc0O0kpY8633/pMNM
	QS1XC3wBvToibpHImGdYB3ZUVbXQjk8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-aTQ4ZhojNE6lOVaVaQ7s_g-1; Wed, 31 Jan 2024 04:12:41 -0500
X-MC-Unique: aTQ4ZhojNE6lOVaVaQ7s_g-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bec05c9047so252088b6e.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 01:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692361; x=1707297161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsqjWW/MnDSmuwoZiRaLj0nDWAmbUu5RXdiCDY/znJM=;
        b=VIM3C98axx1RlZO1aTDTcWe6uFqqGJpS2bSraulAHW3Rj3SkNOWaIgb1Zq8ezUFvmk
         9qXakj4lPesYsEBWinqC4r+yGHYf7sMkVyKX27RRF9Lg+aHgJyijQsRSHjrsYyF953lo
         9fGSyHQAALCJl+4dd5jEXYv8VevQu6CHfEvBbvPMKDtSDmpCzn0y3aw+YoMBzFcNzJN7
         6NMsJ/mYxspZgtHvmVp4r8j1i48AhuWrWJyzkJRHbnMC9FIXvKNKxrnyMRoBbDTSpPos
         AfWIU5jGzJTLJuZoRFV9Tp5lfr2O+KVcY5YwYh21KixG+TvjEv0gCQHqqzaC12PrSvOR
         WmVA==
X-Gm-Message-State: AOJu0YzLPm7KlVuhA57IEFuZbIcCvch018hmccMHYH+6Ir4hoLJM4efP
	RdmOp9zZjqxUogN0mmwoIBpiLmvJ90J8JFnlElfHXidQ1rhQI8nVdGs/auRkUCIc3FUQ7a3DTIC
	1NzSnFaJ6+j4nEwGM3gszfWx2WgcBnJ9FHyaUG7TVOXDDHH2Yehe7SPYHslS834e+ESdvaVKv48
	kYZUJe170OjrouUsL5cuAPlg9q
X-Received: by 2002:a05:6808:1411:b0:3bd:692d:b234 with SMTP id w17-20020a056808141100b003bd692db234mr1439591oiv.46.1706692360820;
        Wed, 31 Jan 2024 01:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkhNl8CYmtHiEfIUfnPYL5oLs/Tc6D6VHe9+SWIvn+sLqMZVRWwpFiE+EIR4sYMDOZHFDn03BUTmGXgWIZEJ8=
X-Received: by 2002:a05:6808:1411:b0:3bd:692d:b234 with SMTP id
 w17-20020a056808141100b003bd692db234mr1439555oiv.46.1706692360520; Wed, 31
 Jan 2024 01:12:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:29 +0800
Message-ID: <CACGkMEtNCjvtDWySzeAqETGZtBSL0MR6=JySBBtm3=s19wB=1w@mail.gmail.com>
Subject: Re: [PATCH vhost 06/17] virtio_ring: no store dma info when unmap is
 not needed
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> As discussed:
> http://lore.kernel.org/all/CACGkMEug-=3DC+VQhkMYSgUKMC=3D=3D04m7-uem_yC21=
bgGkKZh845w@mail.gmail.com
>
> When the vq is premapped mode, the driver manages the dma
> info is a good way.
>
> So this commit make the virtio core not to store the dma
> info and release the memory which is used to store the dma
> info.
>
> If the use_dma_api is false, the memory is also not allocated.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 89 ++++++++++++++++++++++++++++--------
>  1 file changed, 70 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 831667a57429..5bea25167259 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -94,12 +94,15 @@ struct vring_desc_state_packed {
>  };
>
>  struct vring_desc_extra {
> -       dma_addr_t addr;                /* Descriptor DMA addr. */
> -       u32 len;                        /* Descriptor length. */
>         u16 flags;                      /* Descriptor flags. */
>         u16 next;                       /* The next desc state in a list.=
 */
>  };
>
> +struct vring_desc_dma {
> +       dma_addr_t addr;                /* Descriptor DMA addr. */
> +       u32 len;                        /* Descriptor length. */
> +};
> +
>  struct vring_virtqueue_split {
>         /* Actual memory layout for this queue. */
>         struct vring vring;
> @@ -116,6 +119,7 @@ struct vring_virtqueue_split {
>         /* Per-descriptor state. */
>         struct vring_desc_state_split *desc_state;
>         struct vring_desc_extra *desc_extra;
> +       struct vring_desc_dma *desc_dma;
>
>         /* DMA address and size information */
>         dma_addr_t queue_dma_addr;
> @@ -156,6 +160,7 @@ struct vring_virtqueue_packed {
>         /* Per-descriptor state. */
>         struct vring_desc_state_packed *desc_state;
>         struct vring_desc_extra *desc_extra;
> +       struct vring_desc_dma *desc_dma;
>
>         /* DMA address and size information */
>         dma_addr_t ring_dma_addr;
> @@ -472,13 +477,14 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
>                                           unsigned int i)
>  {
>         struct vring_desc_extra *extra =3D vq->split.desc_extra;
> +       struct vring_desc_dma *dma =3D vq->split.desc_dma;
>         u16 flags;
>
>         flags =3D extra[i].flags;
>
>         dma_unmap_page(vring_dma_dev(vq),
> -                      extra[i].addr,
> -                      extra[i].len,
> +                      dma[i].addr,
> +                      dma[i].len,
>                        (flags & VRING_DESC_F_WRITE) ?
>                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
>
> @@ -535,8 +541,11 @@ static inline unsigned int virtqueue_add_desc_split(=
struct virtqueue *vq,
>                 next =3D extra[i].next;
>                 desc[i].next =3D cpu_to_virtio16(vq->vdev, next);
>
> -               extra[i].addr =3D addr;
> -               extra[i].len =3D len;
> +               if (vring->split.desc_dma) {
> +                       vring->split.desc_dma[i].addr =3D addr;
> +                       vring->split.desc_dma[i].len =3D len;
> +               }
> +
>                 extra[i].flags =3D flags;
>         } else
>                 next =3D virtio16_to_cpu(vq->vdev, desc[i].next);
> @@ -1072,16 +1081,26 @@ static void virtqueue_vring_attach_split(struct v=
ring_virtqueue *vq,
>         vq->free_head =3D 0;
>  }
>
> -static int vring_alloc_state_extra_split(struct vring_virtqueue_split *v=
ring_split)
> +static int vring_alloc_state_extra_split(struct vring_virtqueue_split *v=
ring_split,
> +                                        bool need_unmap)
>  {
>         struct vring_desc_state_split *state;
>         struct vring_desc_extra *extra;
> +       struct vring_desc_dma *dma;
>         u32 num =3D vring_split->vring.num;
>
>         state =3D kmalloc_array(num, sizeof(struct vring_desc_state_split=
), GFP_KERNEL);
>         if (!state)
>                 goto err_state;
>
> +       if (need_unmap) {
> +               dma =3D kmalloc_array(num, sizeof(struct vring_desc_dma),=
 GFP_KERNEL);
> +               if (!dma)
> +                       goto err_dma;
> +       } else {
> +               dma =3D NULL;
> +       }
> +
>         extra =3D vring_alloc_desc_extra(num);
>         if (!extra)
>                 goto err_extra;
> @@ -1090,9 +1109,12 @@ static int vring_alloc_state_extra_split(struct vr=
ing_virtqueue_split *vring_spl
>
>         vring_split->desc_state =3D state;
>         vring_split->desc_extra =3D extra;
> +       vring_split->desc_dma =3D dma;
>         return 0;
>
>  err_extra:
> +       kfree(dma);
> +err_dma:
>         kfree(state);
>  err_state:
>         return -ENOMEM;
> @@ -1108,6 +1130,7 @@ static void vring_free_split(struct vring_virtqueue=
_split *vring_split,
>
>         kfree(vring_split->desc_state);
>         kfree(vring_split->desc_extra);
> +       kfree(vring_split->desc_dma);
>  }
>
>  static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_s=
plit,
> @@ -1209,7 +1232,8 @@ static int virtqueue_resize_split(struct virtqueue =
*_vq, u32 num)
>         if (err)
>                 goto err;
>
> -       err =3D vring_alloc_state_extra_split(&vring_split);
> +       err =3D vring_alloc_state_extra_split(&vring_split,
> +                                           vring_need_unmap_buffer(vq));
>         if (err)
>                 goto err_state_extra;
>
> @@ -1245,14 +1269,16 @@ static u16 packed_last_used(u16 last_used_idx)
>
>  /* caller must check vring_need_unmap_buffer() */
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> -                                    const struct vring_desc_extra *extra=
)
> +                                    unsigned int i)
>  {
> +       const struct vring_desc_extra *extra =3D &vq->packed.desc_extra[i=
];
> +       const struct vring_desc_dma *dma =3D &vq->packed.desc_dma[i];
>         u16 flags;
>
>         flags =3D extra->flags;

I don't think this can be compiled.

Thanks


