Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB914EBCD4
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 10:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244392AbiC3IkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 04:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbiC3IkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 04:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD698BE29
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648629512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bzS4bqzaOxuZfQIkqpt655mQSjWQT1LHlpgKAIFezfk=;
        b=I95rdoLFg4j5tZLHKQsTWXvthutVvS4b59GHR+ruZx1CfMzhiXoayGlMORhJKOV3z28lJr
        1G95JAwMNS1pnI9qUTGCa8So2E7bJDFkfgECjm+/tkCeA1evivb+BT9AovP+vKCd6UNAxx
        e8ffSoawc2Ebwz4YR2lAfuq5dcCDLBs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-sj7TjD3VOVqmIphuEmlTqA-1; Wed, 30 Mar 2022 04:38:31 -0400
X-MC-Unique: sj7TjD3VOVqmIphuEmlTqA-1
Received: by mail-lj1-f197.google.com with SMTP id 11-20020a2e154b000000b0024967cd6752so8427088ljv.13
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 01:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzS4bqzaOxuZfQIkqpt655mQSjWQT1LHlpgKAIFezfk=;
        b=ZPeQznAEeKPOlytUNxEnHbeP6stbyuD76SNumPa2EtHFXwp8iqwDXAjfTZmZVKAdHN
         YG0Mrvm2BmrhDMdl0XOgnx4LQxUNTBc3bpwP5Hf9U1d1CmeISvAkWUHROP8OkxMzyVTo
         wHlBAUF8YrxMD/L5IQDVULsr9Tklp/0ay+bAbJmNhEvT5iDOEjKc7ENQgJUyCVjBV9IV
         cpj4vp7YztwzgIxSoBh0z1P13Wxv4tgt9wubKpSHnDOfg6MvD7tWdOK8veLf6baXaFEz
         WHXh5AUIF0RTsSraBLDs5oeFlR6/YL8UpQ6Ub4on6+U0yjgZDq7AyFX61M+PC0NHcAr5
         QZFg==
X-Gm-Message-State: AOAM532z18yHHVbg4IvJdYcUDle8+mawJmQCU4zHB+7UtX2xxVJQe7LX
        FAdpBGoXdSGnfwOEMxkcyR5s5z2nhkaVPXuxkAqb+T9HYsB4X+LoSQQ9OXdXHrANugf6LxKAxLa
        rWc323vXV2A3+PEjY2VyQWXyQu5LQ
X-Received: by 2002:a05:651c:b0c:b0:247:e4b7:d4a0 with SMTP id b12-20020a05651c0b0c00b00247e4b7d4a0mr5872402ljr.177.1648629509551;
        Wed, 30 Mar 2022 01:38:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIPbYjEeHmjbGHJuP7G8/hPMIgwTlai10LTpW4LfE/TTf2L5sMsD52LohP2OT9kKgyXmx5YOKVinJp+YoaSOM=
X-Received: by 2002:a05:651c:b0c:b0:247:e4b7:d4a0 with SMTP id
 b12-20020a05651c0b0c00b00247e4b7d4a0mr5872383ljr.177.1648629509284; Wed, 30
 Mar 2022 01:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
 <20220330023258-mutt-send-email-mst@kernel.org> <CACGkMEvESXv9PfMF9riPraX59j0BiLPfTgxuFVw1x0HWwjtYVQ@mail.gmail.com>
 <1648623508.9711535-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1648623508.9711535-4-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 30 Mar 2022 16:38:18 +0800
Message-ID: <CACGkMEvE_wUNa=DgumVErTjp5gF4QRMDn6eP7UbDpSfSJSBy2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] virtio: support advance DMA
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
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

On Wed, Mar 30, 2022 at 2:59 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Wed, 30 Mar 2022 14:56:17 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Wed, Mar 30, 2022 at 2:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Feb 24, 2022 at 07:03:53PM +0800, Xuan Zhuo wrote:
> > > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > > virtqueue_add().
> > > >
> > > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > > it is necessary for us to support passing the DMA address to virtqueue_add().
> > >
> > > I picked up a couple of patches. Others are waiting for some acks
> > > (Jason?) and improved commit logs for documentation.
> >
> > I will review them.
>
> hi, the core code of premapped, I will merge it into 'virtio pci support
> VIRTIO_F_RING_RESET' because this function will be used when reusing the buffer
> after resize.

I still prefer not to do that.

We can make rest work for resize first and add pre mapping on top. It
will simplify the review.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > Thanks!
> > >
> > > > v2:
> > > >     1. rename predma -> premapped
> > > >     2. virtio net xdp tx use virtio dma api
> > > >
> > > > v1:
> > > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > > >       of them are not supported to be PREDMA
> > > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > > >       together with the next time AF_XDP supports virtio dma
> > > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > > >       indirect desc
> > > >
> > > > Xuan Zhuo (9):
> > > >   virtio_ring: rename vring_unmap_state_packed() to
> > > >     vring_unmap_extra_packed()
> > > >   virtio_ring: remove flags check for unmap split indirect desc
> > > >   virtio_ring: remove flags check for unmap packed indirect desc
> > > >   virtio_ring: virtqueue_add() support premapped
> > > >   virtio_ring: split: virtqueue_add_split() support premapped
> > > >   virtio_ring: packed: virtqueue_add_packed() support premapped
> > > >   virtio_ring: add api virtio_dma_map() for advance dma
> > > >   virtio_ring: introduce virtqueue_add_outbuf_premapped()
> > > >   virtio_net: xdp xmit use virtio dma api
> > > >
> > > >  drivers/net/virtio_net.c     |  42 +++++-
> > > >  drivers/virtio/virtio_ring.c | 280 ++++++++++++++++++++++++++---------
> > > >  include/linux/virtio.h       |  12 ++
> > > >  3 files changed, 254 insertions(+), 80 deletions(-)
> > > >
> > > > --
> > > > 2.31.0
> > >
> >
>

