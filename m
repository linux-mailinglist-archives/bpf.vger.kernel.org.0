Return-Path: <bpf+bounces-50811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D956A2D001
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E1A188AE39
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7511C6FED;
	Fri,  7 Feb 2025 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l15+uRB9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7F9198E81;
	Fri,  7 Feb 2025 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964812; cv=none; b=AnFjNnWTQP8svWcLSn5tvM9LnbS0rP2hJYJaWciAlKjPtindIrdf1I2jMl1wIfviNrHTz59EEmzuHgxS7vNiMzmqxKgtSz+CXLO2O7s+m195084VDhszxeHyr1zl27HbYeU8hGcryNOk7xWwjCOv08U+UutYwAGiqGAdEDl7hy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964812; c=relaxed/simple;
	bh=sh0jb9q4/6T+eDE1u5S5ae7y+Qln5pSTAWqkqfl/TSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm0fndCbXGqL7+kdxggbEyOjzLZ5z8lA+zZ9gFrhbgLZwakXfX9MzgSkvDCAIwWmTUxky4klm9vIsBuQTxNZtYq4xMTPuLwx2bp4nzMa/yEbLLVk2ZtTI30i8O2LLplMZ7GzqW7URuBVOzsbcjyhuXYlWIuPJmyKx5NikBGJb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l15+uRB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EB1C4CED1;
	Fri,  7 Feb 2025 21:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738964812;
	bh=sh0jb9q4/6T+eDE1u5S5ae7y+Qln5pSTAWqkqfl/TSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l15+uRB9tFLknej18SsmCYMZKvEuulyAWG7tnDRwGrFpJlylGYvawgFxkb+BaH/dQ
	 OpkdoueDyQUeir5OePLqLXo4qccUW/vxqRBjGKw3nsLAcFPqoMhdQ3qn7JUwiy3tlt
	 dAdqjj1ffXUiRj3bWOygzk/Q0GdLAiZPMPmGLG6VqyPi2+bC4NjWNgVXhq8kdaXg/o
	 ZjXvRD013Y+Ghlo2GtoMD/7WJiinXv4ma0y9/Toe9mJLZLl25tyQV6W9Omj/+QndQ8
	 M0sHLjATaPDX2qwj8BoO36A+MRNjfJ/GFnVIgiPdqf2hN2KQERjq+RrmG0gXpH20gY
	 UnQcVLefp2wrQ==
Date: Fri, 7 Feb 2025 11:46:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 2/6] sched/topology: Introduce for_each_numa_node()
 iterator
Message-ID: <Z6Z_S6UDg80LUQEi@slm.duckdns.org>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207211104.30009-3-arighi@nvidia.com>

On Fri, Feb 07, 2025 at 09:40:49PM +0100, Andrea Righi wrote:
> +/**
> + * for_each_numa_node - iterate over nodes at increasing distances from a
> + *			given starting node.
> + * @node: the iteration variable and the starting node.
> + * @unvisited: a nodemask to keep track of the unvisited nodes.
> + * @state: state of NUMA nodes to iterate.
> + *
> + * This macro iterates over NUMA node IDs in increasing distance from the
> + * starting @node and yields MAX_NUMNODES when all the nodes have been
> + * visited.
> + *
> + * The difference between for_each_node() and for_each_numa_node() is that
> + * the former allows to iterate over nodes in numerical order, whereas the
> + * latter iterates over nodes in increasing order of distance.
> + *
> + * This complexity of this iterator is O(N^2), where N represents the
> + * number of nodes, as each iteration involves scanning all nodes to
> + * find the one with the shortest distance.
> + *
> + * Requires rcu_lock to be held.
> + */
> +#define for_each_numa_node(node, unvisited, state)				\
> +	for (int start = (node),						\
> +	     node = numa_nearest_nodemask((start), (state), &(unvisited));	\
> +	     node < MAX_NUMNODES;						\
> +	     node_clear(node, (unvisited)),					\
> +	     node = numa_nearest_nodemask((start), (state), &(unvisited)))
> +
>  /**
>   * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
>   *                          from a given node.

Bikeshedding: Maybe this has already been argued back and forth but I find
the distinction between for_each_node() and for_each_numa_node() way too
subtle. I wouldn't suspect that they are doing different things when
glancing through their usages in isolation. Can we add *something* to the
name that indicates that this is iteration by distance? The next one uses
"hop" which is fine, "_by_dist" can be fine too, or even "_from_nearest". I
don't really care which but let's make the name clearly signal what it's
doing.

Thanks.

-- 
tejun

