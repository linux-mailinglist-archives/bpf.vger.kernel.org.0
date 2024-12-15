Return-Path: <bpf+bounces-47005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BF59F25E2
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 20:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368D8163AE3
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 19:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C71CD1FD;
	Sun, 15 Dec 2024 19:35:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E671C5F26;
	Sun, 15 Dec 2024 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734291332; cv=none; b=hJY21EFSGv0LwtklVw/8Q1Ud2y0L/mZehoL6geweiW24V74KY6VF5UV6Px9RXneF1nWdQr8aE8ucyr7a1Ech+rMXTqtSXAuy4P6UFjKumgoPW1qDhmOWOUQQ3ugi9r9gX5kx7ZrkknsGux33S9YOgG+l3VKUdkz8ioiP7iyMVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734291332; c=relaxed/simple;
	bh=ptjmWEYOm+xcUkfP0DGHAlS4eLnm7TtJ20akihWGW/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nByDPYSBXc8DWWTtgW+2Cz1tIUM9voAxILlYz5v9mepB7RUOp5IHFg5QCsozGMAl3nRyf0GlMv42z5rmnqQFlfM8JJWsIzbRpToaafUggpx/neywNmS/qxhTZr87mEjH987xaVtrN+drN9LePRT7jn/tOgoorfHQPeGzP5mxzKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57D451A25;
	Sun, 15 Dec 2024 11:35:57 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D97F3F528;
	Sun, 15 Dec 2024 11:35:25 -0800 (PST)
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
Subject: [PATCH v1 5/7] perf: auxtrace: Support BPF backend for AUX pause
Date: Sun, 15 Dec 2024 19:34:34 +0000
Message-Id: <20241215193436.275278-6-leo.yan@arm.com>
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

This commit support BPF backend for AUX pause.

It uses a list to maintain the trigger points for AUX pause and resume.
The trigger points (e.g. kprobe, tracepoints) will be attached to BPF
programs based on the trigger type.

It also provides an API auxtrace__update_bpf_map() for updating perf AUX
event into the BPF map.  The information will be used afterwards by BPF
program in kernel to fetch the event handler for controlling AUX trace.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/Build                |   4 +
 tools/perf/util/auxtrace.h           |  43 +++
 tools/perf/util/bpf_auxtrace_pause.c | 385 +++++++++++++++++++++++++++
 3 files changed, 432 insertions(+)
 create mode 100644 tools/perf/util/bpf_auxtrace_pause.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c06d2ee9024c..adb6d8b11e4c 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -178,6 +178,10 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
   perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork_top.o
 endif
 
+ifeq ($(CONFIG_AUXTRACE),y)
+  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_auxtrace_pause.o
+endif
+
 perf-util-$(CONFIG_LIBELF) += symbol-elf.o
 perf-util-$(CONFIG_LIBELF) += probe-file.o
 perf-util-$(CONFIG_LIBELF) += probe-event.o
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index b0db84d27b25..52831e501dea 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -907,4 +907,47 @@ void itrace_synth_opts__clear_time_range(struct itrace_synth_opts *opts
 
 #endif
 
+#if defined(HAVE_AUXTRACE_SUPPORT) && defined(HAVE_BPF_SKEL)
+
+int auxtrace__prepare_bpf(struct auxtrace_record *itr, const char *str);
+int auxtrace__set_bpf_filter(struct evlist *evlist, struct record_opts *opts);
+int auxtrace__enable_bpf(void);
+int auxtrace__cleanup_bpf(void);
+int auxtrace__update_bpf_map(struct evsel *evsel, int cpu_map_idx, int fd);
+
+#else	/* HAVE_AUXTRACE_SUPPORT && HAVE_BPF_SKEL */
+
+static inline int auxtrace__prepare_bpf(struct auxtrace_record *itr
+					__maybe_unused,
+					const char *str __maybe_unused)
+{
+	return -EINVAL;
+}
+
+static inline int auxtrace__set_bpf_filter(struct evlist *evlist __maybe_unused,
+					   struct record_opts *opts
+					   __maybe_unused)
+{
+	return -EINVAL;
+}
+
+static inline int auxtrace__enable_bpf(void)
+{
+	return -EINVAL;
+}
+
+static inline int auxtrace__cleanup_bpf(void)
+{
+	return -EINVAL;
+}
+
+static int auxtrace__update_bpf_map(struct evsel *evsel __maybe_unused,
+				    int cpu_map_idx __maybe_unused,
+				    int fd __maybe_unused)
+{
+	return -EINVAL;
+}
+
+#endif
+
 #endif
diff --git a/tools/perf/util/bpf_auxtrace_pause.c b/tools/perf/util/bpf_auxtrace_pause.c
new file mode 100644
index 000000000000..1012e0d62dbc
--- /dev/null
+++ b/tools/perf/util/bpf_auxtrace_pause.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright 2024 Arm Limited */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+#include <linux/err.h>
+
+#include "util/auxtrace.h"
+#include "util/cpumap.h"
+#include "util/thread_map.h"
+#include "util/debug.h"
+#include "util/evlist.h"
+#include "util/bpf_counter.h"
+#include "util/record.h"
+#include "util/target.h"
+
+#include "util/bpf_skel/auxtrace_pause.skel.h"
+
+/* The valid controlling type is "p" (pause) and "r" (resume) */
+#define is_attach_kprobe(str)		\
+	(!strcmp((str), "kprobe") || !strcmp((str), "kretprobe"))
+#define is_attach_tracepoint(str)	\
+	(!strcmp((str), "tp") || !strcmp((str), "tracepoint"))
+
+/* The valid controlling type is "p" (pause) and "r" (resume) */
+#define is_valid_ctrl_type(str)	\
+	(!strcmp((str), "p") || !strcmp((str), "r"))
+
+static struct auxtrace_pause_bpf *skel;
+
+struct trigger_entry {
+	struct list_head list;
+	char *arg0;
+	char *arg1;
+	char *arg2;
+	char *arg3;
+};
+
+static int trigger_entry_num;
+static LIST_HEAD(trigger_list);
+static struct bpf_link **trigger_links;
+
+static void auxtrace__free_bpf_trigger_list(void)
+{
+	struct trigger_entry *entry, *next;
+
+	list_for_each_entry_safe(entry, next, &trigger_list, list) {
+		free(entry->arg0);
+		free(entry->arg1);
+		free(entry->arg2);
+		free(entry->arg3);
+		free(entry);
+	}
+
+	trigger_entry_num = 0;
+}
+
+static int auxtrace__alloc_bpf_trigger_list(const char *str)
+{
+	char *cmd_str;
+	char *substr, *saveptr1;
+	struct trigger_entry *entry;
+	int ret = 0;
+
+	if (!str)
+		return -EINVAL;
+
+	cmd_str = strdup(str);
+	if (!cmd_str)
+		return -ENOMEM;
+
+	substr = strtok_r(cmd_str, ",", &saveptr1);
+	for ( ; substr != NULL; substr = strtok_r(NULL, ",", &saveptr1)) {
+		char *fmt1_str, *fmt2_str, *fmt3_str, *fmt4_str, *fmt;
+
+		entry = zalloc(sizeof(*entry));
+		if (!entry) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		/*
+		 * A trigger is expressed with several fields with separator ":".
+		 * The first field is specified for attach types, it can be one
+		 * of types listed below:
+		 *   kprobe
+		 *   kretprobe
+		 *   tp
+		 *   tracepoint
+		 *
+		 * Kprobe and kretprobe use the second field to express the
+		 * probe point. So far, it only support a simple expression with
+		 * kernel function name.  Kprobe/kretprobe trigger format is:
+		 *   {kprobe|kretprobe}:function_name:{p|r}
+		 *
+		 * Tracepoint use the second field for the trace category and
+		 * the third field for the tracepoint name.  Tracepoint trigger
+		 * format is:
+		 *   {tp|tracepoint}:category:tracepint_name:{p|r}
+		 *
+		 * The last field is used to express the controlling type: "p"
+		 * means aux pause and "r" is for aux resume.
+		 */
+		fmt1_str = strtok_r(substr, ":", &fmt);
+		fmt2_str = strtok_r(NULL, ":", &fmt);
+		fmt3_str = strtok_r(NULL, ":", &fmt);
+		if (!fmt1_str || !fmt2_str || !fmt3_str) {
+			pr_err("Failed to parse bpf aux pause string: %s\n",
+				substr);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		entry->arg0 = strdup(fmt1_str);
+		entry->arg1 = strdup(fmt2_str);
+		entry->arg2 = strdup(fmt3_str);
+		if (!entry->arg0 || !entry->arg1 || !entry->arg2) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		if (!is_attach_kprobe(entry->arg0) &&
+		    !is_attach_tracepoint(entry->arg0)) {
+			pr_err("Failed to support bpf aux pause attach: %s\n",
+			       entry->arg0);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (is_attach_kprobe(entry->arg0)) {
+			if (!is_valid_ctrl_type(entry->arg2)) {
+				pr_err("Failed to support bpf aux pause ctrl: %s\n",
+				       entry->arg2);
+				ret = -EINVAL;
+				goto out;
+			}
+		} else {
+			fmt4_str = strtok_r(NULL, ":", &fmt);
+			if (!fmt4_str) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			entry->arg3 = strdup(fmt4_str);
+			if (!entry->arg3) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			if (!is_valid_ctrl_type(entry->arg3)) {
+				pr_err("Failed to support bpf aux pause ctrl: %s\n",
+				       entry->arg3);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+
+		if (ret)
+			goto out;
+
+		list_add(&entry->list, &trigger_list);
+		trigger_entry_num++;
+	}
+
+	free(cmd_str);
+	return 0;
+
+out:
+	free(cmd_str);
+	if (entry) {
+		free(entry->arg0);
+		free(entry->arg1);
+		free(entry->arg2);
+		free(entry->arg3);
+		free(entry);
+	}
+	auxtrace__free_bpf_trigger_list();
+	return ret;
+}
+
+int auxtrace__prepare_bpf(struct auxtrace_record *itr, const char *str)
+{
+	int ret;
+
+	if (!itr || !str)
+		return 0;
+
+	skel = auxtrace_pause_bpf__open();
+	if (!skel) {
+		pr_err("Failed to open func latency skeleton\n");
+		return -1;
+	}
+
+	ret = auxtrace__alloc_bpf_trigger_list(str);
+	if (ret) {
+		auxtrace_pause_bpf__destroy(skel);
+		skel = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct bpf_link *auxtrace__attach_bpf_prog(struct trigger_entry *entry)
+{
+	struct bpf_link *link = NULL;
+
+	if (!strcmp(entry->arg0, "kprobe")) {
+		if (!strcmp(entry->arg2, "p")) {
+			link = bpf_program__attach_kprobe(
+					skel->progs.kprobe_event_pause,
+					false, entry->arg1);
+		} else if (!strcmp(entry->arg2, "r")) {
+			link = bpf_program__attach_kprobe(
+					skel->progs.kprobe_event_resume,
+					false, entry->arg1);
+		}
+	} else if (!strcmp(entry->arg0, "kretprobe")) {
+		if (!strcmp(entry->arg2, "p")) {
+			link = bpf_program__attach_kprobe(
+					skel->progs.kretprobe_event_pause,
+					true, entry->arg1);
+		} else if (!strcmp(entry->arg2, "r")) {
+			link = bpf_program__attach_kprobe(
+					skel->progs.kretprobe_event_resume,
+					true, entry->arg1);
+		}
+	} else if (is_attach_tracepoint(entry->arg0)) {
+		if (!strcmp(entry->arg3, "p")) {
+			link = bpf_program__attach_tracepoint(
+					skel->progs.tp_event_pause,
+					entry->arg1, entry->arg2);
+		} else if (!strcmp(entry->arg3, "r")) {
+			link = bpf_program__attach_tracepoint(
+					skel->progs.tp_event_resume,
+					entry->arg1, entry->arg2);
+		}
+	}
+
+	return link;
+}
+
+int auxtrace__set_bpf_filter(struct evlist *evlist, struct record_opts *opts)
+{
+	int fd, err;
+	int i, ncpus = 1, ntasks = 1;
+	struct trigger_entry *trigger_entry;
+	struct target *target;
+
+	if (!skel)
+		return 0;
+
+	if (!opts)
+		return -EINVAL;
+
+	target = &opts->target;
+
+	if (target__has_cpu(target)) {
+		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
+		bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
+		skel->rodata->has_cpu = 1;
+	}
+
+	if (target__has_task(target) || target__none(target)) {
+		ntasks = perf_thread_map__nr(evlist->core.threads);
+		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
+		skel->rodata->has_task = 1;
+	}
+
+	bpf_map__set_max_entries(skel->maps.events, libbpf_num_possible_cpus());
+
+	err = auxtrace_pause_bpf__load(skel);
+	if (err) {
+		pr_err("Failed to load func latency skeleton: %d\n", err);
+		goto out;
+	}
+
+	if (target__has_cpu(target)) {
+		u32 cpu;
+		u8 val = 1;
+
+		fd = bpf_map__fd(skel->maps.cpu_filter);
+
+		for (i = 0; i < ncpus; i++) {
+			cpu = perf_cpu_map__cpu(evlist->core.user_requested_cpus, i).cpu;
+			bpf_map_update_elem(fd, &cpu, &val, BPF_ANY);
+		}
+	}
+
+	if (target__has_task(target) || target__none(target)) {
+		u32 pid;
+		u8 val = 1;
+
+		fd = bpf_map__fd(skel->maps.task_filter);
+
+		for (i = 0; i < ntasks; i++) {
+			pid = perf_thread_map__pid(evlist->core.threads, i);
+			bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
+		}
+	}
+
+	trigger_links = zalloc(sizeof(*trigger_links) * trigger_entry_num);
+	if (!trigger_links)
+		return -ENOMEM;
+
+	i = 0;
+	list_for_each_entry(trigger_entry, &trigger_list, list) {
+		trigger_links[i] = auxtrace__attach_bpf_prog(trigger_entry);
+		err = libbpf_get_error(trigger_links[i]);
+		if (err) {
+			pr_err("Failed to attach bpf program to aux pause entry\n");
+			pr_err("  arg0=%s arg1=%s arg2=%s arg3=%s\n",
+			       trigger_entry->arg0, trigger_entry->arg1,
+			       trigger_entry->arg2, trigger_entry->arg3);
+			trigger_links[i] = NULL;
+			goto out;
+		}
+		i++;
+	}
+
+	return 0;
+
+out:
+	for (i = 0; i < trigger_entry_num; i++) {
+		if (!trigger_links[i])
+			continue;
+		bpf_link__destroy(trigger_links[i]);
+	}
+
+	return err;
+}
+
+int auxtrace__enable_bpf(void)
+{
+	if (!skel)
+		return 0;
+
+	skel->bss->enabled = 1;
+	return 0;
+}
+
+int auxtrace__cleanup_bpf(void)
+{
+	int i;
+
+	if (!skel)
+		return 0;
+
+	for (i = 0; i < trigger_entry_num; i++) {
+		if (!trigger_links[i])
+			continue;
+		bpf_link__destroy(trigger_links[i]);
+	}
+
+	auxtrace__free_bpf_trigger_list();
+	auxtrace_pause_bpf__destroy(skel);
+	return 0;
+}
+
+int auxtrace__update_bpf_map(struct evsel *evsel, int cpu_map_idx, int fd)
+{
+	int ret;
+
+	if (!skel)
+		return 0;
+
+	if (!evsel__is_aux_event(evsel))
+		return 0;
+
+	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.events),
+				  &cpu_map_idx, &fd, BPF_ANY);
+	if (ret) {
+		pr_err("Failed to update BPF map for auxtrace: %s.\n",
+			strerror(errno));
+		if (errno == EOPNOTSUPP)
+			pr_err("  Try to disable inherit mode with option '-i'.\n");
+		return ret;
+	}
+
+	return 0;
+}
-- 
2.34.1


