Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41F65A2E65
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiHZS06 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZS0z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:26:55 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9508ED2B35;
        Fri, 26 Aug 2022 11:26:54 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 6-20020a9d0106000000b0063963134d04so1551205otu.3;
        Fri, 26 Aug 2022 11:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Nn+QtQucyfx6hcyPZtuaj6djQCVOs1Ze3pe5mHGUDSg=;
        b=bFgjdebfTpIvwzclDqBA2KmKVAIRLPKkJ/LVr/EV1JSXcFZAxdNWwYEIkE31uEu44g
         uHC6WjnCRo6i6OQPexTu1F8JtEaf34Bt5gbfPZagxuNv94AXsewo6CLt8rjZPxX/JoYW
         ruUHhrPZ2gLHVB3zui1qaNWovmEE7gxY3tKQXIRR5hlqsutKm4UMvdX/cC0zx0VohRqF
         aZshjRXpNuVRSKOgXsfFA7+XQudvGgJSDFAI2kkGLZHXLqDdbPonydQrNSiwsS4Gd7Yz
         uWCo2f9PmyBEeeLldtFV/mCvJ9tLyM/99rNLrGa88Bm1EFpRAh+NenE2D1p+SZ4yEYOF
         q8tw==
X-Gm-Message-State: ACgBeo1A1ff6putp3PSfnjFSYQgGZD6KV6fPo+n6rMRnHyI5MJB9ziKe
        pIjjh3j+FT3Nou0Voaufoi8MQleVo2tR0nrNF58=
X-Google-Smtp-Source: AA6agR4N0hqbt734SQVaauOAORRXZ1pYaDIcvUCo7verqNVGgH5aMY/FntbjVqmez72p0/J2Ly8puUOMKyj9MyjthsQ=
X-Received: by 2002:a9d:6f18:0:b0:638:b4aa:a546 with SMTP id
 n24-20020a9d6f18000000b00638b4aaa546mr1811694otq.124.1661538413803; Fri, 26
 Aug 2022 11:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com> <20220824153901.488576-17-irogers@google.com>
 <a7176263-7dc8-6cbd-af2d-5338c4c4b546@intel.com> <CAP-5=fXk+mLv=C0CTrvnBeuhCTAtJ=x2O8D2YqvmVZSMHqcLvQ@mail.gmail.com>
 <b9ffea78-48c4-e2cd-20c2-dc0c9c2c69f7@intel.com> <CAP-5=fVXuwxP-REryDShX0RZQjkdy2YJKJ5M+zczUqDE2=59Bg@mail.gmail.com>
In-Reply-To: <CAP-5=fVXuwxP-REryDShX0RZQjkdy2YJKJ5M+zczUqDE2=59Bg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 26 Aug 2022 11:26:42 -0700
Message-ID: <CAM9d7cgcLHYded1w4h22F_KWcHUpuxqak7Ny02Awj1WDFLynDQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] perf sched: Fixes for thread safety analysis
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 10:48 AM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Aug 26, 2022 at 10:41 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 26/08/22 19:06, Ian Rogers wrote:
> > > On Fri, Aug 26, 2022 at 5:12 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >>
> > >> On 24/08/22 18:38, Ian Rogers wrote:
> > >>> Add annotations to describe lock behavior. Add unlocks so that mutexes
> > >>> aren't conditionally held on exit from perf_sched__replay. Add an exit
> > >>> variable so that thread_func can terminate, rather than leaving the
> > >>> threads blocked on mutexes.
> > >>>
> > >>> Signed-off-by: Ian Rogers <irogers@google.com>
> > >>> ---
> > >>>  tools/perf/builtin-sched.c | 46 ++++++++++++++++++++++++--------------
> > >>>  1 file changed, 29 insertions(+), 17 deletions(-)
> > >>>
> > >>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > >>> index 7e4006d6b8bc..b483ff0d432e 100644
> > >>> --- a/tools/perf/builtin-sched.c
> > >>> +++ b/tools/perf/builtin-sched.c
> > >>> @@ -246,6 +246,7 @@ struct perf_sched {
> > >>>       const char      *time_str;
> > >>>       struct perf_time_interval ptime;
> > >>>       struct perf_time_interval hist_time;
> > >>> +     volatile bool   thread_funcs_exit;
> > >>>  };
> > >>>
> > >>>  /* per thread run time data */
> > >>> @@ -633,31 +634,34 @@ static void *thread_func(void *ctx)
> > >>>       prctl(PR_SET_NAME, comm2);
> > >>>       if (fd < 0)
> > >>>               return NULL;
> > >>> -again:
> > >>> -     ret = sem_post(&this_task->ready_for_work);
> > >>> -     BUG_ON(ret);
> > >>> -     mutex_lock(&sched->start_work_mutex);
> > >>> -     mutex_unlock(&sched->start_work_mutex);
> > >>>
> > >>> -     cpu_usage_0 = get_cpu_usage_nsec_self(fd);
> > >>> +     while (!sched->thread_funcs_exit) {
> > >>> +             ret = sem_post(&this_task->ready_for_work);
> > >>> +             BUG_ON(ret);
> > >>> +             mutex_lock(&sched->start_work_mutex);
> > >>> +             mutex_unlock(&sched->start_work_mutex);
> > >>>
> > >>> -     for (i = 0; i < this_task->nr_events; i++) {
> > >>> -             this_task->curr_event = i;
> > >>> -             perf_sched__process_event(sched, this_task->atoms[i]);
> > >>> -     }
> > >>> +             cpu_usage_0 = get_cpu_usage_nsec_self(fd);
> > >>>
> > >>> -     cpu_usage_1 = get_cpu_usage_nsec_self(fd);
> > >>> -     this_task->cpu_usage = cpu_usage_1 - cpu_usage_0;
> > >>> -     ret = sem_post(&this_task->work_done_sem);
> > >>> -     BUG_ON(ret);
> > >>> +             for (i = 0; i < this_task->nr_events; i++) {
> > >>> +                     this_task->curr_event = i;
> > >>> +                     perf_sched__process_event(sched, this_task->atoms[i]);
> > >>> +             }
> > >>>
> > >>> -     mutex_lock(&sched->work_done_wait_mutex);
> > >>> -     mutex_unlock(&sched->work_done_wait_mutex);
> > >>> +             cpu_usage_1 = get_cpu_usage_nsec_self(fd);
> > >>> +             this_task->cpu_usage = cpu_usage_1 - cpu_usage_0;
> > >>> +             ret = sem_post(&this_task->work_done_sem);
> > >>> +             BUG_ON(ret);
> > >>>
> > >>> -     goto again;
> > >>> +             mutex_lock(&sched->work_done_wait_mutex);
> > >>> +             mutex_unlock(&sched->work_done_wait_mutex);
> > >>> +     }
> > >>> +     return NULL;
> > >>>  }
> > >>>
> > >>>  static void create_tasks(struct perf_sched *sched)
> > >>> +     EXCLUSIVE_LOCK_FUNCTION(sched->start_work_mutex)
> > >>> +     EXCLUSIVE_LOCK_FUNCTION(sched->work_done_wait_mutex)
> > >>>  {
> > >>>       struct task_desc *task;
> > >>>       pthread_attr_t attr;
> > >>> @@ -687,6 +691,8 @@ static void create_tasks(struct perf_sched *sched)
> > >>>  }
> > >>>
> > >>>  static void wait_for_tasks(struct perf_sched *sched)
> > >>> +     EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
> > >>> +     EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
> > >>>  {
> > >>>       u64 cpu_usage_0, cpu_usage_1;
> > >>>       struct task_desc *task;
> > >>> @@ -738,6 +744,8 @@ static void wait_for_tasks(struct perf_sched *sched)
> > >>>  }
> > >>>
> > >>>  static void run_one_test(struct perf_sched *sched)
> > >>> +     EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
> > >>> +     EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
> > >>>  {
> > >>>       u64 T0, T1, delta, avg_delta, fluct;
> > >>>
> > >>> @@ -3309,11 +3317,15 @@ static int perf_sched__replay(struct perf_sched *sched)
> > >>>       print_task_traces(sched);
> > >>>       add_cross_task_wakeups(sched);
> > >>>
> > >>> +     sched->thread_funcs_exit = false;
> > >>>       create_tasks(sched);
> > >>>       printf("------------------------------------------------------------\n");
> > >>>       for (i = 0; i < sched->replay_repeat; i++)
> > >>>               run_one_test(sched);
> > >>>
> > >>> +     sched->thread_funcs_exit = true;
> > >>> +     mutex_unlock(&sched->start_work_mutex);
> > >>> +     mutex_unlock(&sched->work_done_wait_mutex);
> > >>
> > >> I think you still need to wait for the threads to exit before
> > >> destroying the mutexes.
> > >
> > > This is a pre-existing issue and beyond the scope of this patch set.
> >
> > You added the mutex_destroy functions in patch 8, so it is still
> > fallout from that.
>
> In the previous code the threads were blocked on mutexes that were
> stack allocated and the stack memory went away. You are correct to say
> that to those locks I added an init and destroy call. The lifetime of
> the mutex was wrong previously and remains wrong in this change.

I think you fixed the lifetime issue with sched->thread_funcs_exit here.
All you need to do is calling pthread_join() after the mutex_unlock, no?

Thanks,
Namhyung
