Return-Path: <bpf+bounces-3539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F0673F664
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 10:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D007D281008
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 08:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5D515ACE;
	Tue, 27 Jun 2023 08:03:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840415499
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 08:03:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6414C10F9
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687853016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQ1KiUIpCNyDhBtgM+t3Kj4l2XehoEKxQO7OYIILltw=;
	b=NtQ4/bd6BA8tX8JLRDRXXJOvbaKx+veH+RpDnl6Q9Aez9ydQQJOwaAtjn5iktD76P1Na3b
	ZYx+eYFZdoVpETNtnxA7LELMAzYg1qC7IFNuXZDv1In0jFss0aIPN8mXXGR9oJV1O6cYB+
	6xCSiVeVjVVdpQ3qlNT3rwj7ps7/yh4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-TytDGR5aO3S_sLVMRdAQEg-1; Tue, 27 Jun 2023 04:03:33 -0400
X-MC-Unique: TytDGR5aO3S_sLVMRdAQEg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fb76659d44so1994852e87.3
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853011; x=1690445011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQ1KiUIpCNyDhBtgM+t3Kj4l2XehoEKxQO7OYIILltw=;
        b=XapKqDk/eiAJQhTPkkfGpKnM7nRs4d3zMMSTZZ7wu1Rluxde6vZdbDDOdZScVg9hJQ
         IGym9g/Jm3NNIFKF6u2ZiDSfdbNT1A5Zk5C0+m9sum3UBh+oXs0G3w+4YIsCMAsc794p
         yPaIUHJshlfhBOb+p902oCkL9by4xDVJ97s5Z/lbdMYA+dCiXh/50R4nyS9dLTmoUyv2
         NUd6NGr/XZWsfUSb2x0MSGIIVBDYkgd7aXJcX/+2Rw9E2Lz5ky9DSoB2ZBDTlUZMTt8g
         SFG32d+Omh9gSVTwmsbR8nb/LOP6mupBl60RBL8D24hRNZgRebRIiq7K8BP31WkK1mEC
         3e6w==
X-Gm-Message-State: AC+VfDwOM9MyNPoVEFyB2pOHQO1OZqJS3i09Fv7scGLQce2BiC/B2Cq5
	r0RRnRWSxzNse8ULu1E2laCBNIsT1r7wY4xxtdtvyzXBqZ2FMkCbDh9xzk8rjPyJA2Vnxk7eI8b
	xEQoAGZcKqOFuW5PkwitAkGx4UKmo
X-Received: by 2002:a19:7111:0:b0:4f3:9136:9cd0 with SMTP id m17-20020a197111000000b004f391369cd0mr17569904lfc.44.1687853011632;
        Tue, 27 Jun 2023 01:03:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/gIIK3zpzyK5hdGmnBvsXW1vftwaoK5OxHi4uoENLn5lDqWlNIYsZvweYSeoKVGgDi8bQXCRsOIUaUEHvEiw=
X-Received: by 2002:a19:7111:0:b0:4f3:9136:9cd0 with SMTP id
 m17-20020a197111000000b004f391369cd0mr17569879lfc.44.1687853011290; Tue, 27
 Jun 2023 01:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com> <20230602092206.50108-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230602092206.50108-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 16:03:19 +0800
Message-ID: <CACGkMEuS3DsjgP0RB2C-DbsACq4FU6RKD4C+p3dOGQHWdZJJhg@mail.gmail.com>
Subject: Re: [PATCH vhost v10 01/10] virtio_ring: put mapping error check in vring_map_one_sg
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 5:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> This patch put the dma addr error check in vring_map_one_sg().
>
> The benefits of doing this:
>
> 1. reduce one judgment of vq->use_dma_api.
> 2. make vring_map_one_sg more simple, without calling
>    vring_mapping_error to check the return value. simplifies subsequent
>    code
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  drivers/virtio/virtio_ring.c | 37 +++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c5310eaf8b46..72ed07a604d4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -355,9 +355,8 @@ static struct device *vring_dma_dev(const struct vrin=
g_virtqueue *vq)
>  }
>
>  /* Map one sg entry. */
> -static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
> -                                  struct scatterlist *sg,
> -                                  enum dma_data_direction direction)
> +static int vring_map_one_sg(const struct vring_virtqueue *vq, struct sca=
tterlist *sg,
> +                           enum dma_data_direction direction, dma_addr_t=
 *addr)
>  {
>         if (!vq->use_dma_api) {
>                 /*
> @@ -366,7 +365,8 @@ static dma_addr_t vring_map_one_sg(const struct vring=
_virtqueue *vq,
>                  * depending on the direction.
>                  */
>                 kmsan_handle_dma(sg_page(sg), sg->offset, sg->length, dir=
ection);
> -               return (dma_addr_t)sg_phys(sg);
> +               *addr =3D (dma_addr_t)sg_phys(sg);
> +               return 0;
>         }
>
>         /*
> @@ -374,9 +374,14 @@ static dma_addr_t vring_map_one_sg(const struct vrin=
g_virtqueue *vq,
>          * the way it expects (we don't guarantee that the scatterlist
>          * will exist for the lifetime of the mapping).
>          */
> -       return dma_map_page(vring_dma_dev(vq),
> +       *addr =3D dma_map_page(vring_dma_dev(vq),
>                             sg_page(sg), sg->offset, sg->length,
>                             direction);
> +
> +       if (dma_mapping_error(vring_dma_dev(vq), *addr))
> +               return -ENOMEM;
> +
> +       return 0;
>  }
>
>  static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
> @@ -588,8 +593,9 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>
>         for (n =3D 0; n < out_sgs; n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> -                       dma_addr_t addr =3D vring_map_one_sg(vq, sg, DMA_=
TO_DEVICE);
> -                       if (vring_mapping_error(vq, addr))
> +                       dma_addr_t addr;
> +
> +                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr=
))
>                                 goto unmap_release;
>
>                         prev =3D i;
> @@ -603,8 +609,9 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         }
>         for (; n < (out_sgs + in_sgs); n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> -                       dma_addr_t addr =3D vring_map_one_sg(vq, sg, DMA_=
FROM_DEVICE);
> -                       if (vring_mapping_error(vq, addr))
> +                       dma_addr_t addr;
> +
> +                       if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &ad=
dr))
>                                 goto unmap_release;
>
>                         prev =3D i;
> @@ -1279,9 +1286,8 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>
>         for (n =3D 0; n < out_sgs + in_sgs; n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> -                       addr =3D vring_map_one_sg(vq, sg, n < out_sgs ?
> -                                       DMA_TO_DEVICE : DMA_FROM_DEVICE);
> -                       if (vring_mapping_error(vq, addr))
> +                       if (vring_map_one_sg(vq, sg, n < out_sgs ?
> +                                            DMA_TO_DEVICE : DMA_FROM_DEV=
ICE, &addr))
>                                 goto unmap_release;
>
>                         desc[i].flags =3D cpu_to_le16(n < out_sgs ?
> @@ -1426,9 +1432,10 @@ static inline int virtqueue_add_packed(struct virt=
queue *_vq,
>         c =3D 0;
>         for (n =3D 0; n < out_sgs + in_sgs; n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> -                       dma_addr_t addr =3D vring_map_one_sg(vq, sg, n < =
out_sgs ?
> -                                       DMA_TO_DEVICE : DMA_FROM_DEVICE);
> -                       if (vring_mapping_error(vq, addr))
> +                       dma_addr_t addr;
> +
> +                       if (vring_map_one_sg(vq, sg, n < out_sgs ?
> +                                            DMA_TO_DEVICE : DMA_FROM_DEV=
ICE, &addr))
>                                 goto unmap_release;
>
>                         flags =3D cpu_to_le16(vq->packed.avail_used_flags=
 |
> --
> 2.32.0.3.g01195cf9f
>


