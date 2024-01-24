Return-Path: <bpf+bounces-20198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8456083A25D
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 07:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782FB1C223A0
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 06:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C718712E70;
	Wed, 24 Jan 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxAHULOI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9EF171A1
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079262; cv=none; b=dpw8YztsIptcEoyj/vImsskvbmpuH88lzJuH6kE0+8/0sAJuBakKlpd62Pa4qTmYQ87TEiWxDpm+PM2VoLD6pJxMb+XisCK1I0TvJ9gOHo9KqcnmVlgZ2KmXeDLxBO0GwbPg6tutMGfkBYLbha9GB1+2n3J4yKZk9as0WBouo3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079262; c=relaxed/simple;
	bh=bXLHhCWG8ib/Q4jwzuKltCw5EdLI7RU1NLepwC90sjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryWVtXCyDjMYqH29rN2FijDfh2ExhQftyyAHd5OJM7didUejn0kPwowLlVgqUA58Nf/3sQAkWVV+IRANb0oBcMIUGCd1PKBgGZBbpuEgBJlNBH+otgtiFKBNTXxA7CutXSXq654cb3PsVdSSAbqn203/Wlpi7qd9cS2f3aHMvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxAHULOI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706079259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1zAT6ss45JjnUY5iL6ZvjV72g+BOh7hKWM+9TGSW6bc=;
	b=LxAHULOIUnQWQ/5sXdqKCnSFQof1zVq/sUpO2anoO81V2p+VFGbZ3mnYVJ/CqzX/6YYtDs
	9watC+SNwQqvgSDBqC4OWD+lrh13AdvMOQW8TGDegnUxJQDPHHvybNzgE8npmmRWBm6udw
	rIYBZccS7nLpOKwWq+4e/aX1MigDpwg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-ZsN0pfCNOfaDLIfBa9ssuw-1; Wed, 24 Jan 2024 01:54:18 -0500
X-MC-Unique: ZsN0pfCNOfaDLIfBa9ssuw-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6ddeb87827eso6677846a34.1
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 22:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706079257; x=1706684057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zAT6ss45JjnUY5iL6ZvjV72g+BOh7hKWM+9TGSW6bc=;
        b=UitJT8O7gA0Yf2DwqCRAeeHQGi0o6Lm52YFbdxrig0OoH1AL7F82UZ056IBvDoOken
         xEdhEpJJtkr6vBo06cdH9z/uF/aLL53dQb3b5XETpsiRs6SZXCFkL5xG8ctpPaBPNRW9
         PTCWXAFtlLmHKFqjgJODSDtaHfcDl7txI7pyV4DoaOgysIvshTB9t7OnDAKCZ5aW2KVg
         Xn2g1Az5M0TkCcrgfmUBQlqsCUX6GgTGUvWoOckMYba5JF1Z++LziQdSvDEhUqEFTzRY
         0+pCHBsMjKXyXCO1ahYpUjnJu4An8zkYlbDGg+qJDni4PlcJ01Nwi3Su/6px7D31vwM/
         9IcQ==
X-Gm-Message-State: AOJu0YxaoTgTAA7CGM5eyAQLlNnDR0xnHoMRjTn2XuigUEyOgLOfh+Zg
	3NNcQxbbE55p6AABwvN50R2l4xmySGapkkC5YXhSzlulrd0md50r/2ZGNjH+mJk31zitM4lL88S
	psptE3z9LTKh6BnUGsyH8FAx99bePSjkmA1NxExpM2bM2LYn23ZImYk5gesWI1W19MwAq75Xx/5
	buw9fv4Uhp+kje1hK/2T06F6LV
X-Received: by 2002:a05:6358:7e08:b0:176:26f9:6ee with SMTP id o8-20020a0563587e0800b0017626f906eemr6831354rwm.31.1706079257282;
        Tue, 23 Jan 2024 22:54:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4wg1Xr84P5XC3BDGgQgN8EKtSEfqpTutDbjs81fUUJ1q/bNxKOs2e6bAN2g5lhNpSmOlexAaiF/fcthWgOIY=
X-Received: by 2002:a05:6358:7e08:b0:176:26f9:6ee with SMTP id
 o8-20020a0563587e0800b0017626f906eemr6831344rwm.31.1706079257009; Tue, 23 Jan
 2024 22:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com> <20240116075924.42798-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240116075924.42798-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Jan 2024 14:54:05 +0800
Message-ID: <CACGkMEvv-ggpiVYeziPaPE4qK7dbZv4BxYeUkFJ9jFqzyhnx0Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> get buf from virtio core for premapped mode.
>
> If the virtio queue is premapped mode, the virtio-net send buf may
> have many desc.

This feature is not specific to virtio-net, so we can let "for example ..."

> Every desc dma address need to be unmap. So here we
> introduce a new helper to collect the dma address of the buffer from
> the virtio core.

Let's explain why we can't (or suboptimal to) depend on a driver to do this=
.

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
> index 49299b1f9ec7..82f72428605b 100644
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

So the code has a check for dma:

        if (!dma)
                return false;

For whatever the case, we need a better comment here.

So we had: use_dma_api, premapped, do_unmap and dma now. I must say
I'm totally lost in this maze. It's a strong hint the API is too
complicated and needs to be tweaked.

For example, is it legal to have do_unmap be false buf DMA is true?

Here're suggestions:

1) rename premapped to buffer_is_premapped
2) rename do_unmap to buffer_need_unmap or introduce a helper

bool vring_need_unmap_buffer()
{
        return use_dma_api && !premapped;
}

3) split the getting dma info logic into an helper like vritqueue_get_dma_i=
nfo()

so we can do

if (!vring_need_unmap_buffer()) {
        virtqueue_get_dma_info()
        return;
}

4) explain why we still need to check dma assuming we had
vring_need_unmap_buffer():

If vring_need_unmap_buffer() is true, we don't need to care about dma at al=
l.

If vring_need_unmap_buffer() is false, we must return dma info
otherwise there's a leak?

> + *
> + * Return:
> + * true: the virtio core must unmap the desc
> + * false: the virtio core skip the desc unmap

Might it be better to say "It's up to the driver to unmap"?

> + */
> +static bool vring_need_unmap(struct vring_virtqueue *vq,
> +                            struct virtio_dma_head *dma,
> +                            dma_addr_t addr, unsigned int length)
> +{
> +       if (vq->do_unmap)
> +               return true;
> +
> +       if (!vq->premapped)
> +               return false;
> +
> +       if (!dma)
> +               return false;

So the logic here is odd.

if (!dma)
        return false;
...
        return false;

A strong hint to split the below getting info logic into another
helper. The root cause is the function do more than just a "yes or
no".

> +
> +       if (unlikely(dma->next >=3D dma->num)) {
> +               BAD_RING(vq, "premapped vq: collect dma overflow: %pad %u=
\n",
> +                        &addr, length);
> +               return false;
> +       }
> +
> +       dma->items[dma->next].addr =3D addr;
> +       dma->items[dma->next].length =3D length;
> +
> +       ++dma->next;
> +
> +       return false;
> +}
> +

Thanks

....


