Return-Path: <bpf+bounces-39571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F5D9748E9
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 05:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545462875C6
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 03:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A3A3BBC9;
	Wed, 11 Sep 2024 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ls3QgDyG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCDEEC8
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026411; cv=none; b=QTW1FGf1niv7USOjyqxw81s8UXs4DixLmpM6piGP++9Dav4jV6mgfCGHbgKgLf6MNUhAFYf74bW9t91dlWQZ0+MAE83+/3D5khQrUjFmwzeyP6GYJaOLamNYJWUkKgXMZWYRp0SE8igwX6ohy5dA9tsO14g2YL5+dNogfG4L5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026411; c=relaxed/simple;
	bh=wFhKcLxyN1ykNiZvxwjOMXoiE6l+99pEcKDjgw165jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eekIRELvNLfEAlYiqfmRa9S4TyIxAibyyytyUcDY/XKEiCg7EkXCwQ7KfldkjTVGpP2Z1dKgXr2U1id45dZcmwcDQbWU7uCOOU2EzF4hrkEar+aC/QmUvP0bHcoUAiQuMD4C+dvKpLID3r+jNFxjELu4mCKp+0qrHVkPFyTZk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ls3QgDyG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726026408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1L3Rw9FQGILLm4dgDngRRTfcF5g+8GVlGOUuhGIUJk=;
	b=Ls3QgDyGPKFZu8Ykt60cQ1uclCaZvwAQo6J+ubP/H+uoOLHCQc00xl8cIlTmQmS6pirP/P
	xMibDZinbpE9MReL3F/3OWWf/X5vNaQPHwKahAo7486Ef1MlOHOjU4aTcB8iCcBFrtDwFS
	cMhFrn8IaRTxLXjskHQqcie4gpyD1Qk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-U5vsU9SaO46bihuLNbg3aw-1; Tue, 10 Sep 2024 23:46:47 -0400
X-MC-Unique: U5vsU9SaO46bihuLNbg3aw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d877d7f9b4so6373489a91.3
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 20:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726026406; x=1726631206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1L3Rw9FQGILLm4dgDngRRTfcF5g+8GVlGOUuhGIUJk=;
        b=Y7nVT2vrfR4Rcl0eKfMNnMOHkLBaABzlixMGw838dkgsTG2mvWFGT0oI0Vs/Dg6sBb
         8VnYvZ4svs6/hLK73Mb4+tcgWGMwazVRJk5DBZ/tTT9pIfr38NVMjRfHDg4qfLeJtZEl
         uWjvhLbmxX3xDy1BUDJZIBmz4yNmdZMHm25eHOBdH6WVukQegKXi7oQpXCYV9NojIJvV
         QBvKPDguQ3+doA+re/uZiFiG13eV7gsPeRCHaEIl1b5CC73bCfx1pa/m1O47ty5mouX7
         qoXv0yEASyTPXvUMd47FBU80Htma8sLvu31Jr8X6gJCxtKF55TzYOze1d1QFmu6luBQV
         W/dg==
X-Forwarded-Encrypted: i=1; AJvYcCXgwmGxRLkQhQik0L+Bc2bj+8J4ZLk8t4KghjXvXNEHO5jFA2/HLXrZFnZ9A08ZofTHjks=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa655we6AGfI8V8/9W/uKhpYsDwDH+G0H9VzZc3B1o+uJVmuDS
	1ywjyMvvXcDNft0Brdv5lmREDu3kc5FmmicHCAmFZ3v2FnbTJuWquMDV1jjjLS7pNfS7G8JtLh9
	+GXez4C0AS6h13NjtZCL9qaqwvXxhmSnD6J+DL9Id/ABodJWcmxXluDUGcR2K9s+s9pQOyQmc87
	kpiTGiRFziFcwxZzJfO6yLakbD
X-Received: by 2002:a17:90a:77ca:b0:2d8:8ead:f013 with SMTP id 98e67ed59e1d1-2dad4efdfa9mr16150974a91.7.1726026406204;
        Tue, 10 Sep 2024 20:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnCJEXli9KWBQMuW7cPrQvykkXNDs1S+lxJ6nyJ9QJcR1HThFRnYJ3qTpH47dKeRKcUVxzNps+IZHyuAdt/B4=
X-Received: by 2002:a17:90a:77ca:b0:2d8:8ead:f013 with SMTP id
 98e67ed59e1d1-2dad4efdfa9mr16150940a91.7.1726026405725; Tue, 10 Sep 2024
 20:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 11:46:30 +0800
Message-ID: <CACGkMEuN6mFv2NjkA-NFBE2NCt0F1EW5Gk=X0dC4hz45Ns+jhw@mail.gmail.com>
Subject: Re: [PATCH net-next 02/13] virtio_ring: split: harden dma unmap for indirect
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
> 1. this commit hardens dma unmap for indirect

I think we need to explain why we need such hardening. For example
indirect use stream mapping which is read-only from the device. So it
looks to me like it doesn't require hardening by itself.

> 2. the subsequent commit uses the struct extra to record whether the
>    buffers need to be unmapped or not.

It's better to explain why such a decision could not be implied with
the existing metadata.

>  So we need a struct extra for
>    every desc, whatever it is indirect or not.

If this is the real reason, we need to tweak the title.

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 122 ++++++++++++++++-------------------
>  1 file changed, 57 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 228e9fbcba3f..582d2c05498a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -67,9 +67,16 @@
>  #define LAST_ADD_TIME_INVALID(vq)
>  #endif
>
> +struct vring_desc_extra {
> +       dma_addr_t addr;                /* Descriptor DMA addr. */
> +       u32 len;                        /* Descriptor length. */
> +       u16 flags;                      /* Descriptor flags. */
> +       u16 next;                       /* The next desc state in a list.=
 */
> +};
> +
>  struct vring_desc_state_split {
>         void *data;                     /* Data for callback. */
> -       struct vring_desc *indir_desc;  /* Indirect descriptor, if any. *=
/
> +       struct vring_desc_extra *indir; /* Indirect descriptor, if any. *=
/

Btw, it might be worth explaining that this will be allocated with an
indirect descriptor table so we won't stress more to the memory
allocator.

Thanks


