Return-Path: <bpf+bounces-22766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DCE8689A5
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 08:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476BE285C42
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 07:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EDC54BED;
	Tue, 27 Feb 2024 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2PXHBsV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C854900
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017946; cv=none; b=A+PGGUqsuoG7nztlVUfkwdpq9sQoTxMLpLzIZczpCMtF1vmIsOeJWaFxVueFpKFNWl06mFmz6hHCG98xP3vgzVR7BCkiluj9WsnYCas8F/h6MWI/7hlwGh92QQl6DEhz+oqrQK8xxkULo8Q9VWuQuO+1ERJQuEblq/hu2c48Ehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017946; c=relaxed/simple;
	bh=Hwhpl+b48/JEAi55RmP9jNhpF7WfoNazpqWNjGTC8jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDMATYLX+rVM/YUWl6S2YuCIYtxHOkUuB3A9uPx29NKn7oKIE19ADeP5ZqcLqd2aR3NM58i/D2Fk1s6qJ1Nn88KHbrffD9+tsyKbl019ZAyp1oHUVR2qIEnPl7RPbcs9ylbe9S2lQLP5HEcYqxzpH4UVhO9CIFNZ3BNjkqeQwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2PXHBsV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc744f54d0so100745ad.0
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 23:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709017942; x=1709622742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLhGzdZYpt7yR/itOwH6IEZhgSnH7gkZJ7wcLyB21+A=;
        b=R2PXHBsVqoFkArOVDqgvBfMnBhqhSUIuu7p4HVvhRS7xo1iSEaVnpqrSMrbkcOiBoQ
         YCQY0ztFz0wzuaL8p9rh1VpgykAd4Vd7+7ynV8FW1AxEBbYD3YemB/UacHmg1jRNLuvs
         sfGIW6dS2Ni6ZfWBWgDk9kE8KSORpQGwNsrJ0I7vuoWju1+hLgJSkNOnDrdZ3nCNrBWr
         cUIIARCUArr4Qu0VOodPqV7Dh96g/fqPIFP+84XJxlfMo5gid8SLjeGZvCGwMAdt1a+y
         cOX8Pmp5m/mu7Xqc6ZQZ31c3I31NG7IjeBLaFvhkdJJ/nXVNJo/zHu0MQsg/nmTH4vVK
         OFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017942; x=1709622742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLhGzdZYpt7yR/itOwH6IEZhgSnH7gkZJ7wcLyB21+A=;
        b=ZGms5JxASKMS4HrJ+JbTsa7A7xhhkMbWhfTo+cWc96gKXVGVKDiPHoLgs4tFlZMgOf
         KCI1B1Mt6I18LMjPfeF9xCSUzHvcseNNfWqIGQ858ISXbdi1Tv4WbcMZrwPP0Rv/QJa5
         uaY4J86KM3f3UL58AT012IJox2kCfVowyX67zToclPA8PNxf4iB81tF7VkIgF9+bU1zd
         49sW9gaER/DBOaW0HAx4zUUwn44LT9NTxxbO6qThn3oEWUXPZl6Nln9kIjLm+3FkYFO2
         Z8WdRqCTNwT3HkexCNvB2xOBMNx+DFfND4aD2d4HT8sOa8Uu0a9jVq4eM8PUodOfnixQ
         Exjw==
X-Forwarded-Encrypted: i=1; AJvYcCXNlbL9tAjT3rBbizo5+nmQZtpnxXZXKPb2R2KqVUsUKK+vy2ENrvEv6PAF6JFynky/3jBDgnvtGyq4zD8IV4IGWnDk
X-Gm-Message-State: AOJu0YzA8rytfi5lqN7YiBMclwfCsVa6NIO4posLfcQ4KMSZ6GZ4PC5a
	qjKVRIJc8s/RP9VjoAWuVUk6n4xqFTgLQOuz0twgoFNyRigOu+ggxEDTaSD+ZWXxfT+4de/5oEI
	mXxgSH4dHBhJlxrjo1mrH+3NpPBEl4fhypgJv
X-Google-Smtp-Source: AGHT+IG8pjmCNn0tk3pBIdI4gvE9SyJxZ0TjBtIU+DX2CGoj0AxUrGsnN6yl1L6ktRHpQeLNrUIXN9Kl0DyEE761atg=
X-Received: by 2002:a17:903:2b86:b0:1db:de7a:9122 with SMTP id
 mj6-20020a1709032b8600b001dbde7a9122mr190131plb.4.1709017941850; Mon, 26 Feb
 2024 23:12:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-2-irogers@google.com>
 <CAM9d7ciB8JAgU9P6qKh-VdVCjH0ZK+Q-n6mdXTO_nRAv6kSSyA@mail.gmail.com>
In-Reply-To: <CAM9d7ciB8JAgU9P6qKh-VdVCjH0ZK+Q-n6mdXTO_nRAv6kSSyA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Feb 2024 23:12:07 -0800
Message-ID: <CAP-5=fW+NAXNYs7LGVORsikL4+jvGNqgNgoWVsgi6w8pezS9wQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf report: Sort child tasks by tid
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > threads") made the iteration of thread tids unordered. The perf report
> > --tasks output now shows child threads in an order determined by the
> > hashing. For example, in this snippet tid 3 appears after tid 256 even
> > though they have the same ppid 2:
> >
> > ```
> > $ perf report --tasks
> > %      pid      tid     ppid  comm
> >          0        0       -1 |swapper
> >          2        2        0 | kthreadd
> >        256      256        2 |  kworker/12:1H-k
> >     693761   693761        2 |  kworker/10:1-mm
> >    1301762  1301762        2 |  kworker/1:1-mm_
> >    1302530  1302530        2 |  kworker/u32:0-k
> >          3        3        2 |  rcu_gp
> > ...
> > ```
> >
> > The output is easier to read if threads appear numerically
> > increasing. To allow for this, read all threads into a list then sort
> > with a comparator that orders by the child task's of the first common
> > parent. The list creation and deletion are created as utilities on
> > machine.  The indentation is possible by counting the number of
> > parents a child has.
> >
> > With this change the output for the same data file is now like:
> > ```
> > $ perf report --tasks
> > %      pid      tid     ppid  comm
> >          0        0       -1 |swapper
> >          1        1        0 | systemd
> >        823      823        1 |  systemd-journal
> >        853      853        1 |  systemd-udevd
> >       3230     3230        1 |  systemd-timesyn
> >       3236     3236        1 |  auditd
> >       3239     3239     3236 |   audisp-syslog
> >       3321     3321        1 |  accounts-daemon
> > ...
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-report.c | 203 ++++++++++++++++++++----------------
> >  tools/perf/util/machine.c   |  30 ++++++
> >  tools/perf/util/machine.h   |  10 ++
> >  3 files changed, 155 insertions(+), 88 deletions(-)
> >
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 8e16fa261e6f..b48f1d5309e3 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -59,6 +59,7 @@
> >  #include <linux/ctype.h>
> >  #include <signal.h>
> >  #include <linux/bitmap.h>
> > +#include <linux/list_sort.h>
> >  #include <linux/string.h>
> >  #include <linux/stringify.h>
> >  #include <linux/time64.h>
> > @@ -828,35 +829,6 @@ static void tasks_setup(struct report *rep)
> >         rep->tool.no_warn =3D true;
> >  }
> >
> > -struct task {
> > -       struct thread           *thread;
> > -       struct list_head         list;
> > -       struct list_head         children;
> > -};
> > -
> > -static struct task *tasks_list(struct task *task, struct machine *mach=
ine)
> > -{
> > -       struct thread *parent_thread, *thread =3D task->thread;
> > -       struct task   *parent_task;
> > -
> > -       /* Already listed. */
> > -       if (!list_empty(&task->list))
> > -               return NULL;
> > -
> > -       /* Last one in the chain. */
> > -       if (thread__ppid(thread) =3D=3D -1)
> > -               return task;
> > -
> > -       parent_thread =3D machine__find_thread(machine, -1, thread__ppi=
d(thread));
> > -       if (!parent_thread)
> > -               return ERR_PTR(-ENOENT);
> > -
> > -       parent_task =3D thread__priv(parent_thread);
> > -       thread__put(parent_thread);
> > -       list_add_tail(&task->list, &parent_task->children);
> > -       return tasks_list(parent_task, machine);
> > -}
> > -
> >  struct maps__fprintf_task_args {
> >         int indent;
> >         FILE *fp;
> > @@ -900,89 +872,144 @@ static size_t maps__fprintf_task(struct maps *ma=
ps, int indent, FILE *fp)
> >         return args.printed;
> >  }
> >
> > -static void task__print_level(struct task *task, FILE *fp, int level)
> > +static int thread_level(struct machine *machine, const struct thread *=
thread)
> >  {
> > -       struct thread *thread =3D task->thread;
> > -       struct task *child;
> > -       int comm_indent =3D fprintf(fp, "  %8d %8d %8d |%*s",
> > -                                 thread__pid(thread), thread__tid(thre=
ad),
> > -                                 thread__ppid(thread), level, "");
> > +       struct thread *parent_thread;
> > +       int res;
> >
> > -       fprintf(fp, "%s\n", thread__comm_str(thread));
> > +       if (thread__tid(thread) <=3D 0)
> > +               return 0;
> >
> > -       maps__fprintf_task(thread__maps(thread), comm_indent, fp);
> > +       if (thread__ppid(thread) <=3D 0)
> > +               return 1;
> >
> > -       if (!list_empty(&task->children)) {
> > -               list_for_each_entry(child, &task->children, list)
> > -                       task__print_level(child, fp, level + 1);
> > +       parent_thread =3D machine__find_thread(machine, -1, thread__ppi=
d(thread));
> > +       if (!parent_thread) {
> > +               pr_err("Missing parent thread of %d\n", thread__tid(thr=
ead));
> > +               return 0;
> >         }
> > +       res =3D 1 + thread_level(machine, parent_thread);
> > +       thread__put(parent_thread);
> > +       return res;
> >  }
> >
> > -static int tasks_print(struct report *rep, FILE *fp)
> > +static void task__print_level(struct machine *machine, struct thread *=
thread, FILE *fp)
> >  {
> > -       struct perf_session *session =3D rep->session;
> > -       struct machine      *machine =3D &session->machines.host;
> > -       struct task *tasks, *task;
> > -       unsigned int nr =3D 0, itask =3D 0, i;
> > -       struct rb_node *nd;
> > -       LIST_HEAD(list);
> > +       int level =3D thread_level(machine, thread);
> > +       int comm_indent =3D fprintf(fp, "  %8d %8d %8d |%*s",
> > +                                 thread__pid(thread), thread__tid(thre=
ad),
> > +                                 thread__ppid(thread), level, "");
> >
> > -       /*
> > -        * No locking needed while accessing machine->threads,
> > -        * because --tasks is single threaded command.
> > -        */
> > +       fprintf(fp, "%s\n", thread__comm_str(thread));
> >
> > -       /* Count all the threads. */
> > -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++)
> > -               nr +=3D machine->threads[i].nr;
> > +       maps__fprintf_task(thread__maps(thread), comm_indent, fp);
> > +}
> >
> > -       tasks =3D malloc(sizeof(*tasks) * nr);
> > -       if (!tasks)
> > -               return -ENOMEM;
> > +static int task_list_cmp(void *priv, const struct list_head *la, const=
 struct list_head *lb)
>
> I'm a little afraid that this comparison logic becomes complex.
> But I think it's better than having a tree of thread relationship.
> Just a comment that explains why we need this would be nice.

I can add something in v2.

>
> > +{
> > +       struct machine *machine =3D priv;
> > +       struct thread_list *task_a =3D list_entry(la, struct thread_lis=
t, list);
> > +       struct thread_list *task_b =3D list_entry(lb, struct thread_lis=
t, list);
> > +       struct thread *a =3D task_a->thread;
> > +       struct thread *b =3D task_b->thread;
> > +       int level_a, level_b, res;
> > +
> > +       /* Compare a and b to root. */
> > +       if (thread__tid(a) =3D=3D thread__tid(b))
> > +               return 0;
> >
> > -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > -               struct threads *threads =3D &machine->threads[i];
> > +       if (thread__tid(a) =3D=3D 0)
> > +               return -1;
> >
> > -               for (nd =3D rb_first_cached(&threads->entries); nd;
> > -                    nd =3D rb_next(nd)) {
> > -                       task =3D tasks + itask++;
> > +       if (thread__tid(b) =3D=3D 0)
> > +               return 1;
> >
> > -                       task->thread =3D rb_entry(nd, struct thread_rb_=
node, rb_node)->thread;
> > -                       INIT_LIST_HEAD(&task->children);
> > -                       INIT_LIST_HEAD(&task->list);
> > -                       thread__set_priv(task->thread, task);
> > -               }
> > +       /* If parents match sort by tid. */
> > +       if (thread__ppid(a) =3D=3D thread__ppid(b)) {
> > +               return thread__tid(a) < thread__tid(b)
> > +                       ? -1
> > +                       : (thread__tid(a) > thread__tid(b) ? 1 : 0);
>
> Can it be simply like this?  We know tid(a) !=3D tid(b).
>
>   return thread__tid(a) < thread__tid(b) ? -1 : 1;

Yes, but the parent check is still required.

> >         }
> >
> >         /*
> > -        * Iterate every task down to the unprocessed parent
> > -        * and link all in task children list. Task with no
> > -        * parent is added into 'list'.
> > +        * Find a and b such that if they are a child of each other a a=
nd b's
> > +        * tid's match, otherwise a and b have a common parent and dist=
inct
> > +        * tid's to sort by. First make the depths of the threads match=
.
> >          */
> > -       for (itask =3D 0; itask < nr; itask++) {
> > -               task =3D tasks + itask;
> > -
> > -               if (!list_empty(&task->list))
> > -                       continue;
> > -
> > -               task =3D tasks_list(task, machine);
> > -               if (IS_ERR(task)) {
> > -                       pr_err("Error: failed to process tasks\n");
> > -                       free(tasks);
> > -                       return PTR_ERR(task);
> > +       level_a =3D thread_level(machine, a);
> > +       level_b =3D thread_level(machine, b);
> > +       a =3D thread__get(a);
> > +       b =3D thread__get(b);
> > +       for (int i =3D level_a; i > level_b; i--) {
> > +               struct thread *parent =3D machine__find_thread(machine,=
 -1, thread__ppid(a));
> > +
> > +               thread__put(a);
> > +               if (!parent) {
> > +                       pr_err("Missing parent thread of %d\n", thread_=
_tid(a));
> > +                       thread__put(b);
> > +                       return -1;
> >                 }
> > +               a =3D parent;
> > +       }
> > +       for (int i =3D level_b; i > level_a; i--) {
> > +               struct thread *parent =3D machine__find_thread(machine,=
 -1, thread__ppid(b));
> >
> > -               if (task)
> > -                       list_add_tail(&task->list, &list);
> > +               thread__put(b);
> > +               if (!parent) {
> > +                       pr_err("Missing parent thread of %d\n", thread_=
_tid(b));
> > +                       thread__put(a);
> > +                       return 1;
> > +               }
> > +               b =3D parent;
> > +       }
> > +       /* Search up to a common parent. */
> > +       while (thread__ppid(a) !=3D thread__ppid(b)) {
> > +               struct thread *parent;
> > +
> > +               parent =3D machine__find_thread(machine, -1, thread__pp=
id(a));
> > +               thread__put(a);
> > +               if (!parent)
> > +                       pr_err("Missing parent thread of %d\n", thread_=
_tid(a));
> > +               a =3D parent;
> > +               parent =3D machine__find_thread(machine, -1, thread__pp=
id(b));
> > +               thread__put(b);
> > +               if (!parent)
> > +                       pr_err("Missing parent thread of %d\n", thread_=
_tid(b));
> > +               b =3D parent;
> > +               if (!a || !b)
> > +                       return !a && !b ? 0 : (!a ? -1 : 1);
>
> Wouldn't it leak a refcount if either a or b is NULL (not both)?

It would, but this would be an error condition anyway. I can add puts.

>
> > +       }
> > +       if (thread__tid(a) =3D=3D thread__tid(b)) {
> > +               /* a is a child of b or vice-versa, deeper levels appea=
r later. */
> > +               res =3D level_a < level_b ? -1 : (level_a > level_b ? 1=
 : 0);
> > +       } else {
> > +               /* Sort by tid now the parent is the same. */
> > +               res =3D thread__tid(a) < thread__tid(b) ? -1 : 1;
> >         }
> > +       thread__put(a);
> > +       thread__put(b);
> > +       return res;
> > +}
> > +
> > +static int tasks_print(struct report *rep, FILE *fp)
> > +{
> > +       struct machine *machine =3D &rep->session->machines.host;
> > +       LIST_HEAD(tasks);
> > +       int ret;
> >
> > -       fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppid", "comm"=
);
> > +       ret =3D machine__thread_list(machine, &tasks);
> > +       if (!ret) {
> > +               struct thread_list *task;
>
> Do we really need this thread_list?  Why not use an
> array of threads directly?

The code isn't particularly performance critical. I used a list as it
best approximated how the rbtree was being used. The code is reused in
subsequent patches, there's no initial pass to size an array and I
think the reallocarray/qsort logic is generally more problematic than
the list ones. If we were worried about performance then I think
arrays could make sense for optimization, but I think this is good
enough for now.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > -       list_for_each_entry(task, &list, list)
> > -               task__print_level(task, fp, 0);
> > +               list_sort(machine, &tasks, task_list_cmp);
> >
> > -       free(tasks);
> > -       return 0;
> > +               fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppid"=
, "comm");
> > +
> > +               list_for_each_entry(task, &tasks, list)
> > +                       task__print_level(machine, task->thread, fp);
> > +       }
> > +       thread_list__delete(&tasks);
> > +       return ret;
> >  }
> >
> >  static int __cmd_report(struct report *rep)
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 3da92f18814a..7872ce92c9fc 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -3261,6 +3261,36 @@ int machines__for_each_thread(struct machines *m=
achines,
> >         return rc;
> >  }
> >
> > +
> > +static int thread_list_cb(struct thread *thread, void *data)
> > +{
> > +       struct list_head *list =3D data;
> > +       struct thread_list *entry =3D malloc(sizeof(*entry));
> > +
> > +       if (!entry)
> > +               return -ENOMEM;
> > +
> > +       entry->thread =3D thread__get(thread);
> > +       list_add_tail(&entry->list, list);
> > +       return 0;
> > +}
> > +
> > +int machine__thread_list(struct machine *machine, struct list_head *li=
st)
> > +{
> > +       return machine__for_each_thread(machine, thread_list_cb, list);
> > +}
> > +
> > +void thread_list__delete(struct list_head *list)
> > +{
> > +       struct thread_list *pos, *next;
> > +
> > +       list_for_each_entry_safe(pos, next, list, list) {
> > +               thread__zput(pos->thread);
> > +               list_del(&pos->list);
> > +               free(pos);
> > +       }
> > +}
> > +
> >  pid_t machine__get_current_tid(struct machine *machine, int cpu)
> >  {
> >         if (cpu < 0 || (size_t)cpu >=3D machine->current_tid_sz)
> > diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> > index 1279acda6a8a..b738ce84817b 100644
> > --- a/tools/perf/util/machine.h
> > +++ b/tools/perf/util/machine.h
> > @@ -280,6 +280,16 @@ int machines__for_each_thread(struct machines *mac=
hines,
> >                               int (*fn)(struct thread *thread, void *p)=
,
> >                               void *priv);
> >
> > +struct thread_list {
> > +       struct list_head         list;
> > +       struct thread           *thread;
> > +};
> > +
> > +/* Make a list of struct thread_list based on threads in the machine. =
*/
> > +int machine__thread_list(struct machine *machine, struct list_head *li=
st);
> > +/* Free up the nodes within the thread_list list. */
> > +void thread_list__delete(struct list_head *list);
> > +
> >  pid_t machine__get_current_tid(struct machine *machine, int cpu);
> >  int machine__set_current_tid(struct machine *machine, int cpu, pid_t p=
id,
> >                              pid_t tid);
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >

