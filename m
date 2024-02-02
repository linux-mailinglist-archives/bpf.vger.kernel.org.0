Return-Path: <bpf+bounces-21116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C199E847D55
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 00:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F7B1C214E3
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF13134CE0;
	Fri,  2 Feb 2024 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIuNlx0u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C584F134CD9
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917290; cv=none; b=e9BOyePBewj2TKZ1OzmohSjitq/D1M8vceRi84h58vjI0Pg1VQJhoEfphWLNnmRT6hvFmU3aVNstV+6pKxuVl/LMQHSSZMVfSVfAYBR5EXLRNopEfI9emx237A3acv4zpdfn17S/WBIEf9wBULOGW5rBke9edl7ALSiR1r/c8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917290; c=relaxed/simple;
	bh=Pj322BHyXG2gYzt70812aeyUBm7YX+GP878Iql8M7M0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SmT5BGC/BCSty2Q0X0xTv4saNPkPE5vh4TpYcBgt26I3BpMbcfX7qDQsipzu2RTWKa+Yd5SWjMJniyCD7oMsbLz/q8IygEvg7VeNI/ue43/Gzlh4Lvon8r5wS+w/oqtbT9JPdanszAKf35L/Qr+ndZW1bQDjje914Xb5z8UMbo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIuNlx0u; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ceade361so4260722276.0
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 15:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917287; x=1707522087; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAZu4qV7GRrZlOn2fzXe1/O/dsnDVPHUY/jAFql6qE8=;
        b=DIuNlx0u6wSWGys6ouJSMYxes9hEfYlyXok/OWotLRxVI35LFDYpfJH8coIYc0681B
         b9NXDeLR2MwM0bjymnAnENA9wDAJIPZ1pXNLfwC9jyhjYcpOXKEr7Zx8c/uXW0f5+yOR
         WOlNjjAKMX44JyyITWLYLd2jrMM6Cwe8DP/iJgOMPFCGUI4e0YOmmQPEHupBuc+JTlNW
         R4ltew9kBb8wstgn6E6eZXSGGmSmJyOoMxX9ab3V/XMLI0t4CQ9RziX+aAGsWZXnIJi7
         69xRVNVv9to9TYv5c0GRE3SqaEO/jvrCEA3eM3o6gqv5lWvaVpbHXmIJPOMN8AFkgJuJ
         rVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917287; x=1707522087;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAZu4qV7GRrZlOn2fzXe1/O/dsnDVPHUY/jAFql6qE8=;
        b=avxEOBgTG7AsWkT4uMJfKjfWoPkbvwsaIjbDrgmd1ad0LF/axvHBscj/cylLiNy1QH
         cTlh9x89aDXT/b5HoPtptSQOjZ+CrY3CfSECo8cWdIINvt/zF0ZENRU85XBUdvAaclIN
         OOglGmIvKXP2ALwNoWkOATmA8/l6ojwFPvhcxjO9tCNFmSDtiVazjMEArPUbVWLMyt3W
         0UtmdoAez3J4dkwZRU1PKYBdelMsg5WHlJIBZzNP9GpJMcpf6/wAaty4GbNXwTDcT/RK
         igk1caoj+xKzO7J9/afEQ0LPrzQ7N7iPRBOkbjOkPd4ueWJRUyf+DtgDgzhMoSJYTjiM
         /krw==
X-Gm-Message-State: AOJu0YwhhE4rHIdi8+3WgnuM3f5DgDLvLjwKgV/18RdqfNsvBslqMzg4
	owQm9jRgScTBGKArX5CiTEejae58z6OHeV9X+dWjAEe83GRNL/FkeRZhnUQpJMJlT4MgVf2dLgW
	KduX6IQ==
X-Google-Smtp-Source: AGHT+IGWKHJPQ+srMx8iTQjHmNcONKoF9irN1wBz1oJLHeiCGaYjrokUE8W5/hfZBgPHowpVLv93UI3h+uEW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7732:d863:503:f53d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1b90:b0:dc6:de8c:f4fb with SMTP
 id ei16-20020a0569021b9000b00dc6de8cf4fbmr1026637ybb.9.1706917287710; Fri, 02
 Feb 2024 15:41:27 -0800 (PST)
Date: Fri,  2 Feb 2024 15:40:57 -0800
In-Reply-To: <20240202234057.2085863-1-irogers@google.com>
Message-Id: <20240202234057.2085863-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v3 8/8] perf cpumap: Use perf_cpu_map__for_each_cpu when possible
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than manually iterating the CPU map, use
perf_cpu_map__for_each_cpu. When possible tidy local variables.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/header.c           | 10 ++--
 tools/perf/tests/bitmap.c                     | 13 +++---
 tools/perf/tests/topology.c                   | 46 +++++++++----------
 tools/perf/util/bpf_kwork.c                   | 16 ++++---
 tools/perf/util/bpf_kwork_top.c               | 12 ++---
 tools/perf/util/cpumap.c                      | 12 ++---
 .../scripting-engines/trace-event-python.c    | 12 +++--
 tools/perf/util/session.c                     |  5 +-
 tools/perf/util/svghelper.c                   | 20 ++++----
 9 files changed, 72 insertions(+), 74 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index a9de0b5187dd..741df3614a09 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -4,8 +4,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <perf/cpumap.h>
-#include <util/cpumap.h>
-#include <internal/cpumap.h>
 #include <api/fs/fs.h>
 #include <errno.h>
 #include "debug.h"
@@ -19,18 +17,18 @@
 static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 {
 	const char *sysfs = sysfs__mountpoint();
-	int cpu;
-	int ret = EINVAL;
+	struct perf_cpu cpu;
+	int idx, ret = EINVAL;
 
 	if (!sysfs || sz < MIDR_SIZE)
 		return EINVAL;
 
-	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		char path[PATH_MAX];
 		FILE *file;
 
 		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d" MIDR,
-			  sysfs, RC_CHK_ACCESS(cpus)->map[cpu].cpu);
+			  sysfs, cpu.cpu);
 
 		file = fopen(path, "r");
 		if (!file) {
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 0173f5402a35..98956e0e0765 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -11,18 +11,19 @@
 static unsigned long *get_bitmap(const char *str, int nbits)
 {
 	struct perf_cpu_map *map = perf_cpu_map__new(str);
-	unsigned long *bm = NULL;
-	int i;
+	unsigned long *bm;
 
 	bm = bitmap_zalloc(nbits);
 
 	if (map && bm) {
-		for (i = 0; i < perf_cpu_map__nr(map); i++)
-			__set_bit(perf_cpu_map__cpu(map, i).cpu, bm);
+		int i;
+		struct perf_cpu cpu;
+
+		perf_cpu_map__for_each_cpu(cpu, i, map)
+			__set_bit(cpu.cpu, bm);
 	}
 
-	if (map)
-		perf_cpu_map__put(map);
+	perf_cpu_map__put(map);
 	return bm;
 }
 
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 2a842f53fbb5..a8cb5ba898ab 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -68,6 +68,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	};
 	int i;
 	struct aggr_cpu_id id;
+	struct perf_cpu cpu;
 
 	session = perf_session__new(&data, NULL);
 	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
@@ -113,8 +114,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	TEST_ASSERT_VAL("Session header CPU map not set", session->header.env.cpu);
 
 	for (i = 0; i < session->header.env.nr_cpus_avail; i++) {
-		struct perf_cpu cpu = { .cpu = i };
-
+		cpu.cpu = i;
 		if (!perf_cpu_map__has(map, cpu))
 			continue;
 		pr_debug("CPU %d, core %d, socket %d\n", i,
@@ -123,48 +123,48 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	}
 
 	// Test that CPU ID contains socket, die, core and CPU
-	for (i = 0; i < perf_cpu_map__nr(map); i++) {
-		id = aggr_cpu_id__cpu(perf_cpu_map__cpu(map, i), NULL);
+	perf_cpu_map__for_each_cpu(cpu, i, map) {
+		id = aggr_cpu_id__cpu(cpu, NULL);
 		TEST_ASSERT_VAL("Cpu map - CPU ID doesn't match",
-				perf_cpu_map__cpu(map, i).cpu == id.cpu.cpu);
+				cpu.cpu == id.cpu.cpu);
 
 		TEST_ASSERT_VAL("Cpu map - Core ID doesn't match",
-			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].core_id == id.core);
+			session->header.env.cpu[cpu.cpu].core_id == id.core);
 		TEST_ASSERT_VAL("Cpu map - Socket ID doesn't match",
-			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].socket_id ==
+			session->header.env.cpu[cpu.cpu].socket_id ==
 			id.socket);
 
 		TEST_ASSERT_VAL("Cpu map - Die ID doesn't match",
-			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].die_id == id.die);
+			session->header.env.cpu[cpu.cpu].die_id == id.die);
 		TEST_ASSERT_VAL("Cpu map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Cpu map - Thread IDX is set", id.thread_idx == -1);
 	}
 
 	// Test that core ID contains socket, die and core
-	for (i = 0; i < perf_cpu_map__nr(map); i++) {
-		id = aggr_cpu_id__core(perf_cpu_map__cpu(map, i), NULL);
+	perf_cpu_map__for_each_cpu(cpu, i, map) {
+		id = aggr_cpu_id__core(cpu, NULL);
 		TEST_ASSERT_VAL("Core map - Core ID doesn't match",
-			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].core_id == id.core);
+			session->header.env.cpu[cpu.cpu].core_id == id.core);
 
 		TEST_ASSERT_VAL("Core map - Socket ID doesn't match",
-			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].socket_id ==
+			session->header.env.cpu[cpu.cpu].socket_id ==
 			id.socket);
 
 		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
-			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].die_id == id.die);
+			session->header.env.cpu[cpu.cpu].die_id == id.die);
 		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Core map - Thread IDX is set", id.thread_idx == -1);
 	}
 
 	// Test that die ID contains socket and die
-	for (i = 0; i < perf_cpu_map__nr(map); i++) {
-		id = aggr_cpu_id__die(perf_cpu_map__cpu(map, i), NULL);
+	perf_cpu_map__for_each_cpu(cpu, i, map) {
+		id = aggr_cpu_id__die(cpu, NULL);
 		TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
-			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].socket_id ==
+			session->header.env.cpu[cpu.cpu].socket_id ==
 			id.socket);
 
 		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
-			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].die_id == id.die);
+			session->header.env.cpu[cpu.cpu].die_id == id.die);
 
 		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Die map - Core is set", id.core == -1);
@@ -173,10 +173,10 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	}
 
 	// Test that socket ID contains only socket
-	for (i = 0; i < perf_cpu_map__nr(map); i++) {
-		id = aggr_cpu_id__socket(perf_cpu_map__cpu(map, i), NULL);
+	perf_cpu_map__for_each_cpu(cpu, i, map) {
+		id = aggr_cpu_id__socket(cpu, NULL);
 		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
-			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].socket_id ==
+			session->header.env.cpu[cpu.cpu].socket_id ==
 			id.socket);
 
 		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
@@ -187,10 +187,10 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	}
 
 	// Test that node ID contains only node
-	for (i = 0; i < perf_cpu_map__nr(map); i++) {
-		id = aggr_cpu_id__node(perf_cpu_map__cpu(map, i), NULL);
+	perf_cpu_map__for_each_cpu(cpu, i, map) {
+		id = aggr_cpu_id__node(cpu, NULL);
 		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
-				cpu__get_node(perf_cpu_map__cpu(map, i)) == id.node);
+				cpu__get_node(cpu) == id.node);
 		TEST_ASSERT_VAL("Node map - Socket is set", id.socket == -1);
 		TEST_ASSERT_VAL("Node map - Die ID is set", id.die == -1);
 		TEST_ASSERT_VAL("Node map - Core is set", id.core == -1);
diff --git a/tools/perf/util/bpf_kwork.c b/tools/perf/util/bpf_kwork.c
index 6eb2c78fd7f4..44f0f708a15d 100644
--- a/tools/perf/util/bpf_kwork.c
+++ b/tools/perf/util/bpf_kwork.c
@@ -147,12 +147,12 @@ static bool valid_kwork_class_type(enum kwork_class_type type)
 
 static int setup_filters(struct perf_kwork *kwork)
 {
-	u8 val = 1;
-	int i, nr_cpus, key, fd;
-	struct perf_cpu_map *map;
-
 	if (kwork->cpu_list != NULL) {
-		fd = bpf_map__fd(skel->maps.perf_kwork_cpu_filter);
+		int idx, nr_cpus;
+		struct perf_cpu_map *map;
+		struct perf_cpu cpu;
+		int fd = bpf_map__fd(skel->maps.perf_kwork_cpu_filter);
+
 		if (fd < 0) {
 			pr_debug("Invalid cpu filter fd\n");
 			return -1;
@@ -165,8 +165,8 @@ static int setup_filters(struct perf_kwork *kwork)
 		}
 
 		nr_cpus = libbpf_num_possible_cpus();
-		for (i = 0; i < perf_cpu_map__nr(map); i++) {
-			struct perf_cpu cpu = perf_cpu_map__cpu(map, i);
+		perf_cpu_map__for_each_cpu(cpu, idx, map) {
+			u8 val = 1;
 
 			if (cpu.cpu >= nr_cpus) {
 				perf_cpu_map__put(map);
@@ -181,6 +181,8 @@ static int setup_filters(struct perf_kwork *kwork)
 	}
 
 	if (kwork->profile_name != NULL) {
+		int key, fd;
+
 		if (strlen(kwork->profile_name) >= MAX_KWORKNAME) {
 			pr_err("Requested name filter %s too large, limit to %d\n",
 			       kwork->profile_name, MAX_KWORKNAME - 1);
diff --git a/tools/perf/util/bpf_kwork_top.c b/tools/perf/util/bpf_kwork_top.c
index 035e02272790..22a3b00a1e23 100644
--- a/tools/perf/util/bpf_kwork_top.c
+++ b/tools/perf/util/bpf_kwork_top.c
@@ -122,11 +122,11 @@ static bool valid_kwork_class_type(enum kwork_class_type type)
 
 static int setup_filters(struct perf_kwork *kwork)
 {
-	u8 val = 1;
-	int i, nr_cpus, fd;
-	struct perf_cpu_map *map;
-
 	if (kwork->cpu_list) {
+		int idx, nr_cpus, fd;
+		struct perf_cpu_map *map;
+		struct perf_cpu cpu;
+
 		fd = bpf_map__fd(skel->maps.kwork_top_cpu_filter);
 		if (fd < 0) {
 			pr_debug("Invalid cpu filter fd\n");
@@ -140,8 +140,8 @@ static int setup_filters(struct perf_kwork *kwork)
 		}
 
 		nr_cpus = libbpf_num_possible_cpus();
-		for (i = 0; i < perf_cpu_map__nr(map); i++) {
-			struct perf_cpu cpu = perf_cpu_map__cpu(map, i);
+		perf_cpu_map__for_each_cpu(cpu, idx, map) {
+			u8 val = 1;
 
 			if (cpu.cpu >= nr_cpus) {
 				perf_cpu_map__put(map);
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 0581ee0fa5f2..e2287187babd 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -629,10 +629,10 @@ static char hex_char(unsigned char val)
 
 size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 {
-	int i, cpu;
+	int idx;
 	char *ptr = buf;
 	unsigned char *bitmap;
-	struct perf_cpu last_cpu = perf_cpu_map__cpu(map, perf_cpu_map__nr(map) - 1);
+	struct perf_cpu c, last_cpu = perf_cpu_map__max(map);
 
 	if (buf == NULL)
 		return 0;
@@ -643,12 +643,10 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 		return 0;
 	}
 
-	for (i = 0; i < perf_cpu_map__nr(map); i++) {
-		cpu = perf_cpu_map__cpu(map, i).cpu;
-		bitmap[cpu / 8] |= 1 << (cpu % 8);
-	}
+	perf_cpu_map__for_each_cpu(c, idx, map)
+		bitmap[c.cpu / 8] |= 1 << (c.cpu % 8);
 
-	for (cpu = last_cpu.cpu / 4 * 4; cpu >= 0; cpu -= 4) {
+	for (int cpu = last_cpu.cpu / 4 * 4; cpu >= 0; cpu -= 4) {
 		unsigned char bits = bitmap[cpu / 8];
 
 		if (cpu % 8)
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 860e1837ba96..8ef0e5ac03c2 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1693,13 +1693,15 @@ static void python_process_stat(struct perf_stat_config *config,
 {
 	struct perf_thread_map *threads = counter->core.threads;
 	struct perf_cpu_map *cpus = counter->core.cpus;
-	int cpu, thread;
 
-	for (thread = 0; thread < perf_thread_map__nr(threads); thread++) {
-		for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
-			process_stat(counter, perf_cpu_map__cpu(cpus, cpu),
+	for (int thread = 0; thread < perf_thread_map__nr(threads); thread++) {
+		int idx;
+		struct perf_cpu cpu;
+
+		perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+			process_stat(counter, cpu,
 				     perf_thread_map__pid(threads, thread), tstamp,
-				     perf_counts(counter->counts, cpu, thread));
+				     perf_counts(counter->counts, idx, thread));
 		}
 	}
 }
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 199d3e8df315..d52b58344dbc 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2738,6 +2738,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 	int i, err = -1;
 	struct perf_cpu_map *map;
 	int nr_cpus = min(session->header.env.nr_cpus_avail, MAX_NR_CPUS);
+	struct perf_cpu cpu;
 
 	for (i = 0; i < PERF_TYPE_MAX; ++i) {
 		struct evsel *evsel;
@@ -2759,9 +2760,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 		return -1;
 	}
 
-	for (i = 0; i < perf_cpu_map__nr(map); i++) {
-		struct perf_cpu cpu = perf_cpu_map__cpu(map, i);
-
+	perf_cpu_map__for_each_cpu(cpu, i, map) {
 		if (cpu.cpu >= nr_cpus) {
 			pr_err("Requested CPU %d too large. "
 			       "Consider raising MAX_NR_CPUS\n", cpu.cpu);
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 1892e9b6aa7f..2b04f47f4db0 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -725,26 +725,24 @@ static void scan_core_topology(int *map, struct topology *t, int nr_cpus)
 
 static int str_to_bitmap(char *s, cpumask_t *b, int nr_cpus)
 {
-	int i;
-	int ret = 0;
-	struct perf_cpu_map *m;
-	struct perf_cpu c;
+	int idx, ret = 0;
+	struct perf_cpu_map *map;
+	struct perf_cpu cpu;
 
-	m = perf_cpu_map__new(s);
-	if (!m)
+	map = perf_cpu_map__new(s);
+	if (!map)
 		return -1;
 
-	for (i = 0; i < perf_cpu_map__nr(m); i++) {
-		c = perf_cpu_map__cpu(m, i);
-		if (c.cpu >= nr_cpus) {
+	perf_cpu_map__for_each_cpu(cpu, idx, map) {
+		if (cpu.cpu >= nr_cpus) {
 			ret = -1;
 			break;
 		}
 
-		__set_bit(c.cpu, cpumask_bits(b));
+		__set_bit(cpu.cpu, cpumask_bits(b));
 	}
 
-	perf_cpu_map__put(m);
+	perf_cpu_map__put(map);
 
 	return ret;
 }
-- 
2.43.0.594.gd9cf4e227d-goog


