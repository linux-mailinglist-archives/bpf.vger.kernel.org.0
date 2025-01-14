Return-Path: <bpf+bounces-48737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599FCA0FFCF
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 04:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DCD3A55B1
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 03:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E22230D39;
	Tue, 14 Jan 2025 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAjR9AdN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C784622ACF7;
	Tue, 14 Jan 2025 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736827004; cv=none; b=E++1iwLLno94Djoak7D5dljDdeHZH43yCfoqMnxrH7uMmdHY+ZyAdRmwEXHBEoUtgGDX4/6qJvoMD4Ei5Af7CohHDjtxzU8XwGkaLGML5d0P5qaQUshVfsRdi8so55p6G4Q9hLUjLji9zDGusx76t0dU1olli/7yvleo8qrg804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736827004; c=relaxed/simple;
	bh=nCLsJ1F8/J91WhpGj9jw+7bQhIyXl9La0vEZdo0ScwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3ipumDJBvnQcdogPCkqjHgt0Dg2ezsWFls+ktFJmWrxRJS/LcJ3/cHCoyYAbH2MENKYx5Lmlh2bJx5CUYL0w1AbeoLM7dsN5YijwHUePiO+0pXalaJkFfhPuaM/FZcQe6du5//BV7LVfH2VVae2vrqo8T6Wzk4rUNW0qT3jsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAjR9AdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD82AC4CEE3;
	Tue, 14 Jan 2025 03:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736827004;
	bh=nCLsJ1F8/J91WhpGj9jw+7bQhIyXl9La0vEZdo0ScwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAjR9AdNT7f90fIdNSBZRYlRvghpUpvpnr5sJFXUEIG1Jq9lNY3M+OXx7uaD740fy
	 c3nSTYS0GgyK4tC4eK5jXyMfUfVN/FIyi8sZvh4f4FC88zfiyb1S+y5XzCVSR1NSfb
	 rmYScPsPfjX0FZLYzyrOPGFtAys1QzGRhHyxYHm+Nf09MQZcSc0NbqgWnW40ulJRlT
	 ZJ2vf1Ou2boGqerBlMcBj7fC1MKZx5XPEUiiJSSso6skrxec7x2Iomc2BHq8AxAwGx
	 Ue8MnsK1frpXsnoUq8MoSWEEaYV1AKd1nIcxm/zaoP9A0RdK7InflGFOdzbPJjintr
	 36hQppeB+8ZIQ==
Date: Mon, 13 Jan 2025 19:56:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 4/4] perf lock: Report owner stack in usermode
Message-ID: <Z4Xgen-HsfcvUuGN@google.com>
References: <20250113052220.2105645-1-ctshao@google.com>
 <20250113052220.2105645-5-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113052220.2105645-5-ctshao@google.com>

On Sun, Jan 12, 2025 at 09:20:17PM -0800, Chun-Tse Shao wrote:
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
>  tools/perf/builtin-lock.c             | 20 ++++++++++++-
>  tools/perf/util/bpf_lock_contention.c | 41 +++++++++++++++++++++++++++
>  tools/perf/util/lock-contention.h     |  2 ++
>  3 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index f9b7620444c0..0dfec175b25b 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -42,6 +42,7 @@
>  #include <linux/zalloc.h>
>  #include <linux/err.h>
>  #include <linux/stringify.h>
> +#include <linux/rbtree.h>
>  
>  static struct perf_session *session;
>  static struct target target;
> @@ -1926,6 +1927,23 @@ static void print_contention_result(struct lock_contention *con)
>  			break;
>  	}
>  
> +	if (con->owner && con->save_callstack) {
> +		struct rb_root root = RB_ROOT;
> +
> +

A duplicate new line.


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
> @@ -2071,7 +2089,7 @@ static int check_lock_contention_options(const struct option *options,
>  		}
>  	}
>  
> -	if (show_lock_owner)
> +	if (show_lock_owner && !verbose)
>  		show_thread_stats = true;

No, I don't think -v should control this.  Let's change the semantic not
to imply --threads anymore.  I think you can simply delete this code.
Users need to specify -t/--threads option for the old behavior.  Hmm..
maybe we can show some warnings.

	if (show_lock_owner && !show_thread_stats) {
		pr_warning("Now -o try to show owner's callstack instead of pid and comm.\n");
		pr_warning("Please use -t option too to keep the old behavior.\n");
	}

Can you please update the documentation of the -o/--lock-owner option
too?

>  
>  	return 0;
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index c9c58f243ceb..a63d5ffac386 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -414,6 +414,47 @@ static const char *lock_contention_get_name(struct lock_contention *con,
>  	return name_buf;
>  }
>  
> +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
> +{
> +	int fd;
> +	u64 *stack_trace;
> +	struct contention_data data = {};
> +	size_t stack_size = con->max_stack * sizeof(*stack_trace);
> +	struct lock_stat *st;
> +	char name[KSYM_NAME_LEN];
> +
> +	fd = bpf_map__fd(skel->maps.owner_lock_stat);
> +
> +	stack_trace = zalloc(stack_size);
> +	if (stack_trace == NULL)
> +		return NULL;
> +
> +	if (bpf_map_get_next_key(fd, NULL, stack_trace))
> +		return NULL;
> +
> +	bpf_map_lookup_elem(fd, stack_trace, &data);
> +	st = zalloc(sizeof(struct lock_stat));

You need to check the error and handle it properly.


> +
> +	strcpy(name, stack_trace[0] ? lock_contention_get_name(con, NULL,
> +							       stack_trace, 0) :
> +				      "unknown");
> +
> +	st->name = strdup(name);

Why do you copy and strdup()?  Anyway please check the error.


> +	st->flags = data.flags;
> +	st->nr_contended = data.count;
> +	st->wait_time_total = data.total_time;
> +	st->wait_time_max = data.max_time;
> +	st->wait_time_min = data.min_time;
> +	st->callstack = memdup(stack_trace, stack_size);

Why not just give it to the 'st'?

> +
> +	if (data.count)
> +		st->avg_wait_time = data.total_time / data.count;
> +
> +	bpf_map_delete_elem(fd, stack_trace);
> +	free(stack_trace);

Then you don't need to free it here.

> +
> +	return st;
> +}
>  int lock_contention_read(struct lock_contention *con)
>  {
>  	int fd, stack, err = 0;
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index 1a7248ff3889..83b400a36137 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -156,6 +156,8 @@ int lock_contention_stop(void);
>  int lock_contention_read(struct lock_contention *con);
>  int lock_contention_finish(struct lock_contention *con);
>  
> +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con);
> +
>  #else  /* !HAVE_BPF_SKEL */

I think you need to define it here as well.

Thanks,
Namhyung

>  
>  static inline int lock_contention_prepare(struct lock_contention *con __maybe_unused)
> -- 
> 2.47.1.688.g23fc6f90ad-goog
> 

