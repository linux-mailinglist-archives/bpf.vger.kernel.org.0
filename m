Return-Path: <bpf+bounces-12797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE3B7D08DA
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 08:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703FE1C20FBC
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 06:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F01CA75;
	Fri, 20 Oct 2023 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAs/FRd1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDFCA60
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:52:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D745D55
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697784755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EIj3bf1mGidhArRikuspkUzwv3+tYWXHezkRsnPZu4=;
	b=HAs/FRd13cxmS1u3hfT9iJoZHJizojR0V+OafL48AiyN3gSFlr9+cg62m3UbVih3U1pZEF
	ceDN34HbHn/9Siar3jOjGG0YW3l39tGuUF20rAkofK7OC72kAehEhEHpUCaHlXHNcBWYXl
	QyPBHz49S7PT14nvdAjO2WCLyxdF5gg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-M4dsngjRPBuiyATJwUnt1Q-1; Fri, 20 Oct 2023 02:52:31 -0400
X-MC-Unique: M4dsngjRPBuiyATJwUnt1Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507c8a8e5d1so470517e87.3
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784750; x=1698389550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EIj3bf1mGidhArRikuspkUzwv3+tYWXHezkRsnPZu4=;
        b=MN9TEeLi1W4nIHOhcY+0pJShzxXjTm0g7FxDIErA9jRnfxaZJy6O3uYDnONmEUqI4s
         73lRj7Oakl3mwvYrHaIPGUidoo5htXbc8PSeNoFJbNzqYtqSGYYPGZzGOh0OmXtm3cca
         Bq7N2RjHmhBIFT2LSlBTe6zVZrwLxbkg/pera3TuScLn7g0/yAneiNkYqMY5pN0P9m72
         0bLyp+9deUluKeREAvKmfg20wfGqWvVUTSG3qgDcBnr2eLGIBSOaik2j2wdkFzpMeQ6G
         18qSrzJcaehmcjzT3c9m2J0JUlirO5GYm8m5QpgPkiuBM/cHKoBAq6PHD9cJOv9UaCCH
         29AQ==
X-Gm-Message-State: AOJu0YwlIPA5peS7mcBzpnJCdooTPjyO7Zeza/DMgywmSHEmx8Dgxpop
	MYbfsyPyDcNseKcxv1shj+oc+ZcACRkgB7krxbZV3bAph12/yNntf9xp/V9Eh/MR8bfPQaTx4KJ
	ASJ6JmyNKUVlheH/2DHLCsZj6q37s
X-Received: by 2002:ac2:5ec3:0:b0:507:9625:5fd3 with SMTP id d3-20020ac25ec3000000b0050796255fd3mr582992lfq.32.1697784750324;
        Thu, 19 Oct 2023 23:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnRuo5sqDr6/4TZIIbTk2wPU8ZXdj12hqoUmgYAL5U7xWnIZLrHn0v6rW79DCzNMacRgQXtQXbupSnIn3yQJ8=
X-Received: by 2002:ac2:5ec3:0:b0:507:9625:5fd3 with SMTP id
 d3-20020ac25ec3000000b0050796255fd3mr582985lfq.32.1697784749976; Thu, 19 Oct
 2023 23:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-13-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-13-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:52:18 +0800
Message-ID: <CACGkMEsoA_y6FV0PzoLfO-UFhJrYRe96cDpX_hHgSo7PAwshrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 12/19] virtio_net: xsk: tx: support wakeup
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
> xsk wakeup is used to trigger the logic for xsk xmit by xsk framework or
> user.
>
> Virtio-Net does not support to actively generate an interruption, so it
> tries to trigger tx NAPI on the tx interrupt cpu.
>
> Consider the effect of cache. When interrupt triggers, it is
> generally fixed on a CPU. It is better to start TX Napi on the same
> CPU.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       |  3 ++
>  drivers/net/virtio/virtio_net.h |  8 +++++
>  drivers/net/virtio/xsk.c        | 57 +++++++++++++++++++++++++++++++++
>  drivers/net/virtio/xsk.h        |  1 +
>  4 files changed, 69 insertions(+)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index a08429bef61f..1a222221352e 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -2066,6 +2066,8 @@ static int virtnet_poll_tx(struct napi_struct *napi=
, int budget)
>                 return 0;
>         }
>
> +       sq->xsk.last_cpu =3D smp_processor_id();
> +
>         txq =3D netdev_get_tx_queue(vi->dev, index);
>         __netif_tx_lock(txq, raw_smp_processor_id());
>         virtqueue_disable_cb(sq->vq);
> @@ -3770,6 +3772,7 @@ static const struct net_device_ops virtnet_netdev =
=3D {
>         .ndo_vlan_rx_kill_vid =3D virtnet_vlan_rx_kill_vid,
>         .ndo_bpf                =3D virtnet_xdp,
>         .ndo_xdp_xmit           =3D virtnet_xdp_xmit,
> +       .ndo_xsk_wakeup         =3D virtnet_xsk_wakeup,
>         .ndo_features_check     =3D passthru_features_check,
>         .ndo_get_phys_port_name =3D virtnet_get_phys_port_name,
>         .ndo_set_features       =3D virtnet_set_features,
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index 3bbb1f5baad5..7c72a8bb1813 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -101,6 +101,14 @@ struct virtnet_sq {
>                 struct xsk_buff_pool __rcu *pool;
>
>                 dma_addr_t hdr_dma_address;
> +
> +               u32 last_cpu;
> +               struct __call_single_data csd;
> +
> +               /* The lock to prevent the repeat of calling
> +                * smp_call_function_single_async().
> +                */
> +               spinlock_t ipi_lock;
>         } xsk;
>  };
>
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index 0e775a9d270f..973e783260c3 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -115,6 +115,60 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct =
xsk_buff_pool *pool,
>         return sent =3D=3D budget;
>  }
>
> +static void virtnet_remote_napi_schedule(void *info)
> +{
> +       struct virtnet_sq *sq =3D info;
> +
> +       virtnet_vq_napi_schedule(&sq->napi, sq->vq);
> +}
> +
> +static void virtnet_remote_raise_napi(struct virtnet_sq *sq)
> +{
> +       u32 last_cpu, cur_cpu;
> +
> +       last_cpu =3D sq->xsk.last_cpu;
> +       cur_cpu =3D get_cpu();
> +
> +       /* On remote cpu, softirq will run automatically when ipi irq exi=
t. On
> +        * local cpu, smp_call_xxx will not trigger ipi interrupt, then s=
oftirq
> +        * cannot be triggered automatically. So Call local_bh_enable aft=
er to
> +        * trigger softIRQ processing.
> +        */
> +       if (last_cpu =3D=3D cur_cpu) {
> +               local_bh_disable();
> +               virtnet_vq_napi_schedule(&sq->napi, sq->vq);
> +               local_bh_enable();
> +       } else {
> +               if (spin_trylock(&sq->xsk.ipi_lock)) {
> +                       smp_call_function_single_async(last_cpu, &sq->xsk=
.csd);
> +                       spin_unlock(&sq->xsk.ipi_lock);
> +               }
> +       }

Is there any number to show whether it's worth it for an IPI here? For
example, GVE doesn't do this.

Thanks


> +
> +       put_cpu();
> +}
> +
> +int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
> +{
> +       struct virtnet_info *vi =3D netdev_priv(dev);
> +       struct virtnet_sq *sq;
> +
> +       if (!netif_running(dev))
> +               return -ENETDOWN;
> +
> +       if (qid >=3D vi->curr_queue_pairs)
> +               return -EINVAL;
> +
> +       sq =3D &vi->sq[qid];
> +
> +       if (napi_if_scheduled_mark_missed(&sq->napi))
> +               return 0;
> +
> +       virtnet_remote_raise_napi(sq);
> +
> +       return 0;
> +}
> +
>  static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virt=
net_rq *rq,
>                                     struct xsk_buff_pool *pool)
>  {
> @@ -240,6 +294,9 @@ static int virtnet_xsk_pool_enable(struct net_device =
*dev,
>
>         sq->xsk.hdr_dma_address =3D hdr_dma;
>
> +       INIT_CSD(&sq->xsk.csd, virtnet_remote_napi_schedule, sq);
> +       spin_lock_init(&sq->xsk.ipi_lock);
> +
>         return 0;
>
>  err_sq:
> diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> index 73ca8cd5308b..1bd19dcda649 100644
> --- a/drivers/net/virtio/xsk.h
> +++ b/drivers/net/virtio/xsk.h
> @@ -17,4 +17,5 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
>  int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xd=
p);
>  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
>                       int budget);
> +int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
>  #endif
> --
> 2.32.0.3.g01195cf9f
>


