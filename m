Return-Path: <bpf+bounces-67730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B13B495B5
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 18:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DAF188BF62
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85343128C6;
	Mon,  8 Sep 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs1A6kTy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424143128B9
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349431; cv=none; b=YhxwxLMJ5Zd+A0hqeolTRVUttvVkXV6iYxWwW69CvyQonQfyC+o+gsjtwyJuLEYDnP1M1S/zsbwwTvUVf4x5f98ZPNUzIgvHg2rlnBN76AHUHxo76uxm4qv23i1pb8AfzPPd7sjxQPGA1+ILoq8VbaA38j0oj1Zn+mZN8NNlltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349431; c=relaxed/simple;
	bh=ooJ+x2sGrz7SnSKOawx8mZ/taQxFfsABI6Gc97nIc5w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPUGWzqujQ/WYhqU9GmKLinnXosFF1gyz6uvIYfkB4+jC2Dnky6noMfrXAGEG36ZUYZLD7dEYQvOORpx5MRoK9+NjTa6Qr+4Ez3FrcnwmlIwwo7cjwahNQO9Jjo5JzghMqwYo93KkThqNwYiyixOO56jt9DW1ptmU+RbYBPIZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs1A6kTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778A1C4CEF1;
	Mon,  8 Sep 2025 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349430;
	bh=ooJ+x2sGrz7SnSKOawx8mZ/taQxFfsABI6Gc97nIc5w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gs1A6kTyvoz9Py59Lljb3lvaXvvsond9xyB3D0ZBrL17ymIksW7lseUtXQf6siteH
	 TWe5y3zJ7+cL2nTJaYLt7NT4GMd3Lz+XkoUsa3tvLZeT12sU1Z7BpDPtn3SpsqAWCE
	 wnV2suFjLyqb+cplgIpI0HccRkcPC0IzLEklDH4Lyl5qVQUViO05MmPMRrKaBn1Txl
	 bv5mzIyMLQ5H8Q5RjeCysyXkowKw6gpesByc8Do6uA5ulbX44VCtJDgfzGy4p0CnBj
	 ciJctyGOzTbhagEM7pejH3bRHWX5riBuztM+bFe8s6wWVkhx5ZDbBwD0Lair3zfuIi
	 isXUAaDP+zVjQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
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
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v6 5/5] selftests/bpf: Add tests for arena fault reporting
Date: Mon,  8 Sep 2025 16:36:34 +0000
Message-ID: <20250908163638.23150-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908163638.23150-1-puranjay@kernel.org>
References: <20250908163638.23150-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for testing the reporting of arena page faults through BPF
streams. Two new bpf programs are added that read and write to an
unmapped arena address and the fault reporting is verified in the
userspace through streams.

The added bpf programs need to access the user_vm_start in struct
bpf_arena, this is done by casting &arena to struct bpf_arena *, but
barrier_var() is used on this ptr before accessing ptr->user_vm_start;
to stop GCC from issuing an out-of-bound access due to the cast from
smaller map struct to larger "struct bpf_arena"

Other tests related to streams have been converted to use __stderr in
progs/stream.c directly and test_stream_errors() in prog_tests/stream.c
has been repurposed to validate the arena fault address printed in the
stderr stream. This can't be directly validated using __stderr because
the address is dynamic.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/stream.c |  53 ++----
 tools/testing/selftests/bpf/progs/stream.c    | 158 ++++++++++++++++++
 2 files changed, 176 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index 9d0e5d93edee7..61ab1da9b189b 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -18,29 +18,9 @@ void test_stream_success(void)
 	return;
 }
 
-struct {
-	int prog_off;
-	const char *errstr;
-} stream_error_arr[] = {
-	{
-		offsetof(struct stream, progs.stream_cond_break),
-		"ERROR: Timeout detected for may_goto instruction\n"
-		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
-		"Call trace:\n"
-		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
-		"|[ \t]+[^\n]+\n)*",
-	},
-	{
-		offsetof(struct stream, progs.stream_deadlock),
-		"ERROR: AA or ABBA deadlock detected for bpf_res_spin_lock\n"
-		"Attempted lock   = (0x[0-9a-fA-F]+)\n"
-		"Total held locks = 1\n"
-		"Held lock\\[ 0\\] = \\1\n"  // Lock address must match
-		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
-		"Call trace:\n"
-		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
-		"|[ \t]+[^\n]+\n)*",
-	},
+int prog_off[] = {
+	offsetof(struct stream, progs.stream_arena_read_fault),
+	offsetof(struct stream, progs.stream_arena_write_fault),
 };
 
 static int match_regex(const char *pattern, const char *string)
@@ -56,34 +36,33 @@ static int match_regex(const char *pattern, const char *string)
 	return rc == 0 ? 1 : 0;
 }
 
-void test_stream_errors(void)
+void test_stream_arena_fault_address(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
 	struct stream *skel;
 	int ret, prog_fd;
 	char buf[1024];
+	char fault_addr[64];
 
 	skel = stream__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
 		return;
 
-	for (int i = 0; i < ARRAY_SIZE(stream_error_arr); i++) {
+	for (int i = 0; i < ARRAY_SIZE(prog_off); i++) {
 		struct bpf_program **prog;
 
-		prog = (struct bpf_program **)(((char *)skel) + stream_error_arr[i].prog_off);
+		prog = (struct bpf_program **)(((char *)skel) + prog_off[i]);
 		prog_fd = bpf_program__fd(*prog);
 		ret = bpf_prog_test_run_opts(prog_fd, &opts);
 		ASSERT_OK(ret, "ret");
 		ASSERT_OK(opts.retval, "retval");
 
-#if !defined(__x86_64__) && !defined(__s390x__) && !defined(__aarch64__)
-		ASSERT_TRUE(1, "Timed may_goto unsupported, skip.");
-		if (i == 0) {
-			ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
-			ASSERT_EQ(ret, 0, "stream read");
-			continue;
-		}
+#if !defined(__x86_64__) && !defined(__aarch64__)
+		ASSERT_TRUE(1, "Arena fault reporting unsupported, skip.");
+		ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
+		ASSERT_EQ(ret, 0, "stream read");
+		continue;
 #endif
 
 		ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
@@ -91,9 +70,13 @@ void test_stream_errors(void)
 		ASSERT_LE(ret, 1023, "len for buf");
 		buf[ret] = '\0';
 
-		ret = match_regex(stream_error_arr[i].errstr, buf);
-		if (!ASSERT_TRUE(ret == 1, "regex match"))
+		sprintf(fault_addr, "0x%lx", skel->bss->fault_addr);
+		ret = match_regex(fault_addr, buf);
+
+		if (!ASSERT_TRUE(ret == 1, "regex match")) {
 			fprintf(stderr, "Output from stream:\n%s\n", buf);
+			fprintf(stderr, "Fault Addr: 0x%lx\n", skel->bss->fault_addr);
+		}
 	}
 
 	stream__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 35790897dc879..07ebca16a7338 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
+#include "bpf_arena_common.h"
 
 struct arr_elem {
 	struct bpf_res_spin_lock lock;
@@ -17,10 +18,29 @@ struct {
 	__type(value, struct arr_elem);
 } arrmap SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1); /* number of pages */
+} arena SEC(".maps");
+
+struct elem {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} array SEC(".maps");
+
 #define ENOSPC 28
 #define _STR "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
 
 int size;
+u64 fault_addr;
+void *arena_ptr;
 
 SEC("syscall")
 __success __retval(0)
@@ -37,7 +57,15 @@ int stream_exhaust(void *ctx)
 }
 
 SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__arch_s390x
 __success __retval(0)
+__stderr("ERROR: Timeout detected for may_goto instruction")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
 int stream_cond_break(void *ctx)
 {
 	while (can_loop)
@@ -47,6 +75,15 @@ int stream_cond_break(void *ctx)
 
 SEC("syscall")
 __success __retval(0)
+__stderr("ERROR: AA or ABBA deadlock detected for bpf_res_spin_lock")
+__stderr("{{Attempted lock   = (0x[0-9a-fA-F]+)\n"
+"Total held locks = 1\n"
+"Held lock\\[ 0\\] = \\1}}")
+__stderr("...")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
 int stream_deadlock(void *ctx)
 {
 	struct bpf_res_spin_lock *lock, *nlock;
@@ -76,4 +113,125 @@ int stream_syscall(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
+int stream_arena_write_fault(void *ctx)
+{
+	struct bpf_arena *ptr = (void *)&arena;
+	u64 user_vm_start;
+
+	/* Prevent GCC bounds warning: casting &arena to struct bpf_arena *
+	 * triggers bounds checking since the map definition is smaller than struct
+	 * bpf_arena. barrier_var() makes the pointer opaque to GCC, preventing the
+	 * bounds analysis
+	 */
+	barrier_var(ptr);
+	user_vm_start =  ptr->user_vm_start;
+	fault_addr = user_vm_start + 0x7fff;
+	bpf_addr_space_cast(user_vm_start, 0, 1);
+	asm volatile (
+		"r1 = %0;"
+		"r2 = 1;"
+		"*(u32 *)(r1 + 0x7fff) = r2;"
+		:
+		: "r" (user_vm_start)
+		: "r1", "r2"
+	);
+	return 0;
+}
+
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__stderr("ERROR: Arena READ access at unmapped address 0x{{.*}}")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
+int stream_arena_read_fault(void *ctx)
+{
+	struct bpf_arena *ptr = (void *)&arena;
+	u64 user_vm_start;
+
+	/* Prevent GCC bounds warning: casting &arena to struct bpf_arena *
+	 * triggers bounds checking since the map definition is smaller than struct
+	 * bpf_arena. barrier_var() makes the pointer opaque to GCC, preventing the
+	 * bounds analysis
+	 */
+	barrier_var(ptr);
+	user_vm_start = ptr->user_vm_start;
+	fault_addr = user_vm_start + 0x7fff;
+	bpf_addr_space_cast(user_vm_start, 0, 1);
+	asm volatile (
+		"r1 = %0;"
+		"r1 = *(u32 *)(r1 + 0x7fff);"
+		:
+		: "r" (user_vm_start)
+		: "r1"
+	);
+	return 0;
+}
+
+static __noinline void subprog(void)
+{
+	int __arena *addr = (int __arena *)0xdeadbeef;
+
+	arena_ptr = &arena;
+	*addr = 1;
+}
+
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
+int stream_arena_subprog_fault(void *ctx)
+{
+	subprog();
+	return 0;
+}
+
+static __noinline int timer_cb(void *map, int *key, struct bpf_timer *timer)
+{
+	int __arena *addr = (int __arena *)0xdeadbeef;
+
+	arena_ptr = &arena;
+	*addr = 1;
+	return 0;
+}
+
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
+int stream_arena_callback_fault(void *ctx)
+{
+	struct bpf_timer *arr_timer;
+
+	arr_timer = bpf_map_lookup_elem(&array, &(int){0});
+	if (!arr_timer)
+		return 0;
+	bpf_timer_init(arr_timer, &array, 1);
+	bpf_timer_set_callback(arr_timer, timer_cb);
+	bpf_timer_start(arr_timer, 0, 0);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3


