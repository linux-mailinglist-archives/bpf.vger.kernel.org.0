Return-Path: <bpf+bounces-63973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F5EB0CEF2
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 03:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763C11AA32E8
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 01:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EEA176AC5;
	Tue, 22 Jul 2025 01:03:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21C10E5;
	Tue, 22 Jul 2025 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753146226; cv=none; b=DYZTSDlAoxFSn64SdO6P02AiBqwOI7MxrkCwZa/wQDWPkA9ZObudo2+aS/TWEqmvA9rTZ4zrv9Xj9rBQBO9rQwi7U8qBsD9JcgNpruBx4XZzxzZAaA31kRBQOT0JzAPz//I1EVYzNB0RgbCYX6C6FObXkrf1mdLBj6SQ7iqJKQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753146226; c=relaxed/simple;
	bh=DXASI+KcllIoznSfl+B3VIAReIqMda3Z/G7kKrcujQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnklwmZdUquw3FS2jKOMX28eMXNhTIZtvDz00X6RPNAXmDMoniv4RNqCQvbbe3TB3g0wTBa6GtXzgatiJVLvhBw/rmJ/IvELoxYDnVBsfAo6Snb7gX8JSbda29rinP3kl6IR66ANk3SxYjl6LM55WiALS/7EZSH9AQU/pUD+ZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-88-687ee3638325
Date: Tue, 22 Jul 2025 10:03:26 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool
 in page type
Message-ID: <20250722010326.GA45337@system.software.com>
References: <20250721054903.39833-1-byungchul@sk.com>
 <77ee68c4-f265-4e55-9889-43ab08f26efd@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ee68c4-f265-4e55-9889-43ab08f26efd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+c45O+c4XJ2W1VcWxLoIk25S8HbF/n1/pKAIWlANPbTRvDDT
	tIutNCpLk8rKuWIV6XTCasbczFnO5a0f2bq4tLTsAqGtslzZTNuUqH8Pz/vy8P54eVrukMzh
	tWn7RH2aWqdgpYz0U/T1Jclv8zTLXWeXgclWw4L1Zw5UvnZKwFTtQPB9pIeDcXcLgm/eVhYG
	mocQ3LgWpMH0qICBYdsvGt639HNgtSdBX8UHBhpO1NHQf7aNhaKCEA3ukQAHx5wWCky1Bg46
	HcUSuPDrJg11htccPKk3sdBbMy6BD54iBtqNVQx8KfXS0FecCC3mmRB8OIjAa6ujIHjmCgvP
	yuopOO8zs/C2oA+Br7mfgdLRkyyUHy1GEPoZrgVKvkug/EEvl6gkzYOfaXKn6gVF/I0dFHEZ
	X3HEbM8itRYlKfT7aGKvPsUS+9A5jrx83sCStsshhrjerCYu5zeKFOUHWPL1fTdDPjc+YzdP
	V0nXpYg6bbaoX7Zht1Qz4LMxGf7onCpPt8SAnkQVoigeCytxZXuv5C8/db9kIswIi/ClbusE
	s0Ic9vtH6AjHCPF4oMvDFSIpTwsXOXzC1sBGBtMFFe40uKkIywTAv3/fm/ByQYNdNdfZST8N
	t5e9m4jSghL7xz6G9/kwx+LKMT6io4T12DjcxUV4hrAA33e0UpO3+XncdXrJJM/GTRY/U4IE
	439V439V47+qGdHVSK5Ny05Va3Url2py07Q5S5PTU+0o/E0Vh0d3ONFQ5xYPEnikiJbNN+Rp
	5BJ1dmZuqgdhnlbEyIJ3w0qWos49IOrTd+mzdGKmB8XyjGKWLCG4P0Uu7FHvE/eKYoao/zul
	+Kg5BmTdmeg7057VOvdhq7uowuqojwndOugwGMduK7TlStW9OK9quKMjocX5sTxuLze6cFr1
	+I/V0t6Nt4evhkqimywKe+OtIxaKGGqa8vjBg/NqzT2H1oZKvI+PrXp6PH67ShWr3Zaf/GM0
	STfTsiqgWFyxJmXT1vipSfUZgRtXpvQnKJhMjXqFktZnqv8AAVMpTEkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTYRSF889M/xmaNhkr6ghKpEZNQHEJxosI4c2JicTEBxN9kFFG27CI
	rSIYJVVIUEIRFVRKibiwFm1SCZRVLcgixKWIVHZBMQbEhSXs2GKMvn35zj3n6TKkIkviwaij
	z4iaaCFSiaWUNDQwccvxwQTVtiq9AozmEgymqTgo6LdKwFhchmB8uouGxZoGBGP1jRiG634h
	eHBvkgTj6yQKJswzJHxuGKDBZNkPfflDFFQnl5MwcK0Jgz5ploSa6VEaLlsLCTA+0dFQl9Ms
	gTdlaRLImMkjoVzXT0NbpRFDb8miBIZsegqaDUUU/MisJ6EvLQQaclfCZMsIgnpzOQGTqTkY
	2rMqCbhpz8UwmNSHwF43QEHm3BUM2ZfSEMxOOddG08clkP2ilw7x5etGvpN8adEHgnfUviT4
	CkMPzedazvJPCn34FIed5C3FVzFv+XWD5rvfV2O+6c4sxVd8DOArrGMEr08cxfzPz50U/722
	HR9wPyzdEy5GqmNFzdbgMKlq2G6mYhyyuCJbp0SH2txSkBvDsf7cu5puysUUu4G73WlaYsxu
	4hyOadLF7qwvN9xho1OQlCHZWzSXbK7GrmA5e5h7o6shXCxngZuff7rkFayKqyi5j//4ZVxz
	1qelUZL14RwLX533jJM9uYIFxqXd2CDOMNFBu3gFu557VtZIpCO54b+24b+24V87F5HFyF0d
	HRslqCN3+mkjVPHR6ji/46eiLMj5MPkX565b0XjbXhtiGaSUydfpElQKiRCrjY+yIY4hle7y
	ySqnkocL8edFzamjmrORotaGPBlKuUq+75AYpmBPCmfECFGMETV/U4Jx89ChULPorT6xXjYm
	i8pbO9hz2mvXOeOXj8JPeOiNF8JM9wK7WlOfz4VerG/O3PFMef/lC/EQGeip929d9SpmpsG+
	8YPX7sWAIy0ZK0bnPlUftBYEt8tCBoyejy54mTYLGXRHeK39bsAxmRB0/nH/Nx9HozIev+1d
	E/FgtYoaKc3OtikprUrY7kNqtMJvRgCHhywDAAA=
X-CFilter-Loop: Reflected

On Mon, Jul 21, 2025 at 12:12:39PM +0100, Pavel Begunkov wrote:
> On 7/21/25 06:49, Byungchul Park wrote:
> > Hi,
> > 
> > I focused on converting the existing APIs accessing ->pp_magic field to
> > page type APIs.  However, yes.  Additional works would better be
> > considered on top like:
> > 
> >     1. Adjust how to store and retrieve dma index.  Maybe network guys
> >        can work better on top.
> > 
> >     2. Move the sanity check for page pool in mm/page_alloc.c to on free.
> 
> Don't be in a hurry, I've got a branch, but as mentioned before,
> it'll be for-6.18. And there will also be more time for testing.

I'm not.  I listed the two items above wishing someone to work on it on
top of this patch in the future.

> > This work was inspired by the following link by Pavel:
> 
> The idea came from David, let's add
> 
> Suggested-by: David Hildenbrand <david@redhat.com>

Okay.  I will replace the current one with this.

> ...> -
> >   static inline bool netmem_is_pp(netmem_ref netmem)
> >   {
> > -     return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
> > +     if (netmem_is_net_iov(netmem))
> 
> This needs to return false for tx niovs. Seems like all callers are
> gated on ->pp_recycle, so maybe it's fine, but we can at least
> check pp. Mina, you've been checking tx doesn't mix with rx, any
> opinion on that?

I will wait for the answer of this before going ahead.

> Question to net maintainers, can a ->pp_recycle marked skb contain
> not page pool originated pages or a mix?

This too.

	Byungchul

> --
> Pavel Begunkov

