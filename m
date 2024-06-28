Return-Path: <bpf+bounces-33326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3236391B666
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 07:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE736285B6D
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 05:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BB4B5A6;
	Fri, 28 Jun 2024 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lae1uSWn"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC663C08A;
	Fri, 28 Jun 2024 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553357; cv=none; b=CObl7Xg8HXf1O3iAGL6rw97GtP+diFXWQ76S1M9ci+tYnwlzlRARJN/vwIr8LM4CKaPZsnnNySAjcoX9lgu51CHQfRjQwUX7EE8MLIPZBJDAGt6U28IORqi9/mcqjdpIgbxikvQGHhNTObI+t4ZTBgWw/cH8wR95C5omKxqHN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553357; c=relaxed/simple;
	bh=gYXXaIbnJMeu2Y5i7gFbuBfABlLzFqp1ojWyFwutkqQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=jBzjy2kRBZGN2FhOzk8GZHMyAWul6MR4GHuqNzo1iK+ZJTwAbpMmR3B4CnoC4bNb2f2BxxgWApGaACDJQ8voMZwJ0wEgL4otDtDn5MIZIs1U2b9+rFPPYQnhIpFfnF1e2oRHYq+4QFOlx98oCPNk7edqJgOzeptWTTWF/nvyn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lae1uSWn; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719553353; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=/jDrd4tsoE8pGQfoa2aLNAfsKwzQ0HaPA+FLDXmgUqw=;
	b=lae1uSWnmC7+RA5WDvCpQTM994icFbobhyhD7Q9oDnIBYMhedoEjMd9WiGHuc6KHMG3SSABK6gx3zfsIn2t3LxEKOy7R9j/bh/u/e37TyiYNbAyQi0i0gBtqnmkakW92vDthj+QdnqqQ/RxO1erLt4c+kZ5gVSKSjdIMXmPoYmk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W9PB5Pu_1719553351;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9PB5Pu_1719553351)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 13:42:32 +0800
Message-ID: <1719553327.3107169-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 05/10] virtio_net: xsk: bind/unbind xsk for rx
Date: Fri, 28 Jun 2024 13:42:07 +0800
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
 <20240618075643.24867-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEtPwA2EN3xEH_T67cOQAWyZfYESso8LzeFDocJKYoXmTw@mail.gmail.com>
In-Reply-To: <CACGkMEtPwA2EN3xEH_T67cOQAWyZfYESso8LzeFDocJKYoXmTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, 28 Jun 2024 10:19:34 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > This patch implement the logic of bind/unbind xsk pool to rq.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 133 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 133 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index df885cdbe658..d8cce143be26 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -25,6 +25,7 @@
> >  #include <net/net_failover.h>
> >  #include <net/netdev_rx_queue.h>
> >  #include <net/netdev_queues.h>
> > +#include <net/xdp_sock_drv.h>
> >
> >  static int napi_weight =3D NAPI_POLL_WEIGHT;
> >  module_param(napi_weight, int, 0444);
> > @@ -348,6 +349,13 @@ struct receive_queue {
> >
> >         /* Record the last dma info to free after new pages is allocate=
d. */
> >         struct virtnet_rq_dma *last_dma;
> > +
> > +       struct {
> > +               struct xsk_buff_pool *pool;
> > +
> > +               /* xdp rxq used by xsk */
> > +               struct xdp_rxq_info xdp_rxq;
> > +       } xsk;
>
> I don't see a special reason for having a container struct here.


Will fix.

>
>
> >  };
> >
> >  /* This structure can contain rss message with maximum settings for in=
direction table and keysize
> > @@ -4970,6 +4978,129 @@ static int virtnet_restore_guest_offloads(struc=
t virtnet_info *vi)
> >         return virtnet_set_guest_offloads(vi, offloads);
> >  }
> >
> > +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct re=
ceive_queue *rq,
> > +                                   struct xsk_buff_pool *pool)
> > +{
> > +       int err, qindex;
> > +
> > +       qindex =3D rq - vi->rq;
> > +
> > +       if (pool) {
> > +               err =3D xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev, qin=
dex, rq->napi.napi_id);
> > +               if (err < 0)
> > +                       return err;
> > +
> > +               err =3D xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> > +                                                MEM_TYPE_XSK_BUFF_POOL=
, NULL);
> > +               if (err < 0)
> > +                       goto unreg;
> > +
> > +               xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> > +       }
> > +
> > +       virtnet_rx_pause(vi, rq);
> > +
> > +       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> > +       if (err) {
> > +               netdev_err(vi->dev, "reset rx fail: rx queue index: %d =
err: %d\n", qindex, err);
> > +
> > +               pool =3D NULL;
> > +       }
> > +
> > +       rq->xsk.pool =3D pool;
> > +
> > +       virtnet_rx_resume(vi, rq);
> > +
> > +       if (pool)
> > +               return 0;
> > +
> > +unreg:
> > +       xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > +       return err;
> > +}
> > +
> > +static int virtnet_xsk_pool_enable(struct net_device *dev,
> > +                                  struct xsk_buff_pool *pool,
> > +                                  u16 qid)
> > +{
> > +       struct virtnet_info *vi =3D netdev_priv(dev);
> > +       struct receive_queue *rq;
> > +       struct device *dma_dev;
> > +       struct send_queue *sq;
> > +       int err;
> > +
> > +       /* In big_packets mode, xdp cannot work, so there is no need to
> > +        * initialize xsk of rq.
> > +        */
> > +       if (vi->big_packets && !vi->mergeable_rx_bufs)
> > +               return -ENOENT;
> > +
> > +       if (qid >=3D vi->curr_queue_pairs)
> > +               return -EINVAL;
> > +
> > +       sq =3D &vi->sq[qid];
> > +       rq =3D &vi->rq[qid];
> > +
> > +       /* For the xsk, the tx and rx should have the same device. The =
af-xdp
> > +        * may use one buffer to receive from the rx and reuse this buf=
fer to
> > +        * send by the tx. So the dma dev of sq and rq should be the sa=
me one.
> > +        *
> > +        * But vq->dma_dev allows every vq has the respective dma dev. =
So I
> > +        * check the dma dev of vq and sq is the same dev.
>
> Not a native speaker, but it might be better to say "xsk assumes ....
> to be the same device". And it might be better to replace "should"
> with "must".

Will fix.

Thanks.


>
> Others look good.
>
> Thanks
>

