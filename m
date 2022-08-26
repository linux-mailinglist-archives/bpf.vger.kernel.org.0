Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4148F5A2DCC
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 19:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbiHZRpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 13:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344849AbiHZRp3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 13:45:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9A91CB0C
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 10:45:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bq11so2604086wrb.12
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SaTDbDH7dmnPggcWT+1/y+/FzPsW+C6u6VoOwGZPEu0=;
        b=IYz0e4VHwiU0hl7/ewAra7f8Yr8bkoDffmmogJD13UYUH+dQontZkLEXfgAMqYpFmq
         x+QZghSY0Bdth3FU7gkCs+m/pWebRKj4UzwYctwJbRavgrJJzn49u6vHRHQES2cfqr/H
         JSX4DTtxOeu2PK1SVnKMr22ghmb2Amijy9PkCgxNQbgje/TxBG0fcaI7NmAAu81bkf+C
         ScGfxanwKQPoSSnZ981DXEdmFNI0/CZhwTrw6VIbkT0pMGYGa5rfhy6yNe3lOV55ZP2r
         nsXBHX9hCu0Zf30xNhgQ6RU3+FLUj7pHS84ePU7hq4iWCRAtGfVdOxEZrHf2KzkvAGdL
         kguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SaTDbDH7dmnPggcWT+1/y+/FzPsW+C6u6VoOwGZPEu0=;
        b=Fv7gu54woiEZz53s4fdDmjhitX1NO3ct++Z5d1F50F8n1/juHA+GsZ4671Q+cTDMYP
         XVtIX6ww0Oxkdt2QD3kdjMzKef+Q2IpOKRRmQICLBJCpjOwiwMooCUuxKLto/UGx423h
         AH6Id/Vaa82B/QS9LLwQO/RcPre2FmFGReypKSV2O7P9Ve9y8U+384IxJdZSQcsxo/0l
         R+yX1hMJBDempTBeyMN8CU2lUW2sKn07PXPIvhojQmTdMAIdo9GBIV+6FzM4uk2w+oZM
         8cFBLRPtWoL5inpW97r42rXIiw07H6/qyZtwVXKmrU0TxpQ6jD3XpbJ1SVrvBXrpnYoT
         AIAg==
X-Gm-Message-State: ACgBeo0bbiC3ApYQbsvHRUZ646Tn3zf7cKXxGvgj3X3LXaAsWLLhJb84
        l07xj9U3g47k6T0Z8nZmOYf3EONygKpfpL4UvYz0SQ==
X-Google-Smtp-Source: AA6agR6p9563BxwXgbd4p77AXJ4khV0XbWuFLcCiRWUjuEvHL1ZoYiu58bwmLxOX6k7rMIdMgpPAliMsEoDxR0b4FdY=
X-Received: by 2002:adf:d1ea:0:b0:225:474b:1061 with SMTP id
 g10-20020adfd1ea000000b00225474b1061mr401845wrd.343.1661535925342; Fri, 26
 Aug 2022 10:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com> <20220824153901.488576-10-irogers@google.com>
 <2cf6edac-6e41-b43c-2bc1-f49cb739201a@intel.com> <CAP-5=fVVWx=LZAzXsxfuktPHwki1gYbV4mcmvJp_9GTDS6KJcQ@mail.gmail.com>
 <a9b4f79d-cdea-821e-0e57-cd4854de6cf4@intel.com>
In-Reply-To: <a9b4f79d-cdea-821e-0e57-cd4854de6cf4@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Aug 2022 10:45:12 -0700
Message-ID: <CAP-5=fW7t9tcJpyUbv8JAo-BFna-KS6FC+HkbuGx6S=h+nBMqw@mail.gmail.com>
Subject: Re: [PATCH v3 09/18] perf ui: Update use of pthread mutex
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

On Fri, Aug 26, 2022 at 10:22 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 26/08/22 19:02, Ian Rogers wrote:
> > On Fri, Aug 26, 2022 at 3:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 24/08/22 18:38, Ian Rogers wrote:
> >>> Switch to the use of mutex wrappers that provide better error checking.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/ui/browser.c           | 20 ++++++++++----------
> >>>  tools/perf/ui/browsers/annotate.c |  2 +-
> >>>  tools/perf/ui/setup.c             |  5 +++--
> >>>  tools/perf/ui/tui/helpline.c      |  5 ++---
> >>>  tools/perf/ui/tui/progress.c      |  8 ++++----
> >>>  tools/perf/ui/tui/setup.c         |  8 ++++----
> >>>  tools/perf/ui/tui/util.c          | 18 +++++++++---------
> >>>  tools/perf/ui/ui.h                |  4 ++--
> >>>  8 files changed, 35 insertions(+), 35 deletions(-)
> >>>
> >>> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> >>> index fa5bd5c20e96..78fb01d6ad63 100644
> >>> --- a/tools/perf/ui/browser.c
> >>> +++ b/tools/perf/ui/browser.c
> >>> @@ -268,9 +268,9 @@ void __ui_browser__show_title(struct ui_browser *browser, const char *title)
> >>>
> >>>  void ui_browser__show_title(struct ui_browser *browser, const char *title)
> >>>  {
> >>> -     pthread_mutex_lock(&ui__lock);
> >>> +     mutex_lock(&ui__lock);
> >>>       __ui_browser__show_title(browser, title);
> >>> -     pthread_mutex_unlock(&ui__lock);
> >>> +     mutex_unlock(&ui__lock);
> >>>  }
> >>>
> >>>  int ui_browser__show(struct ui_browser *browser, const char *title,
> >>> @@ -284,7 +284,7 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
> >>>
> >>>       browser->refresh_dimensions(browser);
> >>>
> >>> -     pthread_mutex_lock(&ui__lock);
> >>> +     mutex_lock(&ui__lock);
> >>>       __ui_browser__show_title(browser, title);
> >>>
> >>>       browser->title = title;
> >>> @@ -295,16 +295,16 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
> >>>       va_end(ap);
> >>>       if (err > 0)
> >>>               ui_helpline__push(browser->helpline);
> >>> -     pthread_mutex_unlock(&ui__lock);
> >>> +     mutex_unlock(&ui__lock);
> >>>       return err ? 0 : -1;
> >>>  }
> >>>
> >>>  void ui_browser__hide(struct ui_browser *browser)
> >>>  {
> >>> -     pthread_mutex_lock(&ui__lock);
> >>> +     mutex_lock(&ui__lock);
> >>>       ui_helpline__pop();
> >>>       zfree(&browser->helpline);
> >>> -     pthread_mutex_unlock(&ui__lock);
> >>> +     mutex_unlock(&ui__lock);
> >>>  }
> >>>
> >>>  static void ui_browser__scrollbar_set(struct ui_browser *browser)
> >>> @@ -352,9 +352,9 @@ static int __ui_browser__refresh(struct ui_browser *browser)
> >>>
> >>>  int ui_browser__refresh(struct ui_browser *browser)
> >>>  {
> >>> -     pthread_mutex_lock(&ui__lock);
> >>> +     mutex_lock(&ui__lock);
> >>>       __ui_browser__refresh(browser);
> >>> -     pthread_mutex_unlock(&ui__lock);
> >>> +     mutex_unlock(&ui__lock);
> >>>
> >>>       return 0;
> >>>  }
> >>> @@ -390,10 +390,10 @@ int ui_browser__run(struct ui_browser *browser, int delay_secs)
> >>>       while (1) {
> >>>               off_t offset;
> >>>
> >>> -             pthread_mutex_lock(&ui__lock);
> >>> +             mutex_lock(&ui__lock);
> >>>               err = __ui_browser__refresh(browser);
> >>>               SLsmg_refresh();
> >>> -             pthread_mutex_unlock(&ui__lock);
> >>> +             mutex_unlock(&ui__lock);
> >>>               if (err < 0)
> >>>                       break;
> >>>
> >>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> >>> index 44ba900828f6..b8747e8dd9ea 100644
> >>> --- a/tools/perf/ui/browsers/annotate.c
> >>> +++ b/tools/perf/ui/browsers/annotate.c
> >>> @@ -8,11 +8,11 @@
> >>>  #include "../../util/hist.h"
> >>>  #include "../../util/sort.h"
> >>>  #include "../../util/map.h"
> >>> +#include "../../util/mutex.h"
> >>>  #include "../../util/symbol.h"
> >>>  #include "../../util/evsel.h"
> >>>  #include "../../util/evlist.h"
> >>>  #include <inttypes.h>
> >>> -#include <pthread.h>
> >>>  #include <linux/kernel.h>
> >>>  #include <linux/string.h>
> >>>  #include <linux/zalloc.h>
> >>> diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
> >>> index 700335cde618..25ded88801a3 100644
> >>> --- a/tools/perf/ui/setup.c
> >>> +++ b/tools/perf/ui/setup.c
> >>> @@ -1,5 +1,4 @@
> >>>  // SPDX-License-Identifier: GPL-2.0
> >>> -#include <pthread.h>
> >>>  #include <dlfcn.h>
> >>>  #include <unistd.h>
> >>>
> >>> @@ -8,7 +7,7 @@
> >>>  #include "../util/hist.h"
> >>>  #include "ui.h"
> >>>
> >>> -pthread_mutex_t ui__lock = PTHREAD_MUTEX_INITIALIZER;
> >>> +struct mutex ui__lock;
> >>>  void *perf_gtk_handle;
> >>>  int use_browser = -1;
> >>>
> >>> @@ -76,6 +75,7 @@ int stdio__config_color(const struct option *opt __maybe_unused,
> >>>
> >>>  void setup_browser(bool fallback_to_pager)
> >>>  {
> >>> +     mutex_init(&ui__lock);
> >>>       if (use_browser < 2 && (!isatty(1) || dump_trace))
> >>>               use_browser = 0;
> >>>
> >>> @@ -118,4 +118,5 @@ void exit_browser(bool wait_for_ok)
> >>>       default:
> >>>               break;
> >>>       }
> >>> +     mutex_destroy(&ui__lock);
> >>
> >> Looks like exit_browser() can be called even when setup_browser()
> >> was never called.
> >>
> >> Note, it also looks like PTHREAD_MUTEX_INITIALIZER is all zeros so
> >> pthread won't notice.
> >
> > Memory sanitizer will notice some cases of this and so I didn't want
> > to code defensively around exit being called ahead of setup.
>
> I am not sure you understood.
>
> As I wrote, exit_browser() can be called even when setup_browser()
> was never called, so it is not defensive programming, it is necessary
> programming that you only get away without doing because
> PTHREAD_MUTEX_INITIALIZER is all zeros.

Why are we here:
1) there is a memory leak
2) I fix the memory and trigger a use after free
3) I invent a reference count checker, use it to fix the memory leak,
use after free and missing locks - the patch for this in 10s of lines
long
4) when adding the lock fixes I defensively add error checking to the
mutex involved - mainly because I was scared I could introduce a
deadlock
5) I get asked to generalize this
6) GSoC contributor picks up and puts this down
7) I pull together the contributor's work
8) I get asked to turn a search and replace 4 patch fix into an unwieldy patch
9) I worry about the sanity of the change and add lock checking from clang
10) I end up trying to fix perf-sched who for some reason thought it
was perfectly valid to have threads blocked on mutexes that were
deallocated on the stack.
11) the UI code was written with a view that exiting something not
setup somehow made sense

I am drawing a line at fixing perf sched and the UI code. We can drop
this patch and keep things as a pthread_mutex_t, similarly for
perf-sched. I have gone about as far as I'm prepared to for the sake
of a 10s of line memory leak fix. Some private thoughts are, it would
be useful if review comments could be constructive, hey do this not
that, and not simply commenting on change or trying to shoehorn vast
amounts of tech debt clean up onto simple fixes.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >>>  }
> >>> diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
> >>> index 298d6af82fdd..db4952f5990b 100644
> >>> --- a/tools/perf/ui/tui/helpline.c
> >>> +++ b/tools/perf/ui/tui/helpline.c
> >>> @@ -2,7 +2,6 @@
> >>>  #include <stdio.h>
> >>>  #include <stdlib.h>
> >>>  #include <string.h>
> >>> -#include <pthread.h>
> >>>  #include <linux/kernel.h>
> >>>  #include <linux/string.h>
> >>>
> >>> @@ -33,7 +32,7 @@ static int tui_helpline__show(const char *format, va_list ap)
> >>>       int ret;
> >>>       static int backlog;
> >>>
> >>> -     pthread_mutex_lock(&ui__lock);
> >>> +     mutex_lock(&ui__lock);
> >>>       ret = vscnprintf(ui_helpline__last_msg + backlog,
> >>>                       sizeof(ui_helpline__last_msg) - backlog, format, ap);
> >>>       backlog += ret;
> >>> @@ -45,7 +44,7 @@ static int tui_helpline__show(const char *format, va_list ap)
> >>>               SLsmg_refresh();
> >>>               backlog = 0;
> >>>       }
> >>> -     pthread_mutex_unlock(&ui__lock);
> >>> +     mutex_unlock(&ui__lock);
> >>>
> >>>       return ret;
> >>>  }
> >>> diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
> >>> index 3d74af5a7ece..71b6c8d9474f 100644
> >>> --- a/tools/perf/ui/tui/progress.c
> >>> +++ b/tools/perf/ui/tui/progress.c
> >>> @@ -45,7 +45,7 @@ static void tui_progress__update(struct ui_progress *p)
> >>>       }
> >>>
> >>>       ui__refresh_dimensions(false);
> >>> -     pthread_mutex_lock(&ui__lock);
> >>> +     mutex_lock(&ui__lock);
> >>>       y = SLtt_Screen_Rows / 2 - 2;
> >>>       SLsmg_set_color(0);
> >>>       SLsmg_draw_box(y, 0, 3, SLtt_Screen_Cols);
> >>> @@ -56,7 +56,7 @@ static void tui_progress__update(struct ui_progress *p)
> >>>       bar = ((SLtt_Screen_Cols - 2) * p->curr) / p->total;
> >>>       SLsmg_fill_region(y, 1, 1, bar, ' ');
> >>>       SLsmg_refresh();
> >>> -     pthread_mutex_unlock(&ui__lock);
> >>> +     mutex_unlock(&ui__lock);
> >>>  }
> >>>
> >>>  static void tui_progress__finish(void)
> >>> @@ -67,12 +67,12 @@ static void tui_progress__finish(void)
> >>>               return;
> >>>
> >>>       ui__refresh_dimensions(false);
> >>> -     pthread_mutex_lock(&ui__lock);
> >>> +     mutex_lock(&ui__lock);
> >>>       y = SLtt_Screen_Rows / 2 - 2;
> >>>       SLsmg_set_color(0);
> >>>       SLsmg_fill_region(y, 0, 3, SLtt_Screen_Cols, ' ');
> >>>       SLsmg_refresh();
> >>> -     pthread_mutex_unlock(&ui__lock);
> >>> +     mutex_unlock(&ui__lock);
> >>>  }
> >>>
> >>>  static struct ui_progress_ops tui_progress__ops = {
> >>> diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
> >>> index b1be59b4e2a4..a3b8c397c24d 100644
> >>> --- a/tools/perf/ui/tui/setup.c
> >>> +++ b/tools/perf/ui/tui/setup.c
> >>> @@ -29,10 +29,10 @@ void ui__refresh_dimensions(bool force)
> >>>  {
> >>>       if (force || ui__need_resize) {
> >>>               ui__need_resize = 0;
> >>> -             pthread_mutex_lock(&ui__lock);
> >>> +             mutex_lock(&ui__lock);
> >>>               SLtt_get_screen_size();
> >>>               SLsmg_reinit_smg();
> >>> -             pthread_mutex_unlock(&ui__lock);
> >>> +             mutex_unlock(&ui__lock);
> >>>       }
> >>>  }
> >>>
> >>> @@ -170,10 +170,10 @@ void ui__exit(bool wait_for_ok)
> >>>                                   "Press any key...", 0);
> >>>
> >>>       SLtt_set_cursor_visibility(1);
> >>> -     if (!pthread_mutex_trylock(&ui__lock)) {
> >>> +     if (mutex_trylock(&ui__lock)) {
> >>>               SLsmg_refresh();
> >>>               SLsmg_reset_smg();
> >>> -             pthread_mutex_unlock(&ui__lock);
> >>> +             mutex_unlock(&ui__lock);
> >>>       }
> >>>       SLang_reset_tty();
> >>>       perf_error__unregister(&perf_tui_eops);
> >>> diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
> >>> index 0f562e2cb1e8..3c5174854ac8 100644
> >>> --- a/tools/perf/ui/tui/util.c
> >>> +++ b/tools/perf/ui/tui/util.c
> >>> @@ -95,7 +95,7 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
> >>>               t = sep + 1;
> >>>       }
> >>>
> >>> -     pthread_mutex_lock(&ui__lock);
> >>> +     mutex_lock(&ui__lock);
> >>>
> >>>       max_len += 2;
> >>>       nr_lines += 8;
> >>> @@ -125,17 +125,17 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
> >>>       SLsmg_write_nstring((char *)exit_msg, max_len);
> >>>       SLsmg_refresh();
> >>>
> >>> -     pthread_mutex_unlock(&ui__lock);
> >>> +     mutex_unlock(&ui__lock);
> >>>
> >>>       x += 2;
> >>>       len = 0;
> >>>       key = ui__getch(delay_secs);
> >>>       while (key != K_TIMER && key != K_ENTER && key != K_ESC) {
> >>> -             pthread_mutex_lock(&ui__lock);
> >>> +             mutex_lock(&ui__lock);
> >>>
> >>>               if (key == K_BKSPC) {
> >>>                       if (len == 0) {
> >>> -                             pthread_mutex_unlock(&ui__lock);
> >>> +                             mutex_unlock(&ui__lock);
> >>>                               goto next_key;
> >>>                       }
> >>>                       SLsmg_gotorc(y, x + --len);
> >>> @@ -147,7 +147,7 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
> >>>               }
> >>>               SLsmg_refresh();
> >>>
> >>> -             pthread_mutex_unlock(&ui__lock);
> >>> +             mutex_unlock(&ui__lock);
> >>>
> >>>               /* XXX more graceful overflow handling needed */
> >>>               if (len == sizeof(buf) - 1) {
> >>> @@ -215,19 +215,19 @@ void __ui__info_window(const char *title, const char *text, const char *exit_msg
> >>>
> >>>  void ui__info_window(const char *title, const char *text)
> >>>  {
> >>> -     pthread_mutex_lock(&ui__lock);
> >>> +     mutex_lock(&ui__lock);
> >>>       __ui__info_window(title, text, NULL);
> >>>       SLsmg_refresh();
> >>> -     pthread_mutex_unlock(&ui__lock);
> >>> +     mutex_unlock(&ui__lock);
> >>>  }
> >>>
> >>>  int ui__question_window(const char *title, const char *text,
> >>>                       const char *exit_msg, int delay_secs)
> >>>  {
> >>> -     pthread_mutex_lock(&ui__lock);
> >>> +     mutex_lock(&ui__lock);
> >>>       __ui__info_window(title, text, exit_msg);
> >>>       SLsmg_refresh();
> >>> -     pthread_mutex_unlock(&ui__lock);
> >>> +     mutex_unlock(&ui__lock);
> >>>       return ui__getch(delay_secs);
> >>>  }
> >>>
> >>> diff --git a/tools/perf/ui/ui.h b/tools/perf/ui/ui.h
> >>> index 9b6fdf06e1d2..99f8d2fe9bc5 100644
> >>> --- a/tools/perf/ui/ui.h
> >>> +++ b/tools/perf/ui/ui.h
> >>> @@ -2,11 +2,11 @@
> >>>  #ifndef _PERF_UI_H_
> >>>  #define _PERF_UI_H_ 1
> >>>
> >>> -#include <pthread.h>
> >>> +#include "../util/mutex.h"
> >>>  #include <stdbool.h>
> >>>  #include <linux/compiler.h>
> >>>
> >>> -extern pthread_mutex_t ui__lock;
> >>> +extern struct mutex ui__lock;
> >>>  extern void *perf_gtk_handle;
> >>>
> >>>  extern int use_browser;
> >>
>
