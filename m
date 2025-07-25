Return-Path: <bpf+bounces-64346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABFDB11B6D
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7CB5A3AB2
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5542DE709;
	Fri, 25 Jul 2025 09:59:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043FA2D375D;
	Fri, 25 Jul 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437595; cv=none; b=eKSZK9ewrLXBLGqxxmwBPwg5c73CqnDU9kocfp7rz+KH0JTXJrU0qulzoiu7RgRs9e7yucsOhlGkpzkaghDH5FEZZ7W21/v8a+cHjIaEWTQNm3GyfBOsWKbqpFzPD3BO6HOUOI/wzOTLSYZcsfbaRTzqKk9HHRSlwXjuiqPIJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437595; c=relaxed/simple;
	bh=+3gjGeeKe7DyZ3/goDLLn+ZLf1jbvy7KWHPofuCLFbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOZUPnGuVQrXdmI0wOdVe+uitM10rUcSfCJunsi60B7g4CTvyfi/w1pLk5JKfLtojqFCspemCn0gXBiyyUMGALOXTGmz2Gs1BkLTfPdq/Aw1K8yqD5mGVDLiepZfybK8MhF+zlN/kkmaJmM7WLCZmD+dnqk4WR8hslnELedk4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99BA6176C;
	Fri, 25 Jul 2025 02:59:46 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 623723F5A1;
	Fri, 25 Jul 2025 02:59:49 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 25 Jul 2025 10:59:15 +0100
Subject: [PATCH PATCH v2 v3 6/6] perf docs: Document AUX pause and resume
 with BPF
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-perf_aux_pause_resume_bpf_rebase-v3-6-9fc84c0f4b3a@arm.com>
References: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>
In-Reply-To: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753437563; l=3165;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=+3gjGeeKe7DyZ3/goDLLn+ZLf1jbvy7KWHPofuCLFbE=;
 b=YZ1S6Xoav56pMejraXEEdJ6z6iYmHtig2FFXReV2g8kwgTJFMV1s33x61Zo+WUvJxzlYQuKYf
 k6MBoxmqGrgDF3E/UM3KSyUGdGEoZooxShRtmAM5G1qotRqgSg/AONW
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Documents the usage of the --bpf-aux-pause option and provides
examples.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/perf-record.txt | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 612612fa2d8041b94860035ed9cb01557a20b6b7..5aee20bfd03bda72bddabf42005b9678309414ad 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -544,6 +544,57 @@ must be an AUX area event. Samples on other events will be created containing
 data from the AUX area. Optionally sample size may be specified, otherwise it
 defaults to 4KiB.
 
+--bpf-aux-pause=[=OPTIONS]::
+Specify trace events for triggering AUX pause with a BPF program. A trace event
+can be static ftrace tracepoint, or dynamic tracepoint by using kprobe,
+kretprobe, uprobe or uretprobe. This option must be enabled in combination with
+the "aux-action=start-paused" configuration in an AUX event.
+
+For attaching a kprobe or kretprobe event, the format is:
+
+  {kprobe|kretprobe}:{p|r}:function_name
+
+The format for attaching a uprobe or uretprobe event is:
+
+  {uprobe|uretprobe}:{p|r}:executable:function_name
+
+The format for attaching a tracepoint is:
+
+  {tp|tracepoint}:{p|r}:category:tracepint
+
+The first field is for the trace event type. It supports five types: kprobe,
+kretprobe, uprobe, uretprobe, and tracepoint ('tp' is also supported as an
+abbreviation for "tracepoint"). The second field specifies whether the action is
+pause ("p") or resume ("r").
+
+For probes, the "function_name" field is used to specify a function name. In
+particular, for a uprobe or uretprobe, an executable path must also be provided.
+In the case of a ftrace tracepoint, the "category" and "tracepoint" fields are
+used together to provide complete tracepoint information.
+
+The '--bpf-aux-pause' option does not support inherit mode.  In the default
+trace mode, it needs to be combined with the '-i' or '--no-inherit' option to
+disable inherit mode.
+
+The syntax supports multiple trace events, with each separated by a comma (,).
+For example, users can set up AUX pause on a kernel function with kretprobe and
+AUX resume on a tracepoint with the syntax below:
+
+  For default trace mode (with inherit mode disabled):
+  perf record -e cs_etm/aux-action=start-paused/ \
+    --bpf-aux-pause="kretprobe:p:__arm64_sys_openat,tp:r:sched:sched_switch" \
+    -i ...
+
+  For system wide trace mode:
+  perf record -e cs_etm/aux-action=start-paused/ \
+    --bpf-aux-pause="kretprobe:p:__arm64_sys_openat,tp:r:sched:sched_switch" \
+    -a ...
+
+  For trace with uprobe and uretprobe:
+  perf record -e cs_etm/aux-action=start-paused/ \
+    --bpf-aux-pause="uretprobe:p:~/sort:bubble_sort,uprobe:r:~/sort:bubble_sort" \
+    -i --per-thread -- ~/sort
+
 --proc-map-timeout::
 When processing pre-existing threads /proc/XXX/mmap, it may take a long time,
 because the file may be huge. A time out is needed in such cases.

-- 
2.34.1


