Return-Path: <bpf+bounces-47004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF4D9F25E0
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 20:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544861886640
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A8E1C8FB4;
	Sun, 15 Dec 2024 19:35:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5691C5F26;
	Sun, 15 Dec 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734291327; cv=none; b=jcps6VtT/R705RffmFZV64RTu0EaMJo/ZmfmqxoAZPINV/MeITUWvoOqKMqkNa6Egh34TT3Wzt3dKKhV3x362842tPeuCBK9eWD3RYmwQJUmHKVPFunSAKDDNIlGZKhE2s3yoCyALuO8HT1hJ8rzf3xODH9IXByvPJ/UMwtj/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734291327; c=relaxed/simple;
	bh=FzoGJzCeZtrd4j9s2zw+2pNu1YI45a/HeNQNrW+Uo1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dua3ktqFua/JNtxKsuuVImWn2u+7WDv9K9PZMbbGDLWLv7Hwj7vaGsyFeR+4nl4KBDNTOPkoF6YH8cuy40LkNHKX1WA5QFB4dznraAWIpkvdlUZU+Pktz80GitMl3Cga3BQFszkZrWfgYKQc+ZRs4CBKOyoXGCiQAhsRLaHTeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C371168F;
	Sun, 15 Dec 2024 11:35:53 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3375B3F528;
	Sun, 15 Dec 2024 11:35:21 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 4/7] perf: auxtrace: Introduce eBPF program for AUX pause
Date: Sun, 15 Dec 2024 19:34:33 +0000
Message-Id: <20241215193436.275278-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241215193436.275278-1-leo.yan@arm.com>
References: <20241215193436.275278-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces eBPF program as backend to trigger AUX pause and
resume.

The eBPF programs are prepared for attaching kprobe, kretprobe and
tracepoints.  When a eBPF program is invoked, it calls the eBPF API
bpf_perf_event_aux_pause() for controlling AUX pause and resume.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Makefile.perf                      |   1 +
 tools/perf/util/bpf_skel/auxtrace_pause.bpf.c | 135 ++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 tools/perf/util/bpf_skel/auxtrace_pause.bpf.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d74241a15131..14ac29094eb5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1173,6 +1173,7 @@ SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_top.skel.h
 SKELETONS += $(SKEL_OUT)/bench_uprobe.skel.h
 SKELETONS += $(SKEL_OUT)/augmented_raw_syscalls.skel.h
+SKELETONS += $(SKEL_OUT)/auxtrace_pause.skel.h
 
 $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
diff --git a/tools/perf/util/bpf_skel/auxtrace_pause.bpf.c b/tools/perf/util/bpf_skel/auxtrace_pause.bpf.c
new file mode 100644
index 000000000000..02c211e30e37
--- /dev/null
+++ b/tools/perf/util/bpf_skel/auxtrace_pause.bpf.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright 2024 Arm Limited
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} cpu_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} task_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(int));
+	__uint(max_entries, 1);
+} events SEC(".maps");
+
+int enabled = 0;
+
+const volatile int has_cpu = 0;
+const volatile int has_task = 0;
+
+static int event_aux_pause(void)
+{
+	__u64 key;
+
+	if (!enabled)
+		return 0;
+
+	if (has_cpu) {
+		__u32 cpu = bpf_get_smp_processor_id();
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&cpu_filter, &cpu);
+		if (!ok)
+			return 0;
+
+		key = cpu;
+	}
+
+	if (has_task) {
+		__u32 pid = bpf_get_current_pid_tgid() & 0xffffffff;
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&task_filter, &pid);
+		if (!ok)
+			return 0;
+
+		key = 0;
+	}
+
+	bpf_perf_event_aux_pause(&events, key, 1);
+	return 0;
+}
+
+static int event_aux_resume(void)
+{
+	__u64 key;
+
+	if (!enabled)
+		return 0;
+
+	if (has_cpu) {
+		__u32 cpu = bpf_get_smp_processor_id();
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&cpu_filter, &cpu);
+		if (!ok)
+			return 0;
+
+		key = cpu;
+	}
+
+	if (has_task) {
+		__u32 pid = bpf_get_current_pid_tgid() & 0xffffffff;
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&task_filter, &pid);
+		if (!ok)
+			return 0;
+
+		key = 0;
+	}
+
+	bpf_perf_event_aux_pause(&events, key, 0);
+	return 0;
+}
+
+SEC("kprobe/func_pause")
+int BPF_PROG(kprobe_event_pause)
+{
+	return event_aux_pause();
+}
+
+SEC("kretprobe/func_pause")
+int BPF_PROG(kretprobe_event_pause)
+{
+	return event_aux_pause();
+}
+
+SEC("tp/func_pause")
+int BPF_PROG(tp_event_pause)
+{
+	return event_aux_pause();
+}
+
+SEC("kprobe/func_resume")
+int BPF_PROG(kprobe_event_resume)
+{
+	return event_aux_resume();
+}
+
+SEC("kretprobe/func_resume")
+int BPF_PROG(kretprobe_event_resume)
+{
+	return event_aux_resume();
+}
+
+SEC("tp/func_resume")
+int BPF_PROG(tp_event_resume)
+{
+	return event_aux_resume();
+}
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.34.1


