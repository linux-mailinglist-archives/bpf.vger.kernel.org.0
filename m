Return-Path: <bpf+bounces-51610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E91A36764
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 22:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77CF188F5A5
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D901DB92A;
	Fri, 14 Feb 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjX//zhP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594D1DC998;
	Fri, 14 Feb 2025 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567817; cv=none; b=OWJHc61whV6NNf2i7dOui2micwSyqn1DTbK1abi4t0IuumavFiFFyFQiK1FsNmmXfyOYGIL3NFQxy5HFf/GaUUBFJ9c6LnxAFxtj0RdgJBn7rS8BCWgNG1JnSCv4b/HtxtjvXscDyGS+VhlTITskqXFDYQoelhMF3jyqvYSlZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567817; c=relaxed/simple;
	bh=kdoCDF691npnxcfSrhhThsuQwDgHrSls1RuILSNL19M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcseGCyWcSNCVs1lGp+K9YiocXGYsDbMk/PbBqsmb7nEyPBWDvmrYTNP3XSzIfAyK2WUIN3X0epUncfxMe8EN3v6antn9X7svzBXUjA7hxE3OgMKFBmLsxKVInRBrIpjY1BGKF65rmGEe8E2Dhw1MOH3iwC3pKGD+0hYhiD+nxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjX//zhP; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f6715734d9so23082527b3.3;
        Fri, 14 Feb 2025 13:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739567814; x=1740172614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/s0mb5QBHXHZM7mJa9A8yyHBmYLb1JiJn/TLFs2Hoc=;
        b=PjX//zhPL8QgfOoTqflxo0ZJOR7k1re3UpZ71mEl9uRd2J1RwkrthaZQkcTkBrJP3I
         LY0rhBU2nw5894G01NRRDzVmQN/wGjoor4Ksk43pmrzcsGgbkDUevzEpZSpozmfkTho+
         t3xX6U1CIFjv8+QSkBfz2j7jhs9A99DcR977+x4Su/PrcYacVSM9FaRqlLsA/JcXeGXm
         fVlNMqFwoy3J5UrMLlqzjJg1bfyG5KUNwemXv1mvqEf/wYmAAghPG6lXxSm4KiokN7Mk
         TPR31MiD5KSTwoRvBXmmpQGQudKmHRGSfLf6xUwMnAvCK1K+iNcgDg4nl93u6Y3Tqbye
         0eBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567814; x=1740172614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/s0mb5QBHXHZM7mJa9A8yyHBmYLb1JiJn/TLFs2Hoc=;
        b=UD1U/eKZvZn4zVtaAsdF387oikTq/AJmkbpZG3N6mUq0GzruAQRRGzlOYY2NiO6VoD
         sq9XQbRQ63h3HY9LCJJfkwoCulVUlwaNHoOzeoJa3T2G+XPEy00D2nECNtjysAqFPJEm
         o7ao4QIAW/MNy+lnyjZk4iJilAjgfIGd5ChNhj7eQreJoUsy73uJs++grv89SjQTEzOX
         VUD0uA+84dpnYPVBHSNSr8RBf9IGi4CgVEeca9aQu8Od5U6Eu7iErzOOeL3OuHd+0Qlw
         2PEvQ8jL/Q1CZQ9tBt5nrGaL8+pFyhC83DwOtQG/lp1so9ciDjpHrqAoyKqhZOuE2Kwq
         kqjg==
X-Forwarded-Encrypted: i=1; AJvYcCUBNhsy8FbXPdIRgQa+Nv1B3oeBaLnn8TEJyuxWgFYfNBaNSwE7YIDOid0sPGMVRNG93JeFRZs9oIo9HTaU@vger.kernel.org, AJvYcCVgGDMPHzymE0YYHkX6bTvfzGp17/KbjvEziWcCrI+jH+V3dLAvky2hnmwbY1U+fnOmOek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFWTeHHxbpVqZy1OGdOKVzc2oCnQMpkgpahQjTKFcllQOv7kmY
	Znnv/T/CuBg/T0zRKobnyyCgBDsMjclNNpLwLlpBh81LCY8uNpcD
X-Gm-Gg: ASbGncssjWiMAYyOnE23HBwTO9ioE4Il/qZwSPmZ39DPmkDIQBCTO4iAY5WXhFUkTZy
	cbOrTxA316BFTwS5cJfrAqPpuemjEPYT4wSaj/NMRgTYXSk6FStj+eQ/TIPNaVnhaZmTa/VgLVk
	NyfcSK8GvGOtfbhvFTkEmKPq4KS+Y2WTcDP8Bd1ix1MWuuzzCRBakdnl/fFa/sr/t/Eel1ezvJK
	QVz2EyyC/2mIBskHXNsEhZLZgTy51iedrT5IrBBupav5sbmKv8h54AjuitZE16FzxuboEe8LuVg
	VbVDiAeqXxOwSVvfROcUhEeRWDOL6HvxB+z2mOKdqWkHqJ87cSk=
X-Google-Smtp-Source: AGHT+IE8JEh8yAC1sU5hyVy0GTo1jz5BgWgWrsAu0Oixm7DD493VWokT9ITeLCSp69fWpGtA5GqTAA==
X-Received: by 2002:a05:690c:7204:b0:6f9:a6bd:2053 with SMTP id 00721157ae682-6fb5837acdamr10160287b3.34.1739567814283;
        Fri, 14 Feb 2025 13:16:54 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb360922f6sm9308177b3.48.2025.02.14.13.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:16:53 -0800 (PST)
Date: Fri, 14 Feb 2025 16:16:53 -0500
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
Subject: Re: [PATCH 4/8] sched/topology: Introduce for_each_node_numadist()
 iterator
Message-ID: <Z6-yxTEbuJZUZW8f@thinkpad>
References: <20250214194134.658939-1-arighi@nvidia.com>
 <20250214194134.658939-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214194134.658939-5-arighi@nvidia.com>

On Fri, Feb 14, 2025 at 08:40:03PM +0100, Andrea Righi wrote:
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
> Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

> ---
>  include/linux/topology.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 52f5850730b3e..a1815f4395ab6 100644
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
> +	for (int __start = (node),						\
> +	     (node) = nearest_node_nodemask((__start), &(unvisited));		\
> +	     (node) < MAX_NUMNODES;						\
> +	     node_clear((node), (unvisited)),					\
> +	     (node) = nearest_node_nodemask((__start), &(unvisited)))
> +
>  /**
>   * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
>   *                          from a given node.
> -- 
> 2.48.1

