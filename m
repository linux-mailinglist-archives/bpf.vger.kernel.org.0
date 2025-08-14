Return-Path: <bpf+bounces-65609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE9B25CE9
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 09:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63169E0C3A
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 07:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51B26AABE;
	Thu, 14 Aug 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeDjDgSo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB1D2690D9;
	Thu, 14 Aug 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155877; cv=none; b=tizHmc9lwcB+vGIO57YdXzOySWmjaw1TPMaWZlJcVGtWsi/jmkDg13LffIGlUvwc4p79Uf4YToxxClJAzzNQfDKtcHIq0vuuXuEZtBNaztv4NTYnDBOKhKmDTrECzmWJ3OzZVhWAXXLtNtv9Kc1+Y0OVmWSswp0J0g58wUY2WmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155877; c=relaxed/simple;
	bh=K94ORhqnl3c2smJSX8vrfd6Auv3Vej1J3NFaxf1as9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1bI2xeN5zqq1aUVdhMZtljx2ml78dkyGs4ofudQak44vO9ludEnWQuPiV1Dp7geMeiAppaNhrc8vxYR+bj5wrecdpfJ4dSUest6lk4boDp/pyjleK16eWmFX2YI9rIZigb/yv08ViS5s78NuMCyFPVJTuPSxaiANfK0MzTzY/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeDjDgSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DBBC4CEF5;
	Thu, 14 Aug 2025 07:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755155876;
	bh=K94ORhqnl3c2smJSX8vrfd6Auv3Vej1J3NFaxf1as9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UeDjDgSops4QH8fr5ivvWjkt+XOxRVMZcOMF3yosBOIRBsgEHyvJ3v82gk0yreYml
	 deLgLt45Td/WAayt+kl+mO+jBSLSMwnd+jkgFkbJ6CYQ4vJcYjWCxz8VwiHYzhy2st
	 ZgO7deSTJnZsB7cWV13j6PvZjxCco9rwfSXt+rFQJ0IclsFOidfx060o2vF2dWRzc8
	 gK/XwNDSZvmTXUXNnI1usgMj1Geyy5H1CHlb6RxNBQIicVRcYaMaZZXkB8SVeVDBKV
	 Vi5tzV9JUT77A/xfBZjCBM1TspQ/dYVHiTHRQe/6a9Cu/zb8hRSmckv6cisqs4+T0s
	 kK/LUPakYMQZw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH 2/5] perf trace: Split unaugmented sys_exit program
Date: Thu, 14 Aug 2025 00:17:51 -0700
Message-ID: <20250814071754.193265-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
In-Reply-To: <20250814071754.193265-1-namhyung@kernel.org>
References: <20250814071754.193265-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to handle syscall exit path differently so let's split the
unaugmented exit BPF program.  Currently it does nothing (same as
sys_enter).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c                            |  8 +++++---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c |  8 +++++++-
 tools/perf/util/bpf_trace_augment.c                   |  9 +++++++--
 tools/perf/util/trace_augment.h                       | 10 ++++++++--
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fe737b3ac6e67d3b..1bc912273af2db66 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3770,13 +3770,15 @@ static void trace__init_syscall_bpf_progs(struct trace *trace, int e_machine, in
 static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int e_machine, int id)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
-	return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program__fd(unaugmented_prog);
+	return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) :
+		bpf_program__fd(augmented_syscalls__unaugmented_enter());
 }
 
 static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int e_machine, int id)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
-	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(unaugmented_prog);
+	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) :
+		bpf_program__fd(augmented_syscalls__unaugmented_exit());
 }
 
 static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, int key, unsigned int *beauty_array)
@@ -3977,7 +3979,7 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
 	if (augmented_syscalls__get_map_fds(&map_enter_fd, &map_exit_fd, &beauty_map_fd) < 0)
 		return -1;
 
-	unaugmented_prog = augmented_syscalls__unaugmented();
+	unaugmented_prog = augmented_syscalls__unaugmented_enter();
 
 	for (int i = 0, num_idx = syscalltbl__num_idx(e_machine); i < num_idx; ++i) {
 		int prog_fd, key = syscalltbl__id_at_idx(e_machine, i);
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 2c9bcc6b8cb0c06c..0016deb321fe0d97 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -180,7 +180,13 @@ unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const
 }
 
 SEC("tp/raw_syscalls/sys_enter")
-int syscall_unaugmented(struct trace_event_raw_sys_enter *args)
+int sys_enter_unaugmented(struct trace_event_raw_sys_enter *args)
+{
+	return 1;
+}
+
+SEC("tp/raw_syscalls/sys_exit")
+int sys_exit_unaugmented(struct trace_event_raw_sys_exit *args)
 {
 	return 1;
 }
diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
index 56ed17534caa4f3f..f2792ede0249ab89 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -115,9 +115,14 @@ int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *beauty_fd)
 	return 0;
 }
 
-struct bpf_program *augmented_syscalls__unaugmented(void)
+struct bpf_program *augmented_syscalls__unaugmented_enter(void)
 {
-	return skel->progs.syscall_unaugmented;
+	return skel->progs.sys_enter_unaugmented;
+}
+
+struct bpf_program *augmented_syscalls__unaugmented_exit(void)
+{
+	return skel->progs.sys_exit_unaugmented;
 }
 
 struct bpf_program *augmented_syscalls__find_by_title(const char *name)
diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
index 4f729bc6775304b4..70b11d3f52906c36 100644
--- a/tools/perf/util/trace_augment.h
+++ b/tools/perf/util/trace_augment.h
@@ -14,7 +14,8 @@ void augmented_syscalls__setup_bpf_output(void);
 int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids);
 int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *beauty_fd);
 struct bpf_program *augmented_syscalls__find_by_title(const char *name);
-struct bpf_program *augmented_syscalls__unaugmented(void);
+struct bpf_program *augmented_syscalls__unaugmented_enter(void);
+struct bpf_program *augmented_syscalls__unaugmented_exit(void);
 void augmented_syscalls__cleanup(void);
 
 #else /* !HAVE_BPF_SKEL */
@@ -52,7 +53,12 @@ augmented_syscalls__find_by_title(const char *name __maybe_unused)
 	return NULL;
 }
 
-static inline struct bpf_program *augmented_syscalls__unaugmented(void)
+static inline struct bpf_program *augmented_syscalls__unaugmented_enter(void)
+{
+	return NULL;
+}
+
+static inline struct bpf_program *augmented_syscalls__unaugmented_exit(void)
 {
 	return NULL;
 }
-- 
2.51.0.rc1.167.g924127e9c0-goog


