Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391BD4ACF58
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 04:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346321AbiBHDAB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 22:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346313AbiBHDAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 22:00:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5FDDC0401D3
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 18:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644289198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ur/XVUARqlEylrl75WMsGXRxz0bKGIVFgoVCSK+68pc=;
        b=YdiCd2K2grp63Ork3pvRY3JC2RKzC6padO7VuNjbd1FOY9vrb5/9x95tZihiGX9if/IUVU
        3ImdngJJaKoJFJFBrV68rR1A/DxgMjkUKSnoGcWj2FpFh+6j6AL93EO2GsBMTHMDa5i5U+
        sm/WKVmBC8DLXb3F/bNsO5j1vO0F+CU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-MqVhVkrOPAqn3oG4nvbzrA-1; Mon, 07 Feb 2022 21:59:56 -0500
X-MC-Unique: MqVhVkrOPAqn3oG4nvbzrA-1
Received: by mail-pj1-f70.google.com with SMTP id q12-20020a17090a2e0c00b001b874772fecso7326243pjd.2
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 18:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ur/XVUARqlEylrl75WMsGXRxz0bKGIVFgoVCSK+68pc=;
        b=PT1CBcUwmY7b6wPxcraHLcdkLEL89sYF/vTv22BhnVU9NaMvsvOLGZGA6PP4LLYPBS
         bC74/zFaz557qWXEYH/sAdGY5SWKohZKEIoA9n0uhfrd/zKrAXbx8qM8Ioi07c8pQdC7
         cR1CXpdk9r0FSH/Stjlcu1YTK6xt0XCx9OTJGsa8E4+eud6X0zV1kbqmtSyWlSczp0al
         Q9ZLk/L9SkIPXttSgz3sMn3GT35o2MU0rzQBRqAvpc6LcwfJ96aIuHmBL58DBheDnUK0
         TtpF2WIxeCcqwa98BRgyO7rCKShqRIivptb+xghXMLHUCgUcEJ/V6SzhG1U5P0IeL+8W
         eAEg==
X-Gm-Message-State: AOAM533IabakxZ262lnAh17IPklq6dhudCdff50JgmG+kwyO5W1R4IVT
        kMTCzj0H822efN4IPV4G4W6o2CqhTZaBY3Hz3jyiZRD+B3GbhgX5o5+g7DtgneyCMSuVOR+6Klr
        yuzxlo8MQ3qUy
X-Received: by 2002:a17:90a:4291:: with SMTP id p17mr2091895pjg.126.1644289195714;
        Mon, 07 Feb 2022 18:59:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw66uwPUuiCvtKOAmk3ev+B5LJnqGSuJHyL+yJsXiATMQiVAvJGYVXYkgiixcW3KyH9wSlZ6w==
X-Received: by 2002:a17:90a:4291:: with SMTP id p17mr2091878pjg.126.1644289195452;
        Mon, 07 Feb 2022 18:59:55 -0800 (PST)
Received: from [10.72.13.233] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m21sm13834878pfk.26.2022.02.07.18.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 18:59:54 -0800 (PST)
Message-ID: <7d1e2d5b-a9a1-cbb7-4d80-89df1cb7bf15@redhat.com>
Date:   Tue, 8 Feb 2022 10:59:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v3 00/17] virtio pci support VIRTIO_F_RING_RESET
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
References: <1644213739.5846965-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <1644213739.5846965-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/2/7 下午2:02, Xuan Zhuo 写道:
> On Mon, 7 Feb 2022 11:39:36 +0800, Jason Wang <jasowang@redhat.com> wrote:
>> On Wed, Jan 26, 2022 at 3:35 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>> ================================================================================
>>> The virtio spec already supports the virtio queue reset function. This patch set
>>> is to add this function to the kernel. The relevant virtio spec information is
>>> here:
>>>
>>>      https://github.com/oasis-tcs/virtio-spec/issues/124
>>>
>>> Also regarding MMIO support for queue reset, I plan to support it after this
>>> patch is passed.
>>>
>>> #14-#17 is the disable/enable function of rx/tx pair implemented by virtio-net
>>> using the new helper.
>> One thing that came to mind is the steering. E.g if we disable an RX,
>> should we stop steering packets to that queue?
> Yes, we should reselect a queue.
>
> Thanks.


Maybe a spec patch for that?

Thanks


>
>> Thanks
>>
>>> This function is not currently referenced by other
>>> functions. It is more to show the usage of the new helper, I not sure if they
>>> are going to be merged together.
>>>
>>> Please review. Thanks.
>>>
>>> v3:
>>>    1. keep vq, irq unreleased
>>>
>>> Xuan Zhuo (17):
>>>    virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
>>>    virtio: queue_reset: add VIRTIO_F_RING_RESET
>>>    virtio: queue_reset: struct virtio_config_ops add callbacks for
>>>      queue_reset
>>>    virtio: queue_reset: add helper
>>>    vritio_ring: queue_reset: extract the release function of the vq ring
>>>    virtio_ring: queue_reset: split: add __vring_init_virtqueue()
>>>    virtio_ring: queue_reset: split: support enable reset queue
>>>    virtio_ring: queue_reset: packed: support enable reset queue
>>>    virtio_ring: queue_reset: add vring_reset_virtqueue()
>>>    virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
>>>      option functions
>>>    virtio_pci: queue_reset: release vq by vp_dev->vqs
>>>    virtio_pci: queue_reset: setup_vq use vring_setup_virtqueue()
>>>    virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
>>>    virtio_net: virtnet_tx_timeout() fix style
>>>    virtio_net: virtnet_tx_timeout() stop ref sq->vq
>>>    virtio_net: split free_unused_bufs()
>>>    virtio_net: support pair disable/enable
>>>
>>>   drivers/net/virtio_net.c               | 220 ++++++++++++++++++++++---
>>>   drivers/virtio/virtio_pci_common.c     |  62 ++++---
>>>   drivers/virtio/virtio_pci_common.h     |  11 +-
>>>   drivers/virtio/virtio_pci_legacy.c     |   5 +-
>>>   drivers/virtio/virtio_pci_modern.c     | 120 +++++++++++++-
>>>   drivers/virtio/virtio_pci_modern_dev.c |  28 ++++
>>>   drivers/virtio/virtio_ring.c           | 144 +++++++++++-----
>>>   include/linux/virtio.h                 |   1 +
>>>   include/linux/virtio_config.h          |  75 ++++++++-
>>>   include/linux/virtio_pci_modern.h      |   2 +
>>>   include/linux/virtio_ring.h            |  42 +++--
>>>   include/uapi/linux/virtio_config.h     |   7 +-
>>>   include/uapi/linux/virtio_pci.h        |   2 +
>>>   13 files changed, 618 insertions(+), 101 deletions(-)
>>>
>>> --
>>> 2.31.0
>>>

