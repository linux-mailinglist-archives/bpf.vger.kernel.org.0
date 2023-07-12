Return-Path: <bpf+bounces-4838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B337501A9
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 10:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92B5281A03
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C799D7471;
	Wed, 12 Jul 2023 08:34:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F707638;
	Wed, 12 Jul 2023 08:34:52 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E9B1994;
	Wed, 12 Jul 2023 01:34:50 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VnCCAGS_1689150885;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VnCCAGS_1689150885)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 16:34:46 +0800
Message-ID: <1689150822.0177438-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 04/10] virtio_ring: support add premapped buf
Date: Wed, 12 Jul 2023 16:33:42 +0800
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
 <20230710034237.12391-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEu16kUX02L+zb=hcX_sMW-s6wBFtiCRC_3H4ky4iDdy4Q@mail.gmail.com>
In-Reply-To: <CACGkMEu16kUX02L+zb=hcX_sMW-s6wBFtiCRC_3H4ky4iDdy4Q@mail.gmail.com>
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

On Wed, 12 Jul 2023 16:31:35 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jul 10, 2023 at 11:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > If the vq is the premapped mode, use the sg_dma_address() directly.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 5ace4539344c..d471dee3f4f7 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -361,6 +361,11 @@ static struct device *vring_dma_dev(const struct v=
ring_virtqueue *vq)
> >  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct s=
catterlist *sg,
> >                             enum dma_data_direction direction, dma_addr=
_t *addr)
> >  {
> > +       if (vq->premapped) {
> > +               *addr =3D sg_dma_address(sg);
> > +               return 0;
> > +       }
> > +
> >         if (!vq->use_dma_api) {
> >                 /*
> >                  * If DMA is not used, KMSAN doesn't know that the scat=
terlist
> > @@ -639,8 +644,12 @@ static inline int virtqueue_add_split(struct virtq=
ueue *_vq,
> >                 dma_addr_t addr =3D vring_map_single(
> >                         vq, desc, total_sg * sizeof(struct vring_desc),
> >                         DMA_TO_DEVICE);
> > -               if (vring_mapping_error(vq, addr))
> > +               if (vring_mapping_error(vq, addr)) {
> > +                       if (vq->premapped)
> > +                               goto free_indirect;
>
> Under which case could we hit this? A bug of the driver?

Here the map operate is for the indirect descs array.

So this is done inside the virtio core.

Thanks.




>
> Thanks
>
> > +
> >                         goto unmap_release;
> > +               }
> >
> >                 virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> >                                          head, addr,
> > @@ -706,6 +715,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                         i =3D vring_unmap_one_split(vq, i);
> >         }
> >
> > +free_indirect:
> >         if (indirect)
> >                 kfree(desc);
> >
> > @@ -1307,8 +1317,12 @@ static int virtqueue_add_indirect_packed(struct =
vring_virtqueue *vq,
> >         addr =3D vring_map_single(vq, desc,
> >                         total_sg * sizeof(struct vring_packed_desc),
> >                         DMA_TO_DEVICE);
> > -       if (vring_mapping_error(vq, addr))
> > +       if (vring_mapping_error(vq, addr)) {
> > +               if (vq->premapped)
> > +                       goto free_desc;
> > +
> >                 goto unmap_release;
> > +       }
> >
> >         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
> >         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
> > @@ -1366,6 +1380,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >         for (i =3D 0; i < err_idx; i++)
> >                 vring_unmap_desc_packed(vq, &desc[i]);
> >
> > +free_desc:
> >         kfree(desc);
> >
> >         END_USE(vq);
> > --
> > 2.32.0.3.g01195cf9f
> >
>

