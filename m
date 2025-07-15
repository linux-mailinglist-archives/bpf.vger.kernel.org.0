Return-Path: <bpf+bounces-63287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E497B04DAE
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 04:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043597B3561
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 02:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510152C327B;
	Tue, 15 Jul 2025 02:08:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF242BAF7;
	Tue, 15 Jul 2025 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545315; cv=none; b=bdveytxT5SJ+AXDM811KMvO+3Tax/PCUvWzXrg4yqSnuLXgwq8lCEhrZL3zd9BLaW98ky6ev7/c6SuGHT/W9y7QagrEN7ek+UHzEJBYV0FWlv85zKuX88+1O2pvr4judyvBDlrWlSMPm/1fzSUOTh/uPmmTKWXqz3aVVfZK009o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545315; c=relaxed/simple;
	bh=jCmfu4Cq1HT1kT/tSt3zFQGeQNBzBfyC9ZCmWTbXlVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRKI19gFaYHMcYQ38WuYxrCPPCmoYK4qyt+Z9GbIovQySWdL1FYDY4j0uiufHkj3smXScwewYsLueOp7BUIdPAuirxjrnVs4AZwvKhfQnurP9+9xAn5vDMA8WYmSSaUACdxRcRTJ45+HTrE/h7ThfIU5L4BRmPKiuJEXE3rhu+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-49-6875b8184208
Date: Tue, 15 Jul 2025 11:08:19 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
	willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, almasrymina@google.com,
	ilias.apalodimas@linaro.org, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, horms@kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, vishal.moola@gmail.com, hannes@cmpxchg.org,
	ziy@nvidia.com, jackmanb@google.com
Subject: Re: [PATCH net-next v7 1/7] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250715020819.GA80407@system.software.com>
References: <20250625043350.7939-2-byungchul@sk.com>
 <20250626174904.4a6125c9@kernel.org>
 <20250627035405.GA4276@system.software.com>
 <20250627173730.15b25a8c@kernel.org>
 <aGHNmKRng9H6kTqz@hyeyoo>
 <20250701164508.0738f00f@kernel.org>
 <aHTQrso2Klvcwasf@hyeyoo>
 <92073822-ab60-40ca-9ff5-a41119c0ad3d@suse.cz>
 <aHUMwHft71cB8PFY@hyeyoo>
 <20250714184743.4acd7ead@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714184743.4acd7ead@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzjlbjo7L6m0GwVIK7aJh9ARRfjA4oYISRFmyRju00byw
	uaVB4NQKJS2yi86Fs/DSMkbL5gq12pbZjUSpVlkrb3S31GxmWU6L/Pbj//yfH8+HhyGklUIZ
	o8nM4XWZSq2cEpPiTyE1K2UugzpmwrkCLPZGCi4GcqH+tUsIFpsTwej4CxpGvHcoOF8zRoDl
	UREJ3+w/CBho76XhoiMZ/HWDJLQcaSag91gHBaVFEwS0jn+mocDVIIBOZ5kQTv6oJaA5/zUN
	3dctFLxq/C2EQXcpCXfNF0jwl8VDu3UBjN3/iMBrbxbA2NGzFJR3WSnoK/Ij6PL0klBlKkNg
	b/MJYSIw5ai6/YqOj+A8H4cIrunCMwF3zfyS5qwOA3elIYor8XURnMNWTHGO4RM01/OkheI6
	KiZI7pprRMCVFn6muK8Dz0luqO0xxdmbHpPcA6uXTglNE29Q8VqNkdet3rhbrB5olWXfonP7
	3pjIfJRPlSARg9k47P1uI//xt+aW6ZxkI7H/11NBkCl2Gfb5xokgh7ERuOhK5XSfYG9QOHA6
	LcjzWCVu6R2d7ktYwAV+HypBYkbKFhJ44OoHemYQiu9W9v9djsK+yXdTC8wUh+P6SSYYi9hY
	bPfUTlfms0vxTecdQdCD2UsMPuevoGcOXYRvNfjI44g1z9KaZ2nN/7VWRNiQVJNpzFBqtHGr
	1HmZmtxVe7IyHGjqYeoO/tzpQsOdW92IZZA8RALvc9RSodKoz8twI8wQ8jDJ+5c6tVSiUuYd
	4HVZCp1By+vdKJwh5Qsla8b2q6TsXmUOv4/ns3ndv6mAEcnyUc62/v3tKiZQfqYybL2xp7o/
	vRMtPl290HS8LzR9dcYW12BBbRg/h48xJMkSv6Qwc3lR9VuLQJbapyhf5+pmo+/t3bG2Z3lX
	UsWphF2exMuO6lrmsOJ6ZLJJ7ztEPiRuv4lWLDeWEQnDouiOw5s2fl+zpDgSGVK3P9zMymQ9
	CjmpVytjowidXvkHKz1dRSwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec95d87ZaHJaVi+uTyu7CFlR0QNdlIQ6REVEFFmkhzy14bVN
	RSVpXiAStSuRa8a6eoXVvE1Rq2mmhGSWtm6bLmdXtNTEWxdnRX378f//f8+nh6NVkziA08Ul
	Svo4MUbDKLBi5/qs5cSepF3Ze3IpmK3lDJSNpUBRj10G5tJqBCPjr1gYbn7IwPWrozSYH2dj
	+GadoMHb4mGhzLYD3Lf6MdSfrKHBc7qVgbzsSRoaxgdYyLQXU9BU2CaDjup8GVyYuElDjbGH
	had1ZgZc5T9l0O/Iw9BmKsHgzg+FFss8GH30GUGztYaC0dxCBs53Whh4m+1G0NnkwXA5Ix+B
	tdEpg8mx6RuXH7jY0ECh6fMgLVSWvKCEWtMbVrDYkoSK4iAhx9lJC7bSU4xgGzrHCq+76xmh
	9dIkFmrtw5SQlzXACF+9L7Ew2NjFCNfff6EEa2UX3qUKV2yIkmJ0yZJ+xaZIhdbbEJBwn015
	25uBjcjI5CA5R/g15FtN/QxjPpC4vz+nfMzwS4jTOU772J9fRLIrCrCPaf4uQ8Yuhvt4Di+S
	es/IzF7JA8l0O1EOUnAqPosm3qpP7O9iNmkr6PsjBxHnjw/TAjfNalL0g/PFcn4VsTbdnJnM
	5ReSe9UPqTNIafrPNv1nm/7ZFkSXIn9dXHKsqItZG2yI1qbG6VKCD8fH2tD0S9xKnzprRyNP
	tzoQzyHNLCV8TNSqZGKyITXWgQhHa/yVH9/otSpllJiaJunjI/RJMZLBgdQc1sxXbtsnRar4
	o2KiFC1JCZL+b0tx8gAjOhZSbY7AXE/K9tw0bnH7nt6wDfJL6avz916lHR7K9bKgaP/tZys6
	1O/GNgbLmSfqsICWLQMdVXXX/DYv2uhKTntSXnnB3hbvV0kniEcOLdg9wbuMC8jBiTvr5k9l
	tSv3DrErzSf6wov8y5bZLOndN8ynjh9rP1By+ob6Ch71aw7RYINWXBVE6w3iL74R2YYOAwAA
X-CFilter-Loop: Reflected

On Mon, Jul 14, 2025 at 06:47:43PM -0700, Jakub Kicinski wrote:
> 
> On Mon, 14 Jul 2025 22:58:31 +0900 Harry Yoo wrote:
> > > > Could you please share your thoughts on why it's hard to judge them and
> > > > what's missing from the series, such as in the comments, changelog, or
> > > > the cover letter?
> 
> My main concern (as shared on earlier revisions) is the type hierarchy
> exposed to the drivers. Converting things back and forth or blindly
> downcasting to netmem and upcasting back to the CPU-readable type is
> no good.

I understand your concern.  I removed a lot of converting things but
left essencial things, that is inevitable to remove accessing the pp
fields through struct page.  Is it still not okay with v10 [1]?

There are some points under disscussion with Mina but I'm curious about
how you think about the direction changed.

[1] https://lore.kernel.org/all/20250714120047.35901-1-byungchul@sk.com/

	Byungchul

