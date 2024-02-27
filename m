Return-Path: <bpf+bounces-22781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1C1869E78
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 19:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD791C24DC1
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A6954FB1;
	Tue, 27 Feb 2024 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XwrNH63f"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA14EB44
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056798; cv=none; b=hp2onySHfvOhjU4MmE8h+atWCsUk++JPyaY1A8h2w6Z2uw0pqywan5IkqH27nYDQlmkXr8XqplStePQR96R+w6iTMoY+tec/svZnb7l93ZSZnOmqi8TsUvsYEshmPoF6gqTwfFTqD++1sLPS6DLC5Tj0xJGlLhpNQUgP+fYn29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056798; c=relaxed/simple;
	bh=qHlhrLgh9oIlv5l90jXjngGOTgnvfshF6vsp6k+OIpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0ua7iJXQyEh/EVRqlwNju5+2CmXmt0pOvu+1e1mwxkMjt3n7xxqRnJVArsKZdpI6UN4eNKOSg7kX8lPTvcZe272Cgc6Y+Y5dxsZLJH9zT+K1oN/85krReVzdaItYXubpfl0kzSJxcPB7JkwNfTIGTtXeMC7yXdUBm+GQpkzg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XwrNH63f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GukGcLj9PQJkkJdIQj2GR9q/JvN/F9bhdGOfMYM4O/U=; b=XwrNH63ffZ7GWr5zMD/MMNx9XI
	v9aKaslPO74VTtTivC5ZzlDmyM/6RnQ6cWIobn9vQYSp0ptp30DwyT/kCVaXr+GrAXmk1GUUxWnS8
	DyBGtLgUkEI4F5RnePXoVclfk6mgvIZ2f97YaRsMb0qfH+scl3eoThCPCW7OHCHjk3Ips9pyendm4
	7Qy6XJfkHoF79fYInWSFYVun7XXy+OYAuvZQT8ctwRRbJGmiwvXPaP6PpCZdc832OybgiyC8SAnJv
	rjm5Ybep2LF4gvmEhBTgaZR8l9m7fJGKIne09MLk5dj2tDRxjYnE3qEHrtHixqQ2CRTi0UmWmpsah
	oSGmJfgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf1kA-00000006L78-3JBT;
	Tue, 27 Feb 2024 17:59:54 +0000
Date: Tue, 27 Feb 2024 09:59:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org,
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com,
	hch@infradead.org, boris.ostrovsky@oracle.com,
	sstabellini@kernel.org, jgross@suse.com, linux-mm@kvack.org,
	xen-devel@lists.xenproject.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 3/3] mm: Introduce VM_SPARSE kind and
 vm_area_[un]map_pages().
Message-ID: <Zd4jGhvb-Utdo2jU@infradead.org>
References: <20240223235728.13981-1-alexei.starovoitov@gmail.com>
 <20240223235728.13981-4-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223235728.13981-4-alexei.starovoitov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> privately-managed pages into a sparse vm area with the following steps:
> 
>   area = get_vm_area(area_size, VM_SPARSE);  // at bpf prog verification time
>   vm_area_map_pages(area, kaddr, 1, page);   // on demand
>                     // it will return an error if kaddr is out of range
>   vm_area_unmap_pages(area, kaddr, 1);
>   free_vm_area(area);                        // after bpf prog is unloaded

I'm still wondering if this should just use an opaque cookie instead
of exposing the vm_area.  But otherwise this mostly looks fine to me.

> +	if (addr < (unsigned long)area->addr || (void *)end > area->addr + area->size)
> +		return -ERANGE;

This check is duplicated so many times that it really begs for a helper.

> +int vm_area_unmap_pages(struct vm_struct *area, unsigned long addr, unsigned int count)
> +{
> +	unsigned long size = ((unsigned long)count) * PAGE_SIZE;
> +	unsigned long end = addr + size;
> +
> +	if (WARN_ON_ONCE(!(area->flags & VM_SPARSE)))
> +		return -EINVAL;
> +	if (addr < (unsigned long)area->addr || (void *)end > area->addr + area->size)
> +		return -ERANGE;
> +
> +	vunmap_range(addr, end);
> +	return 0;

Does it make much sense to have an error return here vs just debug
checks?  It's not like the caller can do much if it violates these
basic invariants.

