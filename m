Return-Path: <bpf+bounces-12035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B3F7C70B8
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 16:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270A21C21132
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FEE26288;
	Thu, 12 Oct 2023 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBZ3o7dq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008F249F0
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 14:50:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE07DA
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697122240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5BqCXztfnjL1n8qvwFlaYSxk8LlaToCm50XqHKuKoc=;
	b=bBZ3o7dqeGnPQadVYAizAggefTD9z2BNeTfKhrfwTTVjhLtaafHaOoVGSkI3U5LXwXNXUi
	Yl4lV54oNz01yeFfeyhQbGmvhIUSvhnpxCbpMxD3qNz39EJHtzeoNsbrRZ7y7nYX4zB8AY
	X9a1U0mHv6EzaR7BKYlAXqRJ8Koq66w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-88U16DJZMWqWnC1kfliyvw-1; Thu, 12 Oct 2023 10:50:38 -0400
X-MC-Unique: 88U16DJZMWqWnC1kfliyvw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fef3606d8cso8610355e9.1
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 07:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697122237; x=1697727037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5BqCXztfnjL1n8qvwFlaYSxk8LlaToCm50XqHKuKoc=;
        b=S22q1i5Zl4nXuZ3/Gxks8mfWrkk+s9RIIWyKkB7R7pMAjsPnrwVoC8Bn7WYt9my+H8
         l61jarDgKRSpD0vUFZ4A6KQwac3fr0yNNoY7lOaV5F0FOGLHiRuYWUE4SQ2hnPAWwMgQ
         4g+fqJ/asznfSgmoLb+rFjl1L0MuxmoNqQA4Xv9T2I0Nzgfn5oRTAze3DONElTWf5Zhb
         ChSx9VfdaVPA4aQ/SO9tztGFO/wZYNi+Fa35ExwQh38Ivj/bK838Tr/ynCyeMO9CULv5
         8OF36JUHC7mNcyfTXcwnFprdpfVPoLJ/tsoJo+o15vbnU3iog7azSW52q8Setpp5Q7fx
         YVFg==
X-Gm-Message-State: AOJu0YyC7EjMEaOgX+CBjwox4PzD7wUIuBFCkKf5DG+vNe0HyAKgBEE9
	pcpQOeZfAdPLsnjmUv9PAOAYwXDtl7kW+44n+5MOnf0fqR9Yd+jkOg4U/V48h/2jyG4zZqXlZd0
	giPgiqcEkxMfBr1sJOzLS
X-Received: by 2002:a05:600c:228a:b0:406:592b:e5aa with SMTP id 10-20020a05600c228a00b00406592be5aamr21389541wmf.14.1697122237106;
        Thu, 12 Oct 2023 07:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF2Vo5PT8GSdHGVGE5cwCLnapcKJkvbtEZBt90uz120dcdtwDAi2HYtfKCc8opIa1m8atskQ==
X-Received: by 2002:a05:600c:228a:b0:406:592b:e5aa with SMTP id 10-20020a05600c228a00b00406592be5aamr21389522wmf.14.1697122236749;
        Thu, 12 Oct 2023 07:50:36 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b00406408dc788sm19240wmg.44.2023.10.12.07.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 07:50:36 -0700 (PDT)
Date: Thu, 12 Oct 2023 10:50:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost 00/22] virtio-net: support AF_XDP zero copy
Message-ID: <20231012050829-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011100057.535f3834@kernel.org>
 <1697075634.444064-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsadYH8Y-KOxPX6vPic7pBqzj2DLnog5osuBDtypKgEZA@mail.gmail.com>
 <1697099560.6227698-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1697099560.6227698-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 04:32:40PM +0800, Xuan Zhuo wrote:
> On Thu, 12 Oct 2023 15:50:13 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Thu, Oct 12, 2023 at 9:58 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Wed, 11 Oct 2023 10:00:57 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > > > On Wed, 11 Oct 2023 17:27:06 +0800 Xuan Zhuo wrote:
> > > > > ## AF_XDP
> > > > >
> > > > > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > > > > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > > > > performance of zero copy is very good. mlx5 and intel ixgbe already support
> > > > > this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> > > > > feature.
> > > >
> > > > You're moving the driver and adding a major feature.
> > > > This really needs to go via net or bpf.
> > > > If you have dependencies in other trees please wait for
> > > > after the merge window.
> > >
> > >
> > > If so, I can remove the first two commits.
> > >
> > > Then, the sq uses the premapped mode by default.
> > > And we can use the api virtqueue_dma_map_single_attrs to replace the
> > > virtqueue_dma_map_page_attrs.
> > >
> > > And then I will fix that on the top.
> > >
> > > Hi Micheal and Jason, is that ok for you?
> >
> > I would go with what looks easy for you but I think Jakub wants the
> > series to go with next-next (this is what we did in the past for
> > networking specific features that is done in virtio-net). So we need
> > to tweak the prefix to use net-next instead of vhost.
> 
> OK.
> 
> I will fix that in next version.
> 
> Thanks.

Scaling scope back as far as possible is a good idea generally.
I am not sure how this will work though. Let's see.

> >
> > Thanks
> >
> >
> > >
> > > Thanks.
> > >
> >


