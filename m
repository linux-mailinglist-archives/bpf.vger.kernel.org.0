Return-Path: <bpf+bounces-50903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859CCA2DF7B
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 18:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AAF164C8C
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB471E0080;
	Sun,  9 Feb 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDSe9kyi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348D1119A;
	Sun,  9 Feb 2025 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739122821; cv=none; b=glmy4VfsdAIXfJ6rOOBJrt5osbaCV+mLjTXishA1XQ9fqedt6serkTm+4UptUy/WetBI7G0TuwXfTsYKlX9xdxYF+nmfV4/76ShKyReW/AAJ3fgxcwr6fUyfBR6INLhwB73hnDBzLL+XZyzJSZVdyrya4pUt3lUSEe2O8kTiwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739122821; c=relaxed/simple;
	bh=hvB7B1qMj2qMUiArzNvjE1o89SrgcMdd3T6esy4XvAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsYLfOzl0WOy12xTrLEbjUTi60uAEqG47aq8lIoz7d2Zku+Z5cMuji6MvzLiov/s6b6FIZFzS0ADoCn0SPoi+pCbxuRqVIVU0Q3RCMxJVLVItpfvG5uJNFU35uQohh0MK3tdyFZLdJAJofdslOc73WMoZBrUC+L8pVp//AKaXDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDSe9kyi; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so2506336276.3;
        Sun, 09 Feb 2025 09:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739122818; x=1739727618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHhjcKTe2BCKEZBZLZukeAJ0EgnYqJNr/A2buIFd+Fk=;
        b=FDSe9kyii2quZaozKLo6b2Lv+LeFo6/620t9Idp6IkaJAHXhB7+OYfG3jdPr/msOr0
         2UjsbEkVJKoOtqZcjt5s9JFlIJh0SJrGGbyJYqNFqB0q8visyvCsFuQVWHYfwljbP7+h
         SM2Ana09dQg4qTkj3gRlZH693BT75s9UMJh5csaTQudhmhxbby5f5MTh5noWtOOJ2ocf
         nOeib42BtNx+rdozqdSPb+0IEkMfJPdWUuPEUYvYL8SUZksZsm31ffnf7tVRWzBZfYq0
         alaG04M/7gQowaJoPYw47E41uK1+hHcNL2sBaGBELW0ydv9h+ep+z5WEiSlM/JhAOm7f
         0YaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739122818; x=1739727618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHhjcKTe2BCKEZBZLZukeAJ0EgnYqJNr/A2buIFd+Fk=;
        b=AJBXjiM3nZKmz804LM+uNFTA04MuWasC9A7fMx7UebJNyYgor3CyiaLUOHIDU3UnHY
         gV1jCwq3LkqtSnJayQtCEBMl/Hb2srlZLIyfKMq+8r4Pje/hxSpRej98qYRs+uK/13oU
         JbvhH3NY3a8XUvrc1aBJMBvBDnQ+rj743iHOKwj9FB0jM6z8AisE1I/OUEBOIRaaS9TR
         crvoLKUh8w3F7lL7QOvK+3M5ZGtBr4BA5LTmSqcYOSgMfqazJ25VdIgQHv4cX92WPYXC
         DN2qrVo/f5Ub2dva/iprXws+3fSmElEybut/4uJQ7QpoIv0XvtASq9nKyBxuWtR1A9ma
         4F1A==
X-Forwarded-Encrypted: i=1; AJvYcCWaj9XkQf7nkD7kvd5FNcyP35mjpoERZ9BNsspyqTJKM1XcFva7W0YKu1vBwhWXd6k77UQ=@vger.kernel.org, AJvYcCXFHTG/lGhKP1EL2N81nXMUPuFZAIS899D3glpyy4yMuBMGfULB00UbS34g3zBtAABb5fad2Ne/4FWwbRcR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4uAGjVxmOAV+SpIWsp8/NjA/98ZaIq28bqCV5dXNAu4e+8//v
	3r0WznBXCW9hMmX8R3JSIZtXHPD7TD+F3uy3Z2HgplIwGTinbjqP
X-Gm-Gg: ASbGnctTzISOdubkiLPi/AyWrNsHVBMV7EqbRJc2ASRh2WEPyOeon1heMu7W5m85OF0
	wZOUzRJMWT8evEcNG9/3WYW627qzSfq24V/DSqe9bHIZ7iI8PFk3e38jW11z5Fia0dN/LPyqAvh
	ryD3cpO63pcJ8TwXqY25eNV5+ZD7BvMysu7XiDuH/nQ2x0xRTzQjR/olCgGRqjbXqrBoKObYj6w
	0cbytMR2SQQnqLZEpgIJNy1wbXiWQ3EreyZPF3c3pQSgLxvYcwZLkaaRBAni956rX7UhS9jmiSB
	U/0VaAZbdXdTzCOWwg7G5LGWb/cAIPnMOB2+jAZV9WctH4KWVWE=
X-Google-Smtp-Source: AGHT+IGHUEpHAWKbx9hs6majl9Wze52NnwmJsz3HoQFx6o58E7mYKSAmWhXHluoW4H8hAzJPDwIpcg==
X-Received: by 2002:a05:690c:6112:b0:6ef:8122:282f with SMTP id 00721157ae682-6f9b29d8b50mr88060807b3.24.1739122818266;
        Sun, 09 Feb 2025 09:40:18 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99fd3c323sm12810307b3.49.2025.02.09.09.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 09:40:16 -0800 (PST)
Date: Sun, 9 Feb 2025 12:40:15 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm/numa: Introduce numa_nearest_nodemask()
Message-ID: <Z6joYmcjyT8eY32H@thinkpad>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207211104.30009-2-arighi@nvidia.com>

On Fri, Feb 07, 2025 at 09:40:48PM +0100, Andrea Righi wrote:
> Introduce the new helper numa_nearest_nodemask() to find the closest
> node, in a specified nodemask and state, from a given starting node.
> 
> Returns MAX_NUMNODES if no node is found.
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  include/linux/nodemask_types.h |  6 +++++-
>  include/linux/numa.h           |  8 +++++++
>  mm/mempolicy.c                 | 38 ++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/nodemask_types.h b/include/linux/nodemask_types.h
> index 6b28d97ea6ed0..8d0b7a66c3a49 100644
> --- a/include/linux/nodemask_types.h
> +++ b/include/linux/nodemask_types.h
> @@ -5,6 +5,10 @@
>  #include <linux/bitops.h>
>  #include <linux/numa.h>
>  
> -typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
> +struct nodemask {
> +	DECLARE_BITMAP(bits, MAX_NUMNODES);
> +};
> +
> +typedef struct nodemask nodemask_t;
>  
>  #endif /* __LINUX_NODEMASK_TYPES_H */
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 3567e40329ebc..a549b87d1fca5 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -27,6 +27,8 @@ static inline bool numa_valid_node(int nid)
>  #define __initdata_or_meminfo __initdata
>  #endif
>  
> +struct nodemask;

Numa should include this via linux/nodemask_types.h, or maybe
nodemask.h.

> +
>  #ifdef CONFIG_NUMA
>  #include <asm/sparsemem.h>
>  
> @@ -38,6 +40,7 @@ void __init alloc_offline_node_data(int nid);
>  
>  /* Generic implementation available */
>  int numa_nearest_node(int node, unsigned int state);
> +int numa_nearest_nodemask(int node, unsigned int state, struct nodemask *mask);
>  
>  #ifndef memory_add_physaddr_to_nid
>  int memory_add_physaddr_to_nid(u64 start);
> @@ -55,6 +58,11 @@ static inline int numa_nearest_node(int node, unsigned int state)
>  	return NUMA_NO_NODE;
>  }
>  
> +static inline int numa_nearest_nodemask(int node, unsigned int state, struct nodemask *mask)
> +{
> +	return NUMA_NO_NODE;
> +}
> +
>  static inline int memory_add_physaddr_to_nid(u64 start)
>  {
>  	return 0;
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 162407fbf2bc7..1cfee509c7229 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -196,6 +196,44 @@ int numa_nearest_node(int node, unsigned int state)
>  }
>  EXPORT_SYMBOL_GPL(numa_nearest_node);
>  
> +/**
> + * numa_nearest_nodemask - Find the node in @mask at the nearest distance
> + *			   from @node.
> + *

So, I have a feeling about this whole naming scheme. At first, this
function (and the existing numa_nearest_node()) searches for something,
but doesn't begin with find_, search_ or similar. Second, the naming
of existing numa_nearest_node() doesn't reflect that it searches
against the state. Should we always include some state for search? If
so, we can skip mentioning the state, otherwise it should be in the
name, I guess...

The problem is that I have no idea for better naming, and I have no
understanding about the future of this functions family. If it's just
numa_nearest_node() and numa_nearest_nodemask(), I'm OK to go this
way. If we'll add more flavors similarly to find_bit() family, we
could probably discuss a naming scheme.

Also, mm/mempolicy.c is a historical place for them, but maybe we need
to move it somewhere else?

Any thoughts appreciated.

> + * @node: the node to start the search from.
> + * @state: the node state to filter nodes by.
> + * @mask: a pointer to a nodemask representing the allowed nodes.
> + *
> + * This function iterates over all nodes in the given state and calculates
> + * the distance to the starting node.
> + *
> + * Returns the node ID in @mask that is the closest in terms of distance
> + * from @node, or MAX_NUMNODES if no node is found.
> + */
> +int numa_nearest_nodemask(int node, unsigned int state, nodemask_t *mask)

Your only user calls the function with N_POSSIBLE:

  s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
  {
        nodemask_t unvisited = NODE_MASK_ALL;

        if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
               return pick_idle_cpu_from_node(cpus_allowed, NUMA_NO_NODE, flags);


        for_each_numa_node(node, unvisited, N_POSSIBLE)
                do_something();
  }

Which means you don't need the state at all. Even more, you don't
need to initialize the unvisited mask before checking the static
branch:

  s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
  {
        nodemask_t unvisited;

        if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
               return pick_idle_cpu_from_node(cpus_allowed, NUMA_NO_NODE, flags);

        nodes_clear(unvisited);

        for_each_numa_node(node, unvisited)
                do_something();
  }


If you need some state other than N_POSSIBLE, you can do it similarly:
        
        nodemask_complement(unvisited, N_CPU);

        /* Only N_CPU nodes iterated */
        for_each_numa_node(node, unvisited)
                do_something();


> +{
> +	int dist, n, min_dist = INT_MAX, min_node = MAX_NUMNODES;
> +
> +	if (node == NUMA_NO_NODE)
> +		return MAX_NUMNODES;
> +
> +	if (node_state(node, state) && node_isset(node, *mask))
> +		return node;

This is correct, but why do we need this special case? If distance to
local node is always 0, and distance to remote node is always greater
than 0, the normal search will return local node, right? Is that a
performance trick? If so, can you put a comment please? Otherwise,
maybe just drop it? 

> +
> +	for_each_node_state(n, state) {
> +		if (!node_isset(n, *mask))
> +			continue;

for_each_node_state_and_mask(n, state, mask)

Or if you take the above consideration, just
        for_each_node_mask(n, mask)       

> +		dist = node_distance(node, n);
> +		if (dist < min_dist) {
> +			min_dist = dist;
> +			min_node = n;
> +		}
> +	}
> +
> +	return min_node;
> +}
> +EXPORT_SYMBOL_GPL(numa_nearest_nodemask);
> +
>  struct mempolicy *get_task_policy(struct task_struct *p)
>  {
>  	struct mempolicy *pol = p->mempolicy;
> -- 
> 2.48.1

