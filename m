Return-Path: <bpf+bounces-4834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1AE750192
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407A41C21102
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F17DDBC;
	Wed, 12 Jul 2023 08:31:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F66638
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 08:31:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABD430CF
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689150710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMY8N4GgkrsaFITZViPaX/26omPvMDOYikNXpePFX8U=;
	b=J9mTj7GQOTLJcGFvm1eoSLDTfJD8IX13x8vaUB4X/N66f3l9SOOVNJGPA0AO0xByuZujFo
	9dwN1MpLM6b8E2stSptCGvXXFmY5SGtdmyzsK8BVjHR2W8CE90YUuCEYt7iMzG0UxlkOa2
	/mGOvcUFGhjCmNujbD7ZBOovPMvTxxs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-NrFVGO3EOYukaN9v5a6vYA-1; Wed, 12 Jul 2023 04:31:49 -0400
X-MC-Unique: NrFVGO3EOYukaN9v5a6vYA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b6ad424a46so64548201fa.3
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 01:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689150708; x=1691742708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMY8N4GgkrsaFITZViPaX/26omPvMDOYikNXpePFX8U=;
        b=lLEBVUdyhJ+PR0aQEhKybFF1eBRiJQdpXPdXXCECXDY6YUhhVSJr+P+rxwGgleHS8l
         ze1dGYPYCdaQeFrQqIRdYSBzDh/4cYw5voLo7dhsRwz4+W0hAlpN0GwUlvsXUdV9eRQy
         /v7ETCFH06zX1+kcRdZXiwdWhzbRLoW46oi0ZXbgaJwU+zTVWmP/T0KN7CbAQKOErYDV
         epMh0z3eBa41KTarRl4kKQFoBlwYhH0rBGksaOR8rnSlWpLZyy+2jTa3R3dLRS3DPEjz
         +ZVdJBg4UC0dSE3EIib9rKmJidnQ4Hsrc9GHR8b4CpG8kpiPQShhJXgCFWeGMqYKQXHr
         ytpA==
X-Gm-Message-State: ABy/qLba5WZRaVtVyoIlk7VD0YOVduuQelvHk9GRz9R4jogJPlBbxsMJ
	OLqoHr82kemX0VJNy4LeZISHrgWcq8P5BILqqaicPeah27CoWvskqbdkuP/MHU/l2exySGMbREV
	OypN6Dr51RIPLvhioMS3yq1yXQSt9
X-Received: by 2002:a2e:b0c7:0:b0:2b6:ec69:7c3b with SMTP id g7-20020a2eb0c7000000b002b6ec697c3bmr14248581ljl.46.1689150707781;
        Wed, 12 Jul 2023 01:31:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH8VQdPippc4jzXJqOkjPYz7uzhQc4c9Zm733Etko9K6J3AzHieVFvn79o9Yal5pESop9imlfRDh3vOC46gGBc=
X-Received: by 2002:a2e:b0c7:0:b0:2b6:ec69:7c3b with SMTP id
 g7-20020a2eb0c7000000b002b6ec697c3bmr14248566ljl.46.1689150707490; Wed, 12
 Jul 2023 01:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com> <20230710034237.12391-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230710034237.12391-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jul 2023 16:31:35 +0800
Message-ID: <CACGkMEu16kUX02L+zb=hcX_sMW-s6wBFtiCRC_3H4ky4iDdy4Q@mail.gmail.com>
Subject: Re: [PATCH vhost v11 04/10] virtio_ring: support add premapped buf
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
> If the vq is the premapped mode, use the sg_dma_address() directly.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 5ace4539344c..d471dee3f4f7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -361,6 +361,11 @@ static struct device *vring_dma_dev(const struct vri=
ng_virtqueue *vq)
>  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct sca=
tterlist *sg,
>                             enum dma_data_direction direction, dma_addr_t=
 *addr)
>  {
> +       if (vq->premapped) {
> +               *addr =3D sg_dma_address(sg);
> +               return 0;
> +       }
> +
>         if (!vq->use_dma_api) {
>                 /*
>                  * If DMA is not used, KMSAN doesn't know that the scatte=
rlist
> @@ -639,8 +644,12 @@ static inline int virtqueue_add_split(struct virtque=
ue *_vq,
>                 dma_addr_t addr =3D vring_map_single(
>                         vq, desc, total_sg * sizeof(struct vring_desc),
>                         DMA_TO_DEVICE);
> -               if (vring_mapping_error(vq, addr))
> +               if (vring_mapping_error(vq, addr)) {
> +                       if (vq->premapped)
> +                               goto free_indirect;

Under which case could we hit this? A bug of the driver?

Thanks

> +
>                         goto unmap_release;
> +               }
>
>                 virtqueue_add_desc_split(_vq, vq->split.vring.desc,
>                                          head, addr,
> @@ -706,6 +715,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                         i =3D vring_unmap_one_split(vq, i);
>         }
>
> +free_indirect:
>         if (indirect)
>                 kfree(desc);
>
> @@ -1307,8 +1317,12 @@ static int virtqueue_add_indirect_packed(struct vr=
ing_virtqueue *vq,
>         addr =3D vring_map_single(vq, desc,
>                         total_sg * sizeof(struct vring_packed_desc),
>                         DMA_TO_DEVICE);
> -       if (vring_mapping_error(vq, addr))
> +       if (vring_mapping_error(vq, addr)) {
> +               if (vq->premapped)
> +                       goto free_desc;
> +
>                 goto unmap_release;
> +       }
>
>         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
>         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
> @@ -1366,6 +1380,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         for (i =3D 0; i < err_idx; i++)
>                 vring_unmap_desc_packed(vq, &desc[i]);
>
> +free_desc:
>         kfree(desc);
>
>         END_USE(vq);
> --
> 2.32.0.3.g01195cf9f
>


