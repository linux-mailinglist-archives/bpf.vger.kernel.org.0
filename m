Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD95F4E8E17
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 08:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiC1G0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 02:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbiC1G0T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 02:26:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F24ECCD
        for <bpf@vger.kernel.org>; Sun, 27 Mar 2022 23:24:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc1ce31261so110301677b3.6
        for <bpf@vger.kernel.org>; Sun, 27 Mar 2022 23:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YZdCpDo2MwsKjb0WbdxKDFQz4ii0U4OJCI/h5Uxfyc8=;
        b=hVa/7ihqPsZym2uTsY9dt+yok+r2vNttS+kECPUz8hlfd3jStwkXswPdBeCrSKu+8r
         QeU5/PriYcQc4cgKtYeuqB+cy1x97REfIUo0tC2tFZO4gXeIS/xcS05fs5cuywbioJnn
         dptX2c3gxaqTVY27IxEJg86seWOY2oqTzL9/HTiP5pi8uDw/SFsbF0HjegJ7qMvBkPpR
         Tb3CYk2hqKAcsnVo+uJYoHlxxOo6v1WKZhiKvPpnMIB8kTTUbg3sdPpLNwbIU7oZ6r3k
         wnckyfAkBl3jtmyGjoDKqwQt5IoJGvKr37Zhaq02trVr8xMkQL0hE58dHckjoxQCLiWN
         W71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YZdCpDo2MwsKjb0WbdxKDFQz4ii0U4OJCI/h5Uxfyc8=;
        b=209fQBq/NCk66pjSFjnRlAuyFrOQqV+OrkIXRj+nQiYDRc92xyTKf6TzAMo3TmXTYq
         ifKwcC7j/eq1rdBN85eWhdMn41pW/dCwb85RlgqLLqWRtu036ywjJG5Cy1U7GITmTPEt
         XoBAO6sbUtxwwFesBd+La+EJXhANZJWNCwBFv8AsBSi0HjiW9rv8D0R7THfwN/PnR11n
         huLzhYXhgyJmbTdUKeHpDvzhp7X0hU7C62puCP/0/TWlYQRqRbidyNumjyExKTwg29ey
         o/AOOc+pS4zIT6LDRkSu7qm6szAXbzDCpUnBh4Seh+nNfEGBiZ8nNZUSCY26nmZSm9Cp
         kKPA==
X-Gm-Message-State: AOAM532McfZpuMFyo42NW4+cAJNyDgW81gg/Ld/vaNlV4TUQnlMXGLj1
        xwj+gjWnc+43xhy9RFVS2pf1crA1HdpV
X-Google-Smtp-Source: ABdhPJzQSAN+iwF+0ELfjnRELyBsh17NWxruCk/wZoBkE5XSh7FJRsS5lOFGmt2jB/qkes1g2fsc2qElJ/xK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef08:ed1b:261f:77fa])
 (user=irogers job=sendgmr) by 2002:a05:6902:150b:b0:639:f81:8179 with SMTP id
 q11-20020a056902150b00b006390f818179mr17151751ybu.31.1648448665698; Sun, 27
 Mar 2022 23:24:25 -0700 (PDT)
Date:   Sun, 27 Mar 2022 23:24:11 -0700
In-Reply-To: <20220328062414.1893550-1-irogers@google.com>
Message-Id: <20220328062414.1893550-3-irogers@google.com>
Mime-Version: 1.0
References: <20220328062414.1893550-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH 2/5] perf cpumap: More cpu map reuse by merge.
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

perf_cpu_map__merge will reuse one of its arguments if they are equal or
the other argument is NULL. The arguments could be reused if it is known
one set of values is a subset of the other. For example, a map of 0-1
and a map of just 0 when merged yields the map of 0-1. Currently a new
map is created rather than adding a reference count to the original 0-1
map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ee66760f1e63..953bc50b0e41 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -319,6 +319,29 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
 	return map->nr > 0 ? map->map[map->nr - 1] : result;
 }
 
+/** Is 'b' a subset of 'a'. */
+static bool perf_cpu_map__is_subset(const struct perf_cpu_map *a,
+				    const struct perf_cpu_map *b)
+{
+	int i, j;
+
+	if (a == b || !b)
+		return true;
+	if (!a || b->nr > a->nr)
+		return false;
+	j = 0;
+	for (i = 0; i < a->nr; i++) {
+		if (a->map[i].cpu > b->map[j].cpu)
+			return false;
+		if (a->map[i].cpu == b->map[j].cpu) {
+			j++;
+			if (j == b->nr)
+				return true;
+		}
+	}
+	return false;
+}
+
 /*
  * Merge two cpumaps
  *
@@ -335,17 +358,12 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 	int i, j, k;
 	struct perf_cpu_map *merged;
 
-	if (!orig && !other)
-		return NULL;
-	if (!orig) {
-		perf_cpu_map__get(other);
-		return other;
-	}
-	if (!other)
-		return orig;
-	if (orig->nr == other->nr &&
-	    !memcmp(orig->map, other->map, orig->nr * sizeof(struct perf_cpu)))
+	if (perf_cpu_map__is_subset(orig, other))
 		return orig;
+	if (perf_cpu_map__is_subset(other, orig)) {
+		perf_cpu_map__put(orig);
+		return perf_cpu_map__get(other);
+	}
 
 	tmp_len = orig->nr + other->nr;
 	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
-- 
2.35.1.1021.g381101b075-goog

