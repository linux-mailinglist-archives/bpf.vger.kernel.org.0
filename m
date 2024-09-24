Return-Path: <bpf+bounces-40258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5111984520
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 13:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4B61F24447
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25C15099D;
	Tue, 24 Sep 2024 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hI3lG33b"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F712A14C;
	Tue, 24 Sep 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178540; cv=none; b=kGyXmf0txE5ybMMNsmfMTU4Ct456I+jOpGrGJPGakp1YjFjmIKaupjcfXy9PNAZZZY3oRQ5n7EK1QYC8TyXuXXrEEkTYkuXiF2y4iMLJSZGWqNoeLa88N1gTczRrqK1oLTT9Z1h/5mp6sEHx46ZafVMSwcsY4B5153q5EZnzuZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178540; c=relaxed/simple;
	bh=nI5RZTnw4jCOprF1i9T8BMmd/c22vlBCqxaEQkrHbaQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=bmISc3ndSIDSupkropqZszRX4LVB++IYF6KL/2y7V8eJZ2Yzxu/lk9rov+vAjQQC9F0xbkuuHCGp5R0zWdURZp4oe/cNOn1j5dNnUDGUGSu2ZOFkjokx8o9nB0+uFik9e2wHxmVZ+DcE81Z1itgbj+0k23vvRnurXG2duNFmvhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hI3lG33b; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727178530; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=8wY6jYmr1SXICebQz5ZYZffdhVXbWENuHCzft78Vc/k=;
	b=hI3lG33b0j94OFGiyykYk0DuEPux3RPrpMmYYUDuCp27KOTEnimdyesdjsjS++x9CQEcseTSOBC/zU+Y3k868g4lRnF7LNMHJM0gc+3Cc7NfsvWRprYR3XgdqEnG70bXtGeNhakdbQP9ZPaaO+Ei5Qm7HmbX6X7wUj2zxMFb6Ik=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFgDpQ6_1727178528)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 19:48:49 +0800
Message-ID: <1727178087.972947-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next v1 10/12] virtio_net: xsk: tx: support xmit xsk buffer
Date: Tue, 24 Sep 2024 19:41:27 +0800
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
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
 <20240924013204.13763-11-xuanzhuo@linux.alibaba.com>
 <CACGkMEvbxs4AK+xCW0i-ZMo4B5WEKMLmFHBu_7ZRa+4Pv+-44w@mail.gmail.com>
In-Reply-To: <CACGkMEvbxs4AK+xCW0i-ZMo4B5WEKMLmFHBu_7ZRa+4Pv+-44w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 24 Sep 2024 15:35:08 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The driver's tx napi is very important for XSK. It is responsible for
> > obtaining data from the XSK queue and sending it out.
> >
> > At the beginning, we need to trigger tx napi.
> >
> > virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
> > buffer) by the last bits of the pointer.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 176 ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 166 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 3ad4c6e3ef18..1a870f1df910 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -83,6 +83,7 @@ struct virtnet_sq_free_stats {
> >         u64 bytes;
> >         u64 napi_packets;
> >         u64 napi_bytes;
> > +       u64 xsk;
> >  };
> >
> >  struct virtnet_sq_stats {
> > @@ -514,16 +515,20 @@ static struct sk_buff *virtnet_skb_append_frag(st=
ruct sk_buff *head_skb,
> >                                                struct sk_buff *curr_skb,
> >                                                struct page *page, void =
*buf,
> >                                                int len, int truesize);
> > +static void virtnet_xsk_completed(struct send_queue *sq, int num);
> >
> >  enum virtnet_xmit_type {
> >         VIRTNET_XMIT_TYPE_SKB,
> >         VIRTNET_XMIT_TYPE_SKB_ORPHAN,
> >         VIRTNET_XMIT_TYPE_XDP,
> > +       VIRTNET_XMIT_TYPE_XSK,
> >  };
> >
> >  /* We use the last two bits of the pointer to distinguish the xmit typ=
e. */
> >  #define VIRTNET_XMIT_TYPE_MASK (BIT(0) | BIT(1))
> >
> > +#define VIRTIO_XSK_FLAG_OFFSET 4
>
> Any reason this is not 2?

There's no particular reason for this, any value greater than 2 will work.


>
> > +
> >  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> >  {
> >         unsigned long p =3D (unsigned long)*ptr;
> > @@ -546,6 +551,11 @@ static int virtnet_add_outbuf(struct send_queue *s=
q, int num, void *data,
> >                                     GFP_ATOMIC);
> >  }
> >
> > +static u32 virtnet_ptr_to_xsk_buff_len(void *ptr)
> > +{
> > +       return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
> > +}
> > +
> >  static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 l=
en)
> >  {
> >         sg_assign_page(sg, NULL);
> > @@ -587,11 +597,27 @@ static void __free_old_xmit(struct send_queue *sq=
, struct netdev_queue *txq,
> >                         stats->bytes +=3D xdp_get_frame_len(frame);
> >                         xdp_return_frame(frame);
> >                         break;
> > +
> > +               case VIRTNET_XMIT_TYPE_XSK:
> > +                       stats->bytes +=3D virtnet_ptr_to_xsk_buff_len(p=
tr);
> > +                       stats->xsk++;
> > +                       break;
> >                 }
> >         }
> >         netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi=
_bytes);
>
> Not related to this patch, but this seems unnecessary to AF_XDP.

YES.

netdev_tx_completed_queue will check napi_bytes firstly.
So I do not think we need to do anything for this.

>
> >  }
> >
> > +static void virtnet_free_old_xmit(struct send_queue *sq,
> > +                                 struct netdev_queue *txq,
> > +                                 bool in_napi,
> > +                                 struct virtnet_sq_free_stats *stats)
> > +{
> > +       __free_old_xmit(sq, txq, in_napi, stats);
> > +
> > +       if (stats->xsk)
> > +               virtnet_xsk_completed(sq, stats->xsk);
> > +}
> > +
> >  /* Converting between virtqueue no. and kernel tx/rx queue no.
> >   * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
> >   */
> > @@ -1019,7 +1045,7 @@ static void free_old_xmit(struct send_queue *sq, =
struct netdev_queue *txq,
> >  {
> >         struct virtnet_sq_free_stats stats =3D {0};
> >
> > -       __free_old_xmit(sq, txq, in_napi, &stats);
> > +       virtnet_free_old_xmit(sq, txq, in_napi, &stats);
> >
> >         /* Avoid overhead when no packets have been processed
> >          * happens when called speculatively from start_xmit.
> > @@ -1380,6 +1406,111 @@ static int virtnet_add_recvbuf_xsk(struct virtn=
et_info *vi, struct receive_queue
> >         return err;
> >  }
> >
> > +static void *virtnet_xsk_to_ptr(u32 len)
> > +{
> > +       unsigned long p;
> > +
> > +       p =3D len << VIRTIO_XSK_FLAG_OFFSET;
> > +
> > +       return virtnet_xmit_ptr_mix((void *)p, VIRTNET_XMIT_TYPE_XSK);
> > +}
> > +
> > +static int virtnet_xsk_xmit_one(struct send_queue *sq,
> > +                               struct xsk_buff_pool *pool,
> > +                               struct xdp_desc *desc)
> > +{
> > +       struct virtnet_info *vi;
> > +       dma_addr_t addr;
> > +
> > +       vi =3D sq->vq->vdev->priv;
> > +
> > +       addr =3D xsk_buff_raw_get_dma(pool, desc->addr);
> > +       xsk_buff_raw_dma_sync_for_device(pool, addr, desc->len);
> > +
> > +       sg_init_table(sq->sg, 2);
> > +
> > +       sg_fill_dma(sq->sg, sq->xsk_hdr_dma_addr, vi->hdr_len);
> > +       sg_fill_dma(sq->sg + 1, addr, desc->len);
> > +
> > +       return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
> > +                                   virtnet_xsk_to_ptr(desc->len), GFP_=
ATOMIC);
> > +}
> > +
> > +static int virtnet_xsk_xmit_batch(struct send_queue *sq,
> > +                                 struct xsk_buff_pool *pool,
> > +                                 unsigned int budget,
> > +                                 u64 *kicks)
> > +{
> > +       struct xdp_desc *descs =3D pool->tx_descs;
> > +       bool kick =3D false;
> > +       u32 nb_pkts, i;
> > +       int err;
> > +
> > +       budget =3D min_t(u32, budget, sq->vq->num_free);
> > +
> > +       nb_pkts =3D xsk_tx_peek_release_desc_batch(pool, budget);
> > +       if (!nb_pkts)
> > +               return 0;
> > +
> > +       for (i =3D 0; i < nb_pkts; i++) {
> > +               err =3D virtnet_xsk_xmit_one(sq, pool, &descs[i]);
> > +               if (unlikely(err)) {
> > +                       xsk_tx_completed(sq->xsk_pool, nb_pkts - i);
> > +                       break;
> > +               }
> > +
> > +               kick =3D true;
> > +       }
> > +
> > +       if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notify(=
sq->vq))
> > +               (*kicks)++;
> > +
> > +       return i;
> > +}
> > +
> > +static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_po=
ol *pool,
> > +                            int budget)
> > +{
> > +       struct virtnet_info *vi =3D sq->vq->vdev->priv;
> > +       struct virtnet_sq_free_stats stats =3D {};
> > +       struct net_device *dev =3D vi->dev;
> > +       u64 kicks =3D 0;
> > +       int sent;
> > +
> > +       /* Avoid to wakeup napi meanless, so call __free_old_xmit. */
>
> I don't understand the meaning of this comment.

The comments need to be more detailed. Here I want to explain why not just =
use
free_old_xmit.


>
> > +       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), true=
, &stats);
> > +
> > +       if (stats.xsk)
> > +               xsk_tx_completed(sq->xsk_pool, stats.xsk);
> > +
> > +       sent =3D virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
> > +
> > +       if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> > +               check_sq_full_and_disable(vi, vi->dev, sq);
> > +
> > +       u64_stats_update_begin(&sq->stats.syncp);
> > +       u64_stats_add(&sq->stats.packets, stats.packets);
> > +       u64_stats_add(&sq->stats.bytes,   stats.bytes);
> > +       u64_stats_add(&sq->stats.kicks,   kicks);
> > +       u64_stats_add(&sq->stats.xdp_tx,  sent);
> > +       u64_stats_update_end(&sq->stats.syncp);
> > +
> > +       if (xsk_uses_need_wakeup(pool))
> > +               xsk_set_tx_need_wakeup(pool);
> > +
> > +       return sent =3D=3D budget;
> > +}
> > +
> > +static void xsk_wakeup(struct send_queue *sq)
> > +{
> > +       if (napi_if_scheduled_mark_missed(&sq->napi))
> > +               return;
> > +
> > +       local_bh_disable();
> > +       virtqueue_napi_schedule(&sq->napi, sq->vq);
> > +       local_bh_enable();
> > +}
> > +
> >  static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 fla=
g)
> >  {
> >         struct virtnet_info *vi =3D netdev_priv(dev);
> > @@ -1393,14 +1524,19 @@ static int virtnet_xsk_wakeup(struct net_device=
 *dev, u32 qid, u32 flag)
> >
> >         sq =3D &vi->sq[qid];
> >
> > -       if (napi_if_scheduled_mark_missed(&sq->napi))
> > -               return 0;
> > +       xsk_wakeup(sq);
> > +       return 0;
> > +}
> >
> > -       local_bh_disable();
> > -       virtqueue_napi_schedule(&sq->napi, sq->vq);
> > -       local_bh_enable();
> > +static void virtnet_xsk_completed(struct send_queue *sq, int num)
> > +{
> > +       xsk_tx_completed(sq->xsk_pool, num);
> >
> > -       return 0;
> > +       /* If this is called by rx poll, start_xmit and xdp xmit we sho=
uld
> > +        * wakeup the tx napi to consume the xsk tx queue, because the =
tx
> > +        * interrupt may not be triggered.
> > +        */
> > +       xsk_wakeup(sq);
> >  }
> >
> >  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> > @@ -1516,8 +1652,8 @@ static int virtnet_xdp_xmit(struct net_device *de=
v,
> >         }
> >
> >         /* Free up any pending old buffers before queueing new ones. */
> > -       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
> > -                       false, &stats);
> > +       virtnet_free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
> > +                             false, &stats);
> >
> >         for (i =3D 0; i < n; i++) {
> >                 struct xdp_frame *xdpf =3D frames[i];
> > @@ -2961,6 +3097,7 @@ static int virtnet_poll_tx(struct napi_struct *na=
pi, int budget)
> >         struct virtnet_info *vi =3D sq->vq->vdev->priv;
> >         unsigned int index =3D vq2txq(sq->vq);
> >         struct netdev_queue *txq;
> > +       bool xsk_busy =3D false;
> >         int opaque;
> >         bool done;
> >
> > @@ -2973,7 +3110,11 @@ static int virtnet_poll_tx(struct napi_struct *n=
api, int budget)
> >         txq =3D netdev_get_tx_queue(vi->dev, index);
> >         __netif_tx_lock(txq, raw_smp_processor_id());
> >         virtqueue_disable_cb(sq->vq);
> > -       free_old_xmit(sq, txq, !!budget);
> > +
> > +       if (sq->xsk_pool)
> > +               xsk_busy =3D virtnet_xsk_xmit(sq, sq->xsk_pool, budget);
>
> I think we need a better name of "xsk_busy", it looks like it means we
> exceeds the quota. Or just return the number of buffers received and
> let the caller to judge.

Will fix.

Thanks.


>
> Other looks good.
>
> With this fixed.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>

