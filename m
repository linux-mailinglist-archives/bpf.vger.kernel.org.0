Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676A059FE97
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 17:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiHXPlL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 11:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbiHXPku (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 11:40:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B857E4F653
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:40:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-336c3b72da5so292134957b3.6
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=E+v8EG42HRikeSNXbmnFQC/dENrnMCWWyvKN9u3QR5M=;
        b=kk7GHJbl10t2LSP2yw9VaKovZEQR44FQrddt7kqK2Ys6J5SQGwWPEL95ziuQIQ8pfY
         msoCOGNgKQw3P8by/o3IgN4F355tvlqYg64SDIzCtmbJXrbznmJmBM+FShGoc39SFXK0
         aPMlYh5ctAS+GDcW9uQFfAyJLq1cf+ud97K0xtS/MA3S+4RbtkwiOm13ikVpmk9ieanQ
         dpf2Kr0wCOwf3nIodSr/ULuOzOgNOwMOm5Ixk+OuwDMunBOO/ZC7fadZUmBkePH6MUM8
         jRmZW2WN0+p56IyrkOuWtjUysotivr4ObMwuWqIWMhStgXBBZWhSkWyuJTXPsaH7Vb8K
         JuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=E+v8EG42HRikeSNXbmnFQC/dENrnMCWWyvKN9u3QR5M=;
        b=BJJ69SDiqtyDqvLbaRLbxFN7aaPa32oc5XN+ijHmwGRs2jIoDWuqwo0S7Z1fWs8MkZ
         EfE8a4z/3KfPZTywlzu+IfHCmPav3PrdvGB5oc8B4yrRGBEihSFdxssxX+6QPWnQwiOD
         0A/MoLZKIzQ9JqNdHCdwcrG2YYD4sNQnWeXGeWmXq3/TGxOGrbgHPI5TLkcI02/qEB6o
         El7FL3t4hVXHa4BGQBYPGF7X9wpf1QyUBJ+baPc3wvRCWFNEh8L8Rez7fypvc6X6q2DE
         QohIrZSP3AA5SN93bEEme5xj+wSv4al7boyFOKzpXg0Va7RcRcpFQoTvQJODAON8yExA
         CJbw==
X-Gm-Message-State: ACgBeo2SYrG5vI8fz+g7L8ra5eoxz9JZbg+ZycZSOuCD7D3oMWr9Xsim
        lBcSa6ICOXnVt+gU+rO81leWz7owQWub
X-Google-Smtp-Source: AA6agR6To5JIGWetFoXHI+NlxYSghgWpdXQVzu35CdiAL1UudXivS7x6NKkZpd5FNbHmhtRzX5R0a+c9Eo9E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ab82:a348:500d:1fc4])
 (user=irogers job=sendgmr) by 2002:a25:41c5:0:b0:690:18a0:c7ee with SMTP id
 o188-20020a2541c5000000b0069018a0c7eemr30626984yba.1.1661355641946; Wed, 24
 Aug 2022 08:40:41 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:38:55 -0700
In-Reply-To: <20220824153901.488576-1-irogers@google.com>
Message-Id: <20220824153901.488576-13-irogers@google.com>
Mime-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v3 12/18] perf annotate: Update use of pthread mutex
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to the use of mutex wrappers that provide better error checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c          | 14 +++++++-------
 tools/perf/ui/browsers/annotate.c | 10 +++++-----
 tools/perf/util/annotate.c        | 13 ++++++-------
 tools/perf/util/annotate.h        |  4 ++--
 4 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 14e60f6f219c..b96bb9a23ac0 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -136,10 +136,10 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	}
 
 	notes = symbol__annotation(sym);
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 
 	if (!symbol__hists(sym, top->evlist->core.nr_entries)) {
-		pthread_mutex_unlock(&notes->lock);
+		mutex_unlock(&notes->lock);
 		pr_err("Not enough memory for annotating '%s' symbol!\n",
 		       sym->name);
 		sleep(1);
@@ -155,7 +155,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		pr_err("Couldn't annotate %s: %s\n", sym->name, msg);
 	}
 
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 	return err;
 }
 
@@ -208,12 +208,12 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 
 	notes = symbol__annotation(sym);
 
-	if (pthread_mutex_trylock(&notes->lock))
+	if (!mutex_trylock(&notes->lock))
 		return;
 
 	err = hist_entry__inc_addr_samples(he, sample, evsel, ip);
 
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 
 	if (unlikely(err)) {
 		/*
@@ -250,7 +250,7 @@ static void perf_top__show_details(struct perf_top *top)
 	symbol = he->ms.sym;
 	notes = symbol__annotation(symbol);
 
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 
 	symbol__calc_percent(symbol, evsel);
 
@@ -271,7 +271,7 @@ static void perf_top__show_details(struct perf_top *top)
 	if (more != 0)
 		printf("%d lines not displayed, maybe increase display entries [e]\n", more);
 out_unlock:
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 }
 
 static void perf_top__resort_hists(struct perf_top *t)
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index b8747e8dd9ea..9bc1076374ff 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -319,7 +319,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 
 	browser->entries = RB_ROOT;
 
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 
 	symbol__calc_percent(sym, evsel);
 
@@ -348,7 +348,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 		}
 		disasm_rb_tree__insert(browser, &pos->al);
 	}
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 
 	browser->curr_hot = rb_last(&browser->entries);
 }
@@ -474,10 +474,10 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	}
 
 	notes = symbol__annotation(dl->ops.target.sym);
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 
 	if (!symbol__hists(dl->ops.target.sym, evsel->evlist->core.nr_entries)) {
-		pthread_mutex_unlock(&notes->lock);
+		mutex_unlock(&notes->lock);
 		ui__warning("Not enough memory for annotating '%s' symbol!\n",
 			    dl->ops.target.sym->name);
 		return true;
@@ -486,7 +486,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	target_ms.maps = ms->maps;
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 	symbol__tui_annotate(&target_ms, evsel, hbt, browser->opts);
 	sym_title(ms->sym, ms->map, title, sizeof(title), browser->opts->percent_type);
 	ui_browser__show_title(&browser->b, title);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2c6a485c3de5..9d7dd6489a05 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -35,7 +35,6 @@
 #include "arch/common.h"
 #include "namespaces.h"
 #include <regex.h>
-#include <pthread.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -821,7 +820,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 	if (notes->src != NULL) {
 		memset(notes->src->histograms, 0,
 		       notes->src->nr_histograms * notes->src->sizeof_sym_hist);
@@ -829,7 +828,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 			memset(notes->src->cycles_hist, 0,
 				symbol__size(sym) * sizeof(struct cyc_hist));
 	}
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 }
 
 static int __symbol__account_cycles(struct cyc_hist *ch,
@@ -1086,7 +1085,7 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 	notes->hit_insn = 0;
 	notes->cover_insn = 0;
 
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 	for (offset = size - 1; offset >= 0; --offset) {
 		struct cyc_hist *ch;
 
@@ -1105,7 +1104,7 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 			notes->have_cycles = true;
 		}
 	}
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
@@ -1258,13 +1257,13 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool r
 
 void annotation__init(struct annotation *notes)
 {
-	pthread_mutex_init(&notes->lock, NULL);
+	mutex_init(&notes->lock);
 }
 
 void annotation__exit(struct annotation *notes)
 {
 	annotated_source__delete(notes->src);
-	pthread_mutex_destroy(&notes->lock);
+	mutex_destroy(&notes->lock);
 }
 
 static void annotation_line__add(struct annotation_line *al, struct list_head *head)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 986f2bbe4870..3cbd883e4d7a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -8,9 +8,9 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
-#include <pthread.h>
 #include <asm/bug.h>
 #include "symbol_conf.h"
+#include "mutex.h"
 #include "spark.h"
 
 struct hist_browser_timer;
@@ -273,7 +273,7 @@ struct annotated_source {
 };
 
 struct annotation {
-	pthread_mutex_t		lock;
+	struct mutex lock;
 	u64			max_coverage;
 	u64			start;
 	u64			hit_cycles;
-- 
2.37.2.609.g9ff673ca1a-goog

