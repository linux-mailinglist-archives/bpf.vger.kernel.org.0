Return-Path: <bpf+bounces-67633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF7BB46595
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA44417C644
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582F32F1FF4;
	Fri,  5 Sep 2025 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h3ahOOnk"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880C315D5F
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108008; cv=none; b=nmgviFcyiXefBZpALZPe9ChBoHh53fO/S9pxZhnIxQLGd+jl+wA6vXNs9h5+at+zKKsEljD24nP9fZ0JuB46NWwgkWqoTVy5Dgftgut4wFIPJpEQKlMktI/WYGzRmxqhyvC90GO9EbQ9Nvm8ze34E4Wj02yTymQPERM74BedvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108008; c=relaxed/simple;
	bh=cM/sC7g+vP43k3NeMR6pWqq6H0KzVlXEAKAVU0GkdsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3pK0snWBafrARQlxsFMa5Sobs62YDo3lmyWxHfDdrOXcvzJh6/enp1TeV5sxubc4+mtq04d9Xl3M6UF824vApnBSr00+XKbxNDpv92c65Mf2/z0+o/soAc+1uGMRCNngs8AYA0r6/Bu1AmwGaZOnaE9LtWuLntcETgpNk7oB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h3ahOOnk; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 14:33:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757108002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwCCUd0KTHgYFr0j+O9LFcsWubnSBozHvxaBHLHATR4=;
	b=h3ahOOnk/F0MmUrnwBj0pv+WS92VUhpUcjg9AF/33EvQBSOR10RVaCo6g6sKvHPZ7RxQiR
	ossZ/zceuY6LBcRxgB1y3V/V+5V4ZIXr9lLQmuk9MmkA2Gmipmt8kzFJybjnnxAq+gq4kj
	1PBirCUf/vYTfpvlbNyxekDm4CIgA8c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Peilin Ye <yepeilin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <ukh4fh3xsahsff62siwgsa3o5k7mjv3xs6j3u2ymdkvgpzagqf@jfrd7uwbacld>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <aLtMrlSDP7M5GZ27@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLtMrlSDP7M5GZ27@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 05, 2025 at 08:48:46PM +0000, Peilin Ye wrote:
> On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> > Generally memcg charging is allowed from all the contexts including NMI
> > where even spinning on spinlock can cause locking issues. However one
> > call chain was missed during the addition of memcg charging from any
> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > cgroup_file_notify().
> > 
> > The possible function call tree under cgroup_file_notify() can acquire
> > many different spin locks in spinning mode. Some of them are
> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > just skip cgroup_file_notify() from memcg charging if the context does
> > not allow spinning.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Tested-by: Peilin Ye <yepeilin@google.com>

Thanks Peilin. When you post the official patch for __GFP_HIGH in
__bpf_async_init(), please add a comment on why __GFP_HIGH is used
instead of GFP_ATOMIC.

> 
> The repro described in [1] no longer triggers locking issues after
> applying this patch and making __bpf_async_init() use __GFP_HIGH
> instead of GFP_ATOMIC:
> 
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1275,7 +1275,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
>         }
> 
>         /* allocate hrtimer via map_kmalloc to use memcg accounting */
> -       cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
> +       cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);
>         if (!cb) {
>                 ret = -ENOMEM;
>                 goto out;
> 
> [1] https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@google.com/#t
> 
> Thanks,
> Peilin Ye
> 

