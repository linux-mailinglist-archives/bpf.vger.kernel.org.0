Return-Path: <bpf+bounces-77206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 775DDCD2159
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 23:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADF423066DB2
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 22:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35A52FF653;
	Fri, 19 Dec 2025 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w5bDiBdx"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B3E2F12DF
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766182247; cv=none; b=j4JVTwsLJnnpLvIPfYL7coD9Wy+GEq7GZfb/PmIzQ+f0Gy9OxQ/HJNnYpSIrXDwbMiDzhRKxXUEQYsj9nxI62iy3VGzOo2ojYODeUy+Kmkzkhh3mTNP/qrZn0cH+KwN7YYz7ZpB+OHPBVte/WpgDeRGsYK8Wyw8FoMCH+iis+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766182247; c=relaxed/simple;
	bh=S0PcphUGnt/UK2RCkW1JtleekIHVWy8xrboswjD1RNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTdypqbyk4gLcw4OWwVBV927flzXPLvV9a/tEIE8iKbyvXpnG5XV7Tc2iFHQWATnE/Iz4/+TiZhbG++u1N1VB92WcxGE4HzFceA0jH+zD+lwYWQPqJaGzdtWvMwfYbW3eregUSqsTTnEoja2Jnfe01Idzhm1HzuyWsPVbcAX+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w5bDiBdx; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 14:10:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766182229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPXk3IdBFVNPfpB6UaPYs8EHosCr3z2DGcPu5LvC9fg=;
	b=w5bDiBdxirzcEnWHI3HunN1oh7BCapjBBM4xyKP2eQ7Jfxgw7C/NX0k1fbsIRRTUJdzFzY
	gAPCW/S00jlOqZu5BdnBtyVRtPpJun/sh3fs+Tzz+bVe63DMnk0ZnNd6VLocgsCoETnIvB
	d50MFpz8buezG3+h11eRrY0a2ma3Nc8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v1 3/6] mm: introduce bpf_get_root_mem_cgroup()
 BPF kfunc
Message-ID: <vnlncxcamfe4z66bd6muhljsf7z6i6lizibo4wpaxfs5d45et5@f73plchvytgy>
References: <20251219015750.23732-1-roman.gushchin@linux.dev>
 <20251219015750.23732-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219015750.23732-4-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 18, 2025 at 05:57:47PM -0800, Roman Gushchin wrote:
> Introduce a BPF kfunc to get a trusted pointer to the root memory
> cgroup. It's very handy to traverse the full memcg tree, e.g.
> for handling a system-wide OOM.
> 
> It's possible to obtain this pointer by traversing the memcg tree
> up from any known memcg, but it's sub-optimal and makes BPF programs
> more complex and less efficient.
> 
> bpf_get_root_mem_cgroup() has a KF_ACQUIRE | KF_RET_NULL semantics,
> however in reality it's not necessarily

necessary*

> to bump the corresponding
> reference counter - root memory cgroup is immortal, reference counting
> is skipped, see css_get(). Once set, root_mem_cgroup is always a valid
> memcg pointer. It's safe to call bpf_put_mem_cgroup() for the pointer
> obtained with bpf_get_root_mem_cgroup(), it's effectively a no-op.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/bpf_memcontrol.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 8aa842b56817..6d0d73bf0dd1 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -10,6 +10,20 @@
>  
>  __bpf_kfunc_start_defs();
>  
> +/**
> + * bpf_get_root_mem_cgroup - Returns a pointer to the root memory cgroup
> + *
> + * The function has KF_ACQUIRE semantics, even though the root memory
> + * cgroup is never destroyed after being created and doesn't require
> + * reference counting. And it's perfectly safe to pass it to
> + * bpf_put_mem_cgroup()
> + */
> +__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
> +{
> +	/* css_get() is not needed */
> +	return root_mem_cgroup;

I think we need mem_cgroup_disabled() check here as well because I think
root_mem_cgroup can get allocated before memcg can be disabled due to
boot param.

> +}
> +
>  /**
>   * bpf_get_mem_cgroup - Get a reference to a memory cgroup
>   * @css: pointer to the css structure
> @@ -64,6 +78,7 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> +BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL | KF_RCU)
>  BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_TRUSTED_ARGS | KF_RELEASE)
>  
> -- 
> 2.52.0
> 

