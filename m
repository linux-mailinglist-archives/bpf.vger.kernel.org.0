Return-Path: <bpf+bounces-6512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 393E276A70C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 04:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D853E281892
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 02:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3B110D;
	Tue,  1 Aug 2023 02:36:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051731103;
	Tue,  1 Aug 2023 02:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21FBC433C8;
	Tue,  1 Aug 2023 02:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690857368;
	bh=7t1d13dIDpP7iXEaQDrUyK3rnmaIVz05ZXV/XTuRkAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ce78m30GmwbtKCI4YvNcU9GiGRhmYpuE4FypqSRFGb1Fg02lY0Zqjp9qdeeMGtFx0
	 THm1mJ7XvOLCz2/W6cfZm2bYGS7vGPdDnYl94L2jh94RtSZoNJjVvb38oEWFug6Gnt
	 OfL+BMcbE/xmFQcZrMgK3xwc9aV1CJhk3UekAQ0REbg9DYLc80HnpQC54nCt+mAQiC
	 vutMtJrqShTTMp7YQ3t51eInlCD0b19187H1safeOMHnGYQFA0dwHMtPl8BBDVf+XF
	 alc3kk5fe18IZLOIuEqqgKXiOKIz5CkcL16NqD8upetuLnRh83HztxyCu1vET3rCCQ
	 +IIKW4RYVTgyA==
Date: Mon, 31 Jul 2023 19:36:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org, "David S.  Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo  Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel  Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce
 virtqueue_dma_dev()
Message-ID: <20230731193606.25233ed9@kernel.org>
In-Reply-To: <1690855424.7821567-1-xuanzhuo@linux.alibaba.com>
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
	<20230728080305.5fe3737c@kernel.org>
	<CACGkMEs5uc=ct8BsJzV2SEJzAGXqCP__yxo-MBa6d6JzDG4YOg@mail.gmail.com>
	<20230731084651.16ec0a96@kernel.org>
	<1690855424.7821567-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 10:03:44 +0800 Xuan Zhuo wrote:
> > Virtio is either a SW
> > construct or offloaded to very capable HW, so either way cost of
> > creating an extra instance for DPDK or whatever else is very low.  
> 
> The extra instance is virtio-net?
> 
> I think there is a gap. So let me give you a brief introduction of our case.
> 
> Firstly, we donot use dpdk. We use the AF_XDP, because of that the AF_XDP is
> more simpler and easy to deploy for the nginx.
> 
> We use the AF_XDP to speedup the UDP of the quic. By the library, the APP just
> needs some simple change.
> 
> On the AliYun, the net driver is virtio-net. So we want the virtio-net support
> the AF_XDP.
> 
> I guess what you mean is that we can speed up through the cooperation of devices
> and drivers, but our machines are public clouds, and we cannot change the
> back-end devices of virtio under normal circumstances.
> 
> Here I do not know the different of the real hw and the virtio-net.

You have this working and benchmarked or this is just and idea?

What about io_uring zero copy w/ pre-registered buffers.
You'll get csum offload, GSO, all the normal perf features.

