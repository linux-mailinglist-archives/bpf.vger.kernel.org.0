Return-Path: <bpf+bounces-23055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D77686CE84
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 17:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD341F25D55
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01D36CBFE;
	Thu, 29 Feb 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MyDA82W9"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2E04AEC9
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222195; cv=none; b=VIgGo53hUKp5n7urFt33U37t9D0oX7Y0lXH/Jyr6ebOiqjYg0pk8ci+9vAFLvTqkkCZcP8t5lyulaOSuS3jYdPPqa/6vhpnCWdIXW2VQWudH8LzuHFtKsHRmKHS7mrJeNvqMdEquMf9zPv5IX/V2BHBzV4T26UlHmPglvOTzF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222195; c=relaxed/simple;
	bh=czcrIZvv5lDveBU2cHYcvqVFr6Snkh6UCtf3GKl3naQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwEv2vzVxh2LF3HJ+geXkP6sWaEfEpQLQhZlODnBUqGJ4RwzQoz/Fm00MkiD4YzDJcRzqE1U+yXdp1H5Nh2I5xd8t8eTQYo/yB0k6GxbTx0VFhfN9W5UqglzNu10IFJBVYAaDrgIWhbLDkBeMw5LEwpf0Vl53n/QdyflSAvxYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MyDA82W9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZZeeQhzP/DHpKF5QdT9LDfZVh1KeLzxu5kAiu8X0IuI=; b=MyDA82W9Ybj19i6XFkxtLJHcIj
	DIdV0B551cX9Of1vbLiE7wQyZ+QZ5s8/rx8PcMT7ZPqE5MxTVE1PqdqAGpoLtaEP7Z4GODcSqBYpf
	+5PUuQblRp6R9otKcB2rgpT/TckK30wW/x9kWHfBUBOEYLAv9ENYNYjr74JbVv+4HkHvDmFDcyos1
	L5Gi5pVl5ETAKTSF6e0VODoCUz2lHFEdWX18oSiBxUvU0VJHDtUoU+XqIK7UWxX26b+RFFj8q7AE8
	7UYQl/Ts9ehrXAidDb+ChLkR4jo9tWvXsBvM8DXn+wWbhjnOn95vr0rgW5lmvfOKAFxXuYbK3wwqj
	Ze2WUX/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfilp-0000000E9xh-2JaC;
	Thu, 29 Feb 2024 15:56:29 +0000
Date: Thu, 29 Feb 2024 07:56:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, bpf <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Barret Rhoden <brho@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	sstabellini@kernel.org, Juergen Gross <jgross@suse.com>,
	linux-mm <linux-mm@kvack.org>, xen-devel@lists.xenproject.org,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 3/3] mm: Introduce VM_SPARSE kind and
 vm_area_[un]map_pages().
Message-ID: <ZeCpLW25Fn6Di3Gu@infradead.org>
References: <20240223235728.13981-1-alexei.starovoitov@gmail.com>
 <20240223235728.13981-4-alexei.starovoitov@gmail.com>
 <Zd4jGhvb-Utdo2jU@infradead.org>
 <CAADnVQ+f06b1hDrAyLM-OrzDfEEa=jtamJOKfEnEo4ewKPV0cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+f06b1hDrAyLM-OrzDfEEa=jtamJOKfEnEo4ewKPV0cA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 27, 2024 at 05:31:28PM -0800, Alexei Starovoitov wrote:
> What would it look like with a cookie?
> A static inline wrapper around get_vm_area() that returns area->addr ?
> And the start address of vmap range will be such a cookie?

Hmm, just making the kernel virtual address the cookie actually
sounds pretty neat indeed even if I did not have that in mind.

> I guess I don't understand the motivation to hide 'struct vm_struct *'.

The prime reason is that then people will try to start random APIs that
work on it.  But let's give it a try without the wrappers and see how
things go.


