Return-Path: <bpf+bounces-12801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3FB7D08F0
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 08:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B041C20E6A
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 06:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1409DD2E8;
	Fri, 20 Oct 2023 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDYoUrti"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C455CA75
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:57:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84491A3
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697785045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XjUPv+gwBCrWbYikhfmwGaSYOiZ3DKUgBx2xSYV9XY=;
	b=hDYoUrtigvXXAxwS+h/Sad4zPd0UR8/TMFDb0Lbf9FgiCmOsPQAaf0mhTs0HYZwTcodCUa
	8hF5o40mc8tzk+QSQ65m2Z45chmslrAdVNI/iN1ElTs6105aG2k2kTmqK4jSZ2QuPSCRjK
	lqFjF1oX0NFRLSvToh4PG5NPxPWqQr8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-JbRCqjzaMCSZkcphrWcMCw-1; Fri, 20 Oct 2023 02:57:19 -0400
X-MC-Unique: JbRCqjzaMCSZkcphrWcMCw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079fe7cc7cso430693e87.2
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697785038; x=1698389838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XjUPv+gwBCrWbYikhfmwGaSYOiZ3DKUgBx2xSYV9XY=;
        b=q6UBcB2j1jR/+H1sq59iGy7L1F7HcnHNdKmzuqd7bSPPAf9MTWu7+NxzMvn9/gCXlc
         xeO7k3lX6UQXj7vzB++E5cXIzb7IwnC+rFrjIdX9Zj5JeA3A8Gm/gADCGN1rmGTYjyI8
         3Up+KrEqm8X5WHC8pEVTW/HAOOHd+WyLdU+LOmLWOZkPKuPa8BoZwy8YLucHOZ7kHdRu
         3ot0jAEXdKLSPqmxPFf4nWYPZnXiReo88Q6+uvUJuJr6PjdrWSpISlr7UQMDouvUNLjN
         fFgcvdzeSseXIrYRsC1+z+BcjS5YXFQKdtQlBmoHOeI/RUQlX1hnojgiz2yHVc5JDWXS
         HpqQ==
X-Gm-Message-State: AOJu0YzSfZvGov2c4dwmqSt4TV8YUZ6qG7G3AhSBAl1Q7FNZH7p7zEda
	rZg8BkrqPbR0M9XjI3QfPpf4MDoAusy4neoslHDBjmQU40frf913e4d/rd5Sx71j6Kfjgw8e48p
	1F0lZE3Z8duBmOcSbQ9eC8bWn2iy7
X-Received: by 2002:a19:6745:0:b0:507:9fc1:ca7e with SMTP id e5-20020a196745000000b005079fc1ca7emr540198lfj.51.1697785038389;
        Thu, 19 Oct 2023 23:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV1/zgHPOTgu23Bkc2CBQtcjSLoGh5tyCKjckYB47DrXeqaiq30vHzI68llkAEUgYVS1CNzdCc88SavQfdUwY=
X-Received: by 2002:a19:6745:0:b0:507:9fc1:ca7e with SMTP id
 e5-20020a196745000000b005079fc1ca7emr540162lfj.51.1697785036851; Thu, 19 Oct
 2023 23:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-17-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-17-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:57:06 +0800
Message-ID: <CACGkMEtvVBXupsiE8=Mt4CWJqckS5tF-w_ZdG2qs-AoYBWptWA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 16/19] virtio_net: xsk: rx: introduce
 receive_xsk() to recv xsk buffer
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
> Implementing the logic of xsk rx. If this packet is not for XSK
> determined in XDP, then we need to copy once to generate a SKB.
> If it is for XSK, it is a zerocopy receive packet process.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       |  14 ++--
>  drivers/net/virtio/virtio_net.h |   4 ++
>  drivers/net/virtio/xsk.c        | 120 ++++++++++++++++++++++++++++++++
>  drivers/net/virtio/xsk.h        |   4 ++
>  4 files changed, 137 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 0e740447b142..003dd67ab707 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -822,10 +822,10 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>         }
>  }
>
> -static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buf=
f *xdp,
> -                              struct net_device *dev,
> -                              unsigned int *xdp_xmit,
> -                              struct virtnet_rq_stats *stats)
> +int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> +                       struct net_device *dev,
> +                       unsigned int *xdp_xmit,
> +                       struct virtnet_rq_stats *stats)
>  {
>         struct xdp_frame *xdpf;
>         int err;
> @@ -1589,13 +1589,17 @@ static void receive_buf(struct virtnet_info *vi, =
struct virtnet_rq *rq,
>                 return;
>         }
>
> -       if (vi->mergeable_rx_bufs)
> +       rcu_read_lock();
> +       if (rcu_dereference(rq->xsk.pool))
> +               skb =3D virtnet_receive_xsk(dev, vi, rq, buf, len, xdp_xm=
it, stats);
> +       else if (vi->mergeable_rx_bufs)
>                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len, xdp=
_xmit,
>                                         stats);
>         else if (vi->big_packets)
>                 skb =3D receive_big(dev, vi, rq, buf, len, stats);
>         else
>                 skb =3D receive_small(dev, vi, rq, buf, ctx, len, xdp_xmi=
t, stats);
> +       rcu_read_unlock();
>
>         if (unlikely(!skb))
>                 return;
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index 6e71622fca45..fd7f34703c9b 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -346,6 +346,10 @@ static inline bool virtnet_is_xdp_raw_buffer_queue(s=
truct virtnet_info *vi, int
>                 return false;
>  }
>
> +int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> +                       struct net_device *dev,
> +                       unsigned int *xdp_xmit,
> +                       struct virtnet_rq_stats *stats);
>  void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
>  void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
>  void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index 841fb078882a..f1c64414fac9 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -13,6 +13,18 @@ static void sg_fill_dma(struct scatterlist *sg, dma_ad=
dr_t addr, u32 len)
>         sg->length =3D len;
>  }
>
> +static unsigned int virtnet_receive_buf_num(struct virtnet_info *vi, cha=
r *buf)
> +{
> +       struct virtio_net_hdr_mrg_rxbuf *hdr;
> +
> +       if (vi->mergeable_rx_bufs) {
> +               hdr =3D (struct virtio_net_hdr_mrg_rxbuf *)buf;
> +               return virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> +       }
> +
> +       return 1;
> +}
> +
>  static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
>  {
>         struct virtnet_info *vi =3D sq->vq->vdev->priv;
> @@ -37,6 +49,114 @@ static void virtnet_xsk_check_queue(struct virtnet_sq=
 *sq)
>                 netif_stop_subqueue(dev, qnum);
>  }
>
> +static void merge_drop_follow_xdp(struct net_device *dev,
> +                                 struct virtnet_rq *rq,
> +                                 u32 num_buf,
> +                                 struct virtnet_rq_stats *stats)
> +{
> +       struct xdp_buff *xdp;
> +       u32 len;
> +
> +       while (num_buf-- > 1) {
> +               xdp =3D virtqueue_get_buf(rq->vq, &len);
> +               if (unlikely(!xdp)) {
> +                       pr_debug("%s: rx error: %d buffers missing\n",
> +                                dev->name, num_buf);
> +                       dev->stats.rx_length_errors++;
> +                       break;
> +               }
> +               stats->bytes +=3D len;
> +               xsk_buff_free(xdp);
> +       }
> +}
> +
> +static struct sk_buff *construct_skb(struct virtnet_rq *rq,
> +                                    struct xdp_buff *xdp)
> +{
> +       unsigned int metasize =3D xdp->data - xdp->data_meta;
> +       struct sk_buff *skb;
> +       unsigned int size;
> +
> +       size =3D xdp->data_end - xdp->data_hard_start;
> +       skb =3D napi_alloc_skb(&rq->napi, size);
> +       if (unlikely(!skb))
> +               return NULL;
> +
> +       skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> +
> +       size =3D xdp->data_end - xdp->data_meta;
> +       memcpy(__skb_put(skb, size), xdp->data_meta, size);
> +
> +       if (metasize) {
> +               __skb_pull(skb, metasize);
> +               skb_metadata_set(skb, metasize);
> +       }
> +
> +       return skb;
> +}
> +
> +struct sk_buff *virtnet_receive_xsk(struct net_device *dev, struct virtn=
et_info *vi,
> +                                   struct virtnet_rq *rq, void *buf,
> +                                   unsigned int len, unsigned int *xdp_x=
mit,
> +                                   struct virtnet_rq_stats *stats)
> +{

I wonder if anything blocks us from reusing the existing XDP logic?
Are there some subtle differences?

Thanks


