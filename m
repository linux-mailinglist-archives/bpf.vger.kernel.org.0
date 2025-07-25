Return-Path: <bpf+bounces-64349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD47B11BD1
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E02317F8C2
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A972E765D;
	Fri, 25 Jul 2025 10:08:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9C62D77F1;
	Fri, 25 Jul 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438111; cv=none; b=a15dHwqBc5ToIFLILTRQx3d1wseWaI2RRvVzxCTb/IP5b7NR8v6m2Bm8RW09e6kJ2yGaK67+girjyPoguY9iMi5D+dgD9/W4Ds9eXkRFq4p4lNaqgrfQx2Pnw8U8uSdnphL115utgDYaWX2paXu9wY02YQqhHvVVQh5QaKnlpaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438111; c=relaxed/simple;
	bh=1WMiJWKF/kFU4nJJ9ht2tF6BzE/oWPQGO6AQ2yKPdOI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bz0xJCHdGMraEnwt6XMZv7ZVw5biTC3rOxj1xeO9UZrqFrjqeArFuizR7PhVg0z7o3JUlZ4o0/Hm2XmYBY/MIt94Xsva8qs/436UjcjY/xsHZFCiL3buvqjdnzXk2Pt/4yZgvLBZ0AC8KjRo41rd8NdteKFdJQNMZt+5cgLmKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9112176C;
	Fri, 25 Jul 2025 03:08:20 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F1983F5A1;
	Fri, 25 Jul 2025 03:08:23 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH RESEND v3 0/6] perf auxtrace: Support AUX pause and resume
 with BPF
Date: Fri, 25 Jul 2025 11:08:10 +0100
Message-Id: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-ae21deb49d1a@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIpXg2gC/43Nuw7CIBSA4VdpmMVQWqR1crCrg47GEMCDZeglY
 ElN03cXGxPddDuX5Psn5MFZ8GibTMhBsN52bVyyVYJ0LdsbYHuNO6KEMsJTjntwRshhFL0cPAg
 HfmhAqN7EUUkPOOW55qUiSiqGItM7MHZcEmd0rE7VYY8u8V5bf+/cYykHunzfkeJ3JFBMcFlSx
 rgqjEo3O+mate6ahQ7ZF0fZH1z24owuck1MrjL54eZ5fgLcMm3/JQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753438103; l=3470;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=1WMiJWKF/kFU4nJJ9ht2tF6BzE/oWPQGO6AQ2yKPdOI=;
 b=rF4svKFjyPiSlgKl42+qw3TqTmdvdkyIRNHjxZM1KOtCynFK/ni17d/jVhPy5n8QTVMNpJF4e
 DlIXghoCV1rDuh4A9laxYZ8DWs+uXtvAcHGaL89UcZU0of6ARQqeK57
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


