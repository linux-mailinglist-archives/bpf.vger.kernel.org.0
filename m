Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB254EBB3B
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 08:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243613AbiC3G6Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 02:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243573AbiC3G6S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 02:58:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AF87DCE31
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 23:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648623392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GEPBB5G5c+LQGsS56cllBXvgUxc5xBSY2dhcbaxd6h4=;
        b=TR4sgtA8BBQgCGSHa5CXSCBuNb4qPtWJSF+OtTNFVV6Lq98CWG/t1kcoVCTb3BGyzikM05
        o4LZ/pCYBNG1zKzagbxGR9HU+ehewr8GRrOF5lHxk7ovmVdQEceaMQvnhhY7ItMeDXTVp7
        yD7MVdZmiw/CNDbWrYZG7Aai/rK9wLI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-WjCfyWEePaSoABebXZ8m8w-1; Wed, 30 Mar 2022 02:56:30 -0400
X-MC-Unique: WjCfyWEePaSoABebXZ8m8w-1
Received: by mail-lj1-f197.google.com with SMTP id v8-20020a2e7a08000000b002498273eb20so8341081ljc.7
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 23:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEPBB5G5c+LQGsS56cllBXvgUxc5xBSY2dhcbaxd6h4=;
        b=HRjYjqBvNWsosOqYKC1AR/1mEcTzXyFyrashgD4D4BHZIfQ/n1llY7yl0DZN9V51bC
         nMJecSTCRJQdaTf54H6tZTfJ42UPxTVLryAJurL5rn8/Hdrn8wR0ziSKoyH09TxnpJek
         Cfn87EBgiYdBDk6zUnvn0+rbt3JMi5iaQpmBPKNWK1kAI2ZATd8U/FOHXwB/VIt1NHH7
         wKjDz1FmOjRKu0YGPG3PMw/OuvhI2NAT8J2nlNV3cPvwW/jc0xoD8+bQUONm1w9T93HH
         ZIbvSSTOsvcOEsR3/Udlk3P6ciThSeFCpiM+RmCwm7wG/KafRPjYB19y5/LHhdZj/jTn
         v/NA==
X-Gm-Message-State: AOAM531IrhuMHpNvSzj3uU/68EKPCHobbD9iyUmyKHY3c0n33bzjqQ5L
        r2WW2fTR/stTYrtdPOgL9bk15YTQnaGFPoO60G5KhTVixcmwh2EAzq1i8fcOKA0UWI2Y1DbtHGe
        qj3SvtnlKBOlYXRb8pDLAFGDRmjdB
X-Received: by 2002:ac2:4477:0:b0:44a:55c6:155d with SMTP id y23-20020ac24477000000b0044a55c6155dmr5669570lfl.376.1648623389274;
        Tue, 29 Mar 2022 23:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwW3W/Rw+4wINA0n2UEX3TUfxQkWNftf4UnzHfapIPk1fPf1HGsiUPU++i+qV4XswKgcPdxcBzr1+V7DjLaTOM=
X-Received: by 2002:ac2:4477:0:b0:44a:55c6:155d with SMTP id
 y23-20020ac24477000000b0044a55c6155dmr5669559lfl.376.1648623389074; Tue, 29
 Mar 2022 23:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com> <20220330023258-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220330023258-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 30 Mar 2022 14:56:17 +0800
Message-ID: <CACGkMEvESXv9PfMF9riPraX59j0BiLPfTgxuFVw1x0HWwjtYVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] virtio: support advance DMA
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 30, 2022 at 2:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Feb 24, 2022 at 07:03:53PM +0800, Xuan Zhuo wrote:
> > virtqueue_add() only supports virtual addresses, dma is completed in
> > virtqueue_add().
> >
> > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > it is necessary for us to support passing the DMA address to virtqueue_add().
>
> I picked up a couple of patches. Others are waiting for some acks
> (Jason?) and improved commit logs for documentation.

I will review them.

Thanks

>
> Thanks!
>
> > v2:
> >     1. rename predma -> premapped
> >     2. virtio net xdp tx use virtio dma api
> >
> > v1:
> >    1. All sgs requested at one time are required to be unified PREDMA, and several
> >       of them are not supported to be PREDMA
> >    2. virtio_dma_map() is removed from this patch set and will be submitted
> >       together with the next time AF_XDP supports virtio dma
> >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> >       indirect desc
> >
> > Xuan Zhuo (9):
> >   virtio_ring: rename vring_unmap_state_packed() to
> >     vring_unmap_extra_packed()
> >   virtio_ring: remove flags check for unmap split indirect desc
> >   virtio_ring: remove flags check for unmap packed indirect desc
> >   virtio_ring: virtqueue_add() support premapped
> >   virtio_ring: split: virtqueue_add_split() support premapped
> >   virtio_ring: packed: virtqueue_add_packed() support premapped
> >   virtio_ring: add api virtio_dma_map() for advance dma
> >   virtio_ring: introduce virtqueue_add_outbuf_premapped()
> >   virtio_net: xdp xmit use virtio dma api
> >
> >  drivers/net/virtio_net.c     |  42 +++++-
> >  drivers/virtio/virtio_ring.c | 280 ++++++++++++++++++++++++++---------
> >  include/linux/virtio.h       |  12 ++
> >  3 files changed, 254 insertions(+), 80 deletions(-)
> >
> > --
> > 2.31.0
>

