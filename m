Return-Path: <bpf+bounces-52316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112EA41513
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 07:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DA216DCC3
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 06:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017DA1C6FE5;
	Mon, 24 Feb 2025 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo9R81eA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7043728DB3;
	Mon, 24 Feb 2025 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377261; cv=none; b=qRRznJzKs37M3bypa3tLUsk15EFjbIVO31Z7DCUWHzfjtR9LI+uGzZ9jPIO0yzxZ/sTz/HQSZeIGD+fGpAOMxWhrqrKieHqnkmkeK0RRda1+pjQsrGm6wTYfw3QaSy7D3BuKWPwA/n2E6k1qNUSRQajkNz6WJaK3dKSX1OQTnA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377261; c=relaxed/simple;
	bh=Sqrj7NwRWuy/rG7PR36Rt4tX9YwItq1zgtEC5MSZkoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KveYjuPvzd0pqpjTi5CB3md/sPCLvrFsUvmPbEqqXjN/MujyIxqu5J+dvzpBf9UPK3dQ/j5xQirRNEvSyx0LUBf7NqAHVdnpYviGxm4xjxQ8Cc8J4yCZoNJjTtITN9/Lg+j5jiuyTGmLZ7m+KZXabY9pezJJnP5zP7gBq86UzwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo9R81eA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BA5C4CED6;
	Mon, 24 Feb 2025 06:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740377260;
	bh=Sqrj7NwRWuy/rG7PR36Rt4tX9YwItq1zgtEC5MSZkoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jo9R81eAOmURkxLAByqZ1v1Z7vbPKRFIBp7V7DN8sgUm3lgmpWfPBEVjYI6iR3xgG
	 EfNOqF0JZt5IvNF1+xQ8qfP0rDxMf/JGVI1iY0iw+83wxWuKRyoJYEpv00/4gM62WP
	 mhCZZi0k6s6Z+1kgMYdshlE3uaRMmU3Ez0l9JQAQmsNTTwzza2aUSj/LZF6t+u3+s6
	 Tmc1hg4IaIHynC2TyAfJWO0+lAQP6oFO4SHffNipKg0w3ySyACc6Xqp+KG5tDFEE0j
	 eVPqnxQSONpDEydEo/YL70O4+m2aDvbH42kj6WpI0ZRuyNZ8521ZVOVlX9tneBoiHu
	 HzPG+fyTTzQuQ==
Date: Sun, 23 Feb 2025 22:07:36 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, nick.forrington@arm.com,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v6 4/4] perf lock: Report owner stack in usermode
Message-ID: <Z7wMqNUPbFoJA4RR@google.com>
References: <20250219214400.3317548-1-ctshao@google.com>
 <20250219214400.3317548-5-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219214400.3317548-5-ctshao@google.com>

Hello,

On Wed, Feb 19, 2025 at 01:40:03PM -0800, Chun-Tse Shao wrote:
> This patch parses `owner_lock_stat` into a RB tree, enabling ordered
> reporting of owner lock statistics with stack traces. It also updates
> the documentation for the `-o` option in contention mode, decouples `-o`
> from `-t`, and issues a warning to inform users about the new behavior
> of `-ov`.
> 
> Example output:
>   $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex-spin -E3 perf bench sched pipe
>   ...
>    contended   total wait     max wait     avg wait         type   caller
> 
>          171      1.55 ms     20.26 us      9.06 us        mutex   pipe_read+0x57
>                           0xffffffffac6318e7  pipe_read+0x57
>                           0xffffffffac623862  vfs_read+0x332
>                           0xffffffffac62434b  ksys_read+0xbb
>                           0xfffffffface604b2  do_syscall_64+0x82
>                           0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
>           36    193.71 us     15.27 us      5.38 us        mutex   pipe_write+0x50
>                           0xffffffffac631ee0  pipe_write+0x50
>                           0xffffffffac6241db  vfs_write+0x3bb
>                           0xffffffffac6244ab  ksys_write+0xbb
>                           0xfffffffface604b2  do_syscall_64+0x82
>                           0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
>            4     51.22 us     16.47 us     12.80 us        mutex   do_epoll_wait+0x24d
>                           0xffffffffac691f0d  do_epoll_wait+0x24d
>                           0xffffffffac69249b  do_epoll_pwait.part.0+0xb
>                           0xffffffffac693ba5  __x64_sys_epoll_pwait+0x95
>                           0xfffffffface604b2  do_syscall_64+0x82
>                           0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
> 
>   === owner stack trace ===
> 
>            3     31.24 us     15.27 us     10.41 us        mutex   pipe_read+0x348
>                           0xffffffffac631bd8  pipe_read+0x348
>                           0xffffffffac623862  vfs_read+0x332
>                           0xffffffffac62434b  ksys_read+0xbb
>                           0xfffffffface604b2  do_syscall_64+0x82
>                           0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
>   ...
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/Documentation/perf-lock.txt |  6 +--
>  tools/perf/builtin-lock.c              | 22 +++++++++-
>  tools/perf/util/bpf_lock_contention.c  | 58 ++++++++++++++++++++++++++
>  tools/perf/util/lock-contention.h      |  7 ++++
>  4 files changed, 88 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index d3793054f7d3..255e4f3e9d2b 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -140,7 +140,6 @@ CONTENTION OPTIONS
>  --use-bpf::
>  	Use BPF program to collect lock contention stats instead of
>  	using the input data.
> -
>  -a::
>  --all-cpus::
>          System-wide collection from all CPUs.
> @@ -179,8 +178,9 @@ CONTENTION OPTIONS
>  
>  -o::
>  --lock-owner::
> -	Show lock contention stat by owners.  Implies --threads and
> -	requires --use-bpf.
> +	Show lock contention stat by owners. This option can be combined with -t,
> +	which shows owner's per thread lock stats, or -v, which shows owner's
> +	stacktrace. Requires --use-bpf.
>  
>  -Y::
>  --type-filter=<value>::
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 9bebc186286f..34cffa3c7cad 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1817,6 +1817,22 @@ static void print_contention_result(struct lock_contention *con)
>  			break;
>  	}
>  
> +	if (con->owner && con->save_callstack && verbose > 0) {
> +		struct rb_root root = RB_ROOT;
> +
> +		if (symbol_conf.field_sep)
> +			fprintf(lock_output, "# owner stack trace:\n");
> +		else
> +			fprintf(lock_output, "\n=== owner stack trace ===\n\n");
> +		while ((st = pop_owner_stack_trace(con)))
> +			insert_to(&root, st, compare);
> +
> +		while ((st = pop_from(&root))) {
> +			print_lock_stat(con, st);
> +			zfree(st);

I think it should be 'zfree(&st)' or 'free(st)'.


> +		}
> +	}
> +
>  	if (print_nr_entries) {
>  		/* update the total/bad stats */
>  		while ((st = pop_from_result())) {
> @@ -1962,8 +1978,10 @@ static int check_lock_contention_options(const struct option *options,
>  		}
>  	}
>  
> -	if (show_lock_owner)
> -		show_thread_stats = true;
> +	if (show_lock_owner && !show_thread_stats) {
> +		pr_warning("Now -o try to show owner's callstack instead of pid and comm.\n");
> +		pr_warning("Please use -t option too to keep the old behavior.\n");
> +	}
>  
>  	return 0;
>  }
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index 76542b86e83f..226ec7a06ab1 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -549,6 +549,64 @@ static const char *lock_contention_get_name(struct lock_contention *con,
>  	return name_buf;
>  }
>  
> +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
> +{
> +	int stacks_fd, stat_fd;
> +	u64 *stack_trace = NULL;
> +	s32 stack_id;
> +	struct contention_key ckey = {};
> +	struct contention_data cdata = {};
> +	size_t stack_size = con->max_stack * sizeof(*stack_trace);
> +	struct lock_stat *st = NULL;
> +
> +	stacks_fd = bpf_map__fd(skel->maps.owner_stacks);
> +	stat_fd = bpf_map__fd(skel->maps.owner_stat);
> +	if (!stacks_fd || !stat_fd)
> +		goto out_err;
> +
> +	stack_trace = zalloc(stack_size);
> +	if (stack_trace == NULL)
> +		goto out_err;
> +
> +	if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
> +		goto out_err;
> +
> +	bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
> +	ckey.stack_id = stack_id;
> +	bpf_map_lookup_elem(stat_fd, &ckey, &cdata);
> +
> +	st = zalloc(sizeof(struct lock_stat));
> +	if (!st)
> +		goto out_err;
> +
> +	st->name = strdup(stack_trace[0] ? lock_contention_get_name(con, NULL, stack_trace, 0) :
> +					   "unknown");
> +	if (!st->name)
> +		goto out_err;
> +
> +	st->flags = cdata.flags;
> +	st->nr_contended = cdata.count;
> +	st->wait_time_total = cdata.total_time;
> +	st->wait_time_max = cdata.max_time;
> +	st->wait_time_min = cdata.min_time;
> +	st->callstack = stack_trace;
> +
> +	if (cdata.count)
> +		st->avg_wait_time = cdata.total_time / cdata.count;
> +
> +	bpf_map_delete_elem(stacks_fd, stack_trace);
> +	bpf_map_delete_elem(stat_fd, &ckey);
> +
> +	return st;
> +
> +out_err:
> +	if (stack_trace)
> +		free(stack_trace);
> +	if (st)
> +		free(st);

No need to check NULL before calling free().

Thanks,
Namhyung


> +	return NULL;
> +}
> +
>  int lock_contention_read(struct lock_contention *con)
>  {
>  	int fd, stack, err = 0;
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index a09f7fe877df..97fd33c57f17 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -168,6 +168,8 @@ int lock_contention_stop(void);
>  int lock_contention_read(struct lock_contention *con);
>  int lock_contention_finish(struct lock_contention *con);
>  
> +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con);
> +
>  #else  /* !HAVE_BPF_SKEL */
>  
>  static inline int lock_contention_prepare(struct lock_contention *con __maybe_unused)
> @@ -187,6 +189,11 @@ static inline int lock_contention_read(struct lock_contention *con __maybe_unuse
>  	return 0;
>  }
>  
> +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
> +{
> +	return NULL;
> +}
> +
>  #endif  /* HAVE_BPF_SKEL */
>  
>  #endif  /* PERF_LOCK_CONTENTION_H */
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 

