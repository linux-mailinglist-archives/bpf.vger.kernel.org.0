Return-Path: <bpf+bounces-22943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB9986BAE8
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90441F23471
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE2271EA5;
	Wed, 28 Feb 2024 22:46:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983D1361C4;
	Wed, 28 Feb 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160374; cv=none; b=fPx9s8vtae1XlhFVPq7PcgwND4FNA8z17BJOOUzHAWP5p+2L0oluPgxqz0W0R4KYBkWKWCV+6/nEsERpwibpmtpYC7osxFqXdCVBQt7cjl4UEg78gRyQqaRgM/Cdqk3Vq2J3GvZeTFgPcODEw88Mdr9wx2AZ2V4w/hoHMHLHUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160374; c=relaxed/simple;
	bh=7RRzneLYt+xTejLjTN4BVAZY+CA9CfQCXer8A4H+gtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9xHUIDnFzkAiGu3ewYUaskLBK5v0Odr3NrFQteDV036e2ZdKlFpsB2ortHFlGd2SrJM7LkRphOwBI280krfUPMiFyDUzUXHob2nePozObsIN+6BXQVgtB3w3FGaJjd1Mf1VcyGbDcHrWbsyn26B8El9NC0rk1D0B2RU/2fyFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc1ff697f9so3252565ad.0;
        Wed, 28 Feb 2024 14:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709160372; x=1709765172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMx4G/Nh/7/SXZ5sMaybi77I6S5a4/vWNVVZ3HNkVVc=;
        b=FoGbuDgSmKyvkyeS2z33Ciq19JY35gVnDqPUO2vN804D/U7EU8E1gzK8Ou18XDquzG
         KbLweVNS3s4j1y0ExglEinKXogO7YIVlSKz5JFehCHvKD8eDz9NaKQqoM8IV1BnLYb58
         nyFoEeV2ID/fEraDYSozW8wfQ2wzJo43RZwHWbr9avsNkAA134RKdLWyC6U7A76SHmEP
         E0AF2Zmu86cJFZ5SF04NO9BBNrqQymcVsSY6ECzcJbe78d5R1voKRhcM2vafRwdHh17C
         tt8H37llLjqi3IFxSrUlHNltfS3ryFAxru8JtYER28ZknUrKAl+zFBpIJIAZhQbtQsYl
         etGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxGevkVP7q9ylCMXDYLai3D98k3c68+s2SaL5wAunfSTFeJM073VyM097NyHdpDxoX9mh3hl4w106BIkkZ0sQjLFmzoKkuMS6eUkaO0lLdTPubaddOzV+GSumwQTY+i6aWGiLleXXaAeVPqLLI1p3kTYqGhIf9Vmqiu76/cQDsVCjTow==
X-Gm-Message-State: AOJu0YwiK8u/Fc02XWvCnasWKYmEYTJR+FbSk7Hr7wCY1Z76VZkUS+uL
	e+5Es7sk7vaOV3LcM0QLqkMcLbnJ9HoPOwxVHkKafjGkOziGugCvKz3NAjrcAkGmKSIPU4XIKyq
	WclHNVcMcXxnDof68eIuQw5ak2Uw=
X-Google-Smtp-Source: AGHT+IHtjTh/cm65WCQ93hC52LZFmKBnMCNlbsGoX7PA+DA+sDty2B15XelGqYV8mpDFNsfyHP7OOI3elZKY2AX8RVc=
X-Received: by 2002:a17:90b:19c7:b0:29a:ac9d:a69c with SMTP id
 nm7-20020a17090b19c700b0029aac9da69cmr563241pjb.31.1709160371805; Wed, 28 Feb
 2024 14:46:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-2-irogers@google.com>
 <CAM9d7ciB8JAgU9P6qKh-VdVCjH0ZK+Q-n6mdXTO_nRAv6kSSyA@mail.gmail.com>
 <CAP-5=fW+NAXNYs7LGVORsikL4+jvGNqgNgoWVsgi6w8pezS9wQ@mail.gmail.com>
 <CAM9d7chqy7uD0w=Y+nJyhL8cpAEp6tptqPUHx0-4rQ_NJDRrsg@mail.gmail.com> <CAP-5=fVKpVtNhDQCg=wFTmL7ruZR1gs_CmSsbVw_=_ZfGL2V+Q@mail.gmail.com>
In-Reply-To: <CAP-5=fVKpVtNhDQCg=wFTmL7ruZR1gs_CmSsbVw_=_ZfGL2V+Q@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 28 Feb 2024 14:45:59 -0800
Message-ID: <CAM9d7ciSuOG3V+h_D=ykOYWOfgPGvZfFKfk46U-Y=ViFgqA0aQ@mail.gmail.com>
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

On Tue, Feb 27, 2024 at 11:06=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Tue, Feb 27, 2024 at 10:11=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > On Mon, Feb 26, 2024 at 11:12=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > On Mon, Feb 26, 2024 at 10:39=E2=80=AFPM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > >
> > > > On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google=
.com> wrote:
> > > > >
> > > > > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > > > > threads") made the iteration of thread tids unordered. The perf r=
eport
> > > > > --tasks output now shows child threads in an order determined by =
the
> > > > > hashing. For example, in this snippet tid 3 appears after tid 256=
 even
> > > > > though they have the same ppid 2:
> > > > >
> > > > > ```
> > > > > $ perf report --tasks
> > > > > %      pid      tid     ppid  comm
> > > > >          0        0       -1 |swapper
> > > > >          2        2        0 | kthreadd
> > > > >        256      256        2 |  kworker/12:1H-k
> > > > >     693761   693761        2 |  kworker/10:1-mm
> > > > >    1301762  1301762        2 |  kworker/1:1-mm_
> > > > >    1302530  1302530        2 |  kworker/u32:0-k
> > > > >          3        3        2 |  rcu_gp
> > > > > ...
> > > > > ```
> > > > >
> > > > > The output is easier to read if threads appear numerically
> > > > > increasing. To allow for this, read all threads into a list then =
sort
> > > > > with a comparator that orders by the child task's of the first co=
mmon
> > > > > parent. The list creation and deletion are created as utilities o=
n
> > > > > machine.  The indentation is possible by counting the number of
> > > > > parents a child has.
> > > > >
> > > > > With this change the output for the same data file is now like:
> > > > > ```
> > > > > $ perf report --tasks
> > > > > %      pid      tid     ppid  comm
> > > > >          0        0       -1 |swapper
> > > > >          1        1        0 | systemd
> > > > >        823      823        1 |  systemd-journal
> > > > >        853      853        1 |  systemd-udevd
> > > > >       3230     3230        1 |  systemd-timesyn
> > > > >       3236     3236        1 |  auditd
> > > > >       3239     3239     3236 |   audisp-syslog
> > > > >       3321     3321        1 |  accounts-daemon
> > > > > ...
> > > > > ```
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > I know you sent out v2 already, but let me continue the discussion
> > here.
> >
> >
> > > > > ---
> > > > >  tools/perf/builtin-report.c | 203 ++++++++++++++++++++----------=
------
> > > > >  tools/perf/util/machine.c   |  30 ++++++
> > > > >  tools/perf/util/machine.h   |  10 ++
> > > > >  3 files changed, 155 insertions(+), 88 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-rep=
ort.c
> > > > > index 8e16fa261e6f..b48f1d5309e3 100644
> > > > > --- a/tools/perf/builtin-report.c
> > > > > +++ b/tools/perf/builtin-report.c
> > > > > @@ -59,6 +59,7 @@
> > > > >  #include <linux/ctype.h>
> > > > >  #include <signal.h>
> > > > >  #include <linux/bitmap.h>
> > > > > +#include <linux/list_sort.h>
> > > > >  #include <linux/string.h>
> > > > >  #include <linux/stringify.h>
> > > > >  #include <linux/time64.h>
> > > > > @@ -828,35 +829,6 @@ static void tasks_setup(struct report *rep)
> > > > >         rep->tool.no_warn =3D true;
> > > > >  }
> > > > >
> > > > > -struct task {
> > > > > -       struct thread           *thread;
> > > > > -       struct list_head         list;
> > > > > -       struct list_head         children;
> > > > > -};
> > > > > -
> > > > > -static struct task *tasks_list(struct task *task, struct machine=
 *machine)
> > > > > -{
> > > > > -       struct thread *parent_thread, *thread =3D task->thread;
> > > > > -       struct task   *parent_task;
> > > > > -
> > > > > -       /* Already listed. */
> > > > > -       if (!list_empty(&task->list))
> > > > > -               return NULL;
> > > > > -
> > > > > -       /* Last one in the chain. */
> > > > > -       if (thread__ppid(thread) =3D=3D -1)
> > > > > -               return task;
> > > > > -
> > > > > -       parent_thread =3D machine__find_thread(machine, -1, threa=
d__ppid(thread));
> > > > > -       if (!parent_thread)
> > > > > -               return ERR_PTR(-ENOENT);
> > > > > -
> > > > > -       parent_task =3D thread__priv(parent_thread);
> > > > > -       thread__put(parent_thread);
> > > > > -       list_add_tail(&task->list, &parent_task->children);
> > > > > -       return tasks_list(parent_task, machine);
> > > > > -}
> > > > > -
> > > > >  struct maps__fprintf_task_args {
> > > > >         int indent;
> > > > >         FILE *fp;
> > > > > @@ -900,89 +872,144 @@ static size_t maps__fprintf_task(struct ma=
ps *maps, int indent, FILE *fp)
> > > > >         return args.printed;
> > > > >  }
> > > > >
> > > > > -static void task__print_level(struct task *task, FILE *fp, int l=
evel)
> > > > > +static int thread_level(struct machine *machine, const struct th=
read *thread)
> > > > >  {
> > > > > -       struct thread *thread =3D task->thread;
> > > > > -       struct task *child;
> > > > > -       int comm_indent =3D fprintf(fp, "  %8d %8d %8d |%*s",
> > > > > -                                 thread__pid(thread), thread__ti=
d(thread),
> > > > > -                                 thread__ppid(thread), level, ""=
);
> > > > > +       struct thread *parent_thread;
> > > > > +       int res;
> > > > >
> > > > > -       fprintf(fp, "%s\n", thread__comm_str(thread));
> > > > > +       if (thread__tid(thread) <=3D 0)
> > > > > +               return 0;
> > > > >
> > > > > -       maps__fprintf_task(thread__maps(thread), comm_indent, fp)=
;
> > > > > +       if (thread__ppid(thread) <=3D 0)
> > > > > +               return 1;
> > > > >
> > > > > -       if (!list_empty(&task->children)) {
> > > > > -               list_for_each_entry(child, &task->children, list)
> > > > > -                       task__print_level(child, fp, level + 1);
> > > > > +       parent_thread =3D machine__find_thread(machine, -1, threa=
d__ppid(thread));
> > > > > +       if (!parent_thread) {
> > > > > +               pr_err("Missing parent thread of %d\n", thread__t=
id(thread));
> > > > > +               return 0;
> > > > >         }
> > > > > +       res =3D 1 + thread_level(machine, parent_thread);
> > > > > +       thread__put(parent_thread);
> > > > > +       return res;
> > > > >  }
> > > > >
> > > > > -static int tasks_print(struct report *rep, FILE *fp)
> > > > > +static void task__print_level(struct machine *machine, struct th=
read *thread, FILE *fp)
> > > > >  {
> > > > > -       struct perf_session *session =3D rep->session;
> > > > > -       struct machine      *machine =3D &session->machines.host;
> > > > > -       struct task *tasks, *task;
> > > > > -       unsigned int nr =3D 0, itask =3D 0, i;
> > > > > -       struct rb_node *nd;
> > > > > -       LIST_HEAD(list);
> > > > > +       int level =3D thread_level(machine, thread);
> > > > > +       int comm_indent =3D fprintf(fp, "  %8d %8d %8d |%*s",
> > > > > +                                 thread__pid(thread), thread__ti=
d(thread),
> > > > > +                                 thread__ppid(thread), level, ""=
);
> > > > >
> > > > > -       /*
> > > > > -        * No locking needed while accessing machine->threads,
> > > > > -        * because --tasks is single threaded command.
> > > > > -        */
> > > > > +       fprintf(fp, "%s\n", thread__comm_str(thread));
> > > > >
> > > > > -       /* Count all the threads. */
> > > > > -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++)
> > > > > -               nr +=3D machine->threads[i].nr;
> > > > > +       maps__fprintf_task(thread__maps(thread), comm_indent, fp)=
;
> > > > > +}
> > > > >
> > > > > -       tasks =3D malloc(sizeof(*tasks) * nr);
> > > > > -       if (!tasks)
> > > > > -               return -ENOMEM;
> > > > > +static int task_list_cmp(void *priv, const struct list_head *la,=
 const struct list_head *lb)
> > > >
> > > > I'm a little afraid that this comparison logic becomes complex.
> > > > But I think it's better than having a tree of thread relationship.
> > > > Just a comment that explains why we need this would be nice.
> > >
> > > I can add something in v2.
> > >
> > > >
> > > > > +{
> > > > > +       struct machine *machine =3D priv;
> > > > > +       struct thread_list *task_a =3D list_entry(la, struct thre=
ad_list, list);
> > > > > +       struct thread_list *task_b =3D list_entry(lb, struct thre=
ad_list, list);
> > > > > +       struct thread *a =3D task_a->thread;
> > > > > +       struct thread *b =3D task_b->thread;
> > > > > +       int level_a, level_b, res;
> > > > > +
> > > > > +       /* Compare a and b to root. */
> > > > > +       if (thread__tid(a) =3D=3D thread__tid(b))
> > > > > +               return 0;
> > > > >
> > > > > -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > > > > -               struct threads *threads =3D &machine->threads[i];
> > > > > +       if (thread__tid(a) =3D=3D 0)
> > > > > +               return -1;
> > > > >
> > > > > -               for (nd =3D rb_first_cached(&threads->entries); n=
d;
> > > > > -                    nd =3D rb_next(nd)) {
> > > > > -                       task =3D tasks + itask++;
> > > > > +       if (thread__tid(b) =3D=3D 0)
> > > > > +               return 1;
> > > > >
> > > > > -                       task->thread =3D rb_entry(nd, struct thre=
ad_rb_node, rb_node)->thread;
> > > > > -                       INIT_LIST_HEAD(&task->children);
> > > > > -                       INIT_LIST_HEAD(&task->list);
> > > > > -                       thread__set_priv(task->thread, task);
> > > > > -               }
> > > > > +       /* If parents match sort by tid. */
> > > > > +       if (thread__ppid(a) =3D=3D thread__ppid(b)) {
> > > > > +               return thread__tid(a) < thread__tid(b)
> > > > > +                       ? -1
> > > > > +                       : (thread__tid(a) > thread__tid(b) ? 1 : =
0);
> > > >
> > > > Can it be simply like this?  We know tid(a) !=3D tid(b).
> > > >
> > > >   return thread__tid(a) < thread__tid(b) ? -1 : 1;
> > >
> > > Yes, but the parent check is still required.
> >
> > Sure.  I only meant the return statement.
> >
> > >
> > > > >         }
> > > > >
> > > > >         /*
> > > > > -        * Iterate every task down to the unprocessed parent
> > > > > -        * and link all in task children list. Task with no
> > > > > -        * parent is added into 'list'.
> > > > > +        * Find a and b such that if they are a child of each oth=
er a and b's
> > > > > +        * tid's match, otherwise a and b have a common parent an=
d distinct
> > > > > +        * tid's to sort by. First make the depths of the threads=
 match.
> > > > >          */
> > > > > -       for (itask =3D 0; itask < nr; itask++) {
> > > > > -               task =3D tasks + itask;
> > > > > -
> > > > > -               if (!list_empty(&task->list))
> > > > > -                       continue;
> > > > > -
> > > > > -               task =3D tasks_list(task, machine);
> > > > > -               if (IS_ERR(task)) {
> > > > > -                       pr_err("Error: failed to process tasks\n"=
);
> > > > > -                       free(tasks);
> > > > > -                       return PTR_ERR(task);
> > > > > +       level_a =3D thread_level(machine, a);
> > > > > +       level_b =3D thread_level(machine, b);
> > > > > +       a =3D thread__get(a);
> > > > > +       b =3D thread__get(b);
> > > > > +       for (int i =3D level_a; i > level_b; i--) {
> > > > > +               struct thread *parent =3D machine__find_thread(ma=
chine, -1, thread__ppid(a));
> > > > > +
> > > > > +               thread__put(a);
> > > > > +               if (!parent) {
> > > > > +                       pr_err("Missing parent thread of %d\n", t=
hread__tid(a));
> > > > > +                       thread__put(b);
> > > > > +                       return -1;
> > > > >                 }
> > > > > +               a =3D parent;
> > > > > +       }
> > > > > +       for (int i =3D level_b; i > level_a; i--) {
> > > > > +               struct thread *parent =3D machine__find_thread(ma=
chine, -1, thread__ppid(b));
> > > > >
> > > > > -               if (task)
> > > > > -                       list_add_tail(&task->list, &list);
> > > > > +               thread__put(b);
> > > > > +               if (!parent) {
> > > > > +                       pr_err("Missing parent thread of %d\n", t=
hread__tid(b));
> > > > > +                       thread__put(a);
> > > > > +                       return 1;
> > > > > +               }
> > > > > +               b =3D parent;
> > > > > +       }
> > > > > +       /* Search up to a common parent. */
> > > > > +       while (thread__ppid(a) !=3D thread__ppid(b)) {
> > > > > +               struct thread *parent;
> > > > > +
> > > > > +               parent =3D machine__find_thread(machine, -1, thre=
ad__ppid(a));
> > > > > +               thread__put(a);
> > > > > +               if (!parent)
> > > > > +                       pr_err("Missing parent thread of %d\n", t=
hread__tid(a));
> > > > > +               a =3D parent;
> > > > > +               parent =3D machine__find_thread(machine, -1, thre=
ad__ppid(b));
> > > > > +               thread__put(b);
> > > > > +               if (!parent)
> > > > > +                       pr_err("Missing parent thread of %d\n", t=
hread__tid(b));
> > > > > +               b =3D parent;
> > > > > +               if (!a || !b)
> > > > > +                       return !a && !b ? 0 : (!a ? -1 : 1);
> > > >
> > > > Wouldn't it leak a refcount if either a or b is NULL (not both)?
> > >
> > > It would, but this would be an error condition anyway. I can add puts=
.
> > >
> > > >
> > > > > +       }
> > > > > +       if (thread__tid(a) =3D=3D thread__tid(b)) {
> > > > > +               /* a is a child of b or vice-versa, deeper levels=
 appear later. */
> > > > > +               res =3D level_a < level_b ? -1 : (level_a > level=
_b ? 1 : 0);
> > > > > +       } else {
> > > > > +               /* Sort by tid now the parent is the same. */
> > > > > +               res =3D thread__tid(a) < thread__tid(b) ? -1 : 1;
> > > > >         }
> > > > > +       thread__put(a);
> > > > > +       thread__put(b);
> > > > > +       return res;
> > > > > +}
> > > > > +
> > > > > +static int tasks_print(struct report *rep, FILE *fp)
> > > > > +{
> > > > > +       struct machine *machine =3D &rep->session->machines.host;
> > > > > +       LIST_HEAD(tasks);
> > > > > +       int ret;
> > > > >
> > > > > -       fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppid", =
"comm");
> > > > > +       ret =3D machine__thread_list(machine, &tasks);
> > > > > +       if (!ret) {
> > > > > +               struct thread_list *task;
> > > >
> > > > Do we really need this thread_list?  Why not use an
> > > > array of threads directly?
> > >
> > > The code isn't particularly performance critical. I used a list as it
> > > best approximated how the rbtree was being used. The code is reused i=
n
> > > subsequent patches, there's no initial pass to size an array and I
> > > think the reallocarray/qsort logic is generally more problematic than
> > > the list ones. If we were worried about performance then I think
> > > arrays could make sense for optimization, but I think this is good
> > > enough for now.
> >
> > Well, it's not about performance.  It made me think why we need
> > this thread_list but I couldn't find the reason.  If you can move
> > machine__threads_nr() here then you won't need realloc().
>
> But then you can race between allocating an array and traversing to
> fill it in. Using realloc in the iterator callback would avoid this
> but with capacity tracking, etc. If this were C++ its a call between a
> std::vector and a std::list, and std::vector would win that race there
> (imo). Here we're moving from code that was working on sorted tree
> nodes in code that tends to more heavily use lists. I wanted the
> transition from the rbtree nodes to list nodes to be as small as
> possible in the changes to the APIs that did strange things to the
> threads tree (resorting it). Moving to an array with indices would
> require more tracking and be a larger change in general. The array
> could move because of a realloc, whilst nodes wouldn't, etc. Having
> the code now work on a list its easier to see how it can migrate to an
> array, but that can be follow on work. I'm not sure we're motivated to
> do it given there's no code on a performance critical path.

Ok, as you said it's not a critical path.  I'm ok with this change.

Thanks,
Namhyung

