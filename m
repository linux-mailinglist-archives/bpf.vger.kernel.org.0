Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B37856B2BE
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 08:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbiGHGYQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 02:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbiGHGYQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 02:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62AB22B1AF
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 23:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657261454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MuCsAQqcP9jRhnofNGlkag+3lFIM4NlF43nORVr9O9Q=;
        b=JiPKHAbXDIS89ar7ZF1+TW68z8+Dti80wKv6mCEdmKm0D4XjtLNBFO3Y5TG2VVAM4P5oeO
        snUaweIHbmnkri7pOar3+WviE9+4rIA5h2vIcf59DamjrOeqwBSLTWSEF0xu3jp7zUxX0u
        I5kKNYaOd/Y8Axx5NGQiUjiP9Ksz5gs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-s2F82xqgMM6srYMmbu5NhA-1; Fri, 08 Jul 2022 02:24:10 -0400
X-MC-Unique: s2F82xqgMM6srYMmbu5NhA-1
Received: by mail-lf1-f69.google.com with SMTP id f40-20020a0565123b2800b0048454c5aec2so3675595lfv.1
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 23:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MuCsAQqcP9jRhnofNGlkag+3lFIM4NlF43nORVr9O9Q=;
        b=zGbK27hvsV8dzAO1VsOxwXJvID8CYlM7bU6ugpHTtQMR7DqnJHm0hTXpSDm7fhIIPx
         1IGQ6zClopy2OsJ/ovHKL4nHfpt7ofZMildyuYj5t9fcLaPa3ifZ818sQ2eX57IpHNcP
         2csTwZlKoQDmVnQVgJg+AN+5G8+WF0m9UyCdv1Ia3hDkSuNXUI38+PUh14EEJdkXQifG
         ZHn6/0mLTkqDSCrMr3v8+JKIhQ8AcxzYQxLaDbtf6Oh87Yom0MZzhFQ5JpzTl2uFTVSq
         RmP/wzQKfNgf7pb65J7xZzpyFt2LWhwrEBHchJvmLakQccI7ZKwRmDA11gu43DcFazwC
         JlnQ==
X-Gm-Message-State: AJIora+EQUCm+ibK6XXtVjhP5O7iAJikyafCeaZIhaOjmaSdsntcRcPB
        D2K593I5KAUI3HAnRbFmGylBm7k2ossQ8Ku4evxjgLDe/pEcAsF5wpjXkB7vCKXnr7wVWAzYpR1
        qZd4thsEVMYWcfiYGZR6wFpl9AtIq
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id j3-20020a2eb703000000b0025a93d08a57mr1045823ljo.487.1657261448480;
        Thu, 07 Jul 2022 23:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tzPsP1k2g24mQnHNz5CBL+LS/XojwCfoJppvOK3luPVsAL9MMOxyPmQUAGDT4ZWM4iccKWwEJaWyc8djFVrqw=
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id
 j3-20020a2eb703000000b0025a93d08a57mr1045787ljo.487.1657261448283; Thu, 07
 Jul 2022 23:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-40-xuanzhuo@linux.alibaba.com> <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
 <1656986432.1164997-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1656986432.1164997-2-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 8 Jul 2022 14:23:57 +0800
Message-ID: <CACGkMEt8MSS=tcn=Hd6WF9+btT0ccocxEd1ighRgK-V1uiWmCQ@mail.gmail.com>
Subject: Re: [PATCH v11 39/40] virtio_net: support tx queue resize
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 5, 2022 at 10:01 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrot=
e:
>
> On Mon, 4 Jul 2022 11:45:52 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> >
> > =E5=9C=A8 2022/6/29 14:56, Xuan Zhuo =E5=86=99=E9=81=93:
> > > This patch implements the resize function of the tx queues.
> > > Based on this function, it is possible to modify the ring num of the
> > > queue.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >   drivers/net/virtio_net.c | 48 +++++++++++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 48 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 6ab16fd193e5..fd358462f802 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -135,6 +135,9 @@ struct send_queue {
> > >     struct virtnet_sq_stats stats;
> > >
> > >     struct napi_struct napi;
> > > +
> > > +   /* Record whether sq is in reset state. */
> > > +   bool reset;
> > >   };
> > >
> > >   /* Internal representation of a receive virtqueue */
> > > @@ -279,6 +282,7 @@ struct padded_vnet_hdr {
> > >   };
> > >
> > >   static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *=
buf);
> > > +static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *b=
uf);
> > >
> > >   static bool is_xdp_frame(void *ptr)
> > >   {
> > > @@ -1603,6 +1607,11 @@ static void virtnet_poll_cleantx(struct receiv=
e_queue *rq)
> > >             return;
> > >
> > >     if (__netif_tx_trylock(txq)) {
> > > +           if (READ_ONCE(sq->reset)) {
> > > +                   __netif_tx_unlock(txq);
> > > +                   return;
> > > +           }
> > > +
> > >             do {
> > >                     virtqueue_disable_cb(sq->vq);
> > >                     free_old_xmit_skbs(sq, true);
> > > @@ -1868,6 +1877,45 @@ static int virtnet_rx_resize(struct virtnet_in=
fo *vi,
> > >     return err;
> > >   }
> > >
> > > +static int virtnet_tx_resize(struct virtnet_info *vi,
> > > +                        struct send_queue *sq, u32 ring_num)
> > > +{
> > > +   struct netdev_queue *txq;
> > > +   int err, qindex;
> > > +
> > > +   qindex =3D sq - vi->sq;
> > > +
> > > +   virtnet_napi_tx_disable(&sq->napi);
> > > +
> > > +   txq =3D netdev_get_tx_queue(vi->dev, qindex);
> > > +
> > > +   /* 1. wait all ximt complete
> > > +    * 2. fix the race of netif_stop_subqueue() vs netif_start_subque=
ue()
> > > +    */
> > > +   __netif_tx_lock_bh(txq);
> > > +
> > > +   /* Prevent rx poll from accessing sq. */
> > > +   WRITE_ONCE(sq->reset, true);
> >
> >
> > Can we simply disable RX NAPI here?
>
> Disable rx napi is indeed a simple solution. But I hope that when dealing=
 with
> tx, it will not affect rx.

Ok, but I think we've already synchronized with tx lock here, isn't it?

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
> > > +   /* Prevent the upper layer from trying to send packets. */
> > > +   netif_stop_subqueue(vi->dev, qindex);
> > > +
> > > +   __netif_tx_unlock_bh(txq);
> > > +
> > > +   err =3D virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused=
_buf);
> > > +   if (err)
> > > +           netdev_err(vi->dev, "resize tx fail: tx queue index: %d e=
rr: %d\n", qindex, err);
> > > +
> > > +   /* Memory barrier before set reset and start subqueue. */
> > > +   smp_mb();
> > > +
> > > +   WRITE_ONCE(sq->reset, false);
> > > +   netif_tx_wake_queue(txq);
> > > +
> > > +   virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
> > > +   return err;
> > > +}
> > > +
> > >   /*
> > >    * Send command via the control virtqueue and check status.  Comman=
ds
> > >    * supported by the hypervisor, as indicated by feature bits, shoul=
d
> >
>

