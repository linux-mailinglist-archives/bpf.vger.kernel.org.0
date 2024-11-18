Return-Path: <bpf+bounces-45089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D27C9D11FD
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 14:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5327F2867AF
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8BD1C1F09;
	Mon, 18 Nov 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="smgP0YRY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TXQC4WyG"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0B1BD9C2
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936598; cv=none; b=Ly/NC4UUSvKtBpU7T5pV6qX1S8x0k3j7aT+7lRG1sOx/sjHUJrElCJM79klPQ909DFAZL6+4xp60uN3/qeD3wG2KpbCF3zsyyc/UTI+uFpu095yJ1WmO8fB8D8tDQYWTOr3xmvr9+rRG+dRmIwG+QhPczgiCv0XPXtenvTMPOIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936598; c=relaxed/simple;
	bh=oJSq60OGMNeH9+1YL/CTEPjWsiGCif4w7IlWawQSPWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml2gj36sMNumyEHTSxRRaNrMIayRC+j0kvRHVNihd7Ogvovx2Ac1PK4+xngN4VDXWRazv4TbTWtkmETJfYeZAk4uowq9IgcIuczCYTiKaCWqWuvjyaQ1MnncXKNz6ZJTA4JPzakbhC/A+XbPVVUGjhsb6YUispa0PY9BicnN6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=smgP0YRY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TXQC4WyG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Nov 2024 14:29:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731936593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KR4cdoZ6t9T7BdUKfhgmsWqVGVzREPrLyg7K2zAS4c=;
	b=smgP0YRYdLQS5i+YE45U+yAH+uaisjcPY0YvgioewoXWx62c7JQiIYI9c5mJb164Z1jnNT
	jytp1JcxWqZJuczmjCzBmJ4VgfJwXXBrZW6dbjVCSa6LZzklKP/Hq20GSztvhzZ4YiYZaV
	Gf1GE3R7TEuuvEzLS7Qum+9Wm+3hqP0jhJPOsqamG3+tJtdc59Wq7ql6mSH3FMFR6YN16g
	epfP5P18PaHpl/l2PQrnmaHQOCs42/exkwSHjHXarP4MD+WXMnW+5YApqwO1IQovti/PKW
	cOcck9KeEjSI2UBNq2gtW7exJ+C9RnvDzSMEjmJCZl7tAMMYoVBIEqEbD+HRHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731936593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KR4cdoZ6t9T7BdUKfhgmsWqVGVzREPrLyg7K2zAS4c=;
	b=TXQC4WyG2b/DtNuftmd4hCLcL7DYps9TRJJW5GrTV6dbF6mYHq4c7cxmhhvFpYUfDq4WeL
	iHMhzi/ke9fjeRAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, houtao1@huawei.com, xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 06/10] bpf: Add bpf_mem_cache_is_mergeable()
 helper
Message-ID: <20241118142841-47031015-7ab8-454b-b6d5-12090d10b0d1@linutronix.de>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-7-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118010808.2243555-7-houtao@huaweicloud.com>

On Mon, Nov 18, 2024 at 09:08:04AM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Add bpf_mem_cache_is_mergeable() to check whether two bpf mem allocator
> for fixed-size objects are mergeable or not. The merging could reduce
> the memory overhead of bpf mem allocator.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/bpf_mem_alloc.h |  1 +
>  kernel/bpf/memalloc.c         | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
> index e45162ef59bb..faa54b9c7a04 100644
> --- a/include/linux/bpf_mem_alloc.h
> +++ b/include/linux/bpf_mem_alloc.h
> @@ -47,5 +47,6 @@ void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
>  void bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr);
>  void bpf_mem_cache_raw_free(void *ptr);
>  void *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags);
> +bool bpf_mem_cache_is_mergeable(size_t size, size_t new_size, bool percpu);
>  
>  #endif /* _BPF_MEM_ALLOC_H */
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 889374722d0a..49dd08ad1d4f 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -1014,3 +1014,15 @@ int bpf_mem_alloc_check_size(bool percpu, size_t size)
>  
>  	return 0;
>  }
> +
> +bool bpf_mem_cache_is_mergeable(size_t size, size_t new_size, bool percpu)
> +{
> +	/* Only for fixed-size object allocator */
> +	if (!size || !new_size)
> +		return false;
> +
> +	return (percpu && ALIGN(size, PCPU_MIN_ALLOC_SIZE) ==
> +			  ALIGN(new_size, PCPU_MIN_ALLOC_SIZE)) ||
> +	       (!percpu && kmalloc_size_roundup(size + LLIST_NODE_SZ) ==
> +			   kmalloc_size_roundup(new_size + LLIST_NODE_SZ));

This would be easier to read:

if (percpu)
	return ALIGN() == ALIGN();
else
	return kmalloc_size_roundup() == kmalloc_size_roundup();

> +}
> -- 
> 2.29.2
> 

