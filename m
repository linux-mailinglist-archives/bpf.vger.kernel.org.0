Return-Path: <bpf+bounces-22767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E02D8689D0
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 08:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67E7285714
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 07:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ED354BC8;
	Tue, 27 Feb 2024 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2kjWd075"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B853E36
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018684; cv=none; b=cPhIvflvq5vh3NoAAbDASzvHdoDaGoLtf+iTW0zsTNrG6rptZ6PscYZG8O6+q5Et9iheAHB8wnrhz1VmG8xd9Vtcz8BzUiqYXYY4iSqRuuLPNj/v6d1zHp3qY0T2Q5174pFb3tVpM1TfhyGRS2Fs46PHovOfjPJ2DkKKlGNmR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018684; c=relaxed/simple;
	bh=4A8EcY/zAHPKC2C0hymoe2B8x3j3OXvU5Dz5KwfL7Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmFsiiaMOSpPityrTRAPT4iyZZTmrTqUjqkyMbbnJv/XJJ9UQ7K49wCjQLmPrc2cdHH37LzJzFs2863CXOzwAidCnSXsRu+Lo3ECjmbK9FqZKScnVYJogqtst16k1O+t6P8nhsNC/yUL7sjsyBylrMMYzfBN6sPT1fRuIFyoygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2kjWd075; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc744f54d0so101935ad.0
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 23:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709018682; x=1709623482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGmmFD6VdtvwNnv2X5OzWAQwXsuV3gU6fcFHMRZaCJY=;
        b=2kjWd075SfXEhyj/V5NIxsn5P4FWhueXuQMUd5QvrKRnIAGR45n3cGht2ubcFWwWXi
         LFW60FVtgDyVJIRgfGF2TddVgt9xIHjsj6wiQ9z6+RaLP2oyXN1BBZeyVKJgiq1Gg3Co
         Y26p4nlSmuG7TJH+owWGjOGRwrqRMVsW8yM0J2lwA4ub1SoQvRDuwuA0nmWNZjVSsoey
         sSbdFGrwtZo7Cxu4BdtmiNxYjMB9KYYGQCjuQ15Jm7beEfYEu4AutmXUzy/iockANs6m
         RdQFG+ypHIljjIA7rlweXZfP6RNZebfyk+EqQIeRTuT1gm0FNDxRn64SpUvhrcqzoXXs
         GC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709018682; x=1709623482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGmmFD6VdtvwNnv2X5OzWAQwXsuV3gU6fcFHMRZaCJY=;
        b=dE7lSsuRBjw83WQowaJCugeBL83IxKMI3+TNs6wBcJWtiu09wTWRJGs7udhcD8cOqD
         u++UHzNsLJ9quJVCoYn1gdAgEJyWD6Pa4QYkQ01oBNyF6nkFDQsQ4Lz+XmmN9CGWriVr
         7lH8NPxpL6QV3Hog7WAgHKfhB/m+zVKm72BI3qzOSFKYr3z2lh/8H0bd8SFbYS27Cz0m
         acSPk+d7+P5SEkXrfwSewfoDzPodzsJG6j5VY1NUcxW3lndwCJoiDRPOoFcdreSqHoHr
         5EhPpUnZmB5tRmDFKb+lcMvMdfVKJ8T7K6JDPBe7ImxK4odLWOiSWEx6NkHMT6UwbCnF
         wDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmrffMUPQpzKxQOAde+kwwYjrm1aQ4MIpjNb3/35Uyx3OMHftm6o/SsBTRQHEeYLDY8St+/ullvOC07n9X2Y8hkMFF
X-Gm-Message-State: AOJu0Yzon+T9TtwlzOmWY3vZruuUBx7jYxCD/JYcfkFob5Dhc9U4kaGz
	axIeT8iieAx+cgBiyrbNoUewi0s4Nzz+EddBw1rDuqs+aCdnMhqTTcGODl9g6Zr2J0/pTLREwQk
	zg5JK1gq6xVBymusLNzPhOzCpA7ZgRiOJfo3r
X-Google-Smtp-Source: AGHT+IEMFKmVxGvCZk8yC+No7EN4KW3T+rZiWqbqXtCFP58KcD9E97sZI+mpYjRrvWkvDI8yS1z43P2Naz6y2VZeGIA=
X-Received: by 2002:a17:903:94b:b0:1dc:b16c:63b3 with SMTP id
 ma11-20020a170903094b00b001dcb16c63b3mr185134plb.18.1709018681415; Mon, 26
 Feb 2024 23:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-5-irogers@google.com>
 <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com>
In-Reply-To: <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Feb 2024 23:24:27 -0800
Message-ID: <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf threads: Move threads to its own files
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 11:07=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Move threads out of machine and move thread_rb_node into the C
> > file. This hides the implementation of threads from the rest of the
> > code allowing for it to be refactored.
> >
> > Locking discipline is tightened up in this change.
>
> Doesn't look like a simple code move.  Can we split the locking
> change from the move to make the reviewer's life a bit easier? :)

Not sure I follow. Take threads_nr as an example.

The old code is in machine.c, so:
-static size_t machine__threads_nr(const struct machine *machine)
-{
-       size_t nr =3D 0;
-
-       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++)
-               nr +=3D machine->threads[i].nr;
-
-       return nr;
-}

The new code is in threads.c:
+size_t threads__nr(struct threads *threads)
+{
+       size_t nr =3D 0;
+
+       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
+               struct threads_table_entry *table =3D &threads->table[i];
+
+               down_read(&table->lock);
+               nr +=3D table->nr;
+               up_read(&table->lock);
+       }
+       return nr;
+}

So it is a copy paste from one file to the other. The only difference
is that the old code failed to take a lock when reading "nr" so the
locking is added. I wanted to make sure all the functions in threads.c
were properly correct wrt locking, semaphore creation and destruction,
etc.  We could have a broken threads.c and fix it in the next change,
but given that's a bug it could make bisection more difficult.
Ultimately I thought the locking changes were small enough to not
warrant being on their own compared to the advantages of having a sane
threads abstraction.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/Build                 |   1 +
> >  tools/perf/util/bpf_lock_contention.c |   8 +-
> >  tools/perf/util/machine.c             | 287 ++++----------------------
> >  tools/perf/util/machine.h             |  20 +-
> >  tools/perf/util/thread.c              |   2 +-
> >  tools/perf/util/thread.h              |   6 -
> >  tools/perf/util/threads.c             | 244 ++++++++++++++++++++++
> >  tools/perf/util/threads.h             |  35 ++++
> >  8 files changed, 325 insertions(+), 278 deletions(-)
> >  create mode 100644 tools/perf/util/threads.c
> >  create mode 100644 tools/perf/util/threads.h
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 8027f450fa3e..a0e8cd68d490 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -71,6 +71,7 @@ perf-y +=3D ordered-events.o
> >  perf-y +=3D namespaces.o
> >  perf-y +=3D comm.o
> >  perf-y +=3D thread.o
> > +perf-y +=3D threads.o
> >  perf-y +=3D thread_map.o
> >  perf-y +=3D parse-events-flex.o
> >  perf-y +=3D parse-events-bison.o
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bp=
f_lock_contention.c
> > index 31ff19afc20c..3992c8a9fd96 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -210,7 +210,7 @@ static const char *lock_contention_get_name(struct =
lock_contention *con,
> >
> >                 /* do not update idle comm which contains CPU number */
> >                 if (pid) {
> > -                       struct thread *t =3D __machine__findnew_thread(=
machine, /*pid=3D*/-1, pid);
> > +                       struct thread *t =3D machine__findnew_thread(ma=
chine, /*pid=3D*/-1, pid);
> >
> >                         if (t =3D=3D NULL)
> >                                 return name;
> > @@ -302,9 +302,9 @@ int lock_contention_read(struct lock_contention *co=
n)
> >                 return -1;
> >
> >         if (con->aggr_mode =3D=3D LOCK_AGGR_TASK) {
> > -               struct thread *idle =3D __machine__findnew_thread(machi=
ne,
> > -                                                               /*pid=
=3D*/0,
> > -                                                               /*tid=
=3D*/0);
> > +               struct thread *idle =3D machine__findnew_thread(machine=
,
> > +                                                             /*pid=3D*=
/0,
> > +                                                             /*tid=3D*=
/0);
> >                 thread__set_comm(idle, "swapper", /*timestamp=3D*/0);
> >         }
> >
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index e072b2115b64..e668a97255f8 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -43,9 +43,6 @@
> >  #include <linux/string.h>
> >  #include <linux/zalloc.h>
> >
> > -static void __machine__remove_thread(struct machine *machine, struct t=
hread_rb_node *nd,
> > -                                    struct thread *th, bool lock);
> > -
> >  static struct dso *machine__kernel_dso(struct machine *machine)
> >  {
> >         return map__dso(machine->vmlinux_map);
> > @@ -58,35 +55,6 @@ static void dsos__init(struct dsos *dsos)
> >         init_rwsem(&dsos->lock);
> >  }
> >
> > -static void machine__threads_init(struct machine *machine)
> > -{
> > -       int i;
> > -
> > -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > -               struct threads *threads =3D &machine->threads[i];
> > -               threads->entries =3D RB_ROOT_CACHED;
> > -               init_rwsem(&threads->lock);
> > -               threads->nr =3D 0;
> > -               threads->last_match =3D NULL;
> > -       }
> > -}
> > -
> > -static int thread_rb_node__cmp_tid(const void *key, const struct rb_no=
de *nd)
> > -{
> > -       int to_find =3D (int) *((pid_t *)key);
> > -
> > -       return to_find - (int)thread__tid(rb_entry(nd, struct thread_rb=
_node, rb_node)->thread);
> > -}
> > -
> > -static struct thread_rb_node *thread_rb_node__find(const struct thread=
 *th,
> > -                                                  struct rb_root *tree=
)
> > -{
> > -       pid_t to_find =3D thread__tid(th);
> > -       struct rb_node *nd =3D rb_find(&to_find, tree, thread_rb_node__=
cmp_tid);
> > -
> > -       return rb_entry(nd, struct thread_rb_node, rb_node);
> > -}
> > -
> >  static int machine__set_mmap_name(struct machine *machine)
> >  {
> >         if (machine__is_host(machine))
> > @@ -120,7 +88,7 @@ int machine__init(struct machine *machine, const cha=
r *root_dir, pid_t pid)
> >         RB_CLEAR_NODE(&machine->rb_node);
> >         dsos__init(&machine->dsos);
> >
> > -       machine__threads_init(machine);
> > +       threads__init(&machine->threads);
> >
> >         machine->vdso_info =3D NULL;
> >         machine->env =3D NULL;
> > @@ -221,27 +189,11 @@ static void dsos__exit(struct dsos *dsos)
> >
> >  void machine__delete_threads(struct machine *machine)
> >  {
> > -       struct rb_node *nd;
> > -       int i;
> > -
> > -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > -               struct threads *threads =3D &machine->threads[i];
> > -               down_write(&threads->lock);
> > -               nd =3D rb_first_cached(&threads->entries);
> > -               while (nd) {
> > -                       struct thread_rb_node *trb =3D rb_entry(nd, str=
uct thread_rb_node, rb_node);
> > -
> > -                       nd =3D rb_next(nd);
> > -                       __machine__remove_thread(machine, trb, trb->thr=
ead, false);
> > -               }
> > -               up_write(&threads->lock);
> > -       }
> > +       threads__remove_all_threads(&machine->threads);
> >  }
> >
> >  void machine__exit(struct machine *machine)
> >  {
> > -       int i;
> > -
> >         if (machine =3D=3D NULL)
> >                 return;
> >
> > @@ -254,12 +206,7 @@ void machine__exit(struct machine *machine)
> >         zfree(&machine->current_tid);
> >         zfree(&machine->kallsyms_filename);
> >
> > -       machine__delete_threads(machine);
> > -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > -               struct threads *threads =3D &machine->threads[i];
> > -
> > -               exit_rwsem(&threads->lock);
> > -       }
> > +       threads__exit(&machine->threads);
> >  }
> >
> >  void machine__delete(struct machine *machine)
> > @@ -526,7 +473,7 @@ static void machine__update_thread_pid(struct machi=
ne *machine,
> >         if (thread__pid(th) =3D=3D thread__tid(th))
> >                 return;
> >
> > -       leader =3D __machine__findnew_thread(machine, thread__pid(th), =
thread__pid(th));
> > +       leader =3D machine__findnew_thread(machine, thread__pid(th), th=
read__pid(th));
> >         if (!leader)
> >                 goto out_err;
> >
> > @@ -560,160 +507,55 @@ static void machine__update_thread_pid(struct ma=
chine *machine,
> >         goto out_put;
> >  }
> >
> > -/*
> > - * Front-end cache - TID lookups come in blocks,
> > - * so most of the time we dont have to look up
> > - * the full rbtree:
> > - */
> > -static struct thread*
> > -__threads__get_last_match(struct threads *threads, struct machine *mac=
hine,
> > -                         int pid, int tid)
> > -{
> > -       struct thread *th;
> > -
> > -       th =3D threads->last_match;
> > -       if (th !=3D NULL) {
> > -               if (thread__tid(th) =3D=3D tid) {
> > -                       machine__update_thread_pid(machine, th, pid);
> > -                       return thread__get(th);
> > -               }
> > -               thread__put(threads->last_match);
> > -               threads->last_match =3D NULL;
> > -       }
> > -
> > -       return NULL;
> > -}
> > -
> > -static struct thread*
> > -threads__get_last_match(struct threads *threads, struct machine *machi=
ne,
> > -                       int pid, int tid)
> > -{
> > -       struct thread *th =3D NULL;
> > -
> > -       if (perf_singlethreaded)
> > -               th =3D __threads__get_last_match(threads, machine, pid,=
 tid);
> > -
> > -       return th;
> > -}
> > -
> > -static void
> > -__threads__set_last_match(struct threads *threads, struct thread *th)
> > -{
> > -       thread__put(threads->last_match);
> > -       threads->last_match =3D thread__get(th);
> > -}
> > -
> > -static void
> > -threads__set_last_match(struct threads *threads, struct thread *th)
> > -{
> > -       if (perf_singlethreaded)
> > -               __threads__set_last_match(threads, th);
> > -}
> > -
> >  /*
> >   * Caller must eventually drop thread->refcnt returned with a successf=
ul
> >   * lookup/new thread inserted.
> >   */
> > -static struct thread *____machine__findnew_thread(struct machine *mach=
ine,
> > -                                                 struct threads *threa=
ds,
> > -                                                 pid_t pid, pid_t tid,
> > -                                                 bool create)
> > +static struct thread *__machine__findnew_thread(struct machine *machin=
e,
> > +                                               pid_t pid,
> > +                                               pid_t tid,
> > +                                               bool create)
> >  {
> > -       struct rb_node **p =3D &threads->entries.rb_root.rb_node;
> > -       struct rb_node *parent =3D NULL;
> > -       struct thread *th;
> > -       struct thread_rb_node *nd;
> > -       bool leftmost =3D true;
> > +       struct thread *th =3D threads__find(&machine->threads, tid);
> > +       bool created;
> >
> > -       th =3D threads__get_last_match(threads, machine, pid, tid);
> > -       if (th)
> > +       if (th) {
> > +               machine__update_thread_pid(machine, th, pid);
> >                 return th;
> > -
> > -       while (*p !=3D NULL) {
> > -               parent =3D *p;
> > -               th =3D rb_entry(parent, struct thread_rb_node, rb_node)=
->thread;
> > -
> > -               if (thread__tid(th) =3D=3D tid) {
> > -                       threads__set_last_match(threads, th);
> > -                       machine__update_thread_pid(machine, th, pid);
> > -                       return thread__get(th);
> > -               }
> > -
> > -               if (tid < thread__tid(th))
> > -                       p =3D &(*p)->rb_left;
> > -               else {
> > -                       p =3D &(*p)->rb_right;
> > -                       leftmost =3D false;
> > -               }
> >         }
> > -
> >         if (!create)
> >                 return NULL;
> >
> > -       th =3D thread__new(pid, tid);
> > -       if (th =3D=3D NULL)
> > -               return NULL;
> > -
> > -       nd =3D malloc(sizeof(*nd));
> > -       if (nd =3D=3D NULL) {
> > -               thread__put(th);
> > -               return NULL;
> > -       }
> > -       nd->thread =3D th;
> > -
> > -       rb_link_node(&nd->rb_node, parent, p);
> > -       rb_insert_color_cached(&nd->rb_node, &threads->entries, leftmos=
t);
> > -       /*
> > -        * We have to initialize maps separately after rb tree is updat=
ed.
> > -        *
> > -        * The reason is that we call machine__findnew_thread within
> > -        * thread__init_maps to find the thread leader and that would s=
crewed
> > -        * the rb tree.
> > -        */
> > -       if (thread__init_maps(th, machine)) {
> > -               pr_err("Thread init failed thread %d\n", pid);
> > -               rb_erase_cached(&nd->rb_node, &threads->entries);
> > -               RB_CLEAR_NODE(&nd->rb_node);
> > -               free(nd);
> > -               thread__put(th);
> > -               return NULL;
> > -       }
> > -       /*
> > -        * It is now in the rbtree, get a ref
> > -        */
> > -       threads__set_last_match(threads, th);
> > -       ++threads->nr;
> > -
> > -       return thread__get(th);
> > -}
> > +       th =3D threads__findnew(&machine->threads, pid, tid, &created);
> > +       if (created) {
> > +               /*
> > +                * We have to initialize maps separately after rb tree =
is
> > +                * updated.
> > +                *
> > +                * The reason is that we call machine__findnew_thread w=
ithin
> > +                * thread__init_maps to find the thread leader and that=
 would
> > +                * screwed the rb tree.
> > +                */
> > +               if (thread__init_maps(th, machine)) {
> > +                       pr_err("Thread init failed thread %d\n", pid);
> > +                       threads__remove(&machine->threads, th);
> > +                       thread__put(th);
> > +                       return NULL;
> > +               }
> > +       } else
> > +               machine__update_thread_pid(machine, th, pid);
> >
> > -struct thread *__machine__findnew_thread(struct machine *machine, pid_=
t pid, pid_t tid)
> > -{
> > -       return ____machine__findnew_thread(machine, machine__threads(ma=
chine, tid), pid, tid, true);
> > +       return th;
> >  }
> >
> > -struct thread *machine__findnew_thread(struct machine *machine, pid_t =
pid,
> > -                                      pid_t tid)
> > +struct thread *machine__findnew_thread(struct machine *machine, pid_t =
pid, pid_t tid)
> >  {
> > -       struct threads *threads =3D machine__threads(machine, tid);
> > -       struct thread *th;
> > -
> > -       down_write(&threads->lock);
> > -       th =3D __machine__findnew_thread(machine, pid, tid);
> > -       up_write(&threads->lock);
> > -       return th;
> > +       return __machine__findnew_thread(machine, pid, tid, /*create=3D=
*/true);
> >  }
> >
> > -struct thread *machine__find_thread(struct machine *machine, pid_t pid=
,
> > -                                   pid_t tid)
> > +struct thread *machine__find_thread(struct machine *machine, pid_t pid=
, pid_t tid)
> >  {
> > -       struct threads *threads =3D machine__threads(machine, tid);
> > -       struct thread *th;
> > -
> > -       down_read(&threads->lock);
> > -       th =3D  ____machine__findnew_thread(machine, threads, pid, tid,=
 false);
> > -       up_read(&threads->lock);
> > -       return th;
> > +       return __machine__findnew_thread(machine, pid, tid, /*create=3D=
*/false);
> >  }
> >
> >  /*
> > @@ -1127,23 +969,13 @@ static int machine_fprintf_cb(struct thread *thr=
ead, void *data)
> >         return 0;
> >  }
> >
> > -static size_t machine__threads_nr(const struct machine *machine)
> > -{
> > -       size_t nr =3D 0;
> > -
> > -       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++)
> > -               nr +=3D machine->threads[i].nr;
> > -
> > -       return nr;
> > -}
> > -
> >  size_t machine__fprintf(struct machine *machine, FILE *fp)
> >  {
> >         struct machine_fprintf_cb_args args =3D {
> >                 .fp =3D fp,
> >                 .printed =3D 0,
> >         };
> > -       size_t ret =3D fprintf(fp, "Threads: %zu\n", machine__threads_n=
r(machine));
> > +       size_t ret =3D fprintf(fp, "Threads: %zu\n", threads__nr(&machi=
ne->threads));
> >
> >         machine__for_each_thread(machine, machine_fprintf_cb, &args);
> >         return ret + args.printed;
> > @@ -2069,36 +1901,9 @@ int machine__process_mmap_event(struct machine *=
machine, union perf_event *event
> >         return 0;
> >  }
> >
> > -static void __machine__remove_thread(struct machine *machine, struct t=
hread_rb_node *nd,
> > -                                    struct thread *th, bool lock)
> > -{
> > -       struct threads *threads =3D machine__threads(machine, thread__t=
id(th));
> > -
> > -       if (!nd)
> > -               nd =3D thread_rb_node__find(th, &threads->entries.rb_ro=
ot);
> > -
> > -       if (threads->last_match && RC_CHK_EQUAL(threads->last_match, th=
))
> > -               threads__set_last_match(threads, NULL);
> > -
> > -       if (lock)
> > -               down_write(&threads->lock);
> > -
> > -       BUG_ON(refcount_read(thread__refcnt(th)) =3D=3D 0);
> > -
> > -       thread__put(nd->thread);
> > -       rb_erase_cached(&nd->rb_node, &threads->entries);
> > -       RB_CLEAR_NODE(&nd->rb_node);
> > -       --threads->nr;
> > -
> > -       free(nd);
> > -
> > -       if (lock)
> > -               up_write(&threads->lock);
> > -}
> > -
> >  void machine__remove_thread(struct machine *machine, struct thread *th=
)
> >  {
> > -       return __machine__remove_thread(machine, NULL, th, true);
> > +       return threads__remove(&machine->threads, th);
> >  }
> >
> >  int machine__process_fork_event(struct machine *machine, union perf_ev=
ent *event,
> > @@ -3232,23 +3037,7 @@ int machine__for_each_thread(struct machine *mac=
hine,
> >                              int (*fn)(struct thread *thread, void *p),
> >                              void *priv)
> >  {
> > -       struct threads *threads;
> > -       struct rb_node *nd;
> > -       int rc =3D 0;
> > -       int i;
> > -
> > -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > -               threads =3D &machine->threads[i];
> > -               for (nd =3D rb_first_cached(&threads->entries); nd;
> > -                    nd =3D rb_next(nd)) {
> > -                       struct thread_rb_node *trb =3D rb_entry(nd, str=
uct thread_rb_node, rb_node);
> > -
> > -                       rc =3D fn(trb->thread, priv);
> > -                       if (rc !=3D 0)
> > -                               return rc;
> > -               }
> > -       }
> > -       return rc;
> > +       return threads__for_each_thread(&machine->threads, fn, priv);
> >  }
> >
> >  int machines__for_each_thread(struct machines *machines,
> > diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> > index b738ce84817b..e28c787616fe 100644
> > --- a/tools/perf/util/machine.h
> > +++ b/tools/perf/util/machine.h
> > @@ -7,6 +7,7 @@
> >  #include "maps.h"
> >  #include "dsos.h"
> >  #include "rwsem.h"
> > +#include "threads.h"
> >
> >  struct addr_location;
> >  struct branch_stack;
> > @@ -28,16 +29,6 @@ extern const char *ref_reloc_sym_names[];
> >
> >  struct vdso_info;
> >
> > -#define THREADS__TABLE_BITS    8
> > -#define THREADS__TABLE_SIZE    (1 << THREADS__TABLE_BITS)
> > -
> > -struct threads {
> > -       struct rb_root_cached  entries;
> > -       struct rw_semaphore    lock;
> > -       unsigned int           nr;
> > -       struct thread          *last_match;
> > -};
> > -
> >  struct machine {
> >         struct rb_node    rb_node;
> >         pid_t             pid;
> > @@ -48,7 +39,7 @@ struct machine {
> >         char              *root_dir;
> >         char              *mmap_name;
> >         char              *kallsyms_filename;
> > -       struct threads    threads[THREADS__TABLE_SIZE];
> > +       struct threads    threads;
> >         struct vdso_info  *vdso_info;
> >         struct perf_env   *env;
> >         struct dsos       dsos;
> > @@ -69,12 +60,6 @@ struct machine {
> >         bool              trampolines_mapped;
> >  };
> >
> > -static inline struct threads *machine__threads(struct machine *machine=
, pid_t tid)
> > -{
> > -       /* Cast it to handle tid =3D=3D -1 */
> > -       return &machine->threads[(unsigned int)tid % THREADS__TABLE_SIZ=
E];
> > -}
> > -
> >  /*
> >   * The main kernel (vmlinux) map
> >   */
> > @@ -220,7 +205,6 @@ bool machine__is(struct machine *machine, const cha=
r *arch);
> >  bool machine__normalized_is(struct machine *machine, const char *arch)=
;
> >  int machine__nr_cpus_avail(struct machine *machine);
> >
> > -struct thread *__machine__findnew_thread(struct machine *machine, pid_=
t pid, pid_t tid);
> >  struct thread *machine__findnew_thread(struct machine *machine, pid_t =
pid, pid_t tid);
> >
> >  struct dso *machine__findnew_dso_id(struct machine *machine, const cha=
r *filename, struct dso_id *id);
> > diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> > index c59ab4d79163..1aa8962dcf52 100644
> > --- a/tools/perf/util/thread.c
> > +++ b/tools/perf/util/thread.c
> > @@ -26,7 +26,7 @@ int thread__init_maps(struct thread *thread, struct m=
achine *machine)
> >         if (pid =3D=3D thread__tid(thread) || pid =3D=3D -1) {
> >                 thread__set_maps(thread, maps__new(machine));
> >         } else {
> > -               struct thread *leader =3D __machine__findnew_thread(mac=
hine, pid, pid);
> > +               struct thread *leader =3D machine__findnew_thread(machi=
ne, pid, pid);
> >
> >                 if (leader) {
> >                         thread__set_maps(thread, maps__get(thread__maps=
(leader)));
> > diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> > index 0df775b5c110..4b8f3e9e513b 100644
> > --- a/tools/perf/util/thread.h
> > +++ b/tools/perf/util/thread.h
> > @@ -3,7 +3,6 @@
> >  #define __PERF_THREAD_H
> >
> >  #include <linux/refcount.h>
> > -#include <linux/rbtree.h>
> >  #include <linux/list.h>
> >  #include <stdio.h>
> >  #include <unistd.h>
> > @@ -30,11 +29,6 @@ struct lbr_stitch {
> >         struct callchain_cursor_node    *prev_lbr_cursor;
> >  };
> >
> > -struct thread_rb_node {
> > -       struct rb_node rb_node;
> > -       struct thread *thread;
> > -};
> > -
> >  DECLARE_RC_STRUCT(thread) {
> >         /** @maps: mmaps associated with this thread. */
> >         struct maps             *maps;
> > diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
> > new file mode 100644
> > index 000000000000..d984ec939c7b
> > --- /dev/null
> > +++ b/tools/perf/util/threads.c
> > @@ -0,0 +1,244 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "threads.h"
> > +#include "machine.h"
> > +#include "thread.h"
> > +
> > +struct thread_rb_node {
> > +       struct rb_node rb_node;
> > +       struct thread *thread;
> > +};
> > +
> > +static struct threads_table_entry *threads__table(struct threads *thre=
ads, pid_t tid)
> > +{
> > +       /* Cast it to handle tid =3D=3D -1 */
> > +       return &threads->table[(unsigned int)tid % THREADS__TABLE_SIZE]=
;
> > +}
> > +
> > +void threads__init(struct threads *threads)
> > +{
> > +       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > +               struct threads_table_entry *table =3D &threads->table[i=
];
> > +
> > +               table->entries =3D RB_ROOT_CACHED;
> > +               init_rwsem(&table->lock);
> > +               table->nr =3D 0;
> > +               table->last_match =3D NULL;
> > +       }
> > +}
> > +
> > +void threads__exit(struct threads *threads)
> > +{
> > +       threads__remove_all_threads(threads);
> > +       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > +               struct threads_table_entry *table =3D &threads->table[i=
];
> > +
> > +               exit_rwsem(&table->lock);
> > +       }
> > +}
> > +
> > +size_t threads__nr(struct threads *threads)
> > +{
> > +       size_t nr =3D 0;
> > +
> > +       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > +               struct threads_table_entry *table =3D &threads->table[i=
];
> > +
> > +               down_read(&table->lock);
> > +               nr +=3D table->nr;
> > +               up_read(&table->lock);
> > +       }
> > +       return nr;
> > +}
> > +
> > +/*
> > + * Front-end cache - TID lookups come in blocks,
> > + * so most of the time we dont have to look up
> > + * the full rbtree:
> > + */
> > +static struct thread *__threads_table_entry__get_last_match(struct thr=
eads_table_entry *table,
> > +                                                           pid_t tid)
> > +{
> > +       struct thread *th, *res =3D NULL;
> > +
> > +       th =3D table->last_match;
> > +       if (th !=3D NULL) {
> > +               if (thread__tid(th) =3D=3D tid)
> > +                       res =3D thread__get(th);
> > +       }
> > +       return res;
> > +}
> > +
> > +static void __threads_table_entry__set_last_match(struct threads_table=
_entry *table,
> > +                                                 struct thread *th)
> > +{
> > +       thread__put(table->last_match);
> > +       table->last_match =3D thread__get(th);
> > +}
> > +
> > +static void threads_table_entry__set_last_match(struct threads_table_e=
ntry *table,
> > +                                               struct thread *th)
> > +{
> > +       down_write(&table->lock);
> > +       __threads_table_entry__set_last_match(table, th);
> > +       up_write(&table->lock);
> > +}
> > +
> > +struct thread *threads__find(struct threads *threads, pid_t tid)
> > +{
> > +       struct threads_table_entry *table  =3D threads__table(threads, =
tid);
> > +       struct rb_node **p;
> > +       struct thread *res =3D NULL;
> > +
> > +       down_read(&table->lock);
> > +       res =3D __threads_table_entry__get_last_match(table, tid);
> > +       if (res)
> > +               return res;
> > +
> > +       p =3D &table->entries.rb_root.rb_node;
> > +       while (*p !=3D NULL) {
> > +               struct rb_node *parent =3D *p;
> > +               struct thread *th =3D rb_entry(parent, struct thread_rb=
_node, rb_node)->thread;
> > +
> > +               if (thread__tid(th) =3D=3D tid) {
> > +                       res =3D thread__get(th);
> > +                       break;
> > +               }
> > +
> > +               if (tid < thread__tid(th))
> > +                       p =3D &(*p)->rb_left;
> > +               else
> > +                       p =3D &(*p)->rb_right;
> > +       }
> > +       up_read(&table->lock);
> > +       if (res)
> > +               threads_table_entry__set_last_match(table, res);
> > +       return res;
> > +}
> > +
> > +struct thread *threads__findnew(struct threads *threads, pid_t pid, pi=
d_t tid, bool *created)
> > +{
> > +       struct threads_table_entry *table  =3D threads__table(threads, =
tid);
> > +       struct rb_node **p;
> > +       struct rb_node *parent =3D NULL;
> > +       struct thread *res =3D NULL;
> > +       struct thread_rb_node *nd;
> > +       bool leftmost =3D true;
> > +
> > +       *created =3D false;
> > +       down_write(&table->lock);
> > +       p =3D &table->entries.rb_root.rb_node;
> > +       while (*p !=3D NULL) {
> > +               struct thread *th;
> > +
> > +               parent =3D *p;
> > +               th =3D rb_entry(parent, struct thread_rb_node, rb_node)=
->thread;
> > +
> > +               if (thread__tid(th) =3D=3D tid) {
> > +                       __threads_table_entry__set_last_match(table, th=
);
> > +                       res =3D thread__get(th);
> > +                       goto out_unlock;
> > +               }
> > +
> > +               if (tid < thread__tid(th))
> > +                       p =3D &(*p)->rb_left;
> > +               else {
> > +                       leftmost =3D false;
> > +                       p =3D &(*p)->rb_right;
> > +               }
> > +       }
> > +       nd =3D malloc(sizeof(*nd));
> > +       if (nd =3D=3D NULL)
> > +               goto out_unlock;
> > +       res =3D thread__new(pid, tid);
> > +       if (!res)
> > +               free(nd);
> > +       else {
> > +               *created =3D true;
> > +               nd->thread =3D thread__get(res);
> > +               rb_link_node(&nd->rb_node, parent, p);
> > +               rb_insert_color_cached(&nd->rb_node, &table->entries, l=
eftmost);
> > +               ++table->nr;
> > +               __threads_table_entry__set_last_match(table, res);
> > +       }
> > +out_unlock:
> > +       up_write(&table->lock);
> > +       return res;
> > +}
> > +
> > +void threads__remove_all_threads(struct threads *threads)
> > +{
> > +       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > +               struct threads_table_entry *table =3D &threads->table[i=
];
> > +               struct rb_node *nd;
> > +
> > +               down_write(&table->lock);
> > +               __threads_table_entry__set_last_match(table, NULL);
> > +               nd =3D rb_first_cached(&table->entries);
> > +               while (nd) {
> > +                       struct thread_rb_node *trb =3D rb_entry(nd, str=
uct thread_rb_node, rb_node);
> > +
> > +                       nd =3D rb_next(nd);
> > +                       thread__put(trb->thread);
> > +                       rb_erase_cached(&trb->rb_node, &table->entries)=
;
> > +                       RB_CLEAR_NODE(&trb->rb_node);
> > +                       --table->nr;
> > +
> > +                       free(trb);
> > +               }
> > +               assert(table->nr =3D=3D 0);
> > +               up_write(&table->lock);
> > +       }
> > +}
> > +
> > +void threads__remove(struct threads *threads, struct thread *thread)
> > +{
> > +       struct rb_node **p;
> > +       struct threads_table_entry *table  =3D threads__table(threads, =
thread__tid(thread));
> > +       pid_t tid =3D thread__tid(thread);
> > +
> > +       down_write(&table->lock);
> > +       if (table->last_match && RC_CHK_EQUAL(table->last_match, thread=
))
> > +               __threads_table_entry__set_last_match(table, NULL);
> > +
> > +       p =3D &table->entries.rb_root.rb_node;
> > +       while (*p !=3D NULL) {
> > +               struct rb_node *parent =3D *p;
> > +               struct thread_rb_node *nd =3D rb_entry(parent, struct t=
hread_rb_node, rb_node);
> > +               struct thread *th =3D nd->thread;
> > +
> > +               if (RC_CHK_EQUAL(th, thread)) {
> > +                       thread__put(nd->thread);
> > +                       rb_erase_cached(&nd->rb_node, &table->entries);
> > +                       RB_CLEAR_NODE(&nd->rb_node);
> > +                       --table->nr;
> > +                       free(nd);
> > +                       break;
> > +               }
> > +
> > +               if (tid < thread__tid(th))
> > +                       p =3D &(*p)->rb_left;
> > +               else
> > +                       p =3D &(*p)->rb_right;
> > +       }
> > +       up_write(&table->lock);
> > +}
> > +
> > +int threads__for_each_thread(struct threads *threads,
> > +                            int (*fn)(struct thread *thread, void *dat=
a),
> > +                            void *data)
> > +{
> > +       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > +               struct threads_table_entry *table =3D &threads->table[i=
];
> > +               struct rb_node *nd;
> > +
> > +               for (nd =3D rb_first_cached(&table->entries); nd; nd =
=3D rb_next(nd)) {
> > +                       struct thread_rb_node *trb =3D rb_entry(nd, str=
uct thread_rb_node, rb_node);
> > +                       int rc =3D fn(trb->thread, data);
> > +
> > +                       if (rc !=3D 0)
> > +                               return rc;
> > +               }
> > +       }
> > +       return 0;
> > +
> > +}
> > diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
> > new file mode 100644
> > index 000000000000..ed67de627578
> > --- /dev/null
> > +++ b/tools/perf/util/threads.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __PERF_THREADS_H
> > +#define __PERF_THREADS_H
> > +
> > +#include <linux/rbtree.h>
> > +#include "rwsem.h"
> > +
> > +struct thread;
> > +
> > +#define THREADS__TABLE_BITS    8
> > +#define THREADS__TABLE_SIZE    (1 << THREADS__TABLE_BITS)
> > +
> > +struct threads_table_entry {
> > +       struct rb_root_cached  entries;
> > +       struct rw_semaphore    lock;
> > +       unsigned int           nr;
> > +       struct thread          *last_match;
> > +};
> > +
> > +struct threads {
> > +       struct threads_table_entry table[THREADS__TABLE_SIZE];
> > +};
> > +
> > +void threads__init(struct threads *threads);
> > +void threads__exit(struct threads *threads);
> > +size_t threads__nr(struct threads *threads);
> > +struct thread *threads__find(struct threads *threads, pid_t tid);
> > +struct thread *threads__findnew(struct threads *threads, pid_t pid, pi=
d_t tid, bool *created);
> > +void threads__remove_all_threads(struct threads *threads);
> > +void threads__remove(struct threads *threads, struct thread *thread);
> > +int threads__for_each_thread(struct threads *threads,
> > +                            int (*fn)(struct thread *thread, void *dat=
a),
> > +                            void *data);
> > +
> > +#endif /* __PERF_THREADS_H */
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >

