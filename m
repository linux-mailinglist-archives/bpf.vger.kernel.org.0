Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E219A500991
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 11:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbiDNJV2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 05:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbiDNJVY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 05:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34F8F52E65
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 02:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649927939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJfqPahZeiTk1PNwWhxutR1fdSWZNJKRpTJ6ssfKLRw=;
        b=eMTMEK1K9wtXWf0jem7/J157hOf+hi+yawDi36RA1/16y5fKPyBz8g1jFc8o//AIMaMr1+
        yB/h84oQbPvyWjg7TNU4NKbV0EqXOOkFbFpIHHzlFcERRbiGm5tWTWfgRg7b2ul6NsEzh2
        MymVt7RQNdJ2sFFX6hWJqkDT5F1Tcm0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-NNor1Im_MP61RDW2QqneZA-1; Thu, 14 Apr 2022 05:18:57 -0400
X-MC-Unique: NNor1Im_MP61RDW2QqneZA-1
Received: by mail-lf1-f72.google.com with SMTP id m3-20020a0565120a8300b0046b9e41a663so2087951lfu.3
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 02:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sJfqPahZeiTk1PNwWhxutR1fdSWZNJKRpTJ6ssfKLRw=;
        b=uo9OhRNSw7ed5RSDUKlgLyduKx/LKgeORdllpi8VlUfzTIFQ/gCfOQXq8FXZY9YBb7
         sou3eU1i8y6aFW/1fk+lL13Fp5Xtb+sPGSBnhXSseeDWzmF6xfXLxXD0Ex84kmHSe2/l
         Rvd915ql7alijq+fv/ZbHnBDJKiDKeC+2IKq1MxeqbjCqe/9eGSNtZa5MBA4n8Bw2+dK
         yVgNmh63ydxIIUU0waW+y6xArAK2UjJJybJ71zQ5tvHj/vdSj40VZnFG5Kbo2CoG64FN
         dFyMTBHATXP/tpSw3Fn0E3eVoIEA8X/j6UBYBlytiaLO1BLQff470MxAZrUVafLmQ0oN
         fpCg==
X-Gm-Message-State: AOAM533BLKMR84dxIiy12epUn+qxxEGy+P6dFr+2k0kjipfth4HWmbb6
        IRKpl8CF5DzKNFPlB8CfP+UHrO7qXtMsHBf8ulXM98eoDwFFKuZTM51aB43/vtfh0cyuD7SsP/n
        FShnkUhndKxVZMnReC/psZo8XLN2V
X-Received: by 2002:a2e:9d06:0:b0:24c:7dee:4d58 with SMTP id t6-20020a2e9d06000000b0024c7dee4d58mr1094352lji.177.1649927936443;
        Thu, 14 Apr 2022 02:18:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKBYYLPyYh4rIV0O9pHFa2HW5c1lmiy1wx80UMeUS3XhqO2fkzHNVGe3v4nkVgcVO7Mvlc9uQ1U+LXwGtF0zk=
X-Received: by 2002:a2e:9d06:0:b0:24c:7dee:4d58 with SMTP id
 t6-20020a2e9d06000000b0024c7dee4d58mr1094324lji.177.1649927936181; Thu, 14
 Apr 2022 02:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-13-xuanzhuo@linux.alibaba.com> <4da7b8dc-74ca-fc1b-fbdb-21f9943e8d45@redhat.com>
 <1649820210.3432868-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1649820210.3432868-4-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 14 Apr 2022 17:18:45 +0800
Message-ID: <CACGkMEv2qHLLqtc1uwObZFdRhaCNRMyTQ5qnvF02Yj8cKgV-8g@mail.gmail.com>
Subject: Re: [PATCH v9 12/32] virtio_ring: packed: extract the logic of alloc queue
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm <kvm@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 13, 2022 at 11:26 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wro=
te:
>
> On Tue, 12 Apr 2022 14:28:24 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> >
> > =E5=9C=A8 2022/4/6 =E4=B8=8A=E5=8D=8811:43, Xuan Zhuo =E5=86=99=E9=81=
=93:
> > > Separate the logic of packed to create vring queue.
> > >
> > > For the convenience of passing parameters, add a structure
> > > vring_packed.
> > >
> > > This feature is required for subsequent virtuqueue reset vring.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >   drivers/virtio/virtio_ring.c | 70 ++++++++++++++++++++++++++++-----=
---
> > >   1 file changed, 56 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 33864134a744..ea451ae2aaef 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1817,19 +1817,17 @@ static struct vring_desc_extra *vring_alloc_d=
esc_extra(unsigned int num)
> > >     return desc_extra;
> > >   }
> > >
> > > -static struct virtqueue *vring_create_virtqueue_packed(
> > > -   unsigned int index,
> > > -   unsigned int num,
> > > -   unsigned int vring_align,
> > > -   struct virtio_device *vdev,
> > > -   bool weak_barriers,
> > > -   bool may_reduce_num,
> > > -   bool context,
> > > -   bool (*notify)(struct virtqueue *),
> > > -   void (*callback)(struct virtqueue *),
> > > -   const char *name)
> > > +static int vring_alloc_queue_packed(struct virtio_device *vdev,
> > > +                               u32 num,
> > > +                               struct vring_packed_desc **_ring,
> > > +                               struct vring_packed_desc_event **_dri=
ver,
> > > +                               struct vring_packed_desc_event **_dev=
ice,
> > > +                               dma_addr_t *_ring_dma_addr,
> > > +                               dma_addr_t *_driver_event_dma_addr,
> > > +                               dma_addr_t *_device_event_dma_addr,
> > > +                               size_t *_ring_size_in_bytes,
> > > +                               size_t *_event_size_in_bytes)
> > >   {
> > > -   struct vring_virtqueue *vq;
> > >     struct vring_packed_desc *ring;
> > >     struct vring_packed_desc_event *driver, *device;
> > >     dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma=
_addr;
> > > @@ -1857,6 +1855,52 @@ static struct virtqueue *vring_create_virtqueu=
e_packed(
> > >     if (!device)
> > >             goto err_device;
> > >
> > > +   *_ring                   =3D ring;
> > > +   *_driver                 =3D driver;
> > > +   *_device                 =3D device;
> > > +   *_ring_dma_addr          =3D ring_dma_addr;
> > > +   *_driver_event_dma_addr  =3D driver_event_dma_addr;
> > > +   *_device_event_dma_addr  =3D device_event_dma_addr;
> > > +   *_ring_size_in_bytes     =3D ring_size_in_bytes;
> > > +   *_event_size_in_bytes    =3D event_size_in_bytes;
> >
> >
> > I wonder if we can simply factor out split and packed from struct
> > vring_virtqueue:
> >
> > struct vring_virtqueue {
> >      union {
> >          struct {} split;
> >          struct {} packed;
> >      };
> > };
> >
> > to
> >
> > struct vring_virtqueue_split {};
> > struct vring_virtqueue_packed {};
> >
> > Then we can do things like:
> >
> > vring_create_virtqueue_packed(struct virtio_device *vdev, u32 num,
> > struct vring_virtqueue_packed *packed);
> >
> > and
> >
> > vring_vritqueue_attach_packed(struct vring_virtqueue *vq, struct
> > vring_virtqueue_packed packed);
>
> This idea is very similar to my previous idea, just without introducing a=
 new
> structure.

Yes, it's better to not introduce new structures if it's possible.

>
> I'd be more than happy to revise this.

Good to know this.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> >
> > > +
> > > +   return 0;
> > > +
> > > +err_device:
> > > +   vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_=
dma_addr);
> > > +
> > > +err_driver:
> > > +   vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
> > > +
> > > +err_ring:
> > > +   return -ENOMEM;
> > > +}
> > > +
> > > +static struct virtqueue *vring_create_virtqueue_packed(
> > > +   unsigned int index,
> > > +   unsigned int num,
> > > +   unsigned int vring_align,
> > > +   struct virtio_device *vdev,
> > > +   bool weak_barriers,
> > > +   bool may_reduce_num,
> > > +   bool context,
> > > +   bool (*notify)(struct virtqueue *),
> > > +   void (*callback)(struct virtqueue *),
> > > +   const char *name)
> > > +{
> > > +   dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma=
_addr;
> > > +   struct vring_packed_desc_event *driver, *device;
> > > +   size_t ring_size_in_bytes, event_size_in_bytes;
> > > +   struct vring_packed_desc *ring;
> > > +   struct vring_virtqueue *vq;
> > > +
> > > +   if (vring_alloc_queue_packed(vdev, num, &ring, &driver, &device,
> > > +                                &ring_dma_addr, &driver_event_dma_ad=
dr,
> > > +                                &device_event_dma_addr,
> > > +                                &ring_size_in_bytes,
> > > +                                &event_size_in_bytes))
> > > +           goto err_ring;
> > > +
> > >     vq =3D kmalloc(sizeof(*vq), GFP_KERNEL);
> > >     if (!vq)
> > >             goto err_vq;
> > > @@ -1939,9 +1983,7 @@ static struct virtqueue *vring_create_virtqueue=
_packed(
> > >     kfree(vq);
> > >   err_vq:
> > >     vring_free_queue(vdev, event_size_in_bytes, device, device_event_=
dma_addr);
> > > -err_device:
> > >     vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_=
dma_addr);
> > > -err_driver:
> > >     vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
> > >   err_ring:
> > >     return NULL;
> >
>

