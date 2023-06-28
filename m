Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3470740C80
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjF1JSU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 05:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233249AbjF1IxM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Jun 2023 04:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687942326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=su9PvChmWiVRJcH0aNEvF2GH7iXfYZGfbrKz513TiwY=;
        b=LBG6EHfMvK17vszyEaSMLJ5djXTd477VikidfAJCa0f2lHIbaeXkqdK3FmWk3lQRp4n9JN
        jQI63PAnO+u1H494laDu7K6r5bbt/tqmlbwkTKRjIcRg9Bs/ATAZOdIcE738O83Kkl/pIx
        yiYhEpnRHNEda1aIkgMnOxo4GHYSbhk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-xxPPYTKFMq-gt22R48zaeQ-1; Wed, 28 Jun 2023 02:51:21 -0400
X-MC-Unique: xxPPYTKFMq-gt22R48zaeQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4edc7406cbaso4181757e87.2
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 23:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687935080; x=1690527080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=su9PvChmWiVRJcH0aNEvF2GH7iXfYZGfbrKz513TiwY=;
        b=gnDCQNIYSnZY/DwiFjyc2HUyPzJPVyWmjBY/e7wU92iQKQPuDP/iHkDQKOvxjq+DW3
         xJ1DCWMVRmY5iAurfjeE9QSVZTi7tIVrhiyM4btmsf8t2vxxPm/7xOXMY+L4O0WFSpT/
         BNKu96a3gfAUy4/bJbaLITaLSlmQ+bg1y+VU79PgCGDSLtjP3UH706I+mnkIOg+ud/gM
         Ry2UJOjbDnw9YXN4T4RADTZDB+6c7Bq8VuofO0HSA6xfXdW9cUq33m5Q4QqLZJvToLla
         7ShoQK7yBEkhmYtjLB8eg/sAA/lv+7UeZ836f+jaHdSrvMmY+R/5Ha1G61JayDLdAf1V
         wqcw==
X-Gm-Message-State: AC+VfDwKByYUUQamCoqZP7jr27/AFEH13cs82W4pze5zYCWOkDUGOfe7
        nGOHj4NkjZoTzn/c71qmaiUZMei/8khzXs9nUfKdeyt8JlJA50hvqneV0IPB2M7XJDtklydBuBC
        Nw6SEfFSWstqEzh+hKqEoGQ+993PV
X-Received: by 2002:a19:ca58:0:b0:4f8:b349:6938 with SMTP id h24-20020a19ca58000000b004f8b3496938mr12994475lfj.65.1687935080148;
        Tue, 27 Jun 2023 23:51:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7mv/3o+OYScVrxaKdO8aw/adM4SivgvUgQcZTOZQ3rB1LnCfP7sgXl+EWa854Ej82KZ6RtMTKkjSWEuj6scx8=
X-Received: by 2002:a19:ca58:0:b0:4f8:b349:6938 with SMTP id
 h24-20020a19ca58000000b004f8b3496938mr12994457lfj.65.1687935079753; Tue, 27
 Jun 2023 23:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-4-xuanzhuo@linux.alibaba.com> <CACGkMEtFiutSpM--2agR1YhS0MxreH4vFFAEdCaC6E8qxyjZ4g@mail.gmail.com>
 <1687856491.8062844-5-xuanzhuo@linux.alibaba.com> <CACGkMEsmxax+kOdQA=e4D_xT0WkTPRcooxRHNvsi6xpaV+8ahQ@mail.gmail.com>
 <1687932052.6412272-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687932052.6412272-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Jun 2023 14:51:08 +0800
Message-ID: <CACGkMEumhkBShqXXbWXviS+xZA1aYrnZFoU_avdsWZ_9sBAwUQ@mail.gmail.com>
Subject: Re: [PATCH vhost v10 03/10] virtio_ring: split: support add premapped buf
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 28, 2023 at 2:02=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 28 Jun 2023 12:07:10 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Jun 27, 2023 at 5:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Tue, 27 Jun 2023 16:03:26 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Fri, Jun 2, 2023 at 5:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > > >
> > > > > If the vq is the premapped mode, use the sg_dma_address() directl=
y.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 46 ++++++++++++++++++++++--------=
------
> > > > >  1 file changed, 28 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio=
_ring.c
> > > > > index 2afdfb9e3e30..18212c3e056b 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -598,8 +598,12 @@ static inline int virtqueue_add_split(struct=
 virtqueue *_vq,
> > > > >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > > > >                         dma_addr_t addr;
> > > > >
> > > > > -                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVIC=
E, &addr))
> > > > > -                               goto unmap_release;
> > > > > +                       if (vq->premapped) {
> > > > > +                               addr =3D sg_dma_address(sg);
> > > > > +                       } else {
> > > > > +                               if (vring_map_one_sg(vq, sg, DMA_=
TO_DEVICE, &addr))
> > > > > +                                       goto unmap_release;
> > > > > +                       }
> > > >
> > > > Btw, I wonder whether or not it would be simple to implement the
> > > > vq->premapped check inside vring_map_one_sg() assuming the
> > > > !use_dma_api is done there as well.
> > >
> > >
> > > YES,
> > >
> > > That will more simple for the caller.
> > >
> > > But we will have things like:
> > >
> > > int func(bool do)
> > > {
> > > if (!do)
> > >     return;
> > > }
> > >
> > > I like this way, but you don't like it in last version.
> >
> > I see :)
> >
> > So I think it depends on the error handling path, we should choose a
> > way that can let us easily deal with errors.
> >
> > For example, it seems the current approach is better since it doesn't
> > need to change the unmap_release.
>
> NO,
>
> The unmap_release is same for two way.
>
> Thanks.

Ok, so either is fine for me.

Thanks

>
>
> >
> > Thanks
> >
> > >
> > > >
> > > > >
> > > > >                         prev =3D i;
> > > > >                         /* Note that we trust indirect descriptor
> > > > > @@ -614,8 +618,12 @@ static inline int virtqueue_add_split(struct=
 virtqueue *_vq,
> > > > >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > > > >                         dma_addr_t addr;
> > > > >
> > > > > -                       if (vring_map_one_sg(vq, sg, DMA_FROM_DEV=
ICE, &addr))
> > > > > -                               goto unmap_release;
> > > > > +                       if (vq->premapped) {
> > > > > +                               addr =3D sg_dma_address(sg);
> > > > > +                       } else {
> > > > > +                               if (vring_map_one_sg(vq, sg, DMA_=
FROM_DEVICE, &addr))
> > > > > +                                       goto unmap_release;
> > > > > +                       }
> > > > >
> > > > >                         prev =3D i;
> > > > >                         /* Note that we trust indirect descriptor
> > > > > @@ -689,21 +697,23 @@ static inline int virtqueue_add_split(struc=
t virtqueue *_vq,
> > > > >         return 0;
> > > > >
> > > > >  unmap_release:
> > > > > -       err_idx =3D i;
> > > > > +       if (!vq->premapped) {
> > > >
> > > > Can vq->premapped be true here? The label is named as "unmap_relase=
"
> > > > which implies "map" beforehand which seems not the case for
> > > > premapping.
> > >
> > > I see.
> > >
> > > Rethink about this, there is a better way.
> > > I will fix in next version.
> > >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > > > > +               err_idx =3D i;
> > > > >
> > > > > -       if (indirect)
> > > > > -               i =3D 0;
> > > > > -       else
> > > > > -               i =3D head;
> > > > > -
> > > > > -       for (n =3D 0; n < total_sg; n++) {
> > > > > -               if (i =3D=3D err_idx)
> > > > > -                       break;
> > > > > -               if (indirect) {
> > > > > -                       vring_unmap_one_split_indirect(vq, &desc[=
i]);
> > > > > -                       i =3D virtio16_to_cpu(_vq->vdev, desc[i].=
next);
> > > > > -               } else
> > > > > -                       i =3D vring_unmap_one_split(vq, i);
> > > > > +               if (indirect)
> > > > > +                       i =3D 0;
> > > > > +               else
> > > > > +                       i =3D head;
> > > > > +
> > > > > +               for (n =3D 0; n < total_sg; n++) {
> > > > > +                       if (i =3D=3D err_idx)
> > > > > +                               break;
> > > > > +                       if (indirect) {
> > > > > +                               vring_unmap_one_split_indirect(vq=
, &desc[i]);
> > > > > +                               i =3D virtio16_to_cpu(_vq->vdev, =
desc[i].next);
> > > > > +                       } else
> > > > > +                               i =3D vring_unmap_one_split(vq, i=
);
> > > > > +               }
> > > > >         }
> > > > >
> > > > >         if (indirect)
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > > >
> > > >
> > >
> >
>

