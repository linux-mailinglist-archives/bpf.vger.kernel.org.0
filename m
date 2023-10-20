Return-Path: <bpf+bounces-12793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085017D08CA
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 08:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A965B21397
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 06:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB7CA67;
	Fri, 20 Oct 2023 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJ8e+6OO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E6C8E4
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:51:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2C198
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697784669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crwaKaePMEZqRzjOk6ARvGGv9aJDmk5zOwJBkKiIeIc=;
	b=YJ8e+6OO6jaZ7Oox4AnGr00MMf5ZizCtno7tNKSWxiWXrC78KEfyKfo2PJOtRJff4rXzeA
	IlGxuEJ2+0YHIsplA5AKOZkR13I3f1e0Z/88e6L3wiuHCB56kYo9cvfJGxzT/MQMUhJNbu
	MbKPdx4i9w80o5YetJVXlyDfiGO+COU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-QtpnntKCMZW5fDniUk5TBg-1; Fri, 20 Oct 2023 02:51:06 -0400
X-MC-Unique: QtpnntKCMZW5fDniUk5TBg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5079fd97838so428623e87.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784664; x=1698389464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crwaKaePMEZqRzjOk6ARvGGv9aJDmk5zOwJBkKiIeIc=;
        b=BLCuZFYTr2HbrwjQAiqkzaIUURY3TffYhmrBzohLCO8N18pMGbo/EpoXlf8f6kwkA9
         Nosxb7Nj1ZG3XMRzQef2+WDUqJQktOAxfyFYL82ttbl1DXH23Vz+7a0sIzN+p7a4nF/J
         Yb6gztsWxHIPb124aho4uuomzBKOi7r7Z0o67Aoti5NyPFfIK1tcy8pGjAFRBWfrN8oj
         qtZmCY2V9nN0M9/7KCyRFYRLcFj3Rq2MBzjm9xZMmnfAMfWPIcNsxMoWtZF4Pl8B3Snq
         YiM3ew1Iq6sVws3mfbqhb6C699NHLveV4KF7oWNhmHl1BVINkobOUj+iGdWXpFjZ4aqD
         Wm/g==
X-Gm-Message-State: AOJu0YzpJkgx9LDvr6Bf/6/UoW29xTQED+OSnRTz5q3MTzooy7joJGt+
	UmpOxCyjDv99tanpdPAnQxNcDOC6p2bczAOfFm5ifFlgGWSeUZd3MZX0iHJ9LOaRcL96Y87tYyc
	yNRP50WeDTRNzZhqyNCeUv1OOFDZNemgnAKgYsQk=
X-Received: by 2002:a05:6512:3094:b0:500:9dd4:2969 with SMTP id z20-20020a056512309400b005009dd42969mr619344lfd.59.1697784664107;
        Thu, 19 Oct 2023 23:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYQPJLf7vs3BLmZJ52qeoke4CdfBTo8vgI6dD81vASHojo8uRB5TjPI7cvhTZebQi6LtEdhmZ9zb7VvjcDQ/8=
X-Received: by 2002:a05:6512:3094:b0:500:9dd4:2969 with SMTP id
 z20-20020a056512309400b005009dd42969mr619342lfd.59.1697784663734; Thu, 19 Oct
 2023 23:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:50:52 +0800
Message-ID: <CACGkMEuq8i9_PX+vRESS3g2BpaWBv3FxDLMryG=aEJ+gAOsSaA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 08/19] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 108 ++++++++++++++++++++++++++++----
>  drivers/net/virtio/virtio_net.h |  54 +++++++++++++++-
>  2 files changed, 149 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 8da84ea9bcbe..02d27101fef1 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -514,20 +514,104 @@ static void *virtnet_rq_alloc(struct virtnet_rq *r=
q, u32 size, gfp_t gfp)
>         return buf;
>  }
>
> -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> +static int virtnet_sq_set_premapped(struct virtnet_sq *sq)
>  {
> -       int i;
> +       struct virtnet_sq_dma *d;
> +       int err, size, i;
>
> -       /* disable for big mode */
> -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> -               return;

Not specific to this patch but any plan to fix the big mode?


> +       size =3D virtqueue_get_vring_size(sq->vq);
> +
> +       size +=3D MAX_SKB_FRAGS + 2;
> +
> +       sq->dmainfo.head =3D kcalloc(size, sizeof(*sq->dmainfo.head), GFP=
_KERNEL);
> +       if (!sq->dmainfo.head)
> +               return -ENOMEM;
> +
> +       err =3D virtqueue_set_dma_premapped(sq->vq);
> +       if (err) {
> +               kfree(sq->dmainfo.head);
> +               return err;
> +       }
> +
> +       sq->dmainfo.free =3D NULL;
> +
> +       sq->do_dma =3D true;
> +
> +       for (i =3D 0; i < size; ++i) {
> +               d =3D &sq->dmainfo.head[i];
> +
> +               d->next =3D sq->dmainfo.free;
> +               sq->dmainfo.free =3D d;
> +       }
> +
> +       return 0;
> +}
> +
> +static void virtnet_set_premapped(struct virtnet_info *vi)
> +{
> +       int i;
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> +               if (!virtnet_sq_set_premapped(&vi->sq[i]))
> +                       vi->sq[i].do_dma =3D true;
> +
> +               /* disable for big mode */
> +               if (!vi->mergeable_rx_bufs && vi->big_packets)
>                         continue;
>
> -               vi->rq[i].do_dma =3D true;
> +               if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
> +                       vi->rq[i].do_dma =3D true;
> +       }
> +}
> +
> +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct virtnet_sq *sq, i=
nt nents, void *data)
> +{
> +       struct virtnet_sq_dma *d, *head;
> +       struct scatterlist *sg;
> +       int i;
> +
> +       head =3D NULL;
> +
> +       for_each_sg(sq->sg, sg, nents, i) {
> +               sg->dma_address =3D virtqueue_dma_map_single_attrs(sq->vq=
, sg_virt(sg),
> +                                                                sg->leng=
th,
> +                                                                DMA_TO_D=
EVICE, 0);
> +               if (virtqueue_dma_mapping_error(sq->vq, sg->dma_address))
> +                       goto err;
> +
> +               d =3D sq->dmainfo.free;
> +               sq->dmainfo.free =3D d->next;
> +
> +               d->addr =3D sg->dma_address;
> +               d->len =3D sg->length;
> +
> +               d->next =3D head;
> +               head =3D d;

It's really a pity that we need to duplicate those DMA metata twice.
Could we invent a new API to just fetch it from the virtio core?

> +       }
> +
> +       head->data =3D data;
> +
> +       return (void *)((unsigned long)head | ((unsigned long)data & VIRT=
IO_XMIT_DATA_MASK));

If we packed everything into dmainfo, we can leave the type (XDP vs
skb) there to avoid trick like packing it into the pointer here?

Thanks


