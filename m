Return-Path: <bpf+bounces-70125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D4BBB174B
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 20:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB03192191D
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 18:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742332D3EF2;
	Wed,  1 Oct 2025 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="har80iey"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A021579F
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759342369; cv=none; b=qFf/LGkS3zBxiZoaSKbPu72CbGmby3JGuA5Twrkx76wbBLnYbwvCk6eNZ1jGTq423rDJjsAmXxatZa8R9npc7olm+Wntt4WfmE9c8P+KIJihAoi+4OfUdmeixjU+TVCJKIaTB2BxXpW/xe1DC2FymMJobOhvdDQuK463lsUS5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759342369; c=relaxed/simple;
	bh=011jUGOOoKkXk/ReueeZUoSAU8MIuuPR7QdsFRWbkfM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=g6r6tcEnswqQnqopGNdYpwpvPyJVCj6h0kpg3MwTI3TJBjixd+MaeWTdycCcojXA5MQJ8j+87+pZR+2Y/b9PyqK1EM87QvNLMpU1CwGIs3mfEkWDU3uhkRs842sPItEq4Gq7revoUwnqnKSMbhUHMOhah/FgpI2qGSxRiCsxz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=har80iey; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-34f747ca47eso231372fac.2
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759342365; x=1759947165; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=730yQpFWggvxNIJikZhHthn00aM7vY2Tj4B2azCDoco=;
        b=har80ieyXQxUBrDqjcszI1MPf5z1Eb1+UNrAuosZg4tGQ5Wuww7Lim5/6yUPaPUeNi
         h3XMYhnXS3D8JkyAzql2O18/Bf+VViELG4OyNRoavCUcwOxoXVxZpR+9PbC0/YJ7tyuE
         vL/uVW59cUxYzQ4DchtoaBoBlpQ5Uw+ftQ/R1GpOUhMAPg1E/+7wZnAEsSTCrU82+v1Q
         UgdMMj0fb6eR2WKHqeyjppPcn+bWOAffn5+SvRje37xx4/bQDcCrxOU9sOoUML4qBn3+
         7FWL9hFJNpIVptjWVyvPxOKS0Vq9fkliQzIt0rXq05kaL4yFPhZML9edLRt4ZhOw//FI
         DDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759342365; x=1759947165;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=730yQpFWggvxNIJikZhHthn00aM7vY2Tj4B2azCDoco=;
        b=wTjAea412SnST72ERXD2WWLAgdpUpteEdMxfxnWNtgGu5old1o8zMEGuOaZZFb0oRc
         1F1UGfZJ6hmhn4Se9hF2IwNwrncdZIz2vziSC/pKKRFzfVQ7GPXsQBRziu9aEo50FSTg
         r/dg/hsLaJ9c4z0pfmu9d+SjfY1Kp/plY48U01lG0gt14EX8AjdGxwq6G/UWQNw6ggv4
         V/TrlzLwgwU31isyKcZBTkdRLO6Iom2qEM9k8OzddD2ErLMPdTGqyCUVFtA2gizN3nVL
         rGME4qIMJMfmAKCPadBGdR+pJS/vIEfcO7AAQ15oT2ZOQ06DLYenor48zlC/BM/R1VLq
         iEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYcdYkeeYAD21zwKh3zOOtFC75N5AFMH3A8f6kTZGFXbLhZ4Nfr6py4oPghtukR7/gWuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCPLm+iQOCnUbN9wFakanWO4NZGUdNvyBLtMmYq+Xg15Cozaaa
	ZUq3W+FjhFWSJ8f5kYiPSbiiIjUyoL2xDCsvn6iePqZCpIRxtyu6ij4u+CwKvDj5KPkO8iha+BZ
	HcQPS25CiXg==
X-Google-Smtp-Source: AGHT+IH0pXCIae2yyp2tAq7SYpCMePBRfDR6ltaDmHYJA+cgg0pmRh7cjevkoYEbhEukmRpsI/w3BNS8UR5Q
X-Received: from oabcv42.prod.google.com ([2002:a05:6870:c6aa:b0:394:3e41:3f05])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:2490:b0:332:8989:4ef8
 with SMTP id 586e51a60fabf-39bae855404mr2531917fac.31.1759342365499; Wed, 01
 Oct 2025 11:12:45 -0700 (PDT)
Date: Wed,  1 Oct 2025 11:12:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001181229.1010340-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf bpf_counter: Move header declarations into C code
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, Gabriele Monaco <gmonaco@redhat.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Song Liu <songliubraving@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reduce the API surface that is in bpf_counter.h, this helps compiler
analysis like unused static function, makes it easier to set a
breakpoint and just makes it easier to see the code is self
contained. When code is shared between BPF C code, put it inside
HAVE_BPF_SKEL. Move transitively found #includes into appropriate C
files.
No functional change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter.c        | 62 ++++++++++++++++++++++-
 tools/perf/util/bpf_counter.h        | 74 +++-------------------------
 tools/perf/util/bpf_counter_cgroup.c |  1 +
 tools/perf/util/bpf_ftrace.c         |  1 +
 tools/perf/util/bpf_off_cpu.c        |  1 +
 5 files changed, 69 insertions(+), 70 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 73fcafbffc6a..1c6cb5ea077e 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -6,10 +6,14 @@
 #include <limits.h>
 #include <unistd.h>
 #include <sys/file.h>
+#include <sys/resource.h>
 #include <sys/time.h>
 #include <linux/err.h>
+#include <linux/list.h>
 #include <linux/zalloc.h>
 #include <api/fs/fs.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
 #include <perf/bpf_perf.h>
 
 #include "bpf_counter.h"
@@ -28,13 +32,67 @@
 #include "bpf_skel/bperf_leader.skel.h"
 #include "bpf_skel/bperf_follower.skel.h"
 
+struct bpf_counter {
+	void *skel;
+	struct list_head list;
+};
+
 #define ATTR_MAP_SIZE 16
 
-static inline void *u64_to_ptr(__u64 ptr)
+static void *u64_to_ptr(__u64 ptr)
 {
 	return (void *)(unsigned long)ptr;
 }
 
+
+void set_max_rlimit(void)
+{
+	struct rlimit rinf = { RLIM_INFINITY, RLIM_INFINITY };
+
+	setrlimit(RLIMIT_MEMLOCK, &rinf);
+}
+
+static __u32 bpf_link_get_id(int fd)
+{
+	struct bpf_link_info link_info = { .id = 0, };
+	__u32 link_info_len = sizeof(link_info);
+
+	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
+	return link_info.id;
+}
+
+static __u32 bpf_link_get_prog_id(int fd)
+{
+	struct bpf_link_info link_info = { .id = 0, };
+	__u32 link_info_len = sizeof(link_info);
+
+	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
+	return link_info.prog_id;
+}
+
+static __u32 bpf_map_get_id(int fd)
+{
+	struct bpf_map_info map_info = { .id = 0, };
+	__u32 map_info_len = sizeof(map_info);
+
+	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
+	return map_info.id;
+}
+
+/* trigger the leader program on a cpu */
+int bperf_trigger_reading(int prog_fd, int cpu)
+{
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .ctx_in = NULL,
+			    .ctx_size_in = 0,
+			    .flags = BPF_F_TEST_RUN_ON_CPU,
+			    .cpu = cpu,
+			    .retval = 0,
+		);
+
+	return bpf_prog_test_run_opts(prog_fd, &opts);
+}
+
 static struct bpf_counter *bpf_counter_alloc(void)
 {
 	struct bpf_counter *counter;
@@ -785,7 +843,7 @@ struct bpf_counter_ops bperf_ops = {
 
 extern struct bpf_counter_ops bperf_cgrp_ops;
 
-static inline bool bpf_counter_skip(struct evsel *evsel)
+static bool bpf_counter_skip(struct evsel *evsel)
 {
 	return evsel->bpf_counter_ops == NULL;
 }
diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
index c6d21c07b14c..658d8e7d507e 100644
--- a/tools/perf/util/bpf_counter.h
+++ b/tools/perf/util/bpf_counter.h
@@ -2,18 +2,10 @@
 #ifndef __PERF_BPF_COUNTER_H
 #define __PERF_BPF_COUNTER_H 1
 
-#include <linux/list.h>
-#include <sys/resource.h>
-
-#ifdef HAVE_LIBBPF_SUPPORT
-#include <bpf/bpf.h>
-#include <bpf/btf.h>
-#include <bpf/libbpf.h>
-#endif
-
 struct evsel;
 struct target;
-struct bpf_counter;
+
+#ifdef HAVE_BPF_SKEL
 
 typedef int (*bpf_counter_evsel_op)(struct evsel *evsel);
 typedef int (*bpf_counter_evsel_target_op)(struct evsel *evsel,
@@ -22,6 +14,7 @@ typedef int (*bpf_counter_evsel_install_pe_op)(struct evsel *evsel,
 					       int cpu_map_idx,
 					       int fd);
 
+/* Shared ops between bpf_counter, bpf_counter_cgroup, etc. */
 struct bpf_counter_ops {
 	bpf_counter_evsel_target_op load;
 	bpf_counter_evsel_op enable;
@@ -31,13 +24,6 @@ struct bpf_counter_ops {
 	bpf_counter_evsel_install_pe_op install_pe;
 };
 
-struct bpf_counter {
-	void *skel;
-	struct list_head list;
-};
-
-#ifdef HAVE_BPF_SKEL
-
 int bpf_counter__load(struct evsel *evsel, struct target *target);
 int bpf_counter__enable(struct evsel *evsel);
 int bpf_counter__disable(struct evsel *evsel);
@@ -45,6 +31,9 @@ int bpf_counter__read(struct evsel *evsel);
 void bpf_counter__destroy(struct evsel *evsel);
 int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
 
+int bperf_trigger_reading(int prog_fd, int cpu);
+void set_max_rlimit(void);
+
 #else /* HAVE_BPF_SKEL */
 
 #include <linux/err.h>
@@ -83,55 +72,4 @@ static inline int bpf_counter__install_pe(struct evsel *evsel __maybe_unused,
 
 #endif /* HAVE_BPF_SKEL */
 
-static inline void set_max_rlimit(void)
-{
-	struct rlimit rinf = { RLIM_INFINITY, RLIM_INFINITY };
-
-	setrlimit(RLIMIT_MEMLOCK, &rinf);
-}
-
-#ifdef HAVE_BPF_SKEL
-
-static inline __u32 bpf_link_get_id(int fd)
-{
-	struct bpf_link_info link_info = { .id = 0, };
-	__u32 link_info_len = sizeof(link_info);
-
-	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
-	return link_info.id;
-}
-
-static inline __u32 bpf_link_get_prog_id(int fd)
-{
-	struct bpf_link_info link_info = { .id = 0, };
-	__u32 link_info_len = sizeof(link_info);
-
-	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
-	return link_info.prog_id;
-}
-
-static inline __u32 bpf_map_get_id(int fd)
-{
-	struct bpf_map_info map_info = { .id = 0, };
-	__u32 map_info_len = sizeof(map_info);
-
-	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
-	return map_info.id;
-}
-
-/* trigger the leader program on a cpu */
-static inline int bperf_trigger_reading(int prog_fd, int cpu)
-{
-	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
-			    .ctx_in = NULL,
-			    .ctx_size_in = 0,
-			    .flags = BPF_F_TEST_RUN_ON_CPU,
-			    .cpu = cpu,
-			    .retval = 0,
-		);
-
-	return bpf_prog_test_run_opts(prog_fd, &opts);
-}
-#endif /* HAVE_BPF_SKEL */
-
 #endif /* __PERF_BPF_COUNTER_H */
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 6ff42619de12..ed6a29b106b4 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -13,6 +13,7 @@
 #include <linux/zalloc.h>
 #include <linux/perf_event.h>
 #include <api/fs/fs.h>
+#include <bpf/bpf.h>
 #include <perf/bpf_perf.h>
 
 #include "affinity.h"
diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index 0cb02412043c..e61a3b20be0a 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -3,6 +3,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 
+#include <bpf/bpf.h>
 #include <linux/err.h>
 
 #include "util/ftrace.h"
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index c367fefe6ecb..88e0660c4bff 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -13,6 +13,7 @@
 #include "util/cgroup.h"
 #include "util/strlist.h"
 #include <bpf/bpf.h>
+#include <bpf/btf.h>
 #include <internal/xyarray.h>
 #include <linux/time64.h>
 
-- 
2.51.0.618.g983fd99d29-goog


