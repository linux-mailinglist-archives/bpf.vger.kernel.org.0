Return-Path: <bpf+bounces-22010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7017855065
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA7BB2772D
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123F960DCA;
	Wed, 14 Feb 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m02q2Qlg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080B60DFD;
	Wed, 14 Feb 2024 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931533; cv=none; b=FaFLcUySzFO6VUFavtO4ZfEtXWrELpxY9Dnjvw7ypxQyi+AHK0tjbm78/30EWt6ca2nNH6h35jWUFTQjgVODPeBtc0VADaHaxoWt4VLJYGoRwmFe2bx5LXWlvWMDIqEFLCStqq1ZVMPWoKP3+4mAZ+KpY7pLu1mRH34JmKHHCDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931533; c=relaxed/simple;
	bh=XWEFbPr3J4TJPSoFM3I3qh9skPV1hkdSIaXZRC1c4Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcCqiMhKuCIn8Ep1kSToH+ElI34RY+evCp6nAJ5vsNc4MdOaDdqf+dEdyY38yzMiipZ3wx1d3BUa2nzggxULDOB08vlJhGM7heeDFEbsdybVq5AlC0O9xl/cftjnbRSj3VdhB1VgntORH0RNhqkVa4jYsnSThamu+0Im91pZFsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m02q2Qlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD530C433F1;
	Wed, 14 Feb 2024 17:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707931533;
	bh=XWEFbPr3J4TJPSoFM3I3qh9skPV1hkdSIaXZRC1c4Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m02q2QlgKjdzyutCzXk+eewAb85EmUrqwr7cxV5Xoonu4S0xNmB0UlYxIxdI3rDGc
	 wyOqsaIbacDYUpDXaEf0ncUaye3wphukiNkpgrbwWhjVT8gFyxWX0WtZj1jcviI5X8
	 KS4ChAmdJjHQyoLWWGm8wfHr1KYHs9rtkUmIQsDK8nxem4hOjV+l0j/vmZ2yRjKGMl
	 wVFjbQbIduJTeKwHyfbc+Wf0k2Hjh/WQsxx26dtZnKH5fYkBzT7qp+EVXv/e0p6YcK
	 bEfHCSv9vz3udz8INexjzm8BXmmzbTE881lwryqJCu/8R3D/dv6WIRAFuXFUsWKh+l
	 K3RfXye7hK7YA==
Date: Wed, 14 Feb 2024 14:25:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1 2/6] perf trace: Ignore thread hashing in summary
Message-ID: <Zcz3iSt5k3_74O4J@x1>
References: <20240214063708.972376-1-irogers@google.com>
 <20240214063708.972376-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214063708.972376-3-irogers@google.com>

On Tue, Feb 13, 2024 at 10:37:04PM -0800, Ian Rogers wrote:
> Commit 91e467bc568f ("perf machine: Use hashtable for machine
> threads") made the iteration of thread tids unordered. The perf trace
> --summary output sorts and prints each hash bucket, rather than all
> threads globally. Change this behavior by turn all threads into a
> list, sort the list by number of trace events then by tids, finally
> print the list. This also allows the rbtree in threads to be not
> accessed outside of machine.

Can you please provide a refresh of the output that is changed by your patch?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c  | 41 +++++++++++++++++++++----------------
>  tools/perf/util/rb_resort.h |  5 -----
>  2 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 109b8e64fe69..90eaff8c0f6e 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -74,6 +74,7 @@
>  #include <linux/err.h>
>  #include <linux/filter.h>
>  #include <linux/kernel.h>
> +#include <linux/list_sort.h>
>  #include <linux/random.h>
>  #include <linux/stringify.h>
>  #include <linux/time64.h>
> @@ -4312,34 +4313,38 @@ static unsigned long thread__nr_events(struct thread_trace *ttrace)
>  	return ttrace ? ttrace->nr_events : 0;
>  }
>  
> -DEFINE_RESORT_RB(threads,
> -		(thread__nr_events(thread__priv(a->thread)) <
> -		 thread__nr_events(thread__priv(b->thread))),
> -	struct thread *thread;
> -)
> +static int trace_nr_events_cmp(void *priv __maybe_unused,
> +			       const struct list_head *la,
> +			       const struct list_head *lb)
>  {
> -	entry->thread = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
> +	struct thread_list *a = list_entry(la, struct thread_list, list);
> +	struct thread_list *b = list_entry(lb, struct thread_list, list);
> +	unsigned long a_nr_events = thread__nr_events(thread__priv(a->thread));
> +	unsigned long b_nr_events = thread__nr_events(thread__priv(b->thread));
> +
> +	if (a_nr_events != b_nr_events)
> +		return a_nr_events < b_nr_events ? -1 : 1;
> +
> +	/* Identical number of threads, place smaller tids first. */
> +	return thread__tid(a->thread) < thread__tid(b->thread)
> +		? -1
> +		: (thread__tid(a->thread) > thread__tid(b->thread) ? 1 : 0);
>  }
>  
>  static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp)
>  {
>  	size_t printed = trace__fprintf_threads_header(fp);
> -	struct rb_node *nd;
> -	int i;
> -
> -	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
> -		DECLARE_RESORT_RB_MACHINE_THREADS(threads, trace->host, i);
> +	LIST_HEAD(threads);
>  
> -		if (threads == NULL) {
> -			fprintf(fp, "%s", "Error sorting output by nr_events!\n");
> -			return 0;
> -		}
> +	if (machine__thread_list(trace->host, &threads) == 0) {
> +		struct thread_list *pos;
>  
> -		resort_rb__for_each_entry(nd, threads)
> -			printed += trace__fprintf_thread(fp, threads_entry->thread, trace);
> +		list_sort(NULL, &threads, trace_nr_events_cmp);
>  
> -		resort_rb__delete(threads);
> +		list_for_each_entry(pos, &threads, list)
> +			printed += trace__fprintf_thread(fp, pos->thread, trace);
>  	}
> +	thread_list__delete(&threads);
>  	return printed;
>  }
>  
> diff --git a/tools/perf/util/rb_resort.h b/tools/perf/util/rb_resort.h
> index 376e86cb4c3c..d927a0d25052 100644
> --- a/tools/perf/util/rb_resort.h
> +++ b/tools/perf/util/rb_resort.h
> @@ -143,9 +143,4 @@ struct __name##_sorted *__name = __name##_sorted__new
>  	DECLARE_RESORT_RB(__name)(&__ilist->rblist.entries.rb_root,		\
>  				  __ilist->rblist.nr_entries)
>  
> -/* For 'struct machine->threads' */
> -#define DECLARE_RESORT_RB_MACHINE_THREADS(__name, __machine, hash_bucket)    \
> - DECLARE_RESORT_RB(__name)(&__machine->threads[hash_bucket].entries.rb_root, \
> -			   __machine->threads[hash_bucket].nr)
> -
>  #endif /* _PERF_RESORT_RB_H_ */
> -- 
> 2.43.0.687.g38aa6559b0-goog

