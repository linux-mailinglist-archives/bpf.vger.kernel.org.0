Return-Path: <bpf+bounces-62022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFEAAF0705
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 01:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEB24E118E
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 23:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D5C302CD2;
	Tue,  1 Jul 2025 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4lQxpEO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED44A2857FC;
	Tue,  1 Jul 2025 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751413512; cv=none; b=kMFz0r/AFqn3uTEA7JIUTI7JMhdrBGX0suOaTRP8NEARtaF9GkkKxCWblOlqP6U3hba7rhhXE0uyltmy0kqr/7PAACPbZZuIsRwbeQqsDzy3WsRZnzzErDl2JY/UnXpj/dbX2qHIzVLDx3uiDgiggKJR5yp2fvKfxZurKTWaIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751413512; c=relaxed/simple;
	bh=Gi4HgI/fcGLhn4scOdNk/B+Txx51RJ5SF8pfQNLBedw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6UYrg3eWuRDDWX4pQMgpcT22PEmDWD1yrwoz0Dua3/v5Ra8An9rgn8QLI4k/zAtPnv3lb8nfoYlHqnmd3XbYwdoiDMQS8FobBRjBCUjNB8f0S3zbB/fjiHZ9whitN932bPjJTBlI9aY+wsYC6l1+CzOMQ+VpqHqAcGRNg9x4IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4lQxpEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E77C4CEEB;
	Tue,  1 Jul 2025 23:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751413510;
	bh=Gi4HgI/fcGLhn4scOdNk/B+Txx51RJ5SF8pfQNLBedw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m4lQxpEOa6oeH3or8pRm4zhWDl23ESs4tyFmiPZeaDetKINeN+eEk2eHLQdKKrLdl
	 fHt3OL4c60fYb4talT9acSdKCIoQ7+d5bfrOmrJQRKdbvrDM/vzJUQePmF58cmi3cB
	 HeEZMjE5iw3bGKUVDNjOQdjO9Cyzyt6wMpIMDj457sttmG6AzAx2+9zZxb8UbHKGzZ
	 ltLDJYyoIDitJr4JezQ7llkVUWyLR6GMgVOE4ZyTJPPz91aCJHQpE4+ufoE4Zb51G5
	 nQXIl31TEEH6Y9NQHwbgi1dw0wfnhawjUF5Ls0OMryT1Ld7buBh1ycR2ZnztSPWC7+
	 gyDok0gSbcVuQ==
Date: Tue, 1 Jul 2025 16:45:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, almasrymina@google.com,
 ilias.apalodimas@linaro.org, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Subject: Re: [PATCH net-next v7 1/7] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250701164508.0738f00f@kernel.org>
In-Reply-To: <aGHNmKRng9H6kTqz@hyeyoo>
References: <20250625043350.7939-1-byungchul@sk.com>
	<20250625043350.7939-2-byungchul@sk.com>
	<20250626174904.4a6125c9@kernel.org>
	<20250627035405.GA4276@system.software.com>
	<20250627173730.15b25a8c@kernel.org>
	<aGHNmKRng9H6kTqz@hyeyoo>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 08:34:48 +0900 Harry Yoo wrote:
> > Ugh, you keep explaining the mechanics to me. Our goal here is not
> > just to move fields around and make it still compile :/
> > 
> > Let me ask you this way: you said "netmem_desc" will be allocated
> > thru slab "shortly". How will calling the equivalent of page_address()
> > on netmem_desc work at that stage? Feel free to refer me to the existing
> > docs if its covered..  
> 
> https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> https://kernelnewbies.org/MatthewWilcox/Memdescs
> 
> May not be the exact document you're looking for,
> but with this article I can imagine:
> 
> - The ultimate goal is to shrink struct page to eventually from 64 bytes
>   to 8 bytes, by allocating only the minimum required metadata per 4k page
>   statically and moving the rest of metadata to dynamically-allocated
>   descriptors (netmem_desc, anon, file, ptdesc, zpdesc, etc.) using slab
>   at page allocation time.
> 
> - We can't achieve that goal just yet, because several subsystems
>   still use struct page fields for their own purposes.
> 
>   To achieve that, each of these subsystems needs to define
>   its own descriptor, which, for now, overlays struct page, and should be
>   converted to use the new descriptor.
> 
>   Eventually, these descriptors will be allocated using slab.
> 
> - For CPU-readable buffers, page->memdesc will point to a netmem_desc,
>   with a lower bit set indicating that it's a netmem_desc rather than
>   other type. Networking code will need to cast it to (netmem_desc *)
>   and dereference it to access networking specific fields.
> 
> - The struct page array (vmemmap) will still be statically allocated
>   at boot time (or during memory hotplug time).
>   So no change in how page_address() works.
> 
> net_iovs will continue to be not associated with struct pages,
> as the buffers don't have corresponding struct pages.
> net_iovs are already allocated using slab.

Thanks a lot, this clarifies things for me.

Unfortunately, I still think that it's hard to judge patches 1 and 7 
in context limited to this series, so let's proceed to reposting just
the "middle 5" patches.

