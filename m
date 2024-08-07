Return-Path: <bpf+bounces-36584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B4C94AD4E
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B968B219E7
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE1083A06;
	Wed,  7 Aug 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fDgS2+7G"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FDC2F3E
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044538; cv=none; b=KhX5yv7m/L87AECe2YC746Vd7AXw6ERm+XBHOvxR7mdHfJFiEZe1ZAFAP+Rr1580LCRGrV7CV+z5w1BYVt51pLvcBlDHm35pWCsaxmwdPuy63pgMBO49xBbKcBdQFedRNDwpFoL1nX0l9RjS20Xtz0LS22pgls17U8s8e4r47Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044538; c=relaxed/simple;
	bh=8IFNZ4AVXgIqzOeW9rfEZZBFz3wH/kWxQ5LLMSibMrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAf9t68gjQR7QJzD8x4fqRcLxgXhZDpRK56mGFhykK5aW3DLsHf1fROJixog9yY2ikw24ZebfW7XUEVXpGdgFaJrEmu8iMgMYOYi8nPywJ7hWaFSQvCXKUQ1GI2KiZUxMlx9A7hgnbQq1K1b8BOuZy/wWotEj0H6LDHN1qvmgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fDgS2+7G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U5wZcmGka5hcRftUGlo9apMC9v8dlONo1xbKvjgx7aQ=; b=fDgS2+7GVlJAl7h17YiY/QOkzl
	S/GkDLVAGfTLJ8Saob0gMSXftvGCGuFAnmuojPSlkRa6RdpIZQOgC8UjwYOjty7eM47KK67Hu2FGz
	3r3D6SPVQi/6q1tMmkAuy9Z2zoaE8AIey1Th6pxXI2WH7+ZrJiVHvndUephTXg5Puqc1PzSKo1E0t
	aVT0jniCyTcKmXBgNxxyr2MWWbhJ4VFExaedRo8nTTCK8syF9/aVQXjgbyqlM07Zbm+8Wvz+t6Thb
	XOqRkqypGEBRpVnXLPYV+vS8yri6RZxdKIUoE6SPwZswd7TwwEC6bcpFeiitSjrwvTU1Z0NyJENEC
	L64eWusg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbiar-00000007XQO-378U;
	Wed, 07 Aug 2024 15:28:53 +0000
Date: Wed, 7 Aug 2024 16:28:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org,
	jannh@google.com
Subject: Re: [PATCH v3 bpf-next 02/10] lib/buildid: add single page-based
 file reader abstraction
Message-ID: <ZrOStYOrlFr21jRc@casper.infradead.org>
References: <20240730203914.1182569-1-andrii@kernel.org>
 <20240730203914.1182569-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730203914.1182569-3-andrii@kernel.org>

On Tue, Jul 30, 2024 at 01:39:06PM -0700, Andrii Nakryiko wrote:
> +	union {
> +		struct {
> +			struct address_space *mapping;
> +			struct page *page;

NAK.  All the page-based interfaces are deprecated.  Only we can't mark
them as deprecated because our tooling is a pile of crap.

> +			void *page_addr;
> +			u64 file_off;

loff_t pos.

> +	r->page = find_get_page(r->mapping, pg_off);

r->folio = read_mapping_folio(r->mapping, r->pos / PAGE_SIZE, ...)

OK, for network filesystems, you're going to need to retain the struct
file that's used to access them.  So maybe this becomes
	read_mapping_folio(r->file->f_mapping, r->pos, r->file)

> +	r->page_addr = kmap_local_page(r->page);

kmap_local_folio(r->folio, offset_in_folio(r->folio, r->pos));


