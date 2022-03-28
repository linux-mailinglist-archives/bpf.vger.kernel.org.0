Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642784EA3A5
	for <lists+bpf@lfdr.de>; Tue, 29 Mar 2022 01:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiC1X26 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 19:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiC1X2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 19:28:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD5037026
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 16:27:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h83-20020a25d056000000b0063380d246ceso12043372ybg.3
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 16:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fd8zO3I7cR3jn/Jx1EW0YLNB0c8F/thF/fGaitvvb58=;
        b=jhWfrBgC3Vidx16ZXPyaLDraZh3tQuBYXM724VRgco4ncvfxUi7yyZL7BAMENECuRr
         c8ZOwIgO5+uZy4p89VQXhbbCrSL8Cd0fRgY7Qgttlf7fm0fUgJe7cfxJoGx0+cGnFh7N
         KEB+IRtL1LlXsuam7rw7lu71qt2dGcSOIUCAjAPnee7ZkCJxJfye0EhEXY60jtniThLR
         W/hBrZyqmOKkZUOvGE6itlT47MOqBU1C+DuAI8pS9d/x1QpFDWyaip6AFrUXzzx+rM4Q
         qHMX7xcid4VCbEkpxBxj7NPPx8jYtHKTG09Hyjy3FN0YubprJa9gxwYNJH5xntFBiNm3
         06uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fd8zO3I7cR3jn/Jx1EW0YLNB0c8F/thF/fGaitvvb58=;
        b=y0jZHTXhNL5PJ2qDbf3Pm1bEOzGb/Lkyw5S4RSZFC4+Mi5iatAdJrrmCrxqopvFXRt
         S1VZ/RYJWXlIguUXo3ojxva5TJIW9o+QCMgx68OJs9LS1Z5IYFQ+APN4wmoiSpPsrL7K
         /aaONMLKCx0W9TUEjbFhofrZ727u0fJ+1f1kAMfECz6ZIQBq/dmkYb0POURgdr4e0K7B
         C8TAwXQ2CyIThV9zS6h0k/Fv4MGGZNRixUruY7tMBZnq1fNzwfptARp821bJvOHmu2Pl
         HkrqccaIoxzC8XsYAGnh19AEd4LYvGcrVJUQB+b43RN46tcxiIqc0ahcRBZXYrg5NWEq
         I8vw==
X-Gm-Message-State: AOAM53071tBm+jw5SCuspH9fFfB59vlcKe3/2XWHAJeoOjbJyqNUyS6a
        SqZrURVGamTLxqRbMwed72BtrTTy8+7x
X-Google-Smtp-Source: ABdhPJx9mX24vBUXKujfAxpZd4EOEF4CDe3zBNIYlkFzjKX9KG29aQUbCRbBy+3NfgADLi4J9ufU7jNV4G8B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9d6a:527d:cf46:71e2])
 (user=irogers job=sendgmr) by 2002:a0d:eb4c:0:b0:2e5:bd5c:12cf with SMTP id
 u73-20020a0deb4c000000b002e5bd5c12cfmr28160203ywe.116.1648510019835; Mon, 28
 Mar 2022 16:26:59 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:26:45 -0700
In-Reply-To: <20220328232648.2127340-1-irogers@google.com>
Message-Id: <20220328232648.2127340-4-irogers@google.com>
Mime-Version: 1.0
References: <20220328232648.2127340-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 3/6] perf cpumap: Add is_subset function
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

Returns true if the second argument is a subset of the first.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c                  | 20 ++++++++++++++++++++
 tools/lib/perf/include/internal/cpumap.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ee66760f1e63..23701024e0c0 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -319,6 +319,26 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
 	return map->nr > 0 ? map->map[map->nr - 1] : result;
 }
 
+/** Is 'b' a subset of 'a'. */
+bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b)
+{
+	if (a == b || !b)
+		return true;
+	if (!a || b->nr > a->nr)
+		return false;
+
+	for (int i = 0, j = 0; i < a->nr; i++) {
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
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 1973a18c096b..35dd29642296 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -25,5 +25,6 @@ struct perf_cpu_map {
 #endif
 
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu);
+bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b);
 
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
-- 
2.35.1.1021.g381101b075-goog

