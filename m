Return-Path: <bpf+bounces-75698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6897C92011
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AE524E3CE9
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423FD32AABD;
	Fri, 28 Nov 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ9LaEnw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464132AAA5;
	Fri, 28 Nov 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764333558; cv=none; b=NqI/0Yq7NPYdvjb1MAq2Y7rP8qK8jS+MpWJexhHnLaRvs6yLhT+GKr4LY0jr2Px3pnjc6tIrLI9MbHfsZQpGdZasnoRZC5rTi6NLka7VC5O/UMOEdbP8RMPpJ76TVk04ut5E2WVlOOVjNUZXnwmHJt2AA9IdHd3Vlv8tsE3g0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764333558; c=relaxed/simple;
	bh=g+SkIfajbV0hqvLZ2wup7Z47s5dD85cBMdZ7+aTYs9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLrOmakd9PZCPAgWgy0h2dvlTXwx8ZWfomdITvypb7XpKBujXZKxf2X7VOH3Q9Yj+7RkXPgDidZqjp2lstId0X4NkB+ACaVK2/p7JESfJFDtP8MA6BxhszNHZA6R9/iQ1/DFUY6X7smOnj0A7iQVae/qp3dMDUQEX3mQrU4VPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZ9LaEnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E500C4CEF1;
	Fri, 28 Nov 2025 12:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764333556;
	bh=g+SkIfajbV0hqvLZ2wup7Z47s5dD85cBMdZ7+aTYs9E=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pZ9LaEnwtoMzE2wP2JePzB0UIbDFe/z9WwsqJMrJ6cu8/bpETlbYrY84oneD3Rkik
	 eQQX0YSVwarX9f71FzDcafq2O+YLCxYZB6Wo1LRQZ9kkbJx25PobIAKjp3XyCr+4EQ
	 uOyDZo9HbPpk8BUZm2PlqLrPbneIgJr0SFU4xMvNKThQDt9V9IsR2fLb9sqNFP4k8p
	 Oyxdf3sZUU9P5Hw4UT3x0zX7fvyobkyNDnN+e+tX1I/rTHSs4xaXXu/na9egoDsvhv
	 E2puVi41ZsqqSRvNPDLTV/OnRNmuoq1+j9Hfdr63UB+JEVNZDlCJU04xKKeF1UZj1O
	 KbWaa4cLAs83Q==
Message-ID: <1f19b775-d670-40ef-9147-2dcdce62b56e@kernel.org>
Date: Fri, 28 Nov 2025 13:38:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH V1] mm/slab: introduce kvfree_rcu_barrier_on_cache() for
 cache destruction
To: Harry Yoo <harry.yoo@oracle.com>, surenb@google.com
Cc: Liam.Howlett@oracle.com, atomlin@atomlin.com, bpf@vger.kernel.org,
 cl@gentwo.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, lucas.demarchi@intel.com,
 maple-tree@lists.infradead.org, mcgrof@kernel.org, petr.pavlu@suse.com,
 rcu@vger.kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
 samitolvanen@google.com, sidhartha.kumar@oracle.com, urezki@gmail.com,
 vbabka@suse.cz, jonathanh@nvidia.com
References: <CAJuCfpFTMQD6oyR_Q1ds7XL4Km7h2mmzSv4z7f5fFnQ14=+g_A@mail.gmail.com>
 <20251128113740.90129-1-harry.yoo@oracle.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20251128113740.90129-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/11/2025 12.37, Harry Yoo wrote:
> Currently, kvfree_rcu_barrier() flushes RCU sheaves across all slab
> caches when a cache is destroyed. This is unnecessary when destroying
> a slab cache; only the RCU sheaves belonging to the cache being destroyed
> need to be flushed.
> 
> As suggested by Vlastimil Babka, introduce a weaker form of
> kvfree_rcu_barrier() that operates on a specific slab cache and call it
> on cache destruction.
> 
> The performance benefit is evaluated on a 12 core 24 threads AMD Ryzen
> 5900X machine (1 socket), by loading slub_kunit module.
> 
> Before:
>   Total calls: 19
>   Average latency (us): 8529
>   Total time (us): 162069
> 
> After:
>   Total calls: 19
>   Average latency (us): 3804
>   Total time (us): 72287
> 
> Link: https://lore.kernel.org/linux-mm/0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org
> Link: https://lore.kernel.org/linux-mm/e988eff6-1287-425e-a06c-805af5bbf262@nvidia.com
> Link: https://lore.kernel.org/linux-mm/1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---

Thanks Harry for the patch,

A quick test on a different machine from the one I originally used to report
this shows a decrease from 214s to 100s.

LGTM,

Tested-by: Daniel Gomez <da.gomez@samsung.com>

> 
> Not sure if the regression is worse on the reporters' machines due to
> higher core count (or because some cores were busy doing other things,
> dunno).

FWIW, CI modules run on an 8 core VM. Depending on the host CPU, this made the
absolute number different but equivalent performance degradation.

> 
> Hopefully this will reduce the time to complete tests,
> and Suren could add his patch on top of this ;)
> 
>  include/linux/slab.h |  5 ++++
>  mm/slab.h            |  1 +
>  mm/slab_common.c     | 52 +++++++++++++++++++++++++++++------------
>  mm/slub.c            | 55 ++++++++++++++++++++++++--------------------
>  4 files changed, 73 insertions(+), 40 deletions(-)

