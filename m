Return-Path: <bpf+bounces-61144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12648AE1216
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 06:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49DD5A30E7
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 04:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000441EA7DB;
	Fri, 20 Jun 2025 04:12:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F33218024;
	Fri, 20 Jun 2025 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392742; cv=none; b=f2uBWUoqMdqWhNCDNH299yOKTHJCT0I3ppjDVqTJ5h7ZqFXtaai0Nu7Y9as9FvCuqQxuyYnFr8pio3exvV9QMXZJ/5+P3ifsh10A4TI/cWFUOYG0aeg3WQQIsQydsH39RDvrCb3HQRj/GDbTG1rINCff8Kt0eU+ZWEvU5cn8U4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392742; c=relaxed/simple;
	bh=/yYEvc9YKJuB+6SO8RQVApaqJgCZjt1JYTqSqohRidQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8FGmBHZwoRPVcSCIgfTTObtc3PSDMk1tLkF+xrr7J8pgHstR/++PEKbsRsZYv78xlukcaEbqFsXY5mFOjtvoo5/dlvHadDFvYs50p6EH63pB/XK5wkaDoW0P7pk6JC22cEPSa4eQnmiwdzeIAR1z/RkFzKPr9o127hmfrEL4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-1d-6854df9d3c68
Date: Fri, 20 Jun 2025 13:12:08 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
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
	vishal.moola@gmail.com
Subject: Re: [PATCH net-next 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250620041208.GA11405@system.software.com>
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-2-byungchul@sk.com>
 <20250609123255.18f14000@kernel.org>
 <20250610013001.GA65598@system.software.com>
 <20250611185542.118230c1@kernel.org>
 <20250613011305.GA18998@system.software.com>
 <CAHS8izMsKaP66A1peCHEMxaqf0SV-O6uRQ9Q6MDNpnMbJ+XLUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMsKaP66A1peCHEMxaqf0SV-O6uRQ9Q6MDNpnMbJ+XLUA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa2yLYRTH87y3vuvW5FXDsxGigliCbRk5RGTxQV6XCOELEtT2Rkt3SWs3
	IcY6l7JhJqwr6YxdukUpum6qY8YuNqZ2qW3WZbZFxAydsUuMdhH79sv5n3N+58NhSelNOphV
	xh4W1LFylYwRU+KBgJtLr7t3KEIrny8Cg7mUgZJfyVDYbaPBYLIiGBrpEIGnuoaB/LxhEgyv
	tRT8MI+S0PeiRwTugn4K7KfLSOi5UMtAhnaMhJO2IgKarJk0ZI/eJqEstVsEbysMDHSVTtDQ
	X5VBQZ2+mAJ3ZiS8MM6E4ZefEVSbywgYPn+dgctOIwMftG4Ezmc9FOSeyERgdrhoGPtlYCLn
	8w+K3xF8uf69iDdaEvj7RSG8zuUkeYvpLMNbvmeJ+M5WO8PXXhuj+HKbh+Az0r4w/Le+doof
	dLQwvPlBC8U3GKtFvMcydyu3S7wmWlApEwX18rX7xIrBiQE6/vyc5Po7a1PRwAwdYlnMReBH
	nuM65OfD0TNXSS9T3ELcWNxLeJnhFmOXa8RXD+SW4FuOS7QOiVmS+0rj8u4R5A2mc3uwqeOn
	b0DCAR4w2X1NUq6ZwFmXO0STwTRcl9NLeZn8u3X8hpP0HkFys3Hhb3ayPA+nPcz1yfy4bThP
	20p7eQa3AD+x1hDenZizs/jNxSto8uog/LTIRV1E0/RTFPopCv1/hX6KwogoE5IqYxNj5EpV
	xDJFSqwyeVlUXIwF/f2cgmPju23oe9P2KsSxSBYgsQ1tV0hpeaImJaYKYZaUBUrya7copJJo
	ecoRQR23V52gEjRVaDZLyWZJwoeToqXcAflh4ZAgxAvqfynB+gWnovznOfeafxjtESuJivSk
	KP8n+rvGBQEP6wW6rz1RGxC+vj9Ymr45lGtqUTuzqq+kZx892BTpEAdtmG9oK4ymE8ZHT6lW
	6bLjz3WuGKLdobs+dTrOpD2+uvXQGwvVteHj+LqJyooG6U6XFQVa7fvbxvzTdJWrwzZu8pwe
	0byKKmmUURqFPCyEVGvkfwDhqzvKNQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+d3X7mar61K7ZFCtFwmZQcIRxaLnDwsxDMyCdNXNDR+TOxXt
	AZbaQ3LlI7K51WLlY2WLVTpLJKb5qCzRCtNSMYuK1tOsqT2cEfnfh+/3nM/557Ck4gg9m9Wk
	pAliiipJycgoWWRozjJT/1Z10M9fvmC0XWHg8o9MqBhw0GC01iAYdvdK4GtTCwOWCyMkGB/l
	UvDNNkrCq+ZBCfSXv6ag/mgtCYMnWxkoyB0j4bCjkoBGUxsNHTV6GkpGL5FQmz0gga5bRgb6
	rvym4bWzgII2QxUF/frV0Gz2g5H77xE02WoJGDlhYqC408zAy9x+BJ2NgxSUHdIjsDV00zD2
	w8isVuIbVc8IXGd4IcFmezq+XhmA87s7SWy3Hmew/UuRBD9/Ws/g1tIxCtc5vhK4IOcDgz+/
	6qHwx4YnDLa8+URg240nFH5gbpJEeW+Xhe0RkjQZgrg8PF6m/vjbRaeemJN572p4NnL55iMp
	y3Mr+dFjZ0gPU9wivr1qiPAwwy3hu7vdk7kPt5S/2FBI5yMZS3KfaL5uwI08xUxuJ2/t/T65
	IOeAd1nrJ4cU3GOCLyrulfwtvPm2s0OUh8kJ6/i5zgkrO8H+fMUv9m88l8+5WTZ5TMpt4S/k
	PqU97Mst4O/UtBCn0HTDFJNhisnw32SYYjIjyop8NCkZySpNUnCgLlGdlaLJDNytTbajie8o
	Pzhe6EDDXRudiGORcprcMRytVtCqDF1WshPxLKn0kVtaI9UK+R5V1j5B1MaJ6UmCzon8WUo5
	Sx4RI8QruARVmpAoCKmC+K8lWOnsbEQOBSyK9fIPW6W9G6JXhESutUSN6/e/lfyUds0r8pLF
	H1il1YbfXGDwjV33vfehGOquM2ryNkffCR7aIO4tOf1ubV79jF1Cn7ojdr4u5tCavMUuhbjN
	YqoujXCtKLu2e+F5R2D0pqDivdXtfd6nMNmz/vbnxq4dFS1E3EiMX0Jfo5LSqVUrAkhRp/oD
	2SBXbxkDAAA=
X-CFilter-Loop: Reflected

On Fri, Jun 13, 2025 at 07:19:07PM -0700, Mina Almasry wrote:
> On Thu, Jun 12, 2025 at 6:13 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > On Wed, Jun 11, 2025 at 06:55:42PM -0700, Jakub Kicinski wrote:
> > > On Tue, 10 Jun 2025 10:30:01 +0900 Byungchul Park wrote:
> > > > > What's the intended relation between the types?
> > > >
> > > > One thing I'm trying to achieve is to remove pp fields from struct page,
> > > > and make network code use struct netmem_desc { pp fields; } instead of
> > > > sturc page for that purpose.
> > > >
> > > > The reason why I union'ed it with the existing pp fields in struct
> > > > net_iov *temporarily* for now is, to fade out the existing pp fields
> > > > from struct net_iov so as to make the final form like:
> > >
> > > I see, I may have mixed up the complaints there. I thought the effort
> > > was also about removing the need for the ref count. And Rx is
> > > relatively light on use of ref counting.
> > >
> > > > > netmem_ref exists to clearly indicate that memory may not be readable.
> > > > > Majority of memory we expect to allocate from page pool must be
> > > > > kernel-readable. What's the plan for reading the "single pointer"
> > > > > memory within the kernel?
> > > > >
> > > > > I think you're approaching this problem from the easiest and least
> > > >
> > > > No, I've never looked for the easiest way.  My bad if there are a better
> > > > way to achieve it.  What would you recommend?
> > >
> > > Sorry, I don't mean that the approach you took is the easiest way out.
> > > I meant that between Rx and Tx handling Rx is the easier part because
> > > we already have the suitable abstraction. It's true that we use more
> > > fields in page struct on Rx, but I thought Tx is also more urgent
> > > as there are open reports for networking taking references on slab
> > > pages.
> > >
> > > In any case, please make sure you maintain clear separation between
> > > readable and unreadable memory in the code you produce.
> >
> > Do you mean the current patches do not?  If yes, please point out one
> > as example, which would be helpful to extract action items.
> >
> 
> I think one thing we could do to improve separation between readable
> (pages/netmem_desc) and unreadable (net_iov) is to remove the struct
> netmem_desc field inside the net_iov, and instead just duplicate the
> pp/pp_ref_count/etc fields. The current code gives off the impression
> that net_iov may be a container of netmem_desc which is not really
> accurate.
> 
> But I don't think that's a major blocker. I think maybe the real issue
> is that there are no reviews from any mm maintainers? So I'm not 100%
> sure this is in line with their memdesc plans. I think probably
> patches 2->8 are generic netmem-ifications that are good to merge
> anyway, but I would say patch 1 and 9 need a reviewed by from someone
> on the mm side. Just my 2 cents.
> 
> Btw, this series has been marked as changes requested on patchwork, so
> it is in need of a respin one way or another:

Some can be improved but the others not.  For example:

   +static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool,
   +							  gfp_t gfp)

It complains about the long line length but no idea how to avoid it :(
I can do nothing but to ignore..

	Byungchul

> https://patchwork.kernel.org/project/netdevbpf/list/?series=&submitter=byungchul&state=*&q=&archive=&delegate=
> 
> https://docs.kernel.org/process/maintainer-netdev.html#patch-status
> 
> -- 
> Thanks,
> Mina

