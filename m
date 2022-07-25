Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9A57FA3F
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 09:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiGYH3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 03:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiGYH3M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 03:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2DA61209C
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 00:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658734150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7V73Urf85bEAl0pJImVws1FSD2o2Nh9wuLCajEhv1dQ=;
        b=UuhvzleC7C3ZwDyuYvwUb9V7eyomBOsXr1mDMqFp8kk/KFG6dxtHz+vmvotfa/Mt+Ob0ku
        2KefS7nicYLQXzKoF6Cl368vhyH5IxMWSlxqMtxh+0lDtC6KrXZ78EHFmfBUbe2j5NR+3S
        03xqqwdjI89HNx4FzVyQ9dV07zAFLXQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-20C75tPmMB2NZClP240s8Q-1; Mon, 25 Jul 2022 03:29:08 -0400
X-MC-Unique: 20C75tPmMB2NZClP240s8Q-1
Received: by mail-lj1-f198.google.com with SMTP id u17-20020a05651c131100b0025dd81cd89cso2193750lja.23
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 00:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7V73Urf85bEAl0pJImVws1FSD2o2Nh9wuLCajEhv1dQ=;
        b=grTe1+zpoApfeRUk0Ev5v3Hiie0k1Kp23Z0bbVv6yeJhln2ufAhx1UOcwMgG0wD5OR
         EXsOnWi7KRS6Gnhd/BJrEYOYGGhAM5IcSxUsWJON5NyMSs3OJZ3nNQ2RI0cYd1PLgpXN
         ME0i4MWdNvpI8xC32upWpFsiD0DwYnGKjNzzjOyngvf0dL86Dt5q2BVW1qtgypjITh6G
         u35RJjy9Qe6Kofpil7ZKj5abMsMecWh7IwYJl2nK/FMyAo5efYPSxE5OfIuW+fBBXWGQ
         3/ZjhfcoMZ+ph+8iFtfKgi63YuxgxLViTkQitgE5C8EwRXPV0hqrZCofuVxP2xxhERR7
         CJ2w==
X-Gm-Message-State: AJIora901nECwpQHg6gn64dgex5JHaccL7jj0+NSuOp3rjGa0yCRiBuI
        YqdsNt+FTjgQRGiiqoWl2JJsxYVF5FK/ARb6eMPmyoAyXbQ/HfReqyyc7oYYCns6p+qPPgFbOep
        T2iXA2fwJ9vwqK2JRaAri+Vy182bK
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id y14-20020a0565123f0e00b0048a5edd99b2mr3893765lfa.124.1658734147153;
        Mon, 25 Jul 2022 00:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vSilpMwka+2TIjWzkO9OCXsrSScPIWOm9X8cfPvK1yqV+F7/YxylSd832Ayyg4Jn4Euf9+iYQrDan3aN009eg=
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr3893759lfa.124.1658734146714; Mon, 25
 Jul 2022 00:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-39-xuanzhuo@linux.alibaba.com> <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
 <1658731116.1695666-1-xuanzhuo@linux.alibaba.com> <CACGkMEvsAyR5uRprobv-bQYPOKKOM4sZzQ-Vw5ZiETMjiCkdRQ@mail.gmail.com>
 <1658733700.3892667-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1658733700.3892667-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 25 Jul 2022 15:28:55 +0800
Message-ID: <CACGkMEvsS_QVbq3iCG8hvHuKrp9ObTy3jPUn75zPk-bSHd7tzA@mail.gmail.com>
Subject: Re: [PATCH v12 38/40] virtio_net: support rx queue resize
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
        Kangjie Xu <kangjie.xu@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 25, 2022 at 3:23 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrot=
e:
>
> On Mon, 25 Jul 2022 14:57:11 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Jul 25, 2022 at 2:43 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> =
wrote:
> > >
> > > On Thu, 21 Jul 2022 17:25:59 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > >
> > > > =E5=9C=A8 2022/7/20 11:04, Xuan Zhuo =E5=86=99=E9=81=93:
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
> > > > > index fe4dc43c05a1..1115a8b59a08 100644
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
> > > > We need to disable refill work as well. So this series might need
> > > > rebasing on top of
> > > >
> > > > https://lore.kernel.org/netdev/20220704074859.16912-1-jasowang@redh=
at.com/
> > >
> > > I understand that your patch is used to solve the situation where dev=
 is
> > > destoryed but refill work is running.
> > >
> > > And is there such a possibility here?
> >
> > E.g the refill work runs in parallel with this function?
>
> napi_disable enables lock-like functionality. So I think it's safe.
>

Ok, right, since there will be a napi_enable() soon afterwards.

So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> Thanks.
>
> >
> > Thanks
> >
> > > Or is there any other scenario that I'm
> > > not expecting?
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > I will send a new version (probably tomorrow).
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

