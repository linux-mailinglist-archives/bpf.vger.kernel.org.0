Return-Path: <bpf+bounces-7041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3967709F8
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 22:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B717B28270E
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666621DA30;
	Fri,  4 Aug 2023 20:45:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1CC1AA95;
	Fri,  4 Aug 2023 20:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC365C433C8;
	Fri,  4 Aug 2023 20:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691181905;
	bh=8ywDJqkGVQloG5UrT53vJCwzkueyvL2Zdl1L+cadkP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMwCQ3Vnw71xzrZuJ/jJ94o18ySfq5CXdxO1zj2Uwkwmzuuh5dSZoPMbRPleTSsVr
	 QqirqQcnS7O3+eFxn+npGzlKeiueik5fE5S48AJJ/u5GlXUEeAXzagw0ms3ZtVt+Ip
	 6FakjKhPwGAYikmH6Ba+/1XW5JlnjElhXooIHPyBom3rSgNij/74pHAVMOT7azjwXG
	 XH//lz4B//oNKeQZ+EGKHLHu9vxS3vSZS4uAmtxKMZ1+5qKZ0LPPXFAEy7oDhCqfY+
	 NdmkaDMvD4hjBCH9dIfhW6xHL5tLnZILsVTWXytFTzkLdiPjS3JovqEjaN02okZZ8y
	 eZksZXtoEPR/g==
Date: Fri, 4 Aug 2023 22:44:59 +0200
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
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC Optimizing veth xsk performance 03/10] veth: add support
 for send queue
Message-ID: <ZM1jS2ndLNS+AjIv@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-4-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-4-huangjie.albert@bytedance.com>

On Thu, Aug 03, 2023 at 10:04:29PM +0800, huangjie.albert wrote:

...

> @@ -69,11 +74,25 @@ struct veth_rq {
>  	struct page_pool	*page_pool;
>  };
>  
> +struct veth_sq {
> +	struct napi_struct	xdp_napi;
> +	struct net_device	*dev;
> +	struct xdp_mem_info	xdp_mem;
> +	struct veth_sq_stats	stats;
> +	u32 queue_index;
> +	/* this is for xsk */
> +	struct {
> +		struct xsk_buff_pool __rcu *pool;
> +		u32 last_cpu;
> +	}xsk;

nit: '}xsk;' -> '} xsk;'

Please consider running checkpatch.pl

...

