Return-Path: <bpf+bounces-20540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4961483FCC4
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 04:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B383B28168E
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 03:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C294E10798;
	Mon, 29 Jan 2024 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lKmxDGdF"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CCC101C4;
	Mon, 29 Jan 2024 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499199; cv=none; b=JwoxD+k4Rw6muc56DFIj1nvZSoA47AH17+cBgaLL4ZhGcOc13dCz/cX3wLTQN89jKEVSPFH921JfJJ/WioLQlHoRR5+bh4Hpkj0gESqISHrQmaXuJU+ujPjaZ9FjrI65nVxVKCp78ssmhjwOxBPKkz8qT9B11Za4nFAat7edjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499199; c=relaxed/simple;
	bh=nbkqjBqjt2qggAwLAFvrNtf7haX62wo3oD3UI5rnOmg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=kNIRmesTy2LK/WPHdGOBbV6qihhv8oQ48H3x4I4EaPUWzgYYKNABJX83fmF7uCJWljCuKe1wR+AgzQUJV3gMFxTo8Ex9Nv2lP7r8iHPtuVOhqoRHSu2bk73mvyehqpeHUB1uV4SRa3jQf7nFU+x80yq0P7ipcfob69oGT/oXzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lKmxDGdF; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706499189; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=bcj5vgyPavYhnFSZUqO3Ni0YFDMiMZXSVOd3sZVIUko=;
	b=lKmxDGdFnwPYqVrNvHy5q4C1CEPJxOHn6Lgbw21deRQtTV+l+xTCODDbLWK1KAJkCh69XLNKnpK17Re+CPcYXdEHE8E2NRoAFhMyshRYtpE2L6S7J5wx+H/zuwNke44jdz8uN7Bd/rm6fIovF0ynbD5bTBRscT5Wr9FgkAkYzd4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.UERMz_1706499188;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.UERMz_1706499188)
          by smtp.aliyun-inc.com;
          Mon, 29 Jan 2024 11:33:09 +0800
Message-ID: <1706499019.7011588-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 4/5] virtio_ring: introduce virtqueue_get_dma_premapped()
Date: Mon, 29 Jan 2024 11:30:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <20240116075924.42798-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEtSnuo6yAsiFZkrv6bMaJtLXuLQtL-qvKn-Y_L_PLHdcw@mail.gmail.com>
 <1706162276.5311615-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEsfVQzb1jDXE=-LABot=3Cd1+kPX6oF+g8z_68s8zMWuQ@mail.gmail.com>
In-Reply-To: <CACGkMEsfVQzb1jDXE=-LABot=3Cd1+kPX6oF+g8z_68s8zMWuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 29 Jan 2024 11:07:50 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Jan 25, 2024 at 1:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Thu, 25 Jan 2024 11:39:03 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > Introduce helper virtqueue_get_dma_premapped(), then the driver
> > > > can know whether dma unmap is needed.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio/main.c       | 22 +++++++++-------------
> > > >  drivers/net/virtio/virtio_net.h |  3 ---
> > > >  drivers/virtio/virtio_ring.c    | 22 ++++++++++++++++++++++
> > > >  include/linux/virtio.h          |  1 +
> > > >  4 files changed, 32 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > > index 186b2cf5d8fc..4fbf612da235 100644
> > > > --- a/drivers/net/virtio/main.c
> > > > +++ b/drivers/net/virtio/main.c
> > > > @@ -483,7 +483,7 @@ static void *virtnet_rq_get_buf(struct virtnet_=
rq *rq, u32 *len, void **ctx)
> > > >         void *buf;
> > > >
> > > >         buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > -       if (buf && rq->do_dma)
> > > > +       if (buf && virtqueue_get_dma_premapped(rq->vq))
> > > >                 virtnet_rq_unmap(rq, buf, *len);
> > > >
> > > >         return buf;
> > > > @@ -496,7 +496,7 @@ static void virtnet_rq_init_one_sg(struct virtn=
et_rq *rq, void *buf, u32 len)
> > > >         u32 offset;
> > > >         void *head;
> > > >
> > > > -       if (!rq->do_dma) {
> > > > +       if (!virtqueue_get_dma_premapped(rq->vq)) {
> > > >                 sg_init_one(rq->sg, buf, len);
> > > >                 return;
> > > >         }
> > > > @@ -526,7 +526,7 @@ static void *virtnet_rq_alloc(struct virtnet_rq=
 *rq, u32 size, gfp_t gfp)
> > > >
> > > >         head =3D page_address(alloc_frag->page);
> > > >
> > > > -       if (rq->do_dma) {
> > > > +       if (virtqueue_get_dma_premapped(rq->vq)) {
> > > >                 dma =3D head;
> > > >
> > > >                 /* new pages */
> > > > @@ -580,12 +580,8 @@ static void virtnet_rq_set_premapped(struct vi=
rtnet_info *vi)
> > > >         if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > >                 return;
> > > >
> > > > -       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > > > -                       continue;
> > > > -
> > > > -               vi->rq[i].do_dma =3D true;
> > > > -       }
> > > > +       for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > > +               virtqueue_set_dma_premapped(vi->rq[i].vq);
> > > >  }
> > > >
> > > >  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> > > > @@ -1643,7 +1639,7 @@ static int add_recvbuf_small(struct virtnet_i=
nfo *vi, struct virtnet_rq *rq,
> > > >
> > > >         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx=
, gfp);
> > > >         if (err < 0) {
> > > > -               if (rq->do_dma)
> > > > +               if (virtqueue_get_dma_premapped(rq->vq))
> > > >                         virtnet_rq_unmap(rq, buf, 0);
> > > >                 put_page(virt_to_head_page(buf));
> > > >         }
> > > > @@ -1758,7 +1754,7 @@ static int add_recvbuf_mergeable(struct virtn=
et_info *vi,
> > > >         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> > > >         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx=
, gfp);
> > > >         if (err < 0) {
> > > > -               if (rq->do_dma)
> > > > +               if (virtqueue_get_dma_premapped(rq->vq))
> > > >                         virtnet_rq_unmap(rq, buf, 0);
> > > >                 put_page(virt_to_head_page(buf));
> > > >         }
> > > > @@ -4007,7 +4003,7 @@ static void free_receive_page_frags(struct vi=
rtnet_info *vi)
> > > >         int i;
> > > >         for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > >                 if (vi->rq[i].alloc_frag.page) {
> > > > -                       if (vi->rq[i].do_dma && vi->rq[i].last_dma)
> > > > +                       if (virtqueue_get_dma_premapped(vi->rq[i].v=
q) && vi->rq[i].last_dma)
> > > >                                 virtnet_rq_unmap(&vi->rq[i], vi->rq=
[i].last_dma, 0);
> > > >                         put_page(vi->rq[i].alloc_frag.page);
> > > >                 }
> > > > @@ -4035,7 +4031,7 @@ static void virtnet_rq_free_unused_bufs(struc=
t virtqueue *vq)
> > > >         rq =3D &vi->rq[i];
> > > >
> > > >         while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL)=
 {
> > > > -               if (rq->do_dma)
> > > > +               if (virtqueue_get_dma_premapped(rq->vq))
> > > >                         virtnet_rq_unmap(rq, buf, 0);
> > > >
> > > >                 virtnet_rq_free_buf(vi, rq, buf);
> > > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/v=
irtio_net.h
> > > > index b28a4d0a3150..066a2b9d2b3c 100644
> > > > --- a/drivers/net/virtio/virtio_net.h
> > > > +++ b/drivers/net/virtio/virtio_net.h
> > > > @@ -115,9 +115,6 @@ struct virtnet_rq {
> > > >
> > > >         /* Record the last dma info to free after new pages is allo=
cated. */
> > > >         struct virtnet_rq_dma *last_dma;
> > > > -
> > > > -       /* Do dma by self */
> > > > -       bool do_dma;
> > > >  };
> > > >
> > > >  struct virtnet_info {
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 2c5089d3b510..9092bcdebb53 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -2905,6 +2905,28 @@ int virtqueue_set_dma_premapped(struct virtq=
ueue *_vq)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
> > > >
> > > > +/**
> > > > + * virtqueue_get_dma_premapped - get the vring premapped mode
> > > > + * @_vq: the struct virtqueue we're talking about.
> > > > + *
> > > > + * Get the premapped mode of the vq.
> > > > + *
> > > > + * Returns bool for the vq premapped mode.
> > > > + */
> > > > +bool virtqueue_get_dma_premapped(struct virtqueue *_vq)
> > > > +{
> > > > +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > +       bool premapped;
> > > > +
> > > > +       START_USE(vq);
> > > > +       premapped =3D vq->premapped;
> > > > +       END_USE(vq);
> > >
> > > Why do we need to protect premapped like this? Is the user allowed to
> > > change it on the fly?
> >
> >
> > Just protect before accessing vq.
>
> I meant how did that differ from other booleans? E.g use_dma_api, do_unma=
p etc.

Sorry, maybe I misunderstanded you.

Do you mean, should we put "premapped" to the struct virtqueue?
Then the user can read/write by the struct virtqueue directly?

If that, the reason is that when set premapped, we must check
use_dma_api.


int virtqueue_set_dma_premapped(struct virtqueue *_vq)
{
	struct vring_virtqueue *vq =3D to_vvq(_vq);
	u32 num;

	START_USE(vq);

	num =3D vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;

	if (num !=3D vq->vq.num_free) {
		END_USE(vq);
		return -EINVAL;
	}

	if (!vq->use_dma_api) {
		END_USE(vq);
		return -EINVAL;
	}

	vq->buffer_is_premapped =3D true;

	END_USE(vq);

	return 0;
}

Thanks.

>
> Thanks
>
> >
> > Thanks.
> > >
> > > Thanks
> > >
> >
>

