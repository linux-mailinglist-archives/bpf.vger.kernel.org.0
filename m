Return-Path: <bpf+bounces-4839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36AD7501B5
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 10:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C561281979
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F1100AB;
	Wed, 12 Jul 2023 08:36:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25927100A1;
	Wed, 12 Jul 2023 08:36:22 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69B01FD4;
	Wed, 12 Jul 2023 01:36:19 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VnCF4AR_1689150975;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VnCF4AR_1689150975)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 16:36:16 +0800
Message-ID: <1689150956.767141-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 03/10] virtio_ring: introduce virtqueue_set_premapped()
Date: Wed, 12 Jul 2023 16:35:56 +0800
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
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEumF73qbByV3K1+fdgnXBXqu-YS2yas+Vy_=Dn+yjy-cw@mail.gmail.com>
In-Reply-To: <CACGkMEumF73qbByV3K1+fdgnXBXqu-YS2yas+Vy_=Dn+yjy-cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 12 Jul 2023 16:24:18 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jul 10, 2023 at 11:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com>
> wrote:
>
> > This helper allows the driver change the dma mode to premapped mode.
> > Under the premapped mode, the virtio core do not do dma mapping
> > internally.
> >
> > This just work when the use_dma_api is true. If the use_dma_api is fals=
e,
> > the dma options is not through the DMA APIs, that is not the standard
> > way of the linux kernel.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 45 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  2 ++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 87d7ceeecdbd..5ace4539344c 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -172,6 +172,9 @@ struct vring_virtqueue {
> >         /* Host publishes avail event idx */
> >         bool event;
> >
> > +       /* Do DMA mapping by driver */
> > +       bool premapped;
> > +
> >         /* Head of free buffer list. */
> >         unsigned int free_head;
> >         /* Number we've added since last sync. */
> > @@ -2061,6 +2064,7 @@ static struct virtqueue
> > *vring_create_virtqueue_packed(
> >         vq->packed_ring =3D true;
> >         vq->dma_dev =3D dma_dev;
> >         vq->use_dma_api =3D vring_use_dma_api(vdev);
> > +       vq->premapped =3D false;
> >
> >         vq->indirect =3D virtio_has_feature(vdev,
> > VIRTIO_RING_F_INDIRECT_DESC) &&
> >                 !context;
> > @@ -2550,6 +2554,7 @@ static struct virtqueue
> > *__vring_new_virtqueue(unsigned int index,
> >  #endif
> >         vq->dma_dev =3D dma_dev;
> >         vq->use_dma_api =3D vring_use_dma_api(vdev);
> > +       vq->premapped =3D false;
> >
> >         vq->indirect =3D virtio_has_feature(vdev,
> > VIRTIO_RING_F_INDIRECT_DESC) &&
> >                 !context;
> > @@ -2693,6 +2698,46 @@ int virtqueue_resize(struct virtqueue *_vq, u32 =
num,
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> >
> > +/**
> > + * virtqueue_set_premapped - set the vring premapped mode
> > + * @_vq: the struct virtqueue we're talking about.
> > + *
> > + * Enable the premapped mode of the vq.
> > + *
> > + * The vring in premapped mode does not do dma internally, so the driv=
er
> > must
> > + * do dma mapping in advance. The driver must pass the dma_address thr=
ough
> > + * dma_address of scatterlist. When the driver got a used buffer from
> > + * the vring, it has to unmap the dma address.
> > + *
> > + * This function must be called immediately after creating the vq, or
> > after vq
> > + * reset, and before adding any buffers to it.
> > + *
> > + * Caller must ensure we don't call this with other virtqueue operatio=
ns
> > + * at the same time (except where noted).
> > + *
> > + * Returns zero or a negative error.
> > + * 0: success.
> > + * -EINVAL: vring does not use the dma api, so we can not enable
> > premapped mode.
> > + */
> > +int virtqueue_set_premapped(struct virtqueue *_vq)
> > +{
> > +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > +       u32 num;
> > +
> > +       num =3D vq->packed_ring ? vq->packed.vring.num : vq->split.vrin=
g.num;
> > +
> > +       if (num !=3D vq->vq.num_free)
> > +               return -EINVAL;
> >
>
> If we check this, I think we need to protect this with
> START_USE()/END_USE().

YES.


>
>
> > +
> > +       if (!vq->use_dma_api)
> > +               return -EINVAL;
> >
>
> Not a native spreak, but I think "dma_premapped" is better than "premappe=
d"
> as "dma_premapped" implies "use_dma_api".

I am ok to fix this.

Thanks.


>
> Thanks
>
>
> > +
> > +       vq->premapped =3D true;
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_set_premapped);
> > +
> >  /* Only available for split ring */
> >  struct virtqueue *vring_new_virtqueue(unsigned int index,
> >                                       unsigned int num,
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index de6041deee37..2efd07b79ecf 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -78,6 +78,8 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
> >
> >  unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
> >
> > +int virtqueue_set_premapped(struct virtqueue *_vq);
> > +
> >  bool virtqueue_poll(struct virtqueue *vq, unsigned);
> >
> >  bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
> > --
> > 2.32.0.3.g01195cf9f
> >
> >
>

