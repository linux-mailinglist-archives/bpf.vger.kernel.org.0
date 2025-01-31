Return-Path: <bpf+bounces-50253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C167A245B7
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 00:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77247161BA9
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 23:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25FD1BD519;
	Fri, 31 Jan 2025 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFTAcsVi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F131199223;
	Fri, 31 Jan 2025 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738367293; cv=none; b=bP1Vses6Que80pU4k2PjyemmpG8kTv3jJI+u+FvJ7J6vRzlEf55G7NVa3MWARAvegZKB2vcZCnygRY69OKdFp5v7tyDv3YoBqA1htsXwvymJQicoifvE3vcjRti+2W1Vb/JyT5+r5qwsOHq8yQjTTXbxAGoqXtgq/PpMBz3Lhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738367293; c=relaxed/simple;
	bh=5ZPTZZnQckEL3MJ/yg69NlY9wu5stDv4dICjfuahpQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwazpnsKJLHLCHsaC5iTQ/NbeZ/iFPx42WeHl/5K5gwjuwMIICDB8RzeRBaPNyx3Z13WUJ6YCvh1fHOVH0fMyYAU/RVm8lKuIqaJrn6AD6aDG7whZp9YSn/FCtLpz9PWAM0jVIfRwxbBau3L8Gv1GKeabi+09vIiq5BWyzwRRkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFTAcsVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B44C4CED1;
	Fri, 31 Jan 2025 23:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738367293;
	bh=5ZPTZZnQckEL3MJ/yg69NlY9wu5stDv4dICjfuahpQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFTAcsVih2FdpF6daKb8snCU6bGJkLNQJ6RxPjolvPT0+zL/HvC7MCOhAEj6JoahI
	 TJ490RszuNr4nWcDeXD/WSORKrX0PbfypnuEn2XPiidwZ3A2SgCj88uxFpU9ZtuueZ
	 VzxYMTM0wtUVMStVRJBicfKsyQjl2inqB7l9QRdndtm9ZfeN6XdpUxlPuV+NaGqwQN
	 3k66KTBIrmEPCuv8TSizahYMOKDgNy/pD8asEkZUsupvYcdko4/rsWF5WRDQouaOiM
	 PxnvnMj6pVeR2ehAKllN7XVaUNKhyDC0Lsir60Pm/rIfHd+iY+ceUqWkHVmg6Y/rE8
	 GhWCGClmOCt+w==
Date: Fri, 31 Jan 2025 15:48:11 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 2/5] perf lock: Retrieve owner callstack in bpf program
Message-ID: <Z51hO-0TCmayVc7F@google.com>
References: <20250130052510.860318-1-ctshao@google.com>
 <20250130052510.860318-3-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130052510.860318-3-ctshao@google.com>

On Wed, Jan 29, 2025 at 09:21:36PM -0800, Chun-Tse Shao wrote:
> Tracks lock contention by tracing owner callstacks in
> `contention_begin()` and `contention_end()`, storing data in the
> owner_stat BPF map. `contention_begin()` records the owner and their
> callstack. `contention_end()` updates contention statistics (count,
> time), decrements the waiter count, and removes the record when no
> waiters remain. Statistics are also updated if the owner's callstack
> changes. Note that owner and its callstack retrieval may fail.
> 
> To elaborate the process in detail:
>   /*
>    * In `contention_begin(), the current task is the lock waiter`. We
>    * create/update `owner_data` for the given `lock` address.
>   contention_begin() {
>     Try to get owner task. Skip entire process if fails.
>     Try to get owner stack based on task. Use empty stack if fails.
>     Store owner stack into `owner_stacks` and create `stack_id`. If fail
>       to store, use negative `stack_id`, which will be ignored while
>       reporting in usermode.
>     Retrieve `owner_tracing_data` in `owner_data` with given `lock`
>       address.
> 
>     /*
>      * The first case means contention just happens, or mismatched owner
>      * infomation so we just drop the previous record.
>      */
>     if (`owner_tracing_data` does not exist ||
>         the recorded owner `pid` does not match with the detected owner) {
>       Create `owner_tracing_data` with info from detected owner, and
>         store it in `owner_data` with key `lock` address.
>     }
>     /*
>      * The second case means contention is on going. One more waiter is
>      * joining the lock contention. Both `owner_data` and `owner_stat`
>      * should be updated.
>      */
>     else {
>       `owner_tracing_data.count`++
> 
>       Create `contention_key` with owner `stack_id` and lookup
>         `contention_data` in `owner_stat`.
>       if (`contention_data` does not exist) {
>         Create new entry for `contention_key`:`contention_data` in
>           `owner_stat`.
>       }
>       else {
>         Update the `count` and `total_time` in existing
>         `contention_data`.
>       }
> 
>       Update `timestamp` and `stack_id` in `owner_tracing_data`.
>     }
>   }
> 
>   /*
>    * In `contention_end()`, the current task will be the new owner of
>    * the `lock`, if `ctx[1]` is not 0.
>    */
>   contention_end() {
>     Lookup `owner_tracing_data` in `owner_data` with key `lock`.
> 
>     Create `contention_key` with `owner_tracing_data.stack_id` and
>       lookup `contention_data` in `owner_stat`.
>     if (`contention_data` does not exist) {
>       Create new entry for `contention_key`:`contention_data` in
>         `owner_stat`.
>     }
>     else {
>       Update the `count` and `total_time` in existing `contention_data`.
>     }
> 
>     /*
>      * There is no more waiters, contention is over, delete the record.
>      */
>     if (`owner_tracing_data.count` <= 1) {
>       delete this record in `owner_data`.
>     }
>     /*
>      * Contention is still on going.
>      */
>     else {
>       `owner_tracing_data.count`--
> 
>       if (`!ctx[0]`) {
>         The current task exits without acquiring the lock. However we
>           check for the recorded owner if the stack is changed, and
>           update `onwer_data` and `owner_stat` accordingly.
>       }
>       else {
>         The current task is the new owner, retrieve its stack, store it
>           in `owner_stack` and update `owner_tracing_data`.
>       }
>     }
>   }

I think this is too much detail. :)

I'd say something like this:

This implements per-callstack aggregation of lock owners in addition to
per-thread.  The owner callstack is captured using bpf_get_task_stack()
at contention_begin and it also adds a custom stackid function for the
owner stacks to be compared easily.

The owner info is kept in a hash map using lock addr as a key to handle
multiple waiters for the same lock.  At contention_end, it updates the
owner lock stat based on the info that was saved at contention_begin.
If there are more waiters, it'd update the owner pid to itself as
contention_end means it gets the lock now.  But it also needs to check
the return value of the lock function in case task was killed by a signal
or something.

> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 248 +++++++++++++++++-
>  1 file changed, 247 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 23fe9cc980ae..b12df873379f 100644
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
> @@ -420,6 +423,26 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
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
>  SEC("tp_btf/contention_begin")
>  int contention_begin(u64 *ctx)
>  {
> @@ -437,6 +460,97 @@ int contention_begin(u64 *ctx)
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
> +			goto skip_owner_begin;
> +
> +		task = get_lock_owner(pelem->lock, pelem->flags);
> +		if (!task)
> +			goto skip_owner_begin;
> +
> +		owner_pid = BPF_CORE_READ(task, pid);
> +
> +		buf = bpf_map_lookup_elem(&stack_buf, &i);
> +		if (!buf)
> +			goto skip_owner_begin;
> +		for (i = 0; i < max_stack; i++)
> +			buf[i] = 0x0;
> +
> +		if (bpf_task_from_pid) {

I think you can do this instead:

		if (bpf_task_from_pid == NULL)
			goto skip_owner_begin;

nit: it can be just 'skip_owner'. :)


> +			task = bpf_task_from_pid(owner_pid);
> +			if (task) {
> +				bpf_get_task_stack(task, buf, max_stack * sizeof(unsigned long), 0);
> +				bpf_task_release(task);
> +			}
> +		}
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
> +				u64 duration = otdata->timestamp - pelem->timestamp;

Isn't it the opposite?

	u64 duration = pelem->timestamp - otdata->timestamp;


> +				struct contention_key ckey = {
> +					.stack_id = id,
> +					.pid = 0,
> +					.lock_addr_or_cgroup = 0,
> +				};
> +				struct contention_data *cdata =
> +					bpf_map_lookup_elem(&owner_stat, &ckey);
> +
> +				if (!cdata) {
> +					struct contention_data first = {
> +						.total_time = duration,
> +						.max_time = duration,
> +						.min_time = duration,
> +						.count = 1,
> +						.flags = pelem->flags,
> +					};
> +					bpf_map_update_elem(&owner_stat, &ckey, &first,
> +							    BPF_NOEXIST);
> +				} else {
> +					__sync_fetch_and_add(&cdata->total_time, duration);
> +					__sync_fetch_and_add(&cdata->count, 1);
> +
> +					/* FIXME: need atomic operations */
> +					if (cdata->max_time < duration)
> +						cdata->max_time = duration;
> +					if (cdata->min_time > duration)
> +						cdata->min_time = duration;
> +				}

And as I said before, can we move this block out as a function?

> +
> +				otdata->timestamp = pelem->timestamp;
> +				otdata->stack_id = id;
> +			}
> +		}
> +skip_owner_begin:
>  		pelem->stack_id = bpf_get_stackid(ctx, &stacks,
>  						  BPF_F_FAST_STACK_CMP | stack_skip);
>  		if (pelem->stack_id < 0)
> @@ -473,6 +587,7 @@ int contention_end(u64 *ctx)
>  	struct tstamp_data *pelem;
>  	struct contention_key key = {};
>  	struct contention_data *data;
> +	__u64 timestamp;
>  	__u64 duration;
>  	bool need_delete = false;
>  
> @@ -500,12 +615,143 @@ int contention_end(u64 *ctx)
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
> +		u64 owner_time;
> +		struct contention_key ckey = {};
> +		struct contention_data *cdata;
> +		struct owner_tracing_data *otdata;
> +
> +		otdata = bpf_map_lookup_elem(&owner_data, &pelem->lock);
> +		if (!otdata)
> +			goto skip_owner_end;
> +
> +		/* Update `owner_stat` */
> +		owner_time = timestamp - otdata->timestamp;
> +		ckey.stack_id = otdata->stack_id;
> +		cdata = bpf_map_lookup_elem(&owner_stat, &ckey);
> +
> +		if (!cdata) {
> +			struct contention_data first = {
> +				.total_time = owner_time,
> +				.max_time = owner_time,
> +				.min_time = owner_time,
> +				.count = 1,
> +				.flags = pelem->flags,
> +			};
> +			bpf_map_update_elem(&owner_stat, &ckey, &first, BPF_NOEXIST);
> +		} else {
> +			__sync_fetch_and_add(&cdata->total_time, owner_time);
> +			__sync_fetch_and_add(&cdata->count, 1);
> +
> +			/* FIXME: need atomic operations */
> +			if (cdata->max_time < owner_time)
> +				cdata->max_time = owner_time;
> +			if (cdata->min_time > owner_time)
> +				cdata->min_time = owner_time;
> +		}
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
> +			u64 *buf;
> +
> +			__sync_fetch_and_add(&otdata->count, -1);
> +
> +			buf = bpf_map_lookup_elem(&stack_buf, &i);
> +			if (!buf)
> +				goto skip_owner_end;
> +			for (i = 0; i < (u32)max_stack; i++)
> +				buf[i] = 0x0;
> +
> +			/*
> +			 * ctx[1] has the return code of the lock function.

Then I think it's clearer to have a local variable named 'ret' or so.


> +			 * If ctx[1] is not 0, the current task terminates lock waiting without
> +			 * acquiring it. Owner is not changed, but we still need to update the owner
> +			 * stack.
> +			 */
> +			if (!ctx[1]) {

This doesn't match to the comment.  It should be:

			if (ret < 0) {


> +				s32 id = 0;
> +				struct task_struct *task = NULL;
> +
> +				if (bpf_task_from_pid)

Same as the above.  No need to go down if you cannot get the task and
stack.

				if (bpf_task_from_pid == NULL)
					goto skip_owner;


> +					task = bpf_task_from_pid(otdata->pid);
> +
> +				if (task) {
> +					bpf_get_task_stack(task, buf,
> +							   max_stack * sizeof(unsigned long), 0);
> +					bpf_task_release(task);
> +				}
> +
> +				id = get_owner_stack_id(buf);
> +
> +				/*
> +				 * If owner stack is changed, update `owner_data` and `owner_stat`
> +				 * accordingly.
> +				 */
> +				if (id != otdata->stack_id) {
> +					u64 duration = otdata->timestamp - pelem->timestamp;
> +					struct contention_key ckey = {
> +						.stack_id = id,
> +						.pid = 0,
> +						.lock_addr_or_cgroup = 0,
> +					};
> +					struct contention_data *cdata =
> +						bpf_map_lookup_elem(&owner_stat, &ckey);
> +
> +					if (!cdata) {
> +						struct contention_data first = {
> +							.total_time = duration,
> +							.max_time = duration,
> +							.min_time = duration,
> +							.count = 1,
> +							.flags = pelem->flags,
> +						};
> +						bpf_map_update_elem(&owner_stat, &ckey, &first,
> +								    BPF_NOEXIST);
> +					} else {
> +						__sync_fetch_and_add(&cdata->total_time, duration);
> +						__sync_fetch_and_add(&cdata->count, 1);
> +
> +						/* FIXME: need atomic operations */
> +						if (cdata->max_time < duration)
> +							cdata->max_time = duration;
> +						if (cdata->min_time > duration)
> +							cdata->min_time = duration;
> +					}
> +
> +					otdata->timestamp = pelem->timestamp;
> +					otdata->stack_id = id;
> +				}
> +			}
> +			/*
> +			 * If ctx[1] is 0, then update tracinng data with the current task, which is
> +			 * the new owner.
> +			 */
> +			else {
> +				otdata->pid = pid;
> +				otdata->timestamp = timestamp;
> +
> +				bpf_get_task_stack(bpf_get_current_task_btf(), buf,
> +						   max_stack * sizeof(unsigned long), 0);

This would be meaningless since it's still in the contention path.
Current callstack will be the same as the waiter callstack.  You'd 
better just invalidate callstack here and let the next waiter update
it.

Thanks,
Namhyung


> +				otdata->stack_id = get_owner_stack_id(buf);
> +			}
> +		}
> +	}
> +skip_owner_end:
> +
>  	switch (aggr_mode) {
>  	case LOCK_AGGR_CALLER:
>  		key.stack_id = pelem->stack_id;
> -- 
> 2.48.1.362.g079036d154-goog
> 

