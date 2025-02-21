Return-Path: <bpf+bounces-52155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9D8A3ECFF
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 07:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD5D3A710D
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 06:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628C01FCF43;
	Fri, 21 Feb 2025 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwSdyyIA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14C370807;
	Fri, 21 Feb 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740120410; cv=none; b=WpvptU+IDuF2Knn1hKqp49ZEcU1Z2gdmILdW64LnPHVgyfbpdfwDZinnNKPhAIRehRZwQXmi5EJWWE8vtcF0CXojPsaqNUlaYGglYTjebomNwhqS2B6iYcYsGRm/b9Xxc0OixerNJ5BesNSEchTmBpAW6btZ6QVuUNncJ2vxa6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740120410; c=relaxed/simple;
	bh=/lcKvEh7xzFQthcjIJScl1xXg9SkqZpz9b/yOuJqvSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLTw0ckS3LhTqI7wZFgpEca7U64RHPJsMkZJNwxoO8BSGmsd11cjU+1DvA1A1l7XeCb89ZxGRJLCJFbIWnZq3MfU9lmZcdCHvnKvUQaIYdXQGpuWrFNFt1j+J5s9w5vt0f/tCOeOu3LZ+qzHk7Lg5Ux4IKYvQmPZRTwOQvitycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwSdyyIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59CCC4CED6;
	Fri, 21 Feb 2025 06:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740120410;
	bh=/lcKvEh7xzFQthcjIJScl1xXg9SkqZpz9b/yOuJqvSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwSdyyIAnrlexUonJ7U2N/RUiJvQC3SUdMN4bOdK+3fTdhv09IN0qg73LdZHmOkcE
	 ej/8csoehOaXiy4tmxckC6ZPkAzQKk9FLEmzpKXVjWljLZfOxSeelb2cdNBRpCbaGc
	 nmFPV81ov9VfizuPCFRTku2eC6RRJdZyz3GTaLioyQ8m1P4VOTg0qM/DehROyZn+Zt
	 QeoTmWTdrin1BopcNEb1usvWz3nkStvUQr0b8f3J3YMVya4t56z+y2lKqVl7rs6iW4
	 bHsq/CVYWZ8IdHlSgG1U9VW/T3WhOWWLOJwX67ix5NvQaScxaro0Uud8wTnPsMU8b7
	 N85O3lHOmhdWg==
Date: Thu, 20 Feb 2025 22:46:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, nick.forrington@arm.com,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v6 2/4] perf lock: Retrieve owner callstack in bpf program
Message-ID: <Z7ghWIq8wXCJ2Y8T@google.com>
References: <20250219214400.3317548-1-ctshao@google.com>
 <20250219214400.3317548-3-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219214400.3317548-3-ctshao@google.com>

On Wed, Feb 19, 2025 at 01:40:01PM -0800, Chun-Tse Shao wrote:
> This implements per-callstack aggregation of lock owners in addition to
> per-thread.  The owner callstack is captured using `bpf_get_task_stack()`
> at `contention_begin()` and it also adds a custom stackid function for the
> owner stacks to be compared easily.
> 
> The owner info is kept in a hash map using lock addr as a key to handle
> multiple waiters for the same lock.  At `contention_end()`, it updates the
> owner lock stat based on the info that was saved at `contention_begin()`.
> If there are more waiters, it'd update the owner pid to itself as
> `contention_end()` means it gets the lock now.  But it also needs to check
> the return value of the lock function in case task was killed by a signal
> or something.
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 218 +++++++++++++++++-
>  1 file changed, 209 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 23fe9cc980ae..e8b113d5802a 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -197,6 +197,9 @@ int data_fail;
>  int task_map_full;
>  int data_map_full;
>  
> +struct task_struct *bpf_task_from_pid(s32 pid) __ksym __weak;
> +void bpf_task_release(struct task_struct *p) __ksym __weak;
> +
>  static inline __u64 get_current_cgroup_id(void)
>  {
>  	struct task_struct *task;
> @@ -420,6 +423,61 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
>  	return pelem;
>  }
>  
> +static inline s32 get_owner_stack_id(u64 *stacktrace)
> +{
> +	s32 *id, new_id;
> +	static s64 id_gen = 1;
> +
> +	id = bpf_map_lookup_elem(&owner_stacks, stacktrace);
> +	if (id)
> +		return *id;
> +
> +	new_id = (s32)__sync_fetch_and_add(&id_gen, 1);
> +
> +	bpf_map_update_elem(&owner_stacks, stacktrace, &new_id, BPF_NOEXIST);
> +
> +	id = bpf_map_lookup_elem(&owner_stacks, stacktrace);
> +	if (id)
> +		return *id;
> +
> +	return -1;
> +}
> +
> +static inline void update_contention_data(struct contention_data *data, u64 duration, u32 count)
> +{
> +	__sync_fetch_and_add(&data->total_time, duration);
> +	__sync_fetch_and_add(&data->count, count);
> +
> +	/* FIXME: need atomic operations */
> +	if (data->max_time < duration)
> +		data->max_time = duration;
> +	if (data->min_time > duration)
> +		data->min_time = duration;
> +}
> +
> +static inline void update_owner_stat(u32 id, u64 duration, u32 flags)
> +{
> +	struct contention_key key = {
> +		.stack_id = id,
> +		.pid = 0,
> +		.lock_addr_or_cgroup = 0,
> +	};
> +	struct contention_data *data = bpf_map_lookup_elem(&owner_stat, &key);
> +
> +	if (!data) {
> +		struct contention_data first = {
> +			.total_time = duration,
> +			.max_time = duration,
> +			.min_time = duration,
> +			.count = 1,
> +			.flags = flags,
> +		};
> +		bpf_map_update_elem(&owner_stat, &key, &first, BPF_NOEXIST);
> +	} else {
> +		update_contention_data(data, duration, 1);
> +	}
> +}
> +
>  SEC("tp_btf/contention_begin")
>  int contention_begin(u64 *ctx)
>  {
> @@ -437,6 +495,72 @@ int contention_begin(u64 *ctx)
>  	pelem->flags = (__u32)ctx[1];
>  
>  	if (needs_callstack) {
> +		u32 i = 0;
> +		u32 id = 0;
> +		int owner_pid;
> +		u64 *buf;
> +		struct task_struct *task;
> +		struct owner_tracing_data *otdata;
> +
> +		if (!lock_owner)
> +			goto skip_owner;
> +
> +		task = get_lock_owner(pelem->lock, pelem->flags);
> +		if (!task)
> +			goto skip_owner;
> +
> +		owner_pid = BPF_CORE_READ(task, pid);
> +
> +		buf = bpf_map_lookup_elem(&stack_buf, &i);
> +		if (!buf)
> +			goto skip_owner;
> +		for (i = 0; i < max_stack; i++)
> +			buf[i] = 0x0;
> +
> +		if (!bpf_task_from_pid)
> +			goto skip_owner;
> +
> +		task = bpf_task_from_pid(owner_pid);
> +		if (!task)
> +			goto skip_owner;
> +
> +		bpf_get_task_stack(task, buf, max_stack * sizeof(unsigned long), 0);
> +		bpf_task_release(task);
> +
> +		otdata = bpf_map_lookup_elem(&owner_data, &pelem->lock);
> +		id = get_owner_stack_id(buf);
> +
> +		/*
> +		 * Contention just happens, or corner case `lock` is owned by process not
> +		 * `owner_pid`. For the corner case we treat it as unexpected internal error and
> +		 * just ignore the precvious tracing record.
> +		 */
> +		if (!otdata || otdata->pid != owner_pid) {
> +			struct owner_tracing_data first = {
> +				.pid = owner_pid,
> +				.timestamp = pelem->timestamp,
> +				.count = 1,
> +				.stack_id = id,
> +			};
> +			bpf_map_update_elem(&owner_data, &pelem->lock, &first, BPF_ANY);
> +		}
> +		/* Contention is ongoing and new waiter joins */
> +		else {
> +			__sync_fetch_and_add(&otdata->count, 1);
> +
> +			/*
> +			 * The owner is the same, but stacktrace might be changed. In this case we
> +			 * store/update `owner_stat` based on current owner stack id.
> +			 */
> +			if (id != otdata->stack_id) {
> +				update_owner_stat(id, pelem->timestamp - otdata->timestamp,
> +						  pelem->flags);
> +
> +				otdata->timestamp = pelem->timestamp;
> +				otdata->stack_id = id;
> +			}
> +		}
> +skip_owner:
>  		pelem->stack_id = bpf_get_stackid(ctx, &stacks,
>  						  BPF_F_FAST_STACK_CMP | stack_skip);
>  		if (pelem->stack_id < 0)
> @@ -473,6 +597,7 @@ int contention_end(u64 *ctx)
>  	struct tstamp_data *pelem;
>  	struct contention_key key = {};
>  	struct contention_data *data;
> +	__u64 timestamp;
>  	__u64 duration;
>  	bool need_delete = false;
>  
> @@ -500,12 +625,94 @@ int contention_end(u64 *ctx)
>  		need_delete = true;
>  	}
>  
> -	duration = bpf_ktime_get_ns() - pelem->timestamp;
> +	timestamp = bpf_ktime_get_ns();
> +	duration = timestamp - pelem->timestamp;
>  	if ((__s64)duration < 0) {
>  		__sync_fetch_and_add(&time_fail, 1);
>  		goto out;
>  	}
>  
> +	if (needs_callstack && lock_owner) {
> +		struct owner_tracing_data *otdata = bpf_map_lookup_elem(&owner_data, &pelem->lock);
> +
> +		if (!otdata)
> +			goto skip_owner;
> +
> +		/* Update `owner_stat` */
> +		update_owner_stat(otdata->stack_id, timestamp - otdata->timestamp, pelem->flags);
> +
> +		/* No contention is occurring, delete `lock` entry in `owner_data` */
> +		if (otdata->count <= 1)
> +			bpf_map_delete_elem(&owner_data, &pelem->lock);
> +		/*
> +		 * Contention is still ongoing, with a new owner (current task). `owner_data`
> +		 * should be updated accordingly.
> +		 */
> +		else {
> +			u32 i = 0;
> +			s32 ret = (s32)ctx[1];
> +			u64 *buf;
> +
> +			__sync_fetch_and_add(&otdata->count, -1);
> +
> +			buf = bpf_map_lookup_elem(&stack_buf, &i);
> +			if (!buf)
> +				goto skip_owner;
> +			for (i = 0; i < (u32)max_stack; i++)
> +				buf[i] = 0x0;
> +
> +			/*
> +			 * `ret` has the return code of the lock function.
> +			 * If `ret` is negative, the current task terminates lock waiting without
> +			 * acquiring it. Owner is not changed, but we still need to update the owner
> +			 * stack.
> +			 */
> +			if (ret < 0) {
> +				s32 id = 0;
> +				struct task_struct *task;
> +
> +				if (!bpf_task_from_pid)
> +					goto skip_owner;
> +
> +				task = bpf_task_from_pid(otdata->pid);
> +				if (!task)
> +					goto skip_owner;
> +
> +				bpf_get_task_stack(task, buf,
> +						   max_stack * sizeof(unsigned long), 0);
> +				bpf_task_release(task);
> +
> +				id = get_owner_stack_id(buf);
> +
> +				/*
> +				 * If owner stack is changed, update `owner_data` and `owner_stat`
> +				 * accordingly.
> +				 */
> +				if (id != otdata->stack_id) {
> +					update_owner_stat(id, pelem->timestamp - otdata->timestamp,

Shouldn't it be 'timestamp' instead of 'pelem->timestamp'?


> +							  pelem->flags);
> +
> +					otdata->timestamp = pelem->timestamp;

Ditto.

Thanks,
Namhyung


> +					otdata->stack_id = id;
> +				}
> +			}
> +			/*
> +			 * Otherwise, update tracing data with the current task, which is the new
> +			 * owner.
> +			 */
> +			else {
> +				otdata->pid = pid;
> +				otdata->timestamp = timestamp;
> +				/*
> +				 * We don't want to retrieve callstack here, since it is where the
> +				 * current task acquires the lock and provides no additional
> +				 * information. We simply assign -1 to invalidate it.
> +				 */
> +				otdata->stack_id = -1;
> +			}
> +		}
> +	}
> +skip_owner:
>  	switch (aggr_mode) {
>  	case LOCK_AGGR_CALLER:
>  		key.stack_id = pelem->stack_id;
> @@ -589,14 +796,7 @@ int contention_end(u64 *ctx)
>  	}
>  
>  found:
> -	__sync_fetch_and_add(&data->total_time, duration);
> -	__sync_fetch_and_add(&data->count, 1);
> -
> -	/* FIXME: need atomic operations */
> -	if (data->max_time < duration)
> -		data->max_time = duration;
> -	if (data->min_time > duration)
> -		data->min_time = duration;
> +	update_contention_data(data, duration, 1);
>  
>  out:
>  	pelem->lock = 0;
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 

