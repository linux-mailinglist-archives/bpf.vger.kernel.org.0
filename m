Return-Path: <bpf+bounces-19360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD7B82A93A
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 09:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6FB1C21D39
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311BCF512;
	Thu, 11 Jan 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bfa4pMU/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423AC539D
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704962445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbUkvBoj8gxLrACYWyhfe3FGuAwpnKYJCy4ANl1OWAQ=;
	b=Bfa4pMU/FlPj1gZrH9k+Z79ytKtz7bQUr+980xbJqZnN4oIRtt5BttQHSJJ0D1S6dF0D2T
	dOaLH3fkO7pR+pPzDHOHsN0/eLfcqJ1dxW/X5CVnK6g9+9eVQbvw0p5HTTQU79fWo+iRW7
	ngqFztA3+TIZC+APS3YpFqHIyeQYp+c=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-cZkuOzrLNNaUu0K97bCEMA-1; Thu, 11 Jan 2024 03:40:44 -0500
X-MC-Unique: cZkuOzrLNNaUu0K97bCEMA-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bef67c486aso147228339f.2
        for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 00:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704962444; x=1705567244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbUkvBoj8gxLrACYWyhfe3FGuAwpnKYJCy4ANl1OWAQ=;
        b=ufrqbWbyuaJ3RVpLhmwLO3vIvDgAVbgN64kvfxZwxw8W6cni5L83AHM9q59iQA6J79
         bALuCfO9IMiWTpzJOcEFnZ3Q8zDgFkQboYjbnLIXWrQwUaIEyYhWlPVz+M802oaCDhzg
         tAH1FXF3VJhGvsguJ8sPTRb8llvP6r/ifbexhoHzB+iC3GqEcsT+ic+aEC9J3gqTdkGU
         V6HSqN+w8CLzXO6SNzuK+ESaMu418Jd8jCwbtnlgCPu1+9AjHEyRxT0hEuln7J6VoXca
         3AzgEXVaGMj3TF27YIQ8jOj0wJY5BrgHmCuhEIsO7YNFiaxYDcdy2XXfrj+zjG79fvFj
         dN1g==
X-Gm-Message-State: AOJu0Yy8xMrt9Dn0tihSGJ2hi6RgY+g6wFVuxt2fwjhSyB9atc+WUEPL
	TI/uibBEkrOJWCQu+wfK/pnkm6BRKOmt0+X8hOClYJr74Z8K4/EYrh/VWbHufwaU23HjePnoJki
	KPZJkvUG4k/V214m94znziVR8OtXmm9r1um4x
X-Received: by 2002:a05:6808:128b:b0:3bd:3225:4be3 with SMTP id a11-20020a056808128b00b003bd32254be3mr801914oiw.71.1704962060415;
        Thu, 11 Jan 2024 00:34:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBRprWzEj5DmMX32LaMUs1+qfaZPU6alpcl5pE809RY8gFTAICGop4IB9CnQEXSpHBKdpk2dfokvLOl5dCxe8=
X-Received: by 2002:a05:6808:128b:b0:3bd:3225:4be3 with SMTP id
 a11-20020a056808128b00b003bd32254be3mr801909oiw.71.1704962060197; Thu, 11 Jan
 2024 00:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com> <20231229073108.57778-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231229073108.57778-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:34:09 +0800
Message-ID: <CACGkMEvaTr1iT1M7DXN1PNOAZPM75BGv-wTOkyqb-7Sgjshwaw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/27] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> get buf from virtio core for premapped mode.
>
> If the virtio queue is premapped mode, the virtio-net send buf may
> have many desc. Every desc dma address need to be unmap. So here we
> introduce a new helper to collect the dma address of the buffer from
> the virtio core.
>
> Because the BAD_RING is called (that may set vq->broken), so
> the relative "const" of vq is removed.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 174 +++++++++++++++++++++++++----------
>  include/linux/virtio.h       |  16 ++++
>  2 files changed, 142 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..1374b3fd447c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -362,6 +362,45 @@ static struct device *vring_dma_dev(const struct vri=
ng_virtqueue *vq)
>         return vq->dma_dev;
>  }
>
> +/*
> + *     use_dma_api premapped -> do_unmap
> + *  1. false       false        false
> + *  2. true        false        true
> + *  3. true        true         false
> + *
> + * Only #3, we should return the DMA info to the driver.

Btw, I guess you meant "#3 is false" here?

And could we reduce the size of these 3 * 3 matrices? It's usually a
hint that the code is not optmized.

Thanks


