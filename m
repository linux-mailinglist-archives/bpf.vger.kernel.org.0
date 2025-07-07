Return-Path: <bpf+bounces-62480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EECDAFA894
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 02:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6244177A56
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 00:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6733613959D;
	Mon,  7 Jul 2025 00:22:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393BE1373;
	Mon,  7 Jul 2025 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751847721; cv=none; b=k6rW00htz8fjMO9KG94df7YKKJ8lTl0jL3OObsElykSdGyMas3lHm+B7dtvVrYBNcwgf84TlWPsENOI0m8nM5MCf6RyjKSoJoNMmEjglBOu0QcHjasj6nbtUVuU5unNvZ8SE/fIFWSL2gXdzkn3/vPKdnstgNExcijMnDBbcEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751847721; c=relaxed/simple;
	bh=hUyy8yKA2gGVH48GVBvBv9Us8897KhgL9cXpJipTfLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVK0L0xpxFVT6tA6fgQ/864CycZvZ0la9yxq1zz2Q9DId3tMrrVMmSam/DmbrO73OS33VgcbrERX6KTAiXvvDEGGnjCS0bAfB2Jo+r0xrtgtU/4gRgRT9M5Q7y3tIBzrfpx9lqbDldwRkIzzSdIt0EvWfXrzNJCRS8WnC3/p8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c0-686b131ab99d
Date: Mon, 7 Jul 2025 09:21:41 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, almasrymina@google.com,
	ilias.apalodimas@linaro.org, hawk@kernel.org,
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
Message-ID: <20250707002141.GA3379@system.software.com>
References: <20250625043350.7939-1-byungchul@sk.com>
 <20250625043350.7939-2-byungchul@sk.com>
 <20250626174904.4a6125c9@kernel.org>
 <20250627035405.GA4276@system.software.com>
 <20250627173730.15b25a8c@kernel.org>
 <aGHNmKRng9H6kTqz@hyeyoo>
 <20250701164508.0738f00f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701164508.0738f00f@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzjmuVsdp9WZFtUJD6KJYPdGFoi8vdCGwEMqogx7aci7b
	0jQKrEaRqIVJ5NRYRnnpspqlK5bpXKlkZoZ1stpkXkiyRmbStNtmRX378f8//Ph/eDhKZZZH
	cFr9AdGgF3RqRkErPkwsWxgRlqJZ8i0vDkqs1xi4+jUTyrvtciipqkEw7H/NwmdXEwOXLo5Q
	UPLURMMX6ygFfY+8LFy1bQLPlX4aHCdrKfCebmYgzzRGwX3/RxaO2Stk0F6TL4fC0csU1GZ3
	s/D8XgkD7ms/5dDvzKOhxVxJgyd/LTyyTIWRx4MIXNZaGYzkljJwtsPCQI/Jg6Cj0UtD8dF8
	BNY6SQ5jXwOO4odudu180jjoo8jtylcyctf8liUWWzqprogmOVIHRWxVpxhiGypgyZsXDoY0
	nx+jyV37ZxnJO/6RIZ/6umjiq+tkiPV2J01aLS52S+h2xapkUafNEA2L1+xWaNyuXCbNG5b5
	8oyXzUb1k3NQCIf5OJztaWP/ssN9Rx5kmp+Pv5fVUUFm+CgsSf5xDg/kpuoiOgcpOIq/zuBC
	dwsKFmG8gB3eYVmQlfxyLLU/GT9S8RdkePhB758iFLcU9dJBpvhoLP0YCORcgGfg8h9cMA7h
	Y7C/0z4+Ygo/D9fXNMl+j7Nz2Dem/c3TcUOFRJ9BvPk/q/k/q/mf1YKoKqTS6jNSBa0ubpEm
	S6/NXJS0L9WGAh9z5ci3HXY01B7vRDyH1BOVSxL2alRyIcOYlepEmKPU4coTTIpGpUwWsg6J
	hn27DOk60ehEMzhaPU0ZO3IwWcXvEQ6IKaKYJhr+tjIuJCIbbTvxYDRqo9k5NMu02+rvG7iV
	9P79ThW/bnVsQvGxZzsPz5kt1DfM/TKptHBrlLA0Kfy6/WbbrgmRzeA5XXBoDTnevipBP3R5
	DxJiF7y2RcKApOi5sXJFV8S8/TpJSqzx9a2eqTvny1i2OdJR/i6sunVwQ7zFiKO6nyV6Vq5f
	ENOmpo0aISaaMhiFX7d721stAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRiH+Z/bjsPhaZodrD60CsXSlG4vGGYfolNkRBBBRHnQQ5vOGVsb
	WgSmK2vlvQ82L6wk56UYTJuzlprXpJso1iqbY6nYBc2ckpnWJkV9e/g97+/l/fDSuHSRCKMV
	qrOCWsUrZZSYEB+Ky40KC06Tx9gur4EKy10KGr5ngtltJ6Gi3obAO/9OBDNdvRRU35rDoeKl
	noBZyw8cxno8ImiwJsJIzTgBjrxmHDyFTyjI1y/g8Gh+UgQ59loMOiv7SOi3FZBw48cdHJqz
	3SIYfFBBgevuLxLGO/IJ6DPWETBSkAA9plCYe/oFQZelGYO565UUlA6YKPigH0Ew0OkhoPxi
	AQJLq5OEhe++HeXdLlHCRq7zyxTONdW9wbgW43sRZ7JqucbaSM7gHMA5a/1VirN+KxFxw68c
	FPekbIHgWuwzGJefO0lx02NvCW6qdYjiqie+YpylaYg4LD0u3pUiKBU6Qb0lPkksd3Vdp854
	gjNfF3lE2ag9yIACaJbZxjpc90k/E8wGdvF2K+5niglnnc75ZQ7x5frGm4QBiWmcuUexN1x9
	yC+CGZ51eLyYnyXMTtbZ/3x5SMpUYay3bfSPWMH23Rwl/Iwzkaxz6aMvp328mjUv0f44gIll
	54fsy0esZNaz7bZerAhJjP+1jf+1jf/aJoTXoxCFSpfOK5TbozVp8iyVIjM6OSPdinxPUXPh
	Z7EdeQf3dSCGRrJAScyxVLmU5HWarPQOxNK4LERymUqTSyUpfNY5QZ1xSq1VCpoOtJomZKsk
	B44JSVLmNH9WSBOEM4L6r8XogLBslKk1M47U4nXdeaURJyXhLdW5w61u3KV9UWYo67nljZma
	fDpukkV5NjdeORivjziRyKyM99bsd15LCjUpX1QrPl/CtPDMbUwMakjcsSvj6NiRvaYg4/lp
	szFu9+NNn0pm7xe6hk2VCQ/3rI0PSk6PC+zd2phUNbGxPXVUl0NuapMRGjkfG4mrNfxvX+2S
	LBADAAA=
X-CFilter-Loop: Reflected

On Tue, Jul 01, 2025 at 04:45:08PM -0700, Jakub Kicinski wrote:
> On Mon, 30 Jun 2025 08:34:48 +0900 Harry Yoo wrote:
> > > Ugh, you keep explaining the mechanics to me. Our goal here is not
> > > just to move fields around and make it still compile :/
> > >
> > > Let me ask you this way: you said "netmem_desc" will be allocated
> > > thru slab "shortly". How will calling the equivalent of page_address()
> > > on netmem_desc work at that stage? Feel free to refer me to the existing
> > > docs if its covered..
> >
> > https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> > https://kernelnewbies.org/MatthewWilcox/Memdescs
> >
> > May not be the exact document you're looking for,
> > but with this article I can imagine:
> >
> > - The ultimate goal is to shrink struct page to eventually from 64 bytes
> >   to 8 bytes, by allocating only the minimum required metadata per 4k page
> >   statically and moving the rest of metadata to dynamically-allocated
> >   descriptors (netmem_desc, anon, file, ptdesc, zpdesc, etc.) using slab
> >   at page allocation time.
> >
> > - We can't achieve that goal just yet, because several subsystems
> >   still use struct page fields for their own purposes.
> >
> >   To achieve that, each of these subsystems needs to define
> >   its own descriptor, which, for now, overlays struct page, and should be
> >   converted to use the new descriptor.
> >
> >   Eventually, these descriptors will be allocated using slab.
> >
> > - For CPU-readable buffers, page->memdesc will point to a netmem_desc,
> >   with a lower bit set indicating that it's a netmem_desc rather than
> >   other type. Networking code will need to cast it to (netmem_desc *)
> >   and dereference it to access networking specific fields.
> >
> > - The struct page array (vmemmap) will still be statically allocated
> >   at boot time (or during memory hotplug time).
> >   So no change in how page_address() works.
> >
> > net_iovs will continue to be not associated with struct pages,
> > as the buffers don't have corresponding struct pages.
> > net_iovs are already allocated using slab.
> 
> Thanks a lot, this clarifies things for me.
> 
> Unfortunately, I still think that it's hard to judge patches 1 and 7
> in context limited to this series, so let's proceed to reposting just
> the "middle 5" patches.

Just in case, I sent v8 with the "middle 5" last week as you requested.
I'm convinced they are non-controversial but lemme know if any.

	Byungchul

