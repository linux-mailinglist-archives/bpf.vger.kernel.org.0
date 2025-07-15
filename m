Return-Path: <bpf+bounces-63332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F923B061AA
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 16:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646BB5A4847
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEF91B4248;
	Tue, 15 Jul 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mIk1OZeg"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2433597E;
	Tue, 15 Jul 2025 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590243; cv=none; b=FTZhzYvFAbo53BvqCb2XMYokuLCEdpIwE2jo8usrW22HZRSI2b3PJRvLoX/yUxjnIXmP3BxSTlviJivittXKFdz8sRcPviq3kF0SodIF0tZo5N/jnXUbBhUqKzUK8SDQLB48sItc7vrtb5pDy+YDFR6E9KnbFLnHyF2y6G1dmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590243; c=relaxed/simple;
	bh=JB6srs0/hXmNXL29U5hBbo2e7jA6AoI8BkIfVhHHWKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnmLY4+VqMdfVWgkEu/7DdxZSCYi+RfqAOtHuGV29PLOd9nRB/1XAYvL5+ihBOXYKWjh9AjBIZzWM3Gw3vnF+lOU4g9MuPL7dhtQvkxCk6evdicVNj33RmDWZuIQVNIZGzglq0SHT8SJ58OAcihTt6Lc4rwcuHZv1s3JV3nCxuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mIk1OZeg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ssm/Pf0xPS8BgVoBR78mDi4mbuFDFYdIquwSjn1ZXTQ=; b=mIk1OZegNjGFmNKH0vvGqh2HJC
	gNi9amAkigliamcRDqa5VOXl0WVWqS4eKz50TizpcMpmoGdQLrtYrUdGsRy7h3TDjSjluNeuh0ZqZ
	dteG+sFECDlnAR95RVR1TYBBdtHyFyV4UklwRMJLX6qjzIXjPM239izuwELzNqw5Uiw5BZNjMzzWc
	pl/MEKGRNTyw/WUqc3q7FNX+YdQbjEBkG8ha6LspqZXgzCzGngvHMGCav1iSvNJVCnQgQO6Z0gdm7
	vrx1wEoozQ4ZjLVoOB/Ghno5ah6rot72je1rV1bqdAm6ek9FLaQYsPCGFtiwfrvxAPFw22to8wbBU
	mYgiInHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubgmP-0000000Cnat-4BGC;
	Tue, 15 Jul 2025 14:37:14 +0000
Date: Tue, 15 Jul 2025 15:37:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	rust-for-linux@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v13 1/4] :mm/vmalloc: allow to set node and align in
 vrealloc
Message-ID: <aHZnmevtRYt26LBE@casper.infradead.org>
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
 <20250715135724.2230116-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715135724.2230116-1-vitaly.wool@konsulko.se>

On Tue, Jul 15, 2025 at 03:57:24PM +0200, Vitaly Wool wrote:
> +void *__must_check vrealloc_node_align_noprof(const void *p, size_t size,
> +		unsigned long align, gfp_t flags, int nid) __realloc_size(2);
> +#define vrealloc_node_noprof(_p, _s, _f, _nid)	\
> +	vrealloc_node_align_noprof(_p, _s, 1, _f, _nid)
> +#define vrealloc_noprof(_p, _s, _f)		\
> +	vrealloc_node_align_noprof(_p, _s, 1, _f, NUMA_NO_NODE)
> +#define vrealloc_node_align(...)		alloc_hooks(vrealloc_node_align_noprof(__VA_ARGS__))
> +#define vrealloc_node(...)			alloc_hooks(vrealloc_node_noprof(__VA_ARGS__))
> +#define vrealloc(...)				alloc_hooks(vrealloc_noprof(__VA_ARGS__))

I think we can simplify all of this.

void *__must_check vrealloc_noprof(const void *p, size_t size,
		unsigned long align, gfp_t flags, int nid) __realloc_size(2);
#define vrealloc_node_align(...) \
	alloc_hooks(vrealloc_noprof(__VA_ARGS__))
#define vrealloc_node(p, s, f, nid) \
	alloc_hooks(vrealloc_noprof(p, s, 1, f, nid))
#define vrealloc(p, s, f) \
	alloc_hooks(vrealloc_noprof(p, s, 1, f, NUMA_NO_NODE))


