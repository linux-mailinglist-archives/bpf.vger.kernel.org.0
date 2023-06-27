Return-Path: <bpf+bounces-3549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F573F89E
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 11:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235391C203A2
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285FD168DE;
	Tue, 27 Jun 2023 09:21:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294C10F9;
	Tue, 27 Jun 2023 09:21:41 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C10110C;
	Tue, 27 Jun 2023 02:21:38 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vm5G9bd_1687857694;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vm5G9bd_1687857694)
          by smtp.aliyun-inc.com;
          Tue, 27 Jun 2023 17:21:35 +0800
Message-ID: <1687857679.82929-7-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 05/10] virtio_ring: split-detach: support return dma info to driver
Date: Tue, 27 Jun 2023 17:21:19 +0800
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
 bpf@vger.kernel.org
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEvynjFgmt5Q9ime1-Zf6P5LXYYXg4e4iVpAEtmSV7d0pQ@mail.gmail.com>
In-Reply-To: <CACGkMEvynjFgmt5Q9ime1-Zf6P5LXYYXg4e4iVpAEtmSV7d0pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 27 Jun 2023 16:03:31 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Jun 2, 2023 at 5:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > Under the premapped mode, the driver needs to unmap the DMA address
> > after receiving the buffer. The virtio core records the DMA address,
> > so the driver needs a way to get the dma info from the virtio core.
>
> A second thought, can we simply offload the tracking to the driver
> itself? This looks the way many other modern NIC drivers did.
>
> In pre mapped mode, the DMA address is in fact told by the driver
> itself so it should have sufficient knowledge. And in some cases, the
> driver wants to optimize/merge/delay the unampping so the DMA
> addresses returned by the virtio core are not even interested in those
> cases.

Will fix.

Thanks.


>
> Thanks
>
>
>
> >
> > A straightforward approach is to pass an array to the virtio core when
> > calling virtqueue_get_buf(). However, it is not feasible when there are
> > multiple DMA addresses in the descriptor chain, and the array size is
> > unknown.
> >
> > To solve this problem, a helper be introduced. After calling
> > virtqueue_get_buf(), the driver can call the helper to
> > retrieve a dma info. If the helper function returns -EAGAIN, it means
> > that there are more DMA addresses to be processed, and the driver should
> > call the helper function again. To keep track of the current position in
> > the chain, a cursor must be passed to the helper function, which is
> > initialized by virtqueue_get_buf().
> >
> > Some processes are done inside this helper, so this helper MUST be
> > called under the premapped mode.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 118 ++++++++++++++++++++++++++++++++---
> >  include/linux/virtio.h       |  11 ++++
> >  2 files changed, 119 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index dc109fbc05a5..cdc4349f6066 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -754,8 +754,95 @@ static bool virtqueue_kick_prepare_split(struct vi=
rtqueue *_vq)
> >         return needs_kick;
> >  }
> >
> > -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int =
head,
> > -                            void **ctx)
> > +static void detach_cursor_init_split(struct vring_virtqueue *vq,
> > +                                    struct virtqueue_detach_cursor *cu=
rsor, u16 head)
> > +{
> > +       struct vring_desc_extra *extra;
> > +
> > +       extra =3D &vq->split.desc_extra[head];
> > +
> > +       /* Clear data ptr. */
> > +       vq->split.desc_state[head].data =3D NULL;
> > +
> > +       cursor->head =3D head;
> > +       cursor->done =3D 0;
> > +
> > +       if (extra->flags & VRING_DESC_F_INDIRECT) {
> > +               cursor->num =3D extra->len / sizeof(struct vring_desc);
> > +               cursor->indirect =3D true;
> > +               cursor->pos =3D 0;
> > +
> > +               vring_unmap_one_split(vq, head);
> > +
> > +               extra->next =3D vq->free_head;
> > +
> > +               vq->free_head =3D head;
> > +
> > +               /* Plus final descriptor */
> > +               vq->vq.num_free++;
> > +
> > +       } else {
> > +               cursor->indirect =3D false;
> > +               cursor->pos =3D head;
> > +       }
> > +}
> > +
> > +static int virtqueue_detach_split(struct virtqueue *_vq, struct virtqu=
eue_detach_cursor *cursor,
> > +                                 dma_addr_t *addr, u32 *len, enum dma_=
data_direction *dir)
> > +{
> > +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > +       __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DESC=
_F_NEXT);
> > +       int rc =3D -EAGAIN;
> > +
> > +       if (unlikely(cursor->done))
> > +               return -EINVAL;
> > +
> > +       if (!cursor->indirect) {
> > +               struct vring_desc_extra *extra;
> > +               unsigned int i;
> > +
> > +               i =3D cursor->pos;
> > +
> > +               extra =3D &vq->split.desc_extra[i];
> > +
> > +               if (vq->split.vring.desc[i].flags & nextflag) {
> > +                       cursor->pos =3D extra->next;
> > +               } else {
> > +                       extra->next =3D vq->free_head;
> > +                       vq->free_head =3D cursor->head;
> > +                       cursor->done =3D true;
> > +                       rc =3D 0;
> > +               }
> > +
> > +               *addr =3D extra->addr;
> > +               *len =3D extra->len;
> > +               *dir =3D (extra->flags & VRING_DESC_F_WRITE) ? DMA_FROM=
_DEVICE : DMA_TO_DEVICE;
> > +
> > +               vq->vq.num_free++;
> > +
> > +       } else {
> > +               struct vring_desc *indir_desc, *desc;
> > +               u16 flags;
> > +
> > +               indir_desc =3D vq->split.desc_state[cursor->head].indir=
_desc;
> > +               desc =3D &indir_desc[cursor->pos];
> > +
> > +               flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
> > +               *addr =3D virtio64_to_cpu(vq->vq.vdev, desc->addr);
> > +               *len =3D virtio32_to_cpu(vq->vq.vdev, desc->len);
> > +               *dir =3D (flags & VRING_DESC_F_WRITE) ? DMA_FROM_DEVICE=
 : DMA_TO_DEVICE;
> > +
> > +               if (++cursor->pos =3D=3D cursor->num) {
> > +                       kfree(indir_desc);
> > +                       cursor->done =3D true;
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       return rc;
> > +}
> > +
> > +static void detach_buf_split(struct vring_virtqueue *vq, unsigned int =
head)
> >  {
> >         unsigned int i, j;
> >         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DESC=
_F_NEXT);
> > @@ -799,8 +886,6 @@ static void detach_buf_split(struct vring_virtqueue=
 *vq, unsigned int head,
> >
> >                 kfree(indir_desc);
> >                 vq->split.desc_state[head].indir_desc =3D NULL;
> > -       } else if (ctx) {
> > -               *ctx =3D vq->split.desc_state[head].indir_desc;
> >         }
> >  }
> >
> > @@ -812,7 +897,8 @@ static bool more_used_split(const struct vring_virt=
queue *vq)
> >
> >  static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >                                          unsigned int *len,
> > -                                        void **ctx)
> > +                                        void **ctx,
> > +                                        struct virtqueue_detach_cursor=
 *cursor)
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> >         void *ret;
> > @@ -852,7 +938,15 @@ static void *virtqueue_get_buf_ctx_split(struct vi=
rtqueue *_vq,
> >
> >         /* detach_buf_split clears data, so grab it now. */
> >         ret =3D vq->split.desc_state[i].data;
> > -       detach_buf_split(vq, i, ctx);
> > +
> > +       if (!vq->indirect && ctx)
> > +               *ctx =3D vq->split.desc_state[i].indir_desc;
> > +
> > +       if (vq->premapped)
> > +               detach_cursor_init_split(vq, cursor, i);
> > +       else
> > +               detach_buf_split(vq, i);
> > +
> >         vq->last_used_idx++;
> >         /* If we expect an interrupt for the next entry, tell host
> >          * by writing event index and flush out the write before
> > @@ -961,7 +1055,8 @@ static bool virtqueue_enable_cb_delayed_split(stru=
ct virtqueue *_vq)
> >         return true;
> >  }
> >
> > -static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
> > +static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq,
> > +                                              struct virtqueue_detach_=
cursor *cursor)
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> >         unsigned int i;
> > @@ -974,7 +1069,10 @@ static void *virtqueue_detach_unused_buf_split(st=
ruct virtqueue *_vq)
> >                         continue;
> >                 /* detach_buf_split clears data, so grab it now. */
> >                 buf =3D vq->split.desc_state[i].data;
> > -               detach_buf_split(vq, i, NULL);
> > +               if (vq->premapped)
> > +                       detach_cursor_init_split(vq, cursor, i);
> > +               else
> > +                       detach_buf_split(vq, i);
> >                 vq->split.avail_idx_shadow--;
> >                 vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vde=
v,
> >                                 vq->split.avail_idx_shadow);
> > @@ -2361,7 +2459,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq=
, unsigned int *len,
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> >         return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len,=
 ctx) :
> > -                                virtqueue_get_buf_ctx_split(_vq, len, =
ctx);
> > +                                virtqueue_get_buf_ctx_split(_vq, len, =
ctx, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
> >
> > @@ -2493,7 +2591,7 @@ void *virtqueue_detach_unused_buf(struct virtqueu=
e *_vq)
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> >         return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq=
) :
> > -                                virtqueue_detach_unused_buf_split(_vq);
> > +                                virtqueue_detach_unused_buf_split(_vq,=
 NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> >
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 1fc0e1023bd4..eb4a4e4329aa 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -38,6 +38,17 @@ struct virtqueue {
> >         void *priv;
> >  };
> >
> > +struct virtqueue_detach_cursor {
> > +       unsigned indirect:1;
> > +       unsigned done:1;
> > +       unsigned hole:14;
> > +
> > +       /* for split head */
> > +       unsigned head:16;
> > +       unsigned num:16;
> > +       unsigned pos:16;
> > +};
> > +
> >  int virtqueue_add_outbuf(struct virtqueue *vq,
> >                          struct scatterlist sg[], unsigned int num,
> >                          void *data,
> > --
> > 2.32.0.3.g01195cf9f
> >
>

