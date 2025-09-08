Return-Path: <bpf+bounces-67743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 685F0B496FA
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5981C25AA3
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424FC313288;
	Mon,  8 Sep 2025 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PaPT8sxo"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F302A35947
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352762; cv=none; b=l9zBbu3BoR3i0gGon8W45c4t2jl94z0glsWZW9DcHaGHom1Zh+RAplvgXDLFLaN3w9s1LEvDWP4/4Coy7UaqH8CC5oBQWKS43dq2hUtoFmsUJw68A2SQqWlmwkFQUyniDH5+h9rnUuo3CToQuZTCn5d0HfeWnNGgC0m5whpcdbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352762; c=relaxed/simple;
	bh=HNDyIXFjXlFMtYtVfiM4CJ1KbvodoBg5GWrt+WBLMpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewlhw/m4dusIDT+JmwPTnGq/g01wDOKAhI/dthdSfRli4GN/6OBksPTt+phXox2FLRc5L1lux+5ciPKZvHk59W9BKcrLTX3wmvb9G820GShgGwFxUXKRCeXqXJN61URhKE8GpIt2uHtjhUFErDHJupYD5jsaJh3SxmR8nkTWz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PaPT8sxo; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 8 Sep 2025 10:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757352757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zv9Ta4mThEV4XBqO1qxHvbCXn2hXPpn499vn6yt4SLY=;
	b=PaPT8sxopmQs/goLFGqee+bzc4AGGChuBX+kzsBj8jmIJC4SPTpG5yEe882ldBSHcRVJZR
	9pXtxwb4Ye35WfAxVQOi2FCCVznhXNbfonLQctD629gDl/xwxqLvkJJRQc7p/BW6cMIaue
	pEzPqDtRAWRdjPVpinx034Gbnk2rRK0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	linux-mm@kvack.org
Subject: Re: [PATCH bpf] bpf/helpers: Use __GFP_HIGH instead of GFP_ATOMIC in
 __bpf_async_init()
Message-ID: <b634rejnvxqu6knjqlijosxrcnxbbpagt4de4pl6env6dwldz2@hoofqufparh5>
References: <20250905234547.862249-1-yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905234547.862249-1-yepeilin@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 05, 2025 at 11:45:46PM +0000, Peilin Ye wrote:
> Currently, calling bpf_map_kmalloc_node() from __bpf_async_init() can
> cause various locking issues; see the following stack trace (edited for
> style) as one example:
> 
> ...
>  [10.011566]  do_raw_spin_lock.cold
>  [10.011570]  try_to_wake_up             (5) double-acquiring the same
>  [10.011575]  kick_pool                      rq_lock, causing a hardlockup
>  [10.011579]  __queue_work
>  [10.011582]  queue_work_on
>  [10.011585]  kernfs_notify
>  [10.011589]  cgroup_file_notify
>  [10.011593]  try_charge_memcg           (4) memcg accounting raises an
>  [10.011597]  obj_cgroup_charge_pages        MEMCG_MAX event
>  [10.011599]  obj_cgroup_charge_account
>  [10.011600]  __memcg_slab_post_alloc_hook
>  [10.011603]  __kmalloc_node_noprof
> ...
>  [10.011611]  bpf_map_kmalloc_node
>  [10.011612]  __bpf_async_init
>  [10.011615]  bpf_timer_init             (3) BPF calls bpf_timer_init()
>  [10.011617]  bpf_prog_xxxxxxxxxxxxxxxx_fcg_runnable
>  [10.011619]  bpf__sched_ext_ops_runnable
>  [10.011620]  enqueue_task_scx           (2) BPF runs with rq_lock held
>  [10.011622]  enqueue_task
>  [10.011626]  ttwu_do_activate
>  [10.011629]  sched_ttwu_pending         (1) grabs rq_lock
> ...
> 
> The above was reproduced on bpf-next (b338cf849ec8) by modifying
> ./tools/sched_ext/scx_flatcg.bpf.c to call bpf_timer_init() during
> ops.runnable(), and hacking [1] the memcg accounting code a bit to make
> a bpf_timer_init() call much more likely to raise an MEMCG_MAX event.
> 
> We have also run into other similar variants (both internally and on
> bpf-next), including double-acquiring cgroup_file_kn_lock, the same
> worker_pool::lock, etc.
> 
> As suggested by Shakeel, fix this by using __GFP_HIGH instead of
> GFP_ATOMIC in __bpf_async_init(), so that if try_charge_memcg() raises
> an MEMCG_MAX event, we call __memcg_memory_event() with
> @allow_spinning=false and skip calling cgroup_file_notify(), in order to
> avoid the locking issues described above.
> 
> Depends on mm patch "memcg: skip cgroup_file_notify if spinning is not
> allowed".  Tested with vmtest.sh (llvm-18, x86-64):
> 
>  $ ./test_progs -a '*timer*' -a '*wq*'
> ...
>  Summary: 7/12 PASSED, 0 SKIPPED, 0 FAILED
> 
> [1] Making bpf_timer_init() much more likely to raise an MEMCG_MAX event
> (gist-only, for brevity):
> 
> kernel/bpf/helpers.c:__bpf_async_init():
>  -        cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
>  +        cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC | __GFP_HACK,
>  +                                  map->numa_node);
> 
> mm/memcontrol.c:try_charge_memcg():
>           if (!do_memsw_account() ||
>  -            page_counter_try_charge(&memcg->memsw, batch, &counter)) {
>  -                if (page_counter_try_charge(&memcg->memory, batch, &counter))
>  +            page_counter_try_charge_hack(&memcg->memsw, batch, &counter,
>  +                                         gfp_mask & __GFP_HACK)) {
>  +                if (page_counter_try_charge_hack(&memcg->memory, batch,
>  +                                                 &counter,
>  +                                                 gfp_mask & __GFP_HACK))
>                           goto done_restock;
> 
> mm/page_counter.c:page_counter_try_charge():
>  -bool page_counter_try_charge(struct page_counter *counter,
>  -                             unsigned long nr_pages,
>  -                             struct page_counter **fail)
>  +bool page_counter_try_charge_hack(struct page_counter *counter,
>  +                                  unsigned long nr_pages,
>  +                                  struct page_counter **fail, bool hack)
>  {
> ...
>  -                if (new > c->max) {
>  +                if (hack || new > c->max) {     // goto failed;
>                           atomic_long_sub(nr_pages, &c->usage);
> 
> Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>  kernel/bpf/helpers.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b9b0c5fe33f6..508b13c24778 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1274,8 +1274,14 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
>  		goto out;
>  	}
>  
> -	/* allocate hrtimer via map_kmalloc to use memcg accounting */
> -	cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
> +	/* Allocate via bpf_map_kmalloc_node() for memcg accounting. Use
> +	 * __GFP_HIGH instead of GFP_ATOMIC to avoid calling
> +	 * cgroup_file_notify() if an MEMCG_MAX event is raised by
> +	 * try_charge_memcg(). This prevents various locking issues, including
> +	 * double-acquiring locks that may already be held here (e.g.,
> +	 * cgroup_file_kn_lock, rq_lock).

Too much unnecessary information in the comment. Just mention that we
want nolock allocations and for that we need to remove __GFP_RECLAIM
flags until nolock allocation interfaces are available.

