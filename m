Return-Path: <bpf+bounces-48736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA527A0FF85
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 04:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21821882BB4
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 03:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A08D17543;
	Tue, 14 Jan 2025 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLL/sAfy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71759230D0D;
	Tue, 14 Jan 2025 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825719; cv=none; b=QIS2InpPIbjafnxnaDsgSH3Xy49RUz6gi1Mx1y5amBbP80yNwmqaowfjXY6gRELr0/01CU1tK+wBdqklBvuujeNm/iby0ZyOAoSYg2u/QE0PhSMnMVMXKeQeRf1pqJDm5UMni96VNZbAIntJCwsA8Jey/9c4fMJxzNYMf/kFiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825719; c=relaxed/simple;
	bh=VGrG1f3CweZ0OKSLkJYrooWyaLGSwh39l7YO+KbKyfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBkOSKxGjGDG1HDP/g+49Z81rDYWVOhFN6dgPX0GKkXPwEJo13cI7Da8NPz5ouJUVY0ZAMH6kxj0IvdPi/BWZxL7+8OmeZ6k8rPoXjRwMBHwJOVm/DabkYcHv7m7CCi01fcwGDr58mrskUGOO9A5rWdHxwYQrsuT7Ry+EH4g6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLL/sAfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791C2C4CEE1;
	Tue, 14 Jan 2025 03:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736825719;
	bh=VGrG1f3CweZ0OKSLkJYrooWyaLGSwh39l7YO+KbKyfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLL/sAfyUjn57hKVJEuR16UsuWLUEvHWf6SdMj/REKxDsvBAM2EyudSvcgt9VM+AY
	 PfuzaoVf5sStji0FeRjbfa4nzad9YJaVOrvBzTnjE0/HkaMw7CgTaWjq4wubRhLsLz
	 IDQzqx2ydfjvjFe98RFejGmd42LGsEFbUuMU5vyiUyDLd9jD217QJ76A5UfQmnou6p
	 za5OQHj2sNYUAoR4CIa8nOsvPxZXDVWMVL5gdc8oN3ACSZucY3WQEJzGMzsVcfDYNJ
	 MBg6InGB60ygLLKPDqNFh9EwzwVLb+eHwbOhHLgi54CG2Ajzv4ob/v1HFhiGPyuxSH
	 yeYpRJQp4BAyQ==
Date: Mon, 13 Jan 2025 19:35:17 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/4] perf lock: Retrieve owner callstack in bpf program
Message-ID: <Z4XbdVKyXgjUqZcP@google.com>
References: <20250113052220.2105645-1-ctshao@google.com>
 <20250113052220.2105645-3-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113052220.2105645-3-ctshao@google.com>

On Sun, Jan 12, 2025 at 09:20:15PM -0800, Chun-Tse Shao wrote:
> Tracing owner callstack in `contention_begin()` and `contention_end()`,
> and storing in `owner_lock_stat` bpf map.
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 152 +++++++++++++++++-
>  1 file changed, 151 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 05da19fdab23..3f47fbfa237c 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -7,6 +7,7 @@
>  #include <asm-generic/errno-base.h>
>  
>  #include "lock_data.h"
> +#include <time.h>
>  
>  /* for collect_lock_syms().  4096 was rejected by the verifier */
>  #define MAX_CPUS  1024
> @@ -178,6 +179,9 @@ int data_fail;
>  int task_map_full;
>  int data_map_full;
>  
> +struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
> +void bpf_task_release(struct task_struct *p) __ksym;

To support old (ancient?) kernels, you can declare them as __weak and
check if one of them is defined and ignore owner stacks on them.  Also
you can check them in user space and turn off the option before loading.

> +
>  static inline __u64 get_current_cgroup_id(void)
>  {
>  	struct task_struct *task;
> @@ -407,6 +411,60 @@ int contention_begin(u64 *ctx)
>  	pelem->flags = (__u32)ctx[1];
>  
>  	if (needs_callstack) {
> +		u32 i = 0;
> +		int owner_pid;
> +		unsigned long *entries;
> +		struct task_struct *task;
> +		cotd *data;
> +
> +		if (!lock_owner)
> +			goto contention_begin_skip_owner_callstack;

Can be it 'skip_owner'?

> +
> +		task = get_lock_owner(pelem->lock, pelem->flags);
> +		if (!task)
> +			goto contention_begin_skip_owner_callstack;
> +
> +		owner_pid = BPF_CORE_READ(task, pid);
> +
> +		entries = bpf_map_lookup_elem(&owner_stacks_entries, &i);
> +		if (!entries)
> +			goto contention_begin_skip_owner_callstack;
> +		for (i = 0; i < max_stack; i++)
> +			entries[i] = 0x0;
> +
> +		task = bpf_task_from_pid(owner_pid);
> +		if (task) {
> +			bpf_get_task_stack(task, entries,
> +					   max_stack * sizeof(unsigned long),
> +					   0);
> +			bpf_task_release(task);
> +		}
> +
> +		data = bpf_map_lookup_elem(&contention_owner_tracing,
> +					   &(pelem->lock));

No need for parenthesis.

> +
> +		// Contention just happens, or corner case `lock` is owned by
> +		// process not `owner_pid`.
> +		if (!data || data->pid != owner_pid) {
> +			cotd first = {
> +				.pid = owner_pid,
> +				.timestamp = pelem->timestamp,
> +				.count = 1,
> +			};
> +			bpf_map_update_elem(&contention_owner_tracing,
> +					    &(pelem->lock), &first, BPF_ANY);
> +			bpf_map_update_elem(&contention_owner_stacks,
> +					    &(pelem->lock), entries, BPF_ANY);

Hmm.. it just discard the old owner data if it comes from a new owner?
Why not save the data into the result for the old lock/callstack?


> +		}
> +		// Contention is going on and new waiter joins.
> +		else {
> +			__sync_fetch_and_add(&data->count, 1);
> +			// TODO: Since for owner the callstack would change at
> +			// different time, We should check and report if the
> +			// callstack is different with the recorded one in
> +			// `contention_owner_stacks`.
> +		}
> +contention_begin_skip_owner_callstack:
>  		pelem->stack_id = bpf_get_stackid(ctx, &stacks,
>  						  BPF_F_FAST_STACK_CMP | stack_skip);
>  		if (pelem->stack_id < 0)
> @@ -443,6 +501,7 @@ int contention_end(u64 *ctx)
>  	struct tstamp_data *pelem;
>  	struct contention_key key = {};
>  	struct contention_data *data;
> +	__u64 timestamp;
>  	__u64 duration;
>  	bool need_delete = false;
>  
> @@ -469,12 +528,103 @@ int contention_end(u64 *ctx)
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
> +		u64 owner_contention_time;
> +		unsigned long *owner_stack;
> +		struct contention_data *cdata;
> +		cotd *otdata;
> +
> +		otdata = bpf_map_lookup_elem(&contention_owner_tracing,
> +					     &(pelem->lock));
> +		owner_stack = bpf_map_lookup_elem(&contention_owner_stacks,
> +						  &(pelem->lock));
> +		if (!otdata || !owner_stack)
> +			goto contention_end_skip_owner_callstack;
> +
> +		owner_contention_time = timestamp - otdata->timestamp;
> +
> +		// Update `owner_lock_stat` if `owner_stack` is
> +		// available.
> +		if (owner_stack[0] != 0x0) {
> +			cdata = bpf_map_lookup_elem(&owner_lock_stat,
> +						    owner_stack);
> +			if (!cdata) {
> +				struct contention_data first = {
> +					.total_time = owner_contention_time,
> +					.max_time = owner_contention_time,
> +					.min_time = owner_contention_time,
> +					.count = 1,
> +					.flags = pelem->flags,
> +				};
> +				bpf_map_update_elem(&owner_lock_stat,
> +						    owner_stack, &first,
> +						    BPF_ANY);
> +			} else {
> +				__sync_fetch_and_add(&cdata->total_time,
> +						     owner_contention_time);
> +				__sync_fetch_and_add(&cdata->count, 1);
> +
> +				/* FIXME: need atomic operations */
> +				if (cdata->max_time < owner_contention_time)
> +					cdata->max_time = owner_contention_time;
> +				if (cdata->min_time > owner_contention_time)
> +					cdata->min_time = owner_contention_time;
> +			}
> +		}
> +
> +		//  No contention is going on, delete `lock` in
> +		//  `contention_owner_tracing` and
> +		//  `contention_owner_stacks`
> +		if (otdata->count <= 1) {
> +			bpf_map_delete_elem(&contention_owner_tracing,
> +					    &(pelem->lock));
> +			bpf_map_delete_elem(&contention_owner_stacks,
> +					    &(pelem->lock));
> +		}
> +		// Contention is still going on, with a new owner
> +		// (current task). `otdata` should be updated accordingly.
> +		else {
> +			(otdata->count)--;

No need for parenthesis, and it needs to be atomic dec.

> +
> +			// If ctx[1] is not 0, the current task terminates lock
> +			// waiting without acquiring it. Owner is not changed.

Please add a comment that ctx[1] has the return code of the lock
function.  Maybe it's better to use a local variable.

Also I think you need to say about the normal case too.  Returing 0
means the waiter now gets the lock and becomes a new owner.  So it needs
to update the owner information.


> +			if (ctx[1] == 0) {
> +				u32 i = 0;
> +				unsigned long *entries = bpf_map_lookup_elem(
> +					&owner_stacks_entries, &i);
> +				if (entries) {
> +					for (i = 0; i < (u32)max_stack; i++)
> +						entries[i] = 0x0;
> +
> +					bpf_get_task_stack(
> +						bpf_get_current_task_btf(),

Same as bpf_get_stack(), right?

> +						entries,
> +						max_stack *
> +							sizeof(unsigned long),
> +						0);
> +					bpf_map_update_elem(
> +						&contention_owner_stacks,
> +						&(pelem->lock), entries,
> +						BPF_ANY);

Please factor out the code if it indents too much.  Or you can use goto
or something to reduce the indentation level.

  if (ret != 0)
  	goto skip_update;

  ...

  if (entries == NULL)
  	goto skip_stack;

  ...

Thanks,
Namhyung

> +				}
> +
> +				otdata->pid = pid;
> +				otdata->timestamp = timestamp;
> +			}
> +
> +			bpf_map_update_elem(&contention_owner_tracing,
> +					    &(pelem->lock), otdata, BPF_ANY);
> +		}
> +	}
> +contention_end_skip_owner_callstack:
> +
>  	switch (aggr_mode) {
>  	case LOCK_AGGR_CALLER:
>  		key.stack_id = pelem->stack_id;
> -- 
> 2.47.1.688.g23fc6f90ad-goog
> 

