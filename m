Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2781A740ADD
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 10:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjF1IMU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 04:12:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233887AbjF1IKS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Jun 2023 04:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687939767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZpZ6PoVWfkpUfuNjOlXwmJuKqxjPMv+yOZvIpQzOso=;
        b=ZBfatfnc9IKI3BlRSyDZZrcTNtE6pKKOkRNwnmKxDCObou3GOHFDyHrlmUIb5XLFUfyYB0
        fPdsmZBFv8UgWNuFvpRMhKcq4x55oYwJIgBmNDKKLim6Rwoz5DhSOQbLG2GESI9VC8Vk9W
        pUNV6hgbNkT4pQRN4oO1r/6y5iLS6T0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-7nLBvz07P1i55rvXrZ67gQ-1; Wed, 28 Jun 2023 00:07:23 -0400
X-MC-Unique: 7nLBvz07P1i55rvXrZ67gQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb89482c48so1224763e87.3
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 21:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687925242; x=1690517242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZpZ6PoVWfkpUfuNjOlXwmJuKqxjPMv+yOZvIpQzOso=;
        b=Pljt6mkrNwvOZAGxJXZ30B1aHXCYBM+GEvhdbGRiON38FCH09fgC8Dh90iVhHOpKh8
         wc3LrBqmIpcMbIbdFuvc6lrySp42rzsP2czyRwYOas5Bp56J0Omo9cFAPgXeByHuwlNx
         +babkstmOb8gFfcTeQcpl8ynXIFPg2iEyl+8nav7IuSUueOXJPzuNyW5HYGNgGheRRBQ
         qE1XqLp7x6YYGaGp2l2NR1ZwG2reH889MCAxrC8Kqk8OPPYqLVVRmmWvGsmfnArhL+wH
         onYUhhXOgg1rA20qRsWNz2/FqOKUGUMr27kCJ76rnpHDdG/oN8cwNXfSGcwCweT5Xdr1
         uZcg==
X-Gm-Message-State: AC+VfDzr/8rfm271w8cl24Fde+sxsuMGaEW5SV0c4aBpSLoYMVDte3xU
        aAT7YoI4xoiMPxMwRRIqpyUyOsGPuL6pNEKuKnJhdz9PkLup5Bajf4d2nZT6pv/DVUflUjQ1tGl
        L7SG8jlunHr6hPLaR6csW1i4+1lLc
X-Received: by 2002:a05:6512:2348:b0:4fb:7592:cc7a with SMTP id p8-20020a056512234800b004fb7592cc7amr6364678lfu.20.1687925242176;
        Tue, 27 Jun 2023 21:07:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hCTKWRmXZEpVs0DYgKad/Ul/B5vDH3+80UITOMrtYNREd0vSuAqCm4CbSBg4eNiR8SAwsYOxO/FVXJYEWXm8=
X-Received: by 2002:a05:6512:2348:b0:4fb:7592:cc7a with SMTP id
 p8-20020a056512234800b004fb7592cc7amr6364664lfu.20.1687925241866; Tue, 27 Jun
 2023 21:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-4-xuanzhuo@linux.alibaba.com> <CACGkMEtFiutSpM--2agR1YhS0MxreH4vFFAEdCaC6E8qxyjZ4g@mail.gmail.com>
 <1687856491.8062844-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687856491.8062844-5-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Jun 2023 12:07:10 +0800
Message-ID: <CACGkMEsmxax+kOdQA=e4D_xT0WkTPRcooxRHNvsi6xpaV+8ahQ@mail.gmail.com>
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

On Tue, Jun 27, 2023 at 5:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 27 Jun 2023 16:03:26 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Jun 2, 2023 at 5:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > >
> > > If the vq is the premapped mode, use the sg_dma_address() directly.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 46 ++++++++++++++++++++++------------=
--
> > >  1 file changed, 28 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 2afdfb9e3e30..18212c3e056b 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -598,8 +598,12 @@ static inline int virtqueue_add_split(struct vir=
tqueue *_vq,
> > >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > >                         dma_addr_t addr;
> > >
> > > -                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &=
addr))
> > > -                               goto unmap_release;
> > > +                       if (vq->premapped) {
> > > +                               addr =3D sg_dma_address(sg);
> > > +                       } else {
> > > +                               if (vring_map_one_sg(vq, sg, DMA_TO_D=
EVICE, &addr))
> > > +                                       goto unmap_release;
> > > +                       }
> >
> > Btw, I wonder whether or not it would be simple to implement the
> > vq->premapped check inside vring_map_one_sg() assuming the
> > !use_dma_api is done there as well.
>
>
> YES,
>
> That will more simple for the caller.
>
> But we will have things like:
>
> int func(bool do)
> {
> if (!do)
>     return;
> }
>
> I like this way, but you don't like it in last version.

I see :)

So I think it depends on the error handling path, we should choose a
way that can let us easily deal with errors.

For example, it seems the current approach is better since it doesn't
need to change the unmap_release.

Thanks

>
> >
> > >
> > >                         prev =3D i;
> > >                         /* Note that we trust indirect descriptor
> > > @@ -614,8 +618,12 @@ static inline int virtqueue_add_split(struct vir=
tqueue *_vq,
> > >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > >                         dma_addr_t addr;
> > >
> > > -                       if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE,=
 &addr))
> > > -                               goto unmap_release;
> > > +                       if (vq->premapped) {
> > > +                               addr =3D sg_dma_address(sg);
> > > +                       } else {
> > > +                               if (vring_map_one_sg(vq, sg, DMA_FROM=
_DEVICE, &addr))
> > > +                                       goto unmap_release;
> > > +                       }
> > >
> > >                         prev =3D i;
> > >                         /* Note that we trust indirect descriptor
> > > @@ -689,21 +697,23 @@ static inline int virtqueue_add_split(struct vi=
rtqueue *_vq,
> > >         return 0;
> > >
> > >  unmap_release:
> > > -       err_idx =3D i;
> > > +       if (!vq->premapped) {
> >
> > Can vq->premapped be true here? The label is named as "unmap_relase"
> > which implies "map" beforehand which seems not the case for
> > premapping.
>
> I see.
>
> Rethink about this, there is a better way.
> I will fix in next version.
>
>
> Thanks.
>
>
> >
> > Thanks
> >
> >
> > > +               err_idx =3D i;
> > >
> > > -       if (indirect)
> > > -               i =3D 0;
> > > -       else
> > > -               i =3D head;
> > > -
> > > -       for (n =3D 0; n < total_sg; n++) {
> > > -               if (i =3D=3D err_idx)
> > > -                       break;
> > > -               if (indirect) {
> > > -                       vring_unmap_one_split_indirect(vq, &desc[i]);
> > > -                       i =3D virtio16_to_cpu(_vq->vdev, desc[i].next=
);
> > > -               } else
> > > -                       i =3D vring_unmap_one_split(vq, i);
> > > +               if (indirect)
> > > +                       i =3D 0;
> > > +               else
> > > +                       i =3D head;
> > > +
> > > +               for (n =3D 0; n < total_sg; n++) {
> > > +                       if (i =3D=3D err_idx)
> > > +                               break;
> > > +                       if (indirect) {
> > > +                               vring_unmap_one_split_indirect(vq, &d=
esc[i]);
> > > +                               i =3D virtio16_to_cpu(_vq->vdev, desc=
[i].next);
> > > +                       } else
> > > +                               i =3D vring_unmap_one_split(vq, i);
> > > +               }
> > >         }
> > >
> > >         if (indirect)
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>

