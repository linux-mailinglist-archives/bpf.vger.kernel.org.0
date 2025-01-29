Return-Path: <bpf+bounces-50047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C097DA22383
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 19:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227EB163418
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8EC1E0084;
	Wed, 29 Jan 2025 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsvCLxOz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907012DD95;
	Wed, 29 Jan 2025 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738173665; cv=none; b=VS/JNwPE7ggWmn/FX1uuotJ3urdQ210Fl4R61qP+Hz5yz412bFHwD+xuxfR3/P09h7DQqShvPi3rVdeYwiRQcaQmFBbFDXJ+9mK5zhj+5IXq8z5pm33e1aP6q3voip6z/woIBan+hlTFCuOGu4yvbHy0o5vewhvgOQqcDYsFoKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738173665; c=relaxed/simple;
	bh=Qcdw4ofjllD9zMuI20QNMXAGhIHsA7eUDYQdOP02JNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0jEFcXn0nYVbYvN5QJnDYX4HoCgtceT6zhYVAVUysH0fOece/gsjQ/y1Vuw6/oD8+eMhBQuSsIsxSgenbijNuPH9L0q08pGbTlyoV/gQLcTqIKaGtq8ZlvE+g80JBOuVU7stjbSKz0gD1E3Xgamba5hLJru9c8sGzQbBtSnO28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsvCLxOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C419C4CED1;
	Wed, 29 Jan 2025 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738173665;
	bh=Qcdw4ofjllD9zMuI20QNMXAGhIHsA7eUDYQdOP02JNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsvCLxOzRnH318jy+SO8I8ph9ccEbry2Fd2tCBYXxYQEKeF7/7OrR92BimLkL0EaI
	 o3jYWFORRhy13Q9cyo/R31ZikaNdYYkLMqh5EzQy+G9BgNRGBp3tlbOHg/cnFeiwa2
	 8gGvIDaNVGI4lKSFz6VR29NdFGA+SUsTIe00HnxBYexRbTn8pNIH5iJwD7ZuaGkooY
	 u3jaTmixXDgjGGKn6D+nek44MGnUaWuyID38R3DWf1xunsDDwLlNxHTPOUOQnT0Mpl
	 DvfYx56EdcDz1WXdbsKTbvjp0+VlyubzzTZN5V3Kiba8//e2BzgwUU+bcwy3gmkATD
	 BjvtP1kprcl+g==
Date: Wed, 29 Jan 2025 10:01:03 -0800
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
Subject: Re: [PATCH v3 1/5] perf lock: Add bpf maps for owner stack tracing
Message-ID: <Z5ps3wb8lN_N5pCH@google.com>
References: <20250129001905.619859-1-ctshao@google.com>
 <20250129001905.619859-2-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250129001905.619859-2-ctshao@google.com>

On Tue, Jan 28, 2025 at 04:14:57PM -0800, Chun-Tse Shao wrote:
> Add a struct and few bpf maps in order to tracing owner stack.
> `struct owner_tracing_data`: Contains owner's pid, stack id, timestamp for
>   when the owner acquires lock, and the count of lock waiters.
> `stack_buf`: Percpu buffer for retrieving owner stacktrace.
> `owner_stacks`: For tracing owner stacktrace to customized owner stack id.
> `owner_data`: For tracing lock_address to `struct owner_tracing_data` in
>   bpf program.
> `owner_stat`: For reporting owner stacktrace in usermode.
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/util/bpf_lock_contention.c         | 16 +++++--
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 42 ++++++++++++++++---
>  tools/perf/util/bpf_skel/lock_data.h          |  7 ++++
>  3 files changed, 57 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index fc8666222399..795e2374facc 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -131,9 +131,19 @@ int lock_contention_prepare(struct lock_contention *con)
>  	else
>  		bpf_map__set_max_entries(skel->maps.task_data, 1);
>  
> -	if (con->save_callstack)
> -		bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
> -	else
> +	if (con->save_callstack) {
> +		bpf_map__set_max_entries(skel->maps.stacks,
> +					 con->map_nr_entries);

It can be on the same line as it used to be.


> +		if (con->owner) {
> +			bpf_map__set_value_size(skel->maps.stack_buf, con->max_stack * sizeof(u64));
> +			bpf_map__set_key_size(skel->maps.owner_stacks,
> +						con->max_stack * sizeof(u64));
> +			bpf_map__set_max_entries(skel->maps.owner_stacks, con->map_nr_entries);
> +			bpf_map__set_max_entries(skel->maps.owner_data, con->map_nr_entries);
> +			bpf_map__set_max_entries(skel->maps.owner_stat, con->map_nr_entries);
> +			skel->rodata->max_stack = con->max_stack;
> +		}
> +	} else

Please add parenthesis even for single line when the matching if block
has parenthesis.


>  		bpf_map__set_max_entries(skel->maps.stacks, 1);
>  
>  	if (target__has_cpu(target)) {
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 6533ea9b044c..b4961dd86222 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -19,13 +19,37 @@
>  #define LCB_F_PERCPU	(1U << 4)
>  #define LCB_F_MUTEX	(1U << 5)
>  
> -/* callstack storage  */
> + /* buffer for owner stacktrace */
>  struct {
> -	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>  	__uint(key_size, sizeof(__u32));
>  	__uint(value_size, sizeof(__u64));
> -	__uint(max_entries, MAX_ENTRIES);
> -} stacks SEC(".maps");
> +	__uint(max_entries, 1);
> +} stack_buf SEC(".maps");
> +
> +/* a map for tracing owner stacktrace to owner stack id */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(__u64)); // owner stacktrace
> +	__uint(value_size, sizeof(__u64)); // owner stack id
> +	__uint(max_entries, 1);
> +} owner_stacks SEC(".maps");
> +
> +/* a map for tracing lock address to owner data */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(__u64)); // lock address
> +	__uint(value_size, sizeof(struct owner_tracing_data));
> +	__uint(max_entries, 1);
> +} owner_data SEC(".maps");
> +
> +/* a map for contention_key (stores owner stack id) to contention data */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(struct contention_key));
> +	__uint(value_size, sizeof(struct contention_data));
> +	__uint(max_entries, 1);
> +} owner_stat SEC(".maps");
>  
>  /* maintain timestamp at the beginning of contention */
>  struct {
> @@ -43,6 +67,14 @@ struct {
>  	__uint(max_entries, 1);
>  } tstamp_cpu SEC(".maps");
>  
> +/* callstack storage  */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u64));
> +	__uint(max_entries, MAX_ENTRIES);
> +} stacks SEC(".maps");

Can you please keep this on top of the maps so that it can minimize the
diff?  I think it's better to move the new owner related stuff to
bottom.

> +
>  /* actual lock contention statistics */
>  struct {
>  	__uint(type, BPF_MAP_TYPE_HASH);
> @@ -143,6 +175,7 @@ const volatile int needs_callstack;
>  const volatile int stack_skip;
>  const volatile int lock_owner;
>  const volatile int use_cgroup_v2;
> +const volatile int max_stack;
>  
>  /* determine the key of lock stat */
>  const volatile int aggr_mode;
> @@ -466,7 +499,6 @@ int contention_end(u64 *ctx)
>  			return 0;
>  		need_delete = true;
>  	}
> -

Not needed.

Thanks,
Namhyung


>  	duration = bpf_ktime_get_ns() - pelem->timestamp;
>  	if ((__s64)duration < 0) {
>  		__sync_fetch_and_add(&time_fail, 1);
> diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
> index c15f734d7fc4..15f5743bd409 100644
> --- a/tools/perf/util/bpf_skel/lock_data.h
> +++ b/tools/perf/util/bpf_skel/lock_data.h
> @@ -3,6 +3,13 @@
>  #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
>  #define UTIL_BPF_SKEL_LOCK_DATA_H
>  
> +struct owner_tracing_data {
> +	u32 pid; // Who has the lock.
> +	u32 count; // How many waiters for this lock.
> +	u64 timestamp; // The time while the owner acquires lock and contention is going on.
> +	s32 stack_id; // Identifier for `owner_stat`, which stores as value in `owner_stacks`
> +};
> +
>  struct tstamp_data {
>  	u64 timestamp;
>  	u64 lock;
> -- 
> 2.48.1.262.g85cc9f2d1e-goog
> 

