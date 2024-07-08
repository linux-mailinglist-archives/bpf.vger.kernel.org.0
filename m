Return-Path: <bpf+bounces-34045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A14929D82
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 09:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992C51F226EC
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 07:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F813A27B;
	Mon,  8 Jul 2024 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cgkShHGh"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90332D638;
	Mon,  8 Jul 2024 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424846; cv=none; b=lkW7e2evKFMFcarve31HWJvkqT4QyHGU64erJQvv5KQayGIFKYK3hEXOtW8cNktT23vkKP/oPk12q6lVl1RUBIqgHdM82C75rKYOdCwz8tXNWkRRcMxs5RqDWwyxoNQZ3oOxOykRw/KllZBbhkyCAP0w8ElM0Ma94Z3CkQtl8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424846; c=relaxed/simple;
	bh=UnDXitSkkEt+Jmw534QFr9fDFnlhoev+Fk+waL08Snc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=dbYuADl0vWlFbkdojfeBFByAspyjAlr5NjOpWLkp2oLTlu0/Vx7PUWG1bcphu1TovMJuSeFKN5Cp8CpXuztpKrg2mOv442HLJi8FTgpKXIfWIgi0BTK6+ebN8o2Pv31W3LP+1TbI5m4IeAXmKua31RLgHd5cgFYpHRREjkf/Gpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cgkShHGh; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720424841; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=esA4bqpXazIS13FqDzWbuZkVwKbi2WXZCkSctGCHOvI=;
	b=cgkShHGhhMQuGZzcuPrDMVLJutMjpDjhs+MjQEYbC0/r94PvLyI071l1kjX1oRq0J5AMQX31w9vOEc1wsm8OEzbFnj2OW3FuaKmVRb//wuuIvSHLCXcg50JCt5dBZoc7+nKcUCiyM72ZY4eFVhtPTDybtVQW4Om49YHSkCYdAV0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0WA2iGds_1720424839;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WA2iGds_1720424839)
          by smtp.aliyun-inc.com;
          Mon, 08 Jul 2024 15:47:20 +0800
Message-ID: <1720424536.972943-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v7 09/10] virtio_net: xsk: rx: support recv small mode
Date: Mon, 8 Jul 2024 15:42:16 +0800
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
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
 <20240705073734.93905-10-xuanzhuo@linux.alibaba.com>
 <CACGkMEsiMTs=PymmPrrfhmF6W=Oviwg4hWEbSFb1sghGYadSgg@mail.gmail.com>
In-Reply-To: <CACGkMEsiMTs=PymmPrrfhmF6W=Oviwg4hWEbSFb1sghGYadSgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 8 Jul 2024 15:00:50 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Jul 5, 2024 at 3:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > In the process:
> > 1. We may need to copy data to create skb for XDP_PASS.
> > 2. We may need to call xsk_buff_free() to release the buffer.
> > 3. The handle for xdp_buff is difference from the buffer.
> >
> > If we pushed this logic into existing receive handle(merge and small),
> > we would have to maintain code scattered inside merge and small (and bi=
g).
> > So I think it is a good choice for us to put the xsk code into an
> > independent function.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >
> > v7:
> >    1. rename xdp_construct_skb to xsk_construct_skb
> >    2. refactor virtnet_receive()
> >
> >  drivers/net/virtio_net.c | 176 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 168 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 2b27f5ada64a..64d8cd481890 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -498,6 +498,12 @@ struct virtio_net_common_hdr {
> >  };
> >
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf=
);
> > +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_b=
uff *xdp,
> > +                              struct net_device *dev,
> > +                              unsigned int *xdp_xmit,
> > +                              struct virtnet_rq_stats *stats);
> > +static void virtnet_receive_done(struct virtnet_info *vi, struct recei=
ve_queue *rq,
> > +                                struct sk_buff *skb, u8 flags);
> >
> >  static bool is_xdp_frame(void *ptr)
> >  {
> > @@ -1062,6 +1068,124 @@ static void sg_fill_dma(struct scatterlist *sg,=
 dma_addr_t addr, u32 len)
> >         sg->length =3D len;
> >  }
> >
> > +static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> > +                                  struct receive_queue *rq, void *buf,=
 u32 len)
> > +{
> > +       struct xdp_buff *xdp;
> > +       u32 bufsize;
> > +
> > +       xdp =3D (struct xdp_buff *)buf;
> > +
> > +       bufsize =3D xsk_pool_get_rx_frame_size(rq->xsk_pool) + vi->hdr_=
len;
> > +
> > +       if (unlikely(len > bufsize)) {
> > +               pr_debug("%s: rx error: len %u exceeds truesize %u\n",
> > +                        vi->dev->name, len, bufsize);
> > +               DEV_STATS_INC(vi->dev, rx_length_errors);
> > +               xsk_buff_free(xdp);
> > +               return NULL;
> > +       }
> > +
> > +       xsk_buff_set_size(xdp, len);
> > +       xsk_buff_dma_sync_for_cpu(xdp);
> > +
> > +       return xdp;
> > +}
> > +
> > +static struct sk_buff *xsk_construct_skb(struct receive_queue *rq,
> > +                                        struct xdp_buff *xdp)
> > +{
> > +       unsigned int metasize =3D xdp->data - xdp->data_meta;
> > +       struct sk_buff *skb;
> > +       unsigned int size;
> > +
> > +       size =3D xdp->data_end - xdp->data_hard_start;
> > +       skb =3D napi_alloc_skb(&rq->napi, size);
> > +       if (unlikely(!skb)) {
> > +               xsk_buff_free(xdp);
> > +               return NULL;
> > +       }
> > +
> > +       skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> > +
> > +       size =3D xdp->data_end - xdp->data_meta;
> > +       memcpy(__skb_put(skb, size), xdp->data_meta, size);
> > +
> > +       if (metasize) {
> > +               __skb_pull(skb, metasize);
> > +               skb_metadata_set(skb, metasize);
> > +       }
> > +
> > +       xsk_buff_free(xdp);
> > +
> > +       return skb;
> > +}
> > +
> > +static struct sk_buff *virtnet_receive_xsk_small(struct net_device *de=
v, struct virtnet_info *vi,
> > +                                                struct receive_queue *=
rq, struct xdp_buff *xdp,
> > +                                                unsigned int *xdp_xmit,
> > +                                                struct virtnet_rq_stat=
s *stats)
> > +{
> > +       struct bpf_prog *prog;
> > +       u32 ret;
> > +
> > +       ret =3D XDP_PASS;
> > +       rcu_read_lock();
> > +       prog =3D rcu_dereference(rq->xdp_prog);
> > +       if (prog)
> > +               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, s=
tats);
> > +       rcu_read_unlock();
> > +
> > +       switch (ret) {
> > +       case XDP_PASS:
> > +               return xsk_construct_skb(rq, xdp);
> > +
> > +       case XDP_TX:
> > +       case XDP_REDIRECT:
> > +               return NULL;
> > +
> > +       default:
> > +               /* drop packet */
> > +               xsk_buff_free(xdp);
> > +               u64_stats_inc(&stats->drops);
> > +               return NULL;
> > +       }
> > +}
> > +
> > +static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct re=
ceive_queue *rq,
> > +                                   void *buf, u32 len,
> > +                                   unsigned int *xdp_xmit,
> > +                                   struct virtnet_rq_stats *stats)
> > +{
> > +       struct net_device *dev =3D vi->dev;
> > +       struct sk_buff *skb =3D NULL;
> > +       struct xdp_buff *xdp;
> > +       u8 flags;
> > +
> > +       len -=3D vi->hdr_len;
> > +
> > +       u64_stats_add(&stats->bytes, len);
> > +
> > +       xdp =3D buf_to_xdp(vi, rq, buf, len);
> > +       if (!xdp)
> > +               return;
> > +
> > +       if (unlikely(len < ETH_HLEN)) {
> > +               pr_debug("%s: short packet %i\n", dev->name, len);
> > +               DEV_STATS_INC(dev, rx_length_errors);
> > +               xsk_buff_free(xdp);
> > +               return;
> > +       }
> > +
> > +       flags =3D ((struct virtio_net_common_hdr *)(xdp->data - vi->hdr=
_len))->hdr.flags;
> > +
> > +       if (!vi->mergeable_rx_bufs)
> > +               skb =3D virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp=
_xmit, stats);
>
> I wonder if we add the mergeable support in the next patch would it be
> better to re-order the patch? For example, the xsk binding needs to be
> moved to the last patch, otherwise we break xsk with a mergeable
> buffer here?

If you worry that the user works with this commit, I want to say you do not
worry.

Because the flags NETDEV_XDP_ACT_XSK_ZEROCOPY is not added. I plan to add t=
hat
after the tx is completed.

I do test by adding this flags locally.

Thanks.

>
> Or anything I missed here?
>
> Thanks
>

