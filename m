Return-Path: <bpf+bounces-12805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CB67D0973
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 09:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D11282443
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDC2D2F2;
	Fri, 20 Oct 2023 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D656107;
	Fri, 20 Oct 2023 07:23:50 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC2B10D9;
	Fri, 20 Oct 2023 00:23:47 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuWM7J9_1697786622;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuWM7J9_1697786622)
          by smtp.aliyun-inc.com;
          Fri, 20 Oct 2023 15:23:43 +0800
Message-ID: <1697786208.7535846-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 08/19] virtio_net: sq support premapped mode
Date: Fri, 20 Oct 2023 15:16:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEuq8i9_PX+vRESS3g2BpaWBv3FxDLMryG=aEJ+gAOsSaA@mail.gmail.com>
In-Reply-To: <CACGkMEuq8i9_PX+vRESS3g2BpaWBv3FxDLMryG=aEJ+gAOsSaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, 20 Oct 2023 14:50:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > If the xsk is enabling, the xsk tx will share the send queue.
> > But the xsk requires that the send queue use the premapped mode.
> > So the send queue must support premapped mode.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/main.c       | 108 ++++++++++++++++++++++++++++----
> >  drivers/net/virtio/virtio_net.h |  54 +++++++++++++++-
> >  2 files changed, 149 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index 8da84ea9bcbe..02d27101fef1 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -514,20 +514,104 @@ static void *virtnet_rq_alloc(struct virtnet_rq =
*rq, u32 size, gfp_t gfp)
> >         return buf;
> >  }
> >
> > -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > +static int virtnet_sq_set_premapped(struct virtnet_sq *sq)
> >  {
> > -       int i;
> > +       struct virtnet_sq_dma *d;
> > +       int err, size, i;
> >
> > -       /* disable for big mode */
> > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > -               return;
>
> Not specific to this patch but any plan to fix the big mode?
>


For big, we should make it support XDP and do dma first.


>
> > +       size =3D virtqueue_get_vring_size(sq->vq);
> > +
> > +       size +=3D MAX_SKB_FRAGS + 2;
> > +
> > +       sq->dmainfo.head =3D kcalloc(size, sizeof(*sq->dmainfo.head), G=
FP_KERNEL);
> > +       if (!sq->dmainfo.head)
> > +               return -ENOMEM;
> > +
> > +       err =3D virtqueue_set_dma_premapped(sq->vq);
> > +       if (err) {
> > +               kfree(sq->dmainfo.head);
> > +               return err;
> > +       }
> > +
> > +       sq->dmainfo.free =3D NULL;
> > +

[...]

> > +
> > +               d->addr =3D sg->dma_address;
> > +               d->len =3D sg->length;
> > +
> > +               d->next =3D head;
> > +               head =3D d;
>
> It's really a pity that we need to duplicate those DMA metata twice.
> Could we invent a new API to just fetch it from the virtio core?

Actually, I posted that patch.

Consider this is pushing to net-next. We can do that on top.


>
> > +       }
> > +
> > +       head->data =3D data;
> > +
> > +       return (void *)((unsigned long)head | ((unsigned long)data & VI=
RTIO_XMIT_DATA_MASK));
>
> If we packed everything into dmainfo, we can leave the type (XDP vs
> skb) there to avoid trick like packing it into the pointer here?

Yes. But if the virtio has not _ACCESS_PLATFORM, the driver will
has not the DMA meta data.

Thanks.


>
> Thanks
>

