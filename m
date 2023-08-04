Return-Path: <bpf+bounces-7042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A3770A01
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 22:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393701C20FB7
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 20:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979321DA3B;
	Fri,  4 Aug 2023 20:46:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031E1AA95;
	Fri,  4 Aug 2023 20:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CB9C433C7;
	Fri,  4 Aug 2023 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691181989;
	bh=MeJG2vuAuzwQPAdsG0vf4tmGc9lh6I+FFfN9rIwpfm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9tqZdJ30TDBdZpjaI3uDUgJjJV4vCo9oKGYzNfnFLJ4X0rK27qJuVmgenqbdcJM1
	 OrqYnrLixy3ZCw2rcNFFVW20WKXlS5lWj7jUXR30VQjNFCPj+6JRBFwxYbmlRj4Q10
	 ZMZti95gpxwYsBAiur8KkXwn204nEJt8MEGjRCIyc3Y3xyrCxZg+CS3seOvZZAO7fI
	 ORlnmyBbgYmEh37ie26N+8g4gj0Rk22K3x2ZMSNA25LrOo/AOzsPm+x5qO/Gnd+EAv
	 RZ47rQLifPaoSV+YNoJLUfgA+e+Zf2jVPmmrUumq/iPh1XxvEIZy4R6MfClwVafHLM
	 PfhGXK21lNmUg==
Date: Fri, 4 Aug 2023 22:46:24 +0200
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
	Menglong Dong <imagedong@tencent.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC Optimizing veth xsk performance 04/10] xsk: add
 xsk_tx_completed_addr function
Message-ID: <ZM1joMiYtbrXVLv6@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-5-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-5-huangjie.albert@bytedance.com>

On Thu, Aug 03, 2023 at 10:04:30PM +0800, huangjie.albert wrote:

...

> index 13354a1e4280..a494d1dcb1c3 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -428,6 +428,17 @@ static inline void __xskq_prod_submit(struct xsk_queue *q, u32 idx)
>  	smp_store_release(&q->ring->producer, idx); /* B, matches C */
>  }
>  
> +

nit: one blank line is enough

> +static inline void xskq_prod_submit_addr(struct xsk_queue *q, u64 addr)
> +{
> +	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
> +	u32 idx = q->ring->producer;
> +
> +	ring->desc[idx++ & q->ring_mask] = addr;
> +
> +	__xskq_prod_submit(q, idx);
> +}
> +
>  static inline void xskq_prod_submit(struct xsk_queue *q)
>  {
>  	__xskq_prod_submit(q, q->cached_prod);
> -- 
> 2.20.1
> 
> 

