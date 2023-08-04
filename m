Return-Path: <bpf+bounces-7046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB36770AA5
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 23:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B631C20FE8
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3FB1DA5C;
	Fri,  4 Aug 2023 21:13:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07271DA46;
	Fri,  4 Aug 2023 21:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E5EC433C8;
	Fri,  4 Aug 2023 21:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691183580;
	bh=Didgavb7lNnwSvMWDhpBxQbZbMpxnpv2uXjDXw5Px9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5AGU/PC3UclBZNQb+pv82bqd3iu89edndRD6B/37TSHK7zVvSXlPJ+wQVZHXUtW1
	 7Swi0SkEMRhJ+T6SESaQjsAeuRhqReFz4PnC4JhEime7yJsAjTvLLDqAWBnE26BEt9
	 0IqiNnTTDR04sb+rBblZIg7XlgXepFTB8Wxy2cvFR1qgh72GiNzPzPKn4PCUxKp5iR
	 gX9fkWigB/8f/SocWcecoVvRthW8jEoSsbEcv1B9E8xMgiBl7nLEbfNIqyd1b8+gBJ
	 +vVXpry9jdxC3vA62yZDIiO0nUAaXPeAW93dstHsf+nKmAqIezanRah1C+d7NCx4bP
	 djbdIoTBVlXBg==
Date: Fri, 4 Aug 2023 23:12:54 +0200
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
Subject: Re: [RFC Optimizing veth xsk performance 10/10] veth: af_xdp tx
 batch support for ipv4 udp
Message-ID: <ZM1p1qU/RIQYiACP@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-11-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-11-huangjie.albert@bytedance.com>

On Thu, Aug 03, 2023 at 10:04:36PM +0800, huangjie.albert wrote:

...

> @@ -103,6 +104,18 @@ struct veth_xdp_tx_bq {
>  	unsigned int count;
>  };
>  
> +struct veth_gso_tuple {
> +	__u8	protocol;
> +	__be32	saddr;
> +	__be32	daddr;
> +	__be16	source;
> +	__be16	dest;
> +	__be16	gso_size;
> +	__be16	gso_segs;
> +	bool gso_enable;
> +	bool gso_flush;
> +};
> +
>  struct veth_seg_info {
>  	u32 segs;
>  	u64 desc[] ____cacheline_aligned_in_smp;

...

> +static inline bool gso_segment_match(struct veth_gso_tuple *gso_tuple, struct iphdr *iph, struct udphdr *udph)
> +{
> +	if (gso_tuple->protocol == iph->protocol &&
> +		gso_tuple->saddr == iph->saddr &&
> +		gso_tuple->daddr == iph->daddr &&
> +		gso_tuple->source == udph->source &&
> +		gso_tuple->dest == udph->dest &&
> +		gso_tuple->gso_size == ntohs(udph->len))

The type of the gso_size field is __be16,
but it is being assigned a host byte order value.

> +	{
> +		gso_tuple->gso_flush = false;
> +		return true;
> +	} else {
> +		gso_tuple->gso_flush = true;
> +		return false;
> +	}
> +}
> +
> +static inline void gso_tuple_init(struct veth_gso_tuple *gso_tuple, struct iphdr *iph, struct udphdr *udph)
> +{
> +	gso_tuple->protocol = iph->protocol;
> +	gso_tuple->saddr = iph->saddr;
> +	gso_tuple->daddr = iph->daddr;
> +	gso_tuple->source = udph->source;
> +	gso_tuple->dest = udph->dest;
> +	gso_tuple->gso_flush = false;
> +	gso_tuple->gso_size = ntohs(udph->len);


Likewise, here.

As flagged by Sparse.

  .../veth.c:721:29: warning: incorrect type in assignment (different base types)
  .../veth.c:721:29:    expected restricted __be16 [usertype] gso_size
  .../veth.c:721:29:    got unsigned short [usertype]
  .../veth.c:703:26: warning: restricted __be16 degrades to integer

> +	gso_tuple->gso_segs = 0;
> +}

...

> +static struct sk_buff *veth_build_skb_zerocopy_gso(struct net_device *dev, struct xsk_buff_pool *pool,
> +					      struct xdp_desc *desc, struct veth_gso_tuple *gso_tuple, struct sk_buff *prev_skb)

Please consider constraining line length to 80 columns.

> +{
> +	u32 hr, len, ts, index, iph_len, th_len, data_offset, data_len, tot_len;
> +	struct veth_seg_info *seg_info;
> +	void *buffer;
> +	struct udphdr *udph;
> +	struct iphdr *iph;
> +	struct sk_buff *skb;
> +	struct page *page;
> +	int hh_len = 0;
> +	u64 addr;
> +
> +	addr = desc->addr;
> +	len = desc->len;
> +
> +	/* l2 reserved len */
> +	hh_len = LL_RESERVED_SPACE(dev);
> +	hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(hh_len));
> +
> +	/* data points to eth header */
> +	buffer = (unsigned char *)xsk_buff_raw_get_data(pool, addr);
> +
> +	iph = (struct iphdr *)(buffer + ETH_HLEN);
> +	iph_len = iph->ihl * 4;
> +
> +	udph = (struct udphdr *)(buffer + ETH_HLEN + iph_len);
> +	th_len = sizeof(struct udphdr);
> +
> +	if (gso_tuple->gso_flush)
> +		gso_tuple_init(gso_tuple, iph, udph);
> +
> +	ts = pool->unaligned ? len : pool->chunk_size;
> +
> +	data_offset = offset_in_page(buffer) + ETH_HLEN + iph_len + th_len;
> +	data_len = len - (ETH_HLEN + iph_len + th_len);
> +
> +	/* head is null or this is a new 5 tuple */
> +	if (NULL == prev_skb || !gso_segment_match(gso_tuple, iph, udph)) {
> +		tot_len = hr + iph_len + th_len;
> +		skb = veth_build_gso_head_skb(dev, buffer, tot_len, hr, iph_len, th_len);
> +		if (!skb) {
> +			/* to do: handle here for skb */
> +			return NULL;
> +		}
> +
> +		/* store information for gso */
> +		seg_info = (struct veth_seg_info *)kmalloc(struct_size(seg_info, desc, MAX_SKB_FRAGS), GFP_KERNEL);

No need to case the return value of kmalloc, it's type is void *.

		seg_info = kmalloc(struct_size(seg_info, desc, MAX_SKB_FRAGS),
				   GFP_KERNEL);
> +		if (!seg_info) {
> +			/* to do */
> +			kfree_skb(skb);
> +			return NULL;
> +		}

...

