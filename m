Return-Path: <bpf+bounces-22009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45056855047
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F080F285230
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E518526F;
	Wed, 14 Feb 2024 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH+cVosV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF784FC9;
	Wed, 14 Feb 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931476; cv=none; b=Pq/QAEFbM7+RvjrjMIjZWzJkV0yLnxuqGj3E94bmENzS6xcl9na7whJ/65fmcLmccmj+18igyTkQxlB+jxUPEbgtYDtdHdSLh0dGy9whKwUFmu7okx1BZk7zmOfvrMtpPuuAigUlzFJaLVOkyu966Qc6uhHBBzOeHVEGIoIcBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931476; c=relaxed/simple;
	bh=JGNgmytcFrLuaY14RZkXoDCEeX+VONBkvjuEZp3aXoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1oDNEoVkFk5ALPXCq96YFcLaKDu/EGVqmV4P3nCqnKFxn5DMpvAHdUYqKb3a1gv6ncnUe8svcRxcPbFyblwcbUk+rXHVSIn7YzGc98ZDoHFy5s8MWc2M7czCi9IKCjzy3uaplSkmc7brxK1kP6GYtBIJNpI5049XsaLoVeUM7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH+cVosV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF2CC433F1;
	Wed, 14 Feb 2024 17:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707931475;
	bh=JGNgmytcFrLuaY14RZkXoDCEeX+VONBkvjuEZp3aXoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UH+cVosVCxuPLixvta2LyIUAs37bbc/qk1rh845izNebYfQzG1VzkVg1iLp0RnEKI
	 ybH6KWrZnrdwvzeXmBty4t8xId1AU+oiUSV6xIp1t3qI8w+/1m9iU03vDkKVlD6di6
	 +VwCyBTKTX6LG+670F/XwB8HOUAJVq6OCx5/MqUcxW2Pm11Rwa5lnnJTRZCBsb8Fwm
	 PzcIKqTupHd7NyO7Ys4Djbgyf9kpwVUAPJN6xD6hsAc26JOGqQZjKO+IcOJxpATaEp
	 pLSl7TINj5TAs9fCAprKPJT6ULsnK7W5Yc9ChrOCiSjpaQ7R+5C5qSCvEzKJrUWsZb
	 bjkja6tJCc6ww==
Date: Wed, 14 Feb 2024 14:24:32 -0300
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
Subject: Re: [PATCH v1 1/6] perf report: Sort child tasks by tid
Message-ID: <Zcz3UO5Jq4zAqSfx@x1>
References: <20240214063708.972376-1-irogers@google.com>
 <20240214063708.972376-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214063708.972376-2-irogers@google.com>

On Tue, Feb 13, 2024 at 10:37:03PM -0800, Ian Rogers wrote:
> Commit 91e467bc568f ("perf machine: Use hashtable for machine
> threads") made the iteration of thread tids unordered. The perf report
> --tasks output now shows child threads in an order determined by the
> hashing. For example, in this snippet tid 3 appears after tid 256 even
> though they have the same ppid 2:
> 
> ```
> $ perf report --tasks
> %      pid      tid     ppid  comm
>          0        0       -1 |swapper
>          2        2        0 | kthreadd
>        256      256        2 |  kworker/12:1H-k
>     693761   693761        2 |  kworker/10:1-mm
>    1301762  1301762        2 |  kworker/1:1-mm_
>    1302530  1302530        2 |  kworker/u32:0-k
>          3        3        2 |  rcu_gp
> ...
> ```
> 
> The output is easier to read if threads appear numerically
> increasing. To allow for this, read all threads into a list then sort
> with a comparator that orders by the child task's of the first common
> parent. The list creation and deletion are created as utilities on
> machine.  The indentation is possible by counting the number of
> parents a child has.
> 
> With this change the output for the same data file is now like:
> ```
> $ perf report --tasks
> %      pid      tid     ppid  comm
>          0        0       -1 |swapper
>          1        1        0 | systemd
>        823      823        1 |  systemd-journal
>        853      853        1 |  systemd-udevd
>       3230     3230        1 |  systemd-timesyn
>       3236     3236        1 |  auditd
>       3239     3239     3236 |   audisp-syslog
>       3321     3321        1 |  accounts-daemon


Since we're adding extra code for sorting wouldn't be more convenient to
have this done in an graphically hierarchical output?

But maybe to make this honour asking for a CSV output the above is
enough? Or can we have both, i.e. for people just doing --tasks, the
hirarchical way, for CSV, then like above, with the comma separator.

But then perf stat has -x to ask for CSV that is used by the more
obscure --exclude-other option :-\

Maybe we need a --csv that is consistent accross all tools.

- Arnaldo

⬢[acme@toolbox b]$ perf stat -x, ls
perf.data
0.65,msec,task-clock:u,648266,100.00,0.534,CPUs utilized
0,,context-switches:u,648266,100.00,0.000,/sec
0,,cpu-migrations:u,648266,100.00,0.000,/sec
91,,page-faults:u,648266,100.00,140.374,K/sec
775564,,cpu_atom/cycles/u,276334,42.00,1.196,GHz
<not counted>,,cpu_core/cycles/u,0,0.00,,
508381,,cpu_atom/instructions/u,648266,100.00,0.66,insn per cycle
<not counted>,,cpu_core/instructions/u,0,0.00,,
99137,,cpu_atom/branches/u,648266,100.00,152.926,M/sec
<not counted>,,cpu_core/branches/u,0,0.00,,
6238,,cpu_atom/branch-misses/u,648266,100.00,6.29,of all branches
<not counted>,,cpu_core/branch-misses/u,0,0.00,,
,648266,100.00,,,,TopdownL1 (cpu_atom)
,,,,,87.9,%  tma_bad_speculation
,648266,100.00,,,24.0,%  tma_frontend_bound
,648266,100.00,,,31.5,%  tma_backend_bound
,,,,,31.5,%  tma_backend_bound_aux
,371932,57.00,,,0.0,%  tma_retiring
⬢[acme@toolbox b]$ perf report -h -x

 Usage: perf report [<options>]

    -x, --exclude-other   Only display entries with parent-match

⬢[acme@toolbox b]$

- Arnaldo

> ...
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-report.c | 203 ++++++++++++++++++++----------------
>  tools/perf/util/machine.c   |  30 ++++++
>  tools/perf/util/machine.h   |  10 ++
>  3 files changed, 155 insertions(+), 88 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 8e16fa261e6f..b48f1d5309e3 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -59,6 +59,7 @@
>  #include <linux/ctype.h>
>  #include <signal.h>
>  #include <linux/bitmap.h>
> +#include <linux/list_sort.h>
>  #include <linux/string.h>
>  #include <linux/stringify.h>
>  #include <linux/time64.h>
> @@ -828,35 +829,6 @@ static void tasks_setup(struct report *rep)
>  	rep->tool.no_warn = true;
>  }
>  
> -struct task {
> -	struct thread		*thread;
> -	struct list_head	 list;
> -	struct list_head	 children;
> -};
> -
> -static struct task *tasks_list(struct task *task, struct machine *machine)
> -{
> -	struct thread *parent_thread, *thread = task->thread;
> -	struct task   *parent_task;
> -
> -	/* Already listed. */
> -	if (!list_empty(&task->list))
> -		return NULL;
> -
> -	/* Last one in the chain. */
> -	if (thread__ppid(thread) == -1)
> -		return task;
> -
> -	parent_thread = machine__find_thread(machine, -1, thread__ppid(thread));
> -	if (!parent_thread)
> -		return ERR_PTR(-ENOENT);
> -
> -	parent_task = thread__priv(parent_thread);
> -	thread__put(parent_thread);
> -	list_add_tail(&task->list, &parent_task->children);
> -	return tasks_list(parent_task, machine);
> -}
> -
>  struct maps__fprintf_task_args {
>  	int indent;
>  	FILE *fp;
> @@ -900,89 +872,144 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
>  	return args.printed;
>  }
>  
> -static void task__print_level(struct task *task, FILE *fp, int level)
> +static int thread_level(struct machine *machine, const struct thread *thread)
>  {
> -	struct thread *thread = task->thread;
> -	struct task *child;
> -	int comm_indent = fprintf(fp, "  %8d %8d %8d |%*s",
> -				  thread__pid(thread), thread__tid(thread),
> -				  thread__ppid(thread), level, "");
> +	struct thread *parent_thread;
> +	int res;
>  
> -	fprintf(fp, "%s\n", thread__comm_str(thread));
> +	if (thread__tid(thread) <= 0)
> +		return 0;
>  
> -	maps__fprintf_task(thread__maps(thread), comm_indent, fp);
> +	if (thread__ppid(thread) <= 0)
> +		return 1;
>  
> -	if (!list_empty(&task->children)) {
> -		list_for_each_entry(child, &task->children, list)
> -			task__print_level(child, fp, level + 1);
> +	parent_thread = machine__find_thread(machine, -1, thread__ppid(thread));
> +	if (!parent_thread) {
> +		pr_err("Missing parent thread of %d\n", thread__tid(thread));
> +		return 0;
>  	}
> +	res = 1 + thread_level(machine, parent_thread);
> +	thread__put(parent_thread);
> +	return res;
>  }
>  
> -static int tasks_print(struct report *rep, FILE *fp)
> +static void task__print_level(struct machine *machine, struct thread *thread, FILE *fp)
>  {
> -	struct perf_session *session = rep->session;
> -	struct machine      *machine = &session->machines.host;
> -	struct task *tasks, *task;
> -	unsigned int nr = 0, itask = 0, i;
> -	struct rb_node *nd;
> -	LIST_HEAD(list);
> +	int level = thread_level(machine, thread);
> +	int comm_indent = fprintf(fp, "  %8d %8d %8d |%*s",
> +				  thread__pid(thread), thread__tid(thread),
> +				  thread__ppid(thread), level, "");
>  
> -	/*
> -	 * No locking needed while accessing machine->threads,
> -	 * because --tasks is single threaded command.
> -	 */
> +	fprintf(fp, "%s\n", thread__comm_str(thread));
>  
> -	/* Count all the threads. */
> -	for (i = 0; i < THREADS__TABLE_SIZE; i++)
> -		nr += machine->threads[i].nr;
> +	maps__fprintf_task(thread__maps(thread), comm_indent, fp);
> +}
>  
> -	tasks = malloc(sizeof(*tasks) * nr);
> -	if (!tasks)
> -		return -ENOMEM;
> +static int task_list_cmp(void *priv, const struct list_head *la, const struct list_head *lb)
> +{
> +	struct machine *machine = priv;
> +	struct thread_list *task_a = list_entry(la, struct thread_list, list);
> +	struct thread_list *task_b = list_entry(lb, struct thread_list, list);
> +	struct thread *a = task_a->thread;
> +	struct thread *b = task_b->thread;
> +	int level_a, level_b, res;
> +
> +	/* Compare a and b to root. */
> +	if (thread__tid(a) == thread__tid(b))
> +		return 0;
>  
> -	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
> -		struct threads *threads = &machine->threads[i];
> +	if (thread__tid(a) == 0)
> +		return -1;
>  
> -		for (nd = rb_first_cached(&threads->entries); nd;
> -		     nd = rb_next(nd)) {
> -			task = tasks + itask++;
> +	if (thread__tid(b) == 0)
> +		return 1;
>  
> -			task->thread = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
> -			INIT_LIST_HEAD(&task->children);
> -			INIT_LIST_HEAD(&task->list);
> -			thread__set_priv(task->thread, task);
> -		}
> +	/* If parents match sort by tid. */
> +	if (thread__ppid(a) == thread__ppid(b)) {
> +		return thread__tid(a) < thread__tid(b)
> +			? -1
> +			: (thread__tid(a) > thread__tid(b) ? 1 : 0);
>  	}
>  
>  	/*
> -	 * Iterate every task down to the unprocessed parent
> -	 * and link all in task children list. Task with no
> -	 * parent is added into 'list'.
> +	 * Find a and b such that if they are a child of each other a and b's
> +	 * tid's match, otherwise a and b have a common parent and distinct
> +	 * tid's to sort by. First make the depths of the threads match.
>  	 */
> -	for (itask = 0; itask < nr; itask++) {
> -		task = tasks + itask;
> -
> -		if (!list_empty(&task->list))
> -			continue;
> -
> -		task = tasks_list(task, machine);
> -		if (IS_ERR(task)) {
> -			pr_err("Error: failed to process tasks\n");
> -			free(tasks);
> -			return PTR_ERR(task);
> +	level_a = thread_level(machine, a);
> +	level_b = thread_level(machine, b);
> +	a = thread__get(a);
> +	b = thread__get(b);
> +	for (int i = level_a; i > level_b; i--) {
> +		struct thread *parent = machine__find_thread(machine, -1, thread__ppid(a));
> +
> +		thread__put(a);
> +		if (!parent) {
> +			pr_err("Missing parent thread of %d\n", thread__tid(a));
> +			thread__put(b);
> +			return -1;
>  		}
> +		a = parent;
> +	}
> +	for (int i = level_b; i > level_a; i--) {
> +		struct thread *parent = machine__find_thread(machine, -1, thread__ppid(b));
>  
> -		if (task)
> -			list_add_tail(&task->list, &list);
> +		thread__put(b);
> +		if (!parent) {
> +			pr_err("Missing parent thread of %d\n", thread__tid(b));
> +			thread__put(a);
> +			return 1;
> +		}
> +		b = parent;
> +	}
> +	/* Search up to a common parent. */
> +	while (thread__ppid(a) != thread__ppid(b)) {
> +		struct thread *parent;
> +
> +		parent = machine__find_thread(machine, -1, thread__ppid(a));
> +		thread__put(a);
> +		if (!parent)
> +			pr_err("Missing parent thread of %d\n", thread__tid(a));
> +		a = parent;
> +		parent = machine__find_thread(machine, -1, thread__ppid(b));
> +		thread__put(b);
> +		if (!parent)
> +			pr_err("Missing parent thread of %d\n", thread__tid(b));
> +		b = parent;
> +		if (!a || !b)
> +			return !a && !b ? 0 : (!a ? -1 : 1);
> +	}
> +	if (thread__tid(a) == thread__tid(b)) {
> +		/* a is a child of b or vice-versa, deeper levels appear later. */
> +		res = level_a < level_b ? -1 : (level_a > level_b ? 1 : 0);
> +	} else {
> +		/* Sort by tid now the parent is the same. */
> +		res = thread__tid(a) < thread__tid(b) ? -1 : 1;
>  	}
> +	thread__put(a);
> +	thread__put(b);
> +	return res;
> +}
> +
> +static int tasks_print(struct report *rep, FILE *fp)
> +{
> +	struct machine *machine = &rep->session->machines.host;
> +	LIST_HEAD(tasks);
> +	int ret;
>  
> -	fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppid", "comm");
> +	ret = machine__thread_list(machine, &tasks);
> +	if (!ret) {
> +		struct thread_list *task;
>  
> -	list_for_each_entry(task, &list, list)
> -		task__print_level(task, fp, 0);
> +		list_sort(machine, &tasks, task_list_cmp);
>  
> -	free(tasks);
> -	return 0;
> +		fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppid", "comm");
> +
> +		list_for_each_entry(task, &tasks, list)
> +			task__print_level(machine, task->thread, fp);
> +	}
> +	thread_list__delete(&tasks);
> +	return ret;
>  }
>  
>  static int __cmd_report(struct report *rep)
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 3da92f18814a..7872ce92c9fc 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -3261,6 +3261,36 @@ int machines__for_each_thread(struct machines *machines,
>  	return rc;
>  }
>  
> +
> +static int thread_list_cb(struct thread *thread, void *data)
> +{
> +	struct list_head *list = data;
> +	struct thread_list *entry = malloc(sizeof(*entry));
> +
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->thread = thread__get(thread);
> +	list_add_tail(&entry->list, list);
> +	return 0;
> +}
> +
> +int machine__thread_list(struct machine *machine, struct list_head *list)
> +{
> +	return machine__for_each_thread(machine, thread_list_cb, list);
> +}
> +
> +void thread_list__delete(struct list_head *list)
> +{
> +	struct thread_list *pos, *next;
> +
> +	list_for_each_entry_safe(pos, next, list, list) {
> +		thread__zput(pos->thread);
> +		list_del(&pos->list);
> +		free(pos);
> +	}
> +}
> +
>  pid_t machine__get_current_tid(struct machine *machine, int cpu)
>  {
>  	if (cpu < 0 || (size_t)cpu >= machine->current_tid_sz)
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index 1279acda6a8a..b738ce84817b 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -280,6 +280,16 @@ int machines__for_each_thread(struct machines *machines,
>  			      int (*fn)(struct thread *thread, void *p),
>  			      void *priv);
>  
> +struct thread_list {
> +	struct list_head	 list;
> +	struct thread		*thread;
> +};
> +
> +/* Make a list of struct thread_list based on threads in the machine. */
> +int machine__thread_list(struct machine *machine, struct list_head *list);
> +/* Free up the nodes within the thread_list list. */
> +void thread_list__delete(struct list_head *list);
> +
>  pid_t machine__get_current_tid(struct machine *machine, int cpu);
>  int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
>  			     pid_t tid);
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 

