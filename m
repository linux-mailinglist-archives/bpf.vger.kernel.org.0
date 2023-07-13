Return-Path: <bpf+bounces-4912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D50F751724
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5D81C21271
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792B5256;
	Thu, 13 Jul 2023 04:06:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97652468C;
	Thu, 13 Jul 2023 04:06:21 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276E9268C;
	Wed, 12 Jul 2023 21:06:10 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VnFW1kU_1689221166;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VnFW1kU_1689221166)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 12:06:07 +0800
Message-ID: <1689220976.8908284-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 06/10] virtio_ring: skip unmap for premapped
Date: Thu, 13 Jul 2023 12:02:56 +0800
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
 <20230710034237.12391-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEtb_wYyXLU6kAaC2Ju2d4K=J+YbytUCMvKcNtPF+BvpJw@mail.gmail.com>
In-Reply-To: <CACGkMEtb_wYyXLU6kAaC2Ju2d4K=J+YbytUCMvKcNtPF+BvpJw@mail.gmail.com>
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

On Thu, 13 Jul 2023 11:50:57 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jul 10, 2023 at 11:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > Now we add a case where we skip dma unmap, the vq->premapped is true.
> >
> > We can't just rely on use_dma_api to determine whether to skip the dma
> > operation. For convenience, I introduced the "do_unmap". By default, it
> > is the same as use_dma_api. If the driver is configured with premapped,
> > then do_unmap is false.
> >
> > So as long as do_unmap is false, for addr of desc, we should skip dma
> > unmap operation.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 42 ++++++++++++++++++++++++------------
> >  1 file changed, 28 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 1fb2c6dca9ea..10ee3b7ce571 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -175,6 +175,11 @@ struct vring_virtqueue {
> >         /* Do DMA mapping by driver */
> >         bool premapped;
> >
> > +       /* Do unmap or not for desc. Just when premapped is False and
> > +        * use_dma_api is true, this is true.
> > +        */
> > +       bool do_unmap;
> > +
> >         /* Head of free buffer list. */
> >         unsigned int free_head;
> >         /* Number we've added since last sync. */
> > @@ -440,7 +445,7 @@ static void vring_unmap_one_split_indirect(const st=
ruct vring_virtqueue *vq,
> >  {
> >         u16 flags;
> >
> > -       if (!vq->use_dma_api)
> > +       if (!vq->do_unmap)
> >                 return;
> >
> >         flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
> > @@ -458,18 +463,21 @@ static unsigned int vring_unmap_one_split(const s=
truct vring_virtqueue *vq,
> >         struct vring_desc_extra *extra =3D vq->split.desc_extra;
> >         u16 flags;
> >
> > -       if (!vq->use_dma_api)
> > -               goto out;
> > -
> >         flags =3D extra[i].flags;
> >
> >         if (flags & VRING_DESC_F_INDIRECT) {
> > +               if (!vq->use_dma_api)
> > +                       goto out;
> > +
> >                 dma_unmap_single(vring_dma_dev(vq),
> >                                  extra[i].addr,
> >                                  extra[i].len,
> >                                  (flags & VRING_DESC_F_WRITE) ?
> >                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >         } else {
> > +               if (!vq->do_unmap)
> > +                       goto out;
> > +
> >                 dma_unmap_page(vring_dma_dev(vq),
> >                                extra[i].addr,
> >                                extra[i].len,
> > @@ -635,7 +643,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >         }
> >         /* Last one doesn't continue. */
> >         desc[prev].flags &=3D cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_=
NEXT);
> > -       if (!indirect && vq->use_dma_api)
> > +       if (!indirect && vq->do_unmap)
> >                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].=
flags &=3D
> >                         ~VRING_DESC_F_NEXT;
> >
> > @@ -794,7 +802,7 @@ static void detach_buf_split(struct vring_virtqueue=
 *vq, unsigned int head,
> >                                 VRING_DESC_F_INDIRECT));
> >                 BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc));
> >
> > -               if (vq->use_dma_api) {
> > +               if (vq->do_unmap) {
> >                         for (j =3D 0; j < len / sizeof(struct vring_des=
c); j++)
> >                                 vring_unmap_one_split_indirect(vq, &ind=
ir_desc[j]);
> >                 }
> > @@ -1217,17 +1225,20 @@ static void vring_unmap_extra_packed(const stru=
ct vring_virtqueue *vq,
> >  {
> >         u16 flags;
> >
> > -       if (!vq->use_dma_api)
> > -               return;
> > -
> >         flags =3D extra->flags;
> >
> >         if (flags & VRING_DESC_F_INDIRECT) {
> > +               if (!vq->use_dma_api)
> > +                       return;
> > +
> >                 dma_unmap_single(vring_dma_dev(vq),
> >                                  extra->addr, extra->len,
> >                                  (flags & VRING_DESC_F_WRITE) ?
> >                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >         } else {
> > +               if (!vq->do_unmap)
> > +                       return;
>
> This seems not straightforward than:
>
> if (!vq->use_dma_api)
>     return;
>
> if (INDIRECT) {
> } else if (!vq->premapped) {
> }
>
> ?


My logic here is that for the real buffer, we use do_unmap to judge uniform=
ly.
And indirect still use use_dma_api to judge.

From this point of view, how do you feel?

Thanks.


>
> Thanks
>
> > +
> >                 dma_unmap_page(vring_dma_dev(vq),
> >                                extra->addr, extra->len,
> >                                (flags & VRING_DESC_F_WRITE) ?
> > @@ -1240,7 +1251,7 @@ static void vring_unmap_desc_packed(const struct =
vring_virtqueue *vq,
> >  {
> >         u16 flags;
> >
> > -       if (!vq->use_dma_api)
> > +       if (!vq->do_unmap)
> >                 return;
> >
> >         flags =3D le16_to_cpu(desc->flags);
> > @@ -1329,7 +1340,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >                                 sizeof(struct vring_packed_desc));
> >         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
> >
> > -       if (vq->use_dma_api) {
> > +       if (vq->do_unmap) {
> >                 vq->packed.desc_extra[id].addr =3D addr;
> >                 vq->packed.desc_extra[id].len =3D total_sg *
> >                                 sizeof(struct vring_packed_desc);
> > @@ -1470,7 +1481,7 @@ static inline int virtqueue_add_packed(struct vir=
tqueue *_vq,
> >                         desc[i].len =3D cpu_to_le32(sg->length);
> >                         desc[i].id =3D cpu_to_le16(id);
> >
> > -                       if (unlikely(vq->use_dma_api)) {
> > +                       if (unlikely(vq->do_unmap)) {
> >                                 vq->packed.desc_extra[curr].addr =3D ad=
dr;
> >                                 vq->packed.desc_extra[curr].len =3D sg-=
>length;
> >                                 vq->packed.desc_extra[curr].flags =3D
> > @@ -1604,7 +1615,7 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
> >         vq->free_head =3D id;
> >         vq->vq.num_free +=3D state->num;
> >
> > -       if (unlikely(vq->use_dma_api)) {
> > +       if (unlikely(vq->do_unmap)) {
> >                 curr =3D id;
> >                 for (i =3D 0; i < state->num; i++) {
> >                         vring_unmap_extra_packed(vq,
> > @@ -1621,7 +1632,7 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
> >                 if (!desc)
> >                         return;
> >
> > -               if (vq->use_dma_api) {
> > +               if (vq->do_unmap) {
> >                         len =3D vq->packed.desc_extra[id].len;
> >                         for (i =3D 0; i < len / sizeof(struct vring_pac=
ked_desc);
> >                                         i++)
> > @@ -2080,6 +2091,7 @@ static struct virtqueue *vring_create_virtqueue_p=
acked(
> >         vq->dma_dev =3D dma_dev;
> >         vq->use_dma_api =3D vring_use_dma_api(vdev);
> >         vq->premapped =3D false;
> > +       vq->do_unmap =3D vq->use_dma_api;
> >
> >         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIREC=
T_DESC) &&
> >                 !context;
> > @@ -2587,6 +2599,7 @@ static struct virtqueue *__vring_new_virtqueue(un=
signed int index,
> >         vq->dma_dev =3D dma_dev;
> >         vq->use_dma_api =3D vring_use_dma_api(vdev);
> >         vq->premapped =3D false;
> > +       vq->do_unmap =3D vq->use_dma_api;
> >
> >         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIREC=
T_DESC) &&
> >                 !context;
> > @@ -2765,6 +2778,7 @@ int virtqueue_set_premapped(struct virtqueue *_vq)
> >                 return -EINVAL;
> >
> >         vq->premapped =3D true;
> > +       vq->do_unmap =3D false;
> >
> >         return 0;
> >  }
> > --
> > 2.32.0.3.g01195cf9f
> >
>

