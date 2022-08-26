Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4077A5A2C9A
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbiHZQpQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbiHZQos (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:44:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C7CDFB79
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:44:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33d9f6f4656so33378857b3.21
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=KW1wjZhQOylJAM8dFCUuUgsNn9wynC6cGB5CBRkTkjU=;
        b=DLT7CNCPFxgWp4tw+x/BQspqZDpc1UMezv684sA8Gl8TsHyYXrhbYfV0Qr+PfXH6sE
         WyZe8OnzJaU/1Ef8NA1auGJ2hDrBVFrWmQe6C1c75RmFWI5JgK2QkInaC0PFH357sUBK
         iccm1taYoFpVQWHE0/CEbyO9NCebkdSo/fQeYsuY6lmfBq5fUmtl3rMLeYJ8QGma+I+K
         RnmZ6nmyKMDdXUQmHGCIdUIKetMz8UzgX1QFuI8iXW62hCKyDldFPgyV+eyEhCw0AA+N
         ocvsSYMFTlAfmg7rbbu/rnHYvg+mfLX25WZwKcDLZgrttSfeE/17xTn3w2Z+r4BptWl2
         C1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=KW1wjZhQOylJAM8dFCUuUgsNn9wynC6cGB5CBRkTkjU=;
        b=Cp2lvELXJENXIc1ui5Q4fp1JdxxJcEEWNHPO6Vx3qmMHTmUmESTu++6yJ2wRh3V7q2
         dqrhDgWvWc4M1Si0txx01Pe+bEe7Hr/XI6QKZWX8gfobyz5BwSKh0bFHha153pabQHxt
         UyXzYYC0eFIdPEdY4EiHyoEdVCeOgfr0s0TqltslN7mXs3OleSrP2QQGb19HtDDW4Sau
         FJ1BRvOLzuAA6KBc+ug5xhREYS6Sa5EQTBHB3ENSzx8EZd6PoplnHGsZ7PnZdBxRM18e
         fDE1v5DXqo6RokehXBWr+Us2hMlODp3udFAiaVhqHlJ8uIiSLiZzyszeswxn4R61pz3R
         iQ3A==
X-Gm-Message-State: ACgBeo0AqGFlV1Ey98Bfq2g4rrk0x9wFfTIoqvEABGQTlj+k+Ksben7Q
        yJMm3IgQqgulNB4M5rgKw4rOrTyOgK+y
X-Google-Smtp-Source: AA6agR5ECIO+GHRI3XC9wpQWiTgzeGBhIlpvn15OMBLt2Eu4HKggVRe/TElALFWz/W+OT2LnRb3f7F9dYoKl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a05:6902:110d:b0:670:b10b:d16e with SMTP
 id o13-20020a056902110d00b00670b10bd16emr494541ybu.259.1661532248866; Fri, 26
 Aug 2022 09:44:08 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:31 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-8-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 07/18] perf record: Update use of pthread mutex
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

Switch to the use of mutex wrappers that provide better error checking
for synth_lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4713f0f3a6cf..a7b7a317d81b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -21,6 +21,7 @@
 #include "util/evsel.h"
 #include "util/debug.h"
 #include "util/mmap.h"
+#include "util/mutex.h"
 #include "util/target.h"
 #include "util/session.h"
 #include "util/tool.h"
@@ -608,17 +609,18 @@ static int process_synthesized_event(struct perf_tool *tool,
 	return record__write(rec, NULL, event, event->header.size);
 }
 
+static struct mutex synth_lock;
+
 static int process_locked_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
 				     struct machine *machine __maybe_unused)
 {
-	static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
 	int ret;
 
-	pthread_mutex_lock(&synth_lock);
+	mutex_lock(&synth_lock);
 	ret = process_synthesized_event(tool, event, sample, machine);
-	pthread_mutex_unlock(&synth_lock);
+	mutex_unlock(&synth_lock);
 	return ret;
 }
 
@@ -1917,6 +1919,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	}
 
 	if (rec->opts.nr_threads_synthesize > 1) {
+		mutex_init(&synth_lock);
 		perf_set_multithreaded();
 		f = process_locked_synthesized_event;
 	}
@@ -1930,8 +1933,10 @@ static int record__synthesize(struct record *rec, bool tail)
 						    rec->opts.nr_threads_synthesize);
 	}
 
-	if (rec->opts.nr_threads_synthesize > 1)
+	if (rec->opts.nr_threads_synthesize > 1) {
 		perf_set_singlethreaded();
+		mutex_destroy(&synth_lock);
+	}
 
 out:
 	return err;
-- 
2.37.2.672.g94769d06f0-goog

