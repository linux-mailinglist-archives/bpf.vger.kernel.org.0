Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2404D2B46
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 10:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiCIJDe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 04:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiCIJDa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 04:03:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF9633BBC4
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 01:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646816549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5aObMD6Ok3RFIxMTKg8qnF6qbjrqHlGEfR26y0Xh7So=;
        b=QUXYqipsbGVkk8colGFNvkCatBH3mK0b0l2bkDHSAToVOmvuM2b9hScEjxBWfyFBPyvgQP
        M1j7L9a6MQZGCvXYOEOu4SUDI4QpTpEdAASBIexjdSHsne00acIK5pPR28ToNYaWFaBs3B
        6rwSg+Q6elXhmGvLvu1wlkAIfzP9KpU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-Y0oyaoniNtycUBmYQeEbQA-1; Wed, 09 Mar 2022 04:02:28 -0500
X-MC-Unique: Y0oyaoniNtycUBmYQeEbQA-1
Received: by mail-wm1-f70.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so711176wmj.5
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 01:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5aObMD6Ok3RFIxMTKg8qnF6qbjrqHlGEfR26y0Xh7So=;
        b=fZNUJl/vFKvKj134lyGOeYJqcES+Mit02/TeSpy8FvWXuHsZxAKVVJDKby5pi0FVSn
         V8uqQd3rCUOdLlUIQVtPWLNLlcSa8ha0p18OrqgDtJb55WgG/W+3f6FXVzxQp6UGmmaC
         1wZE4bdIECVtmVfk2uJf/0SbNQ7xDcPoKS0sBKv1wUi2saDkVow8v4L6LfPFcrfzNb10
         f4etxLA91nyXjvanS7cP6vqkXh5Wowo+hDE2M3yzi5t2cGoeW+Sl6+zBTmTbdaA6fnx1
         lAJqtlrwNA2eELYhesHW081ovYKYq9uONMrRVdV3A61Z7jET4opNWbq87kZHK5P2jlMJ
         S/Hw==
X-Gm-Message-State: AOAM531g0QbHDsEjMmrcD5+HGLmzk0TvHN2Uxiq+eJ22Q6aN4PENRhfw
        ka9UiDklChG9jp0+M5jPmPzpeVV0055MLUdQpcJiJZGlQu2QxhcwgPn9BEpKVGwgR0rXGxYWoTS
        LS+AzDYxeWFzL
X-Received: by 2002:a05:6000:18c3:b0:1e5:82d3:e4e2 with SMTP id w3-20020a05600018c300b001e582d3e4e2mr14993292wrq.575.1646816547220;
        Wed, 09 Mar 2022 01:02:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/K3pXZ+ppWTfZ6/r7oUGokhYCJ/UF0RyQUca34snHdSOK5obfoBIbDyvpSzzrgemP9xZiVA==
X-Received: by 2002:a05:6000:18c3:b0:1e5:82d3:e4e2 with SMTP id w3-20020a05600018c300b001e582d3e4e2mr14993243wrq.575.1646816546861;
        Wed, 09 Mar 2022 01:02:26 -0800 (PST)
Received: from redhat.com ([2.55.46.250])
        by smtp.gmail.com with ESMTPSA id u10-20020adfa18a000000b001f04c24afe7sm1094077wru.41.2022.03.09.01.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:02:26 -0800 (PST)
Date:   Wed, 9 Mar 2022 04:02:18 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
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
        linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v7 00/26] virtio pci support VIRTIO_F_RING_RESET
Message-ID: <20220309035751-mutt-send-email-mst@kernel.org>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <2c823fed-8024-39e7-f6f5-176fb518fc1a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c823fed-8024-39e7-f6f5-176fb518fc1a@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 09, 2022 at 12:45:57PM +0800, Jason Wang wrote:
> 
> 在 2022/3/8 下午8:34, Xuan Zhuo 写道:
> > The virtio spec already supports the virtio queue reset function. This patch set
> > is to add this function to the kernel. The relevant virtio spec information is
> > here:
> > 
> >      https://github.com/oasis-tcs/virtio-spec/issues/124
> > 
> > Also regarding MMIO support for queue reset, I plan to support it after this
> > patch is passed.
> > 
> > Performing reset on a queue is divided into four steps:
> >       1. virtio_reset_vq()              - notify the device to reset the queue
> >       2. virtqueue_detach_unused_buf()  - recycle the buffer submitted
> >       3. virtqueue_reset_vring()        - reset the vring (may re-alloc)
> >       4. virtio_enable_resetq()         - mmap vring to device, and enable the queue
> > 
> > The first part 1-17 of this patch set implements virtio pci's support and API
> > for queue reset. The latter part is to make virtio-net support set_ringparam. Do
> > these things for this feature:
> > 
> >        1. virtio-net support rx,tx reset
> >        2. find_vqs() support to special the max size of each vq
> >        3. virtio-net support set_ringparam
> > 
> > #1 -#3 :       prepare
> > #4 -#12:       virtio ring support reset vring of the vq
> > #13-#14:       add helper
> > #15-#17:       virtio pci support reset queue and re-enable
> > #18-#21:       find_vqs() support sizes to special the max size of each vq
> > #23-#24:       virtio-net support rx, tx reset
> > #22, #25, #26: virtio-net support set ringparam
> > 
> > Test environment:
> >      Host: 4.19.91
> >      Qemu: QEMU emulator version 6.2.50 (with vq reset support)
> >      Test Cmd:  ethtool -G eth1 rx $1 tx $2; ethtool -g eth1
> > 
> >      The default is split mode, modify Qemu virtio-net to add PACKED feature to test
> >      packed mode.
> > 
> > 
> > Please review. Thanks.
> > 
> > v7:
> >    1. fix #6 subject typo
> >    2. fix #6 ring_size_in_bytes is uninitialized
> >    3. check by: make W=12
> > 
> > v6:
> >    1. virtio_pci: use synchronize_irq(irq) to sync the irq callbacks
> >    2. Introduce virtqueue_reset_vring() to implement the reset of vring during
> >       the reset process. May use the old vring if num of the vq not change.
> >    3. find_vqs() support sizes to special the max size of each vq
> > 
> > v5:
> >    1. add virtio-net support set_ringparam
> > 
> > v4:
> >    1. just the code of virtio, without virtio-net
> >    2. Performing reset on a queue is divided into these steps:
> >      1. reset_vq: reset one vq
> >      2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> >      3. release the ring of the vq by vring_release_virtqueue()
> >      4. enable_reset_vq: re-enable the reset queue
> >    3. Simplify the parameters of enable_reset_vq()
> >    4. add container structures for virtio_pci_common_cfg
> > 
> > v3:
> >    1. keep vq, irq unreleased
> 
> 
> The series became kind of huge.
> 
> I'd suggest to split it into two series.
> 
> 1) refactoring of the virtio_ring to prepare for the resize
> 2) the reset support + virtio-net support
> 
> Thanks


And just to clarify, I think you mean all the "extract logic"
things need to also go into the refactoring part, right?
Just making 3 first patches a series by themselves won't help ...
I'm kind of ambivalent on the splitup - both parts
need work for now, so I wonder how does it help.
But if you care about it, I don't mind.

> > 
> > *** BLURB HERE ***


You don't want this in your cover letters btw.

> > Xuan Zhuo (26):
> >    virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
> >    virtio: queue_reset: add VIRTIO_F_RING_RESET
> >    virtio: add helper virtqueue_get_vring_max_size()
> >    virtio_ring: split: extract the logic of creating vring
> >    virtio_ring: split: extract the logic of init vq and attach vring
> >    virtio_ring: packed: extract the logic of creating vring
> >    virtio_ring: packed: extract the logic of init vq and attach vring
> >    virtio_ring: extract the logic of freeing vring
> >    virtio_ring: split: implement virtqueue_reset_vring_split()
> >    virtio_ring: packed: implement virtqueue_reset_vring_packed()
> >    virtio_ring: introduce virtqueue_reset_vring()
> >    virtio_ring: update the document of the virtqueue_detach_unused_buf
> >      for queue reset
> >    virtio: queue_reset: struct virtio_config_ops add callbacks for
> >      queue_reset
> >    virtio: add helper for queue reset
> >    virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
> >      option functions
> >    virtio_pci: queue_reset: extract the logic of active vq for modern pci
> >    virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
> >    virtio: find_vqs() add arg sizes
> >    virtio_pci: support the arg sizes of find_vqs()
> >    virtio_mmio: support the arg sizes of find_vqs()
> >    virtio: add helper virtio_find_vqs_ctx_size()
> >    virtio_net: get ringparam by virtqueue_get_vring_max_size()
> >    virtio_net: split free_unused_bufs()
> >    virtio_net: support rx/tx queue reset
> >    virtio_net: set the default max ring size by find_vqs()
> >    virtio_net: support set_ringparam
> > 
> >   arch/um/drivers/virtio_uml.c             |   2 +-
> >   drivers/net/virtio_net.c                 | 257 ++++++++--
> >   drivers/platform/mellanox/mlxbf-tmfifo.c |   3 +-
> >   drivers/remoteproc/remoteproc_virtio.c   |   2 +-
> >   drivers/s390/virtio/virtio_ccw.c         |   2 +-
> >   drivers/virtio/virtio_mmio.c             |  12 +-
> >   drivers/virtio/virtio_pci_common.c       |  28 +-
> >   drivers/virtio/virtio_pci_common.h       |   3 +-
> >   drivers/virtio/virtio_pci_legacy.c       |   8 +-
> >   drivers/virtio/virtio_pci_modern.c       | 146 +++++-
> >   drivers/virtio/virtio_pci_modern_dev.c   |  36 ++
> >   drivers/virtio/virtio_ring.c             | 584 +++++++++++++++++------
> >   drivers/virtio/virtio_vdpa.c             |   2 +-
> >   include/linux/virtio.h                   |  12 +
> >   include/linux/virtio_config.h            |  74 ++-
> >   include/linux/virtio_pci_modern.h        |   2 +
> >   include/uapi/linux/virtio_config.h       |   7 +-
> >   include/uapi/linux/virtio_pci.h          |  14 +
> >   18 files changed, 979 insertions(+), 215 deletions(-)
> > 
> > --
> > 2.31.0
> > 

