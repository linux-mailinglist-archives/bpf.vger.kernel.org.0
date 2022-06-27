Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACD655E02E
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbiF0L65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 07:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239523AbiF0L5s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 07:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F22F7BE04
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 04:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656330813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4iA+zJThegEvaay5X9bkB6r2mlx5a4ueL2JEW4gqMI=;
        b=eM0uRhzlaioH843Ei/VC17cLNlJWoHFFVxHZY3/2QmLZFN12tSdn1gS9Vt76Cn8/hi3JzP
        znJL10+UF50MZoxZBpq5JztUKNW18VDJXuBA2hErEyDRfmuLbbHH4YPXMkNyT4cwCGcq1G
        mMMbXq0zL99EAKmD9ar34STGIYd1/DU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-xvxobbH7M_mdxKV71FIUmg-1; Mon, 27 Jun 2022 07:53:31 -0400
X-MC-Unique: xvxobbH7M_mdxKV71FIUmg-1
Received: by mail-wr1-f69.google.com with SMTP id z11-20020a056000110b00b0021b9c009d09so1136942wrw.17
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 04:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4iA+zJThegEvaay5X9bkB6r2mlx5a4ueL2JEW4gqMI=;
        b=b8tPO/RVrSOX6rLOwC3dc6cGlNs68mX5td/5//gh8/rPhPrL3xjIkB9LIYb85IqYNQ
         lBriElLYUazanZrKpz7G4/irtcZo5u4xgQordXCps6WaH1dBDwS2yQGwOcpdFl0CMReR
         cqE+H6k5Kl5xtu7xjLWMdK2K6UuVtkOOwZANTXZ0lghEcD/xEvpoRxU/Drnv4QZU/GKM
         bRUo6ZOEfUiaShGBfLtGcbO0p31Ye82AjoJpZijlas+w65EoeDR1a+7GaHzM270oFA/v
         F+zqUAsK6xh5K6EV485BPoN/6CjDHludeZ0+WHNHXDb+exQRmKuRsoIFmLfI3xpBLnaL
         Mx4g==
X-Gm-Message-State: AJIora+2QOtAH4MEyqjleiU++wmt8YrLZRHSrjCN/zTt1gmLj9vRHM12
        UvWzjRg6QQrtaV04PY/zu8VkRIUeXV4dUuq+4bXu7orG080muy5nzw8Hj0CbjVMUiG0m1WOc9DP
        n8WhEZBil6O7F
X-Received: by 2002:a1c:7c18:0:b0:3a0:39b1:3403 with SMTP id x24-20020a1c7c18000000b003a039b13403mr21172918wmc.84.1656330810175;
        Mon, 27 Jun 2022 04:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umV07YHfv9l89u85pmjMFPA0YWmqYXm7VuXyf0J+ISW9dEoHO5P2MBiXRfYI/0CpLN0ZOgWg==
X-Received: by 2002:a1c:7c18:0:b0:3a0:39b1:3403 with SMTP id x24-20020a1c7c18000000b003a039b13403mr21172868wmc.84.1656330809951;
        Mon, 27 Jun 2022 04:53:29 -0700 (PDT)
Received: from redhat.com ([2.54.45.90])
        by smtp.gmail.com with ESMTPSA id a19-20020a05600c349300b0039db500714fsm13454861wmq.6.2022.06.27.04.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:53:29 -0700 (PDT)
Date:   Mon, 27 Jun 2022 07:53:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
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
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Message-ID: <20220627074723-mutt-send-email-mst@kernel.org>
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com>
 <20220624025817-mutt-send-email-mst@kernel.org>
 <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com>
 <20220627023841-mutt-send-email-mst@kernel.org>
 <CACGkMEvy8xF2T_vubKeUEPC2aroO_fbB0Xe8nnxK4OBUgAS+Gw@mail.gmail.com>
 <20220627034733-mutt-send-email-mst@kernel.org>
 <CACGkMEtpjUBaUML=fEs5hR66rzNTBhBXOmfpzyXV1F-6BqvsGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtpjUBaUML=fEs5hR66rzNTBhBXOmfpzyXV1F-6BqvsGg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 27, 2022 at 04:14:20PM +0800, Jason Wang wrote:
> On Mon, Jun 27, 2022 at 3:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 03:45:30PM +0800, Jason Wang wrote:
> > > On Mon, Jun 27, 2022 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> > > > > On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > > > > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > > > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > > > > >
> > > > > > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> > > > > >
> > > > > > What exactly is meant by not breaking uABI?
> > > > > > Users are supposed to be prepared for struct size to change ... no?
> > > > >
> > > > > Not sure, any doc for this?
> > > > >
> > > > > Thanks
> > > >
> > > >
> > > > Well we have this:
> > > >
> > > >         The drivers SHOULD only map part of configuration structure
> > > >         large enough for device operation.  The drivers MUST handle
> > > >         an unexpectedly large \field{length}, but MAY check that \field{length}
> > > >         is large enough for device operation.
> > >
> > > Yes, but that's the device/driver interface. What's done here is the
> > > userspace/kernel.
> > >
> > > Userspace may break if it uses e.g sizeof(struct virtio_pci_common_cfg)?
> > >
> > > Thanks
> >
> > Hmm I guess there's risk... but then how are we going to maintain this
> > going forward?  Add a new struct on any change?
> 
> This is the way we have used it for the past 5 or more years. I don't
> see why this must be handled in the vq reset feature.
> 
> >Can we at least
> > prevent this going forward somehow?
> 
> Like have some padding?
> 
> Thanks

Maybe - this is what QEMU does ...

> >
> >
> > > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > > > > > this patch first.
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > ---
> > > > > > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > > > > > >  1 file changed, 7 insertions(+)
> > > > > > >
> > > > > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > > > > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > > > > > --- a/include/uapi/linux/virtio_pci.h
> > > > > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > > > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > > > > > >       __le32 queue_used_hi;           /* read-write */
> > > > > > >  };
> > > > > > >
> > > > > > > +struct virtio_pci_common_cfg_notify {
> > > > > > > +     struct virtio_pci_common_cfg cfg;
> > > > > > > +
> > > > > > > +     __le16 queue_notify_data;       /* read-write */
> > > > > > > +     __le16 padding;
> > > > > > > +};
> > > > > > > +
> > > > > > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > > > > >  struct virtio_pci_cfg_cap {
> > > > > > >       struct virtio_pci_cap cap;
> > > > > > > --
> > > > > > > 2.31.0
> > > > > >
> > > >
> >

