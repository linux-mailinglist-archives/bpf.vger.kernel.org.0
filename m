Return-Path: <bpf+bounces-39706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3B99764E7
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 10:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27391C23070
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D07191F6E;
	Thu, 12 Sep 2024 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S33JhWaL"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53218C033;
	Thu, 12 Sep 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131031; cv=none; b=Re1872fqM8u8x3Z3eVttUglac/N+pMIP7esxn7CokCUDGeBtF1lOwEbmmByy2UkYflSf73bT67f+hUy2Gu/6zEvNmuzGlGfB3Fl5dN+Ogs2eVBfhKAHoAAjTJpaccz8cQJSEoZfhGntbjt7HE7jNqc1Zs9w/Hngi9mPyB+8GJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131031; c=relaxed/simple;
	bh=DO4jQefOJT7rdnEMjmJp7Kv0CHLQb1Fm0QtRpGeRuro=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=tPbRab2nf4QsxNXc05AG/Ac/PW7jtAV7F59LzXoQJtrwFyIJv8nKiTzT582eGOmw6HCpTDUl8ECvSnER0idT1Bk7LBaDd5bIXrClhxmJVmdfpKksNGLeqI7t7Bys9sFfMz6mkYV8d2+uauiDk44waCCgJQiGxQII3axUc0h0Qag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S33JhWaL; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726131020; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=xegexEWbi22M1dDA13zly0DPNZGTYkIW17s7tJeyqz4=;
	b=S33JhWaLx5bTxtnex5EvZz65FhjI+GaUWfWmoZkhf6av4D6yme3ge9MTZ76O4V2WR1rlZIFELfYKLsSAyf3Oenik1fRJ2eIBFgQcWMUGbBwebeFNdtKu/5njVUMSIzdoWm/P5yG6Ao20A6COv/3ku2+N4nt+OQid11yQe0Or5a4=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEqsm9C_1726131019)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 16:50:19 +0800
Message-ID: <1726130924.279801-7-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 10/13] virtio_net: xsk: tx: support xmit xsk buffer
Date: Thu, 12 Sep 2024 16:48:44 +0800
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
 <20240820073330.9161-11-xuanzhuo@linux.alibaba.com>
 <CACGkMEv5DZgm1B5CXeHnP4ZPmZzQv7zWHT5=D1oH-h_bin2p7w@mail.gmail.com>
In-Reply-To: <CACGkMEv5DZgm1B5CXeHnP4ZPmZzQv7zWHT5=D1oH-h_bin2p7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 11 Sep 2024 12:31:32 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The driver's tx napi is very important for XSK. It is responsible for
> > obtaining data from the XSK queue and sending it out.
> >
> > At the beginning, we need to trigger tx napi.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 127 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 125 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 221681926d23..3743694d3c3b 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -516,10 +516,13 @@ enum virtnet_xmit_type {
> >         VIRTNET_XMIT_TYPE_SKB,
> >         VIRTNET_XMIT_TYPE_ORPHAN,
> >         VIRTNET_XMIT_TYPE_XDP,
> > +       VIRTNET_XMIT_TYPE_XSK,
> >  };
> >
> >  #define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_T=
YPE_ORPHAN \
> > -                               | VIRTNET_XMIT_TYPE_XDP)
> > +                               | VIRTNET_XMIT_TYPE_XDP | VIRTNET_XMIT_=
TYPE_XSK)
> > +
> > +#define VIRTIO_XSK_FLAG_OFFSET 4
> >
> >  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> >  {
> > @@ -543,6 +546,11 @@ static int virtnet_add_outbuf(struct send_queue *s=
q, int num, void *data,
> >                                     GFP_ATOMIC);
> >  }
> >
> > +static u32 virtnet_ptr_to_xsk(void *ptr)
> > +{
> > +       return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
> > +}
> > +
>
> This needs a better name, otherwise readers might be confused.
>
> E.g something like virtnet_ptr_to_xsk_buff_len()?
>
> >  static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 l=
en)
> >  {
> >         sg_assign_page(sg, NULL);
> > @@ -584,6 +592,10 @@ static void __free_old_xmit(struct send_queue *sq,=
 struct netdev_queue *txq,
> >                         stats->bytes +=3D xdp_get_frame_len(frame);
> >                         xdp_return_frame(frame);
> >                         break;
> > +
> > +               case VIRTNET_XMIT_TYPE_XSK:
> > +                       stats->bytes +=3D virtnet_ptr_to_xsk(ptr);
> > +                       break;
>
> Do we miss xsk_tx_completed() here?
>
> >                 }
> >         }
> >         netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi=
_bytes);
> > @@ -1393,6 +1405,97 @@ static int virtnet_xsk_wakeup(struct net_device =
*dev, u32 qid, u32 flag)
> >         return 0;
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
>
> Should we kick in this condition?
>
> > +                       break;
> > +               }
> > +
> > +               kick =3D true;
> > +       }
> > +
> > +       if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notify(=
sq->vq))
>
> Can we simply use virtqueue_kick() here?
>
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
> > +       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), true=
, &stats);
>
> I haven't checked in depth, but I wonder if we have some side effects
> when using non NAPI tx mode:
>
>         if (napi->weight)
>                 virtqueue_napi_schedule(napi, vq);
>         else
>                 /* We were probably waiting for more output buffers. */
>                 netif_wake_subqueue(vi->dev, vq2txq(vq));
>
> Does this mean xsk will suffer the same issue like when there's no xsk
> xmit request, we could end up with no way to reclaim xmitted xsk
> buffers? (Or should we disallow AF_XDP to be used for non TX-NAPI
> mode?)

Disallow AF_XDP to be used for non TX-NAPI mode.

The last patch #9 does this.

#9 [PATCH net-next 09/13] virtio_net: xsk: prevent disable tx napi

Thanks.
>
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
> >  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> >                                    struct send_queue *sq,
> >                                    struct xdp_frame *xdpf)
> > @@ -2949,6 +3052,7 @@ static int virtnet_poll_tx(struct napi_struct *na=
pi, int budget)
> >         struct virtnet_info *vi =3D sq->vq->vdev->priv;
> >         unsigned int index =3D vq2txq(sq->vq);
> >         struct netdev_queue *txq;
> > +       bool xsk_busy =3D false;
> >         int opaque;
> >         bool done;
> >
> > @@ -2961,7 +3065,11 @@ static int virtnet_poll_tx(struct napi_struct *n=
api, int budget)
> >         txq =3D netdev_get_tx_queue(vi->dev, index);
> >         __netif_tx_lock(txq, raw_smp_processor_id());
> >         virtqueue_disable_cb(sq->vq);
> > -       free_old_xmit(sq, txq, !!budget);
> > +
> > +       if (sq->xsk_pool)
> > +               xsk_busy =3D virtnet_xsk_xmit(sq, sq->xsk_pool, budget);
> > +       else
> > +               free_old_xmit(sq, txq, !!budget);
> >
> >         if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> >                 if (netif_tx_queue_stopped(txq)) {
> > @@ -2972,6 +3080,11 @@ static int virtnet_poll_tx(struct napi_struct *n=
api, int budget)
> >                 netif_tx_wake_queue(txq);
> >         }
> >
> > +       if (xsk_busy) {
> > +               __netif_tx_unlock(txq);
> > +               return budget;
> > +       }
> > +
> >         opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> >
> >         done =3D napi_complete_done(napi, 0);
> > @@ -5974,6 +6087,12 @@ static void free_receive_page_frags(struct virtn=
et_info *vi)
> >
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  {
> > +       struct virtnet_info *vi =3D vq->vdev->priv;
> > +       struct send_queue *sq;
> > +       int i =3D vq2rxq(vq);
> > +
> > +       sq =3D &vi->sq[i];
> > +
> >         switch (virtnet_xmit_ptr_strip(&buf)) {
> >         case VIRTNET_XMIT_TYPE_SKB:
> >         case VIRTNET_XMIT_TYPE_ORPHAN:
> > @@ -5983,6 +6102,10 @@ static void virtnet_sq_free_unused_buf(struct vi=
rtqueue *vq, void *buf)
> >         case VIRTNET_XMIT_TYPE_XDP:
> >                 xdp_return_frame(buf);
> >                 break;
> > +
> > +       case VIRTNET_XMIT_TYPE_XSK:
> > +               xsk_tx_completed(sq->xsk_pool, 1);
> > +               break;
> >         }
> >  }
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>

