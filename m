Return-Path: <bpf+bounces-47288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9697B9F7141
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 01:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2A81890861
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 00:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCEA8BEE;
	Thu, 19 Dec 2024 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rr4UKi7K"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488123A0
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734567036; cv=none; b=qqAZlQcR/Mey6PB0xJTv33q+TIa3qrw7ndXW2yPY/UtxbqLjUb7gtF31jK6Bi3DqMLlrCgnq1uyyLHQLcr+REEmzDZbALMIG+88uUYdsGCi9mIMU2ZEEUK9Zbd8xj2k+DnufYmFu9BCFjCtRjgp3Qi4l3GwVIssdUlaHzxxQYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734567036; c=relaxed/simple;
	bh=t3UuIRJ3r9OcN1zs0OBHwNZQyxYp0UtohosT6poX4jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJO+sGP+URZp0xwc2RXI1gAAmVuahyopy3edLxhst2tqdnqsYuI/pujWIe2HimdsqEJf7r2jk3aT9QIZLM7yEfkf2RTC6caNP7O6klCKo4z5dmMspqvNRbTq4dFsKRk1MrX3GMCpG/ARVx/Zt6DIRqf6nU4ipa1FCDOXQtGyv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rr4UKi7K; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 18 Dec 2024 16:10:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734567032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9H/G23RzoGglbNUDM/QKZSt+D6Rd2u+7uEkML2i7V6Q=;
	b=rr4UKi7KpeV2ikBtwseWYwSpKUDk8dNPMuWCNGplSxj3NkgXPhXaKGY0NUU5KVHJo4zZHw
	cWFFQJxHWzN0PiUO8RUrzjbReHO+7dYJNYRdkoMayLKrkf9+JeGWDVdTRYDxTgFBM5AhJ9
	kQspXGlSSJuXOkFkQMH7PWaDtzu6q2w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com, 
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de, 
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org, mhocko@suse.com, 
	willy@infradead.org, tglx@linutronix.de, jannh@google.com, tj@kernel.org, 
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <wupsauixn4cqn63dvgbrxuwaupslmwgxsffiwmfilu5fnkutj4@55v65liewmfn>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218030720.1602449-2-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 17, 2024 at 07:07:14PM -0800, alexei.starovoitov@gmail.com wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
[...]
> +
> +struct page *try_alloc_pages_noprof(int nid, unsigned int order)
> +{
> +	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO |
> +			  __GFP_NOMEMALLOC | __GFP_TRYLOCK;

I think the above needs a comment to be more clear. Basically why zero,
nomemalloc and no warn? Otherwise this looks good. I don't have a strong
opinion on __GFP_TRYLOCK and maybe just ALLOC_TRYLOCK would be good
enough.


