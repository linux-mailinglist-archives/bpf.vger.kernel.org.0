Return-Path: <bpf+bounces-53686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6CA5851C
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 15:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5D8188E5BD
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 14:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928E11DE3C7;
	Sun,  9 Mar 2025 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwjATJRZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA414A09E;
	Sun,  9 Mar 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532196; cv=none; b=ozxpADv/e7AU4w6LrLeoDzDUz2j3lO0lT1W7BGPGH6nWl7IlSJLv3g3yNyxwS12pm0utW14R1Iezuku+sq7FTFzV50MTnonU2cjsW6iugEUFfPgWIufQzeE9EWSsY8SIhUNpkHWxb6A4rQVLYjvYQkfK1FWro22YUWtBvFvLL3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532196; c=relaxed/simple;
	bh=Jhs0qRQUbAip+cpmFk01G57teBJ/kMUn81WHCTFJn3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6C8eVCyWE6SmSU+rLppbM0FIzxtW+XYYhNpD/zTvh/iOYNakM7QudvFZgJLWcLofXHBxgGfSlDP5BAW+ig256Bfc/NqZpgFGRT2DO0juQJ72/JDBSoATBcLN+3kZmJUCLGM1e/BYeXF/HzJW/pKM8y1qCfqUokYiuorbSaxgg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwjATJRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F2AC4CEE5;
	Sun,  9 Mar 2025 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741532195;
	bh=Jhs0qRQUbAip+cpmFk01G57teBJ/kMUn81WHCTFJn3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwjATJRZ1Oe8oZrmfOdhFyCWHQdckrDOiCEoSX5dS57fUHUlYBtpGPbxVRFQXiCdn
	 HBEo1eSyIy+P0ffLpLFg0EaOF+yT+bGwaeCtRfKjhs/7gMNdP2j9ekpwSv6VFZyCyt
	 Q/DO5gc1sCiF/O50ICRH8Ykc6ZbcNaoKloxrd87bRhJ8RBt0Io3vE1MZraf7zgYKST
	 syljBiC+D9Gp9Ec+ZBF1qHWuaSo/Ud14HQt3cuzZIg2Lo/1eAh0pXDN3NaPQisYJId
	 Fyh+ra/akjAF+X10v3OcoLCCan2tuWGJMuvS0lQrJzlQDp5xrii5fOlvK4xkPLfeZc
	 xXasN9/J9ltYg==
Date: Sun, 9 Mar 2025 04:56:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] sched_ext: idle: Introduce the concept of allowed
 CPUs
Message-ID: <Z82sImYF7jOgPGbL@slm.duckdns.org>
References: <20250307200502.253867-1-arighi@nvidia.com>
 <20250307200502.253867-4-arighi@nvidia.com>
 <Z8twc3pc7I9SyIMC@slm.duckdns.org>
 <Z8voSv70QuxuZa5Z@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8voSv70QuxuZa5Z@gpd3>

Hello,

On Sat, Mar 08, 2025 at 07:48:42AM +0100, Andrea Righi wrote:
> > > With this concept the idle CPU selection policy becomes the following:
> > >  - always prioritize CPUs from fully idle SMT cores (if SMT is enabled),
> > >  - select the same CPU if it's idle and in the allowed domain,
> > >  - select an idle CPU within the same LLC domain, if the LLC domain is a
> > >    subset of the allowed domain,
> > 
> > Why not select from the intersection of the same LLC domain and the cpumask?
> 
> We could do that, but to guarantee the intersection we need to introduce
> other temporary cpumasks (one for the LLC intersection and another for the
> NUMA), which is not a big problem, but it can introduce overhead. And most
> of the time the LLC group is either a subset of the allowed CPUs or
> vice-versa, so in this case the current logic already works.
> 
> The extra cpumask work is needed only when the allowed cpumask spans
> multiple partial LLCs, which should be rare. So maybe in such cases, we
> could tolerate the additional overhead of updating an additional temporary
> cpumask to ensure proper hierarchical semantics (maintaining consistency
> with the topology hierarchy). WDYT?

Would just using a pre-allocated cpumask to do pre-and on @cpus_allowed
work? This won't only be used for topology support (e.g. soft partitioning
in scx_layered and scx_mitosis may want to use multi-topology-unit spanning
subsets) and I'm not sure assuming and optimizing for that is a good idea
for generic API.

We can do something simple now. Note that if we want to optimize it, we can
introduce cpumask_any_and_and_distribute(). There already is
cpumask_first_and_and(), so the pattern isn't new and the only extra bitops
we need to add is find_next_and_and_bit_wrap(). There's already
find_first_and_and_bit(), so I don't think it will be all that difficult to
add.

Thanks.

-- 
tejun

