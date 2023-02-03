Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B583A68926E
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 09:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjBCIi0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 03:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjBCIiZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 03:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCFB47ED9
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 00:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675413459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7TlzcS7seIBaGtc1ElIfuXPqV8FAfo/3wn3H0VyUI+E=;
        b=VQR2vI4qWmKdHwlltP+7K3p/SH4Xd7GD4IHg/Gt+ada86Pgj5065lhnPFHgzzTqHxJ7e98
        e+WhlgGiTCPeYaHPNyxwr1sEcxPcGNh2GwbnE+SG0RUenmgw3L0lgiKdJIbjnEyCss1UDD
        nwPJtK2GIo5z09YK8TXW0gZs45+u+sg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-283-3uyWOwlJO5-cWmrx_8xWcA-1; Fri, 03 Feb 2023 03:37:38 -0500
X-MC-Unique: 3uyWOwlJO5-cWmrx_8xWcA-1
Received: by mail-wm1-f69.google.com with SMTP id l38-20020a05600c1d2600b003ddff4b9a40so2241215wms.9
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 00:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TlzcS7seIBaGtc1ElIfuXPqV8FAfo/3wn3H0VyUI+E=;
        b=nLpzmke8Y68o2mtz9lu8/HnHyqZBTPixF+0XARi5BDvvA/n89GFtiiyWo/2cIJm35h
         wQ17LdT01TsQ3A2GyxRSzf9874RuDH9MiSuOLRYZ4lSYLvq8GTyiCDQMAb3lWdLY9Vz0
         YV2kua9JkGZWgFICYfpZQarE6UpeSOSqXyWzKp+4oOicI53u6WYZIYZYzqU2E9xIkdIh
         vJymJJNm4Plj9c53HNjRnL5vjdDsgpgrHUMW3CuwsV9tHy/L+CHZLmK4XYAr7AWUf19U
         QdQFgmNlI4v5vUZWptJzxSJbVGj3O9dMZFvjvbQS5SRjZ3kZQkomHHLlN27eut87NfHH
         S6cA==
X-Gm-Message-State: AO0yUKVgw2LzE6/GTOGSOWTCy/tAkBbITwuR3nLIWNHmDqeiqgswMozN
        nuauT/Eh/KcUfSZdGj0vvzM1afSNGh9K9peXyTsAXgPC84HUz7fDqnoNUcO41DydX2yj1p7cfMi
        EqRG0z0tFuULW
X-Received: by 2002:a05:600c:4f4e:b0:3dc:5baf:df01 with SMTP id m14-20020a05600c4f4e00b003dc5bafdf01mr8649121wmq.5.1675413457268;
        Fri, 03 Feb 2023 00:37:37 -0800 (PST)
X-Google-Smtp-Source: AK7set/RPW2WAWaTuKsXO5Yvg/JI0uqQ/bc9WDzqoSbtkrWppWMrDb2fom0hSvqVmim9wpfcc8PcBA==
X-Received: by 2002:a05:600c:4f4e:b0:3dc:5baf:df01 with SMTP id m14-20020a05600c4f4e00b003dc5bafdf01mr8649107wmq.5.1675413457090;
        Fri, 03 Feb 2023 00:37:37 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b003dd1c15e7fcsm8095193wmq.15.2023.02.03.00.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:37:36 -0800 (PST)
Date:   Fri, 3 Feb 2023 03:37:32 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
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
Message-ID: <20230203033405-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <5fda6140fa51b4d2944f77b9e24446e4625641e2.camel@redhat.com>
 <1675395211.6279888-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675395211.6279888-2-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 11:33:31AM +0800, Xuan Zhuo wrote:
> On Thu, 02 Feb 2023 15:41:44 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> > On Thu, 2023-02-02 at 19:00 +0800, Xuan Zhuo wrote:
> > > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > > performance of zero copy is very good. mlx5 and intel ixgbe already support
> > > this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> > > feature.
> > >
> > > Virtio-net did not support per-queue reset, so it was impossible to support XDP
> > > Socket Zerocopy. At present, we have completed the work of Virtio Spec and
> > > Kernel in Per-Queue Reset. It is time for Virtio-Net to complete the support for
> > > the XDP Socket Zerocopy.
> > >
> > > Virtio-net can not increase the queue at will, so xsk shares the queue with
> > > kernel.
> > >
> > > On the other hand, Virtio-Net does not support generate interrupt manually, so
> > > when we wakeup tx xmit, we used some tips. If the CPU run by TX NAPI last time
> > > is other CPUs, use IPI to wake up NAPI on the remote CPU. If it is also the
> > > local CPU, then we wake up sofrirqd.
> >
> > Thank you for the large effort.
> >
> > Since this will likely need a few iterations, on next revision please
> > do split the work in multiple chunks to help the reviewer efforts -
> > from Documentation/process/maintainer-netdev.rst:
> >
> >  - don't post large series (> 15 patches), break them up
> >
> > In this case I guess you can split it in 1 (or even 2) pre-req series
> > and another one for the actual xsk zero copy support.
> 
> 
> OK.
> 
> I can split patch into multiple parts such as
> 
> * virtio core
> * xsk
> * virtio-net prepare
> * virtio-net support xsk zerocopy
> 
> However, there is a problem, the virtio core part should enter the VHOST branch
> of Michael. Then, should I post follow-up patches to which branch vhost or
> next-next?
> 
> Thanks.

I personally think 33 patches is still manageable no need to split.
Do try to be careful and track acks and changes: if someone sends an ack
add it in the patch if you change the patch drop the acks,
and logs this fact in the changelog in the cover letter
so people know they need to re-review.


> 
> >
> > Thanks!
> >
> > Paolo
> >

