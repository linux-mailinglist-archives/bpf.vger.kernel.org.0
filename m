Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3E5577E12
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiGRI4r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 04:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiGRI4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 04:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55752EE12
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 01:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658134600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OWEVZ0lWemvnjJGr1KMJVEu33/f4lcOHck1LBmLT0x4=;
        b=UFKCqPMRqlKU6maki4i505+1YW6HkM2/VaCogKPkgZEmtclhYMBnjg+D/789Dbd78bti6F
        3ixntv7KHAv2Ovn3V9Odf0lfWyZyRoRfGkeGzEneQQr9RM89zVJYQg+JT/DfD9bwB1sXg9
        PHagmXqDR8LCzoDfj8GrPx+CcQigRdE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-3B4Osfl5PmCJ8bi2r0lN8w-1; Mon, 18 Jul 2022 04:56:37 -0400
X-MC-Unique: 3B4Osfl5PmCJ8bi2r0lN8w-1
Received: by mail-lf1-f72.google.com with SMTP id z1-20020a195041000000b00489cc321e11so4069616lfj.23
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 01:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OWEVZ0lWemvnjJGr1KMJVEu33/f4lcOHck1LBmLT0x4=;
        b=uMgm68ous51dW7wTtjZHH8BW96+3SQjEPEqwyyNPnvJA5B0p1ypAO4ny9Kq+DVSPAT
         OBOGuKU1fKmJlE6a/9Z3qudtAY0EqPT+9y8YCnkEmgXZ9Y2RfJ/HE+v8BOCRqJiYJgdZ
         PSavVY5Tvqhp2oJKKh+Tsg3rF5rrJzJZKX3Iy6PepFPruSYq/sGyy95DDR867ysH2I2A
         E2rpilyGlxZFBfHVgco8P9g9X5Z02XV97ADViSoqzMMQLHGl48x34PPp+kBIwf/SP8vB
         EdOx+q/pp1k4eXwI0YcGwXuRLhEQnNXdg6JgwzNX7a7v6R8zc/Sw8C5fTAYZZE4a2f6k
         uc/A==
X-Gm-Message-State: AJIora/zSDs/RfenzmF4Fo48gBEBM5uis8OZ9hznqyYUx0MxamQOyOIT
        S2q0XHmvNp1rfybH91n/xxbFeT7uHw1nhCzRoiv5O5Ar8hs+X8CCbZVe+WWcZy7i/vJZWOYqL+u
        KAyFd94sZ3nE4RwHMPvMksHprUbxK
X-Received: by 2002:ac2:4c4c:0:b0:489:fe2c:c877 with SMTP id o12-20020ac24c4c000000b00489fe2cc877mr15771578lfk.238.1658134595383;
        Mon, 18 Jul 2022 01:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uT17stmgD/4/ICa/9NkCqW44+T43NZzTbYZlFnn5f6GksCmVOwfYnKSj/DtJ2DugQNpv1qMO4BpXj9dv3Brrw=
X-Received: by 2002:ac2:4c4c:0:b0:489:fe2c:c877 with SMTP id
 o12-20020ac24c4c000000b00489fe2cc877mr15771561lfk.238.1658134595164; Mon, 18
 Jul 2022 01:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com> <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
 <1656986375.3420787-1-xuanzhuo@linux.alibaba.com> <CACGkMEu80KP-ULz_CBvauRk_3XsCubMkkWv0uLnbt-wib5KOnA@mail.gmail.com>
 <1657874178.9766078-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1657874178.9766078-2-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 18 Jul 2022 16:56:24 +0800
Message-ID: <CACGkMEtF5NSXh-=nnsniLqy0pX2Tpyh413S5Bu5vZ6h=d+aHTA@mail.gmail.com>
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm <kvm@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
        kangjie.xu@linux.alibaba.com,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 15, 2022 at 4:37 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrot=
e:
>
> On Fri, 8 Jul 2022 14:20:52 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Tue, Jul 5, 2022 at 10:00 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> =
wrote:
> > >
> > > On Mon, 4 Jul 2022 11:44:12 +0800, Jason Wang <jasowang@redhat.com> w=
rote:
> > > >
> > > > =E5=9C=A8 2022/6/29 14:56, Xuan Zhuo =E5=86=99=E9=81=93:
> > > > > This patch implements the resize function of the rx queues.
> > > > > Based on this function, it is possible to modify the ring num of =
the
> > > > > queue.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >   drivers/net/virtio_net.c | 22 ++++++++++++++++++++++
> > > > >   1 file changed, 22 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 9fe222a3663a..6ab16fd193e5 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -278,6 +278,8 @@ struct padded_vnet_hdr {
> > > > >     char padding[12];
> > > > >   };
> > > > >
> > > > > +static void virtnet_rq_free_unused_buf(struct virtqueue *vq, voi=
d *buf);
> > > > > +
> > > > >   static bool is_xdp_frame(void *ptr)
> > > > >   {
> > > > >     return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> > > > > @@ -1846,6 +1848,26 @@ static netdev_tx_t start_xmit(struct sk_bu=
ff *skb, struct net_device *dev)
> > > > >     return NETDEV_TX_OK;
> > > > >   }
> > > > >
> > > > > +static int virtnet_rx_resize(struct virtnet_info *vi,
> > > > > +                        struct receive_queue *rq, u32 ring_num)
> > > > > +{
> > > > > +   int err, qindex;
> > > > > +
> > > > > +   qindex =3D rq - vi->rq;
> > > > > +
> > > > > +   napi_disable(&rq->napi);
> > > >
> > > >
> > > > Do we need to cancel the refill work here?
> > >
> > >
> > > I think no, napi_disable is mutually exclusive, which ensures that th=
ere will be
> > > no conflicts between them.
> >
> > So this sounds similar to what I've fixed recently.
> >
> > 1) NAPI schedule delayed work.
> > 2) we disable NAPI here
> > 3) delayed work get schedule and call NAPI again
> >
> > ?
>
> Yes, but I don't think there are any negative effects.

An infinite wait on the napi_disable()?

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > > > > +
> > > > > +   err =3D virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_un=
used_buf);
> > > > > +   if (err)
> > > > > +           netdev_err(vi->dev, "resize rx fail: rx queue index: =
%d err: %d\n", qindex, err);
> > > > > +
> > > > > +   if (!try_fill_recv(vi, rq, GFP_KERNEL))
> > > > > +           schedule_delayed_work(&vi->refill, 0);
> > > > > +
> > > > > +   virtnet_napi_enable(rq->vq, &rq->napi);
> > > > > +   return err;
> > > > > +}
> > > > > +
> > > > >   /*
> > > > >    * Send command via the control virtqueue and check status.  Co=
mmands
> > > > >    * supported by the hypervisor, as indicated by feature bits, s=
hould
> > > >
> > >
> >
>

