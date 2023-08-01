Return-Path: <bpf+bounces-6581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DFC76B8EF
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219B71C20F56
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9BA1ADDC;
	Tue,  1 Aug 2023 15:45:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9F4DC8F;
	Tue,  1 Aug 2023 15:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA1CC43391;
	Tue,  1 Aug 2023 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690904712;
	bh=VEaLAWfjIhnDGSpVQ/9ljIaO+E4dOVi/Dh1KjH+8jgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EzN5c6CkRbdeXJgQUWFyAiXuNmcAlX3e8DSQ44aT3fzSoUzqtVO5l79tjMuItMQmW
	 /YnUADAwNhMzU4IbzAFSgfe6F61DSqruE3po0+o6xgwKDwjlsQJJSAuOqh7MmAOvni
	 bcySCw7rbxjES1O71Twq59QuzKgAT+nDxbs/5oPol76177763IUV3jdHXe6g+iTct+
	 iGYbGTBuEz6fBH3ZBNDbXHN+5U5CXE3/7TubhFZBejqqBU9AEzh82Pf+QFdxc8q25G
	 1aEYLKzOfIIHoCG0wj+CkGCD77oT8ycoTnGQQl2VcEps2GHvuMx6cg9OSNPsWZP3J0
	 Ktci7jenX9MaA==
Date: Tue, 1 Aug 2023 08:45:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org, "David S.  Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo  Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel  Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John 
 Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce
 virtqueue_dma_dev()
Message-ID: <20230801084510.1c2460b9@kernel.org>
In-Reply-To: <1690858650.8698683-2-xuanzhuo@linux.alibaba.com>
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
	<20230731193606.25233ed9@kernel.org>
	<1690858650.8698683-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 10:57:30 +0800 Xuan Zhuo wrote:
> > You have this working and benchmarked or this is just and idea?  
> 
> This is not just an idea. I said that has been used on large scale.
> 
> This is the library for the APP to use the AF_XDP. We has open it.
> https://gitee.com/anolis/libxudp
> 
> This is the Alibaba version of the nginx. That has been opened, that supported
> to work with the libray to use AF_XDP.
> http://tengine.taobao.org/
> 
> I supported this on our kernel release Anolis/Alinux.

Interesting!

> The work was done about 2 years ago. You know, I pushed the first version to
> enable AF_XDP on virtio-net about two years ago. I never thought the job would
> be so difficult.

Me neither, but it is what it is.

> The nic (virtio-net) of AliYun can reach 24,000,000PPS.
> So I think there is no different with the real HW on the performance.
> 
> With the AF_XDP, the UDP pps is seven times that of the kernel udp stack.

UDP pps or QUIC pps? UDP with or without GSO?

Do you have measurements of how much it saves in real world workloads?
I'm asking mostly out of curiosity, not to question the use case.

> > What about io_uring zero copy w/ pre-registered buffers.
> > You'll get csum offload, GSO, all the normal perf features.  
> 
> We tried io-uring, but it was not suitable for our scenario.
> 
> Yes, now the AF_XDP does not support the csum offload and GSO.
> This is indeed a small problem.

Can you say more about io-uring suitability? It can do zero copy
and recently-ish Pavel optimized it quite a bit.

