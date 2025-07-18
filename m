Return-Path: <bpf+bounces-63727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C14B0A766
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 17:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA511C833A7
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8AE2E54DA;
	Fri, 18 Jul 2025 15:26:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D02E54BD;
	Fri, 18 Jul 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852363; cv=none; b=O+dq2LXpCCwYK2ER0TB1rQgo0BMedwJ4JzFLkZJfASV0LNaXCWFrDo0Qwlv/OmH3kODR8FFKkzRX08q0vnlSKXou34X9SGF3gk+iXg+EPT8iu6cj9tfkGcV9xkR+XI5LZm6nk+cONSCphUvsQyMDwSJcn9xl343wpr9pearrFig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852363; c=relaxed/simple;
	bh=L/zjElicyBquY6FNje7j0/5XPOZRjJinzZxw5ZTiPLw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pr35+V0qxlVeeubb9+T7696H9qKTXKM3znfquVoG2khrRg8bEm4AJ+MJ3UWil13infZQD2+JWuWzyuMu5LGmzaTljINp/LaJDAAvHBHcrxM9b25Zjbl21SnY6/dHOoXrmhXXUZVtoqCq3GBkmI/cqna9zXNgogO3UBjLCj5FJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8039C16A3;
	Fri, 18 Jul 2025 08:25:53 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C02823F6A8;
	Fri, 18 Jul 2025 08:25:56 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/6] perf auxtrace: Support AUX pause and resume with
 BPF
Date: Fri, 18 Jul 2025 16:25:34 +0100
Message-Id: <20250718-perf_aux_pause_resume_bpf_rebase-v2-0-992557b8fb16@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG5nemgC/x2NsQrCMBBAfyXcbCANlqCbuDg6uJUS7upFb7CGH
 CmF0n83uL23vLeBchFWOJsNCi+i8p2b+IOB6Y3zi608m4N3vnehCzZzSRHrGjNW5VhY64cj5dS
 QUNl24TiFEzlC6qFlcuEk638xwP3yuN7M4mHc9x/zaua2fAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752852356; l=3313;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=L/zjElicyBquY6FNje7j0/5XPOZRjJinzZxw5ZTiPLw=;
 b=nYbD7ZpIfxhu4FTCNxB0+kCewOUWhgYrUmxGvY03Rg/CeHbAPDZojVmLoLhTgh5tWOXagx5wp
 nvzi7Oim5A5DbMYOf9xwxJIoRJ49PgIG3WY4g6AyQ/VDB/iavw/Zq8Z
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

Changes in v2:
- Changed to use BPF kfunc and dropped uAPI (Yonghong).
- Added support uprobe/uretprobe.
- Refined the syntax for trigger points (mainly for trigger action {p:r}).
- Fixed a bug in the BPF program with passing wrong flag.
- Rebased on bpf-next branch.
- Link to v1: https://lore.kernel.org/linux-perf-users/20241215193436.275278-1-leo.yan@arm.com/T/#m10ea3e66bca7418db07c141a14217934f36e3bc8

Signed-off-by: Leo Yan <leo.yan@arm.com>
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
 kernel/trace/bpf_trace.c                      |  60 ++++
 tools/perf/Documentation/perf-record.txt      |  51 ++++
 tools/perf/Makefile.perf                      |   1 +
 tools/perf/builtin-record.c                   |  20 +-
 tools/perf/util/Build                         |   4 +
 tools/perf/util/auxtrace.h                    |  43 +++
 tools/perf/util/bpf_auxtrace_pause.c          | 408 ++++++++++++++++++++++++++
 tools/perf/util/bpf_skel/auxtrace_pause.bpf.c | 156 ++++++++++
 tools/perf/util/evsel.c                       |   6 +
 tools/perf/util/record.h                      |   1 +
 12 files changed, 751 insertions(+), 2 deletions(-)
---
base-commit: 0768e980feb5cffe63920d375bebef3bb4654961
change-id: 20250717-perf_aux_pause_resume_bpf_rebase-174c79b0bab5

Best regards,
-- 
Leo Yan <leo.yan@arm.com>


