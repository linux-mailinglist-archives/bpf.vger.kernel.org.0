Return-Path: <bpf+bounces-15867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D27F7F91B4
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 08:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E66281295
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 07:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3746B1;
	Sun, 26 Nov 2023 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IEZFUsQP"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983CA85
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 23:13:34 -0800 (PST)
Message-ID: <03909d48-646d-4d71-b7bd-0b7510b0bd4f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700982811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RIQG0ZOKI0rAFv95UTGPzVBIwfAN0oGMflLLQZuGiQ=;
	b=IEZFUsQPF30fhNYp3hd+0/d/T8My5QVfOf4rJGVHbT9vz9ZANSw/wIyktW9fBr+ZtkDz63
	RiCJy9+pkZ3rmMKoN4jPiPAtBoMcFlCsDOObtgNTNK0GIgdsHBWImPo2Sa4375QzDSpBPo
	OXgkb8MYU8GP5F8kn5Dyiz4A87mJHQM=
Date: Sat, 25 Nov 2023 23:13:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 4/6] bpf: Optimize the free of inner map
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231124113033.503338-1-houtao@huaweicloud.com>
 <20231124113033.503338-5-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231124113033.503338-5-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/24/23 6:30 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> When removing the inner map from the outer map, the inner map will be
> freed after one RCU grace period and one RCU tasks trace grace
> period, so it is certain that the bpf program, which may access the
> inner map, has exited before the inner map is freed.
>
> However there is unnecessary to wait for any RCU grace period, one RCU
> grace period or one RCU tasks trace grace period if the outer map is
> only accessed by userspace, sleepable program or non-sleepable program.
> So recording the sleepable attributes of the owned bpf programs when
> adding the outer map into env->used_maps, copying the recorded
> attributes to inner map atomically when removing inner map from the
> outer map and using the recorded attributes in the inner map to decide
> which, and how many, RCU grace periods are needed when freeing the
> inner map.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   include/linux/bpf.h     |  8 +++++++-
>   kernel/bpf/map_in_map.c | 19 ++++++++++++++-----
>   kernel/bpf/syscall.c    | 15 +++++++++++++--
>   kernel/bpf/verifier.c   |  4 ++++
>   4 files changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 15a6bb951b70..c5b549f352d7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -245,6 +245,11 @@ struct bpf_list_node_kern {
>   	void *owner;
>   } __attribute__((aligned(8)));
>   
> +enum {
> +	BPF_MAP_RCU_GP = BIT(0),
> +	BPF_MAP_RCU_TT_GP = BIT(1),
> +};
> +
>   struct bpf_map {
>   	/* The first two cachelines with read-mostly members of which some
>   	 * are also accessed in fast-path (e.g. ops, max_entries).
> @@ -296,7 +301,8 @@ struct bpf_map {
>   	} owner;
>   	bool bypass_spec_v1;
>   	bool frozen; /* write-once; write-protected by freeze_mutex */
> -	bool free_after_mult_rcu_gp;
> +	atomic_t used_in_rcu_gp;
> +	atomic_t free_by_rcu_gp;
>   	s64 __percpu *elem_count;
>   };
>   
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index cf3363065566..d044ee677107 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -131,12 +131,21 @@ void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool deferred)
>   {
>   	struct bpf_map *inner_map = ptr;
>   
> -	/* The inner map may still be used by both non-sleepable and sleepable
> -	 * bpf program, so free it after one RCU grace period and one tasks
> -	 * trace RCU grace period.
> +	/* Defer the freeing of inner map according to the attribute of bpf
> +	 * program which owns the outer map, so unnecessary multiple RCU GP
> +	 * waitings can be avoided.
>   	 */
> -	if (deferred)
> -		WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
> +	if (deferred) {
> +		/* used_in_rcu_gp may be updated concurrently by new bpf
> +		 * program, so add smp_mb() to guarantee the order between
> +		 * used_in_rcu_gp and lookup/deletion operation of inner map.
> +		 * If a new bpf program finds the inner map before it is
> +		 * removed from outer map, reading used_in_rcu_gp below will
> +		 * return the newly-set bit set by the new bpf program.
> +		 */
> +		smp_mb();

smp_mb__before_atomic()?

> +		atomic_or(atomic_read(&map->used_in_rcu_gp), &inner_map->free_by_rcu_gp);
> +	}
>   	bpf_map_put(inner_map);
>   }
>   
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 88882cb58121..014a8cd55a41 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -734,7 +734,10 @@ static void bpf_map_free_rcu_gp(struct rcu_head *rcu)
>   
>   static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
>   {
> -	if (rcu_trace_implies_rcu_gp())
> +	struct bpf_map *map = container_of(rcu, struct bpf_map, rcu);
> +
> +	if (!(atomic_read(&map->free_by_rcu_gp) & BPF_MAP_RCU_GP) ||
> +	    rcu_trace_implies_rcu_gp())
>   		bpf_map_free_rcu_gp(rcu);
>   	else
>   		call_rcu(rcu, bpf_map_free_rcu_gp);
> @@ -746,11 +749,16 @@ static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
>   void bpf_map_put(struct bpf_map *map)
>   {
>   	if (atomic64_dec_and_test(&map->refcnt)) {
> +		int free_by_rcu_gp;
> +
>   		/* bpf_map_free_id() must be called first */
>   		bpf_map_free_id(map);
>   		btf_put(map->btf);
>   
> -		if (READ_ONCE(map->free_after_mult_rcu_gp))
> +		free_by_rcu_gp = atomic_read(&map->free_by_rcu_gp);
> +		if (free_by_rcu_gp == BPF_MAP_RCU_GP)
> +			call_rcu(&map->rcu, bpf_map_free_rcu_gp);
> +		else if (free_by_rcu_gp)
>   			call_rcu_tasks_trace(&map->rcu, bpf_map_free_mult_rcu_gp);
>   		else
>   			bpf_map_free_in_work(map);
> @@ -5343,6 +5351,9 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
>   		goto out_unlock;
>   	}
>   
> +	/* No need to update used_in_rcu_gp, because the bpf program doesn't
> +	 * access the map.
> +	 */
>   	memcpy(used_maps_new, used_maps_old,
>   	       sizeof(used_maps_old[0]) * prog->aux->used_map_cnt);
>   	used_maps_new[prog->aux->used_map_cnt] = map;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6da370a047fe..3b86c02077f1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18051,6 +18051,10 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>   				return -E2BIG;
>   			}
>   
> +			atomic_or(env->prog->aux->sleepable ? BPF_MAP_RCU_TT_GP : BPF_MAP_RCU_GP,
> +				  &map->used_in_rcu_gp);
> +			/* Pairs with smp_mb() in bpf_map_fd_put_ptr() */
> +			smp_mb__before_atomic();

smp_mb__after_atomic()?

Just curious, are two smp_mb*() memory barriers in this patch truely necessary or just
want to be cautious?

>   			/* hold the map. If the program is rejected by verifier,
>   			 * the map will be released by release_maps() or it
>   			 * will be used by the valid program until it's unloaded

