Return-Path: <bpf+bounces-34042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DB9929C77
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 08:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73B61F21BA5
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 06:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702E01862A;
	Mon,  8 Jul 2024 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inW4Efpl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E917545
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421393; cv=none; b=IvW8/4+AupkVR5EJ6TgfxqQpb8gfoITeuR+XICnQ7ZISM1xPT+Oe281E70H0cuE5VoYPGM6++EOei6uhCBpqkExwOoOfo2mNpehThgEYSKmJxcTa4FkVICdaftSjuf5kfCLyRvGuSRCO+lb4U0yS2VP7Jx77f5EWlJC8v9jw6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421393; c=relaxed/simple;
	bh=3H8vMevzIvzcJrAIQhm87D6MyRx2wml/VHmQuniqz9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLywHLJQ/3oiSMHATLl1wMeAd2FuvThtBdCXsFJ31BqCw+DcnJz70cg2bG5sQseyo6vNX+w/cSUuNrw2K25UiXpjcVZeTVXwejWt5wnMWII96mTYrG3DH+ugFcOd3KW1aQDXog25YaLucPTVkvX9HUDXQEdf+yzC75hwthCADKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inW4Efpl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720421390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIbDsP10xfc6NaCkPVB60tYpkZUzdhw3HKdYVd55mQA=;
	b=inW4EfplUMUO/ebqMY+PRfXufmkxoBnLLSAb5SudC8gqlx3ca43+MMJ8pOtK+I1eLHhM9E
	T3Yala/p+y4u2DFAUYvplHWG8/J8JAXKQU+vMaMmrQycSBxTxZ+crqXeZ2iPku7OGZWPzW
	PJ3NSFmyfh4QQWdVkvAjh9lko00yD6o=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-3qinF6PnOH-HcDjbFnOfFA-1; Mon, 08 Jul 2024 02:49:48 -0400
X-MC-Unique: 3qinF6PnOH-HcDjbFnOfFA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70af524f6b9so2070111b3a.2
        for <bpf@vger.kernel.org>; Sun, 07 Jul 2024 23:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720421387; x=1721026187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIbDsP10xfc6NaCkPVB60tYpkZUzdhw3HKdYVd55mQA=;
        b=lonOlwaa7dYsF0d26ysxMJ9EcL6wcQ9n7QOTuFUN7i+wMrjPH4jMZRB6h63dDYrSkp
         dvCFk3F2SMQZsCWPW6AaIGUQyr9sGrKfIpjGsLPGm6AY6qBEEXFeCCrdlgeLKmYD10mg
         A9AFUMYOd/PVomlQBUjI+KaPYcMGJa+xJf1LU6fREC5VZl7uwhA+Hbp8UEL1j4DvPu+x
         2/B1l1IpAzZX7fgflvNnq4PnPQ7NOzEynvetyVfYE5JnSDaoIxH0IrVRtA9k0Wt4TYxs
         SctK7/JyHHnPu1oKkP6MQb+RNlQvwIDX2B2AZihUKvq2MWHyd/uY7wzntNBgfFKvacrO
         OWyA==
X-Forwarded-Encrypted: i=1; AJvYcCVinOEmO1dUfBnK6LkTdKp9A+WRUO+6OxBQ4L+zs6xVSe+em4pPluVVPm11d2l9f+Xc99A4OVetFunKBFX8g6IsyHR1
X-Gm-Message-State: AOJu0Yx/kU1wvEVsHUUGOWnegPhbIWn3xGZY33rXc6xHOYZaDjxIXw4A
	DxNloWpeLBW1bEWfzdehTGBkM5PP942TbOt0DIpPypeBcAJWor66XHCWitbT7Drp3sw3xZPtlTZ
	4zisdKXKsHRRvqCEGJzUlQHqqv7cQKVKg8MphFTRsnEvZxVHKXbQPPMUmTn4gzJBfvXcuv7CQWZ
	hKgspZ2Xs4K3XAQJ4iX+qsusBk
X-Received: by 2002:a05:6a00:1da2:b0:706:6962:4b65 with SMTP id d2e1a72fcca58-70b009520a4mr7278062b3a.14.1720421387503;
        Sun, 07 Jul 2024 23:49:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiSyNQPaBEraFONt6FsI9Zk4on4jhj/4ZYxZehc8znesk8Dw39LiQoxSTRODV1PG/sr19cHEtsdkkC0A7SZxw=
X-Received: by 2002:a05:6a00:1da2:b0:706:6962:4b65 with SMTP id
 d2e1a72fcca58-70b009520a4mr7278051b3a.14.1720421387131; Sun, 07 Jul 2024
 23:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com> <20240705073734.93905-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240705073734.93905-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 14:49:35 +0800
Message-ID: <CACGkMEvW72oG-HsLiOwKdUkdOdKCFiyUAU6Nhj8Q4FFbnXAAqA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 08/10] virtio_net: xsk: rx: support fill with
 xsk buffer
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

On Fri, Jul 5, 2024 at 3:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Implement the logic of filling rq with XSK buffers.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>
> v7:
>    1. some small fixes
>
>  drivers/net/virtio_net.c | 70 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 66 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 29fa25ce1a7f..2b27f5ada64a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -354,6 +354,8 @@ struct receive_queue {
>
>         /* xdp rxq used by xsk */
>         struct xdp_rxq_info xsk_rxq_info;
> +
> +       struct xdp_buff **xsk_buffs;
>  };
>
>  /* This structure can contain rss message with maximum settings for indi=
rection table and keysize
> @@ -1054,6 +1056,53 @@ static void check_sq_full_and_disable(struct virtn=
et_info *vi,
>         }
>  }
>
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg->dma_address =3D addr;
> +       sg->length =3D len;
> +}
> +
> +static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct recei=
ve_queue *rq,
> +                                  struct xsk_buff_pool *pool, gfp_t gfp)
> +{
> +       struct xdp_buff **xsk_buffs;
> +       dma_addr_t addr;
> +       int err =3D 0;
> +       u32 len, i;
> +       int num;
> +
> +       xsk_buffs =3D rq->xsk_buffs;
> +
> +       num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> +       if (!num)
> +               return -ENOMEM;
> +
> +       len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> +
> +       for (i =3D 0; i < num; ++i) {
> +               /* use the part of XDP_PACKET_HEADROOM as the virtnet hdr=
 space */

It's better to also say we assume hdr->len is larger than
XDP_PACKET_HEADROOM. (see function xyz).

> +               addr =3D xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len=
;
> +
> +               sg_init_table(rq->sg, 1);
> +               sg_fill_dma(rq->sg, addr, len);
> +
> +               err =3D virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[=
i], gfp);
> +               if (err)
> +                       goto err;
> +       }
> +
> +       return num;
> +
> +err:
> +       if (i)
> +               err =3D i;

Any reason to assign an index to err here?

Others look good.

Thanks


