Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BF65A2DCF
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 19:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiHZRqW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 13:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiHZRqV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 13:46:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9E39BB5A
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 10:46:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h5so2621432wru.7
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Uh5dFSwK4Zt6YSWyVYmlZi4W8FwEVSfgNxzBjpzWgRU=;
        b=ASsXRXxFXGbufFEF85lod6Fj6XovOs3tY/mYL2fNrOFrUZgxQQoyt0oFzOY+F91wk1
         GI8TIDJN/x2/q2Mim77qosgmD1MAx/eukjBGfiRDMM9OFzEwiOAMBkzp7UujOdrQ1bEm
         WNgeidlm+XQAzuGQ9jj3eQbJCevzgt+Xcob0pGxvdEokcJSegi1kYztOTJV/RwUjwIaG
         sTKYt5F6y/9P74lSxu3KkCeCFc8YHJjL9Bon5Hcnwo8uNM5aZL0YeoRe1SB44AxPQ/08
         9tvtaJXrw4+t0D2X4PU5z5whKre+zxyxztg9r8tH8Qled+Yp+DKkWwrMpgoOATkPHPr6
         2IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Uh5dFSwK4Zt6YSWyVYmlZi4W8FwEVSfgNxzBjpzWgRU=;
        b=2BszvmcM3efo7P/G6TD8NmLLpiAu15YSe+FWvjkfS3hGt+67mE2ReuGOOkQ17MfnNx
         8NhllgOpWp65jLMel9SEhwasi/Ivz75IpKEXZv6+OkrLFDiqjq4NLKAeQL+75TEGEhnO
         Yuw5pjXZM1U8OaO5kdSNphF3f+7CqRIO2CwkALJeWzKoyJios0MdFQNRNpfo2M5mb9Ot
         DMAo6mmD8ZzfoJwPVFp2/aVnKi0tOtbqX6jjnEkzL51rkLw18S6H+lByXNiR54T8AEBB
         7e7TRVBoo9sJbNDkmlOaCl1wrRz8ilmkt6R0SMZws/NPL2H6pN9M+MxBTR2A87YgDAgn
         /nkg==
X-Gm-Message-State: ACgBeo0Y0j0kpqrSWILwV4W9lf5BIdfDEB4v9IwazJYssTBv17D9xpJo
        mgZY12RLLjE8NAnB9scdBuK1b5rpxsJS8bDBCVtVJg==
X-Google-Smtp-Source: AA6agR6UXgkazQ9d8SSn07/lRGYnesHuQWNqOEjB0qqIsN2zrj0kJqBzDCcQs4/3b7t17h2xp4xpiFOoZZyMRKGAjGw=
X-Received: by 2002:a05:6000:1008:b0:225:58e0:223f with SMTP id
 a8-20020a056000100800b0022558e0223fmr419790wrx.375.1661535977496; Fri, 26 Aug
 2022 10:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com> <20220824153901.488576-12-irogers@google.com>
 <12acbe02-bd73-07bb-d0e1-cb13dcd790c0@intel.com> <CAP-5=fWCpoqAhLzdMn1zHXfKpsYg0LQPMSz6Uy82+QL_MQpc8g@mail.gmail.com>
 <dc25fa1b-1c29-755a-2fc9-b30ec79eb2ac@intel.com>
In-Reply-To: <dc25fa1b-1c29-755a-2fc9-b30ec79eb2ac@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Aug 2022 10:46:05 -0700
Message-ID: <CAP-5=fVHi9h5mgW3GGkaO4b0aR=CQea3bNSY9ghHJV4KiGC=Nw@mail.gmail.com>
Subject: Re: [PATCH v3 11/18] perf dso: Update use of pthread mutex
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 10:34 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 26/08/22 19:05, Ian Rogers wrote:
> > On Fri, Aug 26, 2022 at 3:37 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 24/08/22 18:38, Ian Rogers wrote:
> >>> Switch to the use of mutex wrappers that provide better error checking.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/util/dso.c    | 12 ++++++------
> >>
> >> Some not done yet
> >>
> >> $ grep -i pthread_mut tools/perf/util/dso.c
> >> static pthread_mutex_t dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
> >>         pthread_mutex_lock(&dso__data_open_lock);
> >>         pthread_mutex_unlock(&dso__data_open_lock);
> >>         if (pthread_mutex_lock(&dso__data_open_lock) < 0)
> >>                 pthread_mutex_unlock(&dso__data_open_lock);
> >>         pthread_mutex_unlock(&dso__data_open_lock);
> >>         pthread_mutex_lock(&dso__data_open_lock);
> >>         pthread_mutex_unlock(&dso__data_open_lock);
> >>         pthread_mutex_lock(&dso__data_open_lock);
> >>         pthread_mutex_unlock(&dso__data_open_lock);
> >
> > Yes, these are all solely dso__data_open_lock that lacks any clear
> > init/exit code to place the initialization/destruction hooks onto. I
> > don't plan to alter these in this patch set.
>
> Perhaps that could be explained in the change log.
>
> But why not just add init / exit code.  Could be called out
> of main(), or maybe use __attribute__((constructor)) /
> __attribute__((destructor))

Because the lock is global and not part of the dso.

Thanks,
Ian
