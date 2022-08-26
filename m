Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5F5A258B
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiHZKLi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 06:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHZKLh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 06:11:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F63A9C10;
        Fri, 26 Aug 2022 03:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661508696; x=1693044696;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=yNvu6BGSLX3xsDtWd6DweoqiDg0tvzIavq7gCuURtPM=;
  b=maQY4tNuyWGHsgeA2nBiG5pfMwfWquxLBBjH1zBTbLco5ZzkKzXgn6cI
   kz3p7NNAyy1MSrbMli6sRFxjLgYvszETRbC/bPJbmTiIVszgpTaWELHD1
   7M5wEWn9B9g28+DE+gRRd8+ivVruOI/YBDrt2//DIIU5R3Tt8xZmmMjoY
   Pv2Fu+tHUdZgIFbaBUUs8pNcanFtm6lvg96+B1/trU9VdwKwI5bM38kfu
   /gHo7dVe8PD3t0wpDxzqCvg9IU1hrd/QhqszkbaUWr74wCK86FnAriH9P
   rTGgWYInYOgAexmR7be/Jv0zeYi7NzHAybsTXdgbSiVzWGck6h9pc1RSg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320567072"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="320567072"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 03:11:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="671405086"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 03:11:24 -0700
Message-ID: <0004776a-8c39-9515-fd4e-01bfe1c4a3eb@intel.com>
Date:   Fri, 26 Aug 2022 13:11:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 09/18] perf ui: Update use of pthread mutex
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220824153901.488576-10-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/08/22 18:38, Ian Rogers wrote:
> Switch to the use of mutex wrappers that provide better error checking.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/ui/browser.c           | 20 ++++++++++----------
>  tools/perf/ui/browsers/annotate.c |  2 +-

Other changes to tools/perf/ui/browsers/annotate.c are in patch 12

>  tools/perf/ui/setup.c             |  5 +++--
>  tools/perf/ui/tui/helpline.c      |  5 ++---
>  tools/perf/ui/tui/progress.c      |  8 ++++----
>  tools/perf/ui/tui/setup.c         |  8 ++++----
>  tools/perf/ui/tui/util.c          | 18 +++++++++---------
>  tools/perf/ui/ui.h                |  4 ++--
>  8 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> index fa5bd5c20e96..78fb01d6ad63 100644
> --- a/tools/perf/ui/browser.c
> +++ b/tools/perf/ui/browser.c
> @@ -268,9 +268,9 @@ void __ui_browser__show_title(struct ui_browser *browser, const char *title)
>  
>  void ui_browser__show_title(struct ui_browser *browser, const char *title)
>  {
> -	pthread_mutex_lock(&ui__lock);
> +	mutex_lock(&ui__lock);
>  	__ui_browser__show_title(browser, title);
> -	pthread_mutex_unlock(&ui__lock);
> +	mutex_unlock(&ui__lock);
>  }
>  
>  int ui_browser__show(struct ui_browser *browser, const char *title,
> @@ -284,7 +284,7 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
>  
>  	browser->refresh_dimensions(browser);
>  
> -	pthread_mutex_lock(&ui__lock);
> +	mutex_lock(&ui__lock);
>  	__ui_browser__show_title(browser, title);
>  
>  	browser->title = title;
> @@ -295,16 +295,16 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
>  	va_end(ap);
>  	if (err > 0)
>  		ui_helpline__push(browser->helpline);
> -	pthread_mutex_unlock(&ui__lock);
> +	mutex_unlock(&ui__lock);
>  	return err ? 0 : -1;
>  }
>  
>  void ui_browser__hide(struct ui_browser *browser)
>  {
> -	pthread_mutex_lock(&ui__lock);
> +	mutex_lock(&ui__lock);
>  	ui_helpline__pop();
>  	zfree(&browser->helpline);
> -	pthread_mutex_unlock(&ui__lock);
> +	mutex_unlock(&ui__lock);
>  }
>  
>  static void ui_browser__scrollbar_set(struct ui_browser *browser)
> @@ -352,9 +352,9 @@ static int __ui_browser__refresh(struct ui_browser *browser)
>  
>  int ui_browser__refresh(struct ui_browser *browser)
>  {
> -	pthread_mutex_lock(&ui__lock);
> +	mutex_lock(&ui__lock);
>  	__ui_browser__refresh(browser);
> -	pthread_mutex_unlock(&ui__lock);
> +	mutex_unlock(&ui__lock);
>  
>  	return 0;
>  }
> @@ -390,10 +390,10 @@ int ui_browser__run(struct ui_browser *browser, int delay_secs)
>  	while (1) {
>  		off_t offset;
>  
> -		pthread_mutex_lock(&ui__lock);
> +		mutex_lock(&ui__lock);
>  		err = __ui_browser__refresh(browser);
>  		SLsmg_refresh();
> -		pthread_mutex_unlock(&ui__lock);
> +		mutex_unlock(&ui__lock);
>  		if (err < 0)
>  			break;
>  
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 44ba900828f6..b8747e8dd9ea 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -8,11 +8,11 @@
>  #include "../../util/hist.h"
>  #include "../../util/sort.h"
>  #include "../../util/map.h"
> +#include "../../util/mutex.h"
>  #include "../../util/symbol.h"
>  #include "../../util/evsel.h"
>  #include "../../util/evlist.h"
>  #include <inttypes.h>
> -#include <pthread.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>  #include <linux/zalloc.h>
> diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
> index 700335cde618..25ded88801a3 100644
> --- a/tools/perf/ui/setup.c
> +++ b/tools/perf/ui/setup.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <pthread.h>
>  #include <dlfcn.h>
>  #include <unistd.h>
>  
> @@ -8,7 +7,7 @@
>  #include "../util/hist.h"
>  #include "ui.h"
>  
> -pthread_mutex_t ui__lock = PTHREAD_MUTEX_INITIALIZER;
> +struct mutex ui__lock;
>  void *perf_gtk_handle;
>  int use_browser = -1;
>  
> @@ -76,6 +75,7 @@ int stdio__config_color(const struct option *opt __maybe_unused,
>  
>  void setup_browser(bool fallback_to_pager)
>  {
> +	mutex_init(&ui__lock);
>  	if (use_browser < 2 && (!isatty(1) || dump_trace))
>  		use_browser = 0;
>  
> @@ -118,4 +118,5 @@ void exit_browser(bool wait_for_ok)
>  	default:
>  		break;
>  	}
> +	mutex_destroy(&ui__lock);
>  }
> diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
> index 298d6af82fdd..db4952f5990b 100644
> --- a/tools/perf/ui/tui/helpline.c
> +++ b/tools/perf/ui/tui/helpline.c
> @@ -2,7 +2,6 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> -#include <pthread.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>  
> @@ -33,7 +32,7 @@ static int tui_helpline__show(const char *format, va_list ap)
>  	int ret;
>  	static int backlog;
>  
> -	pthread_mutex_lock(&ui__lock);
> +	mutex_lock(&ui__lock);
>  	ret = vscnprintf(ui_helpline__last_msg + backlog,
>  			sizeof(ui_helpline__last_msg) - backlog, format, ap);
>  	backlog += ret;
> @@ -45,7 +44,7 @@ static int tui_helpline__show(const char *format, va_list ap)
>  		SLsmg_refresh();
>  		backlog = 0;
>  	}
> -	pthread_mutex_unlock(&ui__lock);
> +	mutex_unlock(&ui__lock);
>  
>  	return ret;
>  }
> diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
> index 3d74af5a7ece..71b6c8d9474f 100644
> --- a/tools/perf/ui/tui/progress.c
> +++ b/tools/perf/ui/tui/progress.c
> @@ -45,7 +45,7 @@ static void tui_progress__update(struct ui_progress *p)
>  	}
>  
>  	ui__refresh_dimensions(false);
> -	pthread_mutex_lock(&ui__lock);
> +	mutex_lock(&ui__lock);
>  	y = SLtt_Screen_Rows / 2 - 2;
>  	SLsmg_set_color(0);
>  	SLsmg_draw_box(y, 0, 3, SLtt_Screen_Cols);
> @@ -56,7 +56,7 @@ static void tui_progress__update(struct ui_progress *p)
>  	bar = ((SLtt_Screen_Cols - 2) * p->curr) / p->total;
>  	SLsmg_fill_region(y, 1, 1, bar, ' ');
>  	SLsmg_refresh();
> -	pthread_mutex_unlock(&ui__lock);
> +	mutex_unlock(&ui__lock);
>  }
>  
>  static void tui_progress__finish(void)
> @@ -67,12 +67,12 @@ static void tui_progress__finish(void)
>  		return;
>  
>  	ui__refresh_dimensions(false);
> -	pthread_mutex_lock(&ui__lock);
> +	mutex_lock(&ui__lock);
>  	y = SLtt_Screen_Rows / 2 - 2;
>  	SLsmg_set_color(0);
>  	SLsmg_fill_region(y, 0, 3, SLtt_Screen_Cols, ' ');
>  	SLsmg_refresh();
> -	pthread_mutex_unlock(&ui__lock);
> +	mutex_unlock(&ui__lock);
>  }
>  
>  static struct ui_progress_ops tui_progress__ops = {
> diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
> index b1be59b4e2a4..a3b8c397c24d 100644
> --- a/tools/perf/ui/tui/setup.c
> +++ b/tools/perf/ui/tui/setup.c
> @@ -29,10 +29,10 @@ void ui__refresh_dimensions(bool force)
>  {
>  	if (force || ui__need_resize) {
>  		ui__need_resize = 0;
> -		pthread_mutex_lock(&ui__lock);
> +		mutex_lock(&ui__lock);
>  		SLtt_get_screen_size();
>  		SLsmg_reinit_smg();
> -		pthread_mutex_unlock(&ui__lock);
> +		mutex_unlock(&ui__lock);
>  	}
>  }
>  
> @@ -170,10 +170,10 @@ void ui__exit(bool wait_for_ok)
>  				    "Press any key...", 0);
>  
>  	SLtt_set_cursor_visibility(1);
> -	if (!pthread_mutex_trylock(&ui__lock)) {
> +	if (mutex_trylock(&ui__lock)) {
>  		SLsmg_refresh();
>  		SLsmg_reset_smg();
> -		pthread_mutex_unlock(&ui__lock);
> +		mutex_unlock(&ui__lock);
>  	}
>  	SLang_reset_tty();
>  	perf_error__unregister(&perf_tui_eops);
> diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
> index 0f562e2cb1e8..3c5174854ac8 100644
> --- a/tools/perf/ui/tui/util.c
> +++ b/tools/perf/ui/tui/util.c
> @@ -95,7 +95,7 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
>  		t = sep + 1;
>  	}
>  
> -	pthread_mutex_lock(&ui__lock);
> +	mutex_lock(&ui__lock);
>  
>  	max_len += 2;
>  	nr_lines += 8;
> @@ -125,17 +125,17 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
>  	SLsmg_write_nstring((char *)exit_msg, max_len);
>  	SLsmg_refresh();
>  
> -	pthread_mutex_unlock(&ui__lock);
> +	mutex_unlock(&ui__lock);
>  
>  	x += 2;
>  	len = 0;
>  	key = ui__getch(delay_secs);
>  	while (key != K_TIMER && key != K_ENTER && key != K_ESC) {
> -		pthread_mutex_lock(&ui__lock);
> +		mutex_lock(&ui__lock);
>  
>  		if (key == K_BKSPC) {
>  			if (len == 0) {
> -				pthread_mutex_unlock(&ui__lock);
> +				mutex_unlock(&ui__lock);
>  				goto next_key;
>  			}
>  			SLsmg_gotorc(y, x + --len);
> @@ -147,7 +147,7 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
>  		}
>  		SLsmg_refresh();
>  
> -		pthread_mutex_unlock(&ui__lock);
> +		mutex_unlock(&ui__lock);
>  
>  		/* XXX more graceful overflow handling needed */
>  		if (len == sizeof(buf) - 1) {
> @@ -215,19 +215,19 @@ void __ui__info_window(const char *title, const char *text, const char *exit_msg
>  
>  void ui__info_window(const char *title, const char *text)
>  {
> -	pthread_mutex_lock(&ui__lock);
> +	mutex_lock(&ui__lock);
>  	__ui__info_window(title, text, NULL);
>  	SLsmg_refresh();
> -	pthread_mutex_unlock(&ui__lock);
> +	mutex_unlock(&ui__lock);
>  }
>  
>  int ui__question_window(const char *title, const char *text,
>  			const char *exit_msg, int delay_secs)
>  {
> -	pthread_mutex_lock(&ui__lock);
> +	mutex_lock(&ui__lock);
>  	__ui__info_window(title, text, exit_msg);
>  	SLsmg_refresh();
> -	pthread_mutex_unlock(&ui__lock);
> +	mutex_unlock(&ui__lock);
>  	return ui__getch(delay_secs);
>  }
>  
> diff --git a/tools/perf/ui/ui.h b/tools/perf/ui/ui.h
> index 9b6fdf06e1d2..99f8d2fe9bc5 100644
> --- a/tools/perf/ui/ui.h
> +++ b/tools/perf/ui/ui.h
> @@ -2,11 +2,11 @@
>  #ifndef _PERF_UI_H_
>  #define _PERF_UI_H_ 1
>  
> -#include <pthread.h>
> +#include "../util/mutex.h"
>  #include <stdbool.h>
>  #include <linux/compiler.h>
>  
> -extern pthread_mutex_t ui__lock;
> +extern struct mutex ui__lock;
>  extern void *perf_gtk_handle;
>  
>  extern int use_browser;

