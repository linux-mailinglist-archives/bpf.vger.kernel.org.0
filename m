Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289A459FE93
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 17:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbiHXPlS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 11:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiHXPlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 11:41:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7F54C93
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:40:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-336c3b72da5so292139877b3.6
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=OMQ501+sgDM7N3YDKsYf0P/PYHt6dhaxbTww0JcRvz8=;
        b=Df8+yGJaS9KBtdq7S84QTpN9c3hRBXX1dS99gz5VIVOk7bpDCoXOV0MwOxeHJTKERc
         iAdRh3GXOmICv8y4gf1D9/9oJgIKeAv5cMPm4sR6Ca0D6y9bKTxtw+urVRVInfKW6Al2
         HrwzW3F+/obJTX4n1gX2Wgrc+J/457e5qWoqijFs/I7ZiDzNXKhZWI0hKFBrX5e5q0cz
         MCIgalbH61OqEQt1/dmZT1TXskuAAEKtBtildgcHKxwazXLjNIOld0Kv6da39njqb8jB
         +VlQlYSEgYMAIVuohV0u+uONaVlYOEL9bZQS/SoKCW5fxzm9jckIF++O8LNnlcy7/307
         PYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=OMQ501+sgDM7N3YDKsYf0P/PYHt6dhaxbTww0JcRvz8=;
        b=SkROMggUTh07sECcw/d1h9j+h2BsINq5LRA+1s7YlYExcIkBZHT693NI4qxcUlmW7n
         mwz4MZWa68PzPWPL7DBc2qBwAZCRcKBqt/jGTELi/0nZnRULKSxjfv+qyQyYHBH3c+le
         kECGgcktGkPSP/R0eLvP2VXRr5Dy0f8G5SPqus+v2BU7an95rvfa4Qzd5csiH9+xHCP/
         6r+eN5XmSIaX1kF6I5thvK1rnObSEhClyVaX5ttuhHOwjSq6wunbD7i4JgYzctVCTcUc
         sOt6bnRJNgassvxhgUxEe3eebaCV4aMvIGMdEkPZYSQG7EDi8Q/IGpdJLNLoKTBoqo1W
         wemg==
X-Gm-Message-State: ACgBeo0OXsjPqgtGiYu8Urjc+5LIhsvIwIGqoLLUSAd1AN3BqgUeczRT
        6W7old9eMGcDkK9qs1uaPcnsTlZkZGEJ
X-Google-Smtp-Source: AA6agR4CVwuBRiEKrKdshlTIH2sL/L8VgPW5+RUhgxX77UsCiuJ5IF9PGcTXomgl1DeEZX27uib9KYx7cq/S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ab82:a348:500d:1fc4])
 (user=irogers job=sendgmr) by 2002:a25:da57:0:b0:695:818a:416d with SMTP id
 n84-20020a25da57000000b00695818a416dmr19205487ybf.519.1661355648925; Wed, 24
 Aug 2022 08:40:48 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:38:56 -0700
In-Reply-To: <20220824153901.488576-1-irogers@google.com>
Message-Id: <20220824153901.488576-14-irogers@google.com>
Mime-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v3 13/18] perf top: Update use of pthread mutex
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to the use of mutex wrappers that provide better error checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 18 +++++++++---------
 tools/perf/util/top.h    |  5 +++--
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b96bb9a23ac0..5af3347eedc1 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -893,10 +893,10 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		perf_mmap__consume(&md->core);
 
 		if (top->qe.rotate) {
-			pthread_mutex_lock(&top->qe.mutex);
+			mutex_lock(&top->qe.mutex);
 			top->qe.rotate = false;
-			pthread_cond_signal(&top->qe.cond);
-			pthread_mutex_unlock(&top->qe.mutex);
+			cond_signal(&top->qe.cond);
+			mutex_unlock(&top->qe.mutex);
 		}
 	}
 
@@ -1100,10 +1100,10 @@ static void *process_thread(void *arg)
 
 		out = rotate_queues(top);
 
-		pthread_mutex_lock(&top->qe.mutex);
+		mutex_lock(&top->qe.mutex);
 		top->qe.rotate = true;
-		pthread_cond_wait(&top->qe.cond, &top->qe.mutex);
-		pthread_mutex_unlock(&top->qe.mutex);
+		cond_wait(&top->qe.cond, &top->qe.mutex);
+		mutex_unlock(&top->qe.mutex);
 
 		if (ordered_events__flush(out, OE_FLUSH__TOP))
 			pr_err("failed to process events\n");
@@ -1217,8 +1217,8 @@ static void init_process_thread(struct perf_top *top)
 	ordered_events__set_copy_on_queue(&top->qe.data[0], true);
 	ordered_events__set_copy_on_queue(&top->qe.data[1], true);
 	top->qe.in = &top->qe.data[0];
-	pthread_mutex_init(&top->qe.mutex, NULL);
-	pthread_cond_init(&top->qe.cond, NULL);
+	mutex_init(&top->qe.mutex);
+	cond_init(&top->qe.cond);
 }
 
 static int __cmd_top(struct perf_top *top)
@@ -1349,7 +1349,7 @@ static int __cmd_top(struct perf_top *top)
 out_join:
 	pthread_join(thread, NULL);
 out_join_thread:
-	pthread_cond_signal(&top->qe.cond);
+	cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
 	return ret;
 }
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 1c2c0a838430..a8b0d79bd96c 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -5,6 +5,7 @@
 #include "tool.h"
 #include "evswitch.h"
 #include "annotate.h"
+#include "mutex.h"
 #include "ordered-events.h"
 #include "record.h"
 #include <linux/types.h>
@@ -53,8 +54,8 @@ struct perf_top {
 		struct ordered_events	*in;
 		struct ordered_events	 data[2];
 		bool			 rotate;
-		pthread_mutex_t		 mutex;
-		pthread_cond_t		 cond;
+		struct mutex mutex;
+		struct cond cond;
 	} qe;
 };
 
-- 
2.37.2.609.g9ff673ca1a-goog

