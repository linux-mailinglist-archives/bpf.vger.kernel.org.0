Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48905A2DD1
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344615AbiHZRsR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 13:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344613AbiHZRsQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 13:48:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B297DF4E9
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 10:48:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u5so2612219wrt.11
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9JHPKBEhnzj2Xmii0IJwAZm9bDxPzFxlEKG6x6ug6zk=;
        b=YeShUHZAjaMfVm4ZJoT0KtWHtHVQF69k9j5LM9cpMqgaMBQIQk8RISAZ3c9Tqdk1K3
         +u9YAnO+b7e0rlD9Hwu0FZ8cxVnXQkNbxbgHITNxqiu6DnykqjCEQzRAu1VWZ3pWMwXO
         qV8dmBSMKtVzj95smb3JbC4Qxz6oW0AAHo4U4mvjUaCX+F/oNdn28VcnJqXUvoYxsHeL
         LDVP5o6aCWrz15+TGMnlnF5B9lUezo3kaYrDNBfi+zhipDC3vY6zC/AYRaBblBKFZwCA
         JCYLynPHBYuVw2A7/hRiyX8i8tRylbPycdSMmfMib/nALqD33gt64nTQzJDHFay+hhCo
         fdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9JHPKBEhnzj2Xmii0IJwAZm9bDxPzFxlEKG6x6ug6zk=;
        b=ZKsCCdjcSOn061HpbHgpi0qk/Fn7Q1cTJQge8gDxKkeX/ZWeWc9+Cj8Hd9Z/x/LwaF
         DjaVIqQTZpcDtEhrzkJVj2ECzNfsykp9UWxKF1Wptp4Wwcdfd/NI6qxt1x6lPwdHzTc1
         OSSRLdsZ39Plxe5Rour+BvlgHkEGEQe/tso7W53M5WTsw5067YwOK96nfsdqGWSVO5XZ
         rwmz6OcMumYdCaqAhVXjWaj7ID2RbvUg7zQy+WSBs6AdXf8ObM2UFjXGHfqnNyYGA+l8
         +vRvevzo8SM6653D5oVxU3QaDcLHCr945JZlA/kslnJHLBRFIburWAEF7HVGqCgCTkt6
         KcCw==
X-Gm-Message-State: ACgBeo0ds5d4y0pPeTE9HId6jPDIetUXanbaDBx8u4rlKVPw2aeTCnbj
        Vj+xFBitochCo47aniEx1qthwze7eM5iSOMDodNWEQ==
X-Google-Smtp-Source: AA6agR5YTArV0z60f6fmYVbsoslFeZS5EcVg43N45kefsQs86vvqkoP4opnpC/decH7TsBShY7VKfEFc8XYLy4nqC/U=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr431200wri.300.1661536092846; Fri, 26
 Aug 2022 10:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com> <20220824153901.488576-17-irogers@google.com>
 <a7176263-7dc8-6cbd-af2d-5338c4c4b546@intel.com> <CAP-5=fXk+mLv=C0CTrvnBeuhCTAtJ=x2O8D2YqvmVZSMHqcLvQ@mail.gmail.com>
 <b9ffea78-48c4-e2cd-20c2-dc0c9c2c69f7@intel.com>
In-Reply-To: <b9ffea78-48c4-e2cd-20c2-dc0c9c2c69f7@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Aug 2022 10:48:00 -0700
Message-ID: <CAP-5=fVXuwxP-REryDShX0RZQjkdy2YJKJ5M+zczUqDE2=59Bg@mail.gmail.com>
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

On Fri, Aug 26, 2022 at 10:41 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 26/08/22 19:06, Ian Rogers wrote:
> > On Fri, Aug 26, 2022 at 5:12 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 24/08/22 18:38, Ian Rogers wrote:
> >>> Add annotations to describe lock behavior. Add unlocks so that mutexes
> >>> aren't conditionally held on exit from perf_sched__replay. Add an exit
> >>> variable so that thread_func can terminate, rather than leaving the
> >>> threads blocked on mutexes.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/builtin-sched.c | 46 ++++++++++++++++++++++++--------------
> >>>  1 file changed, 29 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> >>> index 7e4006d6b8bc..b483ff0d432e 100644
> >>> --- a/tools/perf/builtin-sched.c
> >>> +++ b/tools/perf/builtin-sched.c
> >>> @@ -246,6 +246,7 @@ struct perf_sched {
> >>>       const char      *time_str;
> >>>       struct perf_time_interval ptime;
> >>>       struct perf_time_interval hist_time;
> >>> +     volatile bool   thread_funcs_exit;
> >>>  };
> >>>
> >>>  /* per thread run time data */
> >>> @@ -633,31 +634,34 @@ static void *thread_func(void *ctx)
> >>>       prctl(PR_SET_NAME, comm2);
> >>>       if (fd < 0)
> >>>               return NULL;
> >>> -again:
> >>> -     ret = sem_post(&this_task->ready_for_work);
> >>> -     BUG_ON(ret);
> >>> -     mutex_lock(&sched->start_work_mutex);
> >>> -     mutex_unlock(&sched->start_work_mutex);
> >>>
> >>> -     cpu_usage_0 = get_cpu_usage_nsec_self(fd);
> >>> +     while (!sched->thread_funcs_exit) {
> >>> +             ret = sem_post(&this_task->ready_for_work);
> >>> +             BUG_ON(ret);
> >>> +             mutex_lock(&sched->start_work_mutex);
> >>> +             mutex_unlock(&sched->start_work_mutex);
> >>>
> >>> -     for (i = 0; i < this_task->nr_events; i++) {
> >>> -             this_task->curr_event = i;
> >>> -             perf_sched__process_event(sched, this_task->atoms[i]);
> >>> -     }
> >>> +             cpu_usage_0 = get_cpu_usage_nsec_self(fd);
> >>>
> >>> -     cpu_usage_1 = get_cpu_usage_nsec_self(fd);
> >>> -     this_task->cpu_usage = cpu_usage_1 - cpu_usage_0;
> >>> -     ret = sem_post(&this_task->work_done_sem);
> >>> -     BUG_ON(ret);
> >>> +             for (i = 0; i < this_task->nr_events; i++) {
> >>> +                     this_task->curr_event = i;
> >>> +                     perf_sched__process_event(sched, this_task->atoms[i]);
> >>> +             }
> >>>
> >>> -     mutex_lock(&sched->work_done_wait_mutex);
> >>> -     mutex_unlock(&sched->work_done_wait_mutex);
> >>> +             cpu_usage_1 = get_cpu_usage_nsec_self(fd);
> >>> +             this_task->cpu_usage = cpu_usage_1 - cpu_usage_0;
> >>> +             ret = sem_post(&this_task->work_done_sem);
> >>> +             BUG_ON(ret);
> >>>
> >>> -     goto again;
> >>> +             mutex_lock(&sched->work_done_wait_mutex);
> >>> +             mutex_unlock(&sched->work_done_wait_mutex);
> >>> +     }
> >>> +     return NULL;
> >>>  }
> >>>
> >>>  static void create_tasks(struct perf_sched *sched)
> >>> +     EXCLUSIVE_LOCK_FUNCTION(sched->start_work_mutex)
> >>> +     EXCLUSIVE_LOCK_FUNCTION(sched->work_done_wait_mutex)
> >>>  {
> >>>       struct task_desc *task;
> >>>       pthread_attr_t attr;
> >>> @@ -687,6 +691,8 @@ static void create_tasks(struct perf_sched *sched)
> >>>  }
> >>>
> >>>  static void wait_for_tasks(struct perf_sched *sched)
> >>> +     EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
> >>> +     EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
> >>>  {
> >>>       u64 cpu_usage_0, cpu_usage_1;
> >>>       struct task_desc *task;
> >>> @@ -738,6 +744,8 @@ static void wait_for_tasks(struct perf_sched *sched)
> >>>  }
> >>>
> >>>  static void run_one_test(struct perf_sched *sched)
> >>> +     EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
> >>> +     EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
> >>>  {
> >>>       u64 T0, T1, delta, avg_delta, fluct;
> >>>
> >>> @@ -3309,11 +3317,15 @@ static int perf_sched__replay(struct perf_sched *sched)
> >>>       print_task_traces(sched);
> >>>       add_cross_task_wakeups(sched);
> >>>
> >>> +     sched->thread_funcs_exit = false;
> >>>       create_tasks(sched);
> >>>       printf("------------------------------------------------------------\n");
> >>>       for (i = 0; i < sched->replay_repeat; i++)
> >>>               run_one_test(sched);
> >>>
> >>> +     sched->thread_funcs_exit = true;
> >>> +     mutex_unlock(&sched->start_work_mutex);
> >>> +     mutex_unlock(&sched->work_done_wait_mutex);
> >>
> >> I think you still need to wait for the threads to exit before
> >> destroying the mutexes.
> >
> > This is a pre-existing issue and beyond the scope of this patch set.
>
> You added the mutex_destroy functions in patch 8, so it is still
> fallout from that.

In the previous code the threads were blocked on mutexes that were
stack allocated and the stack memory went away. You are correct to say
that to those locks I added an init and destroy call. The lifetime of
the mutex was wrong previously and remains wrong in this change.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >>>       return 0;
> >>>  }
> >>>
> >>
>
