Return-Path: <bpf+bounces-6206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B65376700D
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F228282742
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66CC13FF5;
	Fri, 28 Jul 2023 15:03:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279A1C06;
	Fri, 28 Jul 2023 15:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DA8C433C7;
	Fri, 28 Jul 2023 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690556587;
	bh=aBoOKhoaUCGMYOAS2SVseE8E9QPHZohYl5szbxWmGgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nyAxYTFvWI5eowMg9P5ioBj2GPfjcB3E018GKHGw4T8+n116byzfjawJszB8j6F+5
	 mfkywy6ivSuy9CG6JXu74CRUvObbHXQuPKO5NZ4wu9Q9RtWmJYHLfPi3/P6ku7Xzip
	 ErugvWBJb7HHH8PIL0NoKgFjfzJct9Y1/9078Z+d4h8IqkCwUYjMgVY5AYTpjhvpEM
	 d2oPOSZpbW5UWb4vjLS34QjJq45XsYEoMZO3p6TuF5xNnssndl6Yky5G1TnkeqUnCB
	 B19iC32SFwGwHiDYuVgsZvGkA1+q+Ga6TXjaUA8UZ5vxV5p+BoY9o5XeEM4YHO2x06
	 +ubV+gcabKAsg==
Date: Fri, 28 Jul 2023 08:03:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org, Jason Wang
 <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce
 virtqueue_dma_dev()
Message-ID: <20230728080305.5fe3737c@kernel.org>
In-Reply-To: <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
	<20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
	<ZK/cxNHzI23I6efc@infradead.org>
	<20230713104805-mutt-send-email-mst@kernel.org>
	<ZLjSsmTfcpaL6H/I@infradead.org>
	<20230720131928-mutt-send-email-mst@kernel.org>
	<ZL6qPvd6X1CgUD4S@infradead.org>
	<1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
	<20230725033321-mutt-send-email-mst@kernel.org>
	<1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
	<1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 14:02:33 +0800 Xuan Zhuo wrote:
> Hi guys, this topic is stuck again. How should I proceed with this work?
> 
> Let me briefly summarize:
> 1. The problem with adding virtio_dma_{map, sync} api is that, for AF_XDP and
> the driver layer, we need to support these APIs. The current conclusion of
> AF_XDP is no.
> 
> 2. Set dma_set_mask_and_coherent, then we can use DMA API uniformly inside
> driver. This idea seems to be inconsistent with the framework design of DMA. The
> conclusion is no.
> 
> 3. We noticed that if the virtio device supports VIRTIO_F_ACCESS_PLATFORM, it
> uses DMA API. And this type of device is the future direction, so we only
> support DMA premapped for this type of virtio device. The problem with this
> solution is that virtqueue_dma_dev() only returns dev in some cases, because
> VIRTIO_F_ACCESS_PLATFORM is supported in such cases. Otherwise NULL is returned.
> This option is currently NO.
> 
> So I'm wondering what should I do, from a DMA point of view, is there any
> solution in case of using DMA API?

I'd step back and ask you why do you want to use AF_XDP with virtio.
Instead of bifurcating one virtio instance into different queues why
not create a separate virtio instance?

