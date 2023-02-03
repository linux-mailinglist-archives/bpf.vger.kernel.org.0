Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F18689330
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 10:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjBCJK2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 04:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjBCJK0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 04:10:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6D412842
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 01:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675415375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/jc51KQG0w1SZ2JKvl1VHrz8cQjDpUX5SSWtJktdkfw=;
        b=RdTCPT0Hww+QElfX5ib0Q0xQuwfUHot5fAThQhyGkYJdZrdJoRLqQ5KavJyQj0A+tenVzQ
        6gLuHgO3/bD59LDwdFRJhoEnUc9JQQ1DO1JxyWShXfB6vORdO/pW/fM0x9jM1znMdO3aZd
        qi7kvZlJhyoPbVKM1qNLKQHUlVPUnmY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-147-TVvuUDACNTqI0kdFK0MMmg-1; Fri, 03 Feb 2023 04:09:34 -0500
X-MC-Unique: TVvuUDACNTqI0kdFK0MMmg-1
Received: by mail-wm1-f72.google.com with SMTP id iv6-20020a05600c548600b003dc4b8ee42fso2343170wmb.1
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 01:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jc51KQG0w1SZ2JKvl1VHrz8cQjDpUX5SSWtJktdkfw=;
        b=qQg6BRiK34i0VHqSfCVyQ7awj5pQxS92WdVKZn2t3/P+8i2nqCXG7mTWc8xLQJuQuq
         mmxF1Aw+vl8zjCA/EdJUI3u7PBnvR43QYS+y8zSv9YBqyw1XpM2DSoLZiScBd42eBDKa
         HtYrk5QZtwDkaSzlljtlcXNhyy3lrVxH/DtFsWc+c59+cv5YHTFSSvgz+TRWsP9O5SBO
         LnkIzqLEb0SHd5HKVHoARQJylUPWOQ/SNNjitn6k1D5bjYcsq0Om2BdT+rYxDMJ7s/2J
         Q5tA0EBzl9LiYdv56KEP/K1icowjc8FhwxjMW17DYD9E3EKXMXsSmmNsO1PHWTqZxoX5
         IjqQ==
X-Gm-Message-State: AO0yUKVo0yBLA78CIMOkDOuwWrmh8i+3BL9SaNZAXe2/8R0eBu9IVI5v
        z5ZcXa6CAO5E3/3YhIdckcBOeK5i1S+QJ5NUaLrwwCTec2XbxDRMXAaZ7s4a1ifCbmHGQhH/L4/
        2kbpjJzFiql1Z
X-Received: by 2002:adf:d1cc:0:b0:2bf:9465:641 with SMTP id b12-20020adfd1cc000000b002bf94650641mr11248059wrd.65.1675415372852;
        Fri, 03 Feb 2023 01:09:32 -0800 (PST)
X-Google-Smtp-Source: AK7set+TiUkutaIauQ/Tf6xE+qTDtiSxX6A28pk8T4mrOWVcvuU+FUXyr19sF+jujDTG7YmNX7j8MQ==
X-Received: by 2002:adf:d1cc:0:b0:2bf:9465:641 with SMTP id b12-20020adfd1cc000000b002bf94650641mr11248042wrd.65.1675415372633;
        Fri, 03 Feb 2023 01:09:32 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b002bfd524255esm1510845wri.43.2023.02.03.01.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 01:09:31 -0800 (PST)
Date:   Fri, 3 Feb 2023 04:09:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Menglong Dong <imagedong@tencent.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Petr Machata <petrm@nvidia.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 00/33] virtio-net: support AF_XDP zero copy
Message-ID: <20230203040855-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <5fda6140fa51b4d2944f77b9e24446e4625641e2.camel@redhat.com>
 <1675395211.6279888-2-xuanzhuo@linux.alibaba.com>
 <20230203033405-mutt-send-email-mst@kernel.org>
 <Y9zJ9j0GthvRSFHL@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9zJ9j0GthvRSFHL@boxer>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 09:46:46AM +0100, Maciej Fijalkowski wrote:
> On Fri, Feb 03, 2023 at 03:37:32AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Feb 03, 2023 at 11:33:31AM +0800, Xuan Zhuo wrote:
> > > On Thu, 02 Feb 2023 15:41:44 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> > > > On Thu, 2023-02-02 at 19:00 +0800, Xuan Zhuo wrote:
> > > > > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > > > > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > > > > performance of zero copy is very good. mlx5 and intel ixgbe already support
> > > > > this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> > > > > feature.
> > > > >
> > > > > Virtio-net did not support per-queue reset, so it was impossible to support XDP
> > > > > Socket Zerocopy. At present, we have completed the work of Virtio Spec and
> > > > > Kernel in Per-Queue Reset. It is time for Virtio-Net to complete the support for
> > > > > the XDP Socket Zerocopy.
> > > > >
> > > > > Virtio-net can not increase the queue at will, so xsk shares the queue with
> > > > > kernel.
> > > > >
> > > > > On the other hand, Virtio-Net does not support generate interrupt manually, so
> > > > > when we wakeup tx xmit, we used some tips. If the CPU run by TX NAPI last time
> > > > > is other CPUs, use IPI to wake up NAPI on the remote CPU. If it is also the
> > > > > local CPU, then we wake up sofrirqd.
> > > >
> > > > Thank you for the large effort.
> > > >
> > > > Since this will likely need a few iterations, on next revision please
> > > > do split the work in multiple chunks to help the reviewer efforts -
> > > > from Documentation/process/maintainer-netdev.rst:
> > > >
> > > >  - don't post large series (> 15 patches), break them up
> > > >
> > > > In this case I guess you can split it in 1 (or even 2) pre-req series
> > > > and another one for the actual xsk zero copy support.
> > > 
> > > 
> > > OK.
> > > 
> > > I can split patch into multiple parts such as
> > > 
> > > * virtio core
> > > * xsk
> > > * virtio-net prepare
> > > * virtio-net support xsk zerocopy
> > > 
> > > However, there is a problem, the virtio core part should enter the VHOST branch
> > > of Michael. Then, should I post follow-up patches to which branch vhost or
> > > next-next?
> > > 
> > > Thanks.
> > 
> > I personally think 33 patches is still manageable no need to split.
> > Do try to be careful and track acks and changes: if someone sends an ack
> > add it in the patch if you change the patch drop the acks,
> > and logs this fact in the changelog in the cover letter
> > so people know they need to re-review.
> 
> To me some of the patches are too granular but probably this is related to
> personal taste.

I agree here. Some unrelated refactoring can also be deferred.

> However, I would like to ask to check how this series
> affects existing ZC enabled driver(s), since xsk core is touched.
> 
> > 
> > 
> > > 
> > > >
> > > > Thanks!
> > > >
> > > > Paolo
> > > >
> > 

