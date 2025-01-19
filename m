Return-Path: <bpf+bounces-49276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4579A162AF
	for <lists+bpf@lfdr.de>; Sun, 19 Jan 2025 16:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7C61885E89
	for <lists+bpf@lfdr.de>; Sun, 19 Jan 2025 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627C91DF746;
	Sun, 19 Jan 2025 15:34:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBCE1D4335;
	Sun, 19 Jan 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737300848; cv=none; b=BjKpEHsmvKlbTy/sJTerAnI2UuwVoa5WB8e8hroEx9igv+8KaG+Rvakxl5Pov4H2OOA+6+mombXrp7F6atrlKQotKy0pX64WDKb0eCh7KIq7+ACX+nVJt4O5gkwGoMEXS6qY8cLEneuzL2Lo5Do5n96nz71TaPoIg0tFsMRMZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737300848; c=relaxed/simple;
	bh=3+8Et3/XbPzERg0TjMEROIfGBBySVWHHfGWadQhc49w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qfaQlQJzy/2vEbcJYNDeoxZYLWkhhsKeoixasg6xtinWXdUeZGzCytx0Ksz3uS4x4DBjUPb+smUJ0C3jOQpvyk+Svzco9rJ/7AdBG5vRp9ABZPEiX1n3QiEumXiEXR/EqB/Ir/CykujYNH36SwqQYpLm3+ZKPZueZjTc1R+xZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92FE41424;
	Sun, 19 Jan 2025 07:34:26 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0341A3F66E;
	Sun, 19 Jan 2025 07:33:54 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Alexei Starovoitov <ast@kernel.org>,
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
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1] samples/bpf: Add a trace tool with perf PMU counters
Date: Sun, 19 Jan 2025 15:33:43 +0000
Message-Id: <20250119153343.116795-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Developers might need to profile a program with fine-grained
granularity.  E.g., a user case is to account the CPU cycles for a small
program or for a specific function within the program.

This commit introduces a small tool with using eBPF program to read the
perf PMU counters for performance metrics.  As the first step, the four
counters are supported with the '-e' option: cycles, instructions,
branches, branch-misses.

The '-r' option is provided for support raw event number.  This option
is mutually exclusive to the '-e' option, users either pass a raw event
number or a counter name.

The tool enables the counters for the entire trace session in free-run
mode.  It reads the beginning values for counters when the profiled
program is scheduled in, and calculate the interval when the task is
scheduled out.  The advantage of this approach is to dismiss the
statistics noise (e.g. caused by the tool itself) as possible.

The tool can support function based tracing.  By using the '-f' option,
users can specify the traced function.  The eBPF program enables tracing
at the function entry and disables trace upon exit from the function.

The '-u' option can be specified for tracing user mode only.

Below are several usage examples.

Trace CPU cycles for the whole program:

  # ./trace_counter -e cycles -- /mnt/sort
  Or
  # ./trace_counter -e cycles /mnt/sort
  Create process for the workload.
  Enable the event cycles.
  Bubble sorting array of 3000 elements
  551 ms
  Finished the workload.
  Event (cycles) statistics:
   +-----------+------------------+
   | CPU[0000] |         29093250 |
   +-----------+------------------+
   | CPU[0002] |         75672820 |
   +-----------+------------------+
   | CPU[0006] |       1067458735 |
   +-----------+------------------+
     Total     :       1172224805

Trace branches for the user mode only:

  # ./trace_counter -e branches -u -- /mnt/sort
  Create process for the workload.
  Enable the event branches.
  Bubble sorting array of 3000 elements
  541 ms
  Finished the workload.
  Event (branches) statistics:
   +-----------+------------------+
   | CPU[0007] |         88112669 |
   +-----------+------------------+
     Total     :         88112669

Trace instructions for the 'bubble_sort' function:

  # ./trace_counter -f bubble_sort -e instructions -- /mnt/sort
  Create process for the workload.
  Enable the event instructions.
  Bubble sorting array of 3000 elements
  541 ms
  Finished the workload.
  Event (instructions) statistics:
   +-----------+------------------+
   | CPU[0006] |       1169810201 |
   +-----------+------------------+
     Total     :       1169810201
  Function (bubble_sort) duration statistics:
     Count     :                5
     Minimum   :        232009928
     Maximum   :        236742006
     Average   :        233962040

Trace the raw event '0x5' (L1D_TLB_REFILL):

  # ./trace_counter -r 0x5 -u -- /mnt/sort
  Create process for the workload.
  Enable the raw event 0x5.
  Bubble sorting array of 3000 elements
  540 ms
  Finished the workload.
  Event (0x5) statistics:
   +-----------+------------------+
   | CPU[0007] |              174 |
   +-----------+------------------+
     Total     :              174

Trace for the function and set CPU affinity for the profiled program:

  # ./trace_counter -f bubble_sort -x /mnt/sort -e cycles \
	-- taskset -c 2 /mnt/sort
  Create process for the workload.
  Enable the event cycles.
  Bubble sorting array of 3000 elements
  619 ms
  Finished the workload.
  Event (cycles) statistics:
   +-----------+------------------+
   | CPU[0002] |       1169913056 |
   +-----------+------------------+
     Total     :       1169913056
  Function (bubble_sort) duration statistics:
     Count     :                5
     Minimum   :        232054101
     Maximum   :        236769623
     Average   :        233982611

The command above sets the CPU affinity with taskset command.  The
profiled function 'bubble_sort' is in the executable '/mnt/sort' but not
in the taskset binary.  The '-x' option is used to tell the tool the
correct executable path.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 samples/bpf/Makefile             |   7 +-
 samples/bpf/trace_counter.bpf.c  | 222 +++++++++++++
 samples/bpf/trace_counter_user.c | 528 +++++++++++++++++++++++++++++++
 3 files changed, 756 insertions(+), 1 deletion(-)
 create mode 100644 samples/bpf/trace_counter.bpf.c
 create mode 100644 samples/bpf/trace_counter_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index dd9944a97b7e..59123c7f4443 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -23,6 +23,7 @@ tprogs-y += offwaketime
 tprogs-y += spintest
 tprogs-y += map_perf_test
 tprogs-y += xdp_router_ipv4
+tprogs-y += trace_counter
 tprogs-y += trace_event
 tprogs-y += sampleip
 tprogs-y += tc_l2_redirect
@@ -64,6 +65,7 @@ offwaketime-objs := offwaketime_user.o $(TRACE_HELPERS)
 spintest-objs := spintest_user.o $(TRACE_HELPERS)
 map_perf_test-objs := map_perf_test_user.o
 test_overhead-objs := test_overhead_user.o
+trace_counter-objs := trace_counter_user.o $(TRACE_HELPERS)
 trace_event-objs := trace_event_user.o $(TRACE_HELPERS)
 sampleip-objs := sampleip_user.o $(TRACE_HELPERS)
 tc_l2_redirect-objs := tc_l2_redirect_user.o
@@ -99,6 +101,7 @@ always-y += offwaketime.bpf.o
 always-y += spintest.bpf.o
 always-y += map_perf_test.bpf.o
 always-y += parse_varlen.o parse_simple.o parse_ldabs.o
+always-y += trace_counter.bpf.o
 always-y += trace_event_kern.o
 always-y += sampleip_kern.o
 always-y += lwt_len_hist.bpf.o
@@ -283,6 +286,7 @@ $(obj)/$(TRACE_HELPERS) $(obj)/$(CGROUP_HELPERS) $(obj)/$(XDP_SAMPLE): | libbpf_
 .PHONY: libbpf_hdrs
 
 $(obj)/xdp_router_ipv4_user.o: $(obj)/xdp_router_ipv4.skel.h
+$(obj)/trace_counter_user.o: $(obj)/trace_counter.skel.h
 
 $(obj)/tracex5.bpf.o: $(obj)/syscall_nrs.h
 $(obj)/hbm_out_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
@@ -347,10 +351,11 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/x
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
 
-LINKED_SKELS := xdp_router_ipv4.skel.h
+LINKED_SKELS := xdp_router_ipv4.skel.h trace_counter.skel.h
 clean-files += $(LINKED_SKELS)
 
 xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o xdp_sample.bpf.o
+trace_counter.skel.h-deps := trace_counter.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/samples/bpf/trace_counter.bpf.c b/samples/bpf/trace_counter.bpf.c
new file mode 100644
index 000000000000..e7c1e93dcd83
--- /dev/null
+++ b/samples/bpf/trace_counter.bpf.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <linux/version.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, int);
+	__type(value, u32);
+	__uint(max_entries, 1);
+} counters SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, u64);
+	__uint(max_entries, 1);
+} values_begin SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, u64);
+	__uint(max_entries, 1);
+} values SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, u64);
+	__uint(max_entries, 1);
+} task_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, u64);
+	__uint(max_entries, 4);
+} func_stat SEC(".maps");
+
+#define TRACE_MODE_FUNCTION	(1 << 0)
+
+const volatile int trace_mode;
+
+static volatile bool func_trace_enabled;
+static u64 func_duration;
+
+static bool trace_is_enabled(void)
+{
+	/* The trace_mode is zero, traces for whole program. */
+	if (!trace_mode)
+		return true;
+
+	/* Tracing for the function will wait until the function is hit. */
+	if ((trace_mode & TRACE_MODE_FUNCTION) && func_trace_enabled)
+		return true;
+
+	return false;
+}
+
+static bool task_is_traced(u32 pid)
+{
+	u32 *pid_filter;
+	int key = 0;
+
+	pid_filter = bpf_map_lookup_elem(&task_filter, &key);
+	if (!pid_filter)
+		return false;
+
+	if (*pid_filter == pid)
+		return true;
+
+	return false;
+}
+
+static int record_begin_values(void)
+{
+	u64 count, *start;
+	u32 cpu = bpf_get_smp_processor_id();
+	s64 error;
+
+	count = bpf_perf_event_read(&counters, 0);
+	error = (s64)count;
+	if (error <= -2 && error >= -22)
+		return 0;
+
+	start = bpf_map_lookup_elem(&values_begin, &cpu);
+	if (start)
+		*start = count;
+	else
+		bpf_map_update_elem(&values_begin, &cpu, &count, BPF_NOEXIST);
+
+	return 0;
+}
+
+static int record_end_values(void)
+{
+	u64 count, *start, *value, interval;
+	u32 cpu = bpf_get_smp_processor_id();
+	s64 error;
+
+	count = bpf_perf_event_read(&counters, 0);
+	error = (s64)count;
+	if (error <= -2 && error >= -22)
+		return 0;
+
+	start = bpf_map_lookup_elem(&values_begin, &cpu);
+	/* It must be wrong if failed to read out start values, bail out. */
+	if (!start || *start == -1)
+		return 0;
+
+	interval = count - *start;
+	if (!interval)
+		return 0;
+
+	/* Record the interval */
+	value = bpf_map_lookup_elem(&values, &cpu);
+	if (value)
+		*value = *value + interval;
+	else
+		bpf_map_update_elem(&values, &cpu, &interval, BPF_NOEXIST);
+
+	if (func_trace_enabled)
+		func_duration += interval;
+
+	*start = -1;
+	return 0;
+}
+
+static int stat_function(void)
+{
+	int key;
+	u64 *count, *min, *max, init = 1;
+
+	/* Update function entering count */
+	key = 0;
+	count = bpf_map_lookup_elem(&func_stat, &key);
+	if (count)
+		*count += 1;
+	else
+		bpf_map_update_elem(&func_stat, &key, &init, BPF_NOEXIST);
+
+	/* Update function minimum duration */
+	key = 1;
+	min = bpf_map_lookup_elem(&func_stat, &key);
+	if (min) {
+		if (func_duration < *min)
+			*min = func_duration;
+	} else {
+		bpf_map_update_elem(&func_stat, &key, &func_duration, BPF_NOEXIST);
+	}
+
+	/* Update function maximum duration */
+	key = 2;
+	max = bpf_map_lookup_elem(&func_stat, &key);
+	if (max) {
+		if (func_duration > *max)
+			*max = func_duration;
+	} else {
+		bpf_map_update_elem(&func_stat, &key, &func_duration, BPF_NOEXIST);
+	}
+
+	return 0;
+}
+
+SEC("kretprobe/finish_task_switch")
+int schedule_in(struct pt_regs *ctx)
+{
+	if (!trace_is_enabled())
+		return 0;
+
+	if (!task_is_traced(bpf_get_current_pid_tgid()))
+		return 0;
+
+	return record_begin_values();
+}
+
+SEC("tracepoint/sched/sched_switch")
+int schedule_out(struct trace_event_raw_sched_switch *ctx)
+{
+	if (!trace_is_enabled())
+		return 0;
+
+	if (!task_is_traced(ctx->prev_pid))
+		return 0;
+
+	return record_end_values();
+}
+
+SEC("uprobe/func")
+int BPF_PROG(func_begin)
+{
+	int key = 0;
+	u32 *trace_mode;
+
+	if (!task_is_traced(bpf_get_current_pid_tgid()))
+		return 0;
+
+	func_trace_enabled = true;
+	func_duration = 0;
+	return record_begin_values();
+}
+
+SEC("uretprobe/func")
+int BPF_PROG(func_exit)
+{
+	int key = 0;
+	u32 *trace_mode;
+
+	if (!task_is_traced(bpf_get_current_pid_tgid()))
+		return 0;
+
+	record_end_values();
+	func_trace_enabled = false;
+	return stat_function();
+}
+
+char _license[] SEC("license") = "GPL";
+u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/trace_counter_user.c b/samples/bpf/trace_counter_user.c
new file mode 100644
index 000000000000..7c28bf5df51e
--- /dev/null
+++ b/samples/bpf/trace_counter_user.c
@@ -0,0 +1,528 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Arm Limited. */
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <linux/bpf.h>
+#include <linux/limits.h>
+#include <linux/perf_event.h>
+#include <sys/ioctl.h>
+#include <sys/resource.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "perf-sys.h"
+#include "trace_helpers.h"
+#include "trace_counter.skel.h"
+
+#define ARRAY_SIZE(x)		(sizeof(x) / sizeof(*(x)))
+#define SAMPLE_PERIOD		0x7fffffffffffffffULL
+
+static struct trace_counter *skel;
+
+/* Set the flag TRACE_MODE_FUNCTION for function trace. */
+#define TRACE_MODE_FUNCTION	(1 << 0)
+
+/* The PID for the profiled program */
+static int pid;
+
+/*
+ * The PID for a pipe used for synchronization between the parent
+ * process and the forked program in the child process.
+ *
+ * The synchronization mechanism is borrowed from the perf tool.
+ */
+static int cork_fd;
+
+/*
+ * The PMU event for tracing.  Four events are supported:
+ *   cycles, instructions, branches, branch-misses.
+ */
+static char *event;
+
+/*
+ * The absolute path for executable file.
+ */
+static char *executable;
+
+/*
+ * The function name for function trace.
+ */
+static char *func;
+
+/* File descriptor for PMU events */
+static int pmu_fd = -1;
+
+/* The target CPU for PMU event */
+static int pmu_cpu = -1;
+
+static char exec_path[PATH_MAX + 1];
+
+/* Only trace user mode */
+static bool user_mode;
+
+/* CPU number */
+static int nr_cpus;
+
+/* Raw event number */
+static long raw_event = -1;
+
+static void usage(const char *cmd)
+{
+	printf("USAGE: %s [-f function] [-x binary_path] [-e event] -- command ...\n", cmd);
+	printf("       %s [-f function] [-e event] command\n", cmd);
+	printf("       %s [-h]\n", cmd);
+	printf("       -c cpu		# Traced CPU (default: -1 for all CPUs)\n");
+	printf("       -f function      # Traced function name\n");
+	printf("       -x executable    # Absolute path for executable for adding uprobes\n");
+	printf("       -e event         # Event name (default: cycles). Supported events:\n");
+	printf("                        # cycles, instructions, branches, branch-misses\n");
+	printf("       -r raw_event_num # Raw event number in hexadecimal format.\n");
+	printf("                        # The '-r' option is mutually exclusive to the '-e' option.\n");
+	printf("       -u               # Only trace user mode\n");
+	printf("       -h               # Help\n");
+}
+
+static void err_exit(int err)
+{
+	if (pid)
+		kill(pid, SIGKILL);
+	exit(err);
+}
+
+static void print_counter(void)
+{
+	int cpu, fd, key;
+	__u64 value, sum = 0, count, min, max, avg;
+
+	if (event)
+		printf("Event (%s) statistics:\n", event);
+	else
+		printf("Event (0x%lx) statistics:\n", raw_event);
+
+	printf(" +-----------+------------------+\n");
+
+	fd = bpf_map__fd(skel->maps.values);
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		if (bpf_map_lookup_elem(fd, &cpu, &value))
+			continue;
+
+		printf(" | CPU[%04d] | %16llu |\n", cpu, value);
+		printf(" +-----------+------------------+\n");
+		sum += value;
+	}
+
+	printf("   Total     : %16llu\n", sum);
+
+	if (func) {
+		fd = bpf_map__fd(skel->maps.func_stat);
+		key = 0;
+		if (bpf_map_lookup_elem(fd, &key, &count)) {
+			printf("failed to read out function count\n");
+			return;
+		}
+
+		key = 1;
+		if (bpf_map_lookup_elem(fd, &key, &min)) {
+			printf("failed to read out function min duration\n");
+			return;
+		}
+
+		key = 2;
+		if (bpf_map_lookup_elem(fd, &key, &max)) {
+			printf("failed to read out function max duration\n");
+			return;
+		}
+
+		avg = sum / count;
+		printf("Function (%s) duration statistics:\n"
+		       "   Count     : %16llu\n"
+		       "   Minimum   : %16llu\n"
+		       "   Maximum   : %16llu\n"
+		       "   Average   : %16llu\n",
+		       func, count, min, max, avg);
+	}
+}
+
+/*
+ * Prepare process for profiled workload.  The synchronization mechanism is
+ * borrowed from the perf tool for avoid accounting the loads by the tool
+ * itself.
+ *
+ * It creates a child process context for the profiled program and the child
+ * process waits on pipe (go_pipe[0]).  The parent process will enable PMU
+ * events and notify the child process to proceed.
+ */
+static int prepare_workload(char **argv)
+{
+	int child_ready_pipe[2], go_pipe[2];
+	char bf;
+	int key = 0, fd;
+
+	if (pipe(child_ready_pipe) < 0) {
+		printf("Failed to create 'ready' pipe\n");
+		return -1;
+	}
+
+	if (pipe(go_pipe) < 0) {
+		printf("Failed to create 'go' pipe\n");
+		goto out_close_ready_pipe;
+	}
+
+	printf("Create process for the workload.\n");
+
+	pid = fork();
+	if (pid < 0) {
+		printf("Failed to fork child process\n");
+		goto out_close_pipes;
+	}
+
+	/* Child process */
+	if (!pid) {
+		int ret;
+
+		close(child_ready_pipe[0]);
+		close(go_pipe[1]);
+
+		fcntl(go_pipe[0], F_SETFD, FD_CLOEXEC);
+
+		/*
+		 * Tell the parent we're ready to go
+		 */
+		close(child_ready_pipe[1]);
+
+		/*
+		 * Wait until the parent tells us to go.
+		 */
+		ret = read(go_pipe[0], &bf, 1);
+		if (ret != 1) {
+			if (ret == -1)
+				printf("Unable to read go_pipe[0]\n");
+			exit(ret);
+		}
+
+		execvp(argv[0], (char **)argv);
+
+		/* Should not run to here */
+		exit(-1);
+	}
+
+	close(child_ready_pipe[1]);
+	close(go_pipe[0]);
+
+	/* Wait for child to settle */
+	if (read(child_ready_pipe[0], &bf, 1) == -1) {
+		printf("Unable to read ready pipe\n");
+		goto out_close_pipes;
+	}
+
+	fcntl(go_pipe[1], F_SETFD, FD_CLOEXEC);
+	cork_fd = go_pipe[1];
+	close(child_ready_pipe[0]);
+
+	fd = bpf_map__fd(skel->maps.task_filter);
+	/* Set task filter for only trace the target process */
+	assert(bpf_map_update_elem(fd, &key, &pid, BPF_ANY) == 0);
+	return 0;
+
+out_close_pipes:
+	close(go_pipe[0]);
+	close(go_pipe[1]);
+out_close_ready_pipe:
+	close(child_ready_pipe[0]);
+	close(child_ready_pipe[1]);
+	return -1;
+}
+
+static int run_workload(void)
+{
+	int ret, status;
+	char bf = 0;
+
+	if (cork_fd >= 0) {
+		/*
+		 * Remove the cork, let it rip!
+		 */
+		ret = write(cork_fd, &bf, 1);
+		close(cork_fd);
+		cork_fd = -1;
+
+		if (ret < 0) {
+			printf("Unable to write to cork pipe");
+			return ret;
+		}
+	}
+
+	waitpid(pid, &status, 0);
+	printf("Finished the workload.\n");
+
+	return 0;
+}
+
+static void disable_perf_event(void)
+{
+	if (pmu_fd < 0)
+		return;
+
+	ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE, 0);
+	close(pmu_fd);
+}
+
+static int enable_perf_event(void)
+{
+	int key = 0, fd;
+	struct perf_event_attr attr = {
+		.freq = 0,
+		.sample_period = SAMPLE_PERIOD,
+		.inherit = 0,
+		.type = PERF_TYPE_RAW,
+		.read_format = 0,
+		.sample_type = 0,
+		.enable_on_exec = 1,
+		.disabled = 1,
+	};
+
+	if (event) {
+		attr.type = PERF_TYPE_HARDWARE;
+		if (!strcmp(event, "cycles"))
+			attr.config = PERF_COUNT_HW_CPU_CYCLES;
+		else if (!strcmp(event, "instructions"))
+			attr.config = PERF_COUNT_HW_INSTRUCTIONS;
+		else if (!strcmp(event, "branches"))
+			attr.config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS;
+		else if (!strcmp(event, "branch-misses"))
+			attr.config = PERF_COUNT_HW_BRANCH_MISSES;
+		else
+			return -EINVAL;
+		printf("Enable the event %s.\n", event);
+	} else {
+		attr.type = PERF_TYPE_RAW;
+		attr.config = raw_event;
+		printf("Enable the raw event 0x%lx.\n", raw_event);
+	}
+
+	if (user_mode) {
+		attr.exclude_kernel = 1;
+		attr.exclude_hv = 1;
+	}
+
+	pmu_fd = sys_perf_event_open(&attr, pid, pmu_cpu, -1, 0);
+	if (pmu_fd < 0) {
+		printf("sys_perf_event_open failed: %d\n", pmu_fd);
+		return pmu_fd;
+	}
+
+	fd = bpf_map__fd(skel->maps.counters);
+	assert(bpf_map_update_elem(fd, &key, &pmu_fd, BPF_ANY) == 0);
+	return 0;
+}
+
+static int parse_opts(int argc, char **argv)
+{
+	int opt;
+
+	nr_cpus = libbpf_num_possible_cpus();
+
+	while ((opt = getopt(argc, argv, "c:f:e:r:x:uh")) != -1) {
+		switch (opt) {
+		case 'c':
+			pmu_cpu = atoi(optarg);
+			break;
+		case 'f':
+			func = optarg;
+			break;
+		case 'e':
+			event = optarg;
+			break;
+		case 'r':
+			raw_event = strtol(optarg, NULL, 16);
+			break;
+		case 'x':
+			executable = optarg;
+			break;
+		case 'u':
+			user_mode = true;
+			break;
+		case 'h':
+		default:
+			usage(argv[0]);
+			return -EINVAL;
+		}
+	}
+
+	if (pmu_cpu != -1 && (pmu_cpu < 0 || pmu_cpu >= nr_cpus)) {
+		printf("Target CPU %d is out-of-range [0..%d].\n",
+		       pmu_cpu, nr_cpus - 1);
+		return -EINVAL;
+	}
+
+	if (event && raw_event != -1) {
+		printf("Only one of event name or raw event can be enabled.\n");
+		return -EINVAL;
+	}
+
+	if (!event && raw_event == -1)
+		event = "cycles";
+
+	if (event) {
+		if (strcmp(event, "cycles") && strcmp(event, "instructions") &&
+		    strcmp(event, "branches") && strcmp(event, "branch-misses")) {
+			printf("Invalid event name: %s\n", event);
+			printf("Supported events: cycles/instructions/branches/branch-misses\n");
+			return -EOPNOTSUPP;
+		}
+	} else {
+		if (raw_event == LONG_MIN || raw_event == LONG_MAX) {
+			printf("Invalid raw event number: %ld\n", raw_event);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (func) {
+		if (!executable)
+			executable = argv[optind];
+
+		if (!executable) {
+			printf("Missed the executable path\n");
+			return -EINVAL;
+		}
+
+		if (!realpath(executable, exec_path)) {
+			printf("Unable to find the executable's absolute path.\n"
+			       "Use the '-x' option to specify it.\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int i;
+	struct bpf_link *links[4] = { NULL };
+	int error = 1;
+	LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	__u64 finish_task_switch_addr;
+	char *finish_task_switch_str = NULL;
+
+	if (parse_opts(argc, argv))
+		return 0;
+
+	/*
+	 * The kernel function "finish_task_switch" is an occasion for recording
+	 * a task scheduling out.  The compiler can perform interprocedural
+	 * scalar replacement (-fipa-sra) and the function can be altered (e.g.
+	 * "finish_task_switch.isra.0").  Search the kernel symbols to find out
+	 * the correct symbol name.
+	 */
+	if (!kallsyms_find("finish_task_switch", &finish_task_switch_addr)) {
+		finish_task_switch_str = "finish_task_switch";
+	} else if (!kallsyms_find("finish_task_switch.isra.0",
+				&finish_task_switch_addr)) {
+		finish_task_switch_str = "finish_task_switch.isra.0";
+	} else {
+		printf("Failed to find kernel symbol 'finish_task_switch'\n");
+		return -1;
+	}
+
+	signal(SIGINT, err_exit);
+	signal(SIGTERM, err_exit);
+
+	skel = trace_counter__open();
+	if (!skel) {
+		printf("Failed to open trace counter skeleton\n");
+		return -1;
+	}
+
+	bpf_map__set_max_entries(skel->maps.values_begin, nr_cpus);
+	bpf_map__set_max_entries(skel->maps.values, nr_cpus);
+
+	if (func)
+		skel->rodata->trace_mode = TRACE_MODE_FUNCTION;
+
+	if (trace_counter__load(skel)) {
+		printf("Failed to load trace counter skeleton\n");
+		goto cleanup;
+	}
+
+	/* Create a child process for profied program */
+	if (prepare_workload(&argv[optind]))
+		goto cleanup;
+
+	links[0] = bpf_program__attach(skel->progs.schedule_out);
+	if (libbpf_get_error(links[0])) {
+		printf("bpf_program__attach failed\n");
+		links[0] = NULL;
+		goto cleanup;
+	}
+
+	links[1] = bpf_program__attach_kprobe(skel->progs.schedule_in,
+					      true, finish_task_switch_str);
+	if (libbpf_get_error(links[1])) {
+		printf("bpf_program__attach_kprobe failed\n");
+		links[1] = NULL;
+		goto cleanup;
+	}
+
+	if (func) {
+		uprobe_opts.func_name = func;
+
+		uprobe_opts.retprobe = false;
+		links[2] = bpf_program__attach_uprobe_opts(skel->progs.func_begin,
+							   pid,
+							   exec_path,
+							   0 /* offset */,
+							   &uprobe_opts);
+		if (libbpf_get_error(links[2])) {
+			printf("Failed to attach func_begin uprobe\n");
+			links[2] = NULL;
+			goto cleanup;
+		}
+
+		uprobe_opts.retprobe = true;
+		links[3] = bpf_program__attach_uprobe_opts(skel->progs.func_exit,
+							   pid,
+							   exec_path,
+							   0 /* offset */,
+							   &uprobe_opts);
+		if (libbpf_get_error(links[3])) {
+			printf("Failed to attach func_exit uprobe\n");
+			links[3] = NULL;
+			goto cleanup;
+		}
+	}
+
+	/* Enable perf events */
+	if (enable_perf_event() < 0)
+		goto cleanup;
+
+	/* Excute the workload */
+	if (run_workload() < 0)
+		goto cleanup;
+
+	print_counter();
+	error = 0;
+
+cleanup:
+	/* Disable perf events */
+	disable_perf_event();
+
+	for (i = 0; i < ARRAY_SIZE(links); i++) {
+		if (!links[i])
+			continue;
+		bpf_link__destroy(links[i]);
+	}
+	trace_counter__destroy(skel);
+
+	err_exit(error);
+	return 0;
+}
-- 
2.34.1


