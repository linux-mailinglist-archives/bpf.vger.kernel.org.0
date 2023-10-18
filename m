Return-Path: <bpf+bounces-12531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1E67CD799
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 11:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB66E1C20CEF
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02849171D1;
	Wed, 18 Oct 2023 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAt+nm9/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C2156D8
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 09:13:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7774BF7
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697620437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v98xBIyBJ/sPUC9GJh7rulg1/URL0/oOEeAw0GP7jZM=;
	b=JAt+nm9/2FjaAw3jFKQLTVp5KrJaROSS4dQAZ1o9oMDgKBlpnvzeGczieNnZupkyniGYMk
	XzTHRm7ZvNtdF72nwr0Bpt0JGVxWvQQbrg6rSqiI78chbYRit8xkgFso0q+nMaxylJoHsO
	mzU7xHU++aW258z6O3oNSfEIqvAfBaU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-MxqyLZ-gPua9tkkcuFYtig-1; Wed, 18 Oct 2023 05:13:51 -0400
X-MC-Unique: MxqyLZ-gPua9tkkcuFYtig-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b9ecd8c351so463049966b.1
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 02:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697620430; x=1698225230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v98xBIyBJ/sPUC9GJh7rulg1/URL0/oOEeAw0GP7jZM=;
        b=N9qhqm4fsTivYu3suacEIUPmAdusXbzot74hdr5bSb/CcKA9xBowtoqgSTJI564po1
         RKNwYVknMzXsCEhLihhICjaSnMGnTkmxrsxIt+M7EIuWNQkVTNs2g4wWX3owD0SI3X4g
         wi6qEPCDcO2er4jP7/ggW4R4uDeViXl3Fd94nc6dzysrv32VI3IopR/uEG8Lo7ZOVQo9
         8J8Qoh/8OtFHUviV1MvhJcQN2ajpfIsKs4oFjY7ML1EYcqesbiA3cYRSRB6D0F5aPX+c
         yl/Nxc3siyc1G/r1Vpvb4ApI26SA42ROG9TnTJYm13M8TU2BdEjiBEQ7IZrNDrMoIA/s
         qLcA==
X-Gm-Message-State: AOJu0Yz76w+GDu8YE2MQ8XrgZvXyXsSeZLkBocUwEweSaNKpYrvTi5/N
	sqJ2t/ouMSMFDUWEFua6OQDLvbiuQcOJ7Fk+QCVr6hm3JvPbu8zyuzL07AMwXgEI8msnqh+sMXg
	iti0CpGsgqnFY
X-Received: by 2002:a17:907:72d0:b0:9a9:ef41:e5c7 with SMTP id du16-20020a17090772d000b009a9ef41e5c7mr3845026ejc.8.1697620430381;
        Wed, 18 Oct 2023 02:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+QMli7NKSSKCArCyKPit9urwbgTh0jXYZj5BcmUsdRcVCgnT75EXLlIW5G/G2XZ6Kd+BSHQ==
X-Received: by 2002:a17:907:72d0:b0:9a9:ef41:e5c7 with SMTP id du16-20020a17090772d000b009a9ef41e5c7mr3845014ejc.8.1697620430054;
        Wed, 18 Oct 2023 02:13:50 -0700 (PDT)
Received: from redhat.com ([193.142.201.38])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709061c5a00b009adcb6c0f0esm1233352ejg.193.2023.10.18.02.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:13:49 -0700 (PDT)
Date: Wed, 18 Oct 2023 05:13:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH vhost 02/22] virtio_ring: introduce
 virtqueue_dma_[un]map_page_attrs
Message-ID: <20231018051201-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
 <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
 <20231018035751-mutt-send-email-mst@kernel.org>
 <1697616022.630633-2-xuanzhuo@linux.alibaba.com>
 <20231018044204-mutt-send-email-mst@kernel.org>
 <1697619441.5367694-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697619441.5367694-3-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 04:57:21PM +0800, Xuan Zhuo wrote:
> On Wed, 18 Oct 2023 04:44:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Oct 18, 2023 at 04:00:22PM +0800, Xuan Zhuo wrote:
> > > On Wed, 18 Oct 2023 03:59:03 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Oct 18, 2023 at 03:53:00PM +0800, Xuan Zhuo wrote:
> > > > > Hi Michael,
> > > > >
> > > > > Do you think it's appropriate to push the first two patches of this patch set to
> > > > > linux 6.6?
> > > > >
> > > > > Thanks.
> > > >
> > > > I generally treat patchsets as a whole unless someone asks me to do
> > > > otherwise. Why do you want this?
> > >
> > > As we discussed, the patch set supporting AF_XDP will be push to net-next.
> > > But the two patchs belong to the vhost.
> > >
> > > So, if you think that is appropriate, I will post a new patchset(include the two
> > > patchs without virtio-net + AF_XDP) to vhost. I wish that can be merged to 6.6.
> >
> > Oh wait 6.6? Too late really, merge window has been closed for weeks.
> 
> I mean as a fix. So I ask you do you think it is appropriate?

Sure if there's a bugfix please post is separately - what issues do
these two patches fix? this is the part I'm missing. Especially patch 2
which just adds a new API.

> >
> > > Then when the 6.7 net-next merge window is open, I can push this patch set to 6.7.
> > > The v1 version use the virtqueue_dma_map_single_attrs to replace
> > > virtqueue_dma_map_page_attrs. But I think we should use virtqueue_dma_map_page_attrs.
> > >
> > > Thanks.
> > >
> >
> > Get a complete working patchset that causes no regressions posted first please
> > then we will discuss merge strategy.
> > I would maybe just put everything in one file for now, easier to merge,
> > refactor later when it's all upstream. But up to you.
> 
> OK. I will get a working patchset firstly.
> 
> Thanks.
> 
> >
> >
> > > >
> > > > --
> > > > MST
> > > >
> >


