Return-Path: <bpf+bounces-3542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD6373F66B
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 10:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E10281082
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 08:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC5B168A5;
	Tue, 27 Jun 2023 08:03:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2E116439
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 08:03:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21A41A4
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687853024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Sijha0YXJUjNDfHLb+Azz4YINEqeJlQ8jO8DuRzjtc=;
	b=COsHtKR8SM6M8zk168LjKZ9hemNlDG1tiEEOKs3HYkqt6tCt0uigehlDVpukHPlELdaQfi
	iYLkhQc2q+grhVL68c7N+cKZEs30ICltvnlNHlieXhd8Z5K+L/9JjVxZ5KDa/w4F57dikV
	nNLu2nd0qn56VI7nYE8hJm9k/Re+Os8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-FOMhTaQaPKKswbQT1KGOXg-1; Tue, 27 Jun 2023 04:03:42 -0400
X-MC-Unique: FOMhTaQaPKKswbQT1KGOXg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b620465d0eso20392771fa.0
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853021; x=1690445021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Sijha0YXJUjNDfHLb+Azz4YINEqeJlQ8jO8DuRzjtc=;
        b=Yb04RH1k9aGd8eetel+ry1/oHTFniKmywoSViXYBHiCetAeR66V0Wm3M5PBf2YbRSk
         ZXCytXq/vpuiag+nj1uf3H3yD2ixTraGwJnbtj3xflmN7dicOZfPXzVEA3nYESgv9XWk
         fc8/RHKwrulF35TqxxwNcpK4JDizC7tEtlVYxH8BJDWvITHRL09snlhP9V2xzfSLNyqd
         sJWZZ0U4YUCdgf5fJsBV65qDnAEdlW+htpdppd9qsdCviZmPKlolqgMk0IHFjr1mnWBg
         DHrXHmtUZiMC50HUHPcqVkaRaDg0lnjPXdshWnkPDeZBXhY386oRgHk+NVZMqhAHrxXg
         K5Zw==
X-Gm-Message-State: AC+VfDwX2QSD8eGSh6uxKJr+5UvQWsHKD9pqggGEqfquOT+DGTDuieOY
	bS2deU1nQOzFakcN2mtFRIwVwVtusdG7tHSHKMCxjW/ekiQcyDtkEbUfpUx4hAmtvhrbH0xDy5u
	5MUdGFY2c/exCX/Uh94ELVTY8iLJG
X-Received: by 2002:a2e:9619:0:b0:2b6:a59c:5e02 with SMTP id v25-20020a2e9619000000b002b6a59c5e02mr3038566ljh.20.1687853020809;
        Tue, 27 Jun 2023 01:03:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bcmfHyMmURgW7H/N4Q0xvQrGAHQn5HeoHqiK6eNWEjZw8/c0ufCAuMNVB1pTSagyYRiNhsx+f+VI3S81N0Bs=
X-Received: by 2002:a2e:9619:0:b0:2b6:a59c:5e02 with SMTP id
 v25-20020a2e9619000000b002b6a59c5e02mr3038552ljh.20.1687853020520; Tue, 27
 Jun 2023 01:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com> <20230602092206.50108-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230602092206.50108-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 16:03:29 +0800
Message-ID: <CACGkMEuoBtQ+=kJJk84Vs2sk7WAdh8O3d2wJLM-yBFAtkgLEUA@mail.gmail.com>
Subject: Re: [PATCH vhost v10 04/10] virtio_ring: packed: support add
 premapped buf
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
>  drivers/virtio/virtio_ring.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 18212c3e056b..dc109fbc05a5 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1299,9 +1299,13 @@ static int virtqueue_add_indirect_packed(struct vr=
ing_virtqueue *vq,
>
>         for (n =3D 0; n < out_sgs + in_sgs; n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> -                       if (vring_map_one_sg(vq, sg, n < out_sgs ?
> -                                            DMA_TO_DEVICE : DMA_FROM_DEV=
ICE, &addr))
> -                               goto unmap_release;
> +                       if (vq->premapped) {
> +                               addr =3D sg_dma_address(sg);
> +                       } else {
> +                               if (vring_map_one_sg(vq, sg, n < out_sgs =
?
> +                                                    DMA_TO_DEVICE : DMA_=
FROM_DEVICE, &addr))
> +                                       goto unmap_release;
> +                       }
>
>                         desc[i].flags =3D cpu_to_le16(n < out_sgs ?
>                                                 0 : VRING_DESC_F_WRITE);
> @@ -1369,10 +1373,12 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>         return 0;
>
>  unmap_release:
> -       err_idx =3D i;
> +       if (!vq->premapped) {
> +               err_idx =3D i;
>
> -       for (i =3D 0; i < err_idx; i++)
> -               vring_unmap_desc_packed(vq, &desc[i]);
> +               for (i =3D 0; i < err_idx; i++)
> +                       vring_unmap_desc_packed(vq, &desc[i]);
> +       }
>
>         kfree(desc);
>
> @@ -1447,9 +1453,13 @@ static inline int virtqueue_add_packed(struct virt=
queue *_vq,
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
>                         dma_addr_t addr;
>
> -                       if (vring_map_one_sg(vq, sg, n < out_sgs ?
> -                                            DMA_TO_DEVICE : DMA_FROM_DEV=
ICE, &addr))
> -                               goto unmap_release;
> +                       if (vq->premapped) {
> +                               addr =3D sg_dma_address(sg);
> +                       } else {
> +                               if (vring_map_one_sg(vq, sg, n < out_sgs =
?
> +                                                    DMA_TO_DEVICE : DMA_=
FROM_DEVICE, &addr))
> +                                       goto unmap_release;
> +                       }
>
>                         flags =3D cpu_to_le16(vq->packed.avail_used_flags=
 |
>                                     (++c =3D=3D total_sg ? 0 : VRING_DESC=
_F_NEXT) |
> @@ -1512,11 +1522,17 @@ static inline int virtqueue_add_packed(struct vir=
tqueue *_vq,
>         return 0;
>
>  unmap_release:
> +       vq->packed.avail_used_flags =3D avail_used_flags;
> +
> +       if (vq->premapped) {

Similar to the split path, I think we can't hit vq->premapped here.

Thanks


> +               END_USE(vq);
> +               return -EIO;
> +       }
> +
>         err_idx =3D i;
>         i =3D head;
>         curr =3D vq->free_head;
>
> -       vq->packed.avail_used_flags =3D avail_used_flags;
>
>         for (n =3D 0; n < total_sg; n++) {
>                 if (i =3D=3D err_idx)
> --
> 2.32.0.3.g01195cf9f
>


