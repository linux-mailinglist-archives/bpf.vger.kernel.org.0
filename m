Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EBD4E8E16
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 08:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiC1G0Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 02:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbiC1G0U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 02:26:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF15951E7A
        for <bpf@vger.kernel.org>; Sun, 27 Mar 2022 23:24:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h16-20020a056902009000b00628a70584b2so10133962ybs.6
        for <bpf@vger.kernel.org>; Sun, 27 Mar 2022 23:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YAhIdIX1NbY8GJ/Fxc7tPQp5MnsWrJ6b1ZKA2cSf7J0=;
        b=BmBfuq5dDJ8FyY++eKZzoNfnofz30yeVLbgg6C06RDaHI+2/on7h2TcF3d5wM4fa4v
         4bk4KMagZlk4nj19qtiaEbo1M4KSqHCCoSG28PmBhOeZ55PNWY+H93zGymXKK5231X2m
         KZtd7Vd97HDsSx/TyGhWx0qCCkgggvpS4Beh5fSGE8tfMMFU8D1fm5/iLShTGjpys2a+
         Ro5/rm+LPdNcLq+0L3HrEDbV5NW1nCqM4h+PDD0jVJ0KBaAHhCIuNar/9RgYSjRjtnLL
         aT1mG0BBsu3ZXQTCANlrv09w07cbBxpDrXfARHxCKPef7Jb7jNIUufL44QKXW6flpj3O
         tNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YAhIdIX1NbY8GJ/Fxc7tPQp5MnsWrJ6b1ZKA2cSf7J0=;
        b=00t4CN7p4PYmGwO/EbsCdwRUh/gc8B+P5xO1bjLUlP64n+oYIDv1t7G+fu2pwjXch7
         T4ZfB8S5tSpgOtIUi5JHtvkjD4FKCZxffux3h9IEhn51QaZ1ikI6ZYFCCYgbEkZSq5Ga
         2u6wjni0ohvNJpNkZabj0W48P3W1zp/B/rAMNt4CmMDHtmcSD0hM5BbcwTpZidR3djSw
         xsBK4mtpE7Iq2pzC57ccdkp7rxMrknYyNtFIB0bS6y4Yy9kBl3FiYf/WTko/obKLNPt2
         Dk8yeHZc4w4/Vxk+ZaRholvekNBob/eYw8VYWZ4pADGEsktTyl47xroe4/C6CeYfR6Cs
         nalA==
X-Gm-Message-State: AOAM531pTt5TEip67slWKN0oJgG1Qh7a+xzQgisC+fdF1Z6S+NkWXeQt
        rEzEUG3tNl/DQvyZtA02rA//4jK+gKh6
X-Google-Smtp-Source: ABdhPJzgJ3tnHPRL/ZoEIaIEfGlgiRAfkH5m8p1TAIooj8UqZqfQygDqtd6JOglW1lVfIhZfwaS+hnJN01ZZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef08:ed1b:261f:77fa])
 (user=irogers job=sendgmr) by 2002:a05:6902:124e:b0:634:619e:4114 with SMTP
 id t14-20020a056902124e00b00634619e4114mr21938385ybu.181.1648448667764; Sun,
 27 Mar 2022 23:24:27 -0700 (PDT)
Date:   Sun, 27 Mar 2022 23:24:12 -0700
In-Reply-To: <20220328062414.1893550-1-irogers@google.com>
Message-Id: <20220328062414.1893550-4-irogers@google.com>
Mime-Version: 1.0
References: <20220328062414.1893550-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH 3/5] perf cpumap: Add intersect function.
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

The merge function gives the union of two cpu maps. Add an intersect
function which will be used in the next change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 38 ++++++++++++++++++++++++++++
 tools/lib/perf/include/perf/cpumap.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 953bc50b0e41..56b4d213039f 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -393,3 +393,41 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 	perf_cpu_map__put(orig);
 	return merged;
 }
+
+struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
+					     struct perf_cpu_map *other)
+{
+	struct perf_cpu *tmp_cpus;
+	int tmp_len;
+	int i, j, k;
+	struct perf_cpu_map *merged = NULL;
+
+	if (perf_cpu_map__is_subset(other, orig))
+		return orig;
+	if (perf_cpu_map__is_subset(orig, other)) {
+		perf_cpu_map__put(orig);
+		return perf_cpu_map__get(other);
+	}
+
+	tmp_len = max(orig->nr, other->nr);
+	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
+	if (!tmp_cpus)
+		return NULL;
+
+	i = j = k = 0;
+	while (i < orig->nr && j < other->nr) {
+		if (orig->map[i].cpu < other->map[j].cpu)
+			i++;
+		else if (orig->map[i].cpu > other->map[j].cpu)
+			j++;
+		else {
+			j++;
+			tmp_cpus[k++] = orig->map[i++];
+		}
+	}
+	if (k)
+		merged = cpu_map__trim_new(k, tmp_cpus);
+	free(tmp_cpus);
+	perf_cpu_map__put(orig);
+	return merged;
+}
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 4a2edbdb5e2b..a2a7216c0b78 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -19,6 +19,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 						     struct perf_cpu_map *other);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
+							 struct perf_cpu_map *other);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
-- 
2.35.1.1021.g381101b075-goog

