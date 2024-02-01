Return-Path: <bpf+bounces-20878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D147844E04
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 01:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EC61F2B040
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 00:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7814C81;
	Thu,  1 Feb 2024 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fb8QVSyx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5D81FDB
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748093; cv=none; b=CuXPlGKsPV88DRJGgGKKHgZAwe14vmqgE0V0FmmZi7+oYvvcVcNdEa0j9Q0PV+LB+rcZhD6LMX/tasuTBoACABfv0DjTPkyDrIknXcrv4YZuUWipdObsei6Q6MIDg/WoicE2y8UpXMw4RAStbNNJiXlV5ea0jhYR1QQAQMSnPjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748093; c=relaxed/simple;
	bh=HkDSvfSRqnAhIsDwn6auSkMHhy5YeYDTpIl0aj7IF+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/Ky6/QkE0Ac5v5C7uqPCWbIpNyifDoGGL9VPkevKUv/WWFk0rCqEn7OoTE0ERbSyrj/S+03dyfVm8iFuw2oRDNsx/yD1bmY3GQFfZd7JuZmOX0H3VIf350tuPOqg64c4ZnjKsey/hyyH3LV3aoB0FmnBTVfVQ+Qo7DfM3JqyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fb8QVSyx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706748090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xm74o6SZFHiAyG46ECEn20qNcBF1TdhhBIb8LTtMkm0=;
	b=fb8QVSyxXvX8TivUKQu/fZ7GdtvuKJSIVDWhgF9yfV679+GEbMRKwi4URjrVZGB3J9zUXj
	ZpgIEkmqeWuaxBBtiv7s4SkpLswwrkUkhTY7IIKZ2cllJpENBXnbjgh49LHlvvtirSzvcT
	gIOCqVy/gQfsGfi6tI0XOs2yu+OcusQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-1DYLUGG0NDGkZKf9I-ltBg-1; Wed, 31 Jan 2024 19:41:28 -0500
X-MC-Unique: 1DYLUGG0NDGkZKf9I-ltBg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ddded741bfso250981b3a.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 16:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706748087; x=1707352887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm74o6SZFHiAyG46ECEn20qNcBF1TdhhBIb8LTtMkm0=;
        b=RIZ5Ld+8BlHb8FzLBwn2zG5tood056wKq2XkCKv1Sik3qzioWBm+e3LXYXFmGgHKqe
         0FSQBYg5ggw114fz2WHbMiV6MihQ/ZAvuCAhAn2rUfpK2B26wJoZStM8KZkXSuqi5rNo
         dFnOF2iha25TfnbzlWCpSok5oc7x7CDvx3RDDPoXnzSRHXZGa33WNQCeO3IfezVukyv/
         t7hG6CE/N3L5Yfw817ketfy81FPo4twRXjeDqAZ/C2KShAtT1RpawL8u6jesJ9TDTnjG
         +qkt363iff0wR1Se+Q0kUIk67Od4ITD+RQg/If5BHU5oN8HoiRsSUKBYT4ezo476wLtY
         agrA==
X-Gm-Message-State: AOJu0YwZ2SuxQLte0sy2r5UUfkf82H7okRGZ+0ikSV4/O90Fcm0uO8XM
	BYSLVivdijSR8JUqJIKlxwQFdQzYLLdaG8zsw+QR6j632MPxAvDtXsc4Xbf5tp1pqVq5cpGu244
	S3DK4xPtLLazqBRhfeErX5dDildyJYioKpTakeq80i+KhdNuf1fTaFCQprlYKqC7qhRteuuoL4W
	0MNuVnV2/UwDN9J2rF3hcFbl87
X-Received: by 2002:a05:6a00:4c93:b0:6df:e035:5549 with SMTP id eb19-20020a056a004c9300b006dfe0355549mr2951453pfb.15.1706748086979;
        Wed, 31 Jan 2024 16:41:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH/TitMqAcPOEtWHFne1kSiI8iL6WqnOYeJwP2xl0eZN5iQI7uLb9EncoBScobllWL5obozZXTXfo6m5Jujsg=
X-Received: by 2002:a05:6a00:4c93:b0:6df:e035:5549 with SMTP id
 eb19-20020a056a004c9300b006dfe0355549mr2951417pfb.15.1706748086661; Wed, 31
 Jan 2024 16:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-4-xuanzhuo@linux.alibaba.com> <CACGkMEvz55WO+TN2KCv+KLvdT-ZxLike81maahBeVanrCk_Lrg@mail.gmail.com>
 <1706695212.333408-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706695212.333408-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Feb 2024 08:41:14 +0800
Message-ID: <CACGkMEsSw2ZC1jxhnK2FiATcUW7mgomhp+AZ2m0SxavLN1WsGw@mail.gmail.com>
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

On Wed, Jan 31, 2024 at 6:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 31 Jan 2024 17:12:10 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > This commit structure the indirect desc table.
> > > Then we can get the desc num directly when doing unmap.
> > >
> > > And save the dma info to the struct, then the indirect
> > > will not use the dma fields of the desc_extra. The subsequent
> > > commits will make the dma fields are optional. But for
> > > the indirect case, we must record the dma info.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++--------------=
--
> > >  1 file changed, 35 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 7280a1706cca..dd03bc5a81fe 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -72,9 +72,16 @@ struct vring_desc_state_split {
> > >         struct vring_desc *indir_desc;  /* Indirect descriptor, if an=
y. */
> > >  };
> > >
> > > +struct vring_packed_desc_indir {
> > > +       dma_addr_t addr;                /* Descriptor Array DMA addr.=
 */
> > > +       u32 len;                        /* Descriptor Array length. *=
/
> > > +       u32 num;
> > > +       struct vring_packed_desc desc[];
> > > +};
> > > +
> > >  struct vring_desc_state_packed {
> > >         void *data;                     /* Data for callback. */
> > > -       struct vring_packed_desc *indir_desc; /* Indirect descriptor,=
 if any. */
> > > +       struct vring_packed_desc_indir *indir_desc; /* Indirect descr=
iptor, if any. */
> > >         u16 num;                        /* Descriptor list length. */
> > >         u16 last;                       /* The last desc state in a l=
ist. */
> > >  };
> > > @@ -1249,10 +1256,13 @@ static void vring_unmap_desc_packed(const str=
uct vring_virtqueue *vq,
> > >                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > >  }
> > >
> > > -static struct vring_packed_desc *alloc_indirect_packed(unsigned int =
total_sg,
> > > +static struct vring_packed_desc_indir *alloc_indirect_packed(unsigne=
d int total_sg,
> > >                                                        gfp_t gfp)
> > >  {
> > > -       struct vring_packed_desc *desc;
> > > +       struct vring_packed_desc_indir *in_desc;
> > > +       u32 size;
> > > +
> > > +       size =3D struct_size(in_desc, desc, total_sg);
> > >
> > >         /*
> > >          * We require lowmem mappings for the descriptors because
> > > @@ -1261,9 +1271,10 @@ static struct vring_packed_desc *alloc_indirec=
t_packed(unsigned int total_sg,
> > >          */
> > >         gfp &=3D ~__GFP_HIGHMEM;
> > >
> > > -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_packed_d=
esc), gfp);
> > >
> > > -       return desc;
> > > +       in_desc =3D kmalloc(size, gfp);
> > > +
> > > +       return in_desc;
> > >  }
> > >
> > >  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > > @@ -1274,6 +1285,7 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> > >                                          void *data,
> > >                                          gfp_t gfp)
> > >  {
> > > +       struct vring_packed_desc_indir *in_desc;
> > >         struct vring_packed_desc *desc;
> > >         struct scatterlist *sg;
> > >         unsigned int i, n, err_idx;
> > > @@ -1281,10 +1293,12 @@ static int virtqueue_add_indirect_packed(stru=
ct vring_virtqueue *vq,
> > >         dma_addr_t addr;
> > >
> > >         head =3D vq->packed.next_avail_idx;
> > > -       desc =3D alloc_indirect_packed(total_sg, gfp);
> > > -       if (!desc)
> > > +       in_desc =3D alloc_indirect_packed(total_sg, gfp);
> > > +       if (!in_desc)
> > >                 return -ENOMEM;
> > >
> > > +       desc =3D in_desc->desc;
> > > +
> > >         if (unlikely(vq->vq.num_free < 1)) {
> > >                 pr_debug("Can't add buf len 1 - avail =3D 0\n");
> > >                 kfree(desc);
> > > @@ -1321,17 +1335,15 @@ static int virtqueue_add_indirect_packed(stru=
ct vring_virtqueue *vq,
> > >                 goto unmap_release;
> > >         }
> > >
> > > +       in_desc->num =3D i;
> > > +       in_desc->addr =3D addr;
> > > +       in_desc->len =3D total_sg * sizeof(struct vring_packed_desc);
> >
> > It looks to me if we don't use dma_api we don't even need these steps?
>
> YES
>
>
> >
> > > +
> > >         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
> > >         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
> > >                                 sizeof(struct vring_packed_desc));
> > >         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
> > >
> > > -       if (vring_need_unmap_buffer(vq)) {
> > > -               vq->packed.desc_extra[id].addr =3D addr;
> > > -               vq->packed.desc_extra[id].len =3D total_sg *
> > > -                               sizeof(struct vring_packed_desc);
> > > -       }
> > > -
> > >         vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> > >                 vq->packed.avail_used_flags;
> > >
> > > @@ -1362,7 +1374,7 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> > >         /* Store token and indirect buffer state. */
> > >         vq->packed.desc_state[id].num =3D 1;
> > >         vq->packed.desc_state[id].data =3D data;
> > > -       vq->packed.desc_state[id].indir_desc =3D desc;
> > > +       vq->packed.desc_state[id].indir_desc =3D in_desc;
> > >         vq->packed.desc_state[id].last =3D id;
> > >
> > >         vq->num_added +=3D 1;
> > > @@ -1381,7 +1393,7 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> > >                 vring_unmap_desc_packed(vq, &desc[i]);
> > >
> > >  free_desc:
> > > -       kfree(desc);
> > > +       kfree(in_desc);
> > >
> > >         END_USE(vq);
> > >         return -ENOMEM;
> > > @@ -1595,7 +1607,6 @@ static void detach_buf_packed(struct vring_virt=
queue *vq,
> > >                               unsigned int id, void **ctx)
> > >  {
> > >         struct vring_desc_state_packed *state =3D NULL;
> > > -       struct vring_packed_desc *desc;
> > >         unsigned int i, curr;
> > >         u16 flags;
> > >
> > > @@ -1621,28 +1632,24 @@ static void detach_buf_packed(struct vring_vi=
rtqueue *vq,
> > >
> > >                 if (ctx)
> > >                         *ctx =3D state->indir_desc;
> > > +
> >
> > Unnecessary changes.
>
>
> Could you say more?
> You do not like this patch?

Nope, I say the above adding newline is an unnecessary change.

Thanks

>
> Thanks.
>
>
>
> >
> > Thanks
> >
>


