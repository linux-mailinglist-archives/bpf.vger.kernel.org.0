Return-Path: <bpf+bounces-6452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4BF769B0E
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 17:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A3C1C20914
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 15:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0BE18C3F;
	Mon, 31 Jul 2023 15:46:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B914F8E;
	Mon, 31 Jul 2023 15:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADB5C433C7;
	Mon, 31 Jul 2023 15:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690818412;
	bh=1eeFumHYHRXLIgMFKFDtiP+XFlf/cVha1AjBL7OW2h0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lVBb2wgpMWAU4CoacRqO60I6+C4ZmYgTclfwGTAxs5keS8Kki2ixajoJ+PDHXPomN
	 jm3UCkIRFntmXEBwOoYydpUoVAB+1Qza7YSemJe+APgq4NoV6oqOrCQIpCIOmwKI+G
	 GjJX3XaKnT0j3BFFnoazXdg7+GAYPBv9mmVQCV2rlJnxg7dps61lBzBpNU7Y83f2Ny
	 a7Yan8qd6q3EpdWgBH3btDj5OIFmUtGlvvSs+Nj2LyRAwt8xYkBgsHQ/0Nd2BnFNKI
	 GL+Q3Zj/c/uzzCmBU/fIPbu0QhosBMDsrajyvjCJvq0qVR+ePmdOxUFdAXflHHcyk9
	 RN3zHAh16I/DA==
Date: Mon, 31 Jul 2023 08:46:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Christoph Hellwig
 <hch@infradead.org>, virtualization@lists.linux-foundation.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce
 virtqueue_dma_dev()
Message-ID: <20230731084651.16ec0a96@kernel.org>
In-Reply-To: <CACGkMEs5uc=ct8BsJzV2SEJzAGXqCP__yxo-MBa6d6JzDG4YOg@mail.gmail.com>
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
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 09:23:29 +0800 Jason Wang wrote:
> > I'd step back and ask you why do you want to use AF_XDP with virtio.
> > Instead of bifurcating one virtio instance into different queues why
> > not create a separate virtio instance?
> 
> I'm not sure I get this, but do you mean a separate virtio device that
> owns AF_XDP queues only? If I understand it correctly, bifurcating is
> one of the key advantages of AF_XDP. What's more, current virtio
> doesn't support being split at queue (pair) level. And it may still
> suffer from the yes/no DMA API issue.

I guess we should step even further back and ask Xuan what the use case
is, because I'm not very sure. All we hear is "enable AF_XDP on virtio"
but AF_XDP is barely used on real HW, so why?

Bifurcating makes (used to make?) some sense in case of real HW when you
had only one PCI function and had to subdivide it. Virtio is either a SW
construct or offloaded to very capable HW, so either way cost of
creating an extra instance for DPDK or whatever else is very low.

