Return-Path: <bpf+bounces-61723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEDEAEAD9B
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 05:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E69166DCD
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 03:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151221A314D;
	Fri, 27 Jun 2025 03:54:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC87199FD0;
	Fri, 27 Jun 2025 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750996459; cv=none; b=uff1RfafbibSnGTdx4xECYW+CMWsk4zFYrpIwRKPhqU5naBITkyiyBmzCF06ellzSiYcXRav+ueVafGvgRPuF79o13jhse/XbDrRK0187Cw97CVZdB2TtOmQEN9QVLHdrBaYwSBOXiK5ckIvTx6T4Hlio42EpQQVot37rimnJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750996459; c=relaxed/simple;
	bh=1wSshET0D4HzFtPkni4hcnJJMmDOUANJjtoKlvShps8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYCkzhbHTFD1oNEC1pLBxXS9qJVppLycdCOiYdIwB9y2FdYfLyVHPL9X0ZODFmBda+/gv0VhBnlgM31r7fFPKNppdt7Q8IcYqGpvWVVAOi3m+C8WlCDxP7mYwtEL7NY3kmsMjrTPF7NZoHIm+Ym4pPuSG9fTDrvRpDLBRCSt23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-b5-685e15e2381c
Date: Fri, 27 Jun 2025 12:54:05 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v7 1/7] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250627035405.GA4276@system.software.com>
References: <20250625043350.7939-1-byungchul@sk.com>
 <20250625043350.7939-2-byungchul@sk.com>
 <20250626174904.4a6125c9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626174904.4a6125c9@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85O+e4Wh3nrFf9EsuohDJD6iG6GAQdiiiQIhLTUzu41TSZ
	lzRITKWLqd1Ec7OYRrmWNZvhVkytqVmYFZaxbmrrQpktLBuppW2K5Lcf/+f//Hg+PCwp10tC
	WU1KuqhLEbRKWkpJv82sXuIO3q1e1mpaBJWWWhqu/c6Cmj67BCrNDQiGhl8z8LO1nYZLVV4S
	Kp8UUPDLMkLCx/tuBq5Zt0DvlU8UOI7ZSHCfekBDccEoCY3DHgby7CYCnjaUSKB05DIJttw+
	Bp7dqaShp3ZcAp+cxRQ81F+loLckBu4b54C3YwBBq8VGgLfoAg3nuow0vC/oRdDV4qbAcKQE
	gaXJJYHR3z6Hoa2HiQnnWwa+k/ytqy8J/rb+LcMbrRl8vSmCL3R1kbzVfILmrT/OMvybFw6a
	f3B+lOJv238SfHG+h+YHP76i+O9N3TRvudVN8Y+Mrcy2wF3S1SpRq8kUdZFrE6XqzrHU1DJF
	lvP1YyIXDc8uRAEs5qKxNb9TMsV/y0YYP1PcAjxoez/BNLcQu1zDpJ8VXDguqK+gCpGUJbkq
	GhvLHROlIE7ADvcQ4WcZtxL3egaRvyTnjiLc/vcPPTkIxA8rPlB+JrkI7Br74ltgfRyGa8ZY
	fxzAReGeurYJTzA3H99taCf8HszZWVxuyCcmLw3B90wu6jTi9NO0+mla/X+tEZFmJNekZCYL
	Gm30UnV2iiZr6d4DyVbk+5grh//E2dGPp7FOxLFIOVMGkfFquUTITMtOdiLMkkqFTPbCF8lU
	QvYhUXcgQZehFdOcKIyllHNly70HVXIuSUgX94tiqqibmhJsQGguqh5fMn55lmFASLz5anvF
	RvWOFfuDjElNbS2bPMkrYj6c6Xt+z1bSfD3rRkh6R96Q1/A1pCbOGj508eChvC/xOfnanFX9
	/SfvzD5uXluxWfHZY1l8rK/fZG5+1xwl3VnduHVfUUMd+UaVvj7uVFFsRlhdqWJeQtjGPd9m
	sGvWBedoNjiVVJpaiIogdWnCP+YTlCAtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+59zds7ZaHRasw5WRLMLCKVC0QtGaRT9CbKgD4WUeWgHN9Jp
	m5cZBGpWJGllUTqVJtbyFqspOmtKTE1NummXleVkphSIZl5wOq3NiPr243mf3/PpZUmFjwpm
	tbpUUa8TElW0jJLFRJ7f4gmK04TPTy2HUmstDTUzRrg/YJdAaXUDgklvHwMTbR00VJRPk1D6
	KpeCKessCUPPPAzU2A6C2zJMgeNSIwmeq5005OfOkdDsHWUgx15JQGtZlwReNxRI4ObsPRIa
	swYY6H1cSkN/7S8JDDvzKegyVVHgLoiCZ+aVMN09gqDN2kjA9JUyGm70mGkYzHUj6Gn1UFCS
	XYDA2uKSwNyMf6OkvZ+J2ohbR8ZIXF/1kcBNpi8MNtvScF1lKM5z9ZDYVn2ZxrafhQz+/N5B
	486iOQo32ScInH9+lMbjQ58oPNbyjsYV334Q2Fr/jjqsiJXtVIuJ2nRRH7YrXqZ5sZCScktp
	dPa9JLKQd1kekrI8t42fvzXLBJjiNvLjjYOLTHObeZfLSwZYyW3gc+uKqTwkY0munObNtx2L
	pRWcwDs8k0SA5dwO3j06jgIlBXcR8R3zPvrPYTnfVfyVCjDJhfKuhe9+gfXzav7+AhuIpVwE
	3/+wfXEniAvhnzZ0ENeQ3PSfbfrPNv2zzYisRkqtLj1J0CZu32o4rcnUaY1bTyUn2ZD/Jyzn
	fNftaLJ3vxNxLFItlUPYCY1CIqQbMpOciGdJlVIuf++P5Goh86yoTz6pT0sUDU60mqVUq+QH
	jorxCi5BSBVPi2KKqP97JVhpcBb6kO5u3hO3e2/LnoLI4dCcwyOFwZbxyDMZIeua7Z2HXsbi
	48mOu1NrpSHMvti3j2a6pc0Pomq8tRHdRypLBt8svMkr0s2uWXKkzfVELxo3FR6LUSh3L2GU
	FkF7Y29/X/QFaVjCnO/j83D1g+hstTmDbcLrM3y8uvfmHUtyNFW1RkUZNEJEKKk3CL8BPOu0
	Jg8DAAA=
X-CFilter-Loop: Reflected

On Thu, Jun 26, 2025 at 05:49:04PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 13:33:44 +0900 Byungchul Park wrote:
> > +/* A memory descriptor representing abstract networking I/O vectors,
> > + * generally for non-pages memory that doesn't have its corresponding
> > + * struct page and needs to be explicitly allocated through slab.
> 
> I still don't get what your final object set is going to be.

The ultimate goal is:

   Remove the pp fields from struct page

The second important goal is:

   Introduce a network pp descriptor, netmem_desc

While working on these two goals, I added some extra patches too, to
clean up related code if it's obvious e.g. patches for renaming and so
on.

> We have
>  - CPU-readable buffers (struct page)
>  - un-readable buffers (struct net_iov)
>  - abstract reference which can be a pointer to either of the
>    above two (bitwise netmem_ref)
> 
> You say you want to evacuate page pool state from struct page
> so I'd expect you to add a type which can always be fed into
> some form of $type_to_virt(). A type which can always be cast
> to net_iov, but not vice versa. So why are you putting things
> inside net_iov, not outside.

The type, struct netmem_desc, is declared outside.  Even though it's
used overlaying on struct page *for now*, it will be dynamically
allocated through slab shortly - it's also one of mm's plan.

As you know, net_iov is working with the assumption that it overlays on
struct page *for now* indeed, when it comes to netmem_ref.  See the
following APIs as example:

static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
{
	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
}

static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
{
	__netmem_clear_lsb(netmem)->pp = pool;
}

I'd say, I replaced the overlaying (on struct page) part with a
well-defined struct, netmem_desc that will play the role of struct page
for pp usage, instead of a set of the current overlaying fields of
net_iov.

This 'introduction of netmem_desc' patch can be the base for network
code to use netmem_desc as pp descriptor instead of struct page.  That's
what I meant.

Am I missing something or got you wrong?  If yes, please explain in more
detail then I will get back with the answer.

	Byungchul

> > + * net_iovs are allocated and used by networking code, and the size of
> > + * the chunk is PAGE_SIZE.
> 
> FWIW not for long. Patches to make the size of net_iov configurable
> are in progress.

