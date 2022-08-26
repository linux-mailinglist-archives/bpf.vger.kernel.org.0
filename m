Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5CF5A2BF6
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243811AbiHZQGh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiHZQGg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:06:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2D1D41A5
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:06:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z16so2323243wrh.10
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=L0H2b2GPKZYIuMR6iWTYOgB5/UtrkJG2fxwjDyQeFtE=;
        b=ntlSXkWi8J2ryefHCTq55BPnbPb2Tas1Jil+sp/Cx9DrtNvaySXbCSUKAFZ1+1uSXJ
         g8aVWdh4PfNRBWp6P/clzaRfOi8H1idIkp7YVevW1l4LbLHBgZntSjkJthdEwQHUiswo
         xQOEuPgF9GzCZ2/4A4/kr9nwOIlkk90esnB0tOCt9Kq806CqKx0F5uB7WMSAQxMpEDkQ
         Tvs4+3fV4fry9twJESAgmRw7qMrZ9Bh/isM+rGLIEt+i0rJn//YBNlQkqTt9c3CpTBKD
         tomYLfnOJ8HJD8zWgtOV9P9d4WH/L+6bUb9+YWkdZYYRCkKJL+IZRFJsajsi8aO+BDg1
         Tkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=L0H2b2GPKZYIuMR6iWTYOgB5/UtrkJG2fxwjDyQeFtE=;
        b=T8UZjKKcMBXsOPa9ALb642nrycNZO9/+vFFf91aT/g93KVtw/6JBBUWw0wIbLpHvzF
         4j9LoEW5MoPy1SjRVxviczwGNOhl0vLOWqfQTsqUYUxKJp4ks7rU//QbbfA1w2msUiID
         XQ5jaal3Df69Katy8AteuOGYufTmPIIqUpedZV6B9gfLdbQQzP/NLyGeomTHW5yq85yx
         oSDfrkoEi6nENVaKZCkqvEdwTrYIJrVqfewCYl3kfpqCKHNSsqOCyBl3Lloz0ai6IYls
         NQtBqU1Q1czLbvQ+2dh7O8CVLvu/Iijw0JMc04a2pDVw7NbbIUlKpUmYw2ky0Svsg922
         PMFg==
X-Gm-Message-State: ACgBeo3TZN8XjhlEPUddHd2Jmi/Vx809MroWdURYecsFeBTngQHLPTHe
        lYd+lR1ONhZG2kXjCucIznulrLYO3u2/U9Jn7cyOSw==
X-Google-Smtp-Source: AA6agR7GbATeJG4gjXTUnx740JnOkntF0bsh5wXXtuvzI4dmU+OBcbKvRbwC4vpMbhWY0TyQoXad/xg1iOGWvXK8XXA=
X-Received: by 2002:a05:6000:1ac9:b0:220:7f40:49e3 with SMTP id
 i9-20020a0560001ac900b002207f4049e3mr219844wry.40.1661529992826; Fri, 26 Aug
 2022 09:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com> <20220824153901.488576-17-irogers@google.com>
 <a7176263-7dc8-6cbd-af2d-5338c4c4b546@intel.com>
In-Reply-To: <a7176263-7dc8-6cbd-af2d-5338c4c4b546@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Aug 2022 09:06:20 -0700
Message-ID: <CAP-5=fXk+mLv=C0CTrvnBeuhCTAtJ=x2O8D2YqvmVZSMHqcLvQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] perf sched: Fixes for thread safety analysis
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 5:12 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/08/22 18:38, Ian Rogers wrote:
> > Add annotations to describe lock behavior. Add unlocks so that mutexes
> > aren't conditionally held on exit from perf_sched__replay. Add an exit
> > variable so that thread_func can terminate, rather than leaving the
> > threads blocked on mutexes.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-sched.c | 46 ++++++++++++++++++++++++--------------
> >  1 file changed, 29 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 7e4006d6b8bc..b483ff0d432e 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -246,6 +246,7 @@ struct perf_sched {
> >       const char      *time_str;
> >       struct perf_time_interval ptime;
> >       struct perf_time_interval hist_time;
> > +     volatile bool   thread_funcs_exit;
> >  };
> >
> >  /* per thread run time data */
> > @@ -633,31 +634,34 @@ static void *thread_func(void *ctx)
> >       prctl(PR_SET_NAME, comm2);
> >       if (fd < 0)
> >               return NULL;
> > -again:
> > -     ret = sem_post(&this_task->ready_for_work);
> > -     BUG_ON(ret);
> > -     mutex_lock(&sched->start_work_mutex);
> > -     mutex_unlock(&sched->start_work_mutex);
> >
> > -     cpu_usage_0 = get_cpu_usage_nsec_self(fd);
> > +     while (!sched->thread_funcs_exit) {
> > +             ret = sem_post(&this_task->ready_for_work);
> > +             BUG_ON(ret);
> > +             mutex_lock(&sched->start_work_mutex);
> > +             mutex_unlock(&sched->start_work_mutex);
> >
> > -     for (i = 0; i < this_task->nr_events; i++) {
> > -             this_task->curr_event = i;
> > -             perf_sched__process_event(sched, this_task->atoms[i]);
> > -     }
> > +             cpu_usage_0 = get_cpu_usage_nsec_self(fd);
> >
> > -     cpu_usage_1 = get_cpu_usage_nsec_self(fd);
> > -     this_task->cpu_usage = cpu_usage_1 - cpu_usage_0;
> > -     ret = sem_post(&this_task->work_done_sem);
> > -     BUG_ON(ret);
> > +             for (i = 0; i < this_task->nr_events; i++) {
> > +                     this_task->curr_event = i;
> > +                     perf_sched__process_event(sched, this_task->atoms[i]);
> > +             }
> >
> > -     mutex_lock(&sched->work_done_wait_mutex);
> > -     mutex_unlock(&sched->work_done_wait_mutex);
> > +             cpu_usage_1 = get_cpu_usage_nsec_self(fd);
> > +             this_task->cpu_usage = cpu_usage_1 - cpu_usage_0;
> > +             ret = sem_post(&this_task->work_done_sem);
> > +             BUG_ON(ret);
> >
> > -     goto again;
> > +             mutex_lock(&sched->work_done_wait_mutex);
> > +             mutex_unlock(&sched->work_done_wait_mutex);
> > +     }
> > +     return NULL;
> >  }
> >
> >  static void create_tasks(struct perf_sched *sched)
> > +     EXCLUSIVE_LOCK_FUNCTION(sched->start_work_mutex)
> > +     EXCLUSIVE_LOCK_FUNCTION(sched->work_done_wait_mutex)
> >  {
> >       struct task_desc *task;
> >       pthread_attr_t attr;
> > @@ -687,6 +691,8 @@ static void create_tasks(struct perf_sched *sched)
> >  }
> >
> >  static void wait_for_tasks(struct perf_sched *sched)
> > +     EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
> > +     EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
> >  {
> >       u64 cpu_usage_0, cpu_usage_1;
> >       struct task_desc *task;
> > @@ -738,6 +744,8 @@ static void wait_for_tasks(struct perf_sched *sched)
> >  }
> >
> >  static void run_one_test(struct perf_sched *sched)
> > +     EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
> > +     EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
> >  {
> >       u64 T0, T1, delta, avg_delta, fluct;
> >
> > @@ -3309,11 +3317,15 @@ static int perf_sched__replay(struct perf_sched *sched)
> >       print_task_traces(sched);
> >       add_cross_task_wakeups(sched);
> >
> > +     sched->thread_funcs_exit = false;
> >       create_tasks(sched);
> >       printf("------------------------------------------------------------\n");
> >       for (i = 0; i < sched->replay_repeat; i++)
> >               run_one_test(sched);
> >
> > +     sched->thread_funcs_exit = true;
> > +     mutex_unlock(&sched->start_work_mutex);
> > +     mutex_unlock(&sched->work_done_wait_mutex);
>
> I think you still need to wait for the threads to exit before
> destroying the mutexes.

This is a pre-existing issue and beyond the scope of this patch set.

Thanks,
Ian

> >       return 0;
> >  }
> >
>
