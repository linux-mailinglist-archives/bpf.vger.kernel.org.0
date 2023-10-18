Return-Path: <bpf+bounces-12529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37127CD6D8
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 10:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A2CB21238
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 08:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6E0156E6;
	Wed, 18 Oct 2023 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMblYaWx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF297125CB
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 08:44:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84261FF
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 01:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697618675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k/0liIrEL7QSkgX7qVs1vHsvuoJgLIVTs8YD9K4UGPw=;
	b=ZMblYaWxJcLQiBBcwIk5cRT0qOfLS2SrncYlvxqo8l0RBkpnn54gdpnx0bky7ViVY/H0Qc
	FgVLSff151BJDpUGKofpoLqsrLD5DjC8zE8GGWCAxKLKufJoyp1dJJAamjsVRuBZnCAwA+
	uo16hU/0g8GRBlyhHkLyKOM94j2Kivo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-Dgg977wpMJGJ70NMKqwBXQ-1; Wed, 18 Oct 2023 04:44:34 -0400
X-MC-Unique: Dgg977wpMJGJ70NMKqwBXQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b2e2487c6bso1649253b6e.2
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 01:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697618673; x=1698223473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/0liIrEL7QSkgX7qVs1vHsvuoJgLIVTs8YD9K4UGPw=;
        b=BEm11ayatOv1i5/4plue46zdAT/6st7Edq79aHDCPmXUWPHORJF/vswmKt0F8++KKi
         GL1SrYOpi20bqpXY+SUxSG5uU9cClCScMLuWDAaIVip4kfJzfbMHp381ADmWECaCm/yt
         ZrdjmPyKEXBYf6j3vk23YcEgQElkr6OuGoXnUCnGshWTXn9BbsPEK0J21T1yG4L4WEqs
         VGsr5bGk1G1U8Z9Eys6PAQUWLWOJL+sfcOlM44T0gLO8wWD9y3A2wtz1tAZvhW8UkBpF
         Q9lLPZyRG+H4AezZNMB5k8DpSmj399L5qnr36Tvmknjt6VFmDelSiMVj8kODjNlyRTYO
         cfMA==
X-Gm-Message-State: AOJu0YwWe0J48VNEu+MrEMF40FaR81hyqx98FiF3ozmmJ8hL5f249ez5
	KmrHTmEmkI7PFRpprFwTmeaeKKCp7QdGuLZqF+4tkUXIfzMtAcINLN0yDl4pbQXTKaul3BHtCeZ
	y1acQ/sSwuWMG
X-Received: by 2002:a05:6808:3086:b0:3b2:e536:a442 with SMTP id bl6-20020a056808308600b003b2e536a442mr2351967oib.16.1697618673501;
        Wed, 18 Oct 2023 01:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzPGIXQARJW6F6uNFF8ujwB+n068AiJDbzKEeMj1yIirMEG5lXUYwOTS07wjyM14GpSR797g==
X-Received: by 2002:a05:6808:3086:b0:3b2:e536:a442 with SMTP id bl6-20020a056808308600b003b2e536a442mr2351949oib.16.1697618673200;
        Wed, 18 Oct 2023 01:44:33 -0700 (PDT)
Received: from redhat.com ([193.142.201.38])
        by smtp.gmail.com with ESMTPSA id v11-20020a54448b000000b003af732a2054sm581383oiv.57.2023.10.18.01.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:44:32 -0700 (PDT)
Date: Wed, 18 Oct 2023 04:44:24 -0400
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
Message-ID: <20231018044204-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
 <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
 <20231018035751-mutt-send-email-mst@kernel.org>
 <1697616022.630633-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697616022.630633-2-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 04:00:22PM +0800, Xuan Zhuo wrote:
> On Wed, 18 Oct 2023 03:59:03 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Oct 18, 2023 at 03:53:00PM +0800, Xuan Zhuo wrote:
> > > Hi Michael,
> > >
> > > Do you think it's appropriate to push the first two patches of this patch set to
> > > linux 6.6?
> > >
> > > Thanks.
> >
> > I generally treat patchsets as a whole unless someone asks me to do
> > otherwise. Why do you want this?
> 
> As we discussed, the patch set supporting AF_XDP will be push to net-next.
> But the two patchs belong to the vhost.
> 
> So, if you think that is appropriate, I will post a new patchset(include the two
> patchs without virtio-net + AF_XDP) to vhost. I wish that can be merged to 6.6.

Oh wait 6.6? Too late really, merge window has been closed for weeks.

> Then when the 6.7 net-next merge window is open, I can push this patch set to 6.7.
> The v1 version use the virtqueue_dma_map_single_attrs to replace
> virtqueue_dma_map_page_attrs. But I think we should use virtqueue_dma_map_page_attrs.
> 
> Thanks.
> 

Get a complete working patchset that causes no regressions posted first please
then we will discuss merge strategy.
I would maybe just put everything in one file for now, easier to merge,
refactor later when it's all upstream. But up to you.


> >
> > --
> > MST
> >


