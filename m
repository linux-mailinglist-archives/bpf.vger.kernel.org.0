Return-Path: <bpf+bounces-47000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 896DC9F25D7
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 20:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4641884FAA
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471B01BD014;
	Sun, 15 Dec 2024 19:35:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D45192B76;
	Sun, 15 Dec 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734291312; cv=none; b=mEyg3vCuQY8ZQbWPehhqBTRsrQQh2H/yn/rhD0Leu7yb8eOEafN3cfh3WrCQNzxino2+ktZ9WAHHoIXzNVnaXAwG6Z/p02/oiwipFP1sMLuvabgdmo0KlC0Cdwz1UQbn8997pq3GZGUtA4Uf2owYQpvL3uBkJJi92lsUK7kv0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734291312; c=relaxed/simple;
	bh=87K9r6v8CggY8AXvxKnWlvLGmM8yqRM96IkXyTCynEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XAGA5JI7M8WUgtxeN1FPCMcIjWqlYzGHVHS1m47/QHTGJdcTdf//cEzx0pvxNgQbD1STHPDNm8VU0pJsX3h5Xx1ld6303WbIJ7Hhy51GsmZ5KuqrxSvw1KdcCbNcVZJStr8ZwFuIklbgXcrpzDwTGN3aQ9VmeOxq4hAocGRk3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 701B71424;
	Sun, 15 Dec 2024 11:35:36 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 731A43F528;
	Sun, 15 Dec 2024 11:35:04 -0800 (PST)
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
Subject: [PATCH v1 0/7] perf auxtrace: Support AUX pause with BPF backend
Date: Sun, 15 Dec 2024 19:34:29 +0000
Message-Id: <20241215193436.275278-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends Perf's ability for fine-grained tracing by attaching
specific trace events to eBPF programs. As the first step, this series
supports kprobe, kretprobe, and tracepoints for dynamically pausing and
resuming AUX trace.

The first two patches expose a BPF API from kernel so the AUX pause and
resume can be invoked from a BPF kernel program.

Syncing UAPI headers between kernel and tools is finished in patch 03.

The main changes in the Perf tool for implementing eBPF skeleton
program, hooking BPF program in a perf record session, and attaching
trace events with BPF programs are finished in patches 04 ~ 06.

The patch 07 updates documentation for usage of the new introduced
option '--bpf-aux-pause'.

This series has been tested on TC platform with ETE / TRBE with
commands:

  perf record -e cs_etm/aux-action=start-paused/ \
  --bpf-aux-pause="kretprobe:__arm64_sys_openat:p,kprobe:__arm64_sys_openat:r,tp:sched:sched_switch:r" -a -- ls

  perf record -e cs_etm/aux-action=start-paused/ \
  --bpf-aux-pause="kretprobe:__arm64_sys_openat:p,kprobe:__arm64_sys_openat:r,tp:sched:sched_switch:r" -i -- ls

Note, as the AUX pause operation cannot be inherited by child tasks, it
requires to specify the '-i' option for default trace mode and
per-thread mode.


Leo Yan (7):
  perf/core: Make perf_event_aux_pause() as external function
  bpf: Add bpf_perf_event_aux_pause kfunc
  bpf: Sync bpf_perf_event_aux_pause in tools UAPI bpf.h
  perf: auxtrace: Introduce eBPF program for AUX pause
  perf: auxtrace: Support BPF backend for AUX pause
  perf record: Support AUX pause with BPF
  perf docs: Document AUX pause with BPF

 include/linux/perf_event.h                    |   1 +
 include/uapi/linux/bpf.h                      |  21 +
 kernel/bpf/verifier.c                         |   2 +
 kernel/events/core.c                          |   2 +-
 kernel/trace/bpf_trace.c                      |  52 +++
 tools/include/uapi/linux/bpf.h                |  21 +
 tools/perf/Documentation/perf-record.txt      |  40 ++
 tools/perf/Makefile.perf                      |   1 +
 tools/perf/builtin-record.c                   |  18 +-
 tools/perf/util/Build                         |   4 +
 tools/perf/util/auxtrace.h                    |  43 ++
 tools/perf/util/bpf_auxtrace_pause.c          | 385 ++++++++++++++++++
 tools/perf/util/bpf_skel/auxtrace_pause.bpf.c | 135 ++++++
 tools/perf/util/evsel.c                       |   6 +
 tools/perf/util/record.h                      |   1 +
 15 files changed, 730 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/bpf_auxtrace_pause.c
 create mode 100644 tools/perf/util/bpf_skel/auxtrace_pause.bpf.c

-- 
2.34.1


