Return-Path: <bpf+bounces-32365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F42890C173
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 03:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD2B228E4
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 01:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD29E13AD8;
	Tue, 18 Jun 2024 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FqmzsqJW"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1B314295;
	Tue, 18 Jun 2024 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674851; cv=none; b=SOo2dbOInFgofO9wvRTo1U5MJfym9ijyOiNvvansVTWZ7om0fGLtbruq7NOuDTemSlNf6sMId6wHR9Zr8QWrkfkdEOecsebq/rdB2NvtM0r4mBd2szlEzmKlCssVVvgX4VextDDPJiadgIzLCd7m+vR3nz6LQ9iX4hfSBIx6Ff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674851; c=relaxed/simple;
	bh=hvQTP8Ry/qU1EpjbUIawlcOMrW4GBpWF0fVUYya78NM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=OjqRNyALDG/UuRf10RVDlWSnjrNaRilXXY5u+DYpvq9mMOfGIBVpZyBE7mPsQGZNj5K/x11XljYENUY4U8NgHZI8+InEgy09YbqIfMzMLpezmCxtv7tPEHLB3mjeZDVzPI3jKJTNvJypQKCMKpWhckDkxGqyknLGYJA+5kkzduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FqmzsqJW; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718674846; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=XUzSPYOwy9ttnTtGkmH+DS8/GdC3Dw7Xnzzm2WXn79o=;
	b=FqmzsqJWptKs7t4vd+nnN9wE5+nxRnmD7rNfzl7AGA7IDNQfPT1vnfj/aXWiYmzI5jLkKCqexTo8l4ceF6Ba/bAnQEQTogwFB2PmPTO1NAL1Jc28ID+wgLp17VX6YpIajJ/5njxpB3E04cTL/uTkWG4rxUoI5mQpD2ICEc0Ei2w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8hvTFB_1718674844;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8hvTFB_1718674844)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 09:40:45 +0800
Message-ID: <1718674830.0975292-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 11/15] virtio_net: xsk: tx: support xmit xsk buffer
Date: Tue, 18 Jun 2024 09:40:30 +0800
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
 <1718610681.9219804-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEsn8h9UCy66i_N6zOPbW7V=fSswPWRjsjJFKc310YUu3g@mail.gmail.com>
In-Reply-To: <CACGkMEsn8h9UCy66i_N6zOPbW7V=fSswPWRjsjJFKc310YUu3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 18 Jun 2024 09:06:50 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jun 17, 2024 at 3:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Mon, 17 Jun 2024 14:30:07 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Fri, Jun 14, 2024 at 2:40=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > The driver's tx napi is very important for XSK. It is responsible f=
or
> > > > obtaining data from the XSK queue and sending it out.
> > > >
> > > > At the beginning, we need to trigger tx napi.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 121 +++++++++++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 119 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 2767338dc060..7e811f392768 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -535,10 +535,13 @@ enum virtnet_xmit_type {
> > > >         VIRTNET_XMIT_TYPE_SKB,
> > > >         VIRTNET_XMIT_TYPE_XDP,
> > > >         VIRTNET_XMIT_TYPE_DMA,
> > > > +       VIRTNET_XMIT_TYPE_XSK,
> > > >  };
> > > >
> > > >  #define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XM=
IT_TYPE_XDP \
> > > > -                               | VIRTNET_XMIT_TYPE_DMA)
> > > > +                               | VIRTNET_XMIT_TYPE_DMA | VIRTNET_X=
MIT_TYPE_XSK)
> > > > +
> > > > +#define VIRTIO_XSK_FLAG_OFFSET 4
> > > >
> > > >  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> > > >  {
> > > > @@ -768,6 +771,10 @@ static void __free_old_xmit(struct send_queue =
*sq, bool in_napi,
> > > >                          * func again.
> > > >                          */
> > > >                         goto retry;
> > > > +
> > > > +               case VIRTNET_XMIT_TYPE_XSK:
> > > > +                       /* Make gcc happy. DONE in subsequent commi=
t */
> > >
> > > This is probably a hint that the next patch should be squashed here.
> >
> > The code for the xmit patch is more. So I separate the code out.
> >
> > >
> > > > +                       break;
> > > >                 }
> > > >         }
> > > >  }
> > > > @@ -1265,6 +1272,102 @@ static void check_sq_full_and_disable(struc=
t virtnet_info *vi,
> > > >         }
> > > >  }
> > > >
> > > > +static void *virtnet_xsk_to_ptr(u32 len)
> > > > +{
> > > > +       unsigned long p;
> > > > +
> > > > +       p =3D len << VIRTIO_XSK_FLAG_OFFSET;
> > > > +
> > > > +       return virtnet_xmit_ptr_mix((void *)p, VIRTNET_XMIT_TYPE_XS=
K);
> > > > +}
> > > > +
> > > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u=
32 len)
> > > > +{
> > > > +       sg->dma_address =3D addr;
> > > > +       sg->length =3D len;
> > > > +}
> > > > +
> > > > +static int virtnet_xsk_xmit_one(struct send_queue *sq,
> > > > +                               struct xsk_buff_pool *pool,
> > > > +                               struct xdp_desc *desc)
> > > > +{
> > > > +       struct virtnet_info *vi;
> > > > +       dma_addr_t addr;
> > > > +
> > > > +       vi =3D sq->vq->vdev->priv;
> > > > +
> > > > +       addr =3D xsk_buff_raw_get_dma(pool, desc->addr);
> > > > +       xsk_buff_raw_dma_sync_for_device(pool, addr, desc->len);
> > > > +
> > > > +       sg_init_table(sq->sg, 2);
> > > > +
> > > > +       sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);
> > > > +       sg_fill_dma(sq->sg + 1, addr, desc->len);
> > > > +
> > > > +       return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
> > > > +                                   virtnet_xsk_to_ptr(desc->len), =
GFP_ATOMIC);
> > > > +}
> > > > +
> > > > +static int virtnet_xsk_xmit_batch(struct send_queue *sq,
> > > > +                                 struct xsk_buff_pool *pool,
> > > > +                                 unsigned int budget,
> > > > +                                 u64 *kicks)
> > > > +{
> > > > +       struct xdp_desc *descs =3D pool->tx_descs;
> > > > +       bool kick =3D false;
> > > > +       u32 nb_pkts, i;
> > > > +       int err;
> > > > +
> > > > +       budget =3D min_t(u32, budget, sq->vq->num_free);
> > > > +
> > > > +       nb_pkts =3D xsk_tx_peek_release_desc_batch(pool, budget);
> > > > +       if (!nb_pkts)
> > > > +               return 0;
> > > > +
> > > > +       for (i =3D 0; i < nb_pkts; i++) {
> > > > +               err =3D virtnet_xsk_xmit_one(sq, pool, &descs[i]);
> > > > +               if (unlikely(err)) {
> > > > +                       xsk_tx_completed(sq->xsk.pool, nb_pkts - i);
> > > > +                       break;
> > >
> > > Any reason we don't need a kick here?
> >
> > After the loop, I checked the kick.
> >
> > Do you mean kick for the packet that encountered the error?
>
> Nope, I mis-read the code but kick is actually i =3D=3D 0 here.

Will fix.


Thanks.



>
> >
> >
> > >
> > > > +               }
> > > > +
> > > > +               kick =3D true;
> > > > +       }
> > > > +
> > > > +       if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_not=
ify(sq->vq))
> > > > +               (*kicks)++;
> > > > +
> > > > +       return i;
> > > > +}
> > > > +
> > > > +static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buf=
f_pool *pool,
> > > > +                            int budget)
> > > > +{
> > > > +       struct virtnet_info *vi =3D sq->vq->vdev->priv;
> > > > +       struct virtnet_sq_free_stats stats =3D {};
> > > > +       u64 kicks =3D 0;
> > > > +       int sent;
> > > > +
> > > > +       __free_old_xmit(sq, true, &stats);
> > > > +
> > > > +       sent =3D virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
> > > > +
> > > > +       if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> > > > +               check_sq_full_and_disable(vi, vi->dev, sq);
> > > > +
> > > > +       u64_stats_update_begin(&sq->stats.syncp);
> > > > +       u64_stats_add(&sq->stats.packets, stats.packets);
> > > > +       u64_stats_add(&sq->stats.bytes,   stats.bytes);
> > > > +       u64_stats_add(&sq->stats.kicks,   kicks);
> > > > +       u64_stats_add(&sq->stats.xdp_tx,  sent);
> > > > +       u64_stats_update_end(&sq->stats.syncp);
> > > > +
> > > > +       if (xsk_uses_need_wakeup(pool))
> > > > +               xsk_set_tx_need_wakeup(pool);
> > > > +
> > > > +       return sent =3D=3D budget;
> > > > +}
> > > > +
> > > >  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> > > >                                    struct send_queue *sq,
> > > >                                    struct xdp_frame *xdpf)
> > > > @@ -2707,6 +2810,7 @@ static int virtnet_poll_tx(struct napi_struct=
 *napi, int budget)
> > > >         struct virtnet_info *vi =3D sq->vq->vdev->priv;
> > > >         unsigned int index =3D vq2txq(sq->vq);
> > > >         struct netdev_queue *txq;
> > > > +       bool xsk_busy =3D false;
> > > >         int opaque;
> > > >         bool done;
> > > >
> > > > @@ -2719,7 +2823,11 @@ static int virtnet_poll_tx(struct napi_struc=
t *napi, int budget)
> > > >         txq =3D netdev_get_tx_queue(vi->dev, index);
> > > >         __netif_tx_lock(txq, raw_smp_processor_id());
> > > >         virtqueue_disable_cb(sq->vq);
> > > > -       free_old_xmit(sq, true);
> > > > +
> > > > +       if (sq->xsk.pool)
> > > > +               xsk_busy =3D virtnet_xsk_xmit(sq, sq->xsk.pool, bud=
get);
> > >
> > > How about rename this to "xsk_sent"?
> >
> >
> > OK
> >
> > Thanks.
> >
> >
> > >
> > > > +       else
> > > > +               free_old_xmit(sq, true);
> > > >
> > > >         if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > > >                 if (netif_tx_queue_stopped(txq)) {
> > > > @@ -2730,6 +2838,11 @@ static int virtnet_poll_tx(struct napi_struc=
t *napi, int budget)
> > > >                 netif_tx_wake_queue(txq);
> > > >         }
> > > >
> > > > +       if (xsk_busy) {
> > > > +               __netif_tx_unlock(txq);
> > > > +               return budget;
> > > > +       }
> > > > +
> > > >         opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> > > >
> > > >         done =3D napi_complete_done(napi, 0);
> > > > @@ -5715,6 +5828,10 @@ static void virtnet_sq_free_unused_buf(struc=
t virtqueue *vq, void *buf)
> > > >         case VIRTNET_XMIT_TYPE_DMA:
> > > >                 virtnet_sq_unmap(sq, &buf);
> > > >                 goto retry;
> > > > +
> > > > +       case VIRTNET_XMIT_TYPE_XSK:
> > > > +               /* Make gcc happy. DONE in subsequent commit */
> > > > +               break;
> > > >         }
> > > >  }
> > > >
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > > >
> > >
> > > Thanks
> > >
> >
>

