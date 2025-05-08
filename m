Return-Path: <bpf+bounces-57769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D51EAAFD96
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 16:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39286B22B36
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3092D278167;
	Thu,  8 May 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNm2sxiP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAEA2777F5;
	Thu,  8 May 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715562; cv=none; b=iGpIKsspEi5Y+0WOideP7xddwH2v8vTe4mZ2QZyr6Zg1x6FnWCUjgJIhuFA2Wf2jYPo+HQ/AeGvmOaPdLaGiVzfyc0Qu5Ht7haJQlO2I1hFYzGzjdE0Utivu78NNycg44URbtXcwby95xXNljWIIKCd6PRL/N0nNnC2meNLVcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715562; c=relaxed/simple;
	bh=I0FoidB5YlrqQxE4Gxgl146ZkM3RpbKYRomqdP6c5P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4q3CrPNw1HhuHNU4FI7uJPGKHR3Cbx7X9/n0fh3xDr5PoJn1P2DC4TTN5k1AmReYYfJWm1Hd+fjovfUpvKZDEKCUk1TvQ17yPq8AUa14y9ThydVRL2ZF2UZylhGNj6Vl1ETQxOnb7J3cNd6QGCja8HbpjIzlh8kGA1S8KT1lng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNm2sxiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E566C4CEE7;
	Thu,  8 May 2025 14:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746715562;
	bh=I0FoidB5YlrqQxE4Gxgl146ZkM3RpbKYRomqdP6c5P8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNm2sxiP9Jgt0vIOqpAiv1o4jtus7+Gb+yQkgpwpHlOK3Yt96dt9u04Vh8ccC5UED
	 qQrrKp1g2Yr084KUQAs2NJ0LmTHb1sOsguE0o9B37OUG5uEUfsaF1qMMstB73LGV/y
	 Ynk4ZvYQgbMm2HneAwOXH/gGK4klPp4UxphI/NBzHSEq5OssYlmhNvuLUX/hytKzKI
	 gzyYc1b9RqhjS2OUr5bQxq0q8L66/QvZOeL4QyBNflqzfKLJZtBAV+d6+woSmLqC6v
	 CjZ9lchwG7kIyt6KFnjA8S6R7FcTqBEVtZRPMZJ+M529ryB3RsWCjnlGe7bYflI3wO
	 HH9NlxuwH9JwQ==
Date: Thu, 8 May 2025 11:45:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [RFC/PATCH] perf lock contention: Add -J/--inject-delay option
Message-ID: <aBzDpi25-LBgAjEj@x1>
References: <20250225075929.900995-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225075929.900995-1-namhyung@kernel.org>

On Mon, Feb 24, 2025 at 11:59:29PM -0800, Namhyung Kim wrote:
> This is to slow down lock acquistion (on contention locks) deliberately.
> A possible use case is to estimate impact on application performance by
> optimization of kernel locking behavior.  By delaying the lock it can
> simulate the worse condition as a control group, and then compare with
> the current behavior as a optimized condition.

So this looks useful, I guess we can proceed and merge it?

- Arnaldo
 
> The syntax is 'time@function' and the time can have unit suffix like
> "us" and "ms".  For example, I ran a simple test like below.
> 
>   $ sudo perf lock con -abl -L tasklist_lock -- \
>     sh -c 'for i in $(seq 1000); do sleep 1 & done; wait'
>    contended   total wait     max wait     avg wait            address   symbol
> 
>           92      1.18 ms    199.54 us     12.79 us   ffffffff8a806080   tasklist_lock (rwlock)
> 
> The contention count was 92 and the average wait time was around 10 us.
> But if I add 100 usec of delay to the tasklist_lock,
> 
>   $ sudo perf lock con -abl -L tasklist_lock -J 100us@tasklist_lock -- \
>     sh -c 'for i in $(seq 1000); do sleep 1 & done; wait'
>    contended   total wait     max wait     avg wait            address   symbol
> 
>          190     15.67 ms    230.10 us     82.46 us   ffffffff8a806080   tasklist_lock (rwlock)
> 
> The contention count increased and the average wait time was up closed
> to 100 usec.  If I increase the delay even more,
> 
>   $ sudo perf lock con -abl -L tasklist_lock -J 1ms@tasklist_lock -- \
>     sh -c 'for i in $(seq 1000); do sleep 1 & done; wait'
>    contended   total wait     max wait     avg wait            address   symbol
> 
>         1002      2.80 s       3.01 ms      2.80 ms   ffffffff8a806080   tasklist_lock (rwlock)
> 
> Now every sleep process had contention and the wait time was more than 1
> msec.  This is on my 4 CPU laptop so I guess one CPU has the lock while
> other 3 are waiting for it mostly.
> 
> For simplicity, it only supports global locks for now.
> 
> Suggested-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-lock.txt        | 11 +++
>  tools/perf/builtin-lock.c                     | 74 +++++++++++++++++++
>  tools/perf/util/bpf_lock_contention.c         | 28 +++++++
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 43 +++++++++++
>  tools/perf/util/lock-contention.h             |  8 ++
>  5 files changed, 164 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index d3793054f7d35626..151fc837587b216e 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -215,6 +215,17 @@ CONTENTION OPTIONS
>  --cgroup-filter=<value>::
>  	Show lock contention only in the given cgroups (comma separated list).
>  
> +-J::
> +--inject-delay=<time@function>::
> +	Add delays to the given lock.  It's added to the contention-end part so
> +	that the (new) owner of the lock will be delayed.  But by slowing down
> +	the owner, the waiters will also be delayed as well.  This is working
> +	only with -b/--use-bpf.
> +
> +	The 'time' is specified in nsec but it can have a unit suffix.  Available
> +	units are "ms" and "us".  Note that it will busy-wait after it gets the
> +	lock.  Please use it at your own risk.
> +
>  
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 5d405cd8e696d21b..3ef452d5d9f5679d 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -62,6 +62,8 @@ static const char *output_name = NULL;
>  static FILE *lock_output;
>  
>  static struct lock_filter filters;
> +static struct lock_delay *delays;
> +static int nr_delays;
>  
>  static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
>  
> @@ -1971,6 +1973,8 @@ static int __cmd_contention(int argc, const char **argv)
>  		.max_stack = max_stack_depth,
>  		.stack_skip = stack_skip,
>  		.filters = &filters,
> +		.delays = delays,
> +		.nr_delays = nr_delays,
>  		.save_callstack = needs_callstack(),
>  		.owner = show_lock_owner,
>  		.cgroups = RB_ROOT,
> @@ -2474,6 +2478,74 @@ static int parse_cgroup_filter(const struct option *opt __maybe_unused, const ch
>  	return ret;
>  }
>  
> +static bool add_lock_delay(char *spec)
> +{
> +	char *at, *pos;
> +	struct lock_delay *tmp;
> +	unsigned long duration;
> +
> +	at = strchr(spec, '@');
> +	if (at == NULL) {
> +		pr_err("lock delay should have '@' sign: %s\n", spec);
> +		return false;
> +	}
> +	if (at == spec) {
> +		pr_err("lock delay should have time before '@': %s\n", spec);
> +		return false;
> +	}
> +
> +	*at = '\0';
> +	duration = strtoul(spec, &pos, 0);
> +	if (!strcmp(pos, "ns"))
> +		duration *= 1;
> +	else if (!strcmp(pos, "us"))
> +		duration *= 1000;
> +	else if (!strcmp(pos, "ms"))
> +		duration *= 1000 * 1000;
> +	else if (*pos) {
> +		pr_err("invalid delay time: %s@%s\n", spec, at + 1);
> +		return false;
> +	}
> +
> +	tmp = realloc(delays, (nr_delays + 1) * sizeof(*delays));
> +	if (tmp == NULL) {
> +		pr_err("Memory allocation failure\n");
> +		return false;
> +	}
> +	delays = tmp;
> +
> +	delays[nr_delays].sym = strdup(at + 1);
> +	if (delays[nr_delays].sym == NULL) {
> +		pr_err("Memory allocation failure\n");
> +		return false;
> +	}
> +	delays[nr_delays].time = duration;
> +
> +	nr_delays++;
> +	return true;
> +}
> +
> +static int parse_lock_delay(const struct option *opt __maybe_unused, const char *str,
> +			    int unset __maybe_unused)
> +{
> +	char *s, *tmp, *tok;
> +	int ret = 0;
> +
> +	s = strdup(str);
> +	if (s == NULL)
> +		return -1;
> +
> +	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
> +		if (!add_lock_delay(tok)) {
> +			ret = -1;
> +			break;
> +		}
> +	}
> +
> +	free(s);
> +	return ret;
> +}
> +
>  int cmd_lock(int argc, const char **argv)
>  {
>  	const struct option lock_options[] = {
> @@ -2550,6 +2622,8 @@ int cmd_lock(int argc, const char **argv)
>  	OPT_BOOLEAN(0, "lock-cgroup", &show_lock_cgroups, "show lock stats by cgroup"),
>  	OPT_CALLBACK('G', "cgroup-filter", NULL, "CGROUPS",
>  		     "Filter specific cgroups", parse_cgroup_filter),
> +	OPT_CALLBACK('J', "inject-delay", NULL, "TIME@FUNC",
> +		     "Inject delays to specific locks", parse_lock_delay),
>  	OPT_PARENT(lock_options)
>  	};
>  
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index fc8666222399c995..99b64f303e761cbc 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -183,6 +183,27 @@ int lock_contention_prepare(struct lock_contention *con)
>  		skel->rodata->has_addr = 1;
>  	}
>  
> +	/* resolve lock name in delays */
> +	if (con->nr_delays) {
> +		struct symbol *sym;
> +		struct map *kmap;
> +
> +		for (i = 0; i < con->nr_delays; i++) {
> +			sym = machine__find_kernel_symbol_by_name(con->machine,
> +								  con->delays[i].sym,
> +								  &kmap);
> +			if (sym == NULL) {
> +				pr_warning("ignore unknown symbol: %s\n",
> +					   con->delays[i].sym);
> +				continue;
> +			}
> +
> +			con->delays[i].addr = map__unmap_ip(kmap, sym->start);
> +		}
> +		skel->rodata->lock_delay = 1;
> +		bpf_map__set_max_entries(skel->maps.lock_delays, con->nr_delays);
> +	}
> +
>  	bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
>  	bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
>  	bpf_map__set_max_entries(skel->maps.type_filter, ntypes);
> @@ -272,6 +293,13 @@ int lock_contention_prepare(struct lock_contention *con)
>  			bpf_map_update_elem(fd, &con->filters->cgrps[i], &val, BPF_ANY);
>  	}
>  
> +	if (con->nr_delays) {
> +		fd = bpf_map__fd(skel->maps.lock_delays);
> +
> +		for (i = 0; i < con->nr_delays; i++)
> +			bpf_map_update_elem(fd, &con->delays[i].addr, &con->delays[i].time, BPF_ANY);
> +	}
> +
>  	if (con->aggr_mode == LOCK_AGGR_CGROUP)
>  		read_all_cgroups(&con->cgroups);
>  
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 6533ea9b044c71d1..0ac9ae2f1711a129 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -11,6 +11,9 @@
>  /* for collect_lock_syms().  4096 was rejected by the verifier */
>  #define MAX_CPUS  1024
>  
> +/* for do_lock_delay().  Arbitrarily set to 1 million. */
> +#define MAX_LOOP  (1U << 20)
> +
>  /* lock contention flags from include/trace/events/lock.h */
>  #define LCB_F_SPIN	(1U << 0)
>  #define LCB_F_READ	(1U << 1)
> @@ -114,6 +117,13 @@ struct {
>  	__uint(max_entries, 1);
>  } slab_caches SEC(".maps");
>  
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(__u64));
> +	__uint(value_size, sizeof(__u64));
> +	__uint(max_entries, 1);
> +} lock_delays SEC(".maps");
> +
>  struct rw_semaphore___old {
>  	struct task_struct *owner;
>  } __attribute__((preserve_access_index));
> @@ -143,6 +153,7 @@ const volatile int needs_callstack;
>  const volatile int stack_skip;
>  const volatile int lock_owner;
>  const volatile int use_cgroup_v2;
> +const volatile int lock_delay;
>  
>  /* determine the key of lock stat */
>  const volatile int aggr_mode;
> @@ -348,6 +359,35 @@ static inline __u32 check_lock_type(__u64 lock, __u32 flags)
>  	return 0;
>  }
>  
> +static inline long delay_callback(__u64 idx, void *arg)
> +{
> +	__u64 target = *(__u64 *)arg;
> +
> +	if (target <= bpf_ktime_get_ns())
> +		return 1;
> +
> +	/* just to kill time */
> +	(void)bpf_get_prandom_u32();
> +
> +	return 0;
> +}
> +
> +static inline void do_lock_delay(__u64 duration)
> +{
> +	__u64 target = bpf_ktime_get_ns() + duration;
> +
> +	bpf_loop(MAX_LOOP, delay_callback, &target, /*flags=*/0);
> +}
> +
> +static inline void check_lock_delay(__u64 lock)
> +{
> +	__u64 *delay;
> +
> +	delay = bpf_map_lookup_elem(&lock_delays, &lock);
> +	if (delay)
> +		do_lock_delay(*delay);
> +}
> +
>  static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
>  {
>  	__u32 pid;
> @@ -566,6 +606,9 @@ int contention_end(u64 *ctx)
>  		data->min_time = duration;
>  
>  out:
> +	if (lock_delay)
> +		check_lock_delay(pelem->lock);
> +
>  	pelem->lock = 0;
>  	if (need_delete)
>  		bpf_map_delete_elem(&tstamp, &pid);
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index a09f7fe877df8184..12f6cb789ada1bc7 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -18,6 +18,12 @@ struct lock_filter {
>  	char			**slabs;
>  };
>  
> +struct lock_delay {
> +	char			*sym;
> +	unsigned long		addr;
> +	unsigned long		time;
> +};
> +
>  struct lock_stat {
>  	struct hlist_node	hash_entry;
>  	struct rb_node		rb;		/* used for sorting */
> @@ -140,6 +146,7 @@ struct lock_contention {
>  	struct machine *machine;
>  	struct hlist_head *result;
>  	struct lock_filter *filters;
> +	struct lock_delay *delays;
>  	struct lock_contention_fails fails;
>  	struct rb_root cgroups;
>  	unsigned long map_nr_entries;
> @@ -148,6 +155,7 @@ struct lock_contention {
>  	int aggr_mode;
>  	int owner;
>  	int nr_filtered;
> +	int nr_delays;
>  	bool save_callstack;
>  };
>  
> -- 
> 2.48.1.658.g4767266eb4-goog

