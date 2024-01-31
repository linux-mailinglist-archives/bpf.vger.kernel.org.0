Return-Path: <bpf+bounces-20794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E15843AA4
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 10:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5BCB2DD55
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71D069E09;
	Wed, 31 Jan 2024 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpQJiVc2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A26773D
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692349; cv=none; b=RZ9858ms5QiPMGjqyjjrg/3JCUQON29Q6ylxfQg585XxeUanKl2Vzo3YoMvO/0ooUZbjiSZ+6KOsSNUNPnh/rqDIeK10xNW4msJBHGwC6ScivQwjg5hGA4GiTseQeZhcZB3YGkIM8M7toItvAjRAxgHmYoVne7D/8eUxVxcIDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692349; c=relaxed/simple;
	bh=ztRcSVvz1hYEI4OmR3FUypjEuHv/JZyFnd1W0vkBqVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7Yv3maCy9CdVyzJmNU02JqqBDUlCgzxh9J2fs6ghl+zffLPeJdac1riS9g1f3dBSPe6NwUCnLUsAkuXH/Lyr66W0FMoQJdnWJfnfw5nOpuEnZiUYmvqMdAyPshydFtnOBvSpf6Z5nQAbPASN2K42v01n45qakolRRj0wkE1AFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XpQJiVc2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJLwocwtNUB8ZTp4FCceWuPM46tHyYM0Zkz28XCMF9w=;
	b=XpQJiVc23/Mr9foMMUfQXi6OHLbcP+dBsuyH27VxSD1Z0fjviGP4LMTxHFa9UEu5jYtcb2
	0zbRvg5F4nOQF8XY2RKpzyimQY9bc4tcqaIOPEWm5Xaa0n0AyHw0b/E+5K8QxS8T4VpLIG
	kE8kyh4D/5qY6r2h1GZfzRErLTj48Oo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-lLqj3CojMQu3aLnNPRpswQ-1; Wed, 31 Jan 2024 04:12:24 -0500
X-MC-Unique: lLqj3CojMQu3aLnNPRpswQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-295b6b50fc7so744362a91.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 01:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692343; x=1707297143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJLwocwtNUB8ZTp4FCceWuPM46tHyYM0Zkz28XCMF9w=;
        b=F6lIn07Jp3Q2xfLYms/6A7rdIWrzWkrYExn1J95EEBoJi7wd6f3BJwa0v/rrjrpWkp
         PjncJlABauYYEyJwwW5ZhC0Iuv3NShA0TcBsXftBulzFhT8Pk/vhLuTSbaYzbrcwUoKZ
         KXDaCU/Y5NCqlY74saYegL/eYudYbZyqr+4jQXh+DWd1FmXW0WqTajeUbPEUZUfEzDi2
         s4AS8kQA6QaPv5smseBEosEeVkpoYf4QrG0h3zwUJfogeduthDKHk5H/ojuvLN1ktHwg
         6HN5wfECyXTlbkCPIMoWgWjow+NHC195OxcMQNDt4biX5DC0JJs83NpkRDuMH8xy8pb5
         gHvA==
X-Gm-Message-State: AOJu0YzHxzBoSyldRk2pFV+IJY+o+EcJ0ZWabGFx9EAnnspMN0XtVN2y
	oupT9Heulp/rwR/gmBCMRAmnrErNOqpDV7Iqw1KmA6jePivwk1ohnDWVVwN+gy/Ij57Muz/TgXS
	pJYSIYQT3krkiWJIHE7RTx1IW01m6AWX5TSV0RCCXzjWAykDzcf2D+9yOri4voXV8q0TPaod8R8
	Csgk0ZmCsbesfzdYZjRezIbDfO
X-Received: by 2002:a17:90a:4812:b0:28e:850e:7e87 with SMTP id a18-20020a17090a481200b0028e850e7e87mr4055943pjh.41.1706692342966;
        Wed, 31 Jan 2024 01:12:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA19Z59zeHpR3nNimF0ZQi1mnwkJcouyhWsEmqEUBepD+NIxCTxSZH5EaaTBhFTcpXCqGmenq5iSv576m9gbY=
X-Received: by 2002:a17:90a:4812:b0:28e:850e:7e87 with SMTP id
 a18-20020a17090a481200b0028e850e7e87mr4055914pjh.41.1706692342651; Wed, 31
 Jan 2024 01:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:10 +0800
Message-ID: <CACGkMEvz55WO+TN2KCv+KLvdT-ZxLike81maahBeVanrCk_Lrg@mail.gmail.com>
Subject: Re: [PATCH vhost 03/17] virtio_ring: packed: structure the indirect
 desc table
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
> This commit structure the indirect desc table.
> Then we can get the desc num directly when doing unmap.
>
> And save the dma info to the struct, then the indirect
> will not use the dma fields of the desc_extra. The subsequent
> commits will make the dma fields are optional. But for
> the indirect case, we must record the dma info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 7280a1706cca..dd03bc5a81fe 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -72,9 +72,16 @@ struct vring_desc_state_split {
>         struct vring_desc *indir_desc;  /* Indirect descriptor, if any. *=
/
>  };
>
> +struct vring_packed_desc_indir {
> +       dma_addr_t addr;                /* Descriptor Array DMA addr. */
> +       u32 len;                        /* Descriptor Array length. */
> +       u32 num;
> +       struct vring_packed_desc desc[];
> +};
> +
>  struct vring_desc_state_packed {
>         void *data;                     /* Data for callback. */
> -       struct vring_packed_desc *indir_desc; /* Indirect descriptor, if =
any. */
> +       struct vring_packed_desc_indir *indir_desc; /* Indirect descripto=
r, if any. */
>         u16 num;                        /* Descriptor list length. */
>         u16 last;                       /* The last desc state in a list.=
 */
>  };
> @@ -1249,10 +1256,13 @@ static void vring_unmap_desc_packed(const struct =
vring_virtqueue *vq,
>                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  }
>
> -static struct vring_packed_desc *alloc_indirect_packed(unsigned int tota=
l_sg,
> +static struct vring_packed_desc_indir *alloc_indirect_packed(unsigned in=
t total_sg,
>                                                        gfp_t gfp)
>  {
> -       struct vring_packed_desc *desc;
> +       struct vring_packed_desc_indir *in_desc;
> +       u32 size;
> +
> +       size =3D struct_size(in_desc, desc, total_sg);
>
>         /*
>          * We require lowmem mappings for the descriptors because
> @@ -1261,9 +1271,10 @@ static struct vring_packed_desc *alloc_indirect_pa=
cked(unsigned int total_sg,
>          */
>         gfp &=3D ~__GFP_HIGHMEM;
>
> -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_packed_desc)=
, gfp);
>
> -       return desc;
> +       in_desc =3D kmalloc(size, gfp);
> +
> +       return in_desc;
>  }
>
>  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> @@ -1274,6 +1285,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                                          void *data,
>                                          gfp_t gfp)
>  {
> +       struct vring_packed_desc_indir *in_desc;
>         struct vring_packed_desc *desc;
>         struct scatterlist *sg;
>         unsigned int i, n, err_idx;
> @@ -1281,10 +1293,12 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>         dma_addr_t addr;
>
>         head =3D vq->packed.next_avail_idx;
> -       desc =3D alloc_indirect_packed(total_sg, gfp);
> -       if (!desc)
> +       in_desc =3D alloc_indirect_packed(total_sg, gfp);
> +       if (!in_desc)
>                 return -ENOMEM;
>
> +       desc =3D in_desc->desc;
> +
>         if (unlikely(vq->vq.num_free < 1)) {
>                 pr_debug("Can't add buf len 1 - avail =3D 0\n");
>                 kfree(desc);
> @@ -1321,17 +1335,15 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>                 goto unmap_release;
>         }
>
> +       in_desc->num =3D i;
> +       in_desc->addr =3D addr;
> +       in_desc->len =3D total_sg * sizeof(struct vring_packed_desc);

It looks to me if we don't use dma_api we don't even need these steps?

> +
>         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
>         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
>                                 sizeof(struct vring_packed_desc));
>         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
>
> -       if (vring_need_unmap_buffer(vq)) {
> -               vq->packed.desc_extra[id].addr =3D addr;
> -               vq->packed.desc_extra[id].len =3D total_sg *
> -                               sizeof(struct vring_packed_desc);
> -       }
> -
>         vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
>                 vq->packed.avail_used_flags;
>
> @@ -1362,7 +1374,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         /* Store token and indirect buffer state. */
>         vq->packed.desc_state[id].num =3D 1;
>         vq->packed.desc_state[id].data =3D data;
> -       vq->packed.desc_state[id].indir_desc =3D desc;
> +       vq->packed.desc_state[id].indir_desc =3D in_desc;
>         vq->packed.desc_state[id].last =3D id;
>
>         vq->num_added +=3D 1;
> @@ -1381,7 +1393,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                 vring_unmap_desc_packed(vq, &desc[i]);
>
>  free_desc:
> -       kfree(desc);
> +       kfree(in_desc);
>
>         END_USE(vq);
>         return -ENOMEM;
> @@ -1595,7 +1607,6 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>                               unsigned int id, void **ctx)
>  {
>         struct vring_desc_state_packed *state =3D NULL;
> -       struct vring_packed_desc *desc;
>         unsigned int i, curr;
>         u16 flags;
>
> @@ -1621,28 +1632,24 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
>
>                 if (ctx)
>                         *ctx =3D state->indir_desc;
> +

Unnecessary changes.

Thanks


