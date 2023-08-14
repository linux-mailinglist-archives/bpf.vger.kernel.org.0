Return-Path: <bpf+bounces-7696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C277B507
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 11:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6606E280E72
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 09:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B0A94D;
	Mon, 14 Aug 2023 09:03:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D444A927;
	Mon, 14 Aug 2023 09:03:38 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984EC10B;
	Mon, 14 Aug 2023 02:03:36 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpjgjX-_1692003812;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VpjgjX-_1692003812)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 17:03:33 +0800
Message-ID: <1692003413.6339955-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
Date: Mon, 14 Aug 2023 16:56:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
In-Reply-To: <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 14 Aug 2023 11:05:49 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Aug 10, 2023 at 8:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Added virtqueue_dma_dev() to get DMA device for virtio. Then the
> > caller can do dma operation in advance. The purpose is to keep memory
> > mapped across multiple add/get buf operations.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> So I think we don't have actual users for this in this series? Can we
> simply have another independent patch for this?

I am ok. I will remove this from the next version.

But I also help merge this to 6.6. Then we can let the virtio-net to support
AF_XDP in 6.7+.


>
> > ---
> >  drivers/virtio/virtio_ring.c | 17 +++++++++++++++++
> >  include/linux/virtio.h       |  2 ++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index f9f772e85a38..bb3d73d221cd 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2265,6 +2265,23 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
> >
> > +/**
> > + * virtqueue_dma_dev - get the dma dev
> > + * @_vq: the struct virtqueue we're talking about.
> > + *
> > + * Returns the dma dev. That can been used for dma api.
> > + */
> > +struct device *virtqueue_dma_dev(struct virtqueue *_vq)
> > +{
> > +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > +
> > +       if (vq->use_dma_api)
> > +               return vring_dma_dev(vq);
> > +       else
> > +               return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_dma_dev);
>
> One possible concern is that exporting things like NULL may result in
> the switch in the caller (driver). I wonder if it's better to do
> BUG_ON() in the path of NULL?


I agree.

But we need a new helper to tell the driver(or AF_XDP) that the device supp=
ort
ACCESS_PLATFORM or not.

We need a switch, but we can make the switch is irrelevant to the DMA.

Thanks.



>
> Thanks
>
> > +
> >  /**
> >   * virtqueue_kick_prepare - first half of split virtqueue_kick call.
> >   * @_vq: the struct virtqueue
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 8add38038877..bd55a05eec04 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -61,6 +61,8 @@ int virtqueue_add_sgs(struct virtqueue *vq,
> >                       void *data,
> >                       gfp_t gfp);
> >
> > +struct device *virtqueue_dma_dev(struct virtqueue *vq);
> > +
> >  bool virtqueue_kick(struct virtqueue *vq);
> >
> >  bool virtqueue_kick_prepare(struct virtqueue *vq);
> > --
> > 2.32.0.3.g01195cf9f
> >
>

