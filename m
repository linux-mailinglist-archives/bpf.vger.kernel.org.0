Return-Path: <bpf+bounces-20298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C856D83B868
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 04:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A62B21CAC
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 03:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A549E6FCB;
	Thu, 25 Jan 2024 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TssiLz3E"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335179CF
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153977; cv=none; b=SiD/lQ9d+8h2IhKyn/rmOIJ5WCPUrd8dCv1OMj54wOWjzSIrEY4niggXIQMKZqVOG22fCceQy2FK7y9BE/FnUpzFtPbGKUyISJ+ZQiZrxTw/gD9BvcbjLGnr/+iIvLmoSBp63cMm1A87oOx3tL0xeNsQKYc+vIXkQrIqwWoXvMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153977; c=relaxed/simple;
	bh=VTSduOFhTJtDTzA1HpaE0aKiopHWtMXEHoDG//QlxrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPO93g7U32hpAoKbymNar6DDNfcW6M8cqoRxOka4pviqYS7ul/16H9BA50KHvXFNqHMXswG+w4ODIwA3mNRV37HCya7yFCj4jZlzyAofO89FtJFXiWQrA/BoK5EibFh74pfnaSeveW8BBflrjCfpG2UWEkXQmHQpvOtl7aKjnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TssiLz3E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706153974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjnJLRjUUnfsYys8p8NZDH9dTqQ5GmQ+Z9OLP5YvI3U=;
	b=TssiLz3Eq6IFgVUf+0L0YhK7gwOZV2FvGE/zOgXRYFQJpUE5Jef3I7/CHZ1XICmKw5TGjk
	UUQwwydElnx1+4uUIv0CFkWZosLKsdxzEyWdRAsn41W5Ns2nl8ZpYtU0g6iBfUpKBVGexs
	k1O2D6Jay7anqpKexwlYviL1gwcl/wY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-holn2vgzP0K2k93u2jKIxA-1; Wed, 24 Jan 2024 22:39:32 -0500
X-MC-Unique: holn2vgzP0K2k93u2jKIxA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bddadbc2bbso286357b6e.1
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 19:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706153971; x=1706758771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjnJLRjUUnfsYys8p8NZDH9dTqQ5GmQ+Z9OLP5YvI3U=;
        b=Xdp6xifCG7go1Z9EQPlP+kowX5jjw2gpiD+iB0cJNUR/oWMgbY970McspdNFJ04p8/
         MPBi3eQf250kTCixB+/9FqPVfoLtXd0kfwxLvH7Vvf6bHW7KwigMkO2d2OP/xXpSGQcc
         TlKKQFXOUL1aBsjO2eb/Prm9Aq/GmgXzsqYVAiBhhR8oVRMnHvPFUzcYxRAuaLGnAl+/
         Xj2y35243G//zHcwuLc5q4DBEAfWzjYlb8Vi5LV1Y6srWf3XPAZbfaqK9eKCbR9G9TOA
         hhrXtdiVnRlkSZ4YQTtcqHleHrz3X1TxbhuwyzOk8335kAzhRvoNNVLcHizDf/hnVXEO
         wgTA==
X-Gm-Message-State: AOJu0Yx98nQWlLMpDbyqKz/BfIWG0plL+sI6DB9IQBXe4qgbxShcTYLi
	kwSTe0gSGqa3xMvODNeHk0ILShUKHnwl+8jq3ytGu4pBOCNVqMQ+FA6kFZniFbLJySeBzFVn2ho
	pwZ+r9IGqW76rMhWSEBK7jInywiWBv/F8+mwoSEKq5E14nr1v99eSxyN3UzpdC8srwxCV2TsxGc
	EzK5FXDjnhRmFlDUtADAg+3WbS
X-Received: by 2002:a05:6808:2187:b0:3bd:d7c5:942 with SMTP id be7-20020a056808218700b003bdd7c50942mr332282oib.110.1706153971621;
        Wed, 24 Jan 2024 19:39:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM6QTZ+7F881shndgGCv/cg0f6FiQMkj4LPmTtLichjZubQR7DermFohR8nJBxKhcGEAmYnsCeHi+4NE3cciA=
X-Received: by 2002:a05:6808:2187:b0:3bd:d7c5:942 with SMTP id
 be7-20020a056808218700b003bdd7c50942mr332270oib.110.1706153971319; Wed, 24
 Jan 2024 19:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com> <20240116075924.42798-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240116075924.42798-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Jan 2024 11:39:20 +0800
Message-ID: <CACGkMEujO6EdmY_b2wPgG1uBo0DEWhLh81aEX4DHGMfCU7tzUw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] virtio_net: sq support premapped mode
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
> If the xsk is enabling, the xsk tx will share the send queue.

Any reason for this? Technically, virtio-net can work as other NIC
like 256 queues. There could be some work like optimizing the
interrupt allocations etc.

> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode.
>
> command: pktgen_sample01_simple.sh -i eth0 -s 16/1400 -d 10.0.0.123 -m 00=
:16:3e:12:e1:3e -n 0 -p 100
> machine:  ecs.ebmg6e.26xlarge of Aliyun
> cpu: Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> iommu mode: intel_iommu=3Don iommu.strict=3D1 iommu=3Dnopt
>
>                       |        iommu off           |        iommu on
> ----------------------|--------------------------------------------------=
---
>                       | 16         |  1400         | 16         | 1400
> ----------------------|--------------------------------------------------=
---
> Before:               |1716796.00  |  1581829.00   | 390756.00  | 374493.=
00
> After(premapped off): |1733794.00  |  1576259.00   | 390189.00  | 378128.=
00
> After(premapped on):  |1707107.00  |  1562917.00   | 385667.00  | 373584.=
00
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 119 ++++++++++++++++++++++++++++----
>  drivers/net/virtio/virtio_net.h |  10 ++-
>  2 files changed, 116 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 4fbf612da235..53143f95a3a0 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -168,13 +168,39 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
>  }
>
> +static void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct virtio_dm=
a_head *dma)
> +{
> +       int i;
> +
> +       if (!dma)
> +               return;
> +
> +       for (i =3D 0; i < dma->next; ++i)
> +               virtqueue_dma_unmap_single_attrs(sq->vq,
> +                                                dma->items[i].addr,
> +                                                dma->items[i].length,
> +                                                DMA_TO_DEVICE, 0);
> +       dma->next =3D 0;
> +}
> +
>  static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
>                             u64 *bytes, u64 *packets)
>  {
> +       struct virtio_dma_head *dma;
>         unsigned int len;
>         void *ptr;
>
> -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> +       if (virtqueue_get_dma_premapped(sq->vq)) {

Any chance this.can be false?

> +               dma =3D &sq->dma.head;
> +               dma->num =3D ARRAY_SIZE(sq->dma.items);
> +               dma->next =3D 0;

Btw, I found in the case of RX we have:

virtnet_rq_alloc():

                        alloc_frag->offset =3D sizeof(*dma);

This seems to defeat frag coalescing when the memory is highly
fragmented or high order allocation is disallowed.

Any idea to solve this?

> +       } else {
> +               dma =3D NULL;
> +       }
> +
> +       while ((ptr =3D virtqueue_get_buf_ctx_dma(sq->vq, &len, dma, NULL=
)) !=3D NULL) {
> +               virtnet_sq_unmap_buf(sq, dma);
> +
>                 if (!is_xdp_frame(ptr)) {
>                         struct sk_buff *skb =3D ptr;
>
> @@ -572,16 +598,70 @@ static void *virtnet_rq_alloc(struct virtnet_rq *rq=
, u32 size, gfp_t gfp)
>         return buf;
>  }
>
> -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> +static void virtnet_set_premapped(struct virtnet_info *vi)
>  {
>         int i;
>
> -       /* disable for big mode */
> -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> -               return;
> +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +               virtqueue_set_dma_premapped(vi->sq[i].vq);
>
> -       for (i =3D 0; i < vi->max_queue_pairs; i++)
> -               virtqueue_set_dma_premapped(vi->rq[i].vq);
> +               /* TODO for big mode */

Btw, how hard to support big mode? If we can do premapping for that
code could be simplified.

(There are vendors that doesn't support mergeable rx buffers).

> +               if (vi->mergeable_rx_bufs || !vi->big_packets)
> +                       virtqueue_set_dma_premapped(vi->rq[i].vq);
> +       }
> +}
> +
> +static void virtnet_sq_unmap_sg(struct virtnet_sq *sq, u32 num)
> +{
> +       struct scatterlist *sg;
> +       u32 i;
> +
> +       for (i =3D 0; i < num; ++i) {
> +               sg =3D &sq->sg[i];
> +
> +               virtqueue_dma_unmap_single_attrs(sq->vq,
> +                                                sg->dma_address,
> +                                                sg->length,
> +                                                DMA_TO_DEVICE, 0);
> +       }
> +}
> +
> +static int virtnet_sq_map_sg(struct virtnet_sq *sq, u32 num)
> +{
> +       struct scatterlist *sg;
> +       u32 i;
> +
> +       for (i =3D 0; i < num; ++i) {
> +               sg =3D &sq->sg[i];
> +               sg->dma_address =3D virtqueue_dma_map_single_attrs(sq->vq=
, sg_virt(sg),
> +                                                                sg->leng=
th,
> +                                                                DMA_TO_D=
EVICE, 0);
> +               if (virtqueue_dma_mapping_error(sq->vq, sg->dma_address))
> +                       goto err;
> +       }
> +

This seems nothing virtio-net specific, let's move it to the core?

Thanks


> +       return 0;
> +
> +err:
> +       virtnet_sq_unmap_sg(sq, i);
> +       return -ENOMEM;
> +}
> +
> +static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void *data=
)
> +{
> +       int ret;
> +
> +       if (virtqueue_get_dma_premapped(sq->vq)) {
> +               ret =3D virtnet_sq_map_sg(sq, num);
> +               if (ret)
> +                       return -ENOMEM;
> +       }
> +
> +       ret =3D virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMI=
C);
> +       if (ret && virtqueue_get_dma_premapped(sq->vq))
> +               virtnet_sq_unmap_sg(sq, num);
> +
> +       return ret;
>  }
>
>  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> @@ -687,8 +767,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info=
 *vi,
>                             skb_frag_size(frag), skb_frag_off(frag));
>         }
>
> -       err =3D virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> -                                  xdp_to_ptr(xdpf), GFP_ATOMIC);
> +       err =3D virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
>         if (unlikely(err))
>                 return -ENOSPC; /* Caller handle free/refcnt */
>
> @@ -2154,7 +2233,7 @@ static int xmit_skb(struct virtnet_sq *sq, struct s=
k_buff *skb)
>                         return num_sg;
>                 num_sg++;
>         }
> -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOM=
IC);
> +       return virtnet_add_outbuf(sq, num_sg, skb);
>  }
>
>  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *de=
v)
> @@ -4011,9 +4090,25 @@ static void free_receive_page_frags(struct virtnet=
_info *vi)
>
>  static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
>  {
> +       struct virtnet_info *vi =3D vq->vdev->priv;
> +       struct virtio_dma_head *dma;
> +       struct virtnet_sq *sq;
> +       int i =3D vq2txq(vq);
>         void *buf;
>
> -       while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL) {
> +       sq =3D &vi->sq[i];
> +
> +       if (virtqueue_get_dma_premapped(sq->vq)) {
> +               dma =3D &sq->dma.head;
> +               dma->num =3D ARRAY_SIZE(sq->dma.items);
> +               dma->next =3D 0;
> +       } else {
> +               dma =3D NULL;
> +       }
> +
> +       while ((buf =3D virtqueue_detach_unused_buf_dma(vq, dma)) !=3D NU=
LL) {
> +               virtnet_sq_unmap_buf(sq, dma);
> +
>                 if (!is_xdp_frame(buf))
>                         dev_kfree_skb(buf);
>                 else
> @@ -4228,7 +4323,7 @@ static int init_vqs(struct virtnet_info *vi)
>         if (ret)
>                 goto err_free;
>
> -       virtnet_rq_set_premapped(vi);
> +       virtnet_set_premapped(vi);
>
>         cpus_read_lock();
>         virtnet_set_affinity(vi);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index 066a2b9d2b3c..dda144cc91c7 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -48,13 +48,21 @@ struct virtnet_rq_dma {
>         u16 need_sync;
>  };
>
> +struct virtnet_sq_dma {
> +       struct virtio_dma_head head;
> +       struct virtio_dma_item items[MAX_SKB_FRAGS + 2];
> +};
> +
>  /* Internal representation of a send virtqueue */
>  struct virtnet_sq {
>         /* Virtqueue associated with this virtnet_sq */
>         struct virtqueue *vq;
>
>         /* TX: fragments + linear part + virtio header */
> -       struct scatterlist sg[MAX_SKB_FRAGS + 2];
> +       union {
> +               struct scatterlist sg[MAX_SKB_FRAGS + 2];
> +               struct virtnet_sq_dma dma;
> +       };
>
>         /* Name of the send queue: output.$index */
>         char name[16];
> --
> 2.32.0.3.g01195cf9f
>


