Return-Path: <bpf+bounces-22842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B8F86A840
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 07:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E182B241EF
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 06:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260E22209E;
	Wed, 28 Feb 2024 06:11:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EF87FA;
	Wed, 28 Feb 2024 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100708; cv=none; b=UyNuDTaXUB9Xwv8j1gS5jTutpZpeVZDSUCJxW8zSlxOY4unYufkokbunA0FR9p0A7GGY/SRRmD8mFCD5OQFor8gTLMen382nb6UdnraZ4jUNYjdKZL2tWXCihDh+ynwswcB9/yec9MFR5Olj3wlHPD9t5/o9DOKDFRma6JJ8xTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100708; c=relaxed/simple;
	bh=PCISrVUFyNjqTTXIzIpmOKhTVjy/a4Wjw+PB0uTMrVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beBenvnEGjijgMIto+DY3DcH3SiVWcrgZkkWoF4BRl0esPgmAnoMTgCdKEBsQ8nfXtmh5u0Ge0lGjMVdiBudzcAJ8tECQVKZSvdnBsMxCE8j0rwvC3oZi0bqs4Td4J9hf5+DAlsxj1z4d1aJB+IOQ8ZbdmUVedfkBZZBC+8Pb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso4121395a12.2;
        Tue, 27 Feb 2024 22:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709100706; x=1709705506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhQFzRFWo99nje0rg/z/A1aJvaIyL4lQvcD60Dw9htM=;
        b=kP1WehuaKNXS0tivWOB015RcvRpqmJG8Ffk7jhLBxgEcdzE7LujIrUKk+24WWnBQIG
         jvp4okVmz60goIpGGpEkivrcvyNDcLwogdOtsPEh3/VplSZRZjj+qh4xxHlkAssQ2TRQ
         KknZ9VVimzfXIdqeEO7fk7GZKc9ptmzisBQ3loyD4G1MSjrGxNaItUeDPIQJB/rmf/JM
         LrK9vrlajO3B2bh21mN2iN2WR9XY0xmliiqN9v4KfkmtmIm91h6ODwtevGCBpKs+9Ct7
         Sg+lKFWTK9DMlgX6XfDOqcpgv6IK6B7/hKeoozOOKJRcXLf4/yj3iuGnkTF/KJrOUReS
         A8jA==
X-Forwarded-Encrypted: i=1; AJvYcCWm+RVfuBbxC8ni6plFjlcInTu3G6dKmUOROCrsHVCn44Bh10P4WPhxJqqlq9D4tpivB5Cezbs00UfKI4H5wn7D491nk7679CBxVZoLJWAo6iLKZEEK52WRDq8KnV+91wbiuC+NbhW6Ja+HV/J0i69s141TI/zUVYCTAFlbbZ4dnlzVdw==
X-Gm-Message-State: AOJu0Yzhg8E62b1AQPhWXMoei2bIqiBBAPtWyf61osHAZd3sGust7qn2
	VdsV736ttVgLXw8LL4trfM0SclCRNjXTQezrlW9JFHY+0rmg7MGfdScNQLfC2noTBGXVAIj3PZr
	nnbi4f6cHGYytOZ3bw22ZP9HrSAE=
X-Google-Smtp-Source: AGHT+IG1S6yDsJ8aVgZV7tnV/ywRIj82Oy4BAhjQNZDrVKcmTv3FZjRUHELZRnE5lIxxCIKoxAH6oe3F5lSoX06sPaw=
X-Received: by 2002:a17:90a:a088:b0:299:6479:4678 with SMTP id
 r8-20020a17090aa08800b0029964794678mr8463051pjp.19.1709100706152; Tue, 27 Feb
 2024 22:11:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-2-irogers@google.com>
 <CAM9d7ciB8JAgU9P6qKh-VdVCjH0ZK+Q-n6mdXTO_nRAv6kSSyA@mail.gmail.com> <CAP-5=fW+NAXNYs7LGVORsikL4+jvGNqgNgoWVsgi6w8pezS9wQ@mail.gmail.com>
In-Reply-To: <CAP-5=fW+NAXNYs7LGVORsikL4+jvGNqgNgoWVsgi6w8pezS9wQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 27 Feb 2024 22:11:34 -0800
Message-ID: <CAM9d7chqy7uD0w=Y+nJyhL8cpAEp6tptqPUHx0-4rQ_NJDRrsg@mail.gmail.com>
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

On Mon, Feb 26, 2024 at 11:12=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Feb 26, 2024 at 10:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > > threads") made the iteration of thread tids unordered. The perf repor=
t
> > > --tasks output now shows child threads in an order determined by the
> > > hashing. For example, in this snippet tid 3 appears after tid 256 eve=
n
> > > though they have the same ppid 2:
> > >
> > > ```
> > > $ perf report --tasks
> > > %      pid      tid     ppid  comm
> > >          0        0       -1 |swapper
> > >          2        2        0 | kthreadd
> > >        256      256        2 |  kworker/12:1H-k
> > >     693761   693761        2 |  kworker/10:1-mm
> > >    1301762  1301762        2 |  kworker/1:1-mm_
> > >    1302530  1302530        2 |  kworker/u32:0-k
> > >          3        3        2 |  rcu_gp
> > > ...
> > > ```
> > >
> > > The output is easier to read if threads appear numerically
> > > increasing. To allow for this, read all threads into a list then sort
> > > with a comparator that orders by the child task's of the first common
> > > parent. The list creation and deletion are created as utilities on
> > > machine.  The indentation is possible by counting the number of
> > > parents a child has.
> > >
> > > With this change the output for the same data file is now like:
> > > ```
> > > $ perf report --tasks
> > > %      pid      tid     ppid  comm
> > >          0        0       -1 |swapper
> > >          1        1        0 | systemd
> > >        823      823        1 |  systemd-journal
> > >        853      853        1 |  systemd-udevd
> > >       3230     3230        1 |  systemd-timesyn
> > >       3236     3236        1 |  auditd
> > >       3239     3239     3236 |   audisp-syslog
> > >       3321     3321        1 |  accounts-daemon
> > > ...
> > > ```
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>

I know you sent out v2 already, but let me continue the discussion
here.


> > > ---
> > >  tools/perf/builtin-report.c | 203 ++++++++++++++++++++--------------=
--
> > >  tools/perf/util/machine.c   |  30 ++++++
> > >  tools/perf/util/machine.h   |  10 ++
> > >  3 files changed, 155 insertions(+), 88 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.=
c
> > > index 8e16fa261e6f..b48f1d5309e3 100644
> > > --- a/tools/perf/builtin-report.c
> > > +++ b/tools/perf/builtin-report.c
> > > @@ -59,6 +59,7 @@
> > >  #include <linux/ctype.h>
> > >  #include <signal.h>
> > >  #include <linux/bitmap.h>
> > > +#include <linux/list_sort.h>
> > >  #include <linux/string.h>
> > >  #include <linux/stringify.h>
> > >  #include <linux/time64.h>
> > > @@ -828,35 +829,6 @@ static void tasks_setup(struct report *rep)
> > >         rep->tool.no_warn =3D true;
> > >  }
> > >
> > > -struct task {
> > > -       struct thread           *thread;
> > > -       struct list_head         list;
> > > -       struct list_head         children;
> > > -};
> > > -
> > > -static struct task *tasks_list(struct task *task, struct machine *ma=
chine)
> > > -{
> > > -       struct thread *parent_thread, *thread =3D task->thread;
> > > -       struct task   *parent_task;
> > > -
> > > -       /* Already listed. */
> > > -       if (!list_empty(&task->list))
> > > -               return NULL;
> > > -
> > > -       /* Last one in the chain. */
> > > -       if (thread__ppid(thread) =3D=3D -1)
> > > -               return task;
> > > -
> > > -       parent_thread =3D machine__find_thread(machine, -1, thread__p=
pid(thread));
> > > -       if (!parent_thread)
> > > -               return ERR_PTR(-ENOENT);
> > > -
> > > -       parent_task =3D thread__priv(parent_thread);
> > > -       thread__put(parent_thread);
> > > -       list_add_tail(&task->list, &parent_task->children);
> > > -       return tasks_list(parent_task, machine);
> > > -}
> > > -
> > >  struct maps__fprintf_task_args {
> > >         int indent;
> > >         FILE *fp;
> > > @@ -900,89 +872,144 @@ static size_t maps__fprintf_task(struct maps *=
maps, int indent, FILE *fp)
> > >         return args.printed;
> > >  }
> > >
> > > -static void task__print_level(struct task *task, FILE *fp, int level=
)
> > > +static int thread_level(struct machine *machine, const struct thread=
 *thread)
> > >  {
> > > -       struct thread *thread =3D task->thread;
> > > -       struct task *child;
> > > -       int comm_indent =3D fprintf(fp, "  %8d %8d %8d |%*s",
> > > -                                 thread__pid(thread), thread__tid(th=
read),
> > > -                                 thread__ppid(thread), level, "");
> > > +       struct thread *parent_thread;
> > > +       int res;
> > >
> > > -       fprintf(fp, "%s\n", thread__comm_str(thread));
> > > +       if (thread__tid(thread) <=3D 0)
> > > +               return 0;
> > >
> > > -       maps__fprintf_task(thread__maps(thread), comm_indent, fp);
> > > +       if (thread__ppid(thread) <=3D 0)
> > > +               return 1;
> > >
> > > -       if (!list_empty(&task->children)) {
> > > -               list_for_each_entry(child, &task->children, list)
> > > -                       task__print_level(child, fp, level + 1);
> > > +       parent_thread =3D machine__find_thread(machine, -1, thread__p=
pid(thread));
> > > +       if (!parent_thread) {
> > > +               pr_err("Missing parent thread of %d\n", thread__tid(t=
hread));
> > > +               return 0;
> > >         }
> > > +       res =3D 1 + thread_level(machine, parent_thread);
> > > +       thread__put(parent_thread);
> > > +       return res;
> > >  }
> > >
> > > -static int tasks_print(struct report *rep, FILE *fp)
> > > +static void task__print_level(struct machine *machine, struct thread=
 *thread, FILE *fp)
> > >  {
> > > -       struct perf_session *session =3D rep->session;
> > > -       struct machine      *machine =3D &session->machines.host;
> > > -       struct task *tasks, *task;
> > > -       unsigned int nr =3D 0, itask =3D 0, i;
> > > -       struct rb_node *nd;
> > > -       LIST_HEAD(list);
> > > +       int level =3D thread_level(machine, thread);
> > > +       int comm_indent =3D fprintf(fp, "  %8d %8d %8d |%*s",
> > > +                                 thread__pid(thread), thread__tid(th=
read),
> > > +                                 thread__ppid(thread), level, "");
> > >
> > > -       /*
> > > -        * No locking needed while accessing machine->threads,
> > > -        * because --tasks is single threaded command.
> > > -        */
> > > +       fprintf(fp, "%s\n", thread__comm_str(thread));
> > >
> > > -       /* Count all the threads. */
> > > -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++)
> > > -               nr +=3D machine->threads[i].nr;
> > > +       maps__fprintf_task(thread__maps(thread), comm_indent, fp);
> > > +}
> > >
> > > -       tasks =3D malloc(sizeof(*tasks) * nr);
> > > -       if (!tasks)
> > > -               return -ENOMEM;
> > > +static int task_list_cmp(void *priv, const struct list_head *la, con=
st struct list_head *lb)
> >
> > I'm a little afraid that this comparison logic becomes complex.
> > But I think it's better than having a tree of thread relationship.
> > Just a comment that explains why we need this would be nice.
>
> I can add something in v2.
>
> >
> > > +{
> > > +       struct machine *machine =3D priv;
> > > +       struct thread_list *task_a =3D list_entry(la, struct thread_l=
ist, list);
> > > +       struct thread_list *task_b =3D list_entry(lb, struct thread_l=
ist, list);
> > > +       struct thread *a =3D task_a->thread;
> > > +       struct thread *b =3D task_b->thread;
> > > +       int level_a, level_b, res;
> > > +
> > > +       /* Compare a and b to root. */
> > > +       if (thread__tid(a) =3D=3D thread__tid(b))
> > > +               return 0;
> > >
> > > -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > > -               struct threads *threads =3D &machine->threads[i];
> > > +       if (thread__tid(a) =3D=3D 0)
> > > +               return -1;
> > >
> > > -               for (nd =3D rb_first_cached(&threads->entries); nd;
> > > -                    nd =3D rb_next(nd)) {
> > > -                       task =3D tasks + itask++;
> > > +       if (thread__tid(b) =3D=3D 0)
> > > +               return 1;
> > >
> > > -                       task->thread =3D rb_entry(nd, struct thread_r=
b_node, rb_node)->thread;
> > > -                       INIT_LIST_HEAD(&task->children);
> > > -                       INIT_LIST_HEAD(&task->list);
> > > -                       thread__set_priv(task->thread, task);
> > > -               }
> > > +       /* If parents match sort by tid. */
> > > +       if (thread__ppid(a) =3D=3D thread__ppid(b)) {
> > > +               return thread__tid(a) < thread__tid(b)
> > > +                       ? -1
> > > +                       : (thread__tid(a) > thread__tid(b) ? 1 : 0);
> >
> > Can it be simply like this?  We know tid(a) !=3D tid(b).
> >
> >   return thread__tid(a) < thread__tid(b) ? -1 : 1;
>
> Yes, but the parent check is still required.

Sure.  I only meant the return statement.

>
> > >         }
> > >
> > >         /*
> > > -        * Iterate every task down to the unprocessed parent
> > > -        * and link all in task children list. Task with no
> > > -        * parent is added into 'list'.
> > > +        * Find a and b such that if they are a child of each other a=
 and b's
> > > +        * tid's match, otherwise a and b have a common parent and di=
stinct
> > > +        * tid's to sort by. First make the depths of the threads mat=
ch.
> > >          */
> > > -       for (itask =3D 0; itask < nr; itask++) {
> > > -               task =3D tasks + itask;
> > > -
> > > -               if (!list_empty(&task->list))
> > > -                       continue;
> > > -
> > > -               task =3D tasks_list(task, machine);
> > > -               if (IS_ERR(task)) {
> > > -                       pr_err("Error: failed to process tasks\n");
> > > -                       free(tasks);
> > > -                       return PTR_ERR(task);
> > > +       level_a =3D thread_level(machine, a);
> > > +       level_b =3D thread_level(machine, b);
> > > +       a =3D thread__get(a);
> > > +       b =3D thread__get(b);
> > > +       for (int i =3D level_a; i > level_b; i--) {
> > > +               struct thread *parent =3D machine__find_thread(machin=
e, -1, thread__ppid(a));
> > > +
> > > +               thread__put(a);
> > > +               if (!parent) {
> > > +                       pr_err("Missing parent thread of %d\n", threa=
d__tid(a));
> > > +                       thread__put(b);
> > > +                       return -1;
> > >                 }
> > > +               a =3D parent;
> > > +       }
> > > +       for (int i =3D level_b; i > level_a; i--) {
> > > +               struct thread *parent =3D machine__find_thread(machin=
e, -1, thread__ppid(b));
> > >
> > > -               if (task)
> > > -                       list_add_tail(&task->list, &list);
> > > +               thread__put(b);
> > > +               if (!parent) {
> > > +                       pr_err("Missing parent thread of %d\n", threa=
d__tid(b));
> > > +                       thread__put(a);
> > > +                       return 1;
> > > +               }
> > > +               b =3D parent;
> > > +       }
> > > +       /* Search up to a common parent. */
> > > +       while (thread__ppid(a) !=3D thread__ppid(b)) {
> > > +               struct thread *parent;
> > > +
> > > +               parent =3D machine__find_thread(machine, -1, thread__=
ppid(a));
> > > +               thread__put(a);
> > > +               if (!parent)
> > > +                       pr_err("Missing parent thread of %d\n", threa=
d__tid(a));
> > > +               a =3D parent;
> > > +               parent =3D machine__find_thread(machine, -1, thread__=
ppid(b));
> > > +               thread__put(b);
> > > +               if (!parent)
> > > +                       pr_err("Missing parent thread of %d\n", threa=
d__tid(b));
> > > +               b =3D parent;
> > > +               if (!a || !b)
> > > +                       return !a && !b ? 0 : (!a ? -1 : 1);
> >
> > Wouldn't it leak a refcount if either a or b is NULL (not both)?
>
> It would, but this would be an error condition anyway. I can add puts.
>
> >
> > > +       }
> > > +       if (thread__tid(a) =3D=3D thread__tid(b)) {
> > > +               /* a is a child of b or vice-versa, deeper levels app=
ear later. */
> > > +               res =3D level_a < level_b ? -1 : (level_a > level_b ?=
 1 : 0);
> > > +       } else {
> > > +               /* Sort by tid now the parent is the same. */
> > > +               res =3D thread__tid(a) < thread__tid(b) ? -1 : 1;
> > >         }
> > > +       thread__put(a);
> > > +       thread__put(b);
> > > +       return res;
> > > +}
> > > +
> > > +static int tasks_print(struct report *rep, FILE *fp)
> > > +{
> > > +       struct machine *machine =3D &rep->session->machines.host;
> > > +       LIST_HEAD(tasks);
> > > +       int ret;
> > >
> > > -       fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppid", "com=
m");
> > > +       ret =3D machine__thread_list(machine, &tasks);
> > > +       if (!ret) {
> > > +               struct thread_list *task;
> >
> > Do we really need this thread_list?  Why not use an
> > array of threads directly?
>
> The code isn't particularly performance critical. I used a list as it
> best approximated how the rbtree was being used. The code is reused in
> subsequent patches, there's no initial pass to size an array and I
> think the reallocarray/qsort logic is generally more problematic than
> the list ones. If we were worried about performance then I think
> arrays could make sense for optimization, but I think this is good
> enough for now.

Well, it's not about performance.  It made me think why we need
this thread_list but I couldn't find the reason.  If you can move
machine__threads_nr() here then you won't need realloc().

Thanks,
Namhyung

> > >
> > > -       list_for_each_entry(task, &list, list)
> > > -               task__print_level(task, fp, 0);
> > > +               list_sort(machine, &tasks, task_list_cmp);
> > >
> > > -       free(tasks);
> > > -       return 0;
> > > +               fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppi=
d", "comm");
> > > +
> > > +               list_for_each_entry(task, &tasks, list)
> > > +                       task__print_level(machine, task->thread, fp);
> > > +       }
> > > +       thread_list__delete(&tasks);
> > > +       return ret;
> > >  }
> > >
> > >  static int __cmd_report(struct report *rep)
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index 3da92f18814a..7872ce92c9fc 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -3261,6 +3261,36 @@ int machines__for_each_thread(struct machines =
*machines,
> > >         return rc;
> > >  }
> > >
> > > +
> > > +static int thread_list_cb(struct thread *thread, void *data)
> > > +{
> > > +       struct list_head *list =3D data;
> > > +       struct thread_list *entry =3D malloc(sizeof(*entry));
> > > +
> > > +       if (!entry)
> > > +               return -ENOMEM;
> > > +
> > > +       entry->thread =3D thread__get(thread);
> > > +       list_add_tail(&entry->list, list);
> > > +       return 0;
> > > +}
> > > +
> > > +int machine__thread_list(struct machine *machine, struct list_head *=
list)
> > > +{
> > > +       return machine__for_each_thread(machine, thread_list_cb, list=
);
> > > +}
> > > +
> > > +void thread_list__delete(struct list_head *list)
> > > +{
> > > +       struct thread_list *pos, *next;
> > > +
> > > +       list_for_each_entry_safe(pos, next, list, list) {
> > > +               thread__zput(pos->thread);
> > > +               list_del(&pos->list);
> > > +               free(pos);
> > > +       }
> > > +}
> > > +
> > >  pid_t machine__get_current_tid(struct machine *machine, int cpu)
> > >  {
> > >         if (cpu < 0 || (size_t)cpu >=3D machine->current_tid_sz)
> > > diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> > > index 1279acda6a8a..b738ce84817b 100644
> > > --- a/tools/perf/util/machine.h
> > > +++ b/tools/perf/util/machine.h
> > > @@ -280,6 +280,16 @@ int machines__for_each_thread(struct machines *m=
achines,
> > >                               int (*fn)(struct thread *thread, void *=
p),
> > >                               void *priv);
> > >
> > > +struct thread_list {
> > > +       struct list_head         list;
> > > +       struct thread           *thread;
> > > +};
> > > +
> > > +/* Make a list of struct thread_list based on threads in the machine=
. */
> > > +int machine__thread_list(struct machine *machine, struct list_head *=
list);
> > > +/* Free up the nodes within the thread_list list. */
> > > +void thread_list__delete(struct list_head *list);
> > > +
> > >  pid_t machine__get_current_tid(struct machine *machine, int cpu);
> > >  int machine__set_current_tid(struct machine *machine, int cpu, pid_t=
 pid,
> > >                              pid_t tid);
> > > --
> > > 2.43.0.687.g38aa6559b0-goog
> > >

