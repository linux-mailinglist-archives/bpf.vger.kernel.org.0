Return-Path: <bpf+bounces-33332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F9791B692
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 07:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B3E283921
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 05:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09AC47A58;
	Fri, 28 Jun 2024 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Huuz1dj+"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A496A224CC;
	Fri, 28 Jun 2024 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554217; cv=none; b=WZsO7ie/ZUYzn37lYB+VPAIm651i7JmVThzhQgkeSJfjtKsV8yVcJJ8KvCIf4qAVlXQszAP7+taW5DoN7/ojFbgRaWzny7rmqJU723fUrVNe8q47szUISDaljwbaKkfaalGSHLNu1lfQexxrRPj6JEFvaduVq7mnd15MUfWXnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554217; c=relaxed/simple;
	bh=fkytftQRg0MPng/xdsZTO+uBpv+DqMDkoS1rQFKQ4nU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=h5vIOzhD61YuAk1ERHYsVzo+FcseE/a7h50jQcKaaU12DGNx9c3t9z1xSvJU9MnzcVODfrpIZdNpAw/glgMtwbfj9tpt/cn1w1bY8ZUtd2bdGYxn/CTUfRUjLHD7oXqIfs+gYMTdtY2JLPvklVgTbkZY4bpsbGNlff4k0tKVBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Huuz1dj+; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719554212; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=AsUqcmaS2dSprY/+StPit0DpgtIPpt2EVmTvYBB5Qg8=;
	b=Huuz1dj+yPKBbQZyXrgY4AvMDVSJ3VQ1n4rWwlEM/debU45jwLPvNMTxYE8ltI7lXiyRlr5e1kQLZ37nMtxm2vVx5wf831wUcvNVyKmWT/FUoBv+cvY6n19p4jE+twgHK1Xb4o5fj0OB885voz+1rxqwy2/jInWEz0pEKy4NMGE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W9PBCvW_1719554211;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9PBCvW_1719554211)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 13:56:51 +0800
Message-ID: <1719553837.6841416-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 09/10] virtio_net: xsk: rx: support recv merge mode
Date: Fri, 28 Jun 2024 13:50:37 +0800
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
 <20240618075643.24867-10-xuanzhuo@linux.alibaba.com>
 <CACGkMEsqBeV9mSVV0yO_sZ=hB==PFoHvtPyma1pctc_+HMEFrA@mail.gmail.com>
In-Reply-To: <CACGkMEsqBeV9mSVV0yO_sZ=hB==PFoHvtPyma1pctc_+HMEFrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, 28 Jun 2024 10:19:44 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Support AF-XDP for merge mode.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 139 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 139 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 06608d696e2e..cfa106aa8039 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -504,6 +504,10 @@ static int virtnet_xdp_handler(struct bpf_prog *xd=
p_prog, struct xdp_buff *xdp,
> >                                struct net_device *dev,
> >                                unsigned int *xdp_xmit,
> >                                struct virtnet_rq_stats *stats);
> > +static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_sk=
b,
> > +                                              struct sk_buff *curr_skb,
> > +                                              struct page *page, void =
*buf,
> > +                                              int len, int truesize);
> >
> >  static bool is_xdp_frame(void *ptr)
> >  {
> > @@ -1128,6 +1132,139 @@ static struct sk_buff *virtnet_receive_xsk_smal=
l(struct net_device *dev, struct
> >         }
> >  }
> >
> > +static void xsk_drop_follow_bufs(struct net_device *dev,
> > +                                struct receive_queue *rq,
> > +                                u32 num_buf,
> > +                                struct virtnet_rq_stats *stats)
> > +{
> > +       struct xdp_buff *xdp;
> > +       u32 len;
> > +
> > +       while (num_buf-- > 1) {
> > +               xdp =3D virtqueue_get_buf(rq->vq, &len);
> > +               if (unlikely(!xdp)) {
> > +                       pr_debug("%s: rx error: %d buffers missing\n",
> > +                                dev->name, num_buf);
> > +                       DEV_STATS_INC(dev, rx_length_errors);
> > +                       break;
> > +               }
> > +               u64_stats_add(&stats->bytes, len);
> > +               xsk_buff_free(xdp);
> > +       }
> > +}
> > +
> > +static int xsk_append_merge_buffer(struct virtnet_info *vi,
> > +                                  struct receive_queue *rq,
> > +                                  struct sk_buff *head_skb,
> > +                                  u32 num_buf,
> > +                                  struct virtio_net_hdr_mrg_rxbuf *hdr,
> > +                                  struct virtnet_rq_stats *stats)
> > +{
> > +       struct sk_buff *curr_skb;
> > +       struct xdp_buff *xdp;
> > +       u32 len, truesize;
> > +       struct page *page;
> > +       void *buf;
> > +
> > +       curr_skb =3D head_skb;
> > +
> > +       while (--num_buf) {
> > +               buf =3D virtqueue_get_buf(rq->vq, &len);
> > +               if (unlikely(!buf)) {
> > +                       pr_debug("%s: rx error: %d buffers out of %d mi=
ssing\n",
> > +                                vi->dev->name, num_buf,
> > +                                virtio16_to_cpu(vi->vdev,
> > +                                                hdr->num_buffers));
> > +                       DEV_STATS_INC(vi->dev, rx_length_errors);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               u64_stats_add(&stats->bytes, len);
> > +
> > +               xdp =3D buf_to_xdp(vi, rq, buf, len);
> > +               if (!xdp)
> > +                       goto err;
> > +
> > +               buf =3D napi_alloc_frag(len);
>
> So we don't do this for non xsk paths. Any reason we can't reuse the
> existing codes?

Do you mean this code:

	while (--num_buf) {
		int num_skb_frags;

->		buf =3D virtnet_rq_get_buf(rq, &len, &ctx);
		if (unlikely(!buf)) {
			pr_debug("%s: rx error: %d buffers out of %d missing\n",
				 dev->name, num_buf,
				 virtio16_to_cpu(vi->vdev,
						 hdr->num_buffers));
			DEV_STATS_INC(dev, rx_length_errors);
			goto err_buf;
		}

		u64_stats_add(&stats->bytes, len);
		page =3D virt_to_head_page(buf);

->		truesize =3D mergeable_ctx_to_truesize(ctx);
->		headroom =3D mergeable_ctx_to_headroom(ctx);
->		tailroom =3D headroom ? sizeof(struct skb_shared_info) : 0;
->		room =3D SKB_DATA_ALIGN(headroom + tailroom);
->		if (unlikely(len > truesize - room)) {
->			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
->				 dev->name, len, (unsigned long)(truesize - room));
->			DEV_STATS_INC(dev, rx_length_errors);
->			goto err_skb;
->		}

		curr_skb  =3D virtnet_skb_append_frag(head_skb, curr_skb, page,
						    buf, len, truesize);
		if (!curr_skb)
			goto err_skb;
	}

The code lines that are marked are differ.

The same logic is separated to function virtnet_skb_append_frag().

So the code is similitude, but we can not merge them.

Thanks.



>
> Thanks
>

