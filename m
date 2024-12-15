Return-Path: <bpf+bounces-47007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3595F9F25E8
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 20:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7731887311
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 19:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454E31CEE97;
	Sun, 15 Dec 2024 19:35:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F601CDA19;
	Sun, 15 Dec 2024 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734291339; cv=none; b=mYN3v/G2lHAExs6GwdfvNJgANDazY98yDwRQ3gDNS+RXoRl4lZQqZrY6znMulmQkmjGh/+HDAVBvHxDB/90Q6KDxFoeom2TLE06gcRxle184HB6TbxywBXngAmUtwIq6/c5zQT1U79LCVxI0s40BoBMzFlWdQRMPrPQ/x/Bg1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734291339; c=relaxed/simple;
	bh=Fd2GobHfEpLqdvdlqx0gZDYTPeJt7bpEiJ+djgTtVP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLRsucuekyImwa0Sb6w9GpnPaf8laOj96OCHXivg6nLPxWOVbkl8tQZCGALGS53f3oJX1+KlcQYZ8/5J0Hnmut9oSa/aTWj5CrFy8wHgHkSF4AYgnwhxI0gi0N29ObgiezJKJ+yOycaTwvCaOGRmzsBQNxasN7NtjyvcTaO+1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD3CC1A32;
	Sun, 15 Dec 2024 11:36:05 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3D203F528;
	Sun, 15 Dec 2024 11:35:33 -0800 (PST)
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
Subject: [PATCH v1 7/7] perf docs: Document AUX pause with BPF
Date: Sun, 15 Dec 2024 19:34:36 +0000
Message-Id: <20241215193436.275278-8-leo.yan@arm.com>
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

Documents the usage of the --bpf-aux-pause option and provides
examples.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/perf-record.txt | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 80686d590de2..25cf993b7a50 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -535,6 +535,46 @@ must be an AUX area event. Samples on other events will be created containing
 data from the AUX area. Optionally sample size may be specified, otherwise it
 defaults to 4KiB.
 
+--bpf-aux-pause=[=OPTIONS]::
+Specify trace events for triggering AUX pause with a BPF program. A trace event
+can be a kprobe, kretprobe or tracepoint. This option must be enabled in
+combination with the "aux-action=start-paused" configuration in an AUX event.
+
+For attaching a kprobe or kretprobe event, the format is:
+
+  {kprobe|kretprobe}:function_name:{p|r}
+
+For attaching a tracepoint, the format is:
+
+  {tp|tracepoint}:category:tracepint_name:{p|r}
+
+The first field is for the trace event type. It supports three types: kprobe,
+kretprobe, and tracepoint ('tp' is also supported as an abbreviation for
+"tracepoint"). The last field specifies whether the action is pause ("p") or
+resume ("r").
+
+For kprobe and kretprobe, the "function_name" field is for specifying a kernel
+function name. In the case of a tracepoint, the "category" and "tracepoint_name"
+fields are used together for providing complete tracepoint info.
+
+The '--bpf-aux-pause' option does not support inherit mode.  In the default
+trace mode or per-thread mode, it needs to be combined with the '-i' or
+'--no-inherit' option to disable inherit mode.
+
+The syntax supports multiple trace events, with each separated by a comma (,).
+For example, users can set up AUX pause on a kernel function with kretprobe and
+AUX resume on a tracepoint with the syntax below:
+
+  For default trace mode (with inherit mode disabled):
+  perf record -e cs_etm/aux-action=start-paused/ \
+  --bpf-aux-pause="kretprobe:__arm64_sys_openat:p,tp:sched:sched_switch:r" \
+  -i ...
+
+  For system wide trace mode:
+  perf record -e cs_etm/aux-action=start-paused/ \
+  --bpf-aux-pause="kretprobe:__arm64_sys_openat:p,tp:sched:sched_switch:r" \
+  -a ...
+
 --proc-map-timeout::
 When processing pre-existing threads /proc/XXX/mmap, it may take a long time,
 because the file may be huge. A time out is needed in such cases.
-- 
2.34.1


