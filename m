Return-Path: <bpf+bounces-47343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A5B9F8350
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 19:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526371889B0B
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F0A1A0BFB;
	Thu, 19 Dec 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndfGdQEb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112435948;
	Thu, 19 Dec 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633242; cv=none; b=lP36E+9+zrB9lXNRpHhrNvdxjgCCNw0PRXgidlRhLOUQej5oFQqRLlO9W1LU6PckbdQATJMZ6iBnB7dGidglX965xwJMFx0FTbe/uC9BAz4foYIX37BVCgAaRJWGUNHzgcVZ12b9NoKAPLwru4OjE3wmg2oHU0aIGuqiHkNHuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633242; c=relaxed/simple;
	bh=Uuu5Fj97LtLZwaiqztN4Om/PRbSY7pifs5mL0yqLYI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWHouKVyUvCqE8BuBo3kDZESGMO+S4IvOkVleGOjuG0uyxGLc+fhbUM/HW35sQCwUWljZRVnTl8XEB/iO6nvpN76AF1fPTPZKkW4GYvC77c2mALwpsURO/U1hV1duQsizK6Hrl52K8qS5Rrlo5Dzoo6DhOAnoQJtmhTjoBaKR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndfGdQEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27949C4CECE;
	Thu, 19 Dec 2024 18:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734633241;
	bh=Uuu5Fj97LtLZwaiqztN4Om/PRbSY7pifs5mL0yqLYI4=;
	h=From:To:Cc:Subject:Date:From;
	b=ndfGdQEbBNRiIt9ca7Fmoytl0TvLOxpj46lrad5pqhVDRq8y9iIy/hAXOESFTxoON
	 Lkhx7FbA8FiPjGcUJImsVPHJn8McpCP5A0kwIDOdX8rqX2PKH3FbDNMp4Srzocq2Xu
	 Jmhmec2KyGSaiUJxIm7qsM3nuUuA2rQc+E+tMIFV2/xjl8Le8LjxI4pEPmmqBAQHop
	 lFuGvy2h2xm3mACpv6OZdaqTvdzJt3OHutrRoS4N3P+phewRlcCabOE+ZjF2FwUgpB
	 pGJzDU7b6PygLyZ795fkPCkBze4VDLHzhvQKsefkW4Wf6WU3lRi5bqy9evYM6ODVjO
	 nEy4Bb1T/o4Lw==
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
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH v2] perf trace: Add --syscall-sample option
Date: Thu, 19 Dec 2024 10:34:00 -0800
Message-ID: <20241219183400.350308-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option is to implement the event sampling for system calls in BPF.
When it's used, it picks up a syscall in the given sampling period and
discard others.  The period is in msec as it shows the time in msec.

  # perf trace -C 0 --syscall-sample 100 sleep 1
           ? (         ): fleetspeakd/1828559  ... [continued]: futex())                                            = -1 ETIMEDOUT (Connection timed out)
       0.050 (100.247 ms): gnome-shell/572531 recvmsg(fd: 10<socket:[3355761]>, msg: 0x7ffef8b39d20)                = 40
     100.357 (100.149 ms): pipewire-pulse/572245 read(fd: 5<anon_inode:[eventfd]>, buf: 0x7ffc0b9dc8f0, count: 8)      = 8
     200.553 (100.268 ms): NetworkManager/3424 epoll_wait(epfd: 19<anon_inode:[eventpoll]>, events: 0x5607b85bb880, maxevents: 6) = 0
     300.876 (         ): mon/4932 poll(ufds: 0x7fa392784df0, nfds: 1, timeout_msecs: 100)            ...
     400.901 ( 0.025 ms): TaskCon~ller #/620145 futex(uaddr: 0x7f3fc596fa00, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
     300.876 (100.123 ms): mon/4932  ... [continued]: poll())                                             = 0 (Timeout)
     500.901 ( 0.012 ms): evdefer/2/2335122 futex(uaddr: 0x5640baac5198, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
     602.701 ( 0.017 ms): Compositor/1992200 futex(uaddr: 0x7f1a51dfdd40, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
     705.589 ( 0.017 ms): JS Watchdog/947933 futex(uaddr: 0x7f4cac1d4240, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
     812.667 ( 0.027 ms): fix/1985151 futex(uaddr: 0xc0008f7148, op: WAKE|PRIVATE_FLAG, val: 1)             = 1
     912.807 ( 0.017 ms): Xorg/572315 setitimer(value: 0x7ffc375d6ba0)                                      = 0

The timestamp is kept in a per-cpu array and the allowed task is saved
in a BPF hash map.  For non-BPF use cases, it won't work so an error
message would be displayed.

  # perf trace --syscall-sample 100 sleep 1
  ERROR: --syscall-sample works only for BPF

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2 changes)
* rename to --syscall-sample and update the description
* print error when BPF is not available  (Arnaldo)
* rename to sample_period_ns  (Ian)

 tools/perf/Documentation/perf-trace.txt       |  6 ++
 tools/perf/builtin-trace.c                    | 11 +++
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 67 ++++++++++++++++++-
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 6e0cc50bbc13fc7f..e8a38ecc5eddab1c 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -241,6 +241,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	printing using the existing 'perf trace' syscall arg beautifiers to map integer
 	arguments to strings (pid to comm, syscall id to syscall name, etc).
 
+--syscall-sample=<period>::
+	Enable sampling of system calls with a given period in msec.
+	The sampling frequency would be 1 / period, in other words,
+	it will trace a system call only after the given period of
+	time is passed.  The sampling period is tracked per CPU.
+
 
 PAGEFAULTS
 ----------
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6a1a128fe645014d..e70e634fbfaf33f5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -185,6 +185,7 @@ struct trace {
 	} stats;
 	unsigned int		max_stack;
 	unsigned int		min_stack;
+	unsigned long		sample_period_ms;
 	int			raw_augmented_syscalls_args_size;
 	bool			raw_augmented_syscalls;
 	bool			fd_path_disabled;
@@ -5186,6 +5187,7 @@ int cmd_trace(int argc, const char **argv)
 		     "start"),
 	OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
 		       "to customized ones"),
+	OPT_ULONG(0, "syscall-sample", &trace.sample_period_ms, "syscall sampling period in ms"),
 	OPTS_EVSWITCH(&trace.evswitch),
 	OPT_END()
 	};
@@ -5293,6 +5295,9 @@ int cmd_trace(int argc, const char **argv)
 				bpf_program__set_autoattach(prog, /*autoattach=*/false);
 		}
 
+		if (trace.sample_period_ms)
+			trace.skel->rodata->sample_period_ns = trace.sample_period_ms * NSEC_PER_MSEC;
+
 		err = augmented_raw_syscalls_bpf__load(trace.skel);
 
 		if (err < 0) {
@@ -5313,6 +5318,12 @@ int cmd_trace(int argc, const char **argv)
 	trace.syscalls.events.bpf_output = evlist__last(trace.evlist);
 	assert(evsel__name_is(trace.syscalls.events.bpf_output, "__augmented_syscalls__"));
 skip_augmentation:
+#else
+	if (trace.sample_period_ms) {
+		pr_err("ERROR: --syscall-sample works only for BPF\n");
+		err = -EINVAL;
+		goto out;
+	}
 #endif
 	err = -1;
 
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 4a62ed593e84edf8..7027bec55298191d 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -113,6 +113,22 @@ struct pids_filtered {
 	__uint(max_entries, 64);
 } pids_filtered SEC(".maps");
 
+struct sample_timestamp {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, int);
+	__type(value, __u64);
+	__uint(max_entries, 1);
+} sample_timestamp SEC(".maps");
+
+struct sample_filtered {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, bool);
+	__uint(max_entries, MAX_CPUS);
+} sample_filtered SEC(".maps");
+
+const volatile __u64 sample_period_ns;
+
 struct augmented_args_payload {
 	struct syscall_enter_args args;
 	struct augmented_arg arg, arg2; // We have to reserve space for two arguments (rename, etc)
@@ -428,6 +444,44 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
+static bool sample_filter__allow_enter(__u64 timestamp, pid_t pid)
+{
+	int idx = 0;
+	__u64 *prev_ts;
+	bool ok = true;
+
+	/* default behavior */
+	if (sample_period_ns == 0)
+		return true;
+
+	prev_ts = bpf_map_lookup_elem(&sample_timestamp, &idx);
+
+	if (prev_ts) {
+		if ((*prev_ts + sample_period_ns) > timestamp)
+			return false;
+		*prev_ts = timestamp;
+	} else {
+		bpf_map_update_elem(&sample_timestamp, &idx, &timestamp, BPF_ANY);
+	}
+
+	bpf_map_update_elem(&sample_filtered, &pid, &ok, BPF_ANY);
+
+	return true;
+}
+
+static bool sample_filter__allow_exit(pid_t pid)
+{
+	/* default behavior */
+	if (sample_period_ns == 0)
+		return true;
+
+	if (!bpf_map_lookup_elem(&sample_filtered, &pid))
+		return false;
+
+	bpf_map_delete_elem(&sample_filtered, &pid);
+	return true;
+}
+
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 {
 	bool augmented, do_output = false;
@@ -526,7 +580,9 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 SEC("tp/raw_syscalls/sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
+	pid_t pid = getpid();
 	struct augmented_args_payload *augmented_args;
+
 	/*
 	 * We start len, the amount of data that will be in the perf ring
 	 * buffer, if this is not filtered out by one of pid_filter__has(),
@@ -537,7 +593,10 @@ int sys_enter(struct syscall_enter_args *args)
 	 * initial, non-augmented raw_syscalls:sys_enter payload.
 	 */
 
-	if (pid_filter__has(&pids_filtered, getpid()))
+	if (pid_filter__has(&pids_filtered, pid))
+		return 0;
+
+	if (!sample_filter__allow_enter(bpf_ktime_get_ns(), pid))
 		return 0;
 
 	augmented_args = augmented_args_payload();
@@ -561,9 +620,13 @@ int sys_enter(struct syscall_enter_args *args)
 SEC("tp/raw_syscalls/sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
+	pid_t pid = getpid();
 	struct syscall_exit_args exit_args;
 
-	if (pid_filter__has(&pids_filtered, getpid()))
+	if (pid_filter__has(&pids_filtered, pid))
+		return 0;
+
+	if (!sample_filter__allow_exit(pid))
 		return 0;
 
 	bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
-- 
2.47.1.613.gc27f4b7a9f-goog


