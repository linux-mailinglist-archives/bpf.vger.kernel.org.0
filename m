Return-Path: <bpf+bounces-32364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC0F90C158
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 03:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9D71F22EB6
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 01:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A100313AD8;
	Tue, 18 Jun 2024 01:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ff0D1U69"
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460010A16;
	Tue, 18 Jun 2024 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674711; cv=none; b=OGE/6KZrmuzYiW6wIqBKk1h5WcaizRIHA1HQV2ELR/DIerQBjHqLyaYzUiNAyOPaQbpqv09x1bQCl1DwSlfZsrOoknRlOtm8qfCVBSXGWFhF2aJVug1Q9jyjEeXZyCe4vFuwXuTvXdNJoJlVlsVaJO6SpPLAxJbLUVWt8is/KgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674711; c=relaxed/simple;
	bh=g6wTGydtPKi0ukL4yXPEcCGxvLg/T9nDRsqgDigwkh0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=oaOlckHuZ9QniJuFVqcgQZHjKNu8R74gjdYmhqZkfnF3SBFxY9Dwz2I9qs1a58GZBdN+5mqT+5fxCWyddj8ICZWPpjoCOYSSMBR/SkmxmFTcBkgySwKjsgB1IeLIPBAq7JEETS6KJ6Sqw15J0yJOvO0m6xyOxXE1EKh+mDCUY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ff0D1U69; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718674706; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=hIMNYdjc0gyhFl4vv40hMzs7l7ugdiC0y+OzHJdqYB0=;
	b=ff0D1U696W/Ua3LQtxkY9bOgqg5vWElK81FPRfbrq1FiH6cYh47pCcGWMTrsdopJ5SZjzo+7ttvR3fRDSU0kw8XfU/EBJM1fboAXI08pGigC0LTQgOHxa7Mm0Te9EdAwjJrfU6Hu37o/8o+8d+1yJ0EcsHjWt+d6Hu+aM/lPqKk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8i3hD6_1718674704;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8i3hD6_1718674704)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 09:38:25 +0800
Message-ID: <1718674602.351249-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 09/15] virtio_net: xsk: bind/unbind xsk
Date: Tue, 18 Jun 2024 09:36:42 +0800
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
 <20240614063933.108811-10-xuanzhuo@linux.alibaba.com>
 <CACGkMEuLJSuM2Y1JRnvDoQG-dBsLGaOctv7tDdq8NjFOD2miSw@mail.gmail.com>
 <1718610191.0911355-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvySjELA_4vU6yzR+sBAX75u9Rv-XmUUbNA8SaaPf-XXg@mail.gmail.com>
In-Reply-To: <CACGkMEvySjELA_4vU6yzR+sBAX75u9Rv-XmUUbNA8SaaPf-XXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 18 Jun 2024 09:04:03 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jun 17, 2024 at 3:49=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Mon, 17 Jun 2024 14:19:10 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > This patch implement the logic of bind/unbind xsk pool to sq and rq.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 201 +++++++++++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 200 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 88ab9ea1646f..35fd8bca7fcf 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -26,6 +26,7 @@
> > > >  #include <net/netdev_rx_queue.h>
> > > >  #include <net/netdev_queues.h>
> > > >  #include <uapi/linux/virtio_ring.h>
> > > > +#include <net/xdp_sock_drv.h>
> > > >
> > > >  static int napi_weight =3D NAPI_POLL_WEIGHT;
> > > >  module_param(napi_weight, int, 0444);
> > > > @@ -57,6 +58,8 @@ DECLARE_EWMA(pkt_len, 0, 64)
> > > >
> > > >  #define VIRTNET_DRIVER_VERSION "1.0.0"
> > > >
> > > > +static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
> > >
> > > Does this mean AF_XDP only supports virtio_net_hdr_mrg_rxbuf but not =
others?
> >
> > Sorry, this is the old code.
> >
> > Should be virtio_net_common_hdr.
> >
> > Here we should use the max size of the virtio-net header.
>
> Better but still suboptimal, for example it could be extended as we're
> adding more features?

When we use this, we will work with hdr_len.

	sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);

So, I think it is ok.

>
> >
> > >
> > > > +
> > > >  static const unsigned long guest_offloads[] =3D {
> > > >         VIRTIO_NET_F_GUEST_TSO4,
> > > >         VIRTIO_NET_F_GUEST_TSO6,
> > > > @@ -321,6 +324,12 @@ struct send_queue {
> > > >         bool premapped;
> > > >
> > > >         struct virtnet_sq_dma_info dmainfo;
> > > > +
> > > > +       struct {
> > > > +               struct xsk_buff_pool *pool;
> > > > +
> > > > +               dma_addr_t hdr_dma_address;
> > > > +       } xsk;
> > > >  };
> > > >
> > > >  /* Internal representation of a receive virtqueue */
> > > > @@ -372,6 +381,13 @@ struct receive_queue {
> > > >
> > > >         /* Record the last dma info to free after new pages is allo=
cated. */
> > > >         struct virtnet_rq_dma *last_dma;
> > > > +
> > > > +       struct {
> > > > +               struct xsk_buff_pool *pool;
> > > > +
> > > > +               /* xdp rxq used by xsk */
> > > > +               struct xdp_rxq_info xdp_rxq;
> > > > +       } xsk;
> > > >  };
> > > >
> > > >  /* This structure can contain rss message with maximum settings fo=
r indirection table and keysize
> > > > @@ -695,7 +711,7 @@ static void virtnet_sq_free_dma_meta(struct sen=
d_queue *sq)
> > > >  /* This function must be called immediately after creating the vq,=
 or after vq
> > > >   * reset, and before adding any buffers to it.
> > > >   */
> > > > -static __maybe_unused int virtnet_sq_set_premapped(struct send_que=
ue *sq, bool premapped)
> > > > +static int virtnet_sq_set_premapped(struct send_queue *sq, bool pr=
emapped)
> > > >  {
> > > >         if (premapped) {
> > > >                 int r;
> > > > @@ -5177,6 +5193,187 @@ static int virtnet_restore_guest_offloads(s=
truct virtnet_info *vi)
> > > >         return virtnet_set_guest_offloads(vi, offloads);
> > > >  }
> > > >
> > > > +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struc=
t receive_queue *rq,
> > > > +                                   struct xsk_buff_pool *pool)
> > > > +{
> > > > +       int err, qindex;
> > > > +
> > > > +       qindex =3D rq - vi->rq;
> > > > +
> > > > +       if (pool) {
> > > > +               err =3D xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev,=
 qindex, rq->napi.napi_id);
> > > > +               if (err < 0)
> > > > +                       return err;
> > > > +
> > > > +               err =3D xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> > > > +                                                MEM_TYPE_XSK_BUFF_=
POOL, NULL);
> > > > +               if (err < 0) {
> > > > +                       xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > > > +                       return err;
> > > > +               }
> > > > +
> > > > +               xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> > > > +       }
> > > > +
> > > > +       virtnet_rx_pause(vi, rq);
> > > > +
> > > > +       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> > > > +       if (err) {
> > > > +               netdev_err(vi->dev, "reset rx fail: rx queue index:=
 %d err: %d\n", qindex, err);
> > > > +
> > > > +               pool =3D NULL;
> > > > +       }
> > > > +
> > > > +       if (!pool)
> > > > +               xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > >
> > > Let's use err label instead of duplicating xdp_rxq_info_unreg() here?
> > >
> > > > +
> > > > +       rq->xsk.pool =3D pool;
> > > > +
> > > > +       virtnet_rx_resume(vi, rq);
> > > > +
> > > > +       return err;
> > > > +}
> > > > +
> > > > +static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> > > > +                                   struct send_queue *sq,
> > > > +                                   struct xsk_buff_pool *pool)
> > > > +{
> > > > +       int err, qindex;
> > > > +
> > > > +       qindex =3D sq - vi->sq;
> > > > +
> > > > +       virtnet_tx_pause(vi, sq);
> > > > +
> > > > +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> > > > +       if (err)
> > > > +               netdev_err(vi->dev, "reset tx fail: tx queue index:=
 %d err: %d\n", qindex, err);
> > > > +       else
> > > > +               err =3D virtnet_sq_set_premapped(sq, !!pool);
> > > > +
> > > > +       if (err)
> > > > +               pool =3D NULL;
> > > > +
> > > > +       sq->xsk.pool =3D pool;
> > > > +
> > > > +       virtnet_tx_resume(vi, sq);
> > > > +
> > > > +       return err;
> > > > +}
> > > > +
> > > > +static int virtnet_xsk_pool_enable(struct net_device *dev,
> > > > +                                  struct xsk_buff_pool *pool,
> > > > +                                  u16 qid)
> > > > +{
> > > > +       struct virtnet_info *vi =3D netdev_priv(dev);
> > > > +       struct receive_queue *rq;
> > > > +       struct send_queue *sq;
> > > > +       struct device *dma_dev;
> > > > +       dma_addr_t hdr_dma;
> > > > +       int err;
> > > > +
> > > > +       /* In big_packets mode, xdp cannot work, so there is no nee=
d to
> > > > +        * initialize xsk of rq.
> > > > +        *
> > > > +        * Support for small mode firstly.
> > >
> > > This comment is kind of confusing, I think mergeable mode is also
> > > supported. If it's true, we can simply remove it.
> >
> > For the commit num limit of the net-next, I have to remove some commits.
> >
> > So the mergeable mode is not supported by this patch set.
> >
> > I plan to support the merge mode after this patch set.
>
> Then, I'd suggest to split the patches into two series:
>
> 1) AF_XDP TX zerocopy
> 2) AF_XDP RX zerocopy
>
> And implement both small and mergeable in series 2).


I am ok.


>
> >
> >
> > >
> > > > +        */
> > > > +       if (vi->big_packets)
> > > > +               return -ENOENT;
> > > > +
> > > > +       if (qid >=3D vi->curr_queue_pairs)
> > > > +               return -EINVAL;
> > > > +
> > > > +       sq =3D &vi->sq[qid];
> > > > +       rq =3D &vi->rq[qid];
> > > > +
> > > > +       /* xsk tx zerocopy depend on the tx napi.
> > > > +        *
> > > > +        * All xsk packets are actually consumed and sent out from =
the xsk tx
> > > > +        * queue under the tx napi mechanism.
> > > > +        */
> > > > +       if (!sq->napi.weight)
> > > > +               return -EPERM;
> > > > +
> > > > +       /* For the xsk, the tx and rx should have the same device. =
But
> > > > +        * vq->dma_dev allows every vq has the respective dma dev. =
So I check
> > > > +        * the dma dev of vq and sq is the same dev.
> > > > +        */
> > > > +       if (virtqueue_dma_dev(rq->vq) !=3D virtqueue_dma_dev(sq->vq=
))
> > > > +               return -EPERM;
> > >
> > > I don't understand how a different DMA device matters here. It looks
> > > like the code is using per virtqueue DMA below.
> >
> > The af-xdp may use one buffer to receive from the rx and reuse this buf=
fer to
> > send by the tx.  So the dma dev of sq and rq should be the same one.
>
> Right, let's tweak the comment to say something like this.

Will fix.

Thanks.


>
> Thanks
>

