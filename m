Return-Path: <bpf+bounces-4911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B47516EA
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 05:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225831C2120E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 03:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0377546A1;
	Thu, 13 Jul 2023 03:51:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68514691
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 03:51:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0052A1BF2
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 20:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689220272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sp0rdUOcjWH48xIddYuMFWG09V+pGjldr43WMxi/P/A=;
	b=JMaTq/5B3B1La1tUaSYxcJ2NuV4clM8pvPmRqOtXPKSl7rFqxLp21dNSt+KyUGcsEe9CFi
	AiA1E2YfOa4j16UV3K6zJ7phHh3nF2sRBusz1SDPA6akIfF3BFCnOtP3vI3DAHhdK/Y7Sb
	fycEQC5IVanN9WL4SfCgJF8wwT1egQI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-hiVg0wTnObe8f_dl7dzC6A-1; Wed, 12 Jul 2023 23:51:10 -0400
X-MC-Unique: hiVg0wTnObe8f_dl7dzC6A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-635dd236b63so2046416d6.0
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 20:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689220270; x=1691812270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sp0rdUOcjWH48xIddYuMFWG09V+pGjldr43WMxi/P/A=;
        b=Uy2NA8I492/Qr6gtzjcj7Tw3jfaIHluyjLjiMKo1f6kQq9Ebw963lIpPP9tmEU/Tyg
         27iKaZsMqiWGxNZqRgvuMvBc8hOGlZCT5YIuMMWxTs78vmXZTChK1CHiREYov35hNBYd
         i0y9PPpgTRBc7vs2jxMmeNfts5E9UcfkXr6sBy2KgZx5kapi4IISq1UfJpt3IE6Q6RsG
         DNJ5cXjba0Z2BXJZwMZPTm4YwJ5+5e+U8mEw4ZAVzlrgQQkeVeIFPgvB+6PEd028yNlN
         NON9k1kbA1jRwSxxGrJKwf1xkSJN7BUStM1owaY0SlXTlwtDJAfvRTd2DpUiRoZv3GcU
         MFdQ==
X-Gm-Message-State: ABy/qLamc3aY3ITmhGRyUW/0PvhVyKNw6gOVI7czFVD8+A6uRnDbzFLJ
	+l7whRUW3rCZwsm1d2PkM+pdcH4nPxsTx3t0y1u2hxmw3XhjaMfCvGkQcuYorfb8w94CiVPd/TB
	9Zif6wHSm5UUdqKIUlJ6xbjZvpuG6
X-Received: by 2002:a05:6214:20a7:b0:623:8494:9945 with SMTP id 7-20020a05621420a700b0062384949945mr3609949qvd.26.1689220270072;
        Wed, 12 Jul 2023 20:51:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEdeIOd4SfutUHuafWv1+DVep1fvFF9G/+LzDtbweHq5KCbT57EhMqzI9n7HvJhty6c7cN7gBdORh9yNkR8tt8=
X-Received: by 2002:a05:6214:20a7:b0:623:8494:9945 with SMTP id
 7-20020a05621420a700b0062384949945mr3609936qvd.26.1689220269824; Wed, 12 Jul
 2023 20:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com> <20230710034237.12391-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230710034237.12391-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jul 2023 11:50:57 +0800
Message-ID: <CACGkMEtb_wYyXLU6kAaC2Ju2d4K=J+YbytUCMvKcNtPF+BvpJw@mail.gmail.com>
Subject: Re: [PATCH vhost v11 06/10] virtio_ring: skip unmap for premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 11:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now we add a case where we skip dma unmap, the vq->premapped is true.
>
> We can't just rely on use_dma_api to determine whether to skip the dma
> operation. For convenience, I introduced the "do_unmap". By default, it
> is the same as use_dma_api. If the driver is configured with premapped,
> then do_unmap is false.
>
> So as long as do_unmap is false, for addr of desc, we should skip dma
> unmap operation.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 42 ++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 1fb2c6dca9ea..10ee3b7ce571 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -175,6 +175,11 @@ struct vring_virtqueue {
>         /* Do DMA mapping by driver */
>         bool premapped;
>
> +       /* Do unmap or not for desc. Just when premapped is False and
> +        * use_dma_api is true, this is true.
> +        */
> +       bool do_unmap;
> +
>         /* Head of free buffer list. */
>         unsigned int free_head;
>         /* Number we've added since last sync. */
> @@ -440,7 +445,7 @@ static void vring_unmap_one_split_indirect(const stru=
ct vring_virtqueue *vq,
>  {
>         u16 flags;
>
> -       if (!vq->use_dma_api)
> +       if (!vq->do_unmap)
>                 return;
>
>         flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
> @@ -458,18 +463,21 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
>         struct vring_desc_extra *extra =3D vq->split.desc_extra;
>         u16 flags;
>
> -       if (!vq->use_dma_api)
> -               goto out;
> -
>         flags =3D extra[i].flags;
>
>         if (flags & VRING_DESC_F_INDIRECT) {
> +               if (!vq->use_dma_api)
> +                       goto out;
> +
>                 dma_unmap_single(vring_dma_dev(vq),
>                                  extra[i].addr,
>                                  extra[i].len,
>                                  (flags & VRING_DESC_F_WRITE) ?
>                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         } else {
> +               if (!vq->do_unmap)
> +                       goto out;
> +
>                 dma_unmap_page(vring_dma_dev(vq),
>                                extra[i].addr,
>                                extra[i].len,
> @@ -635,7 +643,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         }
>         /* Last one doesn't continue. */
>         desc[prev].flags &=3D cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NE=
XT);
> -       if (!indirect && vq->use_dma_api)
> +       if (!indirect && vq->do_unmap)
>                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].fl=
ags &=3D
>                         ~VRING_DESC_F_NEXT;
>
> @@ -794,7 +802,7 @@ static void detach_buf_split(struct vring_virtqueue *=
vq, unsigned int head,
>                                 VRING_DESC_F_INDIRECT));
>                 BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc));
>
> -               if (vq->use_dma_api) {
> +               if (vq->do_unmap) {
>                         for (j =3D 0; j < len / sizeof(struct vring_desc)=
; j++)
>                                 vring_unmap_one_split_indirect(vq, &indir=
_desc[j]);
>                 }
> @@ -1217,17 +1225,20 @@ static void vring_unmap_extra_packed(const struct=
 vring_virtqueue *vq,
>  {
>         u16 flags;
>
> -       if (!vq->use_dma_api)
> -               return;
> -
>         flags =3D extra->flags;
>
>         if (flags & VRING_DESC_F_INDIRECT) {
> +               if (!vq->use_dma_api)
> +                       return;
> +
>                 dma_unmap_single(vring_dma_dev(vq),
>                                  extra->addr, extra->len,
>                                  (flags & VRING_DESC_F_WRITE) ?
>                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         } else {
> +               if (!vq->do_unmap)
> +                       return;

This seems not straightforward than:

if (!vq->use_dma_api)
    return;

if (INDIRECT) {
} else if (!vq->premapped) {
}

?

Thanks

> +
>                 dma_unmap_page(vring_dma_dev(vq),
>                                extra->addr, extra->len,
>                                (flags & VRING_DESC_F_WRITE) ?
> @@ -1240,7 +1251,7 @@ static void vring_unmap_desc_packed(const struct vr=
ing_virtqueue *vq,
>  {
>         u16 flags;
>
> -       if (!vq->use_dma_api)
> +       if (!vq->do_unmap)
>                 return;
>
>         flags =3D le16_to_cpu(desc->flags);
> @@ -1329,7 +1340,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                                 sizeof(struct vring_packed_desc));
>         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
>
> -       if (vq->use_dma_api) {
> +       if (vq->do_unmap) {
>                 vq->packed.desc_extra[id].addr =3D addr;
>                 vq->packed.desc_extra[id].len =3D total_sg *
>                                 sizeof(struct vring_packed_desc);
> @@ -1470,7 +1481,7 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>                         desc[i].len =3D cpu_to_le32(sg->length);
>                         desc[i].id =3D cpu_to_le16(id);
>
> -                       if (unlikely(vq->use_dma_api)) {
> +                       if (unlikely(vq->do_unmap)) {
>                                 vq->packed.desc_extra[curr].addr =3D addr=
;
>                                 vq->packed.desc_extra[curr].len =3D sg->l=
ength;
>                                 vq->packed.desc_extra[curr].flags =3D
> @@ -1604,7 +1615,7 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>         vq->free_head =3D id;
>         vq->vq.num_free +=3D state->num;
>
> -       if (unlikely(vq->use_dma_api)) {
> +       if (unlikely(vq->do_unmap)) {
>                 curr =3D id;
>                 for (i =3D 0; i < state->num; i++) {
>                         vring_unmap_extra_packed(vq,
> @@ -1621,7 +1632,7 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>                 if (!desc)
>                         return;
>
> -               if (vq->use_dma_api) {
> +               if (vq->do_unmap) {
>                         len =3D vq->packed.desc_extra[id].len;
>                         for (i =3D 0; i < len / sizeof(struct vring_packe=
d_desc);
>                                         i++)
> @@ -2080,6 +2091,7 @@ static struct virtqueue *vring_create_virtqueue_pac=
ked(
>         vq->dma_dev =3D dma_dev;
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
>         vq->premapped =3D false;
> +       vq->do_unmap =3D vq->use_dma_api;
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !context;
> @@ -2587,6 +2599,7 @@ static struct virtqueue *__vring_new_virtqueue(unsi=
gned int index,
>         vq->dma_dev =3D dma_dev;
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
>         vq->premapped =3D false;
> +       vq->do_unmap =3D vq->use_dma_api;
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !context;
> @@ -2765,6 +2778,7 @@ int virtqueue_set_premapped(struct virtqueue *_vq)
>                 return -EINVAL;
>
>         vq->premapped =3D true;
> +       vq->do_unmap =3D false;
>
>         return 0;
>  }
> --
> 2.32.0.3.g01195cf9f
>


