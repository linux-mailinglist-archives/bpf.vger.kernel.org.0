Return-Path: <bpf+bounces-33331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D4C91B686
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 07:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA6F28376F
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 05:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A5247A58;
	Fri, 28 Jun 2024 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fPojHIyj"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08E249F5;
	Fri, 28 Jun 2024 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553738; cv=none; b=TqLvAsWRoDCL9CXHXjFfOk+k8/G4+Bo/N4I5d7JEgKnZvl+HznwyLmCtEOSS7EC9Vc/ovYK3BqPfrrtl8R21Jl+/c9LZHmH2qgz0JC1NfWaSqqhCO/27c1mHunO2Rmazy7Yv3owGcqhBSRcwhUunR5PxzkTxbtcl76cw6Au1afk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553738; c=relaxed/simple;
	bh=PtCasXHAOvOMRVdKF/jW/oHN2QvRGkd1J0RH+6x7KJI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=u1NvicS0WyRlVaGG/CAPzWhqMAKMYI8juCmPenVeV9jWUd+M/ASm39sNuQK4bqWQCxp7weHBxIy5Ra0U9cnId+aLmAVCj0IV2A+Optj3YC7tLSLan5aMBtHFLDQJVhdQF/SWLHnJCTb3UWX2JCUYQ4OBJp0grMmfV0ZFBvqsJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fPojHIyj; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719553728; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=VAHDm7tteOsh7ipE/Q1oWmZbyzYSsMR/7oUjqzklIwQ=;
	b=fPojHIyj3cow5iEGOb21prP3PK79lXl+T9UwDRRrRa5L9kjAi7Sg5PF3SNhxLYHzJbAAZGjQyZvxLr+rfmCRMqieyh0o0RYgit8VL65OlHUVeoKXLhMJNy2HMzDNi6rFdreOWiR6b4DKdUuga6W+XzmVpm7SC06nyKbud29Y3YY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W9PEpy1_1719553727;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9PEpy1_1719553727)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 13:48:47 +0800
Message-ID: <1719553452.932589-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 08/10] virtio_net: xsk: rx: support recv small mode
Date: Fri, 28 Jun 2024 13:44:12 +0800
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
In-Reply-To: <CACGkMEuPB=We-pnj8QH9Oiv4F=XHTcrRsHVVmOnUn9H7+Nrihw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, 28 Jun 2024 10:19:41 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
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
>
> I think it's better to try to reuse the existing functions.
>
> More below:
>
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 135 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 133 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 2ac5668a94ce..06608d696e2e 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -500,6 +500,10 @@ struct virtio_net_common_hdr {
> >  };
> >
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf=
);
> > +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_b=
uff *xdp,
> > +                              struct net_device *dev,
> > +                              unsigned int *xdp_xmit,
> > +                              struct virtnet_rq_stats *stats);
> >
> >  static bool is_xdp_frame(void *ptr)
> >  {
> > @@ -1040,6 +1044,120 @@ static void sg_fill_dma(struct scatterlist *sg,=
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
> > +       bufsize =3D xsk_pool_get_rx_frame_size(rq->xsk.pool) + vi->hdr_=
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
> > +static struct sk_buff *xdp_construct_skb(struct receive_queue *rq,
> > +                                        struct xdp_buff *xdp)
> > +{
>
> So we have a similar caller which is receive_small_build_skb(). Any
> chance to reuse that?

receive_small_build_skb works with build_skb.

Here we need to copy the packet from the xsk buffer to the skb buffer.
So I do not think we can reuse it.


>
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
> > +               return xdp_construct_skb(rq, xdp);
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
> > +static struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi=
, struct receive_queue *rq,
> > +                                              void *buf, u32 len,
> > +                                              unsigned int *xdp_xmit,
> > +                                              struct virtnet_rq_stats =
*stats)
> > +{
> > +       struct net_device *dev =3D vi->dev;
> > +       struct sk_buff *skb =3D NULL;
> > +       struct xdp_buff *xdp;
> > +
> > +       len -=3D vi->hdr_len;
> > +
> > +       u64_stats_add(&stats->bytes, len);
> > +
> > +       xdp =3D buf_to_xdp(vi, rq, buf, len);
> > +       if (!xdp)
> > +               return NULL;
> > +
> > +       if (unlikely(len < ETH_HLEN)) {
> > +               pr_debug("%s: short packet %i\n", dev->name, len);
> > +               DEV_STATS_INC(dev, rx_length_errors);
> > +               xsk_buff_free(xdp);
> > +               return NULL;
> > +       }
> > +
> > +       if (!vi->mergeable_rx_bufs)
> > +               skb =3D virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp=
_xmit, stats);
> > +
> > +       return skb;
> > +}
> > +
> >  static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct rec=
eive_queue *rq,
> >                                    struct xsk_buff_pool *pool, gfp_t gf=
p)
> >  {
> > @@ -2363,9 +2481,22 @@ static int virtnet_receive(struct receive_queue =
*rq, int budget,
> >         void *buf;
> >         int i;
> >
> > -       if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > -               void *ctx;
> > +       if (rq->xsk.pool) {
> > +               struct sk_buff *skb;
> > +
> > +               while (packets < budget) {
> > +                       buf =3D virtqueue_get_buf(rq->vq, &len);
> > +                       if (!buf)
> > +                               break;
> >
> > +                       skb =3D virtnet_receive_xsk_buf(vi, rq, buf, le=
n, xdp_xmit, &stats);
> > +                       if (skb)
> > +                               virtnet_receive_done(vi, rq, skb);
> > +
> > +                       packets++;
> > +               }
>
> If reusing turns out to be hard, I'd rather add new paths in receive_smal=
l().

The exist function is called after virtnet_rq_get_buf(), that will do dma u=
nmap.
But for xsk, the dma unmap is not need. So xsk receive handle should use
virtqueue_get_buf directly.

Thanks.

>
> > +       } else if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > +               void *ctx;
> >                 while (packets < budget &&
> >                        (buf =3D virtnet_rq_get_buf(rq, &len, &ctx))) {
> >                         receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &s=
tats);
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>

