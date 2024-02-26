Return-Path: <bpf+bounces-22715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5424F86723C
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 11:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FC0290E2F
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 10:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29211CD18;
	Mon, 26 Feb 2024 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P3+Hq4bm"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026EA495CC
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944710; cv=none; b=d/p4VmjlYt3dT4zZq/5145S2G75rzwTkQ2NfnapFD69gWig695qQcstoWKAsUVoFsv43Uxf9YyEB5SwGcFuZwDQMHP33nEZNdSPefRSjYzHyzCSN17VZ4xry1ZtSVaU3zYRlraLvJfYrS90m3Q94E56dLWW6cSgE60zsj92PuFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944710; c=relaxed/simple;
	bh=Mudd88/Dl4YOIrrJDw3mC/nsMtzy34A2GuKd9iwFWek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/gIOzGSOp9MMki54LidEQyt5VcfswkFzEjHHiOg8nnJecP/FYaT0eYAk5WDSCVU/qroEU1nH/pNugWH4qEO5FYyY6W4GxZDJoG37+TSmkEeaC9VQrDF7W0EKRuWTwMy67QHbZ6v4WReJtjdnSM8tWWV2zOkUgxqWgYfa+tiLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P3+Hq4bm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8roVx31ufi19zVwomTMUR9WxKwNhqkCKOnoNzyb/69w=; b=P3+Hq4bmD5YRk1RKTqJit0XKn5
	edh2klMjQWEF1w5iz23iQZUvSSJmxb4CSHjtVtmQA8lMnrA3OE9mwCwkZqekhvR7l9wmK2QQirKzK
	zyedNXBLj78QUDEQE9qUuYheD0aSjuqCyv45SGF6zziygXDEi2xq7I8Gip/qKZ+8mPIPxQdbdXsD3
	OuUIwsR4wUfb2Vx9tqZKSvGcY6YfF1MJe3FpPeBK3caVnfapnLfBb9bY94uASzk1+gOmY9YTszZaN
	hBGBfzgqIv2mDJZKE8KiLS9XKG8zQ08KJ/PCXrl36Cbea6Y85IKYOiDZmvjqMGCo3eoCf+CsVRsNo
	Umn4nkiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reYaK-00000000CXP-1Ea2;
	Mon, 26 Feb 2024 10:51:48 +0000
Date: Mon, 26 Feb 2024 02:51:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org,
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com,
	hch@infradead.org, boris.ostrovsky@oracle.com,
	sstabellini@kernel.org, jgross@suse.com, linux-mm@kvack.org,
	xen-devel@lists.xenproject.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 2/3] mm, xen: Separate xen use cases from
 ioremap.
Message-ID: <ZdxtRLw-PxYNkH1u@infradead.org>
References: <20240223235728.13981-1-alexei.starovoitov@gmail.com>
 <20240223235728.13981-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223235728.13981-3-alexei.starovoitov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Feb 23, 2024 at 03:57:27PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> xen grant table and xenbus ring are not ioremap the way arch specific code is using it,
> so let's add VM_XEN flag to separate them from VM_IOREMAP users.
> xen will not and should not be calling ioremap_page_range() on that range.
> /proc/vmallocinfo will print such region as "xen" instead of "ioremap" as well.

Splitting this out is a good idea, but XEN seems a bit of a too
generit time.  Probably GRANT_TABLE or XEN_GRANT_TABLE if that isn't
too long would be better.  Maybe the Xen maintainers have an idea.

Also more overlong commit message lines here, I'm not going to complain
on the third patch if they show up again :)


