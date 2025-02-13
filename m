Return-Path: <bpf+bounces-51474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CBBA35223
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBF83AB870
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 23:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4BB245B07;
	Thu, 13 Feb 2025 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTmlODvw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65722D7A7;
	Thu, 13 Feb 2025 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489058; cv=none; b=ZJyVQ8iR+REP8TNjcNFK7BUGoZ9x65nSHGWQ9Try5gMhs7s7w+UqQjkAxgM0ZSmlJwL0Da5bxuE9AP7RL7HbtbHHKE5T6E9evjOupDn2tCTsMmOAuE/UJTU9oGueDvj2Arg0upxJtdy7WWyiTYqzkPKYUyqyHMp29rzlTWJ5QzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489058; c=relaxed/simple;
	bh=m4J6f0j7kRwC6fKOMI/NNmOw4izFhiRQ6rDCOl9FEhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deTKnoF83nVhUQcwY9/RBc6su+txYjFDb5nVTtLDCKKoMscAdB5UFTowh08AB0n8a5v37imuL681dxnNoxyLmOy0PopR0HGtJzAeqpPPpuBqmoTxGslL4mKu1MDex59/qXLzOdaH+rAB+S13ROuQDDjOI9E17YfQt0W+Luy4m4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTmlODvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3E1C4CED1;
	Thu, 13 Feb 2025 23:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739489057;
	bh=m4J6f0j7kRwC6fKOMI/NNmOw4izFhiRQ6rDCOl9FEhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTmlODvwfC5xZtyRIdTRON2WbisZS478qoGellB7MTuxUVbuzI3nvNUNom7d0taR4
	 8yizAa3/fDU+rL0chppsTmyFkSwouf89I8HSsSfQuscmmOkmzZyvygFcgij/LnVEdX
	 SCqLXX2Gd/vGPge5tB/kMDpH+Q6qUaCnP37XI1N0AZpKw/DLY2AbelCrG6oOnNVRsi
	 O9/XMWNQBTHj3yexY9tBEnwj2EHnvIYZoupQwCxCdkiVrjClzMppihYl2sMm4XCI1N
	 gZdsvnfTzhW/anzJNnyreAPcLRmn4V4MaEdeSairazeXRvEHZxWHIYKNYTg9D07Uz9
	 gNXdSFTJcvbYg==
Date: Thu, 13 Feb 2025 15:24:15 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v5 4/5] perf lock: Report owner stack in usermode
Message-ID: <Z65_H8wCbdF9sQGp@google.com>
References: <20250212222859.2086080-1-ctshao@google.com>
 <20250212222859.2086080-5-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212222859.2086080-5-ctshao@google.com>

On Wed, Feb 12, 2025 at 02:24:55PM -0800, Chun-Tse Shao wrote:
> Parse `owner_lock_stat` into a rb tree, and report owner lock stats with
> stack trace in order.
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
>  tools/perf/builtin-lock.c             | 19 ++++++++--
>  tools/perf/util/bpf_lock_contention.c | 54 +++++++++++++++++++++++++++
>  tools/perf/util/lock-contention.h     |  7 ++++
>  3 files changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 9bebc186286f..3dc100cf30ef 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1817,6 +1817,22 @@ static void print_contention_result(struct lock_contention *con)
>  			break;
>  	}
>  
> +	if (con->owner && con->save_callstack) {
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
> +		}
> +	}
> +
>  	if (print_nr_entries) {
>  		/* update the total/bad stats */
>  		while ((st = pop_from_result())) {
> @@ -1962,9 +1978,6 @@ static int check_lock_contention_options(const struct option *options,
>  		}
>  	}
>  
> -	if (show_lock_owner)
> -		show_thread_stats = true;
> -
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index 76542b86e83f..dc83b02c9724 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -549,6 +549,60 @@ static const char *lock_contention_get_name(struct lock_contention *con,
>  	return name_buf;
>  }
>  
> +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
> +{
> +	int stacks_fd, stat_fd;
> +	u64 *stack_trace;
> +	s32 stack_id;
> +	struct contention_key ckey = {};
> +	struct contention_data cdata = {};
> +	size_t stack_size = con->max_stack * sizeof(*stack_trace);
> +	struct lock_stat *st;
> +	char name[KSYM_NAME_LEN];
> +
> +	stacks_fd = bpf_map__fd(skel->maps.owner_stacks);
> +	stat_fd = bpf_map__fd(skel->maps.owner_stat);
> +	if (!stacks_fd || !stat_fd)
> +		return NULL;
> +
> +	stack_trace = zalloc(stack_size);
> +	if (stack_trace == NULL)
> +		return NULL;
> +
> +	if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
> +		return NULL;

Please free(stack_trace).

> +
> +	bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
> +	ckey.stack_id = stack_id;
> +	bpf_map_lookup_elem(stat_fd, &ckey, &cdata);
> +
> +	st = zalloc(sizeof(struct lock_stat));
> +	if (!st)
> +		return NULL;

And here too.

> +
> +	strcpy(name,
> +	       stack_trace[0] ? lock_contention_get_name(con, NULL, stack_trace, 0) : "unknown");
> +
> +	st->name = strdup(name);
> +	if (!st->name)
> +		return NULL;

Why not

	if (stack_trace[0])
		st->name = strdup(lock_contention_get_name(con, NULL, stack_trace, 0));
	else
		st->name = strdup("unknown");

	if (st->name == NULL) {
		free(stack_trace);
		free(st);
		return NULL;
	}

? I don't think you need the name[].

Thanks,
Namhyung

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
> 2.48.1.502.g6dc24dfdaf-goog
> 

