Return-Path: <bpf+bounces-44020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B79C09BC6D7
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 08:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D868D1C220A0
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54811FDFA0;
	Tue,  5 Nov 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kemL3JWl"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9241CDA25;
	Tue,  5 Nov 2024 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791391; cv=none; b=Z57JKWZrV2vLsmODyhopz4dUcEZ8iEtM2Cl2ayyTleqk3nW3By2O8V0q9bLWkLdP6+fQYVlEt/CRQMN+SO3RItxAJzDMRR+eTGb2xMcbMCxAjnNajRtEOaUQ5J1Sjo0xmRkUVfjyIJ5C6zCqdxv2DV01vu/aHNWSsOt7xOpOrMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791391; c=relaxed/simple;
	bh=AeJGD4KJEVdazyN4Pdjiu0NQ9DAMEFeg7bcV3R3MlDg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=V9MZTg90uILNyflITbIBqHTUjCkd7Q+R2GopK/N2mWHueZiV8ZY32XLfz985AbFuQS8Yt8YU9Wg8rYrLDx5DTo3keRzsnSepKosAg4Hd3Pzi6aI5rA1EuNrWhc6RPOp2CwRDT5OWd2l1nu1AX4EEzZPwnZxGoEqzOiKFjiuI3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kemL3JWl; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730791386; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=D69SUw05yAm2n9d1GD/p6LGTpeWo5LtoZWIPGmJDsiM=;
	b=kemL3JWlRFikpzH5X4iVEmW6zVFBoV7/mEdCYr1HVYTLoN1IJwak0PxiuJtMu39ZG/6gKEbqTdEhIKYGVuSqXT74FHMtIfdW2LyZ0tJdsPG/Bn/N6oVFiTdpHzT86TBPs2Wt1qLpw8kt5yU6ZkUaIAP7o5tRVWCRHgPhzeBn6N4=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIm0l4h_1730791384 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 15:23:05 +0800
Message-ID: <1730790584.4657414-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 06/13] virtio-net: rq submits premapped per-buffer
Date: Tue, 5 Nov 2024 15:09:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
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
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
 <20241030082453.97310-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEviCSEo4thkFo8gYnv+FCm-v65umJ65fdOwtxbAF_F2Ag@mail.gmail.com>
In-Reply-To: <CACGkMEviCSEo4thkFo8gYnv+FCm-v65umJ65fdOwtxbAF_F2Ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 5 Nov 2024 11:23:50 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > virtio-net rq submits premapped per-buffer by setting sg page to NULL;
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 24 +++++++++++++-----------
> >  1 file changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 792e9eadbfc3..09757fa408bd 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -542,6 +542,12 @@ static struct sk_buff *ptr_to_skb(void *ptr)
> >         return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_F=
LAG);
> >  }
> >
> > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 l=
en)
> > +{
> > +       sg->dma_address =3D addr;
> > +       sg->length =3D len;
>
> This may work but I think it's better to reuse existing dma sg helpers li=
ke:
>
> sg_dma_address(sg) =3D addr;
> sg_dma_length(sg) =3D len;
>
> And we probably need to fix the virtio core which only uses
> sg_dma_address() but not sg_dma_length().
>
> This helps us to avoid future issues when CONFIG_NEED_SG_DMA_LENGTH is se=
t.


I don't think so.

For no-premapped mode, we pass the sg as no-dma sg to virtio core,
so the virtio core uses the sg->length directly.
If virtio core do dma map for sg, we do not use the dma_mag_sg_attrs(),
so we must use sg->length directly.

In this case, for the driver, we can not use sg_dma_length(),
if CONFIG_NEED_SG_DMA_LENGTH is set, sg_dma_length() will set sg->dma_lengt=
h,
but virtio core use sg->length.

For sg->dma_address, it is ok for me to use sg_dma_address or not.
But for consistency to sg->length, I use the sg->dma_address directly.

I noticed this is special, so I put them into an independent function.

Thanks.

>
> Others look good.
>
> Thanks
>
> > +}
> > +
> >  static void __free_old_xmit(struct send_queue *sq, struct netdev_queue=
 *txq,
> >                             bool in_napi, struct virtnet_sq_free_stats =
*stats)
> >  {
> > @@ -915,8 +921,7 @@ static void virtnet_rq_init_one_sg(struct receive_q=
ueue *rq, void *buf, u32 len)
> >         addr =3D dma->addr - sizeof(*dma) + offset;
> >
> >         sg_init_table(rq->sg, 1);
> > -       rq->sg[0].dma_address =3D addr;
> > -       rq->sg[0].length =3D len;
> > +       sg_fill_dma(rq->sg, addr, len);
> >  }
> >
> >  static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_=
t gfp)
> > @@ -1068,12 +1073,6 @@ static void check_sq_full_and_disable(struct vir=
tnet_info *vi,
> >         }
> >  }
> >
> > -static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 l=
en)
> > -{
> > -       sg->dma_address =3D addr;
> > -       sg->length =3D len;
> > -}
> > -
> >  static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> >                                    struct receive_queue *rq, void *buf,=
 u32 len)
> >  {
> > @@ -1354,7 +1353,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet=
_info *vi, struct receive_queue
> >                 sg_init_table(rq->sg, 1);
> >                 sg_fill_dma(rq->sg, addr, len);
> >
> > -               err =3D virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buff=
s[i], gfp);
> > +               err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1=
, xsk_buffs[i],
> > +                                                   NULL, true, gfp);
> >                 if (err)
> >                         goto err;
> >         }
> > @@ -2431,7 +2431,8 @@ static int add_recvbuf_small(struct virtnet_info =
*vi, struct receive_queue *rq,
> >
> >         virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
> >
> > -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gf=
p);
> > +       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, c=
tx,
> > +                                           rq->do_dma, gfp);
> >         if (err < 0) {
> >                 if (rq->do_dma)
> >                         virtnet_rq_unmap(rq, buf, 0);
> > @@ -2546,7 +2547,8 @@ static int add_recvbuf_mergeable(struct virtnet_i=
nfo *vi,
> >         virtnet_rq_init_one_sg(rq, buf, len);
> >
> >         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> > -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gf=
p);
> > +       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, c=
tx,
> > +                                           rq->do_dma, gfp);
> >         if (err < 0) {
> >                 if (rq->do_dma)
> >                         virtnet_rq_unmap(rq, buf, 0);
> > --
> > 2.32.0.3.g01195cf9f
> >
>

