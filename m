Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E0855C2E7
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 14:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245405AbiF1GKo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 02:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245380AbiF1GKn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 02:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFCD42610E
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 23:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656396640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BYYScMGsiH8wtlqiDVPv0n7noXIHSehxA8t2s/lQEB0=;
        b=IGF1ddodnZEyVCUyce/Ye7c3/huraKZW7HoBS/uJRs3HT1jN3O0n4F0ycTf+MS10TRUQtk
        F9hm6APJ6mokT24xX0Q2ZcDpm60gl2rggGxo5xve8IGeHjZxjno6Sv93fzlzA+xawHsav2
        D/sLxwByxWOgR919soZZXrMlFRW5ryo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-q4ND4EiTMXWzvrHxffZxyw-1; Tue, 28 Jun 2022 02:10:39 -0400
X-MC-Unique: q4ND4EiTMXWzvrHxffZxyw-1
Received: by mail-wr1-f70.google.com with SMTP id v8-20020adfa1c8000000b0021b81a553fbso1478405wrv.18
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 23:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BYYScMGsiH8wtlqiDVPv0n7noXIHSehxA8t2s/lQEB0=;
        b=IP9/w5cFe4dDcZt58yJKhQPXJ1FeBF/qtUqEs/pTyCYOP/o4NblgufbyIidSbs/yH/
         OqwvhnIR+DZ1EJhZboM9Mb7FYuYkVi7WRqNou9Qr9h3zwFtlbv9/eZJ5kVY4vJ5Im8Pn
         BPbslhIAHS9RzR3lWg/BGVhD5VyiS/rvgVNgf9MBcQgcUuhVNBGTepjvjsmVoPhMNJNB
         GewcxXRQtHZW9D1CuBJ/rcvOwhLHJjTrtIh3q1a/b+GPKEHwWFmFcrcTd3GpoMB+DRlA
         9KuwNPtd1+YP59JsABLz4ATJqxECAn4hrVtNm45R3WzZxZYvIfh8zAxR4/aFXUBPPvDy
         kyKg==
X-Gm-Message-State: AJIora/QlImwNEL6n1CQX40+us6iDRSo2yXgmGEMK8TUby4WAEPug+O1
        f6YJLTNHbF1jJ5aPHa3JPxnTNCF7pPwj5+LBzXciLec/zj22h6vDLbj0EZ9/wOM47Xj86WHzglU
        x1rbKSX9BEMcX
X-Received: by 2002:a7b:c14c:0:b0:3a0:4abb:a921 with SMTP id z12-20020a7bc14c000000b003a04abba921mr9359284wmi.100.1656396637790;
        Mon, 27 Jun 2022 23:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uYPpsc/vNcF8V81k2UPKWJOcoGV0c9Iyt5goPxWMxuimwfAbhL9YzgAF/m6F7YVT4+iKyThg==
X-Received: by 2002:a7b:c14c:0:b0:3a0:4abb:a921 with SMTP id z12-20020a7bc14c000000b003a04abba921mr9359258wmi.100.1656396637509;
        Mon, 27 Jun 2022 23:10:37 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id q12-20020a5d61cc000000b0021cf31e1f7csm4556375wrv.102.2022.06.27.23.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 23:10:37 -0700 (PDT)
Date:   Tue, 28 Jun 2022 02:10:30 -0400
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
Message-ID: <20220628020832-mutt-send-email-mst@kernel.org>
References: <20220624025817-mutt-send-email-mst@kernel.org>
 <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com>
 <20220627023841-mutt-send-email-mst@kernel.org>
 <CACGkMEvy8xF2T_vubKeUEPC2aroO_fbB0Xe8nnxK4OBUgAS+Gw@mail.gmail.com>
 <20220627034733-mutt-send-email-mst@kernel.org>
 <CACGkMEtpjUBaUML=fEs5hR66rzNTBhBXOmfpzyXV1F-6BqvsGg@mail.gmail.com>
 <20220627074723-mutt-send-email-mst@kernel.org>
 <CACGkMEv0zdgG6SAaxRwkpObEFX_KRB1ovezNiHX+QXsYhE=qaQ@mail.gmail.com>
 <20220628014309-mutt-send-email-mst@kernel.org>
 <CACGkMEuzrmVsM5Xa3N_9n0-XOqyMAz65AON8oxkgmjnXb_bAFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuzrmVsM5Xa3N_9n0-XOqyMAz65AON8oxkgmjnXb_bAFg@mail.gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 28, 2022 at 02:07:28PM +0800, Jason Wang wrote:
> On Tue, Jun 28, 2022 at 1:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 28, 2022 at 11:50:37AM +0800, Jason Wang wrote:
> > > On Mon, Jun 27, 2022 at 7:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 27, 2022 at 04:14:20PM +0800, Jason Wang wrote:
> > > > > On Mon, Jun 27, 2022 at 3:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 27, 2022 at 03:45:30PM +0800, Jason Wang wrote:
> > > > > > > On Mon, Jun 27, 2022 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> > > > > > > > > On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > > > > > > > > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > > > > > > > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > > > > > > > > >
> > > > > > > > > > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> > > > > > > > > >
> > > > > > > > > > What exactly is meant by not breaking uABI?
> > > > > > > > > > Users are supposed to be prepared for struct size to change ... no?
> > > > > > > > >
> > > > > > > > > Not sure, any doc for this?
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > >
> > > > > > > > Well we have this:
> > > > > > > >
> > > > > > > >         The drivers SHOULD only map part of configuration structure
> > > > > > > >         large enough for device operation.  The drivers MUST handle
> > > > > > > >         an unexpectedly large \field{length}, but MAY check that \field{length}
> > > > > > > >         is large enough for device operation.
> > > > > > >
> > > > > > > Yes, but that's the device/driver interface. What's done here is the
> > > > > > > userspace/kernel.
> > > > > > >
> > > > > > > Userspace may break if it uses e.g sizeof(struct virtio_pci_common_cfg)?
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > Hmm I guess there's risk... but then how are we going to maintain this
> > > > > > going forward?  Add a new struct on any change?
> > > > >
> > > > > This is the way we have used it for the past 5 or more years. I don't
> > > > > see why this must be handled in the vq reset feature.
> > > > >
> > > > > >Can we at least
> > > > > > prevent this going forward somehow?
> > > > >
> > > > > Like have some padding?
> > > > >
> > > > > Thanks
> > > >
> > > > Maybe - this is what QEMU does ...
> > >
> > > Do you want this to be addressed in this series (it's already very huge anyhow)?
> > >
> > > Thanks
> >
> > Let's come up with a solution at least. QEMU does not seem to need the struct.
> 
> If we want to implement it in Qemu we need that:
> 
> https://github.com/fengidri/qemu/commit/39b79335cb55144d11a3b01f93d46cc73342c6bb
> 
> > Let's just put
> > it in virtio_pci_modern.h for now then?
> 
> Does this mean userspace needs to define the struct by their own
> instead of depending on the uapi in the future?
> 
> Thanks


$ git grep 'struct virtio_pci_common_cfg'
include/standard-headers/linux/virtio_pci.h:struct virtio_pci_common_cfg {
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                       offsetof(struct virtio_pci_common_cfg, device_feature));
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                       offsetof(struct virtio_pci_common_cfg, device_feature));
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                       offsetof(struct virtio_pci_common_cfg, guest_feature));
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                       offsetof(struct virtio_pci_common_cfg, guest_feature));
tests/qtest/libqos/virtio-pci-modern.c:                         offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                          offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_select),
tests/qtest/libqos/virtio-pci-modern.c:                         offsetof(struct virtio_pci_common_cfg, queue_size));
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_desc_lo),
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_desc_hi),
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_avail_lo),
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_avail_hi),
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_used_lo),
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_used_hi),
tests/qtest/libqos/virtio-pci-modern.c:                               offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_enable), 1);
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, msix_config), entry);
tests/qtest/libqos/virtio-pci-modern.c:                           offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_msix_vector),
tests/qtest/libqos/virtio-pci-modern.c:                           offsetof(struct virtio_pci_common_cfg,


The only user of the struct is libqos and it just wants
the offsets so can use macros just as well.


> >
> > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > > > > > > > > > this patch first.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > > > > > > > > > >  1 file changed, 7 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > > > > > > > > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > > > > > > > > > --- a/include/uapi/linux/virtio_pci.h
> > > > > > > > > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > > > > > > > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > > > > > > > > > >       __le32 queue_used_hi;           /* read-write */
> > > > > > > > > > >  };
> > > > > > > > > > >
> > > > > > > > > > > +struct virtio_pci_common_cfg_notify {
> > > > > > > > > > > +     struct virtio_pci_common_cfg cfg;
> > > > > > > > > > > +
> > > > > > > > > > > +     __le16 queue_notify_data;       /* read-write */
> > > > > > > > > > > +     __le16 padding;
> > > > > > > > > > > +};
> > > > > > > > > > > +
> > > > > > > > > > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > > > > > > > > >  struct virtio_pci_cfg_cap {
> > > > > > > > > > >       struct virtio_pci_cap cap;
> > > > > > > > > > > --
> > > > > > > > > > > 2.31.0
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >

