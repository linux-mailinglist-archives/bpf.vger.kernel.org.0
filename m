Return-Path: <bpf+bounces-64340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D678B11B5B
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 11:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63EAF1C24909
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A162D46AF;
	Fri, 25 Jul 2025 09:59:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139B423908B;
	Fri, 25 Jul 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437571; cv=none; b=i7ZJTXhBgaYKr4hh/fzLltH2fc63ab/buKBvU+eJG0hXzrYNv6uL9K7IZPE2XeMg2mksUNf1YM6swy1CwahvC373RXrywJaUtxsq1oRyncamYBePWSyrnydKF3w1qcTZwXTWXafswphhfbrgfIbRG3uK7JYxYgwiKt4SlH1fWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437571; c=relaxed/simple;
	bh=1WMiJWKF/kFU4nJJ9ht2tF6BzE/oWPQGO6AQ2yKPdOI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ifkidVJ7dQfZa/5XieaQZDqjdUWwFgydk5Ky34Dr+f+URmI2OSRd1TDz694YqSPVSTwVfblE4W7VzEn18Fad3Zb1CFAZCp4Il2mxUJ7FPbMnW02ZzjqBDfkP50Dcjk3eD8+rMq6nqCr0nvASTQhJjTOLEmKfj+dUXI+UC5raHzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50608176C;
	Fri, 25 Jul 2025 02:59:21 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 153543F5A1;
	Fri, 25 Jul 2025 02:59:23 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 0/6] perf auxtrace: Support AUX pause and resume with
 BPF
Date: Fri, 25 Jul 2025 10:59:09 +0100
Message-Id: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG1Vg2gC/4WNsQ6CMBRFf4W82ZpSrRUnjYujg5shTYuv0gFoX
 oVgCP9uJe5u996T3DNBRPIY4ZBNQDj46Ls2lc0qg6o27ROZf6QOggvJVa5YQHLa9KMOpo+oCWP
 foLbBpWhNRJarbaUKy62xEtJNIHR+XBR3uJ5u50s2CCgTqX18dfRe3Gn68p9m/18zCMZZUQgpl
 d07m++Ohpp11TVQzvP8Ac5V7rXYAAAA
X-Change-ID: 20250717-perf_aux_pause_resume_bpf_rebase-174c79b0bab5
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753437563; l=3470;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=1WMiJWKF/kFU4nJJ9ht2tF6BzE/oWPQGO6AQ2yKPdOI=;
 b=WkyuFOx5mkoyPRKu7qgtoWxE/7mhkYVVYhrKowVD/tLs8C0rwDxaIdSNO5YtRMigXUSW2HYhO
 2W6WQohlgS4Aq024qdzPBITCZZM6ASseZWXkAdYuoLzoRyN58VYl1cZ
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series extends Perf for fine-grained tracing by using BPF program
to pause and resume AUX tracing. The BPF program can be attached to
tracepoints (including ftrace tracepoints and dynamic tracepoints, like
kprobe, kretprobe, uprobe and uretprobe).

The first two patches are changes in kernel - it adds a bpf kfunc which
can be invoked from BPF program.

The Perf tool implements BPF skeleton program, hooks BPF program into a
perf record session. This is finished by patches 03 ~ 05.

The patch 06 updates documentation for usage of the new introduced
option '--bpf-aux-pause'.

This series has been tested on Hikey960 platform with commands:

  perf record -e cs_etm/aux-action=start-paused/ \
    --bpf-aux-pause="kretprobe:p:__arm64_sys_openat,kprobe:r:__arm64_sys_openat,tp:r:sched:sched_switch" \
    -a -- ls

  perf record -e cs_etm/aux-action=start-paused/ \
    --bpf-aux-pause="kretprobe:p:__arm64_sys_openat,kprobe:r:__arm64_sys_openat,tp:r:sched:sched_switch" \
    -i -- ls

  perf record -e cs_etm/aux-action=start-paused/ \
    --bpf-aux-pause="uretprobe:p:/mnt/sort:bubble_sort,uprobe:r:/mnt/sort:bubble_sort" \
    --per-thread -- /mnt/sort

Note, as the AUX pause operation cannot be inherited by child tasks, it
requires to specify the '-i' option for default mode. Otherwise, the
tool reports an error to remind user to disable inherited mode:

  Failed to update BPF map for auxtrace: Operation not supported.
    Try to disable inherit mode with option '-i'.

Changes in v3:
- Added check "map->type" (Eduard)
- Fixed kfunc with guard(irqsave).
- Link to v2: https://lore.kernel.org/r/20250718-perf_aux_pause_resume_bpf_rebase-v2-0-992557b8fb16@arm.com

Changes in v2:
- Changed to use BPF kfunc and dropped uAPI (Yonghong).
- Added support uprobe/uretprobe.
- Refined the syntax for trigger points (mainly for trigger action {p:r}).
- Fixed a bug in the BPF program with passing wrong flag.
- Rebased on bpf-next branch.
- Link to v1: https://lore.kernel.org/linux-perf-users/20241215193436.275278-1-leo.yan@arm.com/T/#m10ea3e66bca7418db07c141a14217934f36e3bc8

---
Leo Yan (6):
      perf/core: Make perf_event_aux_pause() as external function
      bpf: Add bpf_perf_event_aux_pause kfunc
      perf: auxtrace: Control AUX pause and resume with BPF
      perf: auxtrace: Add BPF userspace program for AUX pause and resume
      perf record: Support AUX pause and resume with BPF
      perf docs: Document AUX pause and resume with BPF

 include/linux/perf_event.h                    |   1 +
 kernel/events/core.c                          |   2 +-
 kernel/trace/bpf_trace.c                      |  55 ++++
 tools/perf/Documentation/perf-record.txt      |  51 ++++
 tools/perf/Makefile.perf                      |   1 +
 tools/perf/builtin-record.c                   |  20 +-
 tools/perf/util/Build                         |   4 +
 tools/perf/util/auxtrace.h                    |  43 +++
 tools/perf/util/bpf_auxtrace_pause.c          | 408 ++++++++++++++++++++++++++
 tools/perf/util/bpf_skel/auxtrace_pause.bpf.c | 156 ++++++++++
 tools/perf/util/evsel.c                       |   6 +
 tools/perf/util/record.h                      |   1 +
 12 files changed, 746 insertions(+), 2 deletions(-)
---
base-commit: 95993dc3039e29dabb9a50d074145d4cb757b08b
change-id: 20250717-perf_aux_pause_resume_bpf_rebase-174c79b0bab5

Best regards,
-- 
Leo Yan <leo.yan@arm.com>


