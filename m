Return-Path: <bpf+bounces-32076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C65907194
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 14:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882511F270D9
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E11143C40;
	Thu, 13 Jun 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WZrur3HK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC91DDDB;
	Thu, 13 Jun 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282283; cv=none; b=U+JjFSIRMFFg1H/by1jFevpWTzHvrPeqZOFA/dkfYdlZhnsVgz+YvQzni0rqUWpfWEdfZdg/CyFZD9ujab8+jbKp6DMGENGwF8CFsdLI38CGwCWa072HizL82FF1OkMeuhKbsTcMRTbppazsss+hDyc2i9z84Jf1gc4oi1FLpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282283; c=relaxed/simple;
	bh=T/rzh9aSn4RcO7ZA+0rbrb8aaIEhNgPoIlj2vbzNxm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4Bk2V90bo2R4+CjrCI+zLk2BEfdKJF3l6m97wFJ62ilshN+R1imj37X+FqjNsyBrVPV8HwmixErCkZ7WSI79LfcLPcKnksihEUUgoj3wVKO37+x+UsOj3Su315flC0BEEtlJr9dD6qFQ9ohtR2jeS6XwNYG3mvLF3WLzPWaeu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WZrur3HK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C52FC4AF1A;
	Thu, 13 Jun 2024 12:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282283;
	bh=T/rzh9aSn4RcO7ZA+0rbrb8aaIEhNgPoIlj2vbzNxm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZrur3HKomS3Z8q9b37+VNBS56vD3kKPnPANx4lA3Px/MKE6TbFGb7LiPweo+RUIy
	 O599ufXfYrGfzeT4Ql9SSW8fhgYxG/QVwsyEsFiakUGpwLM56K5wXWt1cT4q/oUpqH
	 2RRO6fcKjhamq9Rem8niUtdhEu0nIdWTiw+rGCBI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Truong <alexandre.truong@arm.com>,
	Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Andres Freund <andres@anarazel.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Colin Ian King <colin.king@intel.com>,
	Dario Petrillo <dario.pk1@gmail.com>,
	Darren Hart <dvhart@infradead.org>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Fangrui Song <maskray@google.com>,
	Hewenliang <hewenliang4@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@arm.com>,
	Jason Wang <wangborong@cdjrlc.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Kim Phillips <kim.phillips@amd.com>,
	Leo Yan <leo.yan@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	=?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Pavithra Gurushankar <gpavithrasha@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Remi Bernon <rbernon@codeweavers.com>,
	Riccardo Mancini <rickyman7@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tom Rix <trix@redhat.com>,
	Weiguo Li <liwg06@foxmail.com>,
	Wenyu Liu <liuwenyu7@huawei.com>,
	William Cohen <wcohen@redhat.com>,
	Zechuan Chen <chenzechuan1@huawei.com>,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	yaowenbin <yaowenbin1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 225/402] perf ui: Update use of pthread mutex
Date: Thu, 13 Jun 2024 13:33:02 +0200
Message-ID: <20240613113310.919420194@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 82aff6cc070417f26f9b02b26e63c17ff43b4044 ]

Switch to the use of mutex wrappers that provide better error checking.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexandre Truong <alexandre.truong@arm.com>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andres Freund <andres@anarazel.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Colin Ian King <colin.king@intel.com>
Cc: Dario Petrillo <dario.pk1@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Dave Marchevsky <davemarchevsky@fb.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Fangrui Song <maskray@google.com>
Cc: Hewenliang <hewenliang4@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jason Wang <wangborong@cdjrlc.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Pavithra Gurushankar <gpavithrasha@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Monnet <quentin@isovalent.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Remi Bernon <rbernon@codeweavers.com>
Cc: Riccardo Mancini <rickyman7@gmail.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Weiguo Li <liwg06@foxmail.com>
Cc: Wenyu Liu <liuwenyu7@huawei.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: Zechuan Chen <chenzechuan1@huawei.com>
Cc: bpf@vger.kernel.org
Cc: llvm@lists.linux.dev
Cc: yaowenbin <yaowenbin1@huawei.com>
Link: https://lore.kernel.org/r/20220826164242.43412-10-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 769e6a1e15bd ("perf ui browser: Don't save pointer to stack memory")
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index fa5bd5c20e96b..78fb01d6ad63f 100644
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
index 44ba900828f6c..b8747e8dd9ea4 100644
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
index 700335cde6180..25ded88801a3d 100644
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
index 298d6af82fddd..db4952f5990bd 100644
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
index 3d74af5a7ece6..71b6c8d9474fb 100644
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
index b1be59b4e2a4f..a3b8c397c24d5 100644
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
index 0f562e2cb1e88..3c5174854ac8b 100644
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
index 9b6fdf06e1d2f..99f8d2fe9bc55 100644
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
2.43.0




