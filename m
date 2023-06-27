Return-Path: <bpf+bounces-3541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE97373F668
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 10:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691BD281062
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0716418;
	Tue, 27 Jun 2023 08:03:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25D013AC1
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 08:03:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196E91A4
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687853022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eV3eQXIpI7GK86spQgbBgb9YP8fkr4Uc5ICkyIAxi2s=;
	b=dj1MWrooHuO3rMvF2pXjhmFV7JWfLuYm2ABUX7mMjsc8Lrs/Y5MmtLFtp7w7tz82uLfFFV
	TUAPZZP01sXUoqmBobLw8+D9EVtMwQGw1sn7uRvcprrrBbxqAniO/eCizbxQjXLTa72XrR
	1HY6YmTjrZoFFxtio0HQbWGGL7xssN8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161--VLEzcP6NgSiZ1F-YMU53g-1; Tue, 27 Jun 2023 04:03:40 -0400
X-MC-Unique: -VLEzcP6NgSiZ1F-YMU53g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b69b2eb3f7so17732511fa.1
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853019; x=1690445019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eV3eQXIpI7GK86spQgbBgb9YP8fkr4Uc5ICkyIAxi2s=;
        b=JyzqWdMlZcqM/OePfsB0bGcEhzVV5WRjW0mMBTqxtE7cOBp5lX30U+qg4fAaC8akje
         xktHl+a9IIxO7TpHybjdh3aLmx6zMOSHZgiSYXzhhi5Tifl5rkIUn42/vvxdRtEhpmIA
         gXZX0FX0mQBCeeCS01W0GLjf3oJBo+mPehD04zWgI6LkbE71Ly7s9+28S15Qg4Nc+EGO
         9GF9S6Gnd9VQ+L/d8XFV19MMco1KhOSvz5Xd8tSbvfmb92oEtnwgn9I0Gb8CjtlOnrGe
         7NmiaC0IRcUvUb0Cx2pP/iFHCnuKg9m3k349MGLEIl930PE7YmEmai7GF8KKmDJA9s2L
         0lWA==
X-Gm-Message-State: AC+VfDzJWSlIr6zanYXq+ua3TMgRxOmxBzOmeryMFW9RL9bLObu8zjzn
	7AQuIj4o2LmfQGJN3lHEsiHYon459rQYWRai//hk2U772DWN1P60Nnfh6mg0GjrdqwimMu616oJ
	A6d52fnjYPgob4ndcoWG1lLvO+w4T
X-Received: by 2002:a05:651c:8f:b0:2b6:a17b:a120 with SMTP id 15-20020a05651c008f00b002b6a17ba120mr3522016ljq.22.1687853018833;
        Tue, 27 Jun 2023 01:03:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xju1Kw8PXR4eNgtQmaSoMhLrIsFLXo1LyKXcgnZgXB4na1UrEhIvvI/ONUbs4VdgeXtddNPmkh0ZyvZ27O0Q=
X-Received: by 2002:a05:651c:8f:b0:2b6:a17b:a120 with SMTP id
 15-20020a05651c008f00b002b6a17ba120mr3521994ljq.22.1687853018639; Tue, 27 Jun
 2023 01:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com> <20230602092206.50108-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230602092206.50108-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 16:03:26 +0800
Message-ID: <CACGkMEtFiutSpM--2agR1YhS0MxreH4vFFAEdCaC6E8qxyjZ4g@mail.gmail.com>
Subject: Re: [PATCH vhost v10 03/10] virtio_ring: split: support add premapped buf
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 5:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> If the vq is the premapped mode, use the sg_dma_address() directly.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 46 ++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2afdfb9e3e30..18212c3e056b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -598,8 +598,12 @@ static inline int virtqueue_add_split(struct virtque=
ue *_vq,
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
>                         dma_addr_t addr;
>
> -                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr=
))
> -                               goto unmap_release;
> +                       if (vq->premapped) {
> +                               addr =3D sg_dma_address(sg);
> +                       } else {
> +                               if (vring_map_one_sg(vq, sg, DMA_TO_DEVIC=
E, &addr))
> +                                       goto unmap_release;
> +                       }

Btw, I wonder whether or not it would be simple to implement the
vq->premapped check inside vring_map_one_sg() assuming the
!use_dma_api is done there as well.

>
>                         prev =3D i;
>                         /* Note that we trust indirect descriptor
> @@ -614,8 +618,12 @@ static inline int virtqueue_add_split(struct virtque=
ue *_vq,
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
>                         dma_addr_t addr;
>
> -                       if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &ad=
dr))
> -                               goto unmap_release;
> +                       if (vq->premapped) {
> +                               addr =3D sg_dma_address(sg);
> +                       } else {
> +                               if (vring_map_one_sg(vq, sg, DMA_FROM_DEV=
ICE, &addr))
> +                                       goto unmap_release;
> +                       }
>
>                         prev =3D i;
>                         /* Note that we trust indirect descriptor
> @@ -689,21 +697,23 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>         return 0;
>
>  unmap_release:
> -       err_idx =3D i;
> +       if (!vq->premapped) {

Can vq->premapped be true here? The label is named as "unmap_relase"
which implies "map" beforehand which seems not the case for
premapping.

Thanks


> +               err_idx =3D i;
>
> -       if (indirect)
> -               i =3D 0;
> -       else
> -               i =3D head;
> -
> -       for (n =3D 0; n < total_sg; n++) {
> -               if (i =3D=3D err_idx)
> -                       break;
> -               if (indirect) {
> -                       vring_unmap_one_split_indirect(vq, &desc[i]);
> -                       i =3D virtio16_to_cpu(_vq->vdev, desc[i].next);
> -               } else
> -                       i =3D vring_unmap_one_split(vq, i);
> +               if (indirect)
> +                       i =3D 0;
> +               else
> +                       i =3D head;
> +
> +               for (n =3D 0; n < total_sg; n++) {
> +                       if (i =3D=3D err_idx)
> +                               break;
> +                       if (indirect) {
> +                               vring_unmap_one_split_indirect(vq, &desc[=
i]);
> +                               i =3D virtio16_to_cpu(_vq->vdev, desc[i].=
next);
> +                       } else
> +                               i =3D vring_unmap_one_split(vq, i);
> +               }
>         }
>
>         if (indirect)
> --
> 2.32.0.3.g01195cf9f
>


