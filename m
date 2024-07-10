Return-Path: <bpf+bounces-34360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC30892CA61
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 08:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B77F1F22DE5
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 06:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A5D4F8A0;
	Wed, 10 Jul 2024 06:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEIkr5hg"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA02A47
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591703; cv=none; b=eup6TPsz/zsBSHsqJBe3lqXB9cyYM7QAlIR+ooeIKYGbvB+OQYlQe/ZVbjAiZmO2pxFZ8JwG1I2W3G73YLwkEAwcnjkGdGVuW7oLMiPJnJ7Dwmfk74kUbsoPdB80qEHybk0tWhqI+i3ixTZf8G2/UqGWAOa0vtm73AjqIY//gnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591703; c=relaxed/simple;
	bh=0GSnnI2E75/xHcq1KRMe5imkyVdfr9Ns6f6e5UbgkiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYM70XNgyxeEeT+JFBFA32qLXCn802+yrzN+ddDP2GLsNUtc3fLosHYtyGAQec9MouI+wweGYIP+4vYBXmzpcOBmoCalFtcMXCr9zolwlgjqKXpJN/1oZEEUy1A+05owBhTeXt8Zp+lWyGUqXB3C8zgdCf7B3IUVNPM6wk6ySLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEIkr5hg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720591700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+a5Bsaje1eJa/kkPg7uCWmicdAXq2GafTFhZCyZDwSc=;
	b=YEIkr5hgKzVs/c9//HHZ7k7dKMfJK5A728B8ko5lRT0YNJlDuYwG+YD2l/0A5tKcajVpd/
	9LKkvc0nllnoT8fsc3Mo7ZUMnnkfONmN4+aPpkNQSYaQur7A8dOjm1WB33v7TFXTVPlLjV
	xYns5fED+qIZeMQhAyLWeSFb9rIYsiU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-Gp6sQrjtP3epHil-G6ebsQ-1; Wed, 10 Jul 2024 02:08:18 -0400
X-MC-Unique: Gp6sQrjtP3epHil-G6ebsQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3679ed08797so4013097f8f.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 23:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720591694; x=1721196494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+a5Bsaje1eJa/kkPg7uCWmicdAXq2GafTFhZCyZDwSc=;
        b=P7BXmm3HAWMOvmzzLM8VkRXuHtHLxJqPkyEnjh9fij+T0aWEBHspfbZHbiyPCxidQ8
         QTiUIvMRbln/2RSTKD8OvyErVYdXJRBUotbPfVlGrhHYOy8+ys16bL8fbYGO1Vfmi/9R
         nrVVJfyI8YUeawAIXnrPyx31h89FRy8PYeWTD0PblJ+7sqK8kQl1H7E8oyx3f3Zp62Qd
         45hGIh/ZGOdNVbn8m1yrKorhGFUtyjtnF1lfiFTRs9CKC/AnEEZtSnIwOBWFbIbvYvpq
         i3rAsMtewHS6Rf7mtba5oiY6woLlsq+9n+JpdbzMT0seY4PbkS2bn9bk/Jwx2W6ZZnCQ
         eQUA==
X-Forwarded-Encrypted: i=1; AJvYcCW+dUQLr4soETjI/jxDfpsJzlt1TkygDXRgk7143YVQ8tw7IPM28eXu2yYwqn0xc/6pNJ9ucr2DH+MiwmxyywkO8QKE
X-Gm-Message-State: AOJu0Yx8S7Zu7S+MRX20fO6vgId4YIqTqAyn5kD9ijY7p5qhnHwVMVsx
	e7A6FGBAAKNWBObAdlnb1bPoMHO+k1pGkkLqkAJ8fTX03rHkHWrJvKFfefgLK4e2aGptoO9mJ9Y
	x/JYQhy2q/L++lwF8yaMOfu3zo8EOgVeHHM5EqTC8avBpOdktGA==
X-Received: by 2002:a5d:548b:0:b0:362:c7b3:764c with SMTP id ffacd0b85a97d-367ceac47bfmr3031054f8f.48.1720591694649;
        Tue, 09 Jul 2024 23:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSNewYLXe+QfNePgWKsGj1IbTMsfyHo7p6gwn0lDSCj5oPC4X9trCqnic5Odo00Hvu/C7feg==
X-Received: by 2002:a5d:548b:0:b0:362:c7b3:764c with SMTP id ffacd0b85a97d-367ceac47bfmr3031020f8f.48.1720591693882;
        Tue, 09 Jul 2024 23:08:13 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde848e7sm4291385f8f.44.2024.07.09.23.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:08:12 -0700 (PDT)
Date: Wed, 10 Jul 2024 02:08:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 00/10] virtio-net: support AF_XDP zero copy
Message-ID: <20240710020746-mutt-send-email-mst@kernel.org>
References: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com>

On Mon, Jul 08, 2024 at 07:25:27PM +0800, Xuan Zhuo wrote:
> v8:
>     1. virtnet_add_recvbuf_xsk() always return err, when encounters error
> 
> v7:
>     1. some small fixes
> 
> v6:
>     1. start from supporting the rx zerocopy
> 
> v5:
>     1. fix the comments of last version
>         http://lore.kernel.org/all/20240611114147.31320-1-xuanzhuo@linux.alibaba.com
> v4:
>     1. remove the commits that introduce the independent directory
>     2. remove the supporting for the rx merge mode (for limit 15
>        commits of net-next). Let's start with the small mode.
>     3. merge some commits and remove some not important commits


Series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ## AF_XDP
> 
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already support
> this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> feature.
> 
> At present, we have completed some preparation:
> 
> 1. vq-reset (virtio spec and kernel code)
> 2. virtio-core premapped dma
> 3. virtio-net xdp refactor
> 
> So it is time for Virtio-Net to complete the support for the XDP Socket
> Zerocopy.
> 
> Virtio-net can not increase the queue num at will, so xsk shares the queue with
> kernel.
> 
> On the other hand, Virtio-Net does not support generate interrupt from driver
> manually, so when we wakeup tx xmit, we used some tips. If the CPU run by TX
> NAPI last time is other CPUs, use IPI to wake up NAPI on the remote CPU. If it
> is also the local CPU, then we wake up napi directly.
> 
> This patch set includes some refactor to the virtio-net to let that to support
> AF_XDP.
> 
> ## Run & Test
> 
> Because there are too many commits, the work of virtio net supporting af-xdp is
> split to rx part and tx part. This patch set is for rx part.
> 
> So the flag NETDEV_XDP_ACT_XSK_ZEROCOPY is not added, if someone want to test
> for af-xdp rx, the flag needs to be adding locally.
> 
> ## performance
> 
> ENV: Qemu with vhost-user(polling mode).
> Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
> 
> ### virtio PMD in guest with testpmd
> 
> testpmd> show port stats all
> 
>  ######################## NIC statistics for port 0 ########################
>  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
>  RX-errors: 0
>  RX-nombuf: 0
>  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
> 
> 
>  Throughput (since last show)
>  Rx-pps:   8861574     Rx-bps:  3969985208
>  Tx-pps:   8861493     Tx-bps:  3969962736
>  ############################################################################
> 
> ### AF_XDP PMD in guest with testpmd
> 
> testpmd> show port stats all
> 
>   ######################## NIC statistics for port 0  ########################
>   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
> 
>   Throughput (since last show)
>   Rx-pps:      6333196          Rx-bps:   2837272088
>   Tx-pps:      6333227          Tx-bps:   2837285936
>   ############################################################################
> 
> But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
> 
> Please review.
> 
> Thanks.
> 
> v3
>     1. virtio introduces helpers for virtio-net sq using premapped dma
>     2. xsk has more complete support for merge mode
>     3. fix some problems
> 
> v2
>     1. wakeup uses the way of GVE. No send ipi to wakeup napi on remote cpu.
>     2. remove rcu. Because we synchronize all operat, so the rcu is not needed.
>     3. split the commit "move to virtio_net.h" in last patch set. Just move the
>        struct/api to header when we use them.
>     4. add comments for some code
> 
> v1:
>     1. remove two virtio commits. Push this patchset to net-next
>     2. squash "virtio_net: virtnet_poll_tx support rescheduled" to xsk: support tx
>     3. fix some warnings
> 
> 
> 
> 
> 
> 
> 
> 
> Xuan Zhuo (10):
>   virtio_net: replace VIRTIO_XDP_HEADROOM by XDP_PACKET_HEADROOM
>   virtio_net: separate virtnet_rx_resize()
>   virtio_net: separate virtnet_tx_resize()
>   virtio_net: separate receive_buf
>   virtio_net: separate receive_mergeable
>   virtio_net: xsk: bind/unbind xsk for rx
>   virtio_net: xsk: support wakeup
>   virtio_net: xsk: rx: support fill with xsk buffer
>   virtio_net: xsk: rx: support recv small mode
>   virtio_net: xsk: rx: support recv merge mode
> 
>  drivers/net/virtio_net.c | 770 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 676 insertions(+), 94 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


