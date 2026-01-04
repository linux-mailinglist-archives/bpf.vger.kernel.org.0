Return-Path: <bpf+bounces-77762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C73F9CF0A4F
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 07:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B88E3001638
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 06:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D440D2D948A;
	Sun,  4 Jan 2026 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OysSzA94";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQ3Vfp5Y"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825432D877F
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767506964; cv=none; b=guIRJDDS5nchBQI4U619418SJkM1LT8f6f40zkpgeCjqMM1825yC5qvLeJFEGrdfBHFi4OR7t3J2leLbrre/M+Lxi51ltFM9qP8DAboLhqFYoOz9TqcTdwKgLVoG0p1bfsPoY8DnOWSh7axGILLfScOVVfMxeLT5E7Ylhu2hj1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767506964; c=relaxed/simple;
	bh=d62UFEnU7fCkorQZkkR3CJODcl+iqve4VXrymJhCGPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKmXrjDVNQTORFbkyS8QvCCZAYdz5l1oLQiFUIk2SPj+j/gKdjLWe/uM6EwYIaLBpc2g4GWjyj5NJha9yHspmSWsz8NvzNDw6Jyo8jW4wHXg+GV1oAibA3LXaJ3EQtFRD92G0AEEZBcVg4+m6Co0rsInVP26XpS5hoVT1QXSSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OysSzA94; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQ3Vfp5Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767506961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJExj1wMdLs7y98GZ9+oLjZ8HntohnFo3s2nmuYpgMU=;
	b=OysSzA94eLOj64H0PN0+v+sFoAwERbEm/7NkoC9So3mwuEP2IXnch7KlHFcQQjh7Fd3Czx
	7y6z3UCz+1M8gMccHr4DNObowZtDwBUclURnh/2ahQjNak4uY9g0TUyqnSHwqHi7dUH6y7
	A2BXh4qg7ArAHl/bjIXtdEI7o1eea5U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-abfye-0HPC-inXuVWByQOA-1; Sun, 04 Jan 2026 01:09:20 -0500
X-MC-Unique: abfye-0HPC-inXuVWByQOA-1
X-Mimecast-MFC-AGG-ID: abfye-0HPC-inXuVWByQOA_1767506959
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c704d5d15so26308503a91.1
        for <bpf@vger.kernel.org>; Sat, 03 Jan 2026 22:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767506958; x=1768111758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJExj1wMdLs7y98GZ9+oLjZ8HntohnFo3s2nmuYpgMU=;
        b=AQ3Vfp5YShHj7ZRYhv8bH/nsVha3znspsNNF2Ma/gbnaDaLcH12JStCwDyLonLbIsT
         ByVldf4bw+lt//933CxBoR+/zq9jrEyM3H7J/9fO2f6p9Z5f7MLTMY1cZC8J0dfNmhfK
         aSn7rwy/kTP7LNJdLH55dWUU/2GOTJLma3RnDCvxiIf4S3nrjFPo86jKydyRnqrKRZf7
         8qEdsAIhIrsascXmSPLwXommbxxcUIBxMOTWZI8ASoaOSLTfV+bkdIqb+vz7CcDr594a
         pJCGt+5xOXsXZ9h2D2tRwL3R6FdN0A77C2jcZmcBaM7wsEZoGz6sYaJqPRpy8nrjRmK6
         uMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767506958; x=1768111758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJExj1wMdLs7y98GZ9+oLjZ8HntohnFo3s2nmuYpgMU=;
        b=MqKmytCXZPdMsZz0u513VMaotrW8gBjmgJOlvPmUs4xfE1hTJBEjfOSrjx6e6BDZpD
         gZGgDNyXPyte3NkcjBtGOzWkzCglrwYDjaKMvI8Hv+U795SP0ma5G2e4C0NvMAVC6veK
         sk+fQDTYPTTlFQkVhxvLpDdYee8eYoWJLYo3aYAE8jD2ATAbZNK2yD3i3LGgJ/3yr/kM
         wa4/nBnP0kAJBM5SyNPGJvvPBZzOtlavMbJSImD+XkmjVtxSX4KFSbtc01dOmnIqlHa7
         gHBr0k895SChUQutwp6gNRlVFxofkeOdRliSIn77O9R2VntcVUFgqIYZp5n1yx4pBzli
         M2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXJE9tlOmtzpS7S57lERCHL9Vj3T35Dg9qy5Y//bi3m6e/RmksrSdLaYw+7EFXWtQ5lTic=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz/7oArPW9iydZ/37qDpxNcWaaSYrGxpegWH2ZxLqK2sv2KZYB
	CWURIc/tQ3PKZ7S0FAz70sg+KP+J6rDBscnVQKayW0Z0QymobHYgmfFRve0BLWMIiuZDnkgkqWX
	pG62nRt3I+ty7v1pmEOOOlHv3Yt+BY64CkTrEd7nEIjhA3CmSwn8DolEjwwkJVaG4SqdEUyRpPd
	ZXuUBWeS03nG9PluK/TESI3nqj2jf3gTemJQFN
X-Gm-Gg: AY/fxX5PJA2PI2NU5pkoslhzsITsTOWdiok2KQxjZCLLgSRvmZWd6GoVwighI2p6LtL
	1h/0G1cxBIAu37jLNXveaHz5T+3gMCCMwoTMsSbTqcnPFcVckWNbb6U+PaKMrAD3zcK/Dmfsdl1
	UuNOXCcCSqzjtiX16JbUyiHy/3AiFKusNX2TbQutMJK84jY85gVU+mYA8P6ZhxM40=
X-Received: by 2002:a17:90b:2804:b0:339:a243:e96d with SMTP id 98e67ed59e1d1-34e921f7bb8mr34964893a91.36.1767506958557;
        Sat, 03 Jan 2026 22:09:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1TrnHOaObWiDYx4VRiV588ZpfCmQ2a6hTaoJiRv90CvgOiEyCA+WPpxYK2SDPSu+eSM2BKeUX90AdzmAJQvU=
X-Received: by 2002:a17:90b:2804:b0:339:a243:e96d with SMTP id
 98e67ed59e1d1-34e921f7bb8mr34964869a91.36.1767506958105; Sat, 03 Jan 2026
 22:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102152023.10773-1-minhquangbui99@gmail.com> <20260102152023.10773-2-minhquangbui99@gmail.com>
In-Reply-To: <20260102152023.10773-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 4 Jan 2026 14:09:06 +0800
X-Gm-Features: AQt7F2roE9LpNfzF8c2KtQ4VSRlYXoi2Mx29Nbq8m5ARZMNVXphPDvutIIePn_4
Message-ID: <CACGkMEs9wCM8s4_r1HCQGj9mUDdTF+BqkF0rse+dzB3USprhMA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] virtio-net: don't schedule delayed refill worker
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 11:20=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> When we fail to refill the receive buffers, we schedule a delayed worker
> to retry later. However, this worker creates some concurrency issues
> such as races and deadlocks. To simplify the logic and avoid further
> problems, we will instead retry refilling in the next NAPI poll.
>
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx"=
)
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results=
/400961/3-xdp-py/stderr
> Cc: stable@vger.kernel.org
> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..ac514c9383ae 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_i=
nfo *vi,
>  }
>
>  static int virtnet_receive(struct receive_queue *rq, int budget,
> -                          unsigned int *xdp_xmit)
> +                          unsigned int *xdp_xmit, bool *retry_refill)
>  {
>         struct virtnet_info *vi =3D rq->vq->vdev->priv;
>         struct virtnet_rq_stats stats =3D {};
> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *r=
q, int budget,
>                 packets =3D virtnet_receive_packets(vi, rq, budget, xdp_x=
mit, &stats);
>
>         if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vr=
ing_size(rq->vq)) / 2) {
> -               if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -                       spin_lock(&vi->refill_lock);
> -                       if (vi->refill_enabled)
> -                               schedule_delayed_work(&vi->refill, 0);
> -                       spin_unlock(&vi->refill_lock);
> -               }
> +               if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +                       *retry_refill =3D true;
>         }
>
>         u64_stats_set(&stats.packets, packets);
> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi,=
 int budget)
>         struct send_queue *sq;
>         unsigned int received;
>         unsigned int xdp_xmit =3D 0;
> -       bool napi_complete;
> +       bool napi_complete, retry_refill =3D false;
>
>         virtnet_poll_cleantx(rq, budget);
>
> -       received =3D virtnet_receive(rq, budget, &xdp_xmit);
> +       received =3D virtnet_receive(rq, budget, &xdp_xmit, &retry_refill=
);

I think we can simply let virtnet_receive() to return the budget when
reill fails.

>         rq->packets_in_napi +=3D received;
>
>         if (xdp_xmit & VIRTIO_XDP_REDIR)
>                 xdp_do_flush();
>
>         /* Out of packets? */
> -       if (received < budget) {
> +       if (received < budget && !retry_refill) {
>                 napi_complete =3D virtqueue_napi_complete(napi, rq->vq, r=
eceived);
>                 /* Intentionally not taking dim_lock here. This may resul=
t in a
>                  * spurious net_dim call. But if that happens virtnet_rx_=
dim_work
> @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, i=
nt budget)
>                 virtnet_xdp_put_sq(vi, sq);
>         }
>
> -       return received;
> +       return retry_refill ? budget : received;
>  }
>
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_i=
ndex)
> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
>                 if (i < vi->curr_queue_pairs)
> -                       /* Make sure we have some buffers: if oom use wq.=
 */
> -                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -                               schedule_delayed_work(&vi->refill, 0);
> +                       /* If this fails, we will retry later in
> +                        * NAPI poll, which is scheduled in the below
> +                        * virtnet_enable_queue_pair
> +                        */
> +                       try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);

Consider NAPI will be eventually scheduled, I wonder if it's still
worth to refill here.

>
>                 err =3D virtnet_enable_queue_pair(vi, i);
>                 if (err < 0)
> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_in=
fo *vi,
>                                 bool refill)
>  {
>         bool running =3D netif_running(vi->dev);
> -       bool schedule_refill =3D false;
>
> -       if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -               schedule_refill =3D true;
> +       if (refill)
> +               /* If this fails, we will retry later in NAPI poll, which=
 is
> +                * scheduled in the below virtnet_napi_enable
> +                */
> +               try_fill_recv(vi, rq, GFP_KERNEL);

and here.

> +
>         if (running)
>                 virtnet_napi_enable(rq);
> -
> -       if (schedule_refill)
> -               schedule_delayed_work(&vi->refill, 0);
>  }
>
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *=
vi, u16 queue_pairs)
>         struct virtio_net_rss_config_trailer old_rss_trailer;
>         struct net_device *dev =3D vi->dev;
>         struct scatterlist sg;
> +       int i;
>
>         if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ=
))
>                 return 0;
> @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info=
 *vi, u16 queue_pairs)
>         }
>  succ:
>         vi->curr_queue_pairs =3D queue_pairs;
> -       /* virtnet_open() will refill when device is going to up. */
> -       spin_lock_bh(&vi->refill_lock);
> -       if (dev->flags & IFF_UP && vi->refill_enabled)
> -               schedule_delayed_work(&vi->refill, 0);
> -       spin_unlock_bh(&vi->refill_lock);
> +       if (dev->flags & IFF_UP) {
> +               /* Let the NAPI poll refill the receive buffer for us. We=
 can't
> +                * safely call try_fill_recv() here because the NAPI migh=
t be
> +                * enabled already.
> +                */
> +               local_bh_disable();
> +               for (i =3D 0; i < vi->curr_queue_pairs; i++)
> +                       virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i=
].vq);
> +
> +               local_bh_enable();
> +       }
>
>         return 0;
>  }
> --
> 2.43.0
>

Thanks


