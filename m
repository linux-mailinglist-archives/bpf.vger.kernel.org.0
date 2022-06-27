Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFD355C8C6
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 14:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiF0IOk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 04:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiF0IOh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 04:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2560F626F
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 01:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656317674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pajM9hI9fI/87uBaTeYfHZ+TkaK2uNfPmDfKI6EwRtM=;
        b=FtuCsPNfd8nsFVdGEecEd7VnwxVIM9qXD3l7VYYXR0uc3/eQy2zNg8IiLOcfvl36r6kepq
        wnr9/zWXOOODh4FPLl7Z/ILl32QLWKJ6nFzzOWNHEKTA8tf7qntqKhpwuPi+U7m/EV3cB/
        hPRmQh7gVuRlEC36+695jCs2+ecUWBc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-vBQ23a1AOBuLgbT7XhX7xw-1; Mon, 27 Jun 2022 04:14:33 -0400
X-MC-Unique: vBQ23a1AOBuLgbT7XhX7xw-1
Received: by mail-lj1-f197.google.com with SMTP id m8-20020a2eb6c8000000b0025aa0530107so782751ljo.6
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 01:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pajM9hI9fI/87uBaTeYfHZ+TkaK2uNfPmDfKI6EwRtM=;
        b=Ozpkg01i6/22vDCxK8tKoAy5SodhhP+tQ2hQ9gcRSL8a85MNse8T4IICUBOV+S5QHA
         8mho116sV11lP5gM8HzYaeHTF/Xu34OAYrA6yEKkcimc+mFiKcJl7QMWTVkLh/P71ulV
         BZpDmV/HcFj141EBy3vmzisem+33442lK6KXyYlmKGCPNVHp9xtEA6BbQP9/DzzUr+6j
         OWdq/iE70pVg7XXpRXWRx/fSOoiTO3R7mOjZ0V2cFqjOUxMqSONzcAN4XRMn+tX0p91G
         7ZI396TQGiKrWI/3xeBk84mRHHkmXgoViPOz4XbPgMsXTHa4HMFK7R5ahC7zCe3q3u8D
         ipoQ==
X-Gm-Message-State: AJIora94fcici4O9ZthIn3ojE4r4d2mmpGaVxcYeKj6Cnh+SXIS7IF7E
        VozWMybAkCJfxuGW9mLOZ4tnlaBVRerSEW0Dmlgrdemyz1TS/YM9fxi91N1bGoO6ALLtmRc5sLu
        dFm91V84UTtYa+preugvpLtvhgDDj
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id y15-20020a0565123f0f00b0047f6f890326mr7309030lfa.124.1656317672142;
        Mon, 27 Jun 2022 01:14:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1stSWl4OiPqPtvMuSHVstpPhV2ncpnK2QP/uZDvpStVqiSUc6+7r6HgRqJbkG0p8fApLKYURBWKalbv9dZOpEk=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr7309001lfa.124.1656317671894; Mon, 27
 Jun 2022 01:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com> <20220624025817-mutt-send-email-mst@kernel.org>
 <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com>
 <20220627023841-mutt-send-email-mst@kernel.org> <CACGkMEvy8xF2T_vubKeUEPC2aroO_fbB0Xe8nnxK4OBUgAS+Gw@mail.gmail.com>
 <20220627034733-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220627034733-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 27 Jun 2022 16:14:20 +0800
Message-ID: <CACGkMEtpjUBaUML=fEs5hR66rzNTBhBXOmfpzyXV1F-6BqvsGg@mail.gmail.com>
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
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
        kangjie.xu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 27, 2022 at 3:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 27, 2022 at 03:45:30PM +0800, Jason Wang wrote:
> > On Mon, Jun 27, 2022 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> > > > On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > > > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > > > >
> > > > > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> > > > >
> > > > > What exactly is meant by not breaking uABI?
> > > > > Users are supposed to be prepared for struct size to change ... no?
> > > >
> > > > Not sure, any doc for this?
> > > >
> > > > Thanks
> > >
> > >
> > > Well we have this:
> > >
> > >         The drivers SHOULD only map part of configuration structure
> > >         large enough for device operation.  The drivers MUST handle
> > >         an unexpectedly large \field{length}, but MAY check that \field{length}
> > >         is large enough for device operation.
> >
> > Yes, but that's the device/driver interface. What's done here is the
> > userspace/kernel.
> >
> > Userspace may break if it uses e.g sizeof(struct virtio_pci_common_cfg)?
> >
> > Thanks
>
> Hmm I guess there's risk... but then how are we going to maintain this
> going forward?  Add a new struct on any change?

This is the way we have used it for the past 5 or more years. I don't
see why this must be handled in the vq reset feature.

>Can we at least
> prevent this going forward somehow?

Like have some padding?

Thanks

>
>
> > >
> > >
> > >
> > > >
> > > > >
> > > > >
> > > > > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > > > > this patch first.
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > > > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > > > > --- a/include/uapi/linux/virtio_pci.h
> > > > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > > > > >       __le32 queue_used_hi;           /* read-write */
> > > > > >  };
> > > > > >
> > > > > > +struct virtio_pci_common_cfg_notify {
> > > > > > +     struct virtio_pci_common_cfg cfg;
> > > > > > +
> > > > > > +     __le16 queue_notify_data;       /* read-write */
> > > > > > +     __le16 padding;
> > > > > > +};
> > > > > > +
> > > > > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > > > >  struct virtio_pci_cfg_cap {
> > > > > >       struct virtio_pci_cap cap;
> > > > > > --
> > > > > > 2.31.0
> > > > >
> > >
>

