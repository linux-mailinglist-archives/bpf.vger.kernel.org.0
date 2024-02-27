Return-Path: <bpf+bounces-22760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD6F868917
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 07:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B7D284C98
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 06:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767B3535B3;
	Tue, 27 Feb 2024 06:39:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CE37145;
	Tue, 27 Feb 2024 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015961; cv=none; b=N7+BncGePorHlFUuugiv2h1BQ6LkB2v+FhAbcAJGJficpKjzP/XMKohF/yFkQ37Ib3EnbvFLeBCgHo0xZycuTVIgppMuxvwJoBjDgWKJ31JUd/9Y5XtyF0mA/K0R+OZKgvEAX1kh4prS/6HYJYoZfTJIXnUh/JaLXPe1VtrcYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015961; c=relaxed/simple;
	bh=R6EdHF9/U5YZm4C5cKXx3XqJqmaYB1m+UdFHorhDED0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvsdjc0GWV6tcu1Oip+VvNFZI1QRhrZuMvo0hLuYPTVLllRl8zK8DdS1I4bz/2dAHVvNwrxNppfGs0YRDF/d32RX2RvYEKhDO2bJ8C4ySVaBj25LgT5tHItwDCtFXuTAuZAtqqX3sko/E+LNEc4o9lRV8VVf8EG2W1nDS6ggams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso3058386b3a.2;
        Mon, 26 Feb 2024 22:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709015959; x=1709620759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOOtXRsrQNdGcOq5AMB8/CDD2LeeemzfK7SDv2AxfVY=;
        b=tLAuwn7fHSitPut2JWXOUgKh1U8pP+cotq4yUMU/xTlaZNPFuYiZo9adHwqaitY4wE
         VqySjHeLrElf3VaaYs1nUHPqOD9NVZOVbR2LUDdWIbMywTFRmPYu7D+rs1vkj9OCMwtk
         uMOwriuydaCofRgWqcmL9Fd+nkEDn6CdmIdItqGY5HRyNcF/RGIeaO4Y86VgVkMk19en
         3eQ5xtp9JZowhkr5+he4EtZiY6bbH/kpvUcWmlSw83J+Hhf7BfNFVewCHOZxYRESGvVM
         6Rh7wJKpn9fvByYk+dpBcwN8Z/E3RFzZ15tss7ajh4lR/AFg2ovVkkqAJ941mLb8AY13
         z3jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJkG1uEwtfgvi3Ki1qsJ3jWusMUmUyUGYzSsslmq+0l3mOPwuNLzRlEnjpDpdUdjfpH1D/E2ZN9q6ZlIuLk2/eBnpjALDQVcG5MbMP0k+LGe7sPsU3n0sfcTwMHJnA51r6RkbwIPllhregnnbZT82M4fpCbk/5ktPZcLkEG3p0HCQNNw==
X-Gm-Message-State: AOJu0Yzqs0VITqgz7wrF61R9FHWzLkkGqRwxph2+I0zcbhv4oEeVWmKI
	i+Y1AtggcJjr/f19scB9WIG0/VcDamgBF9Jfk92nwM8ZvLVF64mAvmUpZKeJexvW8ppR88ukWQ0
	P9Be28lTz7BLjuaqHJjjVUUf3Vks=
X-Google-Smtp-Source: AGHT+IHIlsxCcK+m01cq7HCfK5M0vFENt/Lj9Y9piuUcl/h9uaihKMh7Qe/8WHPgVTB9+pEFrpeLNyO6utNXSouzhPY=
X-Received: by 2002:a05:6a20:d391:b0:1a0:e4ac:9c7a with SMTP id
 iq17-20020a056a20d39100b001a0e4ac9c7amr1692598pzb.1.1709015958545; Mon, 26
 Feb 2024 22:39:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-2-irogers@google.com>
In-Reply-To: <20240214063708.972376-2-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 26 Feb 2024 22:39:07 -0800
Message-ID: <CAM9d7ciB8JAgU9P6qKh-VdVCjH0ZK+Q-n6mdXTO_nRAv6kSSyA@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf report: Sort child tasks by tid
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
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
>         rep->tool.no_warn =3D true;
>  }
>
> -struct task {
> -       struct thread           *thread;
> -       struct list_head         list;
> -       struct list_head         children;
> -};
> -
> -static struct task *tasks_list(struct task *task, struct machine *machin=
e)
> -{
> -       struct thread *parent_thread, *thread =3D task->thread;
> -       struct task   *parent_task;
> -
> -       /* Already listed. */
> -       if (!list_empty(&task->list))
> -               return NULL;
> -
> -       /* Last one in the chain. */
> -       if (thread__ppid(thread) =3D=3D -1)
> -               return task;
> -
> -       parent_thread =3D machine__find_thread(machine, -1, thread__ppid(=
thread));
> -       if (!parent_thread)
> -               return ERR_PTR(-ENOENT);
> -
> -       parent_task =3D thread__priv(parent_thread);
> -       thread__put(parent_thread);
> -       list_add_tail(&task->list, &parent_task->children);
> -       return tasks_list(parent_task, machine);
> -}
> -
>  struct maps__fprintf_task_args {
>         int indent;
>         FILE *fp;
> @@ -900,89 +872,144 @@ static size_t maps__fprintf_task(struct maps *maps=
, int indent, FILE *fp)
>         return args.printed;
>  }
>
> -static void task__print_level(struct task *task, FILE *fp, int level)
> +static int thread_level(struct machine *machine, const struct thread *th=
read)
>  {
> -       struct thread *thread =3D task->thread;
> -       struct task *child;
> -       int comm_indent =3D fprintf(fp, "  %8d %8d %8d |%*s",
> -                                 thread__pid(thread), thread__tid(thread=
),
> -                                 thread__ppid(thread), level, "");
> +       struct thread *parent_thread;
> +       int res;
>
> -       fprintf(fp, "%s\n", thread__comm_str(thread));
> +       if (thread__tid(thread) <=3D 0)
> +               return 0;
>
> -       maps__fprintf_task(thread__maps(thread), comm_indent, fp);
> +       if (thread__ppid(thread) <=3D 0)
> +               return 1;
>
> -       if (!list_empty(&task->children)) {
> -               list_for_each_entry(child, &task->children, list)
> -                       task__print_level(child, fp, level + 1);
> +       parent_thread =3D machine__find_thread(machine, -1, thread__ppid(=
thread));
> +       if (!parent_thread) {
> +               pr_err("Missing parent thread of %d\n", thread__tid(threa=
d));
> +               return 0;
>         }
> +       res =3D 1 + thread_level(machine, parent_thread);
> +       thread__put(parent_thread);
> +       return res;
>  }
>
> -static int tasks_print(struct report *rep, FILE *fp)
> +static void task__print_level(struct machine *machine, struct thread *th=
read, FILE *fp)
>  {
> -       struct perf_session *session =3D rep->session;
> -       struct machine      *machine =3D &session->machines.host;
> -       struct task *tasks, *task;
> -       unsigned int nr =3D 0, itask =3D 0, i;
> -       struct rb_node *nd;
> -       LIST_HEAD(list);
> +       int level =3D thread_level(machine, thread);
> +       int comm_indent =3D fprintf(fp, "  %8d %8d %8d |%*s",
> +                                 thread__pid(thread), thread__tid(thread=
),
> +                                 thread__ppid(thread), level, "");
>
> -       /*
> -        * No locking needed while accessing machine->threads,
> -        * because --tasks is single threaded command.
> -        */
> +       fprintf(fp, "%s\n", thread__comm_str(thread));
>
> -       /* Count all the threads. */
> -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++)
> -               nr +=3D machine->threads[i].nr;
> +       maps__fprintf_task(thread__maps(thread), comm_indent, fp);
> +}
>
> -       tasks =3D malloc(sizeof(*tasks) * nr);
> -       if (!tasks)
> -               return -ENOMEM;
> +static int task_list_cmp(void *priv, const struct list_head *la, const s=
truct list_head *lb)

I'm a little afraid that this comparison logic becomes complex.
But I think it's better than having a tree of thread relationship.
Just a comment that explains why we need this would be nice.


> +{
> +       struct machine *machine =3D priv;
> +       struct thread_list *task_a =3D list_entry(la, struct thread_list,=
 list);
> +       struct thread_list *task_b =3D list_entry(lb, struct thread_list,=
 list);
> +       struct thread *a =3D task_a->thread;
> +       struct thread *b =3D task_b->thread;
> +       int level_a, level_b, res;
> +
> +       /* Compare a and b to root. */
> +       if (thread__tid(a) =3D=3D thread__tid(b))
> +               return 0;
>
> -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> -               struct threads *threads =3D &machine->threads[i];
> +       if (thread__tid(a) =3D=3D 0)
> +               return -1;
>
> -               for (nd =3D rb_first_cached(&threads->entries); nd;
> -                    nd =3D rb_next(nd)) {
> -                       task =3D tasks + itask++;
> +       if (thread__tid(b) =3D=3D 0)
> +               return 1;
>
> -                       task->thread =3D rb_entry(nd, struct thread_rb_no=
de, rb_node)->thread;
> -                       INIT_LIST_HEAD(&task->children);
> -                       INIT_LIST_HEAD(&task->list);
> -                       thread__set_priv(task->thread, task);
> -               }
> +       /* If parents match sort by tid. */
> +       if (thread__ppid(a) =3D=3D thread__ppid(b)) {
> +               return thread__tid(a) < thread__tid(b)
> +                       ? -1
> +                       : (thread__tid(a) > thread__tid(b) ? 1 : 0);

Can it be simply like this?  We know tid(a) !=3D tid(b).

  return thread__tid(a) < thread__tid(b) ? -1 : 1;


>         }
>
>         /*
> -        * Iterate every task down to the unprocessed parent
> -        * and link all in task children list. Task with no
> -        * parent is added into 'list'.
> +        * Find a and b such that if they are a child of each other a and=
 b's
> +        * tid's match, otherwise a and b have a common parent and distin=
ct
> +        * tid's to sort by. First make the depths of the threads match.
>          */
> -       for (itask =3D 0; itask < nr; itask++) {
> -               task =3D tasks + itask;
> -
> -               if (!list_empty(&task->list))
> -                       continue;
> -
> -               task =3D tasks_list(task, machine);
> -               if (IS_ERR(task)) {
> -                       pr_err("Error: failed to process tasks\n");
> -                       free(tasks);
> -                       return PTR_ERR(task);
> +       level_a =3D thread_level(machine, a);
> +       level_b =3D thread_level(machine, b);
> +       a =3D thread__get(a);
> +       b =3D thread__get(b);
> +       for (int i =3D level_a; i > level_b; i--) {
> +               struct thread *parent =3D machine__find_thread(machine, -=
1, thread__ppid(a));
> +
> +               thread__put(a);
> +               if (!parent) {
> +                       pr_err("Missing parent thread of %d\n", thread__t=
id(a));
> +                       thread__put(b);
> +                       return -1;
>                 }
> +               a =3D parent;
> +       }
> +       for (int i =3D level_b; i > level_a; i--) {
> +               struct thread *parent =3D machine__find_thread(machine, -=
1, thread__ppid(b));
>
> -               if (task)
> -                       list_add_tail(&task->list, &list);
> +               thread__put(b);
> +               if (!parent) {
> +                       pr_err("Missing parent thread of %d\n", thread__t=
id(b));
> +                       thread__put(a);
> +                       return 1;
> +               }
> +               b =3D parent;
> +       }
> +       /* Search up to a common parent. */
> +       while (thread__ppid(a) !=3D thread__ppid(b)) {
> +               struct thread *parent;
> +
> +               parent =3D machine__find_thread(machine, -1, thread__ppid=
(a));
> +               thread__put(a);
> +               if (!parent)
> +                       pr_err("Missing parent thread of %d\n", thread__t=
id(a));
> +               a =3D parent;
> +               parent =3D machine__find_thread(machine, -1, thread__ppid=
(b));
> +               thread__put(b);
> +               if (!parent)
> +                       pr_err("Missing parent thread of %d\n", thread__t=
id(b));
> +               b =3D parent;
> +               if (!a || !b)
> +                       return !a && !b ? 0 : (!a ? -1 : 1);

Wouldn't it leak a refcount if either a or b is NULL (not both)?


> +       }
> +       if (thread__tid(a) =3D=3D thread__tid(b)) {
> +               /* a is a child of b or vice-versa, deeper levels appear =
later. */
> +               res =3D level_a < level_b ? -1 : (level_a > level_b ? 1 :=
 0);
> +       } else {
> +               /* Sort by tid now the parent is the same. */
> +               res =3D thread__tid(a) < thread__tid(b) ? -1 : 1;
>         }
> +       thread__put(a);
> +       thread__put(b);
> +       return res;
> +}
> +
> +static int tasks_print(struct report *rep, FILE *fp)
> +{
> +       struct machine *machine =3D &rep->session->machines.host;
> +       LIST_HEAD(tasks);
> +       int ret;
>
> -       fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppid", "comm");
> +       ret =3D machine__thread_list(machine, &tasks);
> +       if (!ret) {
> +               struct thread_list *task;

Do we really need this thread_list?  Why not use an
array of threads directly?

Thanks,
Namhyung

>
> -       list_for_each_entry(task, &list, list)
> -               task__print_level(task, fp, 0);
> +               list_sort(machine, &tasks, task_list_cmp);
>
> -       free(tasks);
> -       return 0;
> +               fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppid", =
"comm");
> +
> +               list_for_each_entry(task, &tasks, list)
> +                       task__print_level(machine, task->thread, fp);
> +       }
> +       thread_list__delete(&tasks);
> +       return ret;
>  }
>
>  static int __cmd_report(struct report *rep)
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 3da92f18814a..7872ce92c9fc 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -3261,6 +3261,36 @@ int machines__for_each_thread(struct machines *mac=
hines,
>         return rc;
>  }
>
> +
> +static int thread_list_cb(struct thread *thread, void *data)
> +{
> +       struct list_head *list =3D data;
> +       struct thread_list *entry =3D malloc(sizeof(*entry));
> +
> +       if (!entry)
> +               return -ENOMEM;
> +
> +       entry->thread =3D thread__get(thread);
> +       list_add_tail(&entry->list, list);
> +       return 0;
> +}
> +
> +int machine__thread_list(struct machine *machine, struct list_head *list=
)
> +{
> +       return machine__for_each_thread(machine, thread_list_cb, list);
> +}
> +
> +void thread_list__delete(struct list_head *list)
> +{
> +       struct thread_list *pos, *next;
> +
> +       list_for_each_entry_safe(pos, next, list, list) {
> +               thread__zput(pos->thread);
> +               list_del(&pos->list);
> +               free(pos);
> +       }
> +}
> +
>  pid_t machine__get_current_tid(struct machine *machine, int cpu)
>  {
>         if (cpu < 0 || (size_t)cpu >=3D machine->current_tid_sz)
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index 1279acda6a8a..b738ce84817b 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -280,6 +280,16 @@ int machines__for_each_thread(struct machines *machi=
nes,
>                               int (*fn)(struct thread *thread, void *p),
>                               void *priv);
>
> +struct thread_list {
> +       struct list_head         list;
> +       struct thread           *thread;
> +};
> +
> +/* Make a list of struct thread_list based on threads in the machine. */
> +int machine__thread_list(struct machine *machine, struct list_head *list=
);
> +/* Free up the nodes within the thread_list list. */
> +void thread_list__delete(struct list_head *list);
> +
>  pid_t machine__get_current_tid(struct machine *machine, int cpu);
>  int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid=
,
>                              pid_t tid);
> --
> 2.43.0.687.g38aa6559b0-goog
>

