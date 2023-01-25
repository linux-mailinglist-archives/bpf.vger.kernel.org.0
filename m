Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F1867A7A8
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 01:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjAYA1E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 19:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbjAYA1C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 19:27:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAD04DCF4
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 16:26:28 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so200454wms.2
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 16:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/S6M5fE5dqraQtTu0ARhI5S8I+Yd8ezbJtEp3cGiW8=;
        b=tC/FehMrzOya4va7khNvmhYMEXBTP1T0sO2jImqR0q0yGg4NLpl+tDjFG53x2oXX/B
         y9NBHw0GS1ITLxbX9yxpvARTknNbrXAGpL1Fmmrqn5sBUcYHKxGM5i/xi+Wx7v+WCgOU
         79URds/ARRXJTSqi6YDAPTlpnJOtk+mmnSPDQCjz/VD11qpfW951jsUhYTa+uJwWcZ2X
         PNXsVPSg7CrIX5UxDXtrOo7YCjPvVI2pyDeXu8TYcOIHiS5Te3cAJCY136kReEyOcE5Y
         p2z076nNgM6AcuXq9vN5LkTC4sL9UzaKPJXoiqEPAhEs5+AhpnE83r1rvtsRMibcnbcA
         Vbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/S6M5fE5dqraQtTu0ARhI5S8I+Yd8ezbJtEp3cGiW8=;
        b=PAnt7ftpdCxfdblZf2EkqS9fdKGZNqAj/xjK3D2HJSVPPWfLbCfh6Bh6/pbydi2VHh
         Z/6kpRaBSICWcQR20UVieGeCN+tZdQ0b/xFGkGsf4s4sKfGf0PJXzAfUvyRR0Lq1CgvO
         XAMCz2LRsX18+fPEkfBHDWkntUMQMhyL6j4mAYjKxrIB4FJfcyS+gQNjD7cvKxuVSog0
         NDPYofH3D1D6SCPnNvCFB5k4l5hI2AB2FEVsWaGVwxm8DFAOUlnd8VOhkHXHMhPhrEj4
         MpwzgAiDyJcNrR/X5hjkcVmSB2N/4oy4jDbFsGPvoCGYqQzjWCZnE2pjbhX5QEp4oZB2
         0gPw==
X-Gm-Message-State: AFqh2kreOs9W6PVMWJc8PAnBUqxJGGT+391RMTDJSD1L2ShtPTXhjLJl
        5d7NoFj+J40EIt46zHS+1/aXcx0HJlLKuFc3uOnzVQ==
X-Google-Smtp-Source: AMrXdXuESg3r3peBwy1TTVjQgH0Rn2Ls5wrk4pfXBaUH5URXrLdhQyhtyE6mc5eokCAjkts6426e1bhEOmf74v6F6xM=
X-Received: by 2002:a05:600c:1c9a:b0:3d9:ee45:8a9e with SMTP id
 k26-20020a05600c1c9a00b003d9ee458a9emr1409128wms.174.1674606386686; Tue, 24
 Jan 2023 16:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20230105203231.1598936-1-namhyung@kernel.org> <CAM9d7cgJFZhSCnFcYU-5veSpJEyR3=OF_7KBtZLNwq2W2hYd-w@mail.gmail.com>
In-Reply-To: <CAM9d7cgJFZhSCnFcYU-5veSpJEyR3=OF_7KBtZLNwq2W2hYd-w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 24 Jan 2023 16:26:14 -0800
Message-ID: <CAP-5=fWF0u58zeJHhVDvKs8RFjoJmo6pZHPoKOjfU-jMzn1a8w@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf lock contention: Add -o/--lock-owner option
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <song@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 9:59 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> Any feedback on this?
>
> On Thu, Jan 5, 2023 at 12:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > When there're many lock contentions in the system, people sometimes
> > want to know who caused the contention, IOW who's the owner of the
> > locks.
> >
> > The -o/--lock-owner option tries to follow the lock owners for the
> > contended mutexes and rwsems from BPF, and then attributes the
> > contention time to the owner instead of the waiter.  It's a best
> > effort approach to get the owner info at the time of the contention
> > and doesn't guarantee to have the precise tracking of owners if it's
> > changing over time.
> >
> > Currently it only handles mutex and rwsem that have owner field in
> > their struct and it basically points to a task_struct that owns the
> > lock at the moment.
> >
> > Technically its type is atomic_long_t and it comes with some LSB bits
> > used for other meaninigs.  So it needs to clear them when casting it
> > to a pointer to task_struct.
> >
> > Also the atomic_long_t is a typedef of the atomic 32 or 64 bit types
> > depending on arch which is a wrapper struct for the counter value.
> > I'm not aware of proper ways to access those kernel atomic types from
> > BPF so I just read the internal counter value directly.  Please let me
> > know if there's a better way.
> >
> > When -o/--lock-owner option is used, it goes to the task aggregation
> > mode like -t/--threads option does.  However it cannot get the owner
> > for other lock types like spinlock and sometimes even for mutex.
> >
> >   $ sudo ./perf lock con -abo -- ./perf bench sched pipe
> >   # Running 'sched/pipe' benchmark:
> >   # Executed 1000000 pipe operations between two processes
> >
> >        Total time: 4.766 [sec]
> >
> >          4.766540 usecs/op
> >            209795 ops/sec
> >    contended   total wait     max wait     avg wait          pid   owner
> >
> >          403    565.32 us     26.81 us      1.40 us           -1   Unknown
> >            4     27.99 us      8.57 us      7.00 us      1583145   sched-pipe
> >            1      8.25 us      8.25 us      8.25 us      1583144   sched-pipe
> >            1      2.03 us      2.03 us      2.03 us         5068   chrome
> >
> > As you can see, the owner is unknown for the most cases.  But if we
> > filter only for the mutex locks, it'd more likely get the onwers.
> >
> >   $ sudo ./perf lock con -abo -Y mutex -- ./perf bench sched pipe
> >   # Running 'sched/pipe' benchmark:
> >   # Executed 1000000 pipe operations between two processes
> >
> >        Total time: 4.910 [sec]
> >
> >          4.910435 usecs/op
> >            203647 ops/sec
> >    contended   total wait     max wait     avg wait          pid   owner
> >
> >            2     15.50 us      8.29 us      7.75 us      1582852   sched-pipe
> >            7      7.20 us      2.47 us      1.03 us           -1   Unknown
> >            1      6.74 us      6.74 us      6.74 us      1582851   sched-pipe
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Nothing to add on the coding side, and as the commit message says this
can only be a best effort.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >  tools/perf/Documentation/perf-lock.txt        |  5 ++
> >  tools/perf/builtin-lock.c                     | 49 ++++++++++++---
> >  tools/perf/util/bpf_lock_contention.c         |  1 +
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 60 +++++++++++++++++--
> >  tools/perf/util/lock-contention.h             |  1 +
> >  5 files changed, 102 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> > index 0f9f720e599d..a41c8acc7002 100644
> > --- a/tools/perf/Documentation/perf-lock.txt
> > +++ b/tools/perf/Documentation/perf-lock.txt
> > @@ -172,6 +172,11 @@ CONTENTION OPTIONS
> >  --lock-addr::
> >         Show lock contention stat by address
> >
> > +-o::
> > +--lock-owner::
> > +       Show lock contention stat by owners.  Implies --threads and
> > +       requires --use-bpf.
> > +
> >  -Y::
> >  --type-filter=<value>::
> >         Show lock contention only for given lock types (comma separated list).
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 718b82bfcdff..5a3ed5a2bd3d 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -58,6 +58,7 @@ static struct rb_root         thread_stats;
> >  static bool combine_locks;
> >  static bool show_thread_stats;
> >  static bool show_lock_addrs;
> > +static bool show_lock_owner;
> >  static bool use_bpf;
> >  static unsigned long bpf_map_entries = 10240;
> >  static int max_stack_depth = CONTENTION_STACK_DEPTH;
> > @@ -1567,7 +1568,8 @@ static void print_contention_result(struct lock_contention *con)
> >
> >                 switch (aggr_mode) {
> >                 case LOCK_AGGR_TASK:
> > -                       pr_info("  %10s   %s\n\n", "pid", "comm");
> > +                       pr_info("  %10s   %s\n\n", "pid",
> > +                               show_lock_owner ? "owner" : "comm");
> >                         break;
> >                 case LOCK_AGGR_CALLER:
> >                         pr_info("  %10s   %s\n\n", "type", "caller");
> > @@ -1607,7 +1609,8 @@ static void print_contention_result(struct lock_contention *con)
> >                 case LOCK_AGGR_TASK:
> >                         pid = st->addr;
> >                         t = perf_session__findnew(session, pid);
> > -                       pr_info("  %10d   %s\n", pid, thread__comm_str(t));
> > +                       pr_info("  %10d   %s\n",
> > +                               pid, pid == -1 ? "Unknown" : thread__comm_str(t));
> >                         break;
> >                 case LOCK_AGGR_ADDR:
> >                         pr_info("  %016llx   %s\n", (unsigned long long)st->addr,
> > @@ -1718,6 +1721,37 @@ static void sighandler(int sig __maybe_unused)
> >  {
> >  }
> >
> > +static int check_lock_contention_options(const struct option *options,
> > +                                        const char * const *usage)
> > +
> > +{
> > +       if (show_thread_stats && show_lock_addrs) {
> > +               pr_err("Cannot use thread and addr mode together\n");
> > +               parse_options_usage(usage, options, "threads", 0);
> > +               parse_options_usage(NULL, options, "lock-addr", 0);
> > +               return -1;
> > +       }
> > +
> > +       if (show_lock_owner && !use_bpf) {
> > +               pr_err("Lock owners are available only with BPF\n");
> > +               parse_options_usage(usage, options, "lock-owner", 0);
> > +               parse_options_usage(NULL, options, "use-bpf", 0);
> > +               return -1;
> > +       }
> > +
> > +       if (show_lock_owner && show_lock_addrs) {
> > +               pr_err("Cannot use owner and addr mode together\n");
> > +               parse_options_usage(usage, options, "lock-owner", 0);
> > +               parse_options_usage(NULL, options, "lock-addr", 0);
> > +               return -1;
> > +       }
> > +
> > +       if (show_lock_owner)
> > +               show_thread_stats = true;
> > +
> > +       return 0;
> > +}
> > +
> >  static int __cmd_contention(int argc, const char **argv)
> >  {
> >         int err = -EINVAL;
> > @@ -1742,6 +1776,7 @@ static int __cmd_contention(int argc, const char **argv)
> >                 .max_stack = max_stack_depth,
> >                 .stack_skip = stack_skip,
> >                 .filters = &filters,
> > +               .owner = show_lock_owner,
> >         };
> >
> >         session = perf_session__new(use_bpf ? NULL : &data, &eops);
> > @@ -2188,6 +2223,7 @@ int cmd_lock(int argc, const char **argv)
> >                      "Filter specific type of locks", parse_lock_type),
> >         OPT_CALLBACK('L', "lock-filter", NULL, "ADDRS/NAMES",
> >                      "Filter specific address/symbol of locks", parse_lock_addr),
> > +       OPT_BOOLEAN('o', "lock-owner", &show_lock_owner, "show lock owners instead of waiters"),
> >         OPT_PARENT(lock_options)
> >         };
> >
> > @@ -2258,14 +2294,9 @@ int cmd_lock(int argc, const char **argv)
> >                                              contention_usage, 0);
> >                 }
> >
> > -               if (show_thread_stats && show_lock_addrs) {
> > -                       pr_err("Cannot use thread and addr mode together\n");
> > -                       parse_options_usage(contention_usage, contention_options,
> > -                                           "threads", 0);
> > -                       parse_options_usage(NULL, contention_options,
> > -                                           "lock-addr", 0);
> > +               if (check_lock_contention_options(contention_options,
> > +                                                 contention_usage) < 0)
> >                         return -1;
> > -               }
> >
> >                 rc = __cmd_contention(argc, argv);
> >         } else {
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> > index 0236334fd69b..709d418be873 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -146,6 +146,7 @@ int lock_contention_prepare(struct lock_contention *con)
> >         /* these don't work well if in the rodata section */
> >         skel->bss->stack_skip = con->stack_skip;
> >         skel->bss->aggr_mode = con->aggr_mode;
> > +       skel->bss->lock_owner = con->owner;
> >
> >         lock_contention_bpf__attach(skel);
> >         return 0;
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > index ad0ca5d50557..a035a267b08e 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -10,6 +10,14 @@
> >  /* default buffer size */
> >  #define MAX_ENTRIES  10240
> >
> > +/* lock contention flags from include/trace/events/lock.h */
> > +#define LCB_F_SPIN     (1U << 0)
> > +#define LCB_F_READ     (1U << 1)
> > +#define LCB_F_WRITE    (1U << 2)
> > +#define LCB_F_RT       (1U << 3)
> > +#define LCB_F_PERCPU   (1U << 4)
> > +#define LCB_F_MUTEX    (1U << 5)
> > +
> >  struct tstamp_data {
> >         __u64 timestamp;
> >         __u64 lock;
> > @@ -83,6 +91,7 @@ int has_task;
> >  int has_type;
> >  int has_addr;
> >  int stack_skip;
> > +int lock_owner;
> >
> >  /* determine the key of lock stat */
> >  int aggr_mode;
> > @@ -131,17 +140,24 @@ static inline int can_record(u64 *ctx)
> >         return 1;
> >  }
> >
> > -static inline void update_task_data(__u32 pid)
> > +static inline int update_task_data(struct task_struct *task)
> >  {
> >         struct contention_task_data *p;
> > +       int pid, err;
> > +
> > +       err = bpf_core_read(&pid, sizeof(pid), &task->pid);
> > +       if (err)
> > +               return -1;
> >
> >         p = bpf_map_lookup_elem(&task_data, &pid);
> >         if (p == NULL) {
> > -               struct contention_task_data data;
> > +               struct contention_task_data data = {};
> >
> > -               bpf_get_current_comm(data.comm, sizeof(data.comm));
> > +               BPF_CORE_READ_STR_INTO(&data.comm, task, comm);
> >                 bpf_map_update_elem(&task_data, &pid, &data, BPF_NOEXIST);
> >         }
> > +
> > +       return 0;
> >  }
> >
> >  SEC("tp_btf/contention_begin")
> > @@ -178,6 +194,38 @@ int contention_begin(u64 *ctx)
> >                                                   BPF_F_FAST_STACK_CMP | stack_skip);
> >                 if (pelem->stack_id < 0)
> >                         lost++;
> > +       } else if (aggr_mode == LOCK_AGGR_TASK) {
> > +               struct task_struct *task;
> > +
> > +               if (lock_owner) {
> > +                       if (pelem->flags & LCB_F_MUTEX) {
> > +                               struct mutex *lock = (void *)pelem->lock;
> > +                               unsigned long owner = BPF_CORE_READ(lock, owner.counter);
> > +
> > +                               task = (void *)(owner & ~7UL);
> > +                       } else if (pelem->flags == LCB_F_READ || pelem->flags == LCB_F_WRITE) {
> > +                               struct rw_semaphore *lock = (void *)pelem->lock;
> > +                               unsigned long owner = BPF_CORE_READ(lock, owner.counter);
> > +
> > +                               task = (void *)(owner & ~7UL);
> > +                       } else {
> > +                               task = NULL;
> > +                       }
> > +
> > +                       /* The flags is not used anymore.  Pass the owner pid. */
> > +                       if (task)
> > +                               pelem->flags = BPF_CORE_READ(task, pid);
> > +                       else
> > +                               pelem->flags = -1U;
> > +
> > +               } else {
> > +                       task = bpf_get_current_task_btf();
> > +               }
> > +
> > +               if (task) {
> > +                       if (update_task_data(task) < 0 && lock_owner)
> > +                               pelem->flags = -1U;
> > +               }
> >         }
> >
> >         return 0;
> > @@ -207,8 +255,10 @@ int contention_end(u64 *ctx)
> >                 key.aggr_key = pelem->stack_id;
> >                 break;
> >         case LOCK_AGGR_TASK:
> > -               key.aggr_key = pid;
> > -               update_task_data(pid);
> > +               if (lock_owner)
> > +                       key.aggr_key = pelem->flags;
> > +               else
> > +                       key.aggr_key = pid;
> >                 break;
> >         case LOCK_AGGR_ADDR:
> >                 key.aggr_key = pelem->lock;
> > diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> > index b99e83fccf5c..862b0617698a 100644
> > --- a/tools/perf/util/lock-contention.h
> > +++ b/tools/perf/util/lock-contention.h
> > @@ -128,6 +128,7 @@ struct lock_contention {
> >         int max_stack;
> >         int stack_skip;
> >         int aggr_mode;
> > +       int owner;
> >  };
> >
> >  #ifdef HAVE_BPF_SKEL
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
