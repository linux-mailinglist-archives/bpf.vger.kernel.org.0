Return-Path: <bpf+bounces-51426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CE7A348DB
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9CE188F02F
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E388E1CBEAA;
	Thu, 13 Feb 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqlUhrX0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854626B0B3;
	Thu, 13 Feb 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462568; cv=none; b=as+mBUZWSElyurG7OfWhq9dCr7yEDjesS7ti4n11tlQClK7Kn4qhmnUPmUwTBTijEBskHk5HD5dibKu6cpaC4CaK9tHGDr7P/WA5CBmVixBJV7y4T8NWSeARG5n6RBOyDRtJwFQi3fUEUojW798yHQIzty6udK3aQut4lXX+oao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462568; c=relaxed/simple;
	bh=X0B6ed16ijIJFUU4WUxV6i1f5Y/4rtIpdR1w18X3APE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miqoUO3+VX4BnOT8nyXOPbXieynjF2yYm8q9iHx1im4zb1Ksz+D9jvYWicdadAcGjYF4HYWnYd6oS0j/vuSPQc4tUgT0ioW7qBpJHICtnCgYT9oFqafbiP0nqsT4eHQ6mJzkzltZsU3xghyb/HtiJSQznr62c0129aXBUtiwUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqlUhrX0; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6fb2a0e4125so8190837b3.1;
        Thu, 13 Feb 2025 08:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739462566; x=1740067366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nGbLetjXq7UD88DiOxAl4OByYLP4SoORsLA5fTjaPrc=;
        b=FqlUhrX0hIkTEYr9uzyOalt+uWB2temXRoR0CahsWnOA+Y9Gmu/b6tGyxHtIeMO3Kk
         ARrSCKF7O9EQr52nQh9xG6RbgQczVrxaxofU5muEKoYGUcZHbP4zlPrvb/xoDmI+vdWz
         aZDhAwTNE6LZ4XWPC3VF8Wx+rbks8AboBMfkPdcpVNsJwWkhKpFIA8mP4rMjZyfsz8Wj
         MogVA3KKSXwzrsYHoQi4WH5cYa78J0U85ujicHExQB0aDtgSlTMr+SS4AKU8zxFPb6h7
         1MM3ONXY42E9pGGPW05UcnQ2oWRNR5ZFFI2+l/08AUoHkiF7UqzUZ/RTVa0qrkpTtwML
         ANRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462566; x=1740067366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGbLetjXq7UD88DiOxAl4OByYLP4SoORsLA5fTjaPrc=;
        b=c5nKd2lMlIwDBgfwB864CoesB+1OBQnbGj4qrwY/HYCBjx7KMKDwH94C7izPhB1MS4
         tnTV/uMcpRgKAWB9UWyHPLfUl1pTMdvGXZaORdxzkweHqtB6LP3zLLDjM2ib7jT7UDGp
         kxbXH5f/m31L1+j4ootxW8PJ2r66tHDSb9GwQOl1y5M8iG/nZYbsDfp2iqZYiK27StCE
         /gsD5GKL1y0hX0jQcM9dcx9jgkfJUcQmtZkoHjAaQm843Ug8yTmbnRzrFRbToX2KTf9B
         xDRV6lyhzOyLw8kWmGYot7hWrtFNkW5EH2Fq2xtASXDrHhJiGPDe8O/FhvF89xpq6CD/
         WRwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiRDvvyiRNdhV2+iF1LJW+YUcXCCp3lt0yUggYSxp8GCloradFrO5CmYJTC56GZDA2+ZA=@vger.kernel.org, AJvYcCXT68KVjSlCSlSfAsgz5aFsidxw7Vn0ygSWmZQ8sksf1z6+BWj6792CiJplDDzisHOVxW+5LZm4I9c9x2Aj@vger.kernel.org
X-Gm-Message-State: AOJu0YwOITxbGUlc5ywC5fBFEhBU8PhulaXqMKi0JR+JExr+1IsYw6Jz
	RzNLv8XbPGL4qZmqP0e1JPO/0T1xMWaeK9g/GHSgxaAhpIkutE4N
X-Gm-Gg: ASbGnctmSmQ1POzNzkoAMGHNbz8WUZzbimgPUtwcG5Kf0aIaxyimGZkNPPjRWmSufTW
	MvZCqAg2Uc47bSZDK2ac60JK093plSMjpVPpu5XjNq/e6+b2DmJSEJo53BxvEbv7uZ8kLkdqpql
	4RS6eDMMrlncoGwIqhNQDhH++hrr//ddg/hW9sjTOhmjXhS7oQcgo6tXTxXAGMleNyPXFx+Rxh9
	ZFk7HqUl4QkcKo2Wn28IUB36FsGBbvxBt3UO5FfU43GBhtZZzHcLGd7nf6rVqIJqVg4eVesuVaX
	aq/7Fz990UVlqiHN+m4uGM5OyJ7tcwjUcEztj70eb6IGtB5EdZk=
X-Google-Smtp-Source: AGHT+IFcqSJ/N0y/o12d4DD5FvSnC0adZf7Kli5M8pGjTKz5KXXyjHwUTzdzHKlUi0tDxBuN0scOGQ==
X-Received: by 2002:a05:690c:620e:b0:6ef:7036:3b57 with SMTP id 00721157ae682-6fb32d871b6mr36940027b3.28.1739462565590;
        Thu, 13 Feb 2025 08:02:45 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb3619ec66sm3489177b3.79.2025.02.13.08.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:02:45 -0800 (PST)
Date: Thu, 13 Feb 2025 11:02:44 -0500
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
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] sched/topology: Introduce for_each_node_numadist()
 iterator
Message-ID: <Z64XpKDZ0GQ673Eq@thinkpad>
References: <20250212165006.490130-1-arighi@nvidia.com>
 <20250212165006.490130-4-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212165006.490130-4-arighi@nvidia.com>

On Wed, Feb 12, 2025 at 05:48:10PM +0100, Andrea Righi wrote:
> Introduce the new helper for_each_node_numadist() to iterate over node
> IDs in order of increasing NUMA distance from a given starting node.
> 
> This iterator is somehow similar to for_each_numa_hop_mask(), but
> instead of providing a cpumask at each iteration, it provides a node ID.
> 
> Example usage:
> 
>   nodemask_t unvisited = NODE_MASK_ALL;
>   int node, start = cpu_to_node(smp_processor_id());
> 
>   node = start;
>   for_each_node_numadist(node, unvisited)
>   	pr_info("node (%d, %d) -> %d\n",
>   		 start, node, node_distance(start, node));
> 
> On a system with equidistant nodes:
> 
>  $ numactl -H
>  ...
>  node distances:
>  node     0    1    2    3
>     0:   10   20   20   20
>     1:   20   10   20   20
>     2:   20   20   10   20
>     3:   20   20   20   10
> 
> Output of the example above (on node 0):
> 
> [    7.367022] node (0, 0) -> 10
> [    7.367151] node (0, 1) -> 20
> [    7.367186] node (0, 2) -> 20
> [    7.367247] node (0, 3) -> 20
> 
> On a system with non-equidistant nodes (simulated using virtme-ng):
> 
>  $ numactl -H
>  ...
>  node distances:
>  node     0    1    2    3
>     0:   10   51   31   41
>     1:   51   10   21   61
>     2:   31   21   10   11
>     3:   41   61   11   10
> 
> Output of the example above (on node 0):
> 
>  [    8.953644] node (0, 0) -> 10
>  [    8.953712] node (0, 2) -> 31
>  [    8.953764] node (0, 3) -> 41
>  [    8.953817] node (0, 1) -> 51
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

> ---
>  include/linux/topology.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 52f5850730b3e..932d8b819c1b7 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -261,6 +261,36 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
>  }
>  #endif	/* CONFIG_NUMA */
>  
> +/**
> + * for_each_node_numadist() - iterate over nodes in increasing distance
> + *			      order, starting from a given node
> + * @node: the iteration variable and the starting node.
> + * @unvisited: a nodemask to keep track of the unvisited nodes.
> + *
> + * This macro iterates over NUMA node IDs in increasing distance from the
> + * starting @node and yields MAX_NUMNODES when all the nodes have been
> + * visited.
> + *
> + * Note that by the time the loop completes, the @unvisited nodemask will
> + * be fully cleared, unless the loop exits early.
> + *
> + * The difference between for_each_node() and for_each_node_numadist() is
> + * that the former allows to iterate over nodes in numerical order, whereas
> + * the latter iterates over nodes in increasing order of distance.
> + *
> + * This complexity of this iterator is O(N^2), where N represents the
> + * number of nodes, as each iteration involves scanning all nodes to
> + * find the one with the shortest distance.
> + *
> + * Requires rcu_lock to be held.
> + */
> +#define for_each_node_numadist(node, unvisited)					\
> +	for (int start = (node),						\
> +	     node = nearest_node_nodemask((start), &(unvisited));		\
> +	     node < MAX_NUMNODES;						\
> +	     node_clear(node, (unvisited)),					\
> +	     node = nearest_node_nodemask((start), &(unvisited)))

the 'node' should be protected with braces inside the macro, the start should
not because you declare it just inside. Also, the 'start' is a common word,
so there's a chance that you'll mask out already existing 'start' in the scope.
Maybe __start, or simply __s?

>  /**
>   * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
>   *                          from a given node.
> -- 
> 2.48.1

