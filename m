Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EA0695814
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 06:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjBNFFC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 00:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjBNFFA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 00:05:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5E14C1E;
        Mon, 13 Feb 2023 21:04:59 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so14377445pjw.2;
        Mon, 13 Feb 2023 21:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7j9lqx8i5Bq810EG7algMpH58kHO1+kyov3tvBn4mX8=;
        b=YRkVRq2iLhsFbqwPZrOW6M3nk+snc9Zmi+SXn3jHJAKf9pF6de/A/N9e+setFDrv6T
         dETMxTS2nLbyMQ9OTD0BzWbS3pyL0NlVneOze0zn3s/o+FQ0p8K6BGfBcUgFNFqg9+J5
         nB3l+utnqbz7UNfBy+SPN2d7ah590KQmrdkJVGGyPU2CNGRVuEeKlQXekHRqmjykHcSY
         uV9B+SssvQxGMSTaf9rp2pQp9W9eUIDPrr7JSZvd/Me5YVZmicke2YappjbB7I1gak0U
         VyS6wuV1fYqRGhoxPewhjX34gRuRDncSzL3pws04y8CVKYDHYzDh+jP6QX7uvS4MjPoS
         +6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7j9lqx8i5Bq810EG7algMpH58kHO1+kyov3tvBn4mX8=;
        b=12vhRvO+aAUQkkuCLN3whAmJuaUTyDY0aW2G5ajaw9hyfUa3rd1ZjUwRUhMABGaqOx
         VKhcYbHLxBELFdTqYWH4dUnAmksi3VRRXs/hNTXyRv3zAorQHd2xl9j4a4Vj34k4akD2
         WEJL/7UjLIGSx5QJ3V0iDSI3bnYZ0lfWJzB0rQ88t51+t1RpYQy7aoYsvgUSUFuI8jXc
         Zrd+Uz4N9VfsPmpuHKMBDwaqLjg8rYh6KO1x2Bz/6ZOlsE1eFgsydb5miEQ6CC+iOXa+
         wO1o7W1mOwf1X5npML8BaEdrHRCFrUOERCpECH164mFl/g2MR7iz0F9yvr19M49vcFNR
         B6RQ==
X-Gm-Message-State: AO0yUKUAk70A4RBlSZ3Qk6uyUcNt9EKR690GUe81cwjWvgMuR2AK2GsM
        im2GJsPDxqG15HYBrcAcB8ncxhLG8y4=
X-Google-Smtp-Source: AK7set8o6BQQeFGTKi8O2h8TIq7zw88Yx/7HyT3GvpWSWIF7LsYNmnPyttQAZybb90o2MDKRkshvrg==
X-Received: by 2002:a17:902:d2c8:b0:19a:a43c:41aa with SMTP id n8-20020a170902d2c800b0019aa43c41aamr1353958plc.66.1676351099040;
        Mon, 13 Feb 2023 21:04:59 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:de3c:c4c2:3f15:764d])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902761200b001932a9e4f2csm9045593pll.255.2023.02.13.21.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:04:58 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 2/7] perf bpf filter: Implement event sample filtering
Date:   Mon, 13 Feb 2023 21:04:47 -0800
Message-Id: <20230214050452.26390-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
In-Reply-To: <20230214050452.26390-1-namhyung@kernel.org>
References: <20230214050452.26390-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF program will be attached to a perf_event and be triggered when
it overflows.  It'd iterate the filters map and compare the sample
value according to the expression.  If any of them fails, the sample
would be dropped.

Also it needs to have the corresponding sample data for the expression
so it compares data->sample_flags with the given value.  To access the
sample data, it uses the bpf_cast_to_kern_ctx() kfunc which was added
in v6.2 kernel.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.perf                     |   2 +-
 tools/perf/util/bpf-filter.c                 |  71 +++++++++++
 tools/perf/util/bpf-filter.h                 |  24 ++--
 tools/perf/util/bpf_skel/sample-filter.h     |  24 ++++
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 118 +++++++++++++++++++
 tools/perf/util/evsel.h                      |   7 +-
 6 files changed, 234 insertions(+), 12 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/sample-filter.h
 create mode 100644 tools/perf/util/bpf_skel/sample_filter.bpf.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bac9272682b7..474af4adea95 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1047,7 +1047,7 @@ SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
 SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
 SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
-SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
+SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
 
 $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 6b1148fcfb0e..f47420cf81c9 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -1,10 +1,81 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
 
+#include <bpf/bpf.h>
+#include <linux/err.h>
+#include <internal/xyarray.h>
+
+#include "util/debug.h"
+#include "util/evsel.h"
+
 #include "util/bpf-filter.h"
 #include "util/bpf-filter-flex.h"
 #include "util/bpf-filter-bison.h"
 
+#include "bpf_skel/sample-filter.h"
+#include "bpf_skel/sample_filter.skel.h"
+
+#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
+
+int perf_bpf_filter__prepare(struct evsel *evsel)
+{
+	int i, x, y, fd;
+	struct sample_filter_bpf *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	struct perf_bpf_filter_expr *expr;
+
+	skel = sample_filter_bpf__open();
+	if (!skel) {
+		pr_err("Failed to open perf sample-filter BPF skeleton\n");
+		return -1;
+	}
+
+	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
+
+	if (sample_filter_bpf__load(skel) < 0) {
+		pr_err("Failed to load perf sample-filter BPF skeleton\n");
+		return -1;
+	}
+
+	i = 0;
+	fd = bpf_map__fd(skel->maps.filters);
+	list_for_each_entry(expr, &evsel->bpf_filters, list) {
+		struct perf_bpf_filter_entry entry = {
+			.op = expr->op,
+			.flags = expr->sample_flags,
+			.value = expr->val,
+		};
+		bpf_map_update_elem(fd, &i, &entry, BPF_ANY);
+		i++;
+	}
+
+	prog = skel->progs.perf_sample_filter;
+	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
+		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
+			link = bpf_program__attach_perf_event(prog, FD(evsel, x, y));
+			if (IS_ERR(link)) {
+				pr_err("Failed to attach perf sample-filter program\n");
+				return PTR_ERR(link);
+			}
+		}
+	}
+	evsel->bpf_skel = skel;
+	return 0;
+}
+
+int perf_bpf_filter__destroy(struct evsel *evsel)
+{
+	struct perf_bpf_filter_expr *expr, *tmp;
+
+	list_for_each_entry_safe(expr, tmp, &evsel->bpf_filters, list) {
+		list_del(&expr->list);
+		free(expr);
+	}
+	sample_filter_bpf__destroy(evsel->bpf_skel);
+	return 0;
+}
+
 struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
 						       enum perf_bpf_filter_op op,
 						       unsigned long val)
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index fd5b1164a322..6077930073f9 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -4,15 +4,7 @@
 
 #include <linux/list.h>
 
-enum perf_bpf_filter_op {
-	PBF_OP_EQ,
-	PBF_OP_NEQ,
-	PBF_OP_GT,
-	PBF_OP_GE,
-	PBF_OP_LT,
-	PBF_OP_LE,
-	PBF_OP_AND,
-};
+#include "bpf_skel/sample-filter.h"
 
 struct perf_bpf_filter_expr {
 	struct list_head list;
@@ -21,16 +13,30 @@ struct perf_bpf_filter_expr {
 	unsigned long val;
 };
 
+struct evsel;
+
 #ifdef HAVE_BPF_SKEL
 struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
 						       enum perf_bpf_filter_op op,
 						       unsigned long val);
 int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
+int perf_bpf_filter__prepare(struct evsel *evsel);
+int perf_bpf_filter__destroy(struct evsel *evsel);
+
 #else /* !HAVE_BPF_SKEL */
+
 static inline int perf_bpf_filter__parse(struct list_head *expr_head __maybe_unused,
 					 const char *str __maybe_unused)
 {
 	return -ENOSYS;
 }
+static inline int perf_bpf_filter__prepare(struct evsel *evsel)
+{
+	return -ENOSYS;
+}
+static inline int perf_bpf_filter__destroy(struct evsel *evsel)
+{
+	return -ENOSYS;
+}
 #endif /* HAVE_BPF_SKEL*/
 #endif /* PERF_UTIL_BPF_FILTER_H */
\ No newline at end of file
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
new file mode 100644
index 000000000000..862060bfda14
--- /dev/null
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -0,0 +1,24 @@
+#ifndef PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
+#define PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
+
+#define MAX_FILTERS  32
+
+/* supported filter operations */
+enum perf_bpf_filter_op {
+	PBF_OP_EQ,
+	PBF_OP_NEQ,
+	PBF_OP_GT,
+	PBF_OP_GE,
+	PBF_OP_LT,
+	PBF_OP_LE,
+	PBF_OP_AND
+};
+
+/* BPF map entry for filtering */
+struct perf_bpf_filter_entry {
+	enum perf_bpf_filter_op op;
+	__u64 flags;
+	__u64 value;
+};
+
+#endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
\ No newline at end of file
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
new file mode 100644
index 000000000000..1aa6a4cacd51
--- /dev/null
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2023 Google
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#include "sample-filter.h"
+
+/* BPF map that will be filled by user space */
+struct filters {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct perf_bpf_filter_entry);
+	__uint(max_entries, MAX_FILTERS);
+} filters SEC(".maps");
+
+int dropped;
+
+void *bpf_cast_to_kern_ctx(void *) __ksym;
+
+/* helper function to return the given perf sample data */
+static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
+				    struct perf_bpf_filter_entry *entry)
+{
+	if ((kctx->data->sample_flags & entry->flags) == 0)
+		return 0;
+
+	switch (entry->flags) {
+	case PERF_SAMPLE_IP:
+		return kctx->data->ip;
+	case PERF_SAMPLE_ID:
+		return kctx->data->id;
+	case PERF_SAMPLE_TID:
+		return kctx->data->tid_entry.tid;
+	case PERF_SAMPLE_CPU:
+		return kctx->data->cpu_entry.cpu;
+	case PERF_SAMPLE_TIME:
+		return kctx->data->time;
+	case PERF_SAMPLE_ADDR:
+		return kctx->data->addr;
+	case PERF_SAMPLE_PERIOD:
+		return kctx->data->period;
+	case PERF_SAMPLE_TRANSACTION:
+		return kctx->data->txn;
+	case PERF_SAMPLE_WEIGHT:
+		return kctx->data->weight.full;
+	case PERF_SAMPLE_PHYS_ADDR:
+		return kctx->data->phys_addr;
+	case PERF_SAMPLE_CODE_PAGE_SIZE:
+		return kctx->data->code_page_size;
+	case PERF_SAMPLE_DATA_PAGE_SIZE:
+		return kctx->data->data_page_size;
+	default:
+		break;
+	}
+	return 0;
+}
+
+/* BPF program to be called from perf event overflow handler */
+SEC("perf_event")
+int perf_sample_filter(void *ctx)
+{
+	struct bpf_perf_event_data_kern *kctx;
+	struct perf_bpf_filter_entry *entry;
+	__u64 sample_data;
+	int i;
+
+	kctx = bpf_cast_to_kern_ctx(ctx);
+
+	for (i = 0; i < MAX_FILTERS; i++) {
+		int key = i; /* needed for verifier :( */
+
+		entry = bpf_map_lookup_elem(&filters, &key);
+		if (entry == NULL)
+			break;
+		sample_data = perf_get_sample(kctx, entry);
+
+		switch (entry->op) {
+		case PBF_OP_EQ:
+			if (!(sample_data == entry->value))
+				goto drop;
+			break;
+		case PBF_OP_NEQ:
+			if (!(sample_data != entry->value))
+				goto drop;
+			break;
+		case PBF_OP_GT:
+			if (!(sample_data > entry->value))
+				goto drop;
+			break;
+		case PBF_OP_GE:
+			if (!(sample_data >= entry->value))
+				goto drop;
+			break;
+		case PBF_OP_LT:
+			if (!(sample_data < entry->value))
+				goto drop;
+			break;
+		case PBF_OP_LE:
+			if (!(sample_data <= entry->value))
+				goto drop;
+			break;
+		case PBF_OP_AND:
+			if (!(sample_data & entry->value))
+				goto drop;
+			break;
+		}
+	}
+	/* generate sample data */
+	return 1;
+
+drop:
+	__sync_fetch_and_add(&dropped, 1);
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 24cb807ef6ce..6845642485ec 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -151,8 +151,10 @@ struct evsel {
 	 */
 	struct bpf_counter_ops	*bpf_counter_ops;
 
-	/* for perf-stat -b */
-	struct list_head	bpf_counter_list;
+	union {
+		struct list_head	bpf_counter_list; /* for perf-stat -b */
+		struct list_head	bpf_filters; /* for perf-record --filter */
+	};
 
 	/* for perf-stat --use-bpf */
 	int			bperf_leader_prog_fd;
@@ -160,6 +162,7 @@ struct evsel {
 	union {
 		struct bperf_leader_bpf *leader_skel;
 		struct bperf_follower_bpf *follower_skel;
+		void *bpf_skel;
 	};
 	unsigned long		open_flags;
 	int			precise_ip_original;
-- 
2.39.1.581.gbfd45094c4-goog

