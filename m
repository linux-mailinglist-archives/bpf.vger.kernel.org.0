Return-Path: <bpf+bounces-3544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D7A73F675
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 10:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1167281146
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CFA171C7;
	Tue, 27 Jun 2023 08:03:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAC9171B1
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 08:03:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199341A4
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687853032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iuqQE4sOWcqQTKboHiy1Pb1s/z+iQfKOR327P0YVPV0=;
	b=WPjrMfIyUhntQ9MeYCrbpIJDzj79oIMEPg48KNCAfnjW7bjdBtruzwwrKmWH12WBZ5wFQB
	B6w7Ml7y4JrnjixVNxQirXAcXobG7xtCpXMetCecjQpGn7ep60Ykk/PxSP/ZQLAOFfGAB9
	vWkqtZkzxQq6lOuQ38+bFwU7/TgRmVc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-7EHLI4_OMJOjxqOAgQ47bw-1; Tue, 27 Jun 2023 04:03:48 -0400
X-MC-Unique: 7EHLI4_OMJOjxqOAgQ47bw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b6a64d1fb2so12780201fa.2
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853027; x=1690445027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuqQE4sOWcqQTKboHiy1Pb1s/z+iQfKOR327P0YVPV0=;
        b=i5Eid0ePaRuuP9Ayo0AzfvCoEgXTlSIh4JS/0NuCu0v1s8pRL3ZWrQA7SanqAAHGPJ
         jYVKk/pD5FCYcpQEiT5UUkQtGQ0AtPW34pDjCav53DGSI8ZkDtUr0n4Kc3F1NV3aWCmH
         PThn7GqhXPjuWh+U5+N42j3P9MNTQcl03gCWeIpGn1CXyIDPb54QDJ0fCLW9Uza3GIEr
         u0av5VHEWXwFo4f5KsHanXDzn1brF9lXmzof5SjyRJ1UhZj++B1OlhSGhkeka6GEP4VQ
         Cgo/TQDLPhmjuxTbHPkE8yT5KfdZZnbGXTD37j4NdYepH16tdt//Ywde/jXKg4LkgCD3
         Ua8w==
X-Gm-Message-State: AC+VfDzkLmeo3C2xGzvGa9r3ZCIrtbhT7LWg7COCM4qopxyXbgfR6+wr
	GO0sdaPJ6thDyvu6ElwwQ3oYnx4cjgC29bFj3tPD/jp98zkn8sV9StsqglvcJ1NkVe/H+bqyMsU
	vkQGe6YzN2DFHKdsphAVBstiG+axq
X-Received: by 2002:a2e:8812:0:b0:2b5:8c49:7577 with SMTP id x18-20020a2e8812000000b002b58c497577mr10601780ljh.21.1687853026870;
        Tue, 27 Jun 2023 01:03:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7J7AtY0Hf8kWvFMVYn7QpSqp68NGbo8GO9fuwCVZA1SqdSwQLFUBRCoTdDZBAIx3QqpH6Ja4j2kF0vNmI9Vmc=
X-Received: by 2002:a2e:8812:0:b0:2b5:8c49:7577 with SMTP id
 x18-20020a2e8812000000b002b58c497577mr10601768ljh.21.1687853026617; Tue, 27
 Jun 2023 01:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com> <20230602092206.50108-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230602092206.50108-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 16:03:35 +0800
Message-ID: <CACGkMEsyP7bxOchyaKPb=y+td=1F34NwxxP3atyNBwFAtNOsxw@mail.gmail.com>
Subject: Re: [PATCH vhost v10 10/10] virtio_net: support dma premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 5:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Introduce the module param "experiment_premapped" to enable the function
> that the virtio-net do dma mapping.
>
> If that is true, the vq of virtio-net is under the premapped mode.
> It just handle the sg with dma_address. And the driver must get the dma
> address of the buffer to unmap after get the buffer from virtio core.
>
> That will be useful when AF_XDP is enable, AF_XDP tx and the kernel packe=
t
> xmit will share the tx queue, so the skb xmit must support the premapped
> mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 163 +++++++++++++++++++++++++++++++++------
>  1 file changed, 141 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2396c28c0122..5898212fcb3c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,10 +26,11 @@
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
>
> -static bool csum =3D true, gso =3D true, napi_tx =3D true;
> +static bool csum =3D true, gso =3D true, napi_tx =3D true, experiment_pr=
emapped;
>  module_param(csum, bool, 0444);
>  module_param(gso, bool, 0444);
>  module_param(napi_tx, bool, 0644);
> +module_param(experiment_premapped, bool, 0644);

Having a module parameter is sub-optimal. I think we can demonstrate
real benefit:

In the case of a merge rx buffer, if the mapping is done by the
virtio-core, it needs to be done per buffer (< PAGE_SIZE).

But if it is done by the virtio-net, we have a chance to map the
buffer per page. Which can save a lot of mappings and unmapping. A lot
of other optimizations could be done on top as well.

If we manage to prove this, we don't need any experimental module
parameters at all.

Thanks


>
>  /* FIXME: MTU in config. */
>  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
> @@ -142,6 +143,9 @@ struct send_queue {
>
>         /* Record whether sq is in reset state. */
>         bool reset;
> +
> +       /* The vq is premapped mode. */
> +       bool premapped;
>  };
>
>  /* Internal representation of a receive virtqueue */
> @@ -174,6 +178,9 @@ struct receive_queue {
>         char name[16];
>
>         struct xdp_rxq_info xdp_rxq;
> +
> +       /* The vq is premapped mode. */
> +       bool premapped;
>  };
>
>  /* This structure can contain rss message with maximum settings for indi=
rection table and keysize
> @@ -546,6 +553,105 @@ static struct sk_buff *page_to_skb(struct virtnet_i=
nfo *vi,
>         return skb;
>  }
>
> +static int virtnet_generic_unmap(struct virtqueue *vq, struct virtqueue_=
detach_cursor *cursor)
> +{
> +       enum dma_data_direction dir;
> +       dma_addr_t addr;
> +       u32 len;
> +       int err;
> +
> +       do {
> +               err =3D virtqueue_detach(vq, cursor, &addr, &len, &dir);
> +               if (!err || err =3D=3D -EAGAIN)
> +                       dma_unmap_page_attrs(virtqueue_dma_dev(vq), addr,=
 len, dir, 0);
> +
> +       } while (err =3D=3D -EAGAIN);
> +
> +       return err;
> +}
> +
> +static void *virtnet_detach_unused_buf(struct virtqueue *vq, bool premap=
ped)
> +{
> +       struct virtqueue_detach_cursor cursor;
> +       void *buf;
> +
> +       if (!premapped)
> +               return virtqueue_detach_unused_buf(vq);
> +
> +       buf =3D virtqueue_detach_unused_buf_premapped(vq, &cursor);
> +       if (buf)
> +               virtnet_generic_unmap(vq, &cursor);
> +
> +       return buf;
> +}
> +
> +static void *virtnet_get_buf_ctx(struct virtqueue *vq, bool premapped, u=
32 *len, void **ctx)
> +{
> +       struct virtqueue_detach_cursor cursor;
> +       void *buf;
> +
> +       if (!premapped)
> +               return virtqueue_get_buf_ctx(vq, len, ctx);
> +
> +       buf =3D virtqueue_get_buf_premapped(vq, len, ctx, &cursor);
> +       if (buf)
> +               virtnet_generic_unmap(vq, &cursor);
> +
> +       return buf;
> +}
> +
> +#define virtnet_rq_get_buf(rq, plen, pctx) \
> +({ \
> +       typeof(rq) _rq =3D (rq); \
> +       virtnet_get_buf_ctx(_rq->vq, _rq->premapped, plen, pctx); \
> +})
> +
> +#define virtnet_sq_get_buf(sq, plen, pctx) \
> +({ \
> +       typeof(sq) _sq =3D (sq); \
> +       virtnet_get_buf_ctx(_sq->vq, _sq->premapped, plen, pctx); \
> +})
> +
> +static int virtnet_add_sg(struct virtqueue *vq, bool premapped,
> +                         struct scatterlist *sg, unsigned int num, bool =
out,
> +                         void *data, void *ctx, gfp_t gfp)
> +{
> +       enum dma_data_direction dir;
> +       struct device *dev;
> +       int err, ret;
> +
> +       if (!premapped)
> +               return virtqueue_add_sg(vq, sg, num, out, data, ctx, gfp)=
;
> +
> +       dir =3D out ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
> +       dev =3D virtqueue_dma_dev(vq);
> +
> +       ret =3D dma_map_sg_attrs(dev, sg, num, dir, 0);
> +       if (ret !=3D num)
> +               goto err;
> +
> +       err =3D virtqueue_add_sg(vq, sg, num, out, data, ctx, gfp);
> +       if (err < 0)
> +               goto err;
> +
> +       return 0;
> +
> +err:
> +       dma_unmap_sg_attrs(dev, sg, num, dir, 0);
> +       return -ENOMEM;
> +}
> +
> +static int virtnet_add_outbuf(struct send_queue *sq, unsigned int num, v=
oid *data)
> +{
> +       return virtnet_add_sg(sq->vq, sq->premapped, sq->sg, num, true, d=
ata, NULL, GFP_ATOMIC);
> +}
> +
> +static int virtnet_add_inbuf(struct receive_queue *rq, unsigned int num,=
 void *data,
> +                            void *ctx, gfp_t gfp)
> +{
> +       return virtnet_add_sg(rq->vq, rq->premapped, rq->sg, num, false, =
data, ctx, gfp);
> +}
> +
>  static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
>  {
>         unsigned int len;
> @@ -553,7 +659,7 @@ static void free_old_xmit_skbs(struct send_queue *sq,=
 bool in_napi)
>         unsigned int bytes =3D 0;
>         void *ptr;
>
> -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> +       while ((ptr =3D virtnet_sq_get_buf(sq, &len, NULL)) !=3D NULL) {
>                 if (likely(!is_xdp_frame(ptr))) {
>                         struct sk_buff *skb =3D ptr;
>
> @@ -667,8 +773,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info=
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
> @@ -744,7 +849,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>         }
>
>         /* Free up any pending old buffers before queueing new ones. */
> -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> +       while ((ptr =3D virtnet_sq_get_buf(sq, &len, NULL)) !=3D NULL) {
>                 if (likely(is_xdp_frame(ptr))) {
>                         struct xdp_frame *frame =3D ptr_to_xdp(ptr);
>
> @@ -828,7 +933,7 @@ static struct page *xdp_linearize_page(struct receive=
_queue *rq,
>                 void *buf;
>                 int off;
>
> -               buf =3D virtqueue_get_buf(rq->vq, &buflen);
> +               buf =3D virtnet_rq_get_buf(rq, &buflen, NULL);
>                 if (unlikely(!buf))
>                         goto err_buf;
>
> @@ -1119,7 +1224,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>                 return -EINVAL;
>
>         while (--*num_buf > 0) {
> -               buf =3D virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
> +               buf =3D virtnet_rq_get_buf(rq, &len, &ctx);
>                 if (unlikely(!buf)) {
>                         pr_debug("%s: rx error: %d buffers out of %d miss=
ing\n",
>                                  dev->name, *num_buf,
> @@ -1344,7 +1449,7 @@ static struct sk_buff *receive_mergeable(struct net=
_device *dev,
>         while (--num_buf) {
>                 int num_skb_frags;
>
> -               buf =3D virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
> +               buf =3D virtnet_rq_get_buf(rq, &len, &ctx);
>                 if (unlikely(!buf)) {
>                         pr_debug("%s: rx error: %d buffers out of %d miss=
ing\n",
>                                  dev->name, num_buf,
> @@ -1407,7 +1512,7 @@ static struct sk_buff *receive_mergeable(struct net=
_device *dev,
>  err_skb:
>         put_page(page);
>         while (num_buf-- > 1) {
> -               buf =3D virtqueue_get_buf(rq->vq, &len);
> +               buf =3D virtnet_rq_get_buf(rq, &len, NULL);
>                 if (unlikely(!buf)) {
>                         pr_debug("%s: rx error: %d buffers missing\n",
>                                  dev->name, num_buf);
> @@ -1534,7 +1639,7 @@ static int add_recvbuf_small(struct virtnet_info *v=
i, struct receive_queue *rq,
>         alloc_frag->offset +=3D len;
>         sg_init_one(rq->sg, buf + VIRTNET_RX_PAD + xdp_headroom,
>                     vi->hdr_len + GOOD_PACKET_LEN);
> -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
> +       err =3D virtnet_add_inbuf(rq, 1, buf, ctx, gfp);
>         if (err < 0)
>                 put_page(virt_to_head_page(buf));
>         return err;
> @@ -1581,8 +1686,8 @@ static int add_recvbuf_big(struct virtnet_info *vi,=
 struct receive_queue *rq,
>
>         /* chain first in list head */
>         first->private =3D (unsigned long)list;
> -       err =3D virtqueue_add_inbuf(rq->vq, rq->sg, vi->big_packets_num_s=
kbfrags + 2,
> -                                 first, gfp);
> +       err =3D virtnet_add_inbuf(rq, vi->big_packets_num_skbfrags + 2,
> +                               first, NULL, gfp);
>         if (err < 0)
>                 give_pages(rq, first);
>
> @@ -1645,7 +1750,7 @@ static int add_recvbuf_mergeable(struct virtnet_inf=
o *vi,
>
>         sg_init_one(rq->sg, buf, len);
>         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
> +       err =3D virtnet_add_inbuf(rq, 1, buf, ctx, gfp);
>         if (err < 0)
>                 put_page(virt_to_head_page(buf));
>
> @@ -1768,13 +1873,13 @@ static int virtnet_receive(struct receive_queue *=
rq, int budget,
>                 void *ctx;
>
>                 while (stats.packets < budget &&
> -                      (buf =3D virtqueue_get_buf_ctx(rq->vq, &len, &ctx)=
)) {
> +                      (buf =3D virtnet_rq_get_buf(rq, &len, &ctx))) {
>                         receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &sta=
ts);
>                         stats.packets++;
>                 }
>         } else {
>                 while (stats.packets < budget &&
> -                      (buf =3D virtqueue_get_buf(rq->vq, &len)) !=3D NUL=
L) {
> +                      (buf =3D virtnet_rq_get_buf(rq, &len, NULL)) !=3D =
NULL) {
>                         receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &st=
ats);
>                         stats.packets++;
>                 }
> @@ -1984,7 +2089,7 @@ static int xmit_skb(struct send_queue *sq, struct s=
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
> @@ -3552,15 +3657,17 @@ static void free_unused_bufs(struct virtnet_info =
*vi)
>         int i;
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               struct virtqueue *vq =3D vi->sq[i].vq;
> -               while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NUL=
L)
> -                       virtnet_sq_free_unused_buf(vq, buf);
> +               struct send_queue *sq =3D &vi->sq[i];
> +
> +               while ((buf =3D virtnet_detach_unused_buf(sq->vq, sq->pre=
mapped)) !=3D NULL)
> +                       virtnet_sq_free_unused_buf(sq->vq, buf);
>         }
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               struct virtqueue *vq =3D vi->rq[i].vq;
> -               while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NUL=
L)
> -                       virtnet_rq_free_unused_buf(vq, buf);
> +               struct receive_queue *rq =3D &vi->rq[i];
> +
> +               while ((buf =3D virtnet_detach_unused_buf(rq->vq, rq->pre=
mapped)) !=3D NULL)
> +                       virtnet_rq_free_unused_buf(rq->vq, buf);
>         }
>  }
>
> @@ -3658,6 +3765,18 @@ static int virtnet_find_vqs(struct virtnet_info *v=
i)
>                 vi->rq[i].vq =3D vqs[rxq2vq(i)];
>                 vi->rq[i].min_buf_len =3D mergeable_min_buf_len(vi, vi->r=
q[i].vq);
>                 vi->sq[i].vq =3D vqs[txq2vq(i)];
> +
> +               if (experiment_premapped) {
> +                       if (!virtqueue_set_premapped(vi->rq[i].vq))
> +                               vi->rq[i].premapped =3D true;
> +                       else
> +                               netdev_warn(vi->dev, "RXQ (%d) enable pre=
mapped failure.\n", i);
> +
> +                       if (!virtqueue_set_premapped(vi->sq[i].vq))
> +                               vi->sq[i].premapped =3D true;
> +                       else
> +                               netdev_warn(vi->dev, "TXQ (%d) enable pre=
mapped failure.\n", i);
> +               }
>         }
>
>         /* run here: ret =3D=3D 0. */
> --
> 2.32.0.3.g01195cf9f
>


