Return-Path: <bpf+bounces-55797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AD3A86838
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 23:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28868C050F
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 21:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ABA29AB1F;
	Fri, 11 Apr 2025 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFM7eYgZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A0828FFE2;
	Fri, 11 Apr 2025 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406760; cv=none; b=P0cXZ2prRh8OcA6j3v5rsip78xYPlm9Nb8nvsyBXbsakmUlT/RGLTjGdTP2najsQPAjMYmY9C2THGKPCIOk0yR1Os2OXLGNBPOJUYmX7evXVRFQ3yONa750elH14tLO67ZzqqaGXbLKpcY3oUng0mrsk/AaPGoxUMARea7/FaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406760; c=relaxed/simple;
	bh=8m+WJJz2XY3Zvi9305u9X+LU8unyYAC2M1ysvtMLaQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6FGyXIy0EWqdfDmqIDuRsilqVPBkMOqXnghjknSm/iU/4xwazHmNqcNego42AxIAxTjDkdRmXkF1dvMAXXCctcA6g8ls2n/bEbfl5/Ke48AoIBUIkjyYpI2+BFUZ7TD4L+VUN/v3bA9EtdDeH06yRSnnJq9AcvwNEJEnBLmEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFM7eYgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A63CC4CEE2;
	Fri, 11 Apr 2025 21:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744406759;
	bh=8m+WJJz2XY3Zvi9305u9X+LU8unyYAC2M1ysvtMLaQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFM7eYgZNFXpcTcnpmIHcAcIicoIqZan29nEzSpf1j9llHlGD0/fY4QSHOkRsrBj2
	 Y3wYcVeZNXURZX6vskgcDUg67HsShwd0Er1CtprSW1CRCzJQJDjgwHDZK9F6ClbN5N
	 7Jrj12EhIjqo8JJDZW4hm6Ri759PG1TeGPxfPbP71/kR2Nw38dj2CM9AfE5tRNiqeJ
	 gnJ4tmIFfiimdgHQOZJW7BeSPjGodyJcRkpgy0wdK75XdoaxdK/OM12cwUwBmgw+/J
	 JTkAoAI00ADM3ZEIQ20lMT/WTc03BlCqT/HY+TNcwJTP+b61DY+mzvI//KB+Ydu3J7
	 Ko+ovCFD2fX5g==
Date: Fri, 11 Apr 2025 14:25:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, nick.forrington@arm.com,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1] perf lock: Add --duration-filter option
Message-ID: <Z_mI5UDV9ku9-1bG@z2>
References: <20250411052548.2089332-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250411052548.2089332-1-ctshao@google.com>

Hello,

On Thu, Apr 10, 2025 at 10:24:19PM -0700, Chun-Tse Shao wrote:
> This patch introduces the `--duration-filter` option, allows users to
> exclude lock contention samples with durations shorter than the
> specified filter value.
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-lock.txt        |  3 +++
>  tools/perf/builtin-lock.c                     |  3 +++
>  tools/perf/util/bpf_lock_contention.c         | 22 ++++++++++++++-----
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  7 ++++++
>  tools/perf/util/lock-contention.h             |  1 +
>  5 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index 859dc11a7372..1f57f5fc59e0 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -216,6 +216,9 @@ CONTENTION OPTIONS
>  --cgroup-filter=<value>::
>  	Show lock contention only in the given cgroups (comma separated list).
>  
> +--duration-filter=<value>::
> +  Filter out lock contention samples which durations less than the specified
> +  value (default: 0). The unit is nanoseconds (ns).

Please follow the style like indentation and put a blank line after
this.  Also you need to mention that it only works with BPF.  I guess
you can add non-BPF support as well.

I'm not sure if nsec is a good choice since users may be interested in
usec or msec level contentions more.  Maybe we can add unit to the
argument or default to usec and use 'double' type.

>  
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 05e7bc30488a..d7b454e712bf 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -60,6 +60,7 @@ static int stack_skip = CONTENTION_STACK_SKIP;
>  static int print_nr_entries = INT_MAX / 2;
>  static const char *output_name = NULL;
>  static FILE *lock_output;
> +static int duration_filter;
>  
>  static struct lock_filter filters;
>  
> @@ -2004,6 +2005,7 @@ static int __cmd_contention(int argc, const char **argv)
>  		.save_callstack = needs_callstack(),
>  		.owner = show_lock_owner,
>  		.cgroups = RB_ROOT,
> +		.duration_filter = duration_filter,
>  	};
>  
>  	lockhash_table = calloc(LOCKHASH_SIZE, sizeof(*lockhash_table));
> @@ -2580,6 +2582,7 @@ int cmd_lock(int argc, const char **argv)
>  	OPT_BOOLEAN(0, "lock-cgroup", &show_lock_cgroups, "show lock stats by cgroup"),
>  	OPT_CALLBACK('G', "cgroup-filter", NULL, "CGROUPS",
>  		     "Filter specific cgroups", parse_cgroup_filter),
> +	OPT_INTEGER(0, "duration-filter", &duration_filter, "Filter samples by duration"),
>  	OPT_PARENT(lock_options)
>  	};
>  
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index 5af8f6d1bc95..7b982a3e4000 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -203,6 +203,7 @@ int lock_contention_prepare(struct lock_contention *con)
>  	skel->rodata->aggr_mode = con->aggr_mode;
>  	skel->rodata->needs_callstack = con->save_callstack;
>  	skel->rodata->lock_owner = con->owner;
> +	skel->rodata->duration_filter = con->duration_filter;
>  
>  	if (con->aggr_mode == LOCK_AGGR_CGROUP || con->filters->nr_cgrps) {
>  		if (cgroup_is_v2("perf_event"))
> @@ -568,12 +569,23 @@ struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
>  	if (stack_trace == NULL)
>  		goto out_err;
>  
> -	if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
> -		goto out_err;
> +	/*
> +	 * `owner_stacks` contains stacks recorded in `contention_begin()` that either never reached
> +	 * `contention_end()` or were filtered out and not stored in `owner_stat`. We skip if we
> +	 * cannot find corresponding `contention_data` in `owner_stat` with the given `stack_id`.
> +	 */
> +	while (true) {
> +		if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
> +			goto out_err;
> +
> +		bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
> +		ckey.stack_id = stack_id;
> +		if (bpf_map_lookup_elem(stat_fd, &ckey, &cdata) == 0)
> +			break;
>  
> -	bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
> -	ckey.stack_id = stack_id;
> -	bpf_map_lookup_elem(stat_fd, &ckey, &cdata);
> +		/* Can not find `contention_data`, delete and skip. */
> +		bpf_map_delete_elem(stacks_fd, stack_trace);
> +	}

I think we can consider moving the callstack saving code to the
contention-end when the duration filter is used in order to reduce
overheads for to-be-filtered short contentions.

>  
>  	st = zalloc(sizeof(struct lock_stat));
>  	if (!st)
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 69be7a4234e0..26ddc0f21378 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -176,6 +176,7 @@ const volatile int stack_skip;
>  const volatile int lock_owner;
>  const volatile int use_cgroup_v2;
>  const volatile int max_stack;
> +const volatile int duration_filter;

I think it should be u64 to save potentionally large durations.

>  
>  /* determine the key of lock stat */
>  const volatile int aggr_mode;
> @@ -457,6 +458,9 @@ static inline void update_contention_data(struct contention_data *data, u64 dura
>  
>  static inline void update_owner_stat(u32 id, u64 duration, u32 flags)
>  {
> +	if (duration < duration_filter)

What if the duration_filter is 0?  I'm not sure if BPF verifier can
optimize out the whole conditional block if it's 0.

Thanks,
Namhyung


> +		return;
> +
>  	struct contention_key key = {
>  		.stack_id = id,
>  		.pid = 0,
> @@ -707,6 +711,9 @@ int contention_end(u64 *ctx)
>  		}
>  	}
>  skip_owner:
> +	if (duration < duration_filter)
> +		goto out;
> +
>  	switch (aggr_mode) {
>  	case LOCK_AGGR_CALLER:
>  		key.stack_id = pelem->stack_id;
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index b5d916aa49df..97042e6d8b10 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -149,6 +149,7 @@ struct lock_contention {
>  	int owner;
>  	int nr_filtered;
>  	bool save_callstack;
> +	int duration_filter;
>  };
>  
>  struct option;
> -- 
> 2.49.0.604.gff1f9ca942-goog
> 

