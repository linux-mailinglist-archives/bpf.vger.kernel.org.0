Return-Path: <bpf+bounces-9016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2709778E301
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 01:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EFD1C20960
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 23:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4408C09;
	Wed, 30 Aug 2023 23:05:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4E7490
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 23:05:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3DECC
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693436736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NjxVK/JrpkWvoiz6/GperXEOF12luau1rGvSVhj2Bc=;
	b=gfM1/jy8KOy/Vbf7CxSFINwdUpVSyhbf1pbpw3KPWULFsuRfmLUu0cGoHonItyINru8ADi
	QERhZk+4K+bKTporZP+9uVAX3JkJxPpGOrdgmiB+sqf62mnYBmYBi2y9Givd1N7UmeGafr
	RojE4ujA/AjgClwqr6nFiBBXadGgYbg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-rnELq68MPa2-TbRZd15ITA-1; Wed, 30 Aug 2023 15:50:19 -0400
X-MC-Unique: rnELq68MPa2-TbRZd15ITA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31c5adb698aso3702101f8f.2
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 12:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693425018; x=1694029818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NjxVK/JrpkWvoiz6/GperXEOF12luau1rGvSVhj2Bc=;
        b=OIDReqnJ5O9g5qA0wBmYpzlUnUQU5fPFVzwGHnchucp0XUZ8zRiZjqs7/OaCY0QB5L
         5ql8zUYqya8yDZS8+GV0zdoaKV20jdcuVqI5qatjmeeBY2PRLqhbi7v4w2H15ZykGuYk
         36MYddFDT/Nn5IDCQ23zGLbxnUIjBkBEmwuI8Qa5v9KOz15HGKkD2nD3Ht9OrmHwDgjj
         /pU567VYKbCWOFiiSkXG7bJ+7+t86UEgDwFrk/aQihRda13xehBC5TCzdILcwwiXaaAG
         72lP4p+r3OuadW5/+7XFrr3CWev6fbw9iNKSbEUrVNaeXxUBhy8nTMYcs2HuQfT28JOm
         gslQ==
X-Gm-Message-State: AOJu0YzANHlEOW9iiZZs3EInSP2hEZI0AX16sGLJ831gfnbFeu01EVlB
	UQw9oSv3qSq6ZHjgElXKGWfyuCSmfN/tnTJkmQLmjW3Gop8KgmebDjItXzU/q3r9NmYRzC/WKMa
	f4U5sFFqjq3R9LzHGfgG3
X-Received: by 2002:adf:f9c2:0:b0:319:7134:a3cf with SMTP id w2-20020adff9c2000000b003197134a3cfmr2471114wrr.31.1693425017808;
        Wed, 30 Aug 2023 12:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPl2d8yog5OYYxnVfR719SFpTMzeSHrPCryTF2nxMjc68c11HQgd4yjH64I6CkiNALUEQ33w==
X-Received: by 2002:a17:906:18d:b0:9a2:16a7:fd0 with SMTP id 13-20020a170906018d00b009a216a70fd0mr2423093ejb.21.1693424537027;
        Wed, 30 Aug 2023 12:42:17 -0700 (PDT)
Received: from redhat.com ([2.55.167.22])
        by smtp.gmail.com with ESMTPSA id z3-20020a1709064e0300b009a19fa8d2e9sm7490757eju.206.2023.08.30.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:42:16 -0700 (PDT)
Date: Wed, 30 Aug 2023 15:42:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	jiri@nvidia.com, dtatulea@nvidia.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Gavin Li <gavinl@nvidia.com>
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt
 coalescing support
Message-ID: <20230830154200-mutt-send-email-mst@kernel.org>
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <20230713074001-mutt-send-email-mst@kernel.org>
 <1689300651.6874406-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689300651.6874406-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 10:10:51AM +0800, Xuan Zhuo wrote:
> On Thu, 13 Jul 2023 07:40:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Jul 10, 2023 at 12:20:01PM +0300, Gavin Li wrote:
> > > Currently, coalescing parameters are grouped for all transmit and receive
> > > virtqueues. This patch series add support to set or get the parameters for
> > > a specified virtqueue.
> > >
> > > When the traffic between virtqueues is unbalanced, for example, one virtqueue
> > > is busy and another virtqueue is idle, then it will be very useful to
> > > control coalescing parameters at the virtqueue granularity.
> >
> > series:
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> Why?
> 
> This series has the bug I reported.
> 
> Are you thinking that is ok? Or this is not a bug?
> 
> Thanks.
> 
> 


I missed that mail. What's the bug?

> >
> >
> >
> > > Example command:
> > > $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> > > Would set max_packets=10 to VQ 1.
> > > $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> > > Would set max_packets=10 to VQ 0.
> > > $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
> > >  Queue: 0
> > >  Adaptive RX: off  TX: off
> > >  stats-block-usecs: 0
> > >  sample-interval: 0
> > >  pkt-rate-low: 0
> > >  pkt-rate-high: 0
> > >
> > >  rx-usecs: 222
> > >  rx-frames: 0
> > >  rx-usecs-irq: 0
> > >  rx-frames-irq: 256
> > >
> > >  tx-usecs: 222
> > >  tx-frames: 0
> > >  tx-usecs-irq: 0
> > >  tx-frames-irq: 256
> > >
> > >  rx-usecs-low: 0
> > >  rx-frame-low: 0
> > >  tx-usecs-low: 0
> > >  tx-frame-low: 0
> > >
> > >  rx-usecs-high: 0
> > >  rx-frame-high: 0
> > >  tx-usecs-high: 0
> > >  tx-frame-high: 0
> > >
> > > In this patch series:
> > > Patch-1: Extract interrupt coalescing settings to a structure.
> > > Patch-2: Extract get/set interrupt coalesce to a function.
> > > Patch-3: Support per queue interrupt coalesce command.
> > > Patch-4: Enable per queue interrupt coalesce feature.
> > >
> > > Gavin Li (4):
> > >   virtio_net: extract interrupt coalescing settings to a structure
> > >   virtio_net: extract get/set interrupt coalesce to a function
> > >   virtio_net: support per queue interrupt coalesce command
> > >   virtio_net: enable per queue interrupt coalesce feature
> > >
> > >  drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
> > >  include/uapi/linux/virtio_net.h |  14 +++
> > >  2 files changed, 154 insertions(+), 29 deletions(-)
> > >
> > > --
> > > 2.39.1
> >


