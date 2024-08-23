Return-Path: <bpf+bounces-37967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82BB95D487
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 19:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9E61F2440B
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF3118660B;
	Fri, 23 Aug 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2rg7Qup"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255A18E743;
	Fri, 23 Aug 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434836; cv=none; b=NgoshBfVocnllpyynUZS2PJJ5TWUCLjD4rNo2gH1c/6Ohu1S7xpHQFyEJCMvL7z8piAsZEFkpqjTywi3vlKXg38/Zt2HdwUAQ2vrzi6FXGwtF04J3DsevSs/i7GmpE98aIE1zNUn2AzxeSULDTkd16zT2BFjf00+j7dihTxYHoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434836; c=relaxed/simple;
	bh=5IpSPoN06AYJDmo6ubbD3G3WiaI0Y2kK7p+QHwxpxoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/ybxGvLIVFfZKc9rVMtm2M/IZK6Q2Vog3xgy7+vILO18/6IWpYbyZ7CxEbJIOxL2lVuJ6GqOgjZ4pFiZOMqVMjXZt06bYBHwaqh1E1k58FTXOSHZ8eGYHnGJQ8JcJhDVh/7XJ6Ii8bWyoKrGQ6ANrDkttoAuverm4qKrnGLjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2rg7Qup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B1CC4AF19;
	Fri, 23 Aug 2024 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724434836;
	bh=5IpSPoN06AYJDmo6ubbD3G3WiaI0Y2kK7p+QHwxpxoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2rg7QupkiV7GcfzR5t4LZEM5NzKSaNgoRfltrcgGSZLbV1xbs0TQ6PRhymoCq8r0
	 Q3pH5XD8M+Jy6Y1aETH33xzkckdZN2rO3Mks3S1W1OXfCw7zP9AeV4bVxM2G3W9qQZ
	 0Fm1qrW7HF7P1JqkK4Sujj1TCC1QgzHpMEOQLRZC/dYxY1UnxC+VW1aZL2D756cPWx
	 WojhhvpEn9L9rJLQ+4Fq6dnaxxozNK7QaeTqjElU+3YyEJbBjvYoU/OxNZhnYoGM7F
	 L5LtlIn+kYZiSI2MU0AAEq2UgiADTewhXO23oUIpMRpCYvj8japihY6k8tz5l2HbNM
	 4/Xar1IZCOWHg==
Date: Fri, 23 Aug 2024 18:40:27 +0100
From: Simon Horman <horms@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	David Ahern <dsahern@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Boris Pismenny <borisp@nvidia.com>, bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v14 09/11] net: replace page_frag with
 page_frag_cache
Message-ID: <20240823174027.GB2164@kernel.org>
References: <20240823150040.1567062-1-linyunsheng@huawei.com>
 <20240823150040.1567062-10-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823150040.1567062-10-linyunsheng@huawei.com>

On Fri, Aug 23, 2024 at 11:00:37PM +0800, Yunsheng Lin wrote:

> @@ -1114,82 +1104,44 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  			if (err)
>  				goto do_fault;
>  		} else {
> +			struct page_frag_cache *nc = &sk->sk_frag;
> +			struct page_frag page_frag, *pfrag;
>  			int i = skb_shinfo(skb)->nr_frags;
> -			struct page *page = TCP_PAGE(sk);
> -			int pg_size = PAGE_SIZE;
> -			int off = TCP_OFF(sk);
> -			bool merge;
> -
> -			if (page)
> -				pg_size = page_size(page);
> -			if (off < pg_size &&
> -			    skb_can_coalesce(skb, i, page, off)) {
> +			bool merge = false;
> +			void *va;
> +
> +			pfrag = &page_frag;
> +			va = page_frag_alloc_refill_prepare(pfrag, 32U, pfrag,
> +							    sk->sk_allocation);

Unfortunately this does not seem to compile.

.../chtls_io.c: In function 'chtls_sendmsg':
.../chtls_io.c:1114:61: error: passing argument 1 of 'page_frag_alloc_refill_prepare' from incompatible pointer type [-Wincompatible-pointer-types]
 1114 |                         va = page_frag_alloc_refill_prepare(pfrag, 32U, pfrag,
      |                                                             ^~~~~
      |                                                             |
      |                                                             struct page_frag *
In file included from ./include/linux/skbuff.h:34,
                 from .../chtls_io.c:11:
./include/linux/page_frag_cache.h:205:76: note: expected 'struct page_frag_cache *' but argument is of type 'struct page_frag *'
  205 | static inline void *page_frag_alloc_refill_prepare(struct page_frag_cache *nc,
      |                                                    ~~~~~~~~~~~~~~~~~~~~~~~~^~

...

-- 
pw-bot: cr

