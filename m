Return-Path: <bpf+bounces-7045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99366770A5D
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 23:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49CA1C216A8
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF761DA58;
	Fri,  4 Aug 2023 21:05:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90C71DA48;
	Fri,  4 Aug 2023 21:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B429AC433C8;
	Fri,  4 Aug 2023 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691183108;
	bh=gJt669rsfGxg9edElmNCRVGPd1QDKDSpXCM3ZtENT2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E16slqox7a3VQa4utXPuURhDCW1McbB9kCRJaIIHQqNEWriaHXjOMhwmMsmKV7jiN
	 uRakANi+tNkYAPlU2THvsLNpwBAwzyS2oeshEuj/nFSMVR1pgqSouihj5JOqKAH1Dy
	 j9XKloVg2zGbqI0+gQX1ybOBB4fhR+2KDk9ujyEgsjk8CbndAVK2vPrXFwmNQZQz21
	 U0uWPIw3GfwAGpOSDj8Y9xStDDthanaNGeC/qslT3UE5M9KhfOY4H0bCE0mi+tsMal
	 aH7vu8rul4eAR1ztuTQX6c4I/dGW14tf/ayiPG/sqKY4iRgQisRmipSex2LKTB837n
	 X3JOz9kBX/A/A==
Date: Fri, 4 Aug 2023 23:05:02 +0200
From: Simon Horman <horms@kernel.org>
To: "huangjie.albert" <huangjie.albert@bytedance.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC Optimizing veth xsk performance 09/10] veth: support zero
 copy for af xdp
Message-ID: <ZM1n/kAXoL3oeprb@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-10-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-10-huangjie.albert@bytedance.com>

On Thu, Aug 03, 2023 at 10:04:35PM +0800, huangjie.albert wrote:

...

> +static struct sk_buff *veth_build_skb_zerocopy(struct net_device *dev, struct xsk_buff_pool *pool,
> +					      struct xdp_desc *desc)
> +{
> +	struct veth_seg_info *seg_info;
> +	struct sk_buff *skb;
> +	struct page *page;
> +	void *hard_start;
> +	u32 len, ts;
> +	void *buffer;
> +	int headroom;
> +	u64 addr;
> +	u32 index;
> +
> +	addr = desc->addr;
> +	len = desc->len;
> +	buffer = xsk_buff_raw_get_data(pool, addr);
> +	ts = pool->unaligned ? len : pool->chunk_size;
> +
> +	headroom = offset_in_page(buffer);
> +
> +	/* offset in umem pool buffer */
> +	addr = buffer - pool->addrs;
> +
> +	/* get the page of the desc */
> +	page = pool->umem->pgs[addr >> PAGE_SHIFT];
> +
> +	/* in order to avoid to get freed by kfree_skb */
> +	get_page(page);
> +
> +	hard_start = page_to_virt(page);
> +
> +	skb = veth_build_skb(hard_start, headroom, len, ts);
> +	seg_info = (struct veth_seg_info *)kmalloc(struct_size(seg_info, desc, MAX_SKB_FRAGS), GFP_KERNEL);

There is no need to explicitly case the return value of kmalloc,
as it returns void *.

	seg_info = kmalloc(struct_size(seg_info, desc, MAX_SKB_FRAGS),
			   GFP_KERNEL);

...

