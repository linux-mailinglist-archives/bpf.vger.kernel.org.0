Return-Path: <bpf+bounces-4957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C939075203D
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 13:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4B71C2131B
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08058125A6;
	Thu, 13 Jul 2023 11:40:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511011C80
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 11:40:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA75F358E
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689248419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guFh+wPFNIRuesCzeZY5yldfMavaJ0y5Zd0rOUtQc9o=;
	b=h6DJ05wp9e9KrmT3f6LWUu2SVoi/Lqj0PsOcZ++L+lcWf4yCuw8uPfGxvfzW/S2IAGZwqi
	xY5aO3Xqz258UYtzOfGrvXho41qlW+B31DaU0/njV1Hhz8ItY5ZLYPcZHmI7P2XetpVKkG
	lOV8AGxoYsjT8BjPKKKbcESrVJlGUJk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-hgB9UGQCO9OweM0WBHJ6aw-1; Thu, 13 Jul 2023 07:40:18 -0400
X-MC-Unique: hgB9UGQCO9OweM0WBHJ6aw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa9a282fffso3225355e9.1
        for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 04:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689248417; x=1691840417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guFh+wPFNIRuesCzeZY5yldfMavaJ0y5Zd0rOUtQc9o=;
        b=dFN3EcIDyBhwILe9znsqmif0c3+QpMGGYFCJdbQTvUCDBDVr8E1nPJth1BImy6o2sr
         QddlNQ7J7mLd/Z46Sz5FpAAuml+zFWhgqODZDzLDFyZd62OyQuf40OfI4eBPwhEJyM4W
         mnrolW0pYBRvIKUkjH/CRLdEfCj/C3nYpvpMaaBeU+BD65hEL567BVMBSg79BGFHlTpy
         Ou8TK9OYX59BXN6ujF28lU2MzM0CcsMrG+ga28c4GJE6fgIF60gjar/pjT4ipFquZHaJ
         AtAE8VuzqgR7FFBXe8eo3IfFjRVOPR01VzxVdCd88VCmwM9nQm1euQP5SZoyTzEZcEWd
         fQ/Q==
X-Gm-Message-State: ABy/qLb7EvvxztegwKFF5ZxjDgdyqHH5z/v1wrjvG1zVBM07iM/cACWH
	UNPSxOfCa0CN7gSq0d2Epi+qLHQhwsJtKJ8Fn+JnQbAYOmmVvKqpoj3PKdS7oyNCQOj+UryLFmr
	7kN4ktJ0RBe4p
X-Received: by 2002:a05:600c:240d:b0:3fb:b5dc:dab1 with SMTP id 13-20020a05600c240d00b003fbb5dcdab1mr1150147wmp.39.1689248417232;
        Thu, 13 Jul 2023 04:40:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHd/eNeg4sLyvuXqL+tXWMQGEDTMZBr/VxoDrK+A9Qk8/hmWz5tdxZsKTFz4SAT52dsIuaXmA==
X-Received: by 2002:a05:600c:240d:b0:3fb:b5dc:dab1 with SMTP id 13-20020a05600c240d00b003fbb5dcdab1mr1150120wmp.39.1689248416901;
        Thu, 13 Jul 2023 04:40:16 -0700 (PDT)
Received: from redhat.com ([2.52.158.233])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b003fba9db141esm18158573wmj.38.2023.07.13.04.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 04:40:16 -0700 (PDT)
Date: Thu, 13 Jul 2023 07:40:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavinl@nvidia.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt
 coalescing support
Message-ID: <20230713074001-mutt-send-email-mst@kernel.org>
References: <20230710092005.5062-1-gavinl@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710092005.5062-1-gavinl@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 12:20:01PM +0300, Gavin Li wrote:
> Currently, coalescing parameters are grouped for all transmit and receive
> virtqueues. This patch series add support to set or get the parameters for
> a specified virtqueue.
> 
> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> is busy and another virtqueue is idle, then it will be very useful to
> control coalescing parameters at the virtqueue granularity.

series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> Example command:
> $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> Would set max_packets=10 to VQ 1.
> $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> Would set max_packets=10 to VQ 0.
> $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
>  Queue: 0
>  Adaptive RX: off  TX: off
>  stats-block-usecs: 0
>  sample-interval: 0
>  pkt-rate-low: 0
>  pkt-rate-high: 0
> 
>  rx-usecs: 222
>  rx-frames: 0
>  rx-usecs-irq: 0
>  rx-frames-irq: 256
> 
>  tx-usecs: 222
>  tx-frames: 0
>  tx-usecs-irq: 0
>  tx-frames-irq: 256
> 
>  rx-usecs-low: 0
>  rx-frame-low: 0
>  tx-usecs-low: 0
>  tx-frame-low: 0
> 
>  rx-usecs-high: 0
>  rx-frame-high: 0
>  tx-usecs-high: 0
>  tx-frame-high: 0
> 
> In this patch series:
> Patch-1: Extract interrupt coalescing settings to a structure.
> Patch-2: Extract get/set interrupt coalesce to a function.
> Patch-3: Support per queue interrupt coalesce command.
> Patch-4: Enable per queue interrupt coalesce feature.
> 
> Gavin Li (4):
>   virtio_net: extract interrupt coalescing settings to a structure
>   virtio_net: extract get/set interrupt coalesce to a function
>   virtio_net: support per queue interrupt coalesce command
>   virtio_net: enable per queue interrupt coalesce feature
> 
>  drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
>  include/uapi/linux/virtio_net.h |  14 +++
>  2 files changed, 154 insertions(+), 29 deletions(-)
> 
> -- 
> 2.39.1


