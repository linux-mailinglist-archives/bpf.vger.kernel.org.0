Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C885A2F83
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344984AbiHZTBQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 15:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbiHZTA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 15:00:58 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E36321E35;
        Fri, 26 Aug 2022 12:00:55 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11e8b592421so1724064fac.0;
        Fri, 26 Aug 2022 12:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0KBifXuEASh6HGcgH149nanGpV1JiDt7DyDBHIsc/vU=;
        b=ccN8QG8hk63fsWGAxExojN7UzZ2rCOSkdNq+NTQYLKsese+mpfgjXGOL94lDldoj1o
         0xIXZLnvHtA2J2EE9WUExGsrM28SSjxt0A+SNwvzmv4lTBFgIxZFwHeqWwOq3FpHrZWP
         kkIzfP27OBJevc/doAFfnplwiXZi6myTciA67KTAQvZ8V6H6EiVIa8VVfKDPF1wlrN68
         y/1MX8nT/ehYNeAPyaC1SmrJTk6WUYMt3NK+yRzjAvXwBteCVUG5FMwkGnKC6jjRU11x
         8FdKfvta9P10uz1CnCd+101s9mYkMaY97B6OZznsES7bqfWOjd+1ZCb7LvwRVU/CRprX
         EJtg==
X-Gm-Message-State: ACgBeo3vqH0pjCJRWhmBogoLHBZLL/nO2/JAnhpkJFQEgjSm5xoG2+uV
        HtcBMn8tb6ayaQS1S/Fqg8vqalkybMLHxQ430fo=
X-Google-Smtp-Source: AA6agR6xC2kKRjF0UcRxB7gFaYxM1KXLm8OEIF0oTIJbOW+ut9BYRZXoYrKGvWMQJZt27A24Nij44wvtUz4u8g4yTkg=
X-Received: by 2002:a05:6870:a184:b0:116:bd39:7f94 with SMTP id
 a4-20020a056870a18400b00116bd397f94mr2563648oaf.5.1661540454852; Fri, 26 Aug
 2022 12:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com> <20220824153901.488576-10-irogers@google.com>
 <2cf6edac-6e41-b43c-2bc1-f49cb739201a@intel.com> <CAP-5=fVVWx=LZAzXsxfuktPHwki1gYbV4mcmvJp_9GTDS6KJcQ@mail.gmail.com>
 <a9b4f79d-cdea-821e-0e57-cd4854de6cf4@intel.com> <CAP-5=fW7t9tcJpyUbv8JAo-BFna-KS6FC+HkbuGx6S=h+nBMqw@mail.gmail.com>
 <43540a3d-e64e-ec08-e12e-aebb236a2efe@intel.com>
In-Reply-To: <43540a3d-e64e-ec08-e12e-aebb236a2efe@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 26 Aug 2022 12:00:43 -0700
Message-ID: <CAM9d7chBnZtrKe6b8k+VYk1Nmz8YnNWSMmyLydH6+Otvw4xGeA@mail.gmail.com>
Subject: Re: [PATCH v3 09/18] perf ui: Update use of pthread mutex
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

On Fri, Aug 26, 2022 at 11:53 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> Below seems adequate for now, at least logically, but maybe it
> would confuse clang thread-safety analysis?

I think it's not just about locks, the exit_browser should bail out early
if the setup code was not called.

Thanks,
Namhyung


>
> diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
> index 25ded88801a3..6d81be6a349e 100644
> --- a/tools/perf/ui/setup.c
> +++ b/tools/perf/ui/setup.c
> @@ -73,9 +73,17 @@ int stdio__config_color(const struct option *opt __maybe_unused,
>         return 0;
>  }
>
> +/*
> + * exit_browser() can get called without setup_browser() having been called
> + * first, so it is necessary to keep track of whether ui__lock has been
> + * initialized.
> + */
> +static bool ui__lock_initialized;
> +
>  void setup_browser(bool fallback_to_pager)
>  {
>         mutex_init(&ui__lock);
> +       ui__lock_initialized = true;
>         if (use_browser < 2 && (!isatty(1) || dump_trace))
>                 use_browser = 0;
>
> @@ -118,5 +126,6 @@ void exit_browser(bool wait_for_ok)
>         default:
>                 break;
>         }
> -       mutex_destroy(&ui__lock);
> +       if (ui__lock_initialized)
> +               mutex_destroy(&ui__lock);
>  }
>
