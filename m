Return-Path: <bpf+bounces-63730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F0AB0A789
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 17:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110C73B9B58
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 15:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB732E7F2F;
	Fri, 18 Jul 2025 15:26:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB122E424F;
	Fri, 18 Jul 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852376; cv=none; b=ZuMSw+DseL6ezQNOMl0HeSYgYeJutE6uLjIsqua8QAdXPX2d/cTyznjlhtpaPhtZdE7hJiOxmfEoNm4MOXxRykVU87yY/wYJhQjX24PFJyjwj9eYz2pjkOs4jsUCWyjkJ6B3QxHK5DyB78M46g0BGikdSF7KMh7Jp5cJZxklJqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852376; c=relaxed/simple;
	bh=HbcKt6x+Q/PblSro0Qo9cA0YkAWaCl9Q8+nAyVZruPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=coMy8sk90vASpuBIUN0skH0A6WZnzZM0ik2H/z3I6TR1sWDAVea2odfkfVf+Ch3yrgYIQQI1ChRWb87MPvoP8REySCAScrGAERjHMahF/yzeHcws98yNH6sBJ/eBH1SFJY+5tPjtO45rsWJ+86YUzMMe1KslR48A2b3qYTxWn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E2E616A3;
	Fri, 18 Jul 2025 08:26:06 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A4773F6A8;
	Fri, 18 Jul 2025 08:26:09 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 18 Jul 2025 16:25:37 +0100
Subject: [PATCH PATCH v2 v2 3/6] perf: auxtrace: Control AUX pause and
 resume with BPF
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-perf_aux_pause_resume_bpf_rebase-v2-3-992557b8fb16@arm.com>
References: <20250718-perf_aux_pause_resume_bpf_rebase-v2-0-992557b8fb16@arm.com>
In-Reply-To: <20250718-perf_aux_pause_resume_bpf_rebase-v2-0-992557b8fb16@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 James Clark <james.clark@linaro.org>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752852356; l=4543;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=HbcKt6x+Q/PblSro0Qo9cA0YkAWaCl9Q8+nAyVZruPc=;
 b=Yw3q5sNtQgfO1wEPcmtB6El94o96bpZPzQQWZk0VxLuoBfNSRlDK6GGnu/OvsFn01y2GrxyRN
 3fgSLaoHDmwBfAt9m4eedoPltndTJUDQInEfgSVdiDVrE3KrA3VIiQ5
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Introduce a BPF program to trigger AUX pause and resume.

Once a attached tracepoint is hit, the BPF program calls the
bpf_perf_event_aux_pause() kfunc for controlling AUX trace.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Makefile.perf                      |   1 +
 tools/perf/util/bpf_skel/auxtrace_pause.bpf.c | 156 ++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d4c7031b01a77f4a42326e4c9a88d8a352143178..8fdd24ba4c25ff4a69925a8e0c85bc78dd4fda47 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1179,6 +1179,7 @@ SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_top.skel.h $(SKEL_OUT)/syscall_summary.skel.h
 SKELETONS += $(SKEL_OUT)/bench_uprobe.skel.h
 SKELETONS += $(SKEL_OUT)/augmented_raw_syscalls.skel.h
+SKELETONS += $(SKEL_OUT)/auxtrace_pause.skel.h
 
 $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
diff --git a/tools/perf/util/bpf_skel/auxtrace_pause.bpf.c b/tools/perf/util/bpf_skel/auxtrace_pause.bpf.c
new file mode 100644
index 0000000000000000000000000000000000000000..2752651dbb6013401b568175b61183e2ac0e7f98
--- /dev/null
+++ b/tools/perf/util/bpf_skel/auxtrace_pause.bpf.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright 2025 Arm Limited
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
+const volatile int per_thread = 0;
+
+int bpf_perf_event_aux_pause(void *map, u64 flags, u32 pause) __ksym;
+
+static int event_aux_pause(void)
+{
+	__u64 flag;
+	__u32 cpu = bpf_get_smp_processor_id();
+
+	if (!enabled)
+		return 0;
+
+	if (has_cpu) {
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&cpu_filter, &cpu);
+		if (!ok)
+			return 0;
+	}
+
+	if (has_task) {
+		__u32 pid = bpf_get_current_pid_tgid() & 0xffffffff;
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&task_filter, &pid);
+		if (!ok)
+			return 0;
+	}
+
+	flag = per_thread ? 0 : BPF_F_CURRENT_CPU;
+	bpf_perf_event_aux_pause(&events, flag, 1);
+	return 0;
+}
+
+static int event_aux_resume(void)
+{
+	__u64 flag;
+	__u32 cpu = bpf_get_smp_processor_id();
+
+	if (!enabled)
+		return 0;
+
+	if (has_cpu) {
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&cpu_filter, &cpu);
+		if (!ok)
+			return 0;
+	}
+
+	if (has_task) {
+		__u32 pid = bpf_get_current_pid_tgid() & 0xffffffff;
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&task_filter, &pid);
+		if (!ok)
+			return 0;
+	}
+
+	flag = per_thread ? 0 : BPF_F_CURRENT_CPU;
+	bpf_perf_event_aux_pause(&events, flag, 0);
+	return 0;
+}
+
+SEC("kprobe/func_pause")
+int BPF_PROG(kprobe_event_pause)
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
+SEC("kretprobe/func_pause")
+int BPF_PROG(kretprobe_event_pause)
+{
+	return event_aux_pause();
+}
+
+SEC("kretprobe/func_resume")
+int BPF_PROG(kretprobe_event_resume)
+{
+	return event_aux_resume();
+}
+
+SEC("uprobe/func_pause")
+int BPF_PROG(uprobe_event_pause)
+{
+	return event_aux_pause();
+}
+
+SEC("uprobe/func_resume")
+int BPF_PROG(uprobe_event_resume)
+{
+	return event_aux_resume();
+}
+
+SEC("uretprobe/func_pause")
+int BPF_PROG(uretprobe_event_pause)
+{
+	return event_aux_pause();
+}
+
+SEC("uretprobe/func_resume")
+int BPF_PROG(uretprobe_event_resume)
+{
+	return event_aux_resume();
+}
+
+SEC("tp/func_pause")
+int BPF_PROG(tp_event_pause)
+{
+	return event_aux_pause();
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


