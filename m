Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108CE6C3198
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 13:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCUMYO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 08:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjCUMYN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 08:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EB54D2AF
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 05:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679401352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bhYIAqjSaFFOuKGO8P8w2NdVEdEzB+ZDIXOhFeNjrwE=;
        b=d3IC7mdkoxIxYwjzkiKl3bJ2nLlF8zOLbOy1+U9rMrHuAf87nY1j0jojEFbcnQWKjwwns9
        hglmSG0gn0nJ0L7nL+S422a7IIlFS7BHTmHRfcdA1sugnpo1xrQS5rOOCedO5MRjoTCPLu
        ULmTEsaHgYWpe/Iue/hH3mAlyhhapM4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-gRNfBjw-MJ-6WLLRUZBtpw-1; Tue, 21 Mar 2023 08:22:30 -0400
X-MC-Unique: gRNfBjw-MJ-6WLLRUZBtpw-1
Received: by mail-wr1-f72.google.com with SMTP id u27-20020adfa19b000000b002d3b9266941so1181402wru.2
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 05:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679401350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhYIAqjSaFFOuKGO8P8w2NdVEdEzB+ZDIXOhFeNjrwE=;
        b=7TnU2VqOkGW6KaoeBciwfPWl6z4xgiyjyfpFNPGMZiL0XUBC2CKv+aHtK4NhkjylVw
         Jcbb6kBBdD8lIuv4vhM1EEdDWkGfqUTwUu2QwHaeLaG7pf5ARLKe4/4aZnQIQ6AH5UZ5
         E4akuE6+sLklpBqmlWolSmzDHrnVEhhvQhmmt1KGR1DrxmxtmlWzt8keAXhfcczzsrnk
         Oris/yGaaJdl++B7/upwwSBHrbtHCkuviZQ2iMwwQYd308TFta/AmNG0Qtttl4Nz4fYN
         90TSJ7SnPIMmDc0iBhTEQacd8CDT/F39Y80i9mrfCfZzRNb3fdPsICNeJF/JWphChvCQ
         8zJQ==
X-Gm-Message-State: AO0yUKWWhJOsCj+Z9wa47/s/bH7DtYHLPGTjqYZ4TQc4NjDPoZm0KsqT
        7Hlm9SZSSh/4tp8IiWnjR3mfNNZZdRzq+U+dAPjX1DjT9fFPWcdIKc2EtPwiHHXqfFTJdXeM8wx
        jEhAJ2rijPDqF
X-Received: by 2002:a1c:f20e:0:b0:3ed:ac66:9445 with SMTP id s14-20020a1cf20e000000b003edac669445mr2297562wmc.8.1679401349796;
        Tue, 21 Mar 2023 05:22:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set8YeKutAAOEemeAKynuByQv3FxmQfnuDB21wRMtth8a1Pu+Sesej59PAmO4YgxyGIvYNZKqfg==
X-Received: by 2002:a1c:f20e:0:b0:3ed:ac66:9445 with SMTP id s14-20020a1cf20e000000b003edac669445mr2297546wmc.8.1679401349536;
        Tue, 21 Mar 2023 05:22:29 -0700 (PDT)
Received: from redhat.com ([2.52.1.105])
        by smtp.gmail.com with ESMTPSA id c16-20020a7bc850000000b003ee2bed222asm2127363wml.32.2023.03.21.05.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 05:22:29 -0700 (PDT)
Date:   Tue, 21 Mar 2023 08:22:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC net-next 0/8] virtio_net: refactor xdp codes
Message-ID: <20230321082216-mutt-send-email-mst@kernel.org>
References: <20230315041042.88138-1-xuanzhuo@linux.alibaba.com>
 <1679399929.1424522-1-xuanzhuo@linux.alibaba.com>
 <1679401220.8186114-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679401220.8186114-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 21, 2023 at 08:20:20PM +0800, Xuan Zhuo wrote:
> On Tue, 21 Mar 2023 19:58:49 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > On Wed, 15 Mar 2023 12:10:34 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > Due to historical reasons, the implementation of XDP in virtio-net is relatively
> > > chaotic. For example, the processing of XDP actions has two copies of similar
> > > code. Such as page, xdp_page processing, etc.
> > >
> > > The purpose of this patch set is to refactor these code. Reduce the difficulty
> > > of subsequent maintenance. Subsequent developers will not introduce new bugs
> > > because of some complex logical relationships.
> > >
> > > In addition, the supporting to AF_XDP that I want to submit later will also need
> > > to reuse the logic of XDP, such as the processing of actions, I don't want to
> > > introduce a new similar code. In this way, I can reuse these codes in the
> > > future.
> > >
> > > This patches are developed on the top of another patch set[1]. I may have to
> > > wait to merge this. So this patch set is a RFC.
> >
> >
> > Hi, Jason:
> >
> > Now, the patch set[1] has been in net-next. So this patch set can been merge
> > into net-next.
> >
> > Please review.
> 
> 
> I do not know why this patch set miss Jason. I send it normally. ^_^
> 
> Thanks.


repost as non-rfc.

> 
> 
> >
> > Thanks.
> >
> >
> > >
> > > Please review.
> > >
> > > Thanks.
> > >
> > > [1]. https://lore.kernel.org/netdev/20230315015223.89137-1-xuanzhuo@linux.alibaba.com/
> > >
> > >
> > > Xuan Zhuo (8):
> > >   virtio_net: mergeable xdp: put old page immediately
> > >   virtio_net: mergeable xdp: introduce mergeable_xdp_prepare
> > >   virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
> > >     run xdp
> > >   virtio_net: separate the logic of freeing xdp shinfo
> > >   virtio_net: separate the logic of freeing the rest mergeable buf
> > >   virtio_net: auto release xdp shinfo
> > >   virtio_net: introduce receive_mergeable_xdp()
> > >   virtio_net: introduce receive_small_xdp()
> > >
> > >  drivers/net/virtio_net.c | 615 +++++++++++++++++++++++----------------
> > >  1 file changed, 357 insertions(+), 258 deletions(-)
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> > > _______________________________________________
> > > Virtualization mailing list
> > > Virtualization@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

