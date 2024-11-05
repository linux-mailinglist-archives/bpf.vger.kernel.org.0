Return-Path: <bpf+bounces-44006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C29BC455
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 05:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07BFB21599
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 04:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D041B219F;
	Tue,  5 Nov 2024 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vjf89mA5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696118FDAC
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 04:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780916; cv=none; b=WktUz23/CkB2e1VzG/QKEXN4hDS/QKYR5P7ww2AXIO4GUkQUezyqcgKe4uAA/lP+CbFjnAjRSDDtFWsIQZEKEjpEFfgVXJpqJpvTXS/KVYeFtn2KlrMASMJfOUVza0eDAIAnlUdLFL9rSJD2b0MN/KZK0aFbTsWIoJaeLH9lOJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780916; c=relaxed/simple;
	bh=jCOhmUK6IbEIRDl5mkQTmEZnPSs5BTtuXv8Ub6PBav4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eD1Hdhb8MFjTdLp9UjGuuG2wjp9JBdrhxERDoka0Q1UI4nVu9K/Q7xgnBoFzyUZtG7AlDoXdDRrAPgq93ZvbSiu6QAYzswEn3Oxr+jhMoiqIYlY/ZhhNK/h22h70zLrXnw3E1OJR9wNSor786dqPdDJpjzKVSYu23k4eboDLa/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vjf89mA5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730780913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WNP/eiwwlyjDkpO5BsHHqJGwhWGw0F0hz9Z4SjJmr0=;
	b=Vjf89mA5eWElCFxe2ZYB3fYtWNWc1QURZsRghH1R+h0pOy04xAVMHL6iP072oaLYt4z4Yn
	f+3YD6rXe+zSVxzdT1Gl2C47Kg4wjYwo76br882znYJiEv+HqjIIKKUWvw2lI7/Mj3/5/l
	WvCEsIF5OR4MsahAqO1ATC/FSiFOFJk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-5Oztqh8kMne07Zg_0PThpA-1; Mon, 04 Nov 2024 23:28:30 -0500
X-MC-Unique: 5Oztqh8kMne07Zg_0PThpA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e2e146c77cso6534363a91.3
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 20:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730780909; x=1731385709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WNP/eiwwlyjDkpO5BsHHqJGwhWGw0F0hz9Z4SjJmr0=;
        b=M52cyYVfGxCacnLNaji1WcRvr8FNdrcO3p63+Px22HgfGbA+NSciVEve/rfmPRCllo
         jCRYdFyM9FLcB4AXH0P6hjA2nmeG3BV+BVnBMBCSMc9rH06aZlaxXaA6sUHV0iVDw1ge
         Epvp9pWfHO0qOMAWHoKrq6C93PplD/3tEdvRWjv2Jg2z2rNDZ5/ShyBhT5ckEdq0qvOL
         zWa7Net96L3ZYWScGI/xFbgFA6oQlZTLOK57OEhzuP3jolMsZU3HO3fTdV83TvE+T6IX
         rJ/OOsOaY30D6iYCJvbcQNMhNJbvdzDVlbAM2ubSMh0JnNsNui5+zXqhCyfUCVIVQmXl
         TGNA==
X-Forwarded-Encrypted: i=1; AJvYcCW2UttOD16+gaRiQ6ouDZ+fZFps437Oy1F2e5rbJfMz3m/zaRqXAqSptXR9HW4uoGDMFtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxODqsdy5XwWf/mCxwCk3Y82OC1x/04YTCYrcJx6Nj4FPqz3OP
	D99coBLqQ1XkUgIaeb0zuodk/07r7V1QWotOjx4c4HVWOvqojDP6plFanjp1VD5S/5S71XXLJgf
	7ahFekXzHIktvWwpMigeSutkLZXJRrJZPfaJuoHyvo0V3XkVuD8TLSPavyxxdnSXfidpO4WdtIf
	KoxpAOUFV+ilPza/R/DIXLOKX8
X-Received: by 2002:a17:90b:2703:b0:2e2:bad3:e393 with SMTP id 98e67ed59e1d1-2e93c1239b8mr23888102a91.3.1730780909403;
        Mon, 04 Nov 2024 20:28:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCqHP1v9rviscFmYSIZGGEle1Y/T+Yx3tavSzj80nHe7tuCQVnZBAYxDS5nHUdLvz4jkM+KeZYvQfYErHiRy0=
X-Received: by 2002:a17:90b:2703:b0:2e2:bad3:e393 with SMTP id
 98e67ed59e1d1-2e93c1239b8mr23888074a91.3.1730780908928; Mon, 04 Nov 2024
 20:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com> <20241030082453.97310-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241030082453.97310-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 12:28:18 +0800
Message-ID: <CACGkMEuO4Y04nLLJDXD_atHz8-yD=sk1QLYPidoJSPtAn+ycqQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/13] virtio_ring: introduce add api for premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Two APIs are introduced to submit premapped per-buffers.
>
> int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
>                                  struct scatterlist *sg, unsigned int num=
,
>                                  void *data,
>                                  void *ctx,
>                                  bool premapped,
>                                  gfp_t gfp);
>
> int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
>                                   struct scatterlist *sg, unsigned int nu=
m,
>                                   void *data,
>                                   bool premapped,
>                                   gfp_t gfp);
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 48 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       | 13 ++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a89295b79e66..525308d82728 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2272,6 +2272,29 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
>
> +/**
> + * virtqueue_add_outbuf_premapped - expose output buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sg: scatterlist (must be well-formed and terminated!)
> + * @num: the number of entries in @sg readable by other side
> + * @data: the token identifying the buffer.
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
> +                                  struct scatterlist *sg, unsigned int n=
um,
> +                                  void *data,
> +                                  bool premapped,

We don't need this parameter consider:

1) we've already had virtqueue_add_outbuf() which implies the buf has
been mapped
2) no explanation for "premapped" in the function doc

Thanks

> +                                  gfp_t gfp)
> +{
> +       return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, premapped, g=
fp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_outbuf_premapped);
> +
>  /**
>   * virtqueue_add_inbuf - expose input buffers to other end
>   * @vq: the struct virtqueue we're talking about.
> @@ -2318,6 +2341,31 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
>
> +/**
> + * virtqueue_add_inbuf_premapped - expose input buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sg: scatterlist (must be well-formed and terminated!)
> + * @num: the number of entries in @sg writable by other side
> + * @data: the token identifying the buffer.
> + * @ctx: extra context for the token
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
> +                                 struct scatterlist *sg, unsigned int nu=
m,
> +                                 void *data,
> +                                 void *ctx,
> +                                 bool premapped,
> +                                 gfp_t gfp)
> +{
> +       return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, premapped, gf=
p);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
> +
>  /**
>   * virtqueue_dma_dev - get the dma dev
>   * @_vq: the struct virtqueue we're talking about.
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 306137a15d07..19afa49b92d0 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -56,6 +56,19 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
>                             void *ctx,
>                             gfp_t gfp);
>
> +int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
> +                                 struct scatterlist *sg, unsigned int nu=
m,
> +                                 void *data,
> +                                 void *ctx,
> +                                 bool premapped,
> +                                 gfp_t gfp);
> +
> +int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
> +                                  struct scatterlist *sg, unsigned int n=
um,
> +                                  void *data,
> +                                  bool premapped,
> +                                  gfp_t gfp);
> +
>  int virtqueue_add_sgs(struct virtqueue *vq,
>                       struct scatterlist *sgs[],
>                       unsigned int out_sgs,
> --
> 2.32.0.3.g01195cf9f
>


