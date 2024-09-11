Return-Path: <bpf+bounces-39574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E4F97490B
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 06:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C2D1F268D9
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 04:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70A04501A;
	Wed, 11 Sep 2024 04:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDbUpHYv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6952BAEF
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726027704; cv=none; b=llWpUgYVVTfzbz6iNv5z4auAZ4TM0NPMNdaOVU1GWUjPBEn+nuZ6HlY8wIt+iSC78mc9uZTO3fGcDWC+JjqQu0o2aI6xRAFjzAXEcOVIogO6pwyXpdohbd3LsVVCApJahgjj6SmKkGAQlOFYWEzkzO0aZY3PH7HhZH8G/TCm1cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726027704; c=relaxed/simple;
	bh=AVhZdGRu8dpeR4b4F2jgIvNalKXiUOled0MascdxuZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OobIFI7NMXfl89jE6NgSuB8nnGvt9I+cU9ErKbmWYo2dfZloN0isHpzJKrE3Ipj/jJ2DYQk0yyy+ZBsozBvgKtCjG4/UJ1H+iMu+STYLIIZo0y6OIWiJlCMckiCdtaX3nRs9ZVj13vYlQk58I3uHMpxsQHSUZ1+J2RAoElztzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDbUpHYv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726027701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0shg6ORiFzwW+Vj2RjyGiWTgW5vV9/QyPqZaO+umrw=;
	b=CDbUpHYvAnWsbCJt3DkUnK1ukKH2ZtK0U/QSLg1MFaaf05cwCjjdt2VZo5gmCC6WS6i0zL
	fUhxGIuEG1RliU6hJuGhtA0hpv2dPeZlg2rpA0WwlctUW9i2QpSI0WUaFuU+635h4ds4cg
	N/I0L3f/X+x7/NfCNOuvQgR1z9cKXkM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-qQUwPDl3PKW48MqakR1LKQ-1; Wed, 11 Sep 2024 00:08:19 -0400
X-MC-Unique: qQUwPDl3PKW48MqakR1LKQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d8e7e427d5so522573a91.0
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 21:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726027698; x=1726632498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0shg6ORiFzwW+Vj2RjyGiWTgW5vV9/QyPqZaO+umrw=;
        b=Q2mPaI9YxLQvmDqlFhsc3tALrrVV8bvUHJqySoNzvrerOWCLOPr1Zrmjn5/EzrlYlH
         beCJPOCOHn+QgX5DQqBeRiMHysiC+qg1fH7DTyun/d0DAXfazljV6kuGkKS793imAHAZ
         J9yWzlaWQDZRvZ6sEnx0OGHfkHehoBebQcvmDBE+1PKUZyJsRTgMdPKUDHfbRvBmNKwy
         rI1XatP+VYR266eSCW61AmuBHJPlHXhEG2J1NhqUeHnxZCtlmju45ZXYzGvQhYQQU3qL
         RRR8kIL542gZYuhEYLjxaAvVK4ps1VsAUpwN9m5zWRwRZgXbX9VyHoFHgAUpWFieNfAa
         r4mw==
X-Forwarded-Encrypted: i=1; AJvYcCUk8GST79bx5REmhgi6y2i4WoXJ332PRIkgFSwUI4anefsx165GwDl+R2nQHtWe2EBzy5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMTOZbnw7D4pWjnP7wuGA5X4XJOrQyvSGBqMkpyoOhbFtVOU4i
	rsoSchEnt5Kd2oMatlQ8MVoy9myPOX4uwn/4XDafNYAW8HWYa2sNDyEuncfq7iW/Fo3YVOJAEQ1
	I+FgoP23AT5Cjt1qZH3PxtKIeJ9qBqqutGjL7Sa1wtOB/bt9o0hO8BWAIXV1z9J5VTRlDGAh0wl
	niCr4fvCC2QcL+5dwJCQjsNF20JEsmr/imIao=
X-Received: by 2002:a17:90b:c11:b0:2da:5863:fdbd with SMTP id 98e67ed59e1d1-2db6722519fmr7937414a91.17.1726027698107;
        Tue, 10 Sep 2024 21:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOcqVGVU9kAqU8Id60TW/drK/kX8DW3MCRfobzzdGZzCl0LDs7xbjJclqvOwKSLXmBDAI4DTN/H3ftyXYI1ac=
X-Received: by 2002:a17:90b:c11:b0:2da:5863:fdbd with SMTP id
 98e67ed59e1d1-2db6722519fmr7937359a91.17.1726027697475; Tue, 10 Sep 2024
 21:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 12:08:06 +0800
Message-ID: <CACGkMEuD9kp5Mgpqu+zszcYsiAyX_H-A-LfPM+YJPijeUtWJcw@mail.gmail.com>
Subject: Re: [PATCH net-next 08/13] virtio_net: xsk: bind/unbind xsk for tx
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This patch implement the logic of bind/unbind xsk pool to sq and rq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 54 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 96abee36738b..6a36a204e967 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -295,6 +295,10 @@ struct send_queue {
>
>         /* Record whether sq is in reset state. */
>         bool reset;
> +
> +       struct xsk_buff_pool *xsk_pool;
> +
> +       dma_addr_t xsk_hdr_dma_addr;
>  };
>
>  /* Internal representation of a receive virtqueue */
> @@ -494,6 +498,8 @@ struct virtio_net_common_hdr {
>         };
>  };
>
> +static struct virtio_net_common_hdr xsk_hdr;
> +
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buf=
f *xdp,
>                                struct net_device *dev,
> @@ -5476,6 +5482,29 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet=
_info *vi, struct receive_queu
>         return err;
>  }
>
> +static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> +                                   struct send_queue *sq,
> +                                   struct xsk_buff_pool *pool)
> +{
> +       int err, qindex;
> +
> +       qindex =3D sq - vi->sq;
> +
> +       virtnet_tx_pause(vi, sq);
> +
> +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> +       if (err) {
> +               netdev_err(vi->dev, "reset tx fail: tx queue index: %d er=
r: %d\n", qindex, err);
> +               pool =3D NULL;
> +       }
> +
> +       sq->xsk_pool =3D pool;
> +
> +       virtnet_tx_resume(vi, sq);
> +
> +       return err;
> +}
> +
>  static int virtnet_xsk_pool_enable(struct net_device *dev,
>                                    struct xsk_buff_pool *pool,
>                                    u16 qid)
> @@ -5484,6 +5513,7 @@ static int virtnet_xsk_pool_enable(struct net_devic=
e *dev,
>         struct receive_queue *rq;
>         struct device *dma_dev;
>         struct send_queue *sq;
> +       dma_addr_t hdr_dma;
>         int err, size;
>
>         if (vi->hdr_len > xsk_pool_get_headroom(pool))
> @@ -5521,6 +5551,10 @@ static int virtnet_xsk_pool_enable(struct net_devi=
ce *dev,
>         if (!rq->xsk_buffs)
>                 return -ENOMEM;
>
> +       hdr_dma =3D dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO=
_DEVICE);

Let's use the virtqueue_dma_xxx() wrappers here.

> +       if (dma_mapping_error(dma_dev, hdr_dma))
> +               return -ENOMEM;
> +
>         err =3D xsk_pool_dma_map(pool, dma_dev, 0);
>         if (err)
>                 goto err_xsk_map;
> @@ -5529,11 +5563,23 @@ static int virtnet_xsk_pool_enable(struct net_dev=
ice *dev,
>         if (err)
>                 goto err_rq;
>
> +       err =3D virtnet_sq_bind_xsk_pool(vi, sq, pool);
> +       if (err)
> +               goto err_sq;
> +
> +       /* Now, we do not support tx offset, so all the tx virtnet hdr is=
 zero.
> +        * So all the tx packets can share a single hdr.
> +        */
> +       sq->xsk_hdr_dma_addr =3D hdr_dma;
> +
>         return 0;
>
> +err_sq:
> +       virtnet_rq_bind_xsk_pool(vi, rq, NULL);
>  err_rq:
>         xsk_pool_dma_unmap(pool, 0);
>  err_xsk_map:
> +       dma_unmap_single(dma_dev, hdr_dma, vi->hdr_len, DMA_TO_DEVICE);
>         return err;
>  }
>
> @@ -5542,19 +5588,27 @@ static int virtnet_xsk_pool_disable(struct net_de=
vice *dev, u16 qid)
>         struct virtnet_info *vi =3D netdev_priv(dev);
>         struct xsk_buff_pool *pool;
>         struct receive_queue *rq;
> +       struct device *dma_dev;
> +       struct send_queue *sq;
>         int err;
>
>         if (qid >=3D vi->curr_queue_pairs)
>                 return -EINVAL;
>
> +       sq =3D &vi->sq[qid];
>         rq =3D &vi->rq[qid];
>
>         pool =3D rq->xsk_pool;
>
>         err =3D virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> +       err |=3D virtnet_sq_bind_xsk_pool(vi, sq, NULL);
>
>         xsk_pool_dma_unmap(pool, 0);
>
> +       dma_dev =3D virtqueue_dma_dev(sq->vq);
> +
> +       dma_unmap_single(dma_dev, sq->xsk_hdr_dma_addr, vi->hdr_len, DMA_=
TO_DEVICE);

And here.

Thanks

> +
>         kvfree(rq->xsk_buffs);
>
>         return err;
> --
> 2.32.0.3.g01195cf9f
>


