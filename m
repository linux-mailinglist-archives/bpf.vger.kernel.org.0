Return-Path: <bpf+bounces-39701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9520797638C
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 09:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5475D284F28
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FAD18E74C;
	Thu, 12 Sep 2024 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wSjcfkTd"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664F188A00;
	Thu, 12 Sep 2024 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127681; cv=none; b=uPQn56sRUBkokqgSTPwtQSsl87+7WcV7wb2rHakfp5S+zBUGQNV9opL0I0uuB2Oq67ALFeX/C5KgKQN0RNxIdd8ZZ+fFImKrYqcQbUl1fdKJTWZkWRq7c67GMAShEGdiw2ZP1J42x9lVMP75r+fN48sD1J+VNhCs1v/3QOkmOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127681; c=relaxed/simple;
	bh=NPkqtlIp+xHGvm3GLxHAjqcdlu7FEkPbfUXqj+L3Km4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=T1q3Bv9WJqIswQ1a2LlQEwluaFcTgUrzr786E55/HVpou4rzubpBJNlVaQ2xaOU+gvBzOww55ldhlXmFHpyFO545+JXV9LG17mP/7vAWt4cfdQGlp5mg1+m8wz0/G5TwhWpoBZIivY1yfGi7WzhnacZTgJai+1L4ED4S3LW/0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wSjcfkTd; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726127675; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=dYU0VAB3CUut9S7OAZml/Q5y5JLsH2ot7LKXNCPmZSo=;
	b=wSjcfkTdrq9O49UkreUmSQ2SE9ZC66oHDEvwrFwUKNRsE4J0G74/NRsuKza+ReEOjC1lhAAoZzobjInyV7UK1TbwYHqTYDSHWagwZNHK+SD7P/bcj8f9nd7msyIGzCk3GUK+RbBd+CpcKWmrXZG2FD+YgvLcHtCriw4G2x/6w/k=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEqjsd-_1726127674)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 15:54:34 +0800
Message-ID: <1726127409.3427224-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 07/13] virtio_net: refactor the xmit type
Date: Thu, 12 Sep 2024 15:50:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEuDg800zy+-W7VRY5Ns4COsmvMP_kpHdzJ-ws8PuMoGhA@mail.gmail.com>
In-Reply-To: <CACGkMEuDg800zy+-W7VRY5Ns4COsmvMP_kpHdzJ-ws8PuMoGhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 11 Sep 2024 12:04:16 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Because the af-xdp will introduce a new xmit type, so I refactor the
> > xmit type mechanism first.
> >
> > We use the last two bits of the pointer to distinguish the xmit type,
> > so we can distinguish four xmit types. Now we have three types: skb,
> > orphan and xdp.
>
> And if I was not wrong, we do not anymore use bitmasks. If yes, let's
> explain the reason here.

In general, pointers are aligned to 4 or 8 bytes. If it is aligned to 4 byt=
es,
then only two bits are free for a pointer. So we can only use two bits.

But there are 4 types here, so we can't use bits to distinguish them.

b00 for skb
b01 for SKB_ORPHAN
b10 for XDP
b11 for af-xdp tx


>
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 90 +++++++++++++++++++++++-----------------
> >  1 file changed, 51 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 41aaea3b90fd..96abee36738b 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -45,9 +45,6 @@ module_param(napi_tx, bool, 0644);
> >  #define VIRTIO_XDP_TX          BIT(0)
> >  #define VIRTIO_XDP_REDIR       BIT(1)
> >
> > -#define VIRTIO_XDP_FLAG                BIT(0)
> > -#define VIRTIO_ORPHAN_FLAG     BIT(1)
> > -
> >  /* RX packet size EWMA. The average packet size is used to determine t=
he packet
> >   * buffer size when refilling RX rings. As the entire RX ring may be r=
efilled
> >   * at once, the weight is chosen so that the EWMA will be insensitive =
to short-
> > @@ -509,34 +506,35 @@ static struct sk_buff *virtnet_skb_append_frag(st=
ruct sk_buff *head_skb,
> >                                                struct page *page, void =
*buf,
> >                                                int len, int truesize);
> >
> > -static bool is_xdp_frame(void *ptr)
> > -{
> > -       return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> > -}
> > +enum virtnet_xmit_type {
> > +       VIRTNET_XMIT_TYPE_SKB,
> > +       VIRTNET_XMIT_TYPE_ORPHAN,
>
> Let's rename this to SKB_ORPHAN?
>
> > +       VIRTNET_XMIT_TYPE_XDP,
> > +};
> >
> > -static void *xdp_to_ptr(struct xdp_frame *ptr)
> > -{
> > -       return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
> > -}
> > +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_T=
YPE_ORPHAN \
> > +                               | VIRTNET_XMIT_TYPE_XDP)
>

Maybe I should define VIRTNET_XMIT_TYPE_MASK to 0x3 directly with some comm=
ents.

Thanks.


> I may miss something but it seems not a correct bitmask definition as
> each member is not a bit actually?
>
> >
> > -static struct xdp_frame *ptr_to_xdp(void *ptr)
> > +static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> >  {
> > -       return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FL=
AG);
> > -}
> > +       unsigned long p =3D (unsigned long)*ptr;
> >
> > -static bool is_orphan_skb(void *ptr)
> > -{
> > -       return (unsigned long)ptr & VIRTIO_ORPHAN_FLAG;
> > +       *ptr =3D (void *)(p & ~VIRTNET_XMIT_TYPE_MASK);
> > +
> > +       return p & VIRTNET_XMIT_TYPE_MASK;
> >  }
> >
> > -static void *skb_to_ptr(struct sk_buff *skb, bool orphan)
> > +static void *virtnet_xmit_ptr_mix(void *ptr, enum virtnet_xmit_type ty=
pe)
> >  {
> > -       return (void *)((unsigned long)skb | (orphan ? VIRTIO_ORPHAN_FL=
AG : 0));
> > +       return (void *)((unsigned long)ptr | type);
> >  }
> >
> > -static struct sk_buff *ptr_to_skb(void *ptr)
> > +static int virtnet_add_outbuf(struct send_queue *sq, int num, void *da=
ta,
> > +                             enum virtnet_xmit_type type)
> >  {
> > -       return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_F=
LAG);
> > +       return virtqueue_add_outbuf(sq->vq, sq->sg, num,
> > +                                   virtnet_xmit_ptr_mix(data, type),
> > +                                   GFP_ATOMIC);
> >  }
> >
> >  static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 l=
en)
> > @@ -549,29 +547,37 @@ static void sg_fill_dma(struct scatterlist *sg, d=
ma_addr_t addr, u32 len)
> >  static void __free_old_xmit(struct send_queue *sq, struct netdev_queue=
 *txq,
> >                             bool in_napi, struct virtnet_sq_free_stats =
*stats)
> >  {
> > +       struct xdp_frame *frame;
> > +       struct sk_buff *skb;
> >         unsigned int len;
> >         void *ptr;
> >
> >         while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> > -               if (!is_xdp_frame(ptr)) {
> > -                       struct sk_buff *skb =3D ptr_to_skb(ptr);
> > +               switch (virtnet_xmit_ptr_strip(&ptr)) {
> > +               case VIRTNET_XMIT_TYPE_SKB:
> > +                       skb =3D ptr;
> >
> >                         pr_debug("Sent skb %p\n", skb);
> > +                       stats->napi_packets++;
> > +                       stats->napi_bytes +=3D skb->len;
> > +                       napi_consume_skb(skb, in_napi);
> > +                       break;
> >
> > -                       if (is_orphan_skb(ptr)) {
> > -                               stats->packets++;
> > -                               stats->bytes +=3D skb->len;
> > -                       } else {
> > -                               stats->napi_packets++;
> > -                               stats->napi_bytes +=3D skb->len;
> > -                       }
> > +               case VIRTNET_XMIT_TYPE_ORPHAN:
> > +                       skb =3D ptr;
> > +
> > +                       stats->packets++;
> > +                       stats->bytes +=3D skb->len;
> >                         napi_consume_skb(skb, in_napi);
> > -               } else {
> > -                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> > +                       break;
> > +
> > +               case VIRTNET_XMIT_TYPE_XDP:
> > +                       frame =3D ptr;
> >
> >                         stats->packets++;
> >                         stats->bytes +=3D xdp_get_frame_len(frame);
> >                         xdp_return_frame(frame);
> > +                       break;
> >                 }
> >         }
> >         netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi=
_bytes);
> > @@ -1421,8 +1427,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_=
info *vi,
> >                             skb_frag_size(frag), skb_frag_off(frag));
> >         }
> >
> > -       err =3D virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> > -                                  xdp_to_ptr(xdpf), GFP_ATOMIC);
> > +       err =3D virtnet_add_outbuf(sq, nr_frags + 1, xdpf, VIRTNET_XMIT=
_TYPE_XDP);
> >         if (unlikely(err))
> >                 return -ENOSPC; /* Caller handle free/refcnt */
> >
> > @@ -3028,8 +3033,9 @@ static int xmit_skb(struct send_queue *sq, struct=
 sk_buff *skb, bool orphan)
> >                         return num_sg;
> >                 num_sg++;
> >         }
> > -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg,
> > -                                   skb_to_ptr(skb, orphan), GFP_ATOMIC=
);
> > +
> > +       return virtnet_add_outbuf(sq, num_sg, skb,
> > +                                 orphan ? VIRTNET_XMIT_TYPE_ORPHAN : V=
IRTNET_XMIT_TYPE_SKB);
> >  }
> >
> >  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *=
dev)
> > @@ -5906,10 +5912,16 @@ static void free_receive_page_frags(struct virt=
net_info *vi)
> >
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  {
> > -       if (!is_xdp_frame(buf))
> > +       switch (virtnet_xmit_ptr_strip(&buf)) {
> > +       case VIRTNET_XMIT_TYPE_SKB:
> > +       case VIRTNET_XMIT_TYPE_ORPHAN:
> >                 dev_kfree_skb(buf);
> > -       else
> > -               xdp_return_frame(ptr_to_xdp(buf));
> > +               break;
> > +
> > +       case VIRTNET_XMIT_TYPE_XDP:
> > +               xdp_return_frame(buf);
> > +               break;
> > +       }
> >  }
>
> Others look fine.
>
> Thanks
>
> >
> >  static void free_unused_bufs(struct virtnet_info *vi)
> > --
> > 2.32.0.3.g01195cf9f
> >
>

