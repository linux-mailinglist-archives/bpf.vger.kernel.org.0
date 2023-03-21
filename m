Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F0E6C3185
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 13:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjCUMWH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 08:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjCUMVy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 08:21:54 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401CC3CE3E;
        Tue, 21 Mar 2023 05:21:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VeN-dCC_1679401303;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VeN-dCC_1679401303)
          by smtp.aliyun-inc.com;
          Tue, 21 Mar 2023 20:21:44 +0800
Message-ID: <1679401220.8186114-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next 0/8] virtio_net: refactor xdp codes
Date:   Tue, 21 Mar 2023 20:20:20 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
References: <20230315041042.88138-1-xuanzhuo@linux.alibaba.com>
 <1679399929.1424522-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1679399929.1424522-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 21 Mar 2023 19:58:49 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Wed, 15 Mar 2023 12:10:34 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > Due to historical reasons, the implementation of XDP in virtio-net is relatively
> > chaotic. For example, the processing of XDP actions has two copies of similar
> > code. Such as page, xdp_page processing, etc.
> >
> > The purpose of this patch set is to refactor these code. Reduce the difficulty
> > of subsequent maintenance. Subsequent developers will not introduce new bugs
> > because of some complex logical relationships.
> >
> > In addition, the supporting to AF_XDP that I want to submit later will also need
> > to reuse the logic of XDP, such as the processing of actions, I don't want to
> > introduce a new similar code. In this way, I can reuse these codes in the
> > future.
> >
> > This patches are developed on the top of another patch set[1]. I may have to
> > wait to merge this. So this patch set is a RFC.
>
>
> Hi, Jason:
>
> Now, the patch set[1] has been in net-next. So this patch set can been merge
> into net-next.
>
> Please review.


I do not know why this patch set miss Jason. I send it normally. ^_^

Thanks.



>
> Thanks.
>
>
> >
> > Please review.
> >
> > Thanks.
> >
> > [1]. https://lore.kernel.org/netdev/20230315015223.89137-1-xuanzhuo@linux.alibaba.com/
> >
> >
> > Xuan Zhuo (8):
> >   virtio_net: mergeable xdp: put old page immediately
> >   virtio_net: mergeable xdp: introduce mergeable_xdp_prepare
> >   virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
> >     run xdp
> >   virtio_net: separate the logic of freeing xdp shinfo
> >   virtio_net: separate the logic of freeing the rest mergeable buf
> >   virtio_net: auto release xdp shinfo
> >   virtio_net: introduce receive_mergeable_xdp()
> >   virtio_net: introduce receive_small_xdp()
> >
> >  drivers/net/virtio_net.c | 615 +++++++++++++++++++++++----------------
> >  1 file changed, 357 insertions(+), 258 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
