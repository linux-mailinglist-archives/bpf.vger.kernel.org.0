Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB8559EEAE
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiHWWKM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiHWWKF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:10:05 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E685D74B81
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:09:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33580e26058so260607257b3.4
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=1eSbxV8xsUDpc2lqCmn8NmCq3Cnp8BvOk6OZp7THu6w=;
        b=n2OTj1VLp6o80LdM8jnNvYoBYsCyZzoBStuGJULDdMtK0CWmBVdgrwHF1OaGt+Qwi5
         eRuRw8mi7HBI8UOxklnAv/41dyMbKaRy1Ta8W9ULGpyZVcLLTz3DwtDqd67GTyKGWGNc
         UtgVw7As6Jm1/J3mUL9fyRwlIIauby2UvWTWfwctcgAHWhKndmG6tcCi3ocg+hN5MBHD
         7PrzHzK4NfxF67H7EHTvglpl3oGvbpj+O2s9rEBxedMdYyfuoSgT7++ssJ87Cs60V+kJ
         1STe+qDjpbrUAdHdO2E34BmTFGbwg/ny4RW9A/kENMkvcl3uei22V7ZagcnPlJSMxpzh
         H0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=1eSbxV8xsUDpc2lqCmn8NmCq3Cnp8BvOk6OZp7THu6w=;
        b=d6CE9oZOgf/jUATNamODGYHoetbXBFTSEBUG+XfDu6VIGZ1UQK1DrwJP9DQMVlvYjj
         y8QTitzJl/Aj3GubfxYasntcUTUsZMb8Hc/tiFbh6+m00C60vYsCJTXLodDVKjhbfG2v
         sriy+OHSN0rHs2xlgD4bvvby9P51ddDvUPlOTO5O8glnhf27WEbtoyumgmkqdjLeGElz
         luziRzkCuT/st2jLIHxynrMVtT0n4wHMyibab8F5+GD6mGO3I5EYLRe/jeh0X4NQKx2M
         8ZXykg2ZsTSBXkW8ZK56F1X0gP3UcplMkxMMrZ0tB1BG7T6lDBvmt/2khnBqyBw7JRcZ
         n1mw==
X-Gm-Message-State: ACgBeo0FqvHvwSIiVRBZCTqeRKlgOxpvzXC0ci5lUVzSnhufBMftJF9r
        GvV1fZz0f0Ff0fvtCCL4gixrCWBw5OwA
X-Google-Smtp-Source: AA6agR5NQD+yIEJJ17qmVE5UxbRtTg+1QVTswl9OUhRV+oUsoSDQ/p9MEH1i7Y0xqkhVQ9084bu0eUFCQccE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a5b:24c:0:b0:68f:b0d7:79d9 with SMTP id
 g12-20020a5b024c000000b0068fb0d779d9mr24803235ybp.26.1661292593105; Tue, 23
 Aug 2022 15:09:53 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:09:08 -0700
In-Reply-To: <20220823220922.256001-1-irogers@google.com>
Message-Id: <20220823220922.256001-5-irogers@google.com>
Mime-Version: 1.0
References: <20220823220922.256001-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v2 04/18] perf hist: Update use of pthread mutex
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
 tools/perf/builtin-top.c | 8 ++++----
 tools/perf/util/hist.c   | 6 +++---
 tools/perf/util/hist.h   | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index fd8fd913c533..14e60f6f219c 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -220,7 +220,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 		 * This function is now called with he->hists->lock held.
 		 * Release it before going to sleep.
 		 */
-		pthread_mutex_unlock(&he->hists->lock);
+		mutex_unlock(&he->hists->lock);
 
 		if (err == -ERANGE && !he->ms.map->erange_warned)
 			ui__warn_map_erange(he->ms.map, sym, ip);
@@ -230,7 +230,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 			sleep(1);
 		}
 
-		pthread_mutex_lock(&he->hists->lock);
+		mutex_lock(&he->hists->lock);
 	}
 }
 
@@ -836,12 +836,12 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		else
 			iter.ops = &hist_iter_normal;
 
-		pthread_mutex_lock(&hists->lock);
+		mutex_lock(&hists->lock);
 
 		if (hist_entry_iter__add(&iter, &al, top->max_stack, top) < 0)
 			pr_err("Problem incrementing symbol period, skipping event\n");
 
-		pthread_mutex_unlock(&hists->lock);
+		mutex_unlock(&hists->lock);
 	}
 
 	addr_location__put(&al);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 1c085ab56534..bfce88e5eb0d 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1622,13 +1622,13 @@ struct rb_root_cached *hists__get_rotate_entries_in(struct hists *hists)
 {
 	struct rb_root_cached *root;
 
-	pthread_mutex_lock(&hists->lock);
+	mutex_lock(&hists->lock);
 
 	root = hists->entries_in;
 	if (++hists->entries_in > &hists->entries_in_array[1])
 		hists->entries_in = &hists->entries_in_array[0];
 
-	pthread_mutex_unlock(&hists->lock);
+	mutex_unlock(&hists->lock);
 
 	return root;
 }
@@ -2805,7 +2805,7 @@ int __hists__init(struct hists *hists, struct perf_hpp_list *hpp_list)
 	hists->entries_in = &hists->entries_in_array[0];
 	hists->entries_collapsed = RB_ROOT_CACHED;
 	hists->entries = RB_ROOT_CACHED;
-	pthread_mutex_init(&hists->lock, NULL);
+	mutex_init(&hists->lock, /*pshared=*/false);
 	hists->socket_filter = -1;
 	hists->hpp_list = hpp_list;
 	INIT_LIST_HEAD(&hists->hpp_formats);
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 7ed4648d2fc2..508428b2c1b2 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -4,10 +4,10 @@
 
 #include <linux/rbtree.h>
 #include <linux/types.h>
-#include <pthread.h>
 #include "evsel.h"
 #include "color.h"
 #include "events_stats.h"
+#include "mutex.h"
 
 struct hist_entry;
 struct hist_entry_ops;
@@ -98,7 +98,7 @@ struct hists {
 	const struct dso	*dso_filter;
 	const char		*uid_filter_str;
 	const char		*symbol_filter_str;
-	pthread_mutex_t		lock;
+	struct mutex		lock;
 	struct hists_stats	stats;
 	u64			event_stream;
 	u16			col_len[HISTC_NR_COLS];
-- 
2.37.2.609.g9ff673ca1a-goog

