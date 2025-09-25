Return-Path: <bpf+bounces-69711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 746CAB9F00E
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 13:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52EE04E10C7
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08912FBE1A;
	Thu, 25 Sep 2025 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8mabVUb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8142ED84A;
	Thu, 25 Sep 2025 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801119; cv=none; b=JAtR2tmOmo4I1dlhedyNS5lQrDnY9VGJ0wQQciIz2vpl16hI9Qkm5J+fvT3m7fwawIuH8SLaB1gMY7RNDu9yTP7CYArY3MXsp9d07wKVcSdIfhvdfjM/3MZBcgnSFvcBej4QtIcSGbej0wOnLaezPXsswhFk5OWHTby7KqYDIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801119; c=relaxed/simple;
	bh=wfgqwt+NXtirlCpuguERid2O5/nt96XopcicVnATzLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iH5HKQOmzjT8+pCP7XnanXVBA0LQYxiV/KhZGNh5lW8860ZblN10hGod79WLfED4ingDZb3W9mu0WN1c8MjphmTKG6by5b9YKHAuOC8T/Gg3SB30wSKJdqBmdY4JIU46noDGigIo6gtUiO30QUJoPRFRPickrHaGeXkoyFECptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8mabVUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5978C4CEF0;
	Thu, 25 Sep 2025 11:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758801119;
	bh=wfgqwt+NXtirlCpuguERid2O5/nt96XopcicVnATzLI=;
	h=From:To:Cc:Subject:Date:From;
	b=o8mabVUbJgXlvnQxRfysKj9zaPpL4bgmOIrAjLAsKaLEkC7sNSfmoynpJc3xVw01l
	 eBOavrRQcyeYsasd0RN7lwMAfFneLx3wcJPK6K8VuCUqev7hfk8De52MJnP1CNngIP
	 zAO8I1D+0EQoLUP0QHpDBJmsDDCmuP8RZXetSj+hTU/p7KcWs7rNY+7pzm9C+/FMuj
	 6EALZHFWhe4SjNd8thf2UwEKlEaN9xHi3jVc4qEmmllRH/5nvHNi+6ClkX5a0pTY7f
	 fxIEn7YLVCCx4j8lyjk7TLFLUwvWblh5DNCzjso7Sh83+DiIk0O/IPWwRuRP4Y9gJK
	 EjsRlA90zDAcQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Feng Yang <yangfeng59949@163.com>,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next] selftests/bpf: Add stacktrace test for kprobe multi
Date: Thu, 25 Sep 2025 13:51:45 +0200
Message-ID: <20250925115145.1916664-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding stacktrace test for kprobe multi probe.

Cc: Feng Yang <yangfeng59949@163.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
test for arm64 fix posted separately in here:
  https://lore.kernel.org/bpf/20250925020822.119302-1-yangfeng59949@163.com/

 .../selftests/bpf/prog_tests/stacktrace_map.c | 107 +++++++++++++-----
 .../selftests/bpf/progs/test_stacktrace_map.c |  28 ++++-
 2 files changed, 106 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
index 84a7e405e912..922224adc86b 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
@@ -1,13 +1,44 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "test_stacktrace_map.skel.h"
 
-void test_stacktrace_map(void)
+static void check_stackmap(int control_map_fd, int stackid_hmap_fd,
+			   int stackmap_fd, int stack_amap_fd)
+{
+	__u32 key, val, duration = 0;
+	int err, stack_trace_len;
+
+	/* disable stack trace collection */
+	key = 0;
+	val = 1;
+	bpf_map_update_elem(control_map_fd, &key, &val, 0);
+
+	/* for every element in stackid_hmap, we can find a corresponding one
+	 * in stackmap, and vice versa.
+	 */
+	err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
+	if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
+		  "err %d errno %d\n", err, errno))
+		return;
+
+	err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
+	if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
+		  "err %d errno %d\n", err, errno))
+		return;
+
+	stack_trace_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
+	err = compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace_len);
+	CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
+		"err %d errno %d\n", err, errno);
+}
+
+static void test_stacktrace_map_tp(void)
 {
 	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
 	const char *prog_name = "oncpu";
-	int err, prog_fd, stack_trace_len;
+	int err, prog_fd;
 	const char *file = "./test_stacktrace_map.bpf.o";
-	__u32 key, val, duration = 0;
+	__u32 duration = 0;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
 	struct bpf_link *link;
@@ -44,32 +75,56 @@ void test_stacktrace_map(void)
 	/* give some time for bpf program run */
 	sleep(1);
 
-	/* disable stack trace collection */
-	key = 0;
-	val = 1;
-	bpf_map_update_elem(control_map_fd, &key, &val, 0);
-
-	/* for every element in stackid_hmap, we can find a corresponding one
-	 * in stackmap, and vice versa.
-	 */
-	err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
-	if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
-	if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	stack_trace_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
-	err = compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace_len);
-	if (CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
+	check_stackmap(control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd);
 
 disable_pmu:
 	bpf_link__destroy(link);
 close_prog:
 	bpf_object__close(obj);
 }
+
+static void test_stacktrace_map_kprobe_multi(bool retprobe)
+{
+	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts,
+		.retprobe = retprobe
+	);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct test_stacktrace_map *skel;
+	struct bpf_link *link;
+	int prog_fd, err;
+
+	skel = test_stacktrace_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_stacktrace_map__open_and_load"))
+		return;
+
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.kprobe,
+						     "bpf_fentry_test1", &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_kprobe_multi_opts"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.trigger);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	control_map_fd  = bpf_map__fd(skel->maps.control_map);
+	stackid_hmap_fd = bpf_map__fd(skel->maps.stackid_hmap);
+	stackmap_fd     = bpf_map__fd(skel->maps.stackmap);
+	stack_amap_fd   = bpf_map__fd(skel->maps.stack_amap);
+
+	check_stackmap(control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd);
+
+cleanup:
+	test_stacktrace_map__destroy(skel);
+}
+
+void test_stacktrace_map(void)
+{
+	if (test__start_subtest("tp"))
+		test_stacktrace_map_tp();
+	if (test__start_subtest("kprobe_multi"))
+		test_stacktrace_map_kprobe_multi(false);
+	if (test__start_subtest("kretprobe_multi"))
+		test_stacktrace_map_kprobe_multi(true);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
index 47568007b668..7a27e162a407 100644
--- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
+++ b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
@@ -3,6 +3,7 @@
 
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 
 #ifndef PERF_MAX_STACK_DEPTH
 #define PERF_MAX_STACK_DEPTH         127
@@ -50,8 +51,7 @@ struct sched_switch_args {
 	int next_prio;
 };
 
-SEC("tracepoint/sched/sched_switch")
-int oncpu(struct sched_switch_args *ctx)
+static inline void test_stackmap(void *ctx)
 {
 	__u32 max_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
 	__u32 key = 0, val = 0, *value_p;
@@ -59,7 +59,7 @@ int oncpu(struct sched_switch_args *ctx)
 
 	value_p = bpf_map_lookup_elem(&control_map, &key);
 	if (value_p && *value_p)
-		return 0; /* skip if non-zero *value_p */
+		return; /* skip if non-zero *value_p */
 
 	/* The size of stackmap and stackid_hmap should be the same */
 	key = bpf_get_stackid(ctx, &stackmap, 0);
@@ -69,7 +69,29 @@ int oncpu(struct sched_switch_args *ctx)
 		if (stack_p)
 			bpf_get_stack(ctx, stack_p, max_len, 0);
 	}
+}
+
+SEC("tracepoint/sched/sched_switch")
+int oncpu(struct sched_switch_args *ctx)
+{
+	test_stackmap(ctx);
+	return 0;
+}
 
+/*
+ * No tests in here, just to trigger 'bpf_fentry_test*'
+ * through tracing test_run.
+ */
+SEC("fentry/bpf_modify_return_test")
+int BPF_PROG(trigger)
+{
+	return 0;
+}
+
+SEC("kprobe.multi")
+int kprobe(struct pt_regs *ctx)
+{
+	test_stackmap(ctx);
 	return 0;
 }
 
-- 
2.51.0


