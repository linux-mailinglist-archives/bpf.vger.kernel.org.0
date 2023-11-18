Return-Path: <bpf+bounces-15306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EC97EFE4B
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 08:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1FD1C20A04
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D27101F4;
	Sat, 18 Nov 2023 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NC5N4GGK"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6DFC1
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 23:34:49 -0800 (PST)
Message-ID: <b3955bcd-779e-4171-9daa-d5e2d6b9afd8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700292887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PduGGno1Wgn5D26gwkexmE5uxMP6nLSm3xWsjN9EOaA=;
	b=NC5N4GGK7CXgwCW9Q4xb2SrqK0BBWm2I48YauOSiETUPfcGjWPZ0Uz0UWpgEJ9EhYnqWlU
	hktQrU9ebnkYVmtu92aIn1s947H14AKAOoBJx/Ha0uFmHWT5kJHRywipxxR3aniV2QCizm
	ws+Kx6f1j/vMMLddytT26SrGTk402qo=
Date: Fri, 17 Nov 2023 23:34:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 4/5] bpf: Optimize the free of inner map
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 bpf@vger.kernel.org
References: <20231113123324.3914612-1-houtao@huaweicloud.com>
 <20231113123324.3914612-5-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231113123324.3914612-5-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/13/23 4:33 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When removing the inner map from the outer map, the inner map will be
> freed after one RCU grace period and one RCU tasks trace grace
> period, so it is certain that the bpf program which may access the inner
> map, has exited before the inner map is freed.
> 
> However there is unnecessary to wait for one RCU grace period or one RCU
> tasks trace grace period if the outer map is only accessed by sleepable
> program or non-sleepable program. So recording the context of the owned
> bpf programs when adding map into env->used_maps and using the recorded
> access context to decide which, and how many, RCU grace periods are
> needed when freeing the inner map.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   include/linux/bpf.h     |  9 ++++++++-
>   kernel/bpf/map_in_map.c | 18 +++++++++++++-----
>   kernel/bpf/syscall.c    | 15 +++++++++++++--
>   kernel/bpf/verifier.c   |  5 +++++
>   4 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ec3c90202ffe6..8faa1af4b39df 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -245,6 +245,12 @@ struct bpf_list_node_kern {
>   	void *owner;
>   } __attribute__((aligned(8)));
>   
> +enum {
> +	BPF_MAP_ACC_NORMAL_PROG_CTX = 1,
> +	BPF_MAP_ACC_SLEEPABLE_PROG_CTX = 2,

nit. It is a bit flag. Use (1U << 0) and (1U << 1) to make it more obvious.

How about renaming this to BPF_MAP_RCU_GP and BPF_MAP_RCU_TT_GP to better 
reflect it is used to decide if the map_free needs to wait for any rcu gp?

> +	BPF_MAP_ACC_PROG_CTX_MASK = BPF_MAP_ACC_NORMAL_PROG_CTX | BPF_MAP_ACC_SLEEPABLE_PROG_CTX,
> +};
> +
>   struct bpf_map {
>   	/* The first two cachelines with read-mostly members of which some
>   	 * are also accessed in fast-path (e.g. ops, max_entries).
> @@ -292,7 +298,8 @@ struct bpf_map {
>   	} owner;
>   	bool bypass_spec_v1;
>   	bool frozen; /* write-once; write-protected by freeze_mutex */
> -	bool free_after_mult_rcu_gp;
> +	atomic_t owned_prog_ctx;

Instead of the enum flags, this should only need a true/false value to tell 
whether the outer map has ever been used by a sleepable prog or not. may be 
renaming this to "atomic used_by_sleepable;"?

> +	atomic_t may_be_accessed_prog_ctx;

nit. rename this to "rcu_gp_flags;"

>   	s64 __percpu *elem_count;
>   };
>   
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index cf33630655661..e3d26a89ac5b6 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -131,12 +131,20 @@ void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool deferred)
>   {
>   	struct bpf_map *inner_map = ptr;
>   
> -	/* The inner map may still be used by both non-sleepable and sleepable
> -	 * bpf program, so free it after one RCU grace period and one tasks
> -	 * trace RCU grace period.
> +	/* Defer the freeing of inner map according to the owner program
> +	 * context of outer maps, so unnecessary multiple RCU GP waitings
> +	 * can be avoided.
>   	 */
> -	if (deferred)
> -		WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
> +	if (deferred) {
> +		/* owned_prog_ctx may be updated concurrently by new bpf program
> +		 * so add smp_mb() below to ensure that reading owned_prog_ctx
> +		 * will return the newly-set bit when the new bpf program finds
> +		 * the inner map before it is removed from outer map.
> +		 */
> +		smp_mb();

This part took my head spinning a little, so it is better to ask. The 
owned_prog_ctx is set during verification time. There are many instructions till 
the prog is actually verified, attached (another syscall) and then run to do the 
actual lookup(&outer_map). Is this level of reordering practically possible?

> +		atomic_or(atomic_read(&map->owned_prog_ctx),
> +			  &inner_map->may_be_accessed_prog_ctx);
> +	}
>   	bpf_map_put(inner_map);
>   }
>   
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e2d2701ce2c45..5a7906f2b027e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -694,12 +694,20 @@ static void bpf_map_free_deferred(struct work_struct *work)
>   {
>   	struct bpf_map *map = container_of(work, struct bpf_map, work);
>   	struct btf_record *rec = map->record;
> +	int acc_ctx;
>   
>   	security_bpf_map_free(map);
>   	bpf_map_release_memcg(map);
>   
> -	if (READ_ONCE(map->free_after_mult_rcu_gp))
> -		synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
> +	acc_ctx = atomic_read(&map->may_be_accessed_prog_ctx) & BPF_MAP_ACC_PROG_CTX_MASK;

The mask should not be needed.

> +	if (acc_ctx) {
> +		if (acc_ctx == BPF_MAP_ACC_NORMAL_PROG_CTX)
> +			synchronize_rcu();
> +		else if (acc_ctx == BPF_MAP_ACC_SLEEPABLE_PROG_CTX)
> +			synchronize_rcu_tasks_trace();
> +		else
> +			synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);

Is it better to add a rcu_head to the map and then use call_rcu_(). e.g. when 
there is many delete happened to the outer map during a process restart to 
re-populate the outer map. It is relatively much cheaper to add a rcu_head to 
the map comparing to adding one for each elem. wdyt?

> +	}
>   
>   	/* implementation dependent freeing */
>   	map->ops->map_free(map);
> @@ -5326,6 +5334,9 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
>   		goto out_unlock;
>   	}
>   
> +	/* No need to update owned_prog_ctx, because the bpf program doesn't
> +	 * access the map.
> +	 */
>   	memcpy(used_maps_new, used_maps_old,
>   	       sizeof(used_maps_old[0]) * prog->aux->used_map_cnt);
>   	used_maps_new[prog->aux->used_map_cnt] = map;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bd1c42eb540f1..d8d5432b240dc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18012,12 +18012,17 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>   				return -E2BIG;
>   			}
>   
> +			atomic_or(env->prog->aux->sleepable ? BPF_MAP_ACC_SLEEPABLE_PROG_CTX :
> +							      BPF_MAP_ACC_NORMAL_PROG_CTX,
> +				  &map->owned_prog_ctx);
>   			/* hold the map. If the program is rejected by verifier,
>   			 * the map will be released by release_maps() or it
>   			 * will be used by the valid program until it's unloaded
>   			 * and all maps are released in free_used_maps()
>   			 */
>   			bpf_map_inc(map);
> +			/* Paired with smp_mb() in bpf_map_fd_put_ptr() */
> +			smp_mb__after_atomic();
>   
>   			aux->map_index = env->used_map_cnt;
>   			env->used_maps[env->used_map_cnt++] = map;


