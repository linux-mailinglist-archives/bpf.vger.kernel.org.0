Return-Path: <bpf+bounces-64507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE54B1395F
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 12:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB4A3B5856
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB33254849;
	Mon, 28 Jul 2025 10:57:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEAD24DD12;
	Mon, 28 Jul 2025 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753700235; cv=none; b=mudX5+I6vdL8dWDibXD2DGXtVI6bNpqNrcuuteXyKbhxmQcwXgbjatOLurYS3XZyG81eV2zXGryxArwnFOloRR5bLaOuBdSifhTr4F/3+BaN7ylYs2mFbFlbWVA7x0bZjxR4pXTjyVbzIapbutwdXEjC+FhgdYHxQVxI73UYBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753700235; c=relaxed/simple;
	bh=76QdSn73LOh9tmQFxgQKv1HVjQzRj9Ri17MZ+QOX3Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJhnrCDQoJFg0tyC+ZYtDkW/KnyhUlL/W6iEt3d/cjRCNFlaMUS4FvmZ2xv9ljRXqQ1yGM8XM5HvmtLAPWnKLV2n/GGgSThKqNdDUFY8hBPBmBXsB3euVmFjTq1r7qlIe8RfeXUJYnp49yj3OMs9A//rvI2ZvZjMweRcpOHI3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-ea-688757822918
Date: Mon, 28 Jul 2025 19:57:01 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool
 in page type
Message-ID: <20250728105701.GA21732@system.software.com>
References: <20250721054903.39833-1-byungchul@sk.com>
 <e897e784-4403-467c-b3e4-4ac4dc7b2e25@redhat.com>
 <20250721081910.GA21207@system.software.com>
 <8b6e6547-cb39-4e64-8dff-6e16e27e7055@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b6e6547-cb39-4e64-8dff-6e16e27e7055@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaWxMURiGc+65c+/txMQ1imMJMWJJpbXE8lkifhBHRDTRkIxYJnpjJqZV
	U6qVkIuJpUwVLTod6di6IWWq7bTpWLraW7XkqmprUEQVVU1Hq8wU4d+T9/2+5zs/joC1HtUw
	wRS9RbJEG8w6Ts2qP/Y7Hbp75T7jZPtTAEfeRQ4udMVDVrNbBY7cQgQdvuc8/PRUIfhaUc3B
	h/J2BGdPd2Jw1FhZ+Jb3HcObKi8PF1xLoSmzhYXSfUUYvIdvcWCzdmPw+Np42O3OZsCRL/NQ
	W5ikgpTv5zEUyc08PCpxcNB48acKWspsLNy257DwObUCQ1PSfKhyDobOu60IKvKKGOg8dIqD
	J2klDBR4nvBwrM7JwStrE4K6ci8LqT37OUjflYSgu8uvbEvuUEF6ZSM/fyLdpSgcLW/9hOnV
	nGcMVa7dYWix/QVPna6tND87hCYqdZi6cg9w1NV+lKcNT0s5eutkN0uLX86ixe6vDLXtaePo
	lzf1bHiwXj03UjKb4iTLpHnr1MYTn9/imLeq+N7STFZGBWwiChKIOI2UlGTwf7m7MI8JMCuO
	JTX5KX05J44niuLDAQ4WJxDX3st+VgtYvMqT1I76vmKgqCe1sqdvWSMC6XH7+MCQVryHiPNK
	+p9iALmd9rrvMhZDiNL73p8Lfh5OsnqFQBwkziOlR36PDBLHkBuF1UzAQ8RmgSTvyUC/XzqU
	3MxW2GQk2v/T2v/T2v9pnQjnIq0pOi7KYDJPCzMmRJviw9ZvinIh/6fK3NGzyo3aa5eXIVFA
	un6adzP3GrUqQ1xsQlQZIgLWBWtizvsjTaQhYbtk2bTWstUsxZah4QKrG6KZ2rktUituMGyR
	NkpSjGT52zJC0DAZLbbph1obrEneNnP4gQVzHJsfRySGLoOmjtYz+aBvWbO6fNQMye6V792v
	HCmn1vrqD1pSHs5eM0N5lTtixY0iU3VoY0H15iUfuurlM5U153omTo1YpJePRWxfeH/n9enJ
	L/snXPoR1nDowXtrGrZpx9XZFlYej/cktvPhk0/S0abXOjbWaJgSgi2xhl8QJnYFUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHee5zd+91tbjZqovSl1VkUlZQdKI0C6KbZAQKgRS58tJG02RT
	USuYL6ll6iwlnYtmoakZ6rQ5dfYyTbOiZGFNK996sUjMdzTN2qzIbz/+//M758thsPsNkQej
	jIgS1BFylYwSk+JDO5M2Jh5JVWwu6l0FhopyCu5MxcLtXosIDGVmBOPTb2n41diCYKy5lYJv
	TaMIbhVOYjC8TCZhouIHhk8t/TTcMQVCT/FnEqyptRj6s55QkJE8g6FxeoiGREsJAYZqLQ1N
	19tE0G7OFEHOjyIMtdpeGl7VGyjoLv8lgs+2DBLa9KUkDOc2Y+jJ9IcW4wqYfDaIoLmiloDJ
	y9cp6MivJ+BeYwcNV+1GCj4k9yCwN/WTkDubRkFBQiaCmSnnyiHduAgKHnfT/hv4BIeD4psG
	v2O+prST4B33nxJ8nf49zRtN0Xx1iTd/yWHHvKnsIsWbRq/Q/LvXVop/kjdD8nV9O/g6yxjB
	ZyQNUfzIpy7y8PIQ8a4wQaWMEdSb/ELFimvDAzhyQBQ7Zy0mtegeeQm5MRy7lZsxVxAuJtm1
	3MvqHNrFFLuOczimsYulrBdnSql0spjBbA3N5Y53zRfL2BCuXds4L0tY4GYt07RryJ19jjhj
	VcHfYinXlv9x/hpmvTnH3FdnzjjZk7s9x7hiN9aPs2b/GVnOruYemlsJHZLoF9j6Bbb+v21E
	uAxJlREx4XKlapuP5rQiLkIZ63PyTLgJOd+m+PxstgWNv9pvQyyDZIslX7anKNxF8hhNXLgN
	cQyWSSWRRc5IEiaPixfUZ46ro1WCxoY8GVK2UhJwRAh1Z0/Jo4TTghApqP+1BOPmoUW6lVBz
	JR8lhEvyszpPsPsGCx22FQ+EpT17yh9Juh6lnchZbc7MTl2UPhvcR2FputdeQx9Oq9JVljc8
	VsX/xGuiRoJHJ4LOBnv4t+7JO/cioDSw7+7Fm6G6yI4gsdtU5aolxwt2H6uasAbapbpDb9Zv
	e99+9ODUyXSywdf3wIVsu4zUKORbvLFaI/8NkQW17zIDAAA=
X-CFilter-Loop: Reflected

On Mon, Jul 21, 2025 at 10:49:37AM +0200, David Hildenbrand wrote:
> > > 
> > > This will not work they way you want it once you rebase on top of
> > > linux-next, where we have (from mm/mm-stable)
> > > 
> > > commit 2dfcd1608f3a96364f10de7fcfe28727c0292e5d
> > 
> > I just checked this.
> > 
> > So is it sufficient that I rebase on mm/mm-stable?  Or should I wait for
> > something else?  Or should I achieve this in other ways?
> 
> Probably best to rebase (+test) to linux-next, where that commit should
> be in.

+cc sfr@canb.auug.org.au

	Byungchul
> 
> Whatever is in mm-stable is expected to go upstream in the next merge
> window (iow, soon), with stable commit ids.
> 
> --
> Cheers,
> 
> David / dhildenb

