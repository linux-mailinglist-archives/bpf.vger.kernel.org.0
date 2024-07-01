Return-Path: <bpf+bounces-33469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3E791DA04
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 10:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4707328209F
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A88D824BD;
	Mon,  1 Jul 2024 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Re9Nxr3K"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D52C6BB;
	Mon,  1 Jul 2024 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822853; cv=none; b=sw+mF4YYwNH3KmGxe4/v+gf1F2QD/fuPlipF12F5n2Tmx+iR7thnDMDkr552ktAtBPFY+nQ6CznPRO6PsT0558eXsochFuvh/alHF6dY1Ddzu56X9TxL4sdIe2JhF5Bl/qCqQUMe+W62iPS+zha79mASdDgC3JvqMqkjdLVVf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822853; c=relaxed/simple;
	bh=SmGnTvi342t5TCdhjNotrThgx8/jX4Rp7taYTTQ1w6o=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=FCKYZNuUtnWv82BbtrUBMpf4hYrJa9s+QuEpeV0dAxlycJ6MXIXlI0gHF3SwdhRCBFSEok3BMJN+KoAhnvLSQ4JubtAvQfW6CBtvbg3twEHVt0yW3jSM5tm2ZgElAo9PqQIyrdzWTIVUuS85HVA36VVBtjn/kO3AYjOi1t5g6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Re9Nxr3K; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719822847; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=MsAbrXcJVgnrPuf5AVodtEAEdIJ5iFRLnptm0WXC8VA=;
	b=Re9Nxr3KH6KgDU605KuQBKGZ0tmiDF7HosGVQ5gBs1XQVM94Igal94H9WHkgw8Ha6vG9VFO+ToKtORImFvLbuAqVnaE6IjJ9gVrU6jpl0mvf1EV7Dk2YkqIcZOhng2PQOETmA4uIKJ54NUa6at9AD5uRnekI7f6B5Gnzok0D4/Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W9cLjqx_1719822846;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9cLjqx_1719822846)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 16:34:06 +0800
Message-ID: <1719822753.9386358-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 08/10] virtio_net: xsk: rx: support recv small mode
Date: Mon, 1 Jul 2024 16:32:33 +0800
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
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
 <20240618075643.24867-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEuPB=We-pnj8QH9Oiv4F=XHTcrRsHVVmOnUn9H7+Nrihw@mail.gmail.com>
 <1719553452.932589-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEv_MOMHz1U48aVPXSj9gVJqA_h-UDt+oNgVgCQww4Jbdg@mail.gmail.com>
 <CACGkMEu-zmNtueGTNPUZsimf5XSXOWO3oCXgetaBS7g1UjHmuQ@mail.gmail.com>
In-Reply-To: <CACGkMEu-zmNtueGTNPUZsimf5XSXOWO3oCXgetaBS7g1UjHmuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 1 Jul 2024 11:25:37 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jul 1, 2024 at 11:20=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Jun 28, 2024 at 1:48=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Fri, 28 Jun 2024 10:19:41 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > In the process:
> > > > > 1. We may need to copy data to create skb for XDP_PASS.
> > > > > 2. We may need to call xsk_buff_free() to release the buffer.
> > > > > 3. The handle for xdp_buff is difference from the buffer.
> > > > >
> > > > > If we pushed this logic into existing receive handle(merge and sm=
all),
> > > > > we would have to maintain code scattered inside merge and small (=
and big).
> > > > > So I think it is a good choice for us to put the xsk code into an
> > > > > independent function.
> > > >
> > > > I think it's better to try to reuse the existing functions.
> > > >
> > > > More below:
> > > >
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 135 +++++++++++++++++++++++++++++++++=
+++++-
> > > > >  1 file changed, 133 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 2ac5668a94ce..06608d696e2e 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -500,6 +500,10 @@ struct virtio_net_common_hdr {
> > > > >  };
> > > > >
> > > > >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, voi=
d *buf);
> > > > > +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct=
 xdp_buff *xdp,
> > > > > +                              struct net_device *dev,
> > > > > +                              unsigned int *xdp_xmit,
> > > > > +                              struct virtnet_rq_stats *stats);
> > > > >
> > > > >  static bool is_xdp_frame(void *ptr)
> > > > >  {
> > > > > @@ -1040,6 +1044,120 @@ static void sg_fill_dma(struct scatterlis=
t *sg, dma_addr_t addr, u32 len)
> > > > >         sg->length =3D len;
> > > > >  }
> > > > >
> > > > > +static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> > > > > +                                  struct receive_queue *rq, void=
 *buf, u32 len)
> > > > > +{
> > > > > +       struct xdp_buff *xdp;
> > > > > +       u32 bufsize;
> > > > > +
> > > > > +       xdp =3D (struct xdp_buff *)buf;
> > > > > +
> > > > > +       bufsize =3D xsk_pool_get_rx_frame_size(rq->xsk.pool) + vi=
->hdr_len;
> > > > > +
> > > > > +       if (unlikely(len > bufsize)) {
> > > > > +               pr_debug("%s: rx error: len %u exceeds truesize %=
u\n",
> > > > > +                        vi->dev->name, len, bufsize);
> > > > > +               DEV_STATS_INC(vi->dev, rx_length_errors);
> > > > > +               xsk_buff_free(xdp);
> > > > > +               return NULL;
> > > > > +       }
> > > > > +
> > > > > +       xsk_buff_set_size(xdp, len);
> > > > > +       xsk_buff_dma_sync_for_cpu(xdp);
> > > > > +
> > > > > +       return xdp;
> > > > > +}
> > > > > +
> > > > > +static struct sk_buff *xdp_construct_skb(struct receive_queue *r=
q,
> > > > > +                                        struct xdp_buff *xdp)
> > > > > +{
> > > >
> > > > So we have a similar caller which is receive_small_build_skb(). Any
> > > > chance to reuse that?
> > >
> > > receive_small_build_skb works with build_skb.
> >
> > RIght.
> >
> > >
> > > Here we need to copy the packet from the xsk buffer to the skb buffer.
> > > So I do not think we can reuse it.
> > >
> >
> > Let's rename this to xsk_construct_skb() ?
> >
> > >
> > > >
> > > > > +       unsigned int metasize =3D xdp->data - xdp->data_meta;
> > > > > +       struct sk_buff *skb;
> > > > > +       unsigned int size;
> > > > > +
> > > > > +       size =3D xdp->data_end - xdp->data_hard_start;
> > > > > +       skb =3D napi_alloc_skb(&rq->napi, size);
> > > > > +       if (unlikely(!skb)) {
> > > > > +               xsk_buff_free(xdp);
> > > > > +               return NULL;
> > > > > +       }
> > > > > +
> > > > > +       skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> > > > > +
> > > > > +       size =3D xdp->data_end - xdp->data_meta;
> > > > > +       memcpy(__skb_put(skb, size), xdp->data_meta, size);
> > > > > +
> > > > > +       if (metasize) {
> > > > > +               __skb_pull(skb, metasize);
> > > > > +               skb_metadata_set(skb, metasize);
> > > > > +       }
> > > > > +
> > > > > +       xsk_buff_free(xdp);
> > > > > +
> > > > > +       return skb;
> > > > > +}
> > > > > +
> > > > > +static struct sk_buff *virtnet_receive_xsk_small(struct net_devi=
ce *dev, struct virtnet_info *vi,
> > > > > +                                                struct receive_q=
ueue *rq, struct xdp_buff *xdp,
> > > > > +                                                unsigned int *xd=
p_xmit,
> > > > > +                                                struct virtnet_r=
q_stats *stats)
> > > > > +{
> > > > > +       struct bpf_prog *prog;
> > > > > +       u32 ret;
> > > > > +
> > > > > +       ret =3D XDP_PASS;
> > > > > +       rcu_read_lock();
> > > > > +       prog =3D rcu_dereference(rq->xdp_prog);
> > > > > +       if (prog)
> > > > > +               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_x=
mit, stats);
> > > > > +       rcu_read_unlock();
> > > > > +
> > > > > +       switch (ret) {
> > > > > +       case XDP_PASS:
> > > > > +               return xdp_construct_skb(rq, xdp);
> > > > > +
> > > > > +       case XDP_TX:
> > > > > +       case XDP_REDIRECT:
> > > > > +               return NULL;
> > > > > +
> > > > > +       default:
> > > > > +               /* drop packet */
> > > > > +               xsk_buff_free(xdp);
> > > > > +               u64_stats_inc(&stats->drops);
> > > > > +               return NULL;
> > > > > +       }
> > > > > +}
> > > > > +
> > > > > +static struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_in=
fo *vi, struct receive_queue *rq,
> > > > > +                                              void *buf, u32 len,
> > > > > +                                              unsigned int *xdp_=
xmit,
> > > > > +                                              struct virtnet_rq_=
stats *stats)
> > > > > +{
> > > > > +       struct net_device *dev =3D vi->dev;
> > > > > +       struct sk_buff *skb =3D NULL;
> > > > > +       struct xdp_buff *xdp;
> > > > > +
> > > > > +       len -=3D vi->hdr_len;
> > > > > +
> > > > > +       u64_stats_add(&stats->bytes, len);
> > > > > +
> > > > > +       xdp =3D buf_to_xdp(vi, rq, buf, len);
> > > > > +       if (!xdp)
> > > > > +               return NULL;
> > > > > +
> > > > > +       if (unlikely(len < ETH_HLEN)) {
> > > > > +               pr_debug("%s: short packet %i\n", dev->name, len);
> > > > > +               DEV_STATS_INC(dev, rx_length_errors);
> > > > > +               xsk_buff_free(xdp);
> > > > > +               return NULL;
> > > > > +       }
> > > > > +
> > > > > +       if (!vi->mergeable_rx_bufs)
> > > > > +               skb =3D virtnet_receive_xsk_small(dev, vi, rq, xd=
p, xdp_xmit, stats);
> > > > > +
> > > > > +       return skb;
> > > > > +}
> > > > > +
> > > > >  static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, stru=
ct receive_queue *rq,
> > > > >                                    struct xsk_buff_pool *pool, gf=
p_t gfp)
> > > > >  {
> > > > > @@ -2363,9 +2481,22 @@ static int virtnet_receive(struct receive_=
queue *rq, int budget,
> > > > >         void *buf;
> > > > >         int i;
> > > > >
> > > > > -       if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > > > > -               void *ctx;
> > > > > +       if (rq->xsk.pool) {
> > > > > +               struct sk_buff *skb;
> > > > > +
> > > > > +               while (packets < budget) {
> > > > > +                       buf =3D virtqueue_get_buf(rq->vq, &len);
> > > > > +                       if (!buf)
> > > > > +                               break;
> > > > >
> > > > > +                       skb =3D virtnet_receive_xsk_buf(vi, rq, b=
uf, len, xdp_xmit, &stats);
> > > > > +                       if (skb)
> > > > > +                               virtnet_receive_done(vi, rq, skb);
> > > > > +
> > > > > +                       packets++;
> > > > > +               }
> > > >
> > > > If reusing turns out to be hard, I'd rather add new paths in receiv=
e_small().
> > >
> > > The exist function is called after virtnet_rq_get_buf(), that will do=
 dma unmap.
> > > But for xsk, the dma unmap is not need. So xsk receive handle should =
use
> > > virtqueue_get_buf directly.
> >
> > Probably but if it's just virtnet_rq_get_buf() we can simply did:
> >
> > static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, voi=
d **ctx)
> > {
> >         void *buf;
> >
> >         buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> >         if (buf && rq->xsk.pool)
> >                 virtnet_rq_unmap(rq, buf, *len);
> >
> >         return buf;
> > }
>
> Or maybe it would be much more clearer if we did:
>
> static int virtnet_receive()
> {
>
> if (rq->xsk.pool)
>         virtnet_receive_xsk()
> else
>         virtnet_receive_xxx()
> ...
> }

I like this.

Thanks.


>
> Thanks
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > > +       } else if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > > > > +               void *ctx;
> > > > >                 while (packets < budget &&
> > > > >                        (buf =3D virtnet_rq_get_buf(rq, &len, &ctx=
))) {
> > > > >                         receive_buf(vi, rq, buf, len, ctx, xdp_xm=
it, &stats);
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > > >
> > > >
> > > > Thanks
> > > >
> > >
>

