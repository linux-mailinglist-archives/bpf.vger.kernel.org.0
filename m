Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7864F8EB5
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 08:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiDHD6a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 23:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiDHD62 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 23:58:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED5CE09BE
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 20:56:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k206-20020a2524d7000000b0063db1bacae1so5751173ybk.4
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 20:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+UkP3lUK7ObQkCyzmAzO/DKgbCUB8zFLRfkItQiish8=;
        b=BNzAVEsk+y8i0hvgdOFQ3JjFIanV1LS9VEuAZRKQGCjO0pQxkFs7HPpPGinn10Etid
         qbGu6TJpWjAY7tbIUlgPbg3YDegF4SulYZEbqhImfHCA0bSLbcxb9In1hHjf0qFjZCvP
         SgeQSstMpFwmFmWUpRXp5btO080Ea/O/UWkoShdBq+D0DcObzMq3R3+XSJG9JI0mPSWi
         QDz27KQ4K/OH+iABrm4y66+uPvJIn+c/q9mQiJUGWR3Zdmduu2Hac54igS6lH/ACe2+u
         E/7s11R33gc1MsZazSS7nFG5nDxsYxZMR2FUCps5bhbd4R+En2NY/xireFZ9DN82KY0w
         hPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+UkP3lUK7ObQkCyzmAzO/DKgbCUB8zFLRfkItQiish8=;
        b=1OkzZ6ewv7zVVamI8Zvf9+J7fz2lzTkkpmSafMF83JputPYRRx7a/r8i5U+V0vcirW
         VkVL98VAgEt/SFECHWpWJs5VuiR06SqPY05JCNJq/yR2NSYtMaWpNrM4JbrRu2XUP96x
         mDZNaadQ3hk/agSHuGJFhT+6Xj+qu24C+ayC7vQZ2il9Goj+FTcNv50r6vKrph31NGrk
         oM+yg+zOwMfQG2kSiVZkLKIxoHPaF6CwjZEGKF3Ufdo/JF6k0J5FFOEC0f6IfzxKruIB
         qbiW057McgsRD9tBuSmmWCKRUCKOn0vzCtIedORdKJw3SOX2juQGeD276zAV8o/30EfS
         ARig==
X-Gm-Message-State: AOAM5303UCAqgwVHiexqSbP5K1Rh+RA7SFBq8z0ObJN9a2myBKcl6+Uk
        Pgo8qn/H/J/1KvV4KhPwH4Q5tZ/moyvO
X-Google-Smtp-Source: ABdhPJzAGn8IgbwUAH+00Y1LBeQMqrkd4DN8Kp/utfITpsnis/mZA85HK2v7x30g/16DPHKVX+kOi1HjQZn4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:560:aa27:649e:a07d])
 (user=irogers job=sendgmr) by 2002:a25:af41:0:b0:633:905f:9e9b with SMTP id
 c1-20020a25af41000000b00633905f9e9bmr12894988ybj.77.1649390184327; Thu, 07
 Apr 2022 20:56:24 -0700 (PDT)
Date:   Thu,  7 Apr 2022 20:56:12 -0700
In-Reply-To: <20220408035616.1356953-1-irogers@google.com>
Message-Id: <20220408035616.1356953-2-irogers@google.com>
Mime-Version: 1.0
References: <20220408035616.1356953-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v3 1/5] perf cpumap: Don't decrement refcnt on args to merge
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

Having one argument to the cpumap merge decremented but not the other
leads to an inconsistent API. Don't decrement either argument.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c   | 11 +++--------
 tools/lib/perf/evlist.c   |  6 +++++-
 tools/perf/tests/cpumap.c |  1 +
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 384d5e076ee4..95c56e17241b 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -342,9 +342,7 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
 /*
  * Merge two cpumaps
  *
- * orig either gets freed and replaced with a new map, or reused
- * with no reference count change (similar to "realloc")
- * other has its reference count increased.
+ * May reuse either orig or other bumping reference count accordingly.
  */
 
 struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
@@ -356,11 +354,9 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 	struct perf_cpu_map *merged;
 
 	if (perf_cpu_map__is_subset(orig, other))
-		return orig;
-	if (perf_cpu_map__is_subset(other, orig)) {
-		perf_cpu_map__put(orig);
+		return perf_cpu_map__get(orig);
+	if (perf_cpu_map__is_subset(other, orig))
 		return perf_cpu_map__get(other);
-	}
 
 	tmp_len = orig->nr + other->nr;
 	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
@@ -387,6 +383,5 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 
 	merged = cpu_map__trim_new(k, tmp_cpus);
 	free(tmp_cpus);
-	perf_cpu_map__put(orig);
 	return merged;
 }
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 1b15ba13c477..b783249a038b 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -35,6 +35,8 @@ void perf_evlist__init(struct perf_evlist *evlist)
 static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 					  struct perf_evsel *evsel)
 {
+	struct perf_cpu_map *tmp;
+
 	/*
 	 * We already have cpus for evsel (via PMU sysfs) so
 	 * keep it, if there's no target cpu list defined.
@@ -52,7 +54,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 
 	perf_thread_map__put(evsel->threads);
 	evsel->threads = perf_thread_map__get(evlist->threads);
-	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
+	tmp = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
+	perf_cpu_map__put(evlist->all_cpus);
+	evlist->all_cpus = tmp;
 }
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index f94929ebb54b..cf205ed6b158 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -133,6 +133,7 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
 	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
 	cpu_map__snprint(c, buf, sizeof(buf));
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
+	perf_cpu_map__put(a);
 	perf_cpu_map__put(b);
 	perf_cpu_map__put(c);
 	return 0;
-- 
2.35.1.1178.g4f1659d476-goog

