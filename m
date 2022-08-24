Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67F659FE8B
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiHXPkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 11:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbiHXPkZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 11:40:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3054399E6
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:40:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33da75a471cso30013227b3.20
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=BA1zN+uZxMDo1UEMKcWy7XDM8k1fPvAP2mOEhcK9B9E=;
        b=nEOLVIhtcvat5Ia33YtMxHyyUnPtRX1bBMzf+IcWC62kOr88tK2QUM/MSssxYTWhXI
         NWNP1QApGcFt2Vbf80qF4iqXO0obI+sggBDDJHim9FqsffUgrhi740nAUTRtk+nPbOab
         6FpwxhkZYwWBaXV+ESspkJRPwzrKg0ftHiGwwlfaILKS4U6uodcdn9FlR/LuElG++ewx
         EbUcV0inU0Jf0uZLKzGQqq537v7aXTYzr0/dyvoGrdE4aD8LGXycf7IeBAHbEmp3BQ4j
         NEA2rY3kWqIr87euLR49jwacq12uSoQK7Tl1dJXfVPpX8W1JFKs171/UwcyiSvu5b5n3
         x1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=BA1zN+uZxMDo1UEMKcWy7XDM8k1fPvAP2mOEhcK9B9E=;
        b=1O8VPzXL5ctx/WfgoI5KqzmnGFoIth4MxiSpw3IKIt7tPoWfshxjpc39sJRD0uuWwh
         Q/gfeRwIookpY/odCPaqTkH9zSnxIkoW+KCGYXDGp86Rbq9eGzXftFHFMPof/OgDbNkX
         eRAweFgF4Zijj2GRYs49T6OY37PsuIVLLNULKk8E11YP/+PHbsI1VqzJwHO0sR5hIcK4
         rl3EOX1cZjClF+kX16GbcVWq05PZsxiAbTy4aRIdhTRC4KXBqIPpSVYeRbmFdqo3sq+i
         VO/4A8lkSjc61bYwep0y//sZR9xJ1GwCpLfA5uEYRtlV8dmmVGc1XbAssE+B+38vizIN
         HrOA==
X-Gm-Message-State: ACgBeo3mgwhdu7TOcm/tAGJGX58dYP/HRiPrrThKNXkNDrzGNcEnsIN/
        rZ1rQhvZkZWibjX8JVhSdLxk4gGxUkzM
X-Google-Smtp-Source: AA6agR5YOo/q+jZ98wfV2ilb5e3EO6ZR7i521Iq0WLGOABreV5T4Fhirr2k37Djrv5ngA3D8XvpCFo15NzCy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ab82:a348:500d:1fc4])
 (user=irogers job=sendgmr) by 2002:a25:9948:0:b0:67b:fc24:642d with SMTP id
 n8-20020a259948000000b0067bfc24642dmr27544457ybo.42.1661355621430; Wed, 24
 Aug 2022 08:40:21 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:38:52 -0700
In-Reply-To: <20220824153901.488576-1-irogers@google.com>
Message-Id: <20220824153901.488576-10-irogers@google.com>
Mime-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v3 09/18] perf ui: Update use of pthread mutex
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
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
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
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
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to the use of mutex wrappers that provide better error checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browser.c           | 20 ++++++++++----------
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/ui/setup.c             |  5 +++--
 tools/perf/ui/tui/helpline.c      |  5 ++---
 tools/perf/ui/tui/progress.c      |  8 ++++----
 tools/perf/ui/tui/setup.c         |  8 ++++----
 tools/perf/ui/tui/util.c          | 18 +++++++++---------
 tools/perf/ui/ui.h                |  4 ++--
 8 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index fa5bd5c20e96..78fb01d6ad63 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -268,9 +268,9 @@ void __ui_browser__show_title(struct ui_browser *browser, const char *title)
 
 void ui_browser__show_title(struct ui_browser *browser, const char *title)
 {
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	__ui_browser__show_title(browser, title);
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 }
 
 int ui_browser__show(struct ui_browser *browser, const char *title,
@@ -284,7 +284,7 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
 
 	browser->refresh_dimensions(browser);
 
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	__ui_browser__show_title(browser, title);
 
 	browser->title = title;
@@ -295,16 +295,16 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
 	va_end(ap);
 	if (err > 0)
 		ui_helpline__push(browser->helpline);
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 	return err ? 0 : -1;
 }
 
 void ui_browser__hide(struct ui_browser *browser)
 {
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	ui_helpline__pop();
 	zfree(&browser->helpline);
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 }
 
 static void ui_browser__scrollbar_set(struct ui_browser *browser)
@@ -352,9 +352,9 @@ static int __ui_browser__refresh(struct ui_browser *browser)
 
 int ui_browser__refresh(struct ui_browser *browser)
 {
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	__ui_browser__refresh(browser);
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 
 	return 0;
 }
@@ -390,10 +390,10 @@ int ui_browser__run(struct ui_browser *browser, int delay_secs)
 	while (1) {
 		off_t offset;
 
-		pthread_mutex_lock(&ui__lock);
+		mutex_lock(&ui__lock);
 		err = __ui_browser__refresh(browser);
 		SLsmg_refresh();
-		pthread_mutex_unlock(&ui__lock);
+		mutex_unlock(&ui__lock);
 		if (err < 0)
 			break;
 
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 44ba900828f6..b8747e8dd9ea 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -8,11 +8,11 @@
 #include "../../util/hist.h"
 #include "../../util/sort.h"
 #include "../../util/map.h"
+#include "../../util/mutex.h"
 #include "../../util/symbol.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
 #include <inttypes.h>
-#include <pthread.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
index 700335cde618..25ded88801a3 100644
--- a/tools/perf/ui/setup.c
+++ b/tools/perf/ui/setup.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <pthread.h>
 #include <dlfcn.h>
 #include <unistd.h>
 
@@ -8,7 +7,7 @@
 #include "../util/hist.h"
 #include "ui.h"
 
-pthread_mutex_t ui__lock = PTHREAD_MUTEX_INITIALIZER;
+struct mutex ui__lock;
 void *perf_gtk_handle;
 int use_browser = -1;
 
@@ -76,6 +75,7 @@ int stdio__config_color(const struct option *opt __maybe_unused,
 
 void setup_browser(bool fallback_to_pager)
 {
+	mutex_init(&ui__lock);
 	if (use_browser < 2 && (!isatty(1) || dump_trace))
 		use_browser = 0;
 
@@ -118,4 +118,5 @@ void exit_browser(bool wait_for_ok)
 	default:
 		break;
 	}
+	mutex_destroy(&ui__lock);
 }
diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index 298d6af82fdd..db4952f5990b 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -2,7 +2,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <pthread.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 
@@ -33,7 +32,7 @@ static int tui_helpline__show(const char *format, va_list ap)
 	int ret;
 	static int backlog;
 
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	ret = vscnprintf(ui_helpline__last_msg + backlog,
 			sizeof(ui_helpline__last_msg) - backlog, format, ap);
 	backlog += ret;
@@ -45,7 +44,7 @@ static int tui_helpline__show(const char *format, va_list ap)
 		SLsmg_refresh();
 		backlog = 0;
 	}
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 
 	return ret;
 }
diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
index 3d74af5a7ece..71b6c8d9474f 100644
--- a/tools/perf/ui/tui/progress.c
+++ b/tools/perf/ui/tui/progress.c
@@ -45,7 +45,7 @@ static void tui_progress__update(struct ui_progress *p)
 	}
 
 	ui__refresh_dimensions(false);
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	y = SLtt_Screen_Rows / 2 - 2;
 	SLsmg_set_color(0);
 	SLsmg_draw_box(y, 0, 3, SLtt_Screen_Cols);
@@ -56,7 +56,7 @@ static void tui_progress__update(struct ui_progress *p)
 	bar = ((SLtt_Screen_Cols - 2) * p->curr) / p->total;
 	SLsmg_fill_region(y, 1, 1, bar, ' ');
 	SLsmg_refresh();
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 }
 
 static void tui_progress__finish(void)
@@ -67,12 +67,12 @@ static void tui_progress__finish(void)
 		return;
 
 	ui__refresh_dimensions(false);
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	y = SLtt_Screen_Rows / 2 - 2;
 	SLsmg_set_color(0);
 	SLsmg_fill_region(y, 0, 3, SLtt_Screen_Cols, ' ');
 	SLsmg_refresh();
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 }
 
 static struct ui_progress_ops tui_progress__ops = {
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index b1be59b4e2a4..a3b8c397c24d 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -29,10 +29,10 @@ void ui__refresh_dimensions(bool force)
 {
 	if (force || ui__need_resize) {
 		ui__need_resize = 0;
-		pthread_mutex_lock(&ui__lock);
+		mutex_lock(&ui__lock);
 		SLtt_get_screen_size();
 		SLsmg_reinit_smg();
-		pthread_mutex_unlock(&ui__lock);
+		mutex_unlock(&ui__lock);
 	}
 }
 
@@ -170,10 +170,10 @@ void ui__exit(bool wait_for_ok)
 				    "Press any key...", 0);
 
 	SLtt_set_cursor_visibility(1);
-	if (!pthread_mutex_trylock(&ui__lock)) {
+	if (mutex_trylock(&ui__lock)) {
 		SLsmg_refresh();
 		SLsmg_reset_smg();
-		pthread_mutex_unlock(&ui__lock);
+		mutex_unlock(&ui__lock);
 	}
 	SLang_reset_tty();
 	perf_error__unregister(&perf_tui_eops);
diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index 0f562e2cb1e8..3c5174854ac8 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -95,7 +95,7 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
 		t = sep + 1;
 	}
 
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 
 	max_len += 2;
 	nr_lines += 8;
@@ -125,17 +125,17 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
 	SLsmg_write_nstring((char *)exit_msg, max_len);
 	SLsmg_refresh();
 
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 
 	x += 2;
 	len = 0;
 	key = ui__getch(delay_secs);
 	while (key != K_TIMER && key != K_ENTER && key != K_ESC) {
-		pthread_mutex_lock(&ui__lock);
+		mutex_lock(&ui__lock);
 
 		if (key == K_BKSPC) {
 			if (len == 0) {
-				pthread_mutex_unlock(&ui__lock);
+				mutex_unlock(&ui__lock);
 				goto next_key;
 			}
 			SLsmg_gotorc(y, x + --len);
@@ -147,7 +147,7 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
 		}
 		SLsmg_refresh();
 
-		pthread_mutex_unlock(&ui__lock);
+		mutex_unlock(&ui__lock);
 
 		/* XXX more graceful overflow handling needed */
 		if (len == sizeof(buf) - 1) {
@@ -215,19 +215,19 @@ void __ui__info_window(const char *title, const char *text, const char *exit_msg
 
 void ui__info_window(const char *title, const char *text)
 {
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	__ui__info_window(title, text, NULL);
 	SLsmg_refresh();
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 }
 
 int ui__question_window(const char *title, const char *text,
 			const char *exit_msg, int delay_secs)
 {
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	__ui__info_window(title, text, exit_msg);
 	SLsmg_refresh();
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 	return ui__getch(delay_secs);
 }
 
diff --git a/tools/perf/ui/ui.h b/tools/perf/ui/ui.h
index 9b6fdf06e1d2..99f8d2fe9bc5 100644
--- a/tools/perf/ui/ui.h
+++ b/tools/perf/ui/ui.h
@@ -2,11 +2,11 @@
 #ifndef _PERF_UI_H_
 #define _PERF_UI_H_ 1
 
-#include <pthread.h>
+#include "../util/mutex.h"
 #include <stdbool.h>
 #include <linux/compiler.h>
 
-extern pthread_mutex_t ui__lock;
+extern struct mutex ui__lock;
 extern void *perf_gtk_handle;
 
 extern int use_browser;
-- 
2.37.2.609.g9ff673ca1a-goog

