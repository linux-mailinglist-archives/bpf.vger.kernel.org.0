Return-Path: <bpf+bounces-32278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED7190A7C3
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 09:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6915228A5C0
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 07:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0527B18FDD3;
	Mon, 17 Jun 2024 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c8rX5QaL"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E938396;
	Mon, 17 Jun 2024 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610834; cv=none; b=EBtBXZvezf6R0UnnNG3036PseeShdPyql8idtQO1YUlW10zanOvMSRdgmnDayk5lhz9+sa0EGZh8EBV3N4eZ7ahH0tSZWi96ldmZdj3SYyRt8BgoFF9STO+p4xyzfBp9kuqvj0/tkPixgu7Q6h/Cji014igZxxrKT+mvVEf/Itg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610834; c=relaxed/simple;
	bh=QZWLMROZJ6yMyPZMNTRw8uwJVgbM8CBulr5upUaL/1Q=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=gPGx9flMf0Lt+RJsjEMyGHa9IdHAWTZlObbYexTuO1o3feinb/2jvrZXaDWI6vbzqjupHfXhYxU7L3x8L0/LaV/2jcruCCjJZbK0oDpy0h11sNhX7sFgqj1eY0nozuwXQp8Dv+HijBVDSijTmwIvZ41zzjdNvpt7adVOrptyY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c8rX5QaL; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718610829; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=BOLIpsdx9COnZgmjEKNjHBVGCFu0GGUUJnuvMitqjF4=;
	b=c8rX5QaL0WCG0n/xgDcp0CmjDPR8cRuo3Asw3SAEdqo6PBInhxbphMDHBleUKCXpEWj2CKFI6A81zrmbYyozG7DsC36tKsNfik5gkzvOBAbPlGB8C1sWMS4McejbpFHBcKvvxQBnOBea41z5bW0/o1GoitytRDBIU5AEhxSiYkA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8aXrny_1718610828;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8aXrny_1718610828)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 15:53:49 +0800
Message-ID: <1718610681.9219804-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 11/15] virtio_net: xsk: tx: support xmit xsk buffer
Date: Mon, 17 Jun 2024 15:51:21 +0800
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
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-12-xuanzhuo@linux.alibaba.com>
 <CACGkMEsWg95zXVsnDWrAU1qRS0uuEJJR0rw7LVOV-fGuBGzQCQ@mail.gmail.com>
In-Reply-To: <CACGkMEsWg95zXVsnDWrAU1qRS0uuEJJR0rw7LVOV-fGuBGzQCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 17 Jun 2024 14:30:07 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Jun 14, 2024 at 2:40=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The driver's tx napi is very important for XSK. It is responsible for
> > obtaining data from the XSK queue and sending it out.
> >
> > At the beginning, we need to trigger tx napi.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 121 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 119 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 2767338dc060..7e811f392768 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -535,10 +535,13 @@ enum virtnet_xmit_type {
> >         VIRTNET_XMIT_TYPE_SKB,
> >         VIRTNET_XMIT_TYPE_XDP,
> >         VIRTNET_XMIT_TYPE_DMA,
> > +       VIRTNET_XMIT_TYPE_XSK,
> >  };
> >
> >  #define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_T=
YPE_XDP \
> > -                               | VIRTNET_XMIT_TYPE_DMA)
> > +                               | VIRTNET_XMIT_TYPE_DMA | VIRTNET_XMIT_=
TYPE_XSK)
> > +
> > +#define VIRTIO_XSK_FLAG_OFFSET 4
> >
> >  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> >  {
> > @@ -768,6 +771,10 @@ static void __free_old_xmit(struct send_queue *sq,=
 bool in_napi,
> >                          * func again.
> >                          */
> >                         goto retry;
> > +
> > +               case VIRTNET_XMIT_TYPE_XSK:
> > +                       /* Make gcc happy. DONE in subsequent commit */
>
> This is probably a hint that the next patch should be squashed here.

The code for the xmit patch is more. So I separate the code out.

>
> > +                       break;
> >                 }
> >         }
> >  }
> > @@ -1265,6 +1272,102 @@ static void check_sq_full_and_disable(struct vi=
rtnet_info *vi,
> >         }
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
> > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 l=
en)
> > +{
> > +       sg->dma_address =3D addr;
> > +       sg->length =3D len;
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
> > +       sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);
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
> > +                       xsk_tx_completed(sq->xsk.pool, nb_pkts - i);
> > +                       break;
>
> Any reason we don't need a kick here?

After the loop, I checked the kick.

Do you mean kick for the packet that encountered the error?


>
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
> > +       u64 kicks =3D 0;
> > +       int sent;
> > +
> > +       __free_old_xmit(sq, true, &stats);
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
> > @@ -2707,6 +2810,7 @@ static int virtnet_poll_tx(struct napi_struct *na=
pi, int budget)
> >         struct virtnet_info *vi =3D sq->vq->vdev->priv;
> >         unsigned int index =3D vq2txq(sq->vq);
> >         struct netdev_queue *txq;
> > +       bool xsk_busy =3D false;
> >         int opaque;
> >         bool done;
> >
> > @@ -2719,7 +2823,11 @@ static int virtnet_poll_tx(struct napi_struct *n=
api, int budget)
> >         txq =3D netdev_get_tx_queue(vi->dev, index);
> >         __netif_tx_lock(txq, raw_smp_processor_id());
> >         virtqueue_disable_cb(sq->vq);
> > -       free_old_xmit(sq, true);
> > +
> > +       if (sq->xsk.pool)
> > +               xsk_busy =3D virtnet_xsk_xmit(sq, sq->xsk.pool, budget);
>
> How about rename this to "xsk_sent"?


OK

Thanks.


>
> > +       else
> > +               free_old_xmit(sq, true);
> >
> >         if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> >                 if (netif_tx_queue_stopped(txq)) {
> > @@ -2730,6 +2838,11 @@ static int virtnet_poll_tx(struct napi_struct *n=
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
> > @@ -5715,6 +5828,10 @@ static void virtnet_sq_free_unused_buf(struct vi=
rtqueue *vq, void *buf)
> >         case VIRTNET_XMIT_TYPE_DMA:
> >                 virtnet_sq_unmap(sq, &buf);
> >                 goto retry;
> > +
> > +       case VIRTNET_XMIT_TYPE_XSK:
> > +               /* Make gcc happy. DONE in subsequent commit */
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

