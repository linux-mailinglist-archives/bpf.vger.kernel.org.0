Return-Path: <bpf+bounces-22714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C36F867234
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 11:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7A31C24F88
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0775C39856;
	Mon, 26 Feb 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1FVpbdFG"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E13839E
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944619; cv=none; b=ikY4JfgeAYuXT/y46dHnjmekg1I3wQ9rVD4o+x5fmeVPyjTiy+YXhwZBBmCu1vXd0IaKpKXaAem9Mx9fUcFiFK56gt1IzYF/VeBGE3T7QBE8t6Q2rsAe8XR/RZVJGmFBb1eTKNmPnD2gHM79r/ILMchfbObogmIppmngX0HYLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944619; c=relaxed/simple;
	bh=VVy++HQI40PmHCnWUthBYN0PKo9A6/rbG5stfI6xH/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC7ezI80DDHI7pzuJEGmWRmGwkv4rbbeySFpH4XwcPbZ4C9t9RU3p6FIZL/DF3pJYmsPl6miQprhCtZvVCyT+yjpfqLlNy676IZsEnvNYzdFnDTh6spVfvpFfb2s37OSoqKrBl0ZaLfHFfe25BCUFmCw3qNEgSmUTo0tUPLrq3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1FVpbdFG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8zXJnYkWvb7GCIP0mRpV6jKEXdPSRHoRUoq4Q4XvFso=; b=1FVpbdFGoDA69PZZUcL4HiCtMz
	S6WFk/vpfQAB/kguloupNrgoRgK4vjbvfGKDw6TZHXyCBf52luksnZyy+2wbqip9cqyCkauoU5RxA
	9Jgay49gicYkCypB2ID8yeiUIOoCgg9Ww6kzWEF+BI2PRQBUjmWf31Fba4biwbLFNimlj804lPzhB
	OatWMdfGH7woOtg6A0Wa5soW7v2mb8shmzzPAv/pPb1n3wNayVkic9AQ5Tn9aRJOFvCMEVDGlMx5e
	MxaIBCxza0I8HOVlkQli3oksCZa2jSLmj0y25Lqa3m4xble00cszPiVEb4gvbECDXlYq6xaz1b5MR
	wjjQo3tg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reYYq-00000000C2e-1All;
	Mon, 26 Feb 2024 10:50:16 +0000
Date: Mon, 26 Feb 2024 02:50:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org,
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com,
	hch@infradead.org, boris.ostrovsky@oracle.com,
	sstabellini@kernel.org, jgross@suse.com, linux-mm@kvack.org,
	xen-devel@lists.xenproject.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 1/3] mm: Enforce VM_IOREMAP flag and range in
 ioremap_page_range.
Message-ID: <Zdxs6DDSVtjaqK-d@infradead.org>
References: <20240223235728.13981-1-alexei.starovoitov@gmail.com>
 <20240223235728.13981-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223235728.13981-2-alexei.starovoitov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Feb 23, 2024 at 03:57:26PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> There are various users of get_vm_area() + ioremap_page_range() APIs.
> Enforce that get_vm_area() was requested as VM_IOREMAP type and range passed to
> ioremap_page_range() matches created vm_area to avoid accidentally ioremap-ing
> into wrong address range.

Nit: overly long lines in the commit message here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

