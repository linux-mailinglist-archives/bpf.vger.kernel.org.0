Return-Path: <bpf+bounces-50904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCD9A2DF99
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 18:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8FC3A56A2
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0391DFE00;
	Sun,  9 Feb 2025 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkEW0mDS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6EC2F22;
	Sun,  9 Feb 2025 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739123429; cv=none; b=WYLijPYVCrX6/qfycOqLpmbNmTWda/1X3oCYf8ie29L/CiYIjfjXx3ZNNeHk6gsY9+T4XD2Ng+81l0WbaP6IAv77JufEwHS8c0d0lh4hpJGuUETFQNCBgOodW37dxtJmZ6nvLDz6MP8rTiQptIi3X1eMpG95QEWY1muHODlyqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739123429; c=relaxed/simple;
	bh=Cz++CWnMw5CI/SNuKx7rQu2pEJh3WRGr2rYqI/LMQDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSaJUoUP9kp5Qf/UfmtQMmN6+WiNtRc1RH5Dil1MhK6lbMHtAVqQ6JHwmGCCOyFz6R2oflKmGfkDwMkNgOF+JmNHqRBnhqvEcrJckVAouuiIlmbBqojUU4FdV5BxP/8ANvIuTzX1A7BI1IMxkSa0AuSHWE/Y0o57PCQkswtkA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkEW0mDS; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ef9b8b4f13so31668317b3.2;
        Sun, 09 Feb 2025 09:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739123427; x=1739728227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/0omVsmN3zO6xDrd4HBglrhIiHiSgl3Gp/JjxQkVS8Q=;
        b=OkEW0mDSB8fG3lYDPkI5vQv6K0rnQD5p7ZYlxaFVB/354z+yNwxMWP12nIlaviKopU
         9r5pbjIXSnWsVF+ugrvyWbrFZ27Y4cvNuAHXTuJ/gpUfAmUcgHUaxmX877kmDh/JH04+
         xy6Hpr3PrKE6FARTIfX5kg4b9qP/0CtIapL8GXMHBaFF/81bJge+UGbj4JiBI/DewLs2
         Iuh8l8prlh5bTRQIOpn+n23tXZ6+7eOFiho6m+udyvk0gKLojKXYFekDHbE9xVIqkhTa
         viKYVVFmoln6DLrew78qR4LlPz0qLUVll1UviGkXvVOitDcV0chBtupL6NKKMSqGRcdf
         KodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739123427; x=1739728227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0omVsmN3zO6xDrd4HBglrhIiHiSgl3Gp/JjxQkVS8Q=;
        b=qeBiyDB0FZVRFUbastwtW220kl2mhE0oylHPWOSmIkzxJz9JBsgzp80QXdA7/yixtf
         TbDJbD2a8ZJS5ASnax3VJQYtyz1LfS9mYS2+Ak8dOW6X6JVG7cTgd4yaNzwI4ERGMNTL
         FmLxKJjuamO9F54TrYDFa3fqqw0H+a/RaXdu16cdske51msP5FJQiossnivCoEBcPRRA
         ETYeYHFBvq4K8wHKwtt52NW18kd/VaYOaMImrglVBEeBg+GaEnhQ8Jl6x5vON0/a5TUU
         7xKYzqpW9z3S/OkNEvJ8CUiu6wCzquSIs/Ta+ZJ/NQTVfYYt5yCOvB3uyRqT9UmCmMYe
         2Liw==
X-Forwarded-Encrypted: i=1; AJvYcCUGCwHrQwceWxaUIK3StBkgdPQvqbAL6q1PxCHyAOvwJgFDCClhUpgUt4R7bY/9KRTzCTA=@vger.kernel.org, AJvYcCX/T8w2nnhOSzwrzyFegi6jwzFgMCxsnrj6w60fVGMKFsfMvm6L0IQo2IJtVZrDZhivKbI2lXigl9z98153@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5GSsYpAEEzI3BOrqgL77Xx0IXCtM0TxofrqyFPOcMUHkfX+p
	qUXqUW06t0by5Q7eGpMFcAEn51+q5j/jVRB9kxVwlgJ6PBkC0NQN
X-Gm-Gg: ASbGnctDnsQxtU+yF0ISVS2DS0S2g4jE0yk5sdFfWGq090694FoZsjghnYH9mOJgm/A
	Be8/8bk+tHcei+J7gWO3KBPAksU39vL30d7iVbmFyE/rYz+GC6cYfZw1sIxoz1EaJYaZo/4W541
	DruzkdbnW/XYY8v2Cy9Xc0hOkss5cMr2Stcxd04yrmaEA58QHSTd9uvAM4vxMOQwhB9UjFeigyP
	QPAAD9XjLtKiKhzmTvN8qGJBOFVDnraNqPKhDiUqqdFBILGY6ivl4zzrgpykTtbNQv8VHWJiSy8
	TyHc4tkMsl/21h0+KKF9Vm8x+wjSRRZKPHewNFeFOmzz5H56/LA=
X-Google-Smtp-Source: AGHT+IG6lVo30sIag7LkXlb/FtGB6wrPBCg40lsJadb2e3pC4IvgbseJ7xu1VMCbY5sGUkFCowGT7g==
X-Received: by 2002:a05:690c:6f8c:b0:6f9:8468:127c with SMTP id 00721157ae682-6f9b287b8ddmr88973477b3.19.1739123427125;
        Sun, 09 Feb 2025 09:50:27 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99fcefe5bsm12905037b3.21.2025.02.09.09.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 09:50:26 -0800 (PST)
Date: Sun, 9 Feb 2025 12:50:25 -0500
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
Subject: Re: [PATCH 2/6] sched/topology: Introduce for_each_numa_node()
 iterator
Message-ID: <Z6jq4RTT7ynoM2vO@thinkpad>
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
> Introduce the new helper for_each_numa_node() to iterate over node IDs
> in order of increasing NUMA distance from a given starting node.
> 
> This iterator is similar to for_each_numa_hop_mask(), but instead of
> providing a cpumask at each iteration, it provides a node ID.
> 
> Example usage:
> 
>   nodemask_t unvisited = NODE_MASK_ALL;
>   int node, start = cpu_to_node(smp_processor_id());
> 
>   node = start;
>   for_each_numa_node(node, unvisited, N_ONLINE)
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

Great to see virtme-ng maturing!
 
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
> ---
>  include/linux/topology.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 52f5850730b3e..09c18ee8be0eb 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -261,6 +261,34 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
>  }
>  #endif	/* CONFIG_NUMA */
>  
> +/**
> + * for_each_numa_node - iterate over nodes at increasing distances from a
> + *			given starting node.

Nit: in increasing distance order, starting from a given node

> + * @node: the iteration variable and the starting node.
> + * @unvisited: a nodemask to keep track of the unvisited nodes.
> + * @state: state of NUMA nodes to iterate.
> + *
> + * This macro iterates over NUMA node IDs in increasing distance from the
> + * starting @node and yields MAX_NUMNODES when all the nodes have been
> + * visited.

Please also mention that the unvisited nodemask will be empty when it finish.

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
> -- 
> 2.48.1

