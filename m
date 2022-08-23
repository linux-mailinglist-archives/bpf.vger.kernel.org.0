Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8259EEC1
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiHWWLH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiHWWKc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:10:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB7175FD4
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:10:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33931a5c133so175242227b3.17
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=dmh/92MRm7j95zVGcUZ890xL7HIjX5BjkDj+86ZwSV4=;
        b=BqrCSk/jfE2Eg/kfl3hCAbhvBnIz/GqHBYIYJLFqyhBi497Ll9GGI+raBBPi7M+8Ib
         99+xF9k5162F1hpJBqyAcw/RX+5CtTsRAEwHHOB6NUTG3zVhdWd5fPjWDSjJW3Hm0Fvp
         wQbdiz1uiBz2ncduZi2qpaSl3gV75mc+fyitmLVe680j7a8WEyipRhqLJSaSXlWZyMcy
         W6ejqPOQwH5fWVFTIaiPfZivm1L4HDYTazwFG937PO1YN9evW4HA5ZAIZube3cBEmhgR
         yLhvdJHy4Rh+rZbIu/zSzGtXs2aDe4hwA/RJkV583cWdSHgQ06NuAu6//viZN3vlrUV2
         gDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=dmh/92MRm7j95zVGcUZ890xL7HIjX5BjkDj+86ZwSV4=;
        b=IKvdIHJ9vOFZeFeA5BR/GJBmg4fNylupAo8ji5FBjgKIL/aI8zqG0DjOgrruBU690s
         +IrzcJ2/sJwU8yFv57OIlV1D7YaeQw50T0sQCyLpck/0ttBhpjM3XBSdYTf96yflqbYS
         5b+zgK7ZcdThKiYMqsKluUvBzR2GPlW+uuzXSNZNqyS3shRjkew+eMu9pFmRdJEhvus1
         bqhbDqM6yR0Qt3deYqJQ8w633VrrWev8oXrFMOv0QxVEhaxS9OQCCmXxEoE4CeclgY5K
         fmPleuLS4mlBytMn4X0Frl2Y+NN/RZ9iowKMCd101NesXGpRFbGMjIUry9l/oSyjyZu1
         rZAw==
X-Gm-Message-State: ACgBeo3R9XM0nWYQ3o6IbXm3X1ygGDeBoS/t0ypcoWdY6f6gFY6n7Tgy
        I10gT8O7DjSA+gNVtMAzgpAOH8yCYyC9
X-Google-Smtp-Source: AA6agR6BxJxr/i2FE3SRx08sPUB3srSjsfLBMouB5rTu5H1ZsvNLTfL/kFPNdM7yI+a6YV4HNJOiWFHE6X2R
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a81:90f:0:b0:339:7fcd:6bac with SMTP id
 15-20020a81090f000000b003397fcd6bacmr18285803ywj.239.1661292611451; Tue, 23
 Aug 2022 15:10:11 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:09:11 -0700
In-Reply-To: <20220823220922.256001-1-irogers@google.com>
Message-Id: <20220823220922.256001-8-irogers@google.com>
Mime-Version: 1.0
References: <20220823220922.256001-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v2 07/18] perf record: Update use of pthread mutex
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
index 4713f0f3a6cf..02eb85677e99 100644
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
+		mutex_init(&synth_lock, /*pshared=*/false);
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
2.37.2.609.g9ff673ca1a-goog

