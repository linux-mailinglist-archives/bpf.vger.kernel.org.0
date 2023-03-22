Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7970F6C414F
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 04:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCVDyx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 23:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCVDyr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 23:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170E82CFCA
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 20:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679457240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kmfz3AHdHTkdeXNmLeWbjpqYQCkdTd0YBubZk4XP0tI=;
        b=QA93psLWOko68VZ4P5Vswz0Ihro5QGTuhINNkpDxdhwKO5lfWkJN7GEB80YNC6+4XD6WE2
        UYX7I+9/wCwUzrs0yKrGXa4gGXAOFVn2ufefj+H2KxPIem9hs06IgYbJGoZUFoYEL6FV1N
        BXyi980B6WltwsdygB2D1A8p4umgeT0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-HDiD0FqAMnmxEW39roDvgA-1; Tue, 21 Mar 2023 23:53:58 -0400
X-MC-Unique: HDiD0FqAMnmxEW39roDvgA-1
Received: by mail-wm1-f71.google.com with SMTP id e5-20020a05600c4e4500b003edc5824521so5509319wmq.0
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 20:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679457237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kmfz3AHdHTkdeXNmLeWbjpqYQCkdTd0YBubZk4XP0tI=;
        b=rjyZlgW+IgOHG1pfgZcev//ADtu6Qna5BKzgRXaUwDtbuEW+pxKVJqvecjXB2P/QqN
         iBlGuc0si8pc8OI4UjqoMhInL+YLakLc0x6/DvYr2tfg6dSzrrniNpGvndc+GOI7MJ6c
         joDTdGLpyVVE9r6+dKuMKfG7niXVORZ+rklUO1jlwlPjZ5IfnH9EObUgpKeXmGECp//j
         U0rYu2IUl0Z6JMduXUk93med6b7jGNW1rvRK6q69fCAJfHJ2Nrk9/s7h4bpUIXRXNpa9
         t+pIWwVoZlxV85ARzbKq+AUYtN/2gavCbZzvhosghcWbbUhY19J5X993yqFfzmLVxc4k
         ScSw==
X-Gm-Message-State: AO0yUKXGHyOT2kS8nLEp0biHcFKOg4642SPHDX/sFhWoFr3sv4TDZae7
        Io4HOuGNFzKkglNBDrw+dzq11R/fOG1YrAJA9LwXi1VQzoFcJPi14nfFeSkZmkDs6vicXCIZhuM
        s6zKhPY+WwbI4
X-Received: by 2002:a5d:6409:0:b0:2cf:e8b2:4f76 with SMTP id z9-20020a5d6409000000b002cfe8b24f76mr3983619wru.66.1679457237799;
        Tue, 21 Mar 2023 20:53:57 -0700 (PDT)
X-Google-Smtp-Source: AK7set8zVCwQRMi4Rh1G47k43koQsAembGqp95czOT6L0CoZ3+ax/Z0LHSwwY9xTqnNP6PuioxViDg==
X-Received: by 2002:a5d:6409:0:b0:2cf:e8b2:4f76 with SMTP id z9-20020a5d6409000000b002cfe8b24f76mr3983603wru.66.1679457237513;
        Tue, 21 Mar 2023 20:53:57 -0700 (PDT)
Received: from redhat.com ([2.52.1.105])
        by smtp.gmail.com with ESMTPSA id o17-20020a056000011100b002d30fe0d2fcsm12753934wrx.13.2023.03.21.20.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 20:53:57 -0700 (PDT)
Date:   Tue, 21 Mar 2023 23:53:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/8] virtio_net: refactor xdp codes
Message-ID: <20230321235326-mutt-send-email-mst@kernel.org>
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230321233325-mutt-send-email-mst@kernel.org>
 <1679456456.3777983-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679456456.3777983-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 22, 2023 at 11:40:56AM +0800, Xuan Zhuo wrote:
> On Tue, 21 Mar 2023 23:34:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Mar 22, 2023 at 11:03:00AM +0800, Xuan Zhuo wrote:
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
> > > Please review.
> > >
> > > Thanks.
> >
> > I really want to see that code make progress though.
> 
> I want to know, you refer to virtio-net + AF_XDP or refactor for XDP.
> 
> > Would it make sense to merge this one through the virtio tree?
> 
> There are some small problems that we merge this patch-set to Virtio Tree
> directly.
> 
> Thanks.

what exactly? is there a dependency on net-next?

> >
> > Then you will have all the pieces in one place and try to target
> > next linux.
> >
> >
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
> >

