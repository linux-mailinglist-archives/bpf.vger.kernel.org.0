Return-Path: <bpf+bounces-51460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEB7A34CF6
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 19:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1B8164BFB
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 18:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D15126988D;
	Thu, 13 Feb 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndoCCXvT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130AC269838;
	Thu, 13 Feb 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469806; cv=none; b=oYNZ0cbQPc2DKDZyS1ryLk+pgKx8wLOz92UKLHpKhwK8i5PJBQiY+8NSda/l7zwed9eNjXsQ5QABVavUGUk7GYiawn65bs5y4qZHFUHeSpgncvEpQoSHe/osmtNwa3Oc8aE+oH8bkRSgzL/htR7uhCaf1V0VAsosKwQVyO07P3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469806; c=relaxed/simple;
	bh=JiQiktAGGctXixmXWWF8xDkI8xwbN4TsNDFfzQN1Eeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAQwkjAp2a4PpOmY4ugphLYsxphWkfJ7F/zz8pt+dszaUxKuBqc3F7HqECTPTitsEa0Q9ThzgheAIDBNoTmYcMmbMbxQEtYkRFl3L6Q1Qmgwl6s0SpB0XLSvqsdPQ9ID/9mGg1IJ31k4U1PX7J5EFWgkuuUyr+rdfwsmypjwf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndoCCXvT; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f678a27787so10817177b3.1;
        Thu, 13 Feb 2025 10:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739469804; x=1740074604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oad7Z+1yhIYUiOCZTNX8qIwbCc6zoLXvE+xBf0mlsWA=;
        b=ndoCCXvTxfSHfahVKidgO9H7N5UeS4sKZECKz/8by+gkYcE51wNC+HRoD0m9bEUJMy
         n6mGLZWx12XsOpFm9utJ3muktqa6y7IZSHCjvwTktz0YeAfJCGH0NDi0pLxN2xdaOAmv
         fQX6V4foyatEzgJE3SVDTEknFBajVkQrE12FhV//AC49ubp9Xur2C2yqrlysSTnlxYed
         huN1jIgr1ojeeZqFfDhz/Y5ZeK1+R5B8+D5xRzTsgKVGQat3d1q4iblyY2FsZiqEAdlA
         owUlkX/sO3aiZS/LMyN5cagFoMYoppg13/NhRrrpoD+TzQjX0CjhYKXTRP/3ctwupFGf
         nYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469804; x=1740074604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oad7Z+1yhIYUiOCZTNX8qIwbCc6zoLXvE+xBf0mlsWA=;
        b=JB/bd/UMWKqmnA2O/i01mExtd1p0TV8ZtQYe75xhlL7ahwbn8cSIxktd6JF4CjTE0H
         zlEnevEctFA5pb4D0GNwXBrKo/B/In308EUDvgIS8EWJzEH/w23H5pn0OOja1Q0KPIgY
         T9zrVtuXOahxWdXzwFcH/813+I0j8RB1y+vCLng0hXqm8bCHY2oKS77VzgcswVC1zpGf
         0tGZRXm+vSJzSkOyQsN+Vhi5N5ktTCADkWXhZab8w+GmimQiLjPuvQeyykQ14TqpVcoK
         javtiZtj/pNOuqoqbEddRN7YvNJD76nBQBCQe11r6JTKwSWkv2wLIbSIc5SV/nBT2lbg
         +iWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZFw3ITxvx+XBgbOeGNqLM/w5mKnfpvp2vrSQohrIEFqaSYuY5ZGK/FRNWSMMmv3F0ugA=@vger.kernel.org, AJvYcCWM+c40WtdfRAUp7A0EiuIDNdcfVdnXpC+J3BUBvGvZ4/s6mLIAqSvqmnxlMzUQOVlQYZAZw2fLItiia6Gy@vger.kernel.org
X-Gm-Message-State: AOJu0YwDehHU4MNGPhVPGuClxI8aBsCWMP7YnOBPmIdc2FsdQz/uavHP
	akG3RCdRsa4wXdx0W/BWRUxG6f20aQ7O/yJghwzxK1x4n24dqs6t
X-Gm-Gg: ASbGnctXlqpvyrkPyk0s4eiBK35V3oo1kcHxZ2q07Ae2PQNJbI7LLnbhdOF3wbDXCpU
	KJAK3PMi/oSTwCozVcSoo3d86y38Vho5yrI65iXvW3UBXP7ABdJbC/r7MiA8NyYNTvmaY1u4oiL
	wvHnv5Mnn2XATV0xmWnE4xTgjHAIt10YBsspNJfFsN+5fcIFNM81+i1sUmNezXhb5LTdzndB20V
	AS0UNKwLWcjZjGzQgkAbLvA7XyGn/2+I0dCTfGPc3mgneaJfKYenRCm12xnD/AvJD6Po8MRJ6yg
	wKjK4TN90Et0+NLw4hWsz3bQSxMXBfuCOUFVpCv1GRMYXCkItRk=
X-Google-Smtp-Source: AGHT+IHhs2LWyFE4rnSavzbsLMkx6iS7v85uzRKQU3CGcpkMGtX6p8gC9wXEcmurUu72L9eXFNo+eg==
X-Received: by 2002:a05:690c:6a8a:b0:6f7:5049:7c1b with SMTP id 00721157ae682-6fb1f17e593mr69997977b3.4.1739469803976;
        Thu, 13 Feb 2025 10:03:23 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb361d6258sm3945847b3.114.2025.02.13.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:03:23 -0800 (PST)
Date: Thu, 13 Feb 2025 13:03:22 -0500
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
Subject: Re: [PATCH 6/7] sched_ext: idle: Per-node idle cpumasks
Message-ID: <Z64z6jIXz-MCSlv1@thinkpad>
References: <20250212165006.490130-1-arighi@nvidia.com>
 <20250212165006.490130-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212165006.490130-7-arighi@nvidia.com>

On Wed, Feb 12, 2025 at 05:48:13PM +0100, Andrea Righi wrote:
  
> @@ -90,6 +131,78 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
>  		goto retry;
>  }
>  
> +static s32 pick_idle_cpu_from_other_nodes(const struct cpumask *cpus_allowed, int node, u64 flags)

'From other node' sounds a bit vague

> +{
> +	static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
> +	nodemask_t *unvisited = this_cpu_ptr(&per_cpu_unvisited);
> +	s32 cpu = -EBUSY;
> +
> +	preempt_disable();
> +	unvisited = this_cpu_ptr(&per_cpu_unvisited);
> +
> +	/*
> +	 * Restrict the search to the online nodes, excluding the current
> +	 * one.
> +	 */
> +	nodes_clear(*unvisited);
> +	nodes_or(*unvisited, *unvisited, node_states[N_ONLINE]);

nodes_clear() + nodes_or() == nodes_copy()

Yeah, we miss it. The attached patch adds nodes_copy(). Can you
consider taking it for your series?

> +	node_clear(node, *unvisited);
> +
> +	/*
> +	 * Traverse all nodes in order of increasing distance, starting
> +	 * from @node.
> +	 *
> +	 * This loop is O(N^2), with N being the amount of NUMA nodes,
> +	 * which might be quite expensive in large NUMA systems. However,
> +	 * this complexity comes into play only when a scheduler enables
> +	 * SCX_OPS_BUILTIN_IDLE_PER_NODE and it's requesting an idle CPU
> +	 * without specifying a target NUMA node, so it shouldn't be a
> +	 * bottleneck is most cases.
> +	 *
> +	 * As a future optimization we may want to cache the list of nodes
> +	 * in a per-node array, instead of actually traversing them every
> +	 * time.
> +	 */
> +	for_each_node_numadist(node, *unvisited) {
> +		cpu = pick_idle_cpu_in_node(cpus_allowed, node, flags);
> +		if (cpu >= 0)
> +			break;
> +	}
> +	preempt_enable();
> +
> +	return cpu;
> +}
> +
> +/*
> + * Find an idle CPU in the system, starting from @node.
> + */
> +s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> +{
> +	s32 cpu;
> +
> +	/*
> +	 * Always search in the starting node first (this is an
> +	 * optimization that can save some cycles even when the search is
> +	 * not limited to a single node).
> +	 */
> +	cpu = pick_idle_cpu_in_node(cpus_allowed, node, flags);
> +	if (cpu >= 0)
> +		return cpu;
> +
> +	/*
> +	 * Stop the search if we are using only a single global cpumask
> +	 * (NUMA_NO_NODE) or if the search is restricted to the first node
> +	 * only.
> +	 */
> +	if (node == NUMA_NO_NODE || flags & SCX_PICK_IDLE_IN_NODE)
> +		return -EBUSY;
> +
> +	/*
> +	 * Extend the search to the other nodes.
> +	 */
> +	return pick_idle_cpu_from_other_nodes(cpus_allowed, node, flags);
> +}

From d69294cba9bffc05924dc3351a88601937c24213 Mon Sep 17 00:00:00 2001
From: Yury Norov <yury.norov@gmail.com>
Date: Thu, 13 Feb 2025 11:21:08 -0500
Subject: [PATCH] nodemask: add nodes_copy()

Nodemasks API misses the plain nodes_copy() which is required in this series.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 include/linux/nodemask.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 9fd7a0ce9c1a..41cf43c4e70f 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -191,6 +191,13 @@ static __always_inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *s
 	bitmap_andnot(dstp->bits, src1p->bits, src2p->bits, nbits);
 }
 
+#define nodes_copy(dst, src) __nodes_copy(&(dst), &(src), MAX_NUMNODES)
+static __always_inline void __nodes_copy(nodemask_t *dstp,
+					const nodemask_t *srcp, unsigned int nbits)
+{
+	bitmap_copy(dstp->bits, srcp->bits, nbits);
+}
+
 #define nodes_complement(dst, src) \
 			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
 static __always_inline void __nodes_complement(nodemask_t *dstp,
-- 
2.43.0


