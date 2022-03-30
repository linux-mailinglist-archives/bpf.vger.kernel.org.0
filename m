Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46DF4EBF35
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 12:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbiC3KxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 06:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245598AbiC3Kw4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 06:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC70639838
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 03:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648637471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wnMSItC8n0CDYr8QTJ4aTsqJAmXh/a7xPpLx6HfylVg=;
        b=iK6t6mr1fgpeSSkMBAtfHnf+gsxYSZ9czUidm42yxizkh34inx80Zo8Fx+gm/A+rtRdXFq
        WdOm07xt1bPRY4x3K1wWbfy+/csr77EC1DwFQOKVoWlH45ruiul/m3E80QzH0gO3I01qO+
        butK0oyir4kXqAV73EBM3BpRC+r+vK4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-IkbSgI1AN3OnXgpFR_rISQ-1; Wed, 30 Mar 2022 06:51:09 -0400
X-MC-Unique: IkbSgI1AN3OnXgpFR_rISQ-1
Received: by mail-wr1-f72.google.com with SMTP id s13-20020adfa28d000000b00205e049cff2so87680wra.17
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 03:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wnMSItC8n0CDYr8QTJ4aTsqJAmXh/a7xPpLx6HfylVg=;
        b=cBWpLA9ojN1EuYkChWx/+t6uiXFEBkqtEqRfk9XVponVNfzQVkhMwyOXQ1CwY2V26W
         QTbsWKYaKPbaAaOUOdHvDILkD9a6KtqlGR+8BZS34qDYTLCPtmrQ1NQowhkbP2y7PdFQ
         UFJFIY4lL0OmHOiy6Zs0xCzw48nsXvT14XiZCaoNGjkPWEVj1XXoS+4Q2wflYV1naJ9K
         ECr53CfKOxNt6M3ipL39dDE3WqCzMWFTMM18XS6Cf82k/XyFxgRS2OaxQatV2aYVY7JG
         EagErSruXjbRRBRIwP2rGI0DlhAiFOJAPAJwdKIqMrbJtPbMeBCeZsNVs8ef6rOlFmKP
         W3Mw==
X-Gm-Message-State: AOAM531Er7DQiKF7ZRcKG85hrrtyO1EhnZM3ZbpVAWqi0tciBO1R+BrI
        ynIAiVWaPQxWU0gNhupDPjv/xmVDz3SdKq73tMBBxNvHCuY0y2I+TpwvjPF/btOfWzmJ+qmL3VJ
        QLK47zvQJ+Emr
X-Received: by 2002:a5d:66ca:0:b0:203:f9b1:dfc0 with SMTP id k10-20020a5d66ca000000b00203f9b1dfc0mr36046495wrw.146.1648637468405;
        Wed, 30 Mar 2022 03:51:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBZEJlZUuM9T8weSZ6dyHvg5KLz9n08nG046N4t/DHrijmrL4VGxtkumOjoOLwAE/zUA3xxQ==
X-Received: by 2002:a5d:66ca:0:b0:203:f9b1:dfc0 with SMTP id k10-20020a5d66ca000000b00203f9b1dfc0mr36046468wrw.146.1648637468157;
        Wed, 30 Mar 2022 03:51:08 -0700 (PDT)
Received: from redhat.com ([2.52.9.207])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b0038caf684679sm6436194wmq.0.2022.03.30.03.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 03:51:07 -0700 (PDT)
Date:   Wed, 30 Mar 2022 06:51:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] virtio: support advance DMA
Message-ID: <20220330065039-mutt-send-email-mst@kernel.org>
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
 <20220330023258-mutt-send-email-mst@kernel.org>
 <CACGkMEvESXv9PfMF9riPraX59j0BiLPfTgxuFVw1x0HWwjtYVQ@mail.gmail.com>
 <1648623508.9711535-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvE_wUNa=DgumVErTjp5gF4QRMDn6eP7UbDpSfSJSBy2Q@mail.gmail.com>
 <1648631012.1186295-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648631012.1186295-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 30, 2022 at 05:03:32PM +0800, Xuan Zhuo wrote:
> On Wed, 30 Mar 2022 16:38:18 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Wed, Mar 30, 2022 at 2:59 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Wed, 30 Mar 2022 14:56:17 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > On Wed, Mar 30, 2022 at 2:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Feb 24, 2022 at 07:03:53PM +0800, Xuan Zhuo wrote:
> > > > > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > > > > virtqueue_add().
> > > > > >
> > > > > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > > > > it is necessary for us to support passing the DMA address to virtqueue_add().
> > > > >
> > > > > I picked up a couple of patches. Others are waiting for some acks
> > > > > (Jason?) and improved commit logs for documentation.
> > > >
> > > > I will review them.
> > >
> > > hi, the core code of premapped, I will merge it into 'virtio pci support
> > > VIRTIO_F_RING_RESET' because this function will be used when reusing the buffer
> > > after resize.
> >
> > I still prefer not to do that.
> >
> > We can make rest work for resize first and add pre mapping on top. It
> > will simplify the review.
> 
> Yes, I am also worried about the review problem, the number of my local resize
> patch has reached 44 (including reuse bufs).
> 
> hi, Michael, can we implement resize on top of v8 first? (drop unused bufs directly)
> 
> Then we implement premmapd and reuse the bufs after resize.
> 
> We need to get the address (DMA address) and len from the reset ring and submit
> it to the new vq through virtqueue_add(). So let virtqueue_add() support
> premapped first.
> 
> Thanks.

Not sure I understand.
So the plan is
- remap
- resize on top
?



> 
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks!
> > > > >
> > > > > > v2:
> > > > > >     1. rename predma -> premapped
> > > > > >     2. virtio net xdp tx use virtio dma api
> > > > > >
> > > > > > v1:
> > > > > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > > > > >       of them are not supported to be PREDMA
> > > > > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > > > > >       together with the next time AF_XDP supports virtio dma
> > > > > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > > > > >       indirect desc
> > > > > >
> > > > > > Xuan Zhuo (9):
> > > > > >   virtio_ring: rename vring_unmap_state_packed() to
> > > > > >     vring_unmap_extra_packed()
> > > > > >   virtio_ring: remove flags check for unmap split indirect desc
> > > > > >   virtio_ring: remove flags check for unmap packed indirect desc
> > > > > >   virtio_ring: virtqueue_add() support premapped
> > > > > >   virtio_ring: split: virtqueue_add_split() support premapped
> > > > > >   virtio_ring: packed: virtqueue_add_packed() support premapped
> > > > > >   virtio_ring: add api virtio_dma_map() for advance dma
> > > > > >   virtio_ring: introduce virtqueue_add_outbuf_premapped()
> > > > > >   virtio_net: xdp xmit use virtio dma api
> > > > > >
> > > > > >  drivers/net/virtio_net.c     |  42 +++++-
> > > > > >  drivers/virtio/virtio_ring.c | 280 ++++++++++++++++++++++++++---------
> > > > > >  include/linux/virtio.h       |  12 ++
> > > > > >  3 files changed, 254 insertions(+), 80 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.31.0
> > > > >
> > > >
> > >
> >

