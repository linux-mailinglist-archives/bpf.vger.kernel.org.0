Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE586C413C
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 04:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCVDqQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 23:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCVDqP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 23:46:15 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB12E805;
        Tue, 21 Mar 2023 20:46:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VeP8tPG_1679456770;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VeP8tPG_1679456770)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 11:46:11 +0800
Message-ID: <1679456456.3777983-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/8] virtio_net: refactor xdp codes
Date:   Wed, 22 Mar 2023 11:40:56 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230321233325-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230321233325-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 21 Mar 2023 23:34:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Mar 22, 2023 at 11:03:00AM +0800, Xuan Zhuo wrote:
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
> > Please review.
> >
> > Thanks.
>
> I really want to see that code make progress though.

I want to know, you refer to virtio-net + AF_XDP or refactor for XDP.

> Would it make sense to merge this one through the virtio tree?

There are some small problems that we merge this patch-set to Virtio Tree
directly.

Thanks.

>
> Then you will have all the pieces in one place and try to target
> next linux.
>
>
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
>
