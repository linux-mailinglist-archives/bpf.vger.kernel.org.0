Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68A44EBAD6
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 08:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbiC3Gfu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 02:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbiC3Gft (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 02:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E228431903
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 23:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648622039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8OnziqqDPw1UfFbV4aNhNoy1sEjtLc7+xQm5kwlL89c=;
        b=HRGPH2tmDGprhLH0bk+lMqvhKtI6JJ0zx4tAxgWbKNP9W5gJZUCm8256/mapbIoR5pN7qR
        BDj1723uddPLV9YRG3xBUxLGcd2xwcBnpf9Kf6jwcx+eXDSkkmmH9bL/KvYGjKIpKGLQsH
        2iRs2k41aq08OfHM94zlA1hVy9suZN4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-rDQOLvPPO9S6XivB2nSXmg-1; Wed, 30 Mar 2022 02:33:57 -0400
X-MC-Unique: rDQOLvPPO9S6XivB2nSXmg-1
Received: by mail-wm1-f71.google.com with SMTP id v2-20020a05600c214200b0038c7c02deceso2180091wml.8
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 23:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8OnziqqDPw1UfFbV4aNhNoy1sEjtLc7+xQm5kwlL89c=;
        b=fGt4Ly3H8EzSEy7RjOmyYAJoDTZm/TspvtbNsw4ew8GJjANJdneogFs75vG8uQzdzT
         5+2djV0+3z2zlFytyL8atIBlrer4mEg47swxfNE1BTkPmWpWNA4NCU5NytHEZQso6g/6
         kwhnrgfutzP6tLIJ+3GVPG5/s1htTNh1n46ohM+klEsL4K5qnuSRYw6Xn0QRPP6Ya9CK
         qnU+H5FfnjKr+ZGnjOmfgU65BrASmabA1wI9eM+0X71EctvOJ+wPHrvb4Ndax68mDZJZ
         gpRyt0VEUpJ6cPShE2InFifb8RHeGw0LaPZvvRtwIDNNd9k4s6uGHaU55zdedcCi/8NQ
         BwBw==
X-Gm-Message-State: AOAM533c0VPR6LNzbYwtUI7aAU6Gx6w05eUeRm0rcBnZmBlCA9F85Ki7
        JW+avdU9q4XSKMP8x84GplZHBmTsvJmzZGIFzfA5RjOxUB3WJWqRI0ewPFAIy08lnyn/6srUGAl
        mVbqxFyVp0RGr
X-Received: by 2002:a05:6000:2cd:b0:204:1bf4:e4f8 with SMTP id o13-20020a05600002cd00b002041bf4e4f8mr35140127wry.682.1648622036278;
        Tue, 29 Mar 2022 23:33:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ87E7eY3qwB6BZvYyIwH4cGmNeD8anl5BueTVKGjjkpvj4rb01CerNy1jhbIZHW0+Foa9Jw==
X-Received: by 2002:a05:6000:2cd:b0:204:1bf4:e4f8 with SMTP id o13-20020a05600002cd00b002041bf4e4f8mr35140106wry.682.1648622036067;
        Tue, 29 Mar 2022 23:33:56 -0700 (PDT)
Received: from redhat.com ([2.52.9.207])
        by smtp.gmail.com with ESMTPSA id y5-20020a1c4b05000000b0038cbf571334sm3731386wma.18.2022.03.29.23.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 23:33:54 -0700 (PDT)
Date:   Wed, 30 Mar 2022 02:33:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/9] virtio: support advance DMA
Message-ID: <20220330023258-mutt-send-email-mst@kernel.org>
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
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

On Thu, Feb 24, 2022 at 07:03:53PM +0800, Xuan Zhuo wrote:
> virtqueue_add() only supports virtual addresses, dma is completed in
> virtqueue_add().
> 
> In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> it is necessary for us to support passing the DMA address to virtqueue_add().

I picked up a couple of patches. Others are waiting for some acks
(Jason?) and improved commit logs for documentation.

Thanks!

> v2:
>     1. rename predma -> premapped
>     2. virtio net xdp tx use virtio dma api
> 
> v1:
>    1. All sgs requested at one time are required to be unified PREDMA, and several
>       of them are not supported to be PREDMA
>    2. virtio_dma_map() is removed from this patch set and will be submitted
>       together with the next time AF_XDP supports virtio dma
>    3. Added patch #2 #3 to remove the check for flags when performing unmap
>       indirect desc
> 
> Xuan Zhuo (9):
>   virtio_ring: rename vring_unmap_state_packed() to
>     vring_unmap_extra_packed()
>   virtio_ring: remove flags check for unmap split indirect desc
>   virtio_ring: remove flags check for unmap packed indirect desc
>   virtio_ring: virtqueue_add() support premapped
>   virtio_ring: split: virtqueue_add_split() support premapped
>   virtio_ring: packed: virtqueue_add_packed() support premapped
>   virtio_ring: add api virtio_dma_map() for advance dma
>   virtio_ring: introduce virtqueue_add_outbuf_premapped()
>   virtio_net: xdp xmit use virtio dma api
> 
>  drivers/net/virtio_net.c     |  42 +++++-
>  drivers/virtio/virtio_ring.c | 280 ++++++++++++++++++++++++++---------
>  include/linux/virtio.h       |  12 ++
>  3 files changed, 254 insertions(+), 80 deletions(-)
> 
> --
> 2.31.0

