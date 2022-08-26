Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA445A2F72
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbiHZS4o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345208AbiHZS4L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:56:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145A561720;
        Fri, 26 Aug 2022 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661539959; x=1693075959;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5hyOfHMGCRPY6ozMNY9uanlYd4nTpOOLMFBXCCdYf/s=;
  b=bYUUbuKxoPRDbNiazFQFPee4Posn64oT140h6cFJl0kSyvJpXKJxP54V
   HXNoIhmoU7crI/P6ivmf9apHEJSrlATN4vHjBnLelJrC3Meml7ejLBzQT
   XWpaNnq0piPKyR/hYH5IlGDfLm1DHpDD1VyLXFVweG1iKMPvVNHpK2u2x
   UilDCjivaa4lgJEYXsHFxMWOSjYW9A7c6AnX1OXrOXBDSWALOCQEVH/5h
   9jqiNvS142jXURpWckO/wLQGmoXJsV3iq83gc8gvDUo0FcGUCS3hJn8AP
   CdEqcBCKMraTmOPAVsobfHI/pMJJaLbnbU56Ox411YmosQqwTRYDATX8K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="294578439"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="294578439"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 11:52:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="671578974"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 11:52:27 -0700
Message-ID: <43540a3d-e64e-ec08-e12e-aebb236a2efe@intel.com>
Date:   Fri, 26 Aug 2022 21:52:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 09/18] perf ui: Update use of pthread mutex
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
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
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
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
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
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
References: <20220824153901.488576-1-irogers@google.com>
 <20220824153901.488576-10-irogers@google.com>
 <2cf6edac-6e41-b43c-2bc1-f49cb739201a@intel.com>
 <CAP-5=fVVWx=LZAzXsxfuktPHwki1gYbV4mcmvJp_9GTDS6KJcQ@mail.gmail.com>
 <a9b4f79d-cdea-821e-0e57-cd4854de6cf4@intel.com>
 <CAP-5=fW7t9tcJpyUbv8JAo-BFna-KS6FC+HkbuGx6S=h+nBMqw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fW7t9tcJpyUbv8JAo-BFna-KS6FC+HkbuGx6S=h+nBMqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 26/08/22 20:45, Ian Rogers wrote:
> On Fri, Aug 26, 2022 at 10:22 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 26/08/22 19:02, Ian Rogers wrote:
>>> On Fri, Aug 26, 2022 at 3:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 24/08/22 18:38, Ian Rogers wrote:
>>>>> Switch to the use of mutex wrappers that provide better error checking.
>>>>>
>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>> ---
>>>>>  tools/perf/ui/browser.c           | 20 ++++++++++----------
>>>>>  tools/perf/ui/browsers/annotate.c |  2 +-
>>>>>  tools/perf/ui/setup.c             |  5 +++--
>>>>>  tools/perf/ui/tui/helpline.c      |  5 ++---
>>>>>  tools/perf/ui/tui/progress.c      |  8 ++++----
>>>>>  tools/perf/ui/tui/setup.c         |  8 ++++----
>>>>>  tools/perf/ui/tui/util.c          | 18 +++++++++---------
>>>>>  tools/perf/ui/ui.h                |  4 ++--
>>>>>  8 files changed, 35 insertions(+), 35 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
>>>>> index fa5bd5c20e96..78fb01d6ad63 100644
>>>>> --- a/tools/perf/ui/browser.c
>>>>> +++ b/tools/perf/ui/browser.c
>>>>> @@ -268,9 +268,9 @@ void __ui_browser__show_title(struct ui_browser *browser, const char *title)
>>>>>
>>>>>  void ui_browser__show_title(struct ui_browser *browser, const char *title)
>>>>>  {
>>>>> -     pthread_mutex_lock(&ui__lock);
>>>>> +     mutex_lock(&ui__lock);
>>>>>       __ui_browser__show_title(browser, title);
>>>>> -     pthread_mutex_unlock(&ui__lock);
>>>>> +     mutex_unlock(&ui__lock);
>>>>>  }
>>>>>
>>>>>  int ui_browser__show(struct ui_browser *browser, const char *title,
>>>>> @@ -284,7 +284,7 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
>>>>>
>>>>>       browser->refresh_dimensions(browser);
>>>>>
>>>>> -     pthread_mutex_lock(&ui__lock);
>>>>> +     mutex_lock(&ui__lock);
>>>>>       __ui_browser__show_title(browser, title);
>>>>>
>>>>>       browser->title = title;
>>>>> @@ -295,16 +295,16 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
>>>>>       va_end(ap);
>>>>>       if (err > 0)
>>>>>               ui_helpline__push(browser->helpline);
>>>>> -     pthread_mutex_unlock(&ui__lock);
>>>>> +     mutex_unlock(&ui__lock);
>>>>>       return err ? 0 : -1;
>>>>>  }
>>>>>
>>>>>  void ui_browser__hide(struct ui_browser *browser)
>>>>>  {
>>>>> -     pthread_mutex_lock(&ui__lock);
>>>>> +     mutex_lock(&ui__lock);
>>>>>       ui_helpline__pop();
>>>>>       zfree(&browser->helpline);
>>>>> -     pthread_mutex_unlock(&ui__lock);
>>>>> +     mutex_unlock(&ui__lock);
>>>>>  }
>>>>>
>>>>>  static void ui_browser__scrollbar_set(struct ui_browser *browser)
>>>>> @@ -352,9 +352,9 @@ static int __ui_browser__refresh(struct ui_browser *browser)
>>>>>
>>>>>  int ui_browser__refresh(struct ui_browser *browser)
>>>>>  {
>>>>> -     pthread_mutex_lock(&ui__lock);
>>>>> +     mutex_lock(&ui__lock);
>>>>>       __ui_browser__refresh(browser);
>>>>> -     pthread_mutex_unlock(&ui__lock);
>>>>> +     mutex_unlock(&ui__lock);
>>>>>
>>>>>       return 0;
>>>>>  }
>>>>> @@ -390,10 +390,10 @@ int ui_browser__run(struct ui_browser *browser, int delay_secs)
>>>>>       while (1) {
>>>>>               off_t offset;
>>>>>
>>>>> -             pthread_mutex_lock(&ui__lock);
>>>>> +             mutex_lock(&ui__lock);
>>>>>               err = __ui_browser__refresh(browser);
>>>>>               SLsmg_refresh();
>>>>> -             pthread_mutex_unlock(&ui__lock);
>>>>> +             mutex_unlock(&ui__lock);
>>>>>               if (err < 0)
>>>>>                       break;
>>>>>
>>>>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
>>>>> index 44ba900828f6..b8747e8dd9ea 100644
>>>>> --- a/tools/perf/ui/browsers/annotate.c
>>>>> +++ b/tools/perf/ui/browsers/annotate.c
>>>>> @@ -8,11 +8,11 @@
>>>>>  #include "../../util/hist.h"
>>>>>  #include "../../util/sort.h"
>>>>>  #include "../../util/map.h"
>>>>> +#include "../../util/mutex.h"
>>>>>  #include "../../util/symbol.h"
>>>>>  #include "../../util/evsel.h"
>>>>>  #include "../../util/evlist.h"
>>>>>  #include <inttypes.h>
>>>>> -#include <pthread.h>
>>>>>  #include <linux/kernel.h>
>>>>>  #include <linux/string.h>
>>>>>  #include <linux/zalloc.h>
>>>>> diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
>>>>> index 700335cde618..25ded88801a3 100644
>>>>> --- a/tools/perf/ui/setup.c
>>>>> +++ b/tools/perf/ui/setup.c
>>>>> @@ -1,5 +1,4 @@
>>>>>  // SPDX-License-Identifier: GPL-2.0
>>>>> -#include <pthread.h>
>>>>>  #include <dlfcn.h>
>>>>>  #include <unistd.h>
>>>>>
>>>>> @@ -8,7 +7,7 @@
>>>>>  #include "../util/hist.h"
>>>>>  #include "ui.h"
>>>>>
>>>>> -pthread_mutex_t ui__lock = PTHREAD_MUTEX_INITIALIZER;
>>>>> +struct mutex ui__lock;
>>>>>  void *perf_gtk_handle;
>>>>>  int use_browser = -1;
>>>>>
>>>>> @@ -76,6 +75,7 @@ int stdio__config_color(const struct option *opt __maybe_unused,
>>>>>
>>>>>  void setup_browser(bool fallback_to_pager)
>>>>>  {
>>>>> +     mutex_init(&ui__lock);
>>>>>       if (use_browser < 2 && (!isatty(1) || dump_trace))
>>>>>               use_browser = 0;
>>>>>
>>>>> @@ -118,4 +118,5 @@ void exit_browser(bool wait_for_ok)
>>>>>       default:
>>>>>               break;
>>>>>       }
>>>>> +     mutex_destroy(&ui__lock);
>>>>
>>>> Looks like exit_browser() can be called even when setup_browser()
>>>> was never called.
>>>>
>>>> Note, it also looks like PTHREAD_MUTEX_INITIALIZER is all zeros so
>>>> pthread won't notice.
>>>
>>> Memory sanitizer will notice some cases of this and so I didn't want
>>> to code defensively around exit being called ahead of setup.
>>
>> I am not sure you understood.
>>
>> As I wrote, exit_browser() can be called even when setup_browser()
>> was never called, so it is not defensive programming, it is necessary
>> programming that you only get away without doing because
>> PTHREAD_MUTEX_INITIALIZER is all zeros.
> 
> Why are we here:
> 1) there is a memory leak
> 2) I fix the memory and trigger a use after free
> 3) I invent a reference count checker, use it to fix the memory leak,
> use after free and missing locks - the patch for this in 10s of lines
> long
> 4) when adding the lock fixes I defensively add error checking to the
> mutex involved - mainly because I was scared I could introduce a
> deadlock
> 5) I get asked to generalize this
> 6) GSoC contributor picks up and puts this down
> 7) I pull together the contributor's work
> 8) I get asked to turn a search and replace 4 patch fix into an unwieldy patch
> 9) I worry about the sanity of the change and add lock checking from clang
> 10) I end up trying to fix perf-sched who for some reason thought it
> was perfectly valid to have threads blocked on mutexes that were
> deallocated on the stack.
> 11) the UI code was written with a view that exiting something not
> setup somehow made sense
> 
> I am drawing a line at fixing perf sched and the UI code. We can drop
> this patch and keep things as a pthread_mutex_t, similarly for
> perf-sched. I have gone about as far as I'm prepared to for the sake
> of a 10s of line memory leak fix. Some private thoughts are, it would
> be useful if review comments could be constructive, hey do this not
> that, and not simply commenting on change or trying to shoehorn vast
> amounts of tech debt clean up onto simple fixes.

If you want help, you only need ask.

Below seems adequate for now, at least logically, but maybe it
would confuse clang thread-safety analysis?

diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
index 25ded88801a3..6d81be6a349e 100644
--- a/tools/perf/ui/setup.c
+++ b/tools/perf/ui/setup.c
@@ -73,9 +73,17 @@ int stdio__config_color(const struct option *opt __maybe_unused,
 	return 0;
 }
 
+/*
+ * exit_browser() can get called without setup_browser() having been called
+ * first, so it is necessary to keep track of whether ui__lock has been
+ * initialized.
+ */
+static bool ui__lock_initialized;
+
 void setup_browser(bool fallback_to_pager)
 {
 	mutex_init(&ui__lock);
+	ui__lock_initialized = true;
 	if (use_browser < 2 && (!isatty(1) || dump_trace))
 		use_browser = 0;
 
@@ -118,5 +126,6 @@ void exit_browser(bool wait_for_ok)
 	default:
 		break;
 	}
-	mutex_destroy(&ui__lock);
+	if (ui__lock_initialized)
+		mutex_destroy(&ui__lock);
 }

