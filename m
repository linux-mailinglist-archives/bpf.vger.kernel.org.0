Return-Path: <bpf+bounces-50051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A84A22440
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 19:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82A23A6A60
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 18:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427A61E102E;
	Wed, 29 Jan 2025 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3dGGvMS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF314F9FF;
	Wed, 29 Jan 2025 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176496; cv=none; b=SZ289eTqucgHYzwaRX6QpzoImaqUYH+M0zAt3GTojf7+ivQ8/9Q2Dt2Owyc2xyYGs53ldBUUaPphlE6KPCmgU6hHlkfJIcOT8QSUeFFJAefYuB77PnPQcapKRYexZyTBS9A/rdybd5A0tQKPkAtmiJ0klwaQMYZeiiDPyd8tQEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176496; c=relaxed/simple;
	bh=CXP7BPR+I6h1lJOInWBbEeVVe76H2Yx2qxQM2byVMcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMBuJQDTvanDBMvfqCH8vqp9WryHm3ogoGNoWikJIpXQEDZE+i6dFJAw2ZaQUfWhQzAq03nGeZ87eq/4VOYEbTeglKPg1FMe/64xX9M8HgOcMQCiYSgPVCFC4587g7fmrVMaN7UJoLNsqrY7S3ekH8u80a73YCa5jwj5RxqGPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3dGGvMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A01AC4CED1;
	Wed, 29 Jan 2025 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738176494;
	bh=CXP7BPR+I6h1lJOInWBbEeVVe76H2Yx2qxQM2byVMcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3dGGvMSBN3rjir2qxzHa/0T9GrTLUNoK5jneY7yJ4Tw5DZ9HWPsWU0BEFJNo/I4x
	 S79kHwnTssFcnlbDwomnqyiZklHoNn0ZaeWZiu16H91QXcfOPKHrSPrMzT6yRWapxD
	 FJAfjsR79t8tUGi6FiCjd88G4AjmHJS5dWtUHsAVD4fwbWH+Ai6kSpKqyZt/nw1kl5
	 8GifN3wqPbbvCSJT5Sy7gNr7W5P2UYve7zbp4uWWllZ3aMs7cq0goLQbT8OBGT+K7B
	 Oi0WRBVFIV646sJgjkYqADmd8BTw+Q6MA0yUUvvQ2iQwH4nykxJ31AunZrqMXbSBCM
	 Vq0juwdUb5VMQ==
Date: Wed, 29 Jan 2025 10:48:11 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 2/5] perf lock: Retrieve owner callstack in bpf program
Message-ID: <Z5p361_enAI8ZtX8@google.com>
References: <20250129001905.619859-1-ctshao@google.com>
 <20250129001905.619859-3-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250129001905.619859-3-ctshao@google.com>

On Tue, Jan 28, 2025 at 04:14:58PM -0800, Chun-Tse Shao wrote:
> Tracing owner callstack in `contention_begin()` and `contention_end()`,
> and storing in `owner_stat` bpf map.

Can you please elaborate?  It'd be helpful to describe how the lock
owner is tracked and deals with multiple waiters.  Note that owner will
be changed when contention_end() is called (without an error).

And please mention that it can fail to get an owner and its callstack.
Actually that's very common and only mutex (and rwsem for writing?)
would support owner tracking.

> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 237 +++++++++++++++++-
>  1 file changed, 235 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index b4961dd86222..1ad2a0793c37 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  // Copyright (c) 2022 Google
> +#include "linux/bpf.h"

Why did you add this?


>  #include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> @@ -7,6 +8,7 @@
>  #include <asm-generic/errno-base.h>
>  
>  #include "lock_data.h"
> +#include <time.h>

And this too.  I remember adding header sometimes caused a trouble in
the build.  So I'm trying to be careful on this.  Roughly I don't think
you need new structs or functions so I'm wondering why it's added.

>  
>  /* for collect_lock_syms().  4096 was rejected by the verifier */
>  #define MAX_CPUS  1024
> @@ -31,7 +33,7 @@ struct {
>  struct {
>  	__uint(type, BPF_MAP_TYPE_HASH);
>  	__uint(key_size, sizeof(__u64)); // owner stacktrace
> -	__uint(value_size, sizeof(__u64)); // owner stack id
> +	__uint(value_size, sizeof(__s32)); // owner stack id
>  	__uint(max_entries, 1);
>  } owner_stacks SEC(".maps");
>  
> @@ -197,6 +199,9 @@ int data_fail;
>  int task_map_full;
>  int data_map_full;
>  
> +struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
> +void bpf_task_release(struct task_struct *p) __ksym;

These should have __weak and you need to check if it's NULL or not
before use to support ancient kernels.  If it's NULL then it should
reject owner callstack tracking.  Or you can check it in userspace
using vmlinux BTF and set lock_owner to false if it's not available.

Please take a look at check_slab_cache_iter() for example.

> +
>  static inline __u64 get_current_cgroup_id(void)
>  {
>  	struct task_struct *task;
> @@ -420,6 +425,27 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
>  	return pelem;
>  }
>  
> +static inline s32 get_owner_stack_id(u64 *stacktrace)
> +{
> +	s32 *id;
> +	static s32 id_gen = 1;
> +
> +	id = bpf_map_lookup_elem(&owner_stacks, stacktrace);
> +	if (id)
> +		return *id;
> +
> +	// FIXME: currently `a = __sync_fetch_and_add(...)` cause "Invalid usage of the XADD return
> +	// value" error in BPF program: https://github.com/llvm/llvm-project/issues/91888
> +	bpf_map_update_elem(&owner_stacks, stacktrace, &id_gen, BPF_NOEXIST);
> +	__sync_fetch_and_add(&id_gen, 1);

I'm afraid it doesn't guarantee a unique stack id.

I believe BPF has atomic instructions that can do ADD and FETCH.  I'm
not sure if it's a kernel or compiler version issue.  Have you tried
compare-and-exchange?

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
> @@ -437,6 +463,91 @@ int contention_begin(u64 *ctx)
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
> +		task = bpf_task_from_pid(owner_pid);
> +		if (task) {
> +			bpf_get_task_stack(task, buf, max_stack * sizeof(unsigned long), 0);
> +			bpf_task_release(task);
> +		}
> +
> +		otdata = bpf_map_lookup_elem(&owner_data, &pelem->lock);
> +		id = get_owner_stack_id(buf);
> +
> +		// Contention just happens, or corner case `lock` is owned by process not
> +		// `owner_pid`. For the corner case we treat it as unexpected internal error and
> +		// just ignore the precvious tracing record.

Typo precvious

It's unfortunate the comment style is mixed.  I'm not sure if we have a
strict rule for BPF code but at least we need to be consistent in a file.
Probably // is ok for a short comment at the end of line.  But please
use C-style block comments for multi-line messages.


> +		if (!otdata || otdata->pid != owner_pid) {
> +			struct owner_tracing_data first = {
> +				.pid = owner_pid,
> +				.timestamp = pelem->timestamp,
> +				.count = 1,
> +				.stack_id = id,
> +			};
> +			bpf_map_update_elem(&owner_data, &pelem->lock, &first, BPF_ANY);
> +		}
> +		// Contention is ongoing and new waiter joins.
> +		else {
> +			__sync_fetch_and_add(&otdata->count, 1);
> +
> +			// The owner is the same, but stacktrace might be changed. In this case we
> +			// store/update `owner_stat` based on current owner stack id.
> +			if (id != otdata->stack_id) {
> +				u64 duration = otdata->timestamp - pelem->timestamp;
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

This code block is repeating at least for 3 times.  Can you factor it
out as a function?

> +
> +				otdata->timestamp = pelem->timestamp;
> +				otdata->stack_id = id;
> +			}
> +		}
> +skip_owner_begin:
>  		pelem->stack_id = bpf_get_stackid(ctx, &stacks,
>  						  BPF_F_FAST_STACK_CMP | stack_skip);
>  		if (pelem->stack_id < 0)
> @@ -473,6 +584,7 @@ int contention_end(u64 *ctx)
>  	struct tstamp_data *pelem;
>  	struct contention_key key = {};
>  	struct contention_data *data;
> +	__u64 timestamp;
>  	__u64 duration;
>  	bool need_delete = false;
>  
> @@ -499,12 +611,133 @@ int contention_end(u64 *ctx)
>  			return 0;
>  		need_delete = true;
>  	}
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
> +		// Update `owner_stat`.
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
> +		// No contention is occurring, delete `lock` entry in `owner_data`.
> +		if (otdata->count <= 1)
> +			bpf_map_delete_elem(&owner_data, &pelem->lock);
> +		// Contention is still ongoing, with a new owner (current task). `owner_data`
> +		// should be updated accordingly.
> +		else {
> +			u32 i = 0;
> +			u64 *buf;
> +
> +			// FIXME: __sync_fetch_and_sub(&otdata->count, 1) causes compile error.
> +			otdata->count--;

What about __sync_fetch_and_add(..., -1) ?  It doesn't seem BPF atomic
operations have SUB.

https://docs.kernel.org/bpf/standardization/instruction-set.html#atomic-operations

> +
> +			buf = bpf_map_lookup_elem(&stack_buf, &i);
> +			if (!buf)
> +				goto skip_owner_end;
> +			for (i = 0; i < (u32)max_stack; i++)
> +				buf[i] = 0x0;
> +
> +			// ctx[1] has the return code of the lock function.

Why not adding 's32 ret = (s32)ctx[1]' ?

Thanks,
Namhyung


> +			// If ctx[1] is not 0, the current task terminates lock waiting without
> +			// acquiring it. Owner is not changed, but we still need to update the owner
> +			// stack.
> +			if (!ctx[1]) {
> +				s32 id = 0;
> +				struct task_struct *task = bpf_task_from_pid(otdata->pid);
> +
> +				if (task) {
> +					bpf_get_task_stack(task, buf,
> +							   max_stack * sizeof(unsigned long), 0);
> +					bpf_task_release(task);
> +				}
> +
> +				id = get_owner_stack_id(buf);
> +
> +				// If owner stack is changed, update `owner_data` and `owner_stat`
> +				// accordingly.
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
> +			// If ctx[1] is 0, then update tracinng data with the current task, which is
> +			// the new owner.
> +			else {
> +				otdata->pid = pid;
> +				otdata->timestamp = timestamp;
> +
> +				bpf_get_task_stack(bpf_get_current_task_btf(), buf,
> +						   max_stack * sizeof(unsigned long), 0);
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
> 2.48.1.262.g85cc9f2d1e-goog
> 

