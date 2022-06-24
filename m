Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA955A4AF
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 01:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiFXXNV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 19:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiFXXNT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 19:13:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B7574E49;
        Fri, 24 Jun 2022 16:13:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p14so3763206pfh.6;
        Fri, 24 Jun 2022 16:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46ucjs6wKUKgiiGqtq8K2ec49qlzYcpw1UVL6CAVoBc=;
        b=HMW80cadZRW7ASnl1wG8H8XJt6AASQA5qr4+JUHj1SA3yYvuC4B/pKrx+hBypRpc49
         pvUEqX4bFuDuQGUjr3ngm1wiAoON+/Hc5wINSxtxDgrZ9bH33hZ5/VpN65RGBhoGaDT+
         ybMJz7Tak5mpc4F4JC+kNcoULKeEhsPdB73q6JUGRpAQzHfsCsDx5kKa2tCazsuANxJj
         wWHSzFsGSPY1sdSnxBCgk29r1ScltJmWcpBMD08JPQxV9gmNJ8xQbyJv9G+Z4zqXAVJF
         HJJdVGNBq6M880Mx3fV8zFr4BEEdlw6VLxrY20j+GXkaV08FK3Lmwr5irDbmJm2MsD9L
         jwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=46ucjs6wKUKgiiGqtq8K2ec49qlzYcpw1UVL6CAVoBc=;
        b=eaMt3FRuLv/P+q+QsrLFVulqam7F9bDvy0c1RmoX0bUBcBVrFhPYwLWY4oNfxuUZCx
         Nic5lpQ5Bb2W18xpAzwAS4Ry8nKNWjeaHqpZj+6Ew7nCulrirlpmPpRxpo5Qx4dhjcun
         QVjRzzuPW6VTQZOmYl3WbUtOlyRHxouvs+z2/0Xhe4tVFTzpORIJqiSS/DyXyTKElCMw
         VjBPMeKAI/ZPiWN0msvcuNrj2POtEy53Rfg2aSwJW4jfA4T1pBx8LLYYhWrM1pk71VFG
         ccxq2osOgDzs6MO3T2FpYBj1kjjqhG+DVSSPBpKNT+fTEEPXOLnJ8Q5GsM4CDQkLd+Mw
         F7Tg==
X-Gm-Message-State: AJIora/gQi00b3yIRIapiR3Rj82t6bt+PLXNRamtpPTrBkt1H7G1EdCR
        /Fw/lOd5dCcJS3P+Ja39fPQ=
X-Google-Smtp-Source: AGRyM1vot/3/cqBz4ISehZyl8CPhUFQ3zIiY/9WXXYPmdF/F8kEOJFJtuJIVSrsNQOV1Nl/Uj+s1Iw==
X-Received: by 2002:a05:6a00:2484:b0:51c:4ee0:b899 with SMTP id c4-20020a056a00248400b0051c4ee0b899mr1358635pfv.46.1656112397831;
        Fri, 24 Jun 2022 16:13:17 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:480:eeb0:3156:8fd:28f6])
        by smtp.gmail.com with ESMTPSA id z19-20020aa78893000000b0050dc76281e0sm2242439pfe.186.2022.06.24.16.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:13:17 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 2/6] perf offcpu: Accept allowed sample types only
Date:   Fri, 24 Jun 2022 16:13:09 -0700
Message-Id: <20220624231313.367909-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220624231313.367909-1-namhyung@kernel.org>
References: <20220624231313.367909-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As offcpu-time event is synthesized at the end, it could not get the
all the sample info.  Define OFFCPU_SAMPLE_TYPES for allowed ones and
mask out others in evsel__config() to prevent parse errors.

Because perf sample parsing assumes a specific ordering with the
sample types, setting unsupported one would make it fail to read
data like perf record -d/--data.

Fixes: edc41a1099c2 ("perf record: Enable off-cpu analysis with BPF")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_off_cpu.c | 7 ++++++-
 tools/perf/util/evsel.c       | 9 +++++++++
 tools/perf/util/off_cpu.h     | 9 +++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index b73e84a02264..f289b7713598 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -265,6 +265,12 @@ int off_cpu_write(struct perf_session *session)
 
 	sample_type = evsel->core.attr.sample_type;
 
+	if (sample_type & ~OFFCPU_SAMPLE_TYPES) {
+		pr_err("not supported sample type: %llx\n",
+		       (unsigned long long)sample_type);
+		return -1;
+	}
+
 	if (sample_type & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER)) {
 		if (evsel->core.id)
 			sid = evsel->core.id[0];
@@ -319,7 +325,6 @@ int off_cpu_write(struct perf_session *session)
 		}
 		if (sample_type & PERF_SAMPLE_CGROUP)
 			data.array[n++] = key.cgroup_id;
-		/* TODO: handle more sample types */
 
 		size = n * sizeof(u64);
 		data.hdr.size = size;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ce499c5da8d7..094b0a9c0bc0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -48,6 +48,7 @@
 #include "util.h"
 #include "hashmap.h"
 #include "pmu-hybrid.h"
+#include "off_cpu.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include <internal/xyarray.h>
@@ -1102,6 +1103,11 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 	}
 }
 
+static bool evsel__is_offcpu_event(struct evsel *evsel)
+{
+	return evsel__is_bpf_output(evsel) && !strcmp(evsel->name, OFFCPU_EVENT);
+}
+
 /*
  * The enable_on_exec/disabled value strategy:
  *
@@ -1366,6 +1372,9 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	 */
 	if (evsel__is_dummy_event(evsel))
 		evsel__reset_sample_bit(evsel, BRANCH_STACK);
+
+	if (evsel__is_offcpu_event(evsel))
+		evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;
 }
 
 int evsel__set_filter(struct evsel *evsel, const char *filter)
diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 548008f74d42..2dd67c60f211 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -1,6 +1,8 @@
 #ifndef PERF_UTIL_OFF_CPU_H
 #define PERF_UTIL_OFF_CPU_H
 
+#include <linux/perf_event.h>
+
 struct evlist;
 struct target;
 struct perf_session;
@@ -8,6 +10,13 @@ struct record_opts;
 
 #define OFFCPU_EVENT  "offcpu-time"
 
+#define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
+			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
+			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
+			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
+			      PERF_SAMPLE_CGROUP)
+
+
 #ifdef HAVE_BPF_SKEL
 int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		    struct record_opts *opts);
-- 
2.37.0.rc0.161.g10f37bed90-goog

