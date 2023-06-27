Return-Path: <bpf+bounces-3548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237DD73F848
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 11:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36CD280FC7
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21E6168BC;
	Tue, 27 Jun 2023 09:08:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D0BE53;
	Tue, 27 Jun 2023 09:08:35 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A4526A5;
	Tue, 27 Jun 2023 02:08:26 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vm5G301_1687856900;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vm5G301_1687856900)
          by smtp.aliyun-inc.com;
          Tue, 27 Jun 2023 17:08:21 +0800
Message-ID: <1687856738.178093-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 04/10] virtio_ring: packed: support add premapped buf
Date: Tue, 27 Jun 2023 17:05:38 +0800
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
 <20230602092206.50108-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEuoBtQ+=kJJk84Vs2sk7WAdh8O3d2wJLM-yBFAtkgLEUA@mail.gmail.com>
In-Reply-To: <CACGkMEuoBtQ+=kJJk84Vs2sk7WAdh8O3d2wJLM-yBFAtkgLEUA@mail.gmail.com>
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

On Tue, 27 Jun 2023 16:03:29 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Jun 2, 2023 at 5:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > If the vq is the premapped mode, use the sg_dma_address() directly.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 36 ++++++++++++++++++++++++++----------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 18212c3e056b..dc109fbc05a5 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1299,9 +1299,13 @@ static int virtqueue_add_indirect_packed(struct =
vring_virtqueue *vq,
> >
> >         for (n =3D 0; n < out_sgs + in_sgs; n++) {
> >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > -                       if (vring_map_one_sg(vq, sg, n < out_sgs ?
> > -                                            DMA_TO_DEVICE : DMA_FROM_D=
EVICE, &addr))
> > -                               goto unmap_release;
> > +                       if (vq->premapped) {
> > +                               addr =3D sg_dma_address(sg);
> > +                       } else {
> > +                               if (vring_map_one_sg(vq, sg, n < out_sg=
s ?
> > +                                                    DMA_TO_DEVICE : DM=
A_FROM_DEVICE, &addr))
> > +                                       goto unmap_release;
> > +                       }
> >
> >                         desc[i].flags =3D cpu_to_le16(n < out_sgs ?
> >                                                 0 : VRING_DESC_F_WRITE);
> > @@ -1369,10 +1373,12 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> >         return 0;
> >
> >  unmap_release:
> > -       err_idx =3D i;
> > +       if (!vq->premapped) {
> > +               err_idx =3D i;
> >
> > -       for (i =3D 0; i < err_idx; i++)
> > -               vring_unmap_desc_packed(vq, &desc[i]);
> > +               for (i =3D 0; i < err_idx; i++)
> > +                       vring_unmap_desc_packed(vq, &desc[i]);
> > +       }
> >
> >         kfree(desc);
> >
> > @@ -1447,9 +1453,13 @@ static inline int virtqueue_add_packed(struct vi=
rtqueue *_vq,
> >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> >                         dma_addr_t addr;
> >
> > -                       if (vring_map_one_sg(vq, sg, n < out_sgs ?
> > -                                            DMA_TO_DEVICE : DMA_FROM_D=
EVICE, &addr))
> > -                               goto unmap_release;
> > +                       if (vq->premapped) {
> > +                               addr =3D sg_dma_address(sg);
> > +                       } else {
> > +                               if (vring_map_one_sg(vq, sg, n < out_sg=
s ?
> > +                                                    DMA_TO_DEVICE : DM=
A_FROM_DEVICE, &addr))
> > +                                       goto unmap_release;
> > +                       }
> >
> >                         flags =3D cpu_to_le16(vq->packed.avail_used_fla=
gs |
> >                                     (++c =3D=3D total_sg ? 0 : VRING_DE=
SC_F_NEXT) |
> > @@ -1512,11 +1522,17 @@ static inline int virtqueue_add_packed(struct v=
irtqueue *_vq,
> >         return 0;
> >
> >  unmap_release:
> > +       vq->packed.avail_used_flags =3D avail_used_flags;
> > +
> > +       if (vq->premapped) {
>
> Similar to the split path, I think we can't hit vq->premapped here.


YES, similar to the above reply, we can have a better way.

But, we can hit vq->premapped, when we fail doing dma for the indirect desc
array.

Thanks.




>
> Thanks
>
>
> > +               END_USE(vq);
> > +               return -EIO;
> > +       }
> > +
> >         err_idx =3D i;
> >         i =3D head;
> >         curr =3D vq->free_head;
> >
> > -       vq->packed.avail_used_flags =3D avail_used_flags;
> >
> >         for (n =3D 0; n < total_sg; n++) {
> >                 if (i =3D=3D err_idx)
> > --
> > 2.32.0.3.g01195cf9f
> >
>

