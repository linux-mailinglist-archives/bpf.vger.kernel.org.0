Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC485A30A2
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 22:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiHZUsY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 16:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiHZUsW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 16:48:22 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E67BD1E3C;
        Fri, 26 Aug 2022 13:48:21 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-11d2dcc31dbso3541247fac.7;
        Fri, 26 Aug 2022 13:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+sFY7D0l2mnCR+yBDf+opIgpmAA2WEbHZKwcSvQkuz0=;
        b=XZ7s0hXNmEde4ohHK74sH3BCjN8BfQWuAVtuPeoYll6FujPuRx/7MHB46fAzrOANeI
         cV1m3rpy8yWAcw8d+huZZGtCxQSe9U4c3tB4JgAvZ67g/p+h+/SrqhVJqB348xYEtrrD
         k2HNPc6avqVRmOfwlDEIUUaArHhDtvqqYaA6p58pNsVxfY4UFi/00D3Bm2f3QfiVwAtm
         kwrYz1GyRmfbckQy0knBnLbaSvQxw4S6Hkhp1WqlbHXyby8AzK/f6gd+S0srbjo1Ecrd
         zFbA4Yz5QITn1NTrsDx59C8pAQ4YOtxT6dd14Tn5yCCD4Tx1OMgaEUMHasDMz+r85lOo
         uCmw==
X-Gm-Message-State: ACgBeo1GXVxnN4ULki3E9ut2eLDCsLmzWEu9m5LM0N0zG+FM17vHUhuO
        RMUIT6M6+QqPxnlcjjq9zQluuXAirghgW4nL3V0=
X-Google-Smtp-Source: AA6agR5zjotJNa9cZNMRCVklNAcj4vN3wXvrE7llGej28AXg2L/RwCW7jMpT+qihLPXgoIk9036xBPWFpfl3w2jC2PQ=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr2736185oab.92.1661546900488; Fri, 26
 Aug 2022 13:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com> <20220824153901.488576-17-irogers@google.com>
 <a7176263-7dc8-6cbd-af2d-5338c4c4b546@intel.com> <CAP-5=fXk+mLv=C0CTrvnBeuhCTAtJ=x2O8D2YqvmVZSMHqcLvQ@mail.gmail.com>
 <b9ffea78-48c4-e2cd-20c2-dc0c9c2c69f7@intel.com> <CAP-5=fVXuwxP-REryDShX0RZQjkdy2YJKJ5M+zczUqDE2=59Bg@mail.gmail.com>
 <CAM9d7cgcLHYded1w4h22F_KWcHUpuxqak7Ny02Awj1WDFLynDQ@mail.gmail.com> <5a0b4083-084a-56b3-a6a1-0fad1100a316@intel.com>
In-Reply-To: <5a0b4083-084a-56b3-a6a1-0fad1100a316@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 26 Aug 2022 13:48:09 -0700
Message-ID: <CAM9d7chNUhmULYUfkEuBC3LcD08y7hLGmFn0qeX83KqoPksvCQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] perf sched: Fixes for thread safety analysis
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>,
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

On Fri, Aug 26, 2022 at 12:36 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 26/08/22 21:26, Namhyung Kim wrote:
> > On Fri, Aug 26, 2022 at 10:48 AM Ian Rogers <irogers@google.com> wrote:

> >> In the previous code the threads were blocked on mutexes that were
> >> stack allocated and the stack memory went away. You are correct to say
> >> that to those locks I added an init and destroy call. The lifetime of
> >> the mutex was wrong previously and remains wrong in this change.
> >
> > I think you fixed the lifetime issue with sched->thread_funcs_exit here.
> > All you need to do is calling pthread_join() after the mutex_unlock, no?
>
> Like this maybe:

Yeah, but at this point we might want to factor it out as a function like
destroy_tasks().

Thanks,
Namhyung

>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index b483ff0d432e..8090c1218855 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3326,6 +3326,13 @@ static int perf_sched__replay(struct perf_sched *sched)
>         sched->thread_funcs_exit = true;
>         mutex_unlock(&sched->start_work_mutex);
>         mutex_unlock(&sched->work_done_wait_mutex);
> +       /* Get rid of threads so they won't be upset by mutex destruction */
> +       for (i = 0; i < sched->nr_tasks; i++) {
> +               int err = pthread_join(sched->tasks[i]->thread, NULL);
> +
> +               if (err)
> +                       pr_err("pthread_join() failed for task nr %lu, error %d\n", i, err);
> +       }
>         return 0;
>  }
