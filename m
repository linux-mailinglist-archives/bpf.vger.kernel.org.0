Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B777D740A75
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 10:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjF1IGV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 04:06:21 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111]:41714 "EHLO
        out30-111.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232682AbjF1IC7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Jun 2023 04:02:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vm8Rt9b_1687932111;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vm8Rt9b_1687932111)
          by smtp.aliyun-inc.com;
          Wed, 28 Jun 2023 14:01:51 +0800
Message-ID: <1687932052.6412272-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 03/10] virtio_ring: split: support add premapped buf
Date:   Wed, 28 Jun 2023 14:00:52 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEtFiutSpM--2agR1YhS0MxreH4vFFAEdCaC6E8qxyjZ4g@mail.gmail.com>
 <1687856491.8062844-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEsmxax+kOdQA=e4D_xT0WkTPRcooxRHNvsi6xpaV+8ahQ@mail.gmail.com>
In-Reply-To: <CACGkMEsmxax+kOdQA=e4D_xT0WkTPRcooxRHNvsi6xpaV+8ahQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 28 Jun 2023 12:07:10 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jun 27, 2023 at 5:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Tue, 27 Jun 2023 16:03:26 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Fri, Jun 2, 2023 at 5:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > > >
> > > > If the vq is the premapped mode, use the sg_dma_address() directly.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 46 ++++++++++++++++++++++----------=
----
> > > >  1 file changed, 28 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 2afdfb9e3e30..18212c3e056b 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -598,8 +598,12 @@ static inline int virtqueue_add_split(struct v=
irtqueue *_vq,
> > > >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > > >                         dma_addr_t addr;
> > > >
> > > > -                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE,=
 &addr))
> > > > -                               goto unmap_release;
> > > > +                       if (vq->premapped) {
> > > > +                               addr =3D sg_dma_address(sg);
> > > > +                       } else {
> > > > +                               if (vring_map_one_sg(vq, sg, DMA_TO=
_DEVICE, &addr))
> > > > +                                       goto unmap_release;
> > > > +                       }
> > >
> > > Btw, I wonder whether or not it would be simple to implement the
> > > vq->premapped check inside vring_map_one_sg() assuming the
> > > !use_dma_api is done there as well.
> >
> >
> > YES,
> >
> > That will more simple for the caller.
> >
> > But we will have things like:
> >
> > int func(bool do)
> > {
> > if (!do)
> >     return;
> > }
> >
> > I like this way, but you don't like it in last version.
>
> I see :)
>
> So I think it depends on the error handling path, we should choose a
> way that can let us easily deal with errors.
>
> For example, it seems the current approach is better since it doesn't
> need to change the unmap_release.

NO,

The unmap_release is same for two way.

Thanks.


>
> Thanks
>
> >
> > >
> > > >
> > > >                         prev =3D i;
> > > >                         /* Note that we trust indirect descriptor
> > > > @@ -614,8 +618,12 @@ static inline int virtqueue_add_split(struct v=
irtqueue *_vq,
> > > >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > > >                         dma_addr_t addr;
> > > >
> > > > -                       if (vring_map_one_sg(vq, sg, DMA_FROM_DEVIC=
E, &addr))
> > > > -                               goto unmap_release;
> > > > +                       if (vq->premapped) {
> > > > +                               addr =3D sg_dma_address(sg);
> > > > +                       } else {
> > > > +                               if (vring_map_one_sg(vq, sg, DMA_FR=
OM_DEVICE, &addr))
> > > > +                                       goto unmap_release;
> > > > +                       }
> > > >
> > > >                         prev =3D i;
> > > >                         /* Note that we trust indirect descriptor
> > > > @@ -689,21 +697,23 @@ static inline int virtqueue_add_split(struct =
virtqueue *_vq,
> > > >         return 0;
> > > >
> > > >  unmap_release:
> > > > -       err_idx =3D i;
> > > > +       if (!vq->premapped) {
> > >
> > > Can vq->premapped be true here? The label is named as "unmap_relase"
> > > which implies "map" beforehand which seems not the case for
> > > premapping.
> >
> > I see.
> >
> > Rethink about this, there is a better way.
> > I will fix in next version.
> >
> >
> > Thanks.
> >
> >
> > >
> > > Thanks
> > >
> > >
> > > > +               err_idx =3D i;
> > > >
> > > > -       if (indirect)
> > > > -               i =3D 0;
> > > > -       else
> > > > -               i =3D head;
> > > > -
> > > > -       for (n =3D 0; n < total_sg; n++) {
> > > > -               if (i =3D=3D err_idx)
> > > > -                       break;
> > > > -               if (indirect) {
> > > > -                       vring_unmap_one_split_indirect(vq, &desc[i]=
);
> > > > -                       i =3D virtio16_to_cpu(_vq->vdev, desc[i].ne=
xt);
> > > > -               } else
> > > > -                       i =3D vring_unmap_one_split(vq, i);
> > > > +               if (indirect)
> > > > +                       i =3D 0;
> > > > +               else
> > > > +                       i =3D head;
> > > > +
> > > > +               for (n =3D 0; n < total_sg; n++) {
> > > > +                       if (i =3D=3D err_idx)
> > > > +                               break;
> > > > +                       if (indirect) {
> > > > +                               vring_unmap_one_split_indirect(vq, =
&desc[i]);
> > > > +                               i =3D virtio16_to_cpu(_vq->vdev, de=
sc[i].next);
> > > > +                       } else
> > > > +                               i =3D vring_unmap_one_split(vq, i);
> > > > +               }
> > > >         }
> > > >
> > > >         if (indirect)
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > > >
> > >
> >
>
