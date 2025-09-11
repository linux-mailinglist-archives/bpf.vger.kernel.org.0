Return-Path: <bpf+bounces-68149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB9B536C4
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415453A6450
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE369350835;
	Thu, 11 Sep 2025 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xju31IWK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3134F489
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602717; cv=none; b=o8EuePQnu7tnzcPJFiNCBonxsg8BZrJ+/zJ4u7cvQ0CwPXS1t3SqWmhemEU9PYS6vuRcCnOWvB6QNKGA1z809ConiwgwlSijH3ndmk8MGcy+08DFKpGlXLZWZidTsCId9y45Q0OdNMc0wBSUYdV8ECd9Bma0vLXfd4ZRjD3zRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602717; c=relaxed/simple;
	bh=xMhHXjeynJqjorbt0dnnQsPQCi4mVt4ygvQgOhV/aUc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eblOIkWMTnOfCjbNHXwDMJ5B5mk9D//wqsyKd6lpB9SKrnFMnk547EPle2uYGjljs8Qq2vMzsqYrgH6HJ30/PiBmP5rZ9FJPzkqRhsfXdsy+uzVqfoTs6Kbfw/YF8Lx1N5fGMXHfMviE1mc7FBu0cmJUVdYc/Z/01Cb8VjCJC2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xju31IWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC02AC4CEF0;
	Thu, 11 Sep 2025 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602716;
	bh=xMhHXjeynJqjorbt0dnnQsPQCi4mVt4ygvQgOhV/aUc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Xju31IWKM8Uf879RqoUvO0fC+UWXF6Gp7tQ5RIFPCZVuXQaEcjW0c6PBiI9TZHrer
	 LdlXHnHCFZMRA+zd/fRVxuBdf6Bxu8OKbpQeZ8/HQZ+QQ2+R/Mts2I2SjXVFRZlaR5
	 fksO58R0WQvwM5VVap8E1Kq91DC6ku4qHGhkq6xRNK8YdeAgCux+GufA8IMqqGVEcA
	 +R9rIFwLrJliPoLMKVLfTwiM4trOqnwi/G2zeR3EfwwX1P/8MNxGHUcux7Zpu0DqTX
	 1zUKWPtDXxlIbZIjpM7bgjUQCjQt0QNpmx6fPo+glGKhfe2wJsWBLB3fHgUlQGVLar
	 o/33dyNDGPqhQ==
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
Subject: [PATCH bpf-next v7 6/6] selftests/bpf: Add tests for arena fault reporting
Date: Thu, 11 Sep 2025 14:58:05 +0000
Message-ID: <20250911145808.58042-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911145808.58042-1-puranjay@kernel.org>
References: <20250911145808.58042-1-puranjay@kernel.org>
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

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/stream.c |  49 ++++++
 tools/testing/selftests/bpf/progs/stream.c    | 141 ++++++++++++++++++
 2 files changed, 190 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index 6f8eac5ccb65..c3cce5c292bd 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -57,3 +57,52 @@ void test_stream_syscall(void)
 
 	stream__destroy(skel);
 }
+
+static void test_address(struct bpf_program *prog, unsigned long *fault_addr_p)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
+	int ret, prog_fd;
+	char fault_addr[64];
+	char buf[1024];
+
+	prog_fd = bpf_program__fd(prog);
+
+	ret = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_OK(ret, "ret");
+	ASSERT_OK(opts.retval, "retval");
+
+	sprintf(fault_addr, "0x%lx", *fault_addr_p);
+
+	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
+	ASSERT_GT(ret, 0, "stream read");
+	ASSERT_LE(ret, 1023, "len for buf");
+	buf[ret] = '\0';
+
+	if (!ASSERT_HAS_SUBSTR(buf, fault_addr, "fault_addr")) {
+		fprintf(stderr, "Output from stream:\n%s\n", buf);
+		fprintf(stderr, "Fault Addr: %s\n", fault_addr);
+	}
+}
+
+void test_stream_arena_fault_address(void)
+{
+	struct stream *skel;
+
+#if !defined(__x86_64__) && !defined(__aarch64__)
+	printf("%s:SKIP: arena fault reporting not supported\n", __func__);
+	test__skip();
+	return;
+#endif
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+
+	if (test__start_subtest("read_fault"))
+		test_address(skel->progs.stream_arena_read_fault, &skel->bss->fault_addr);
+	if (test__start_subtest("write_fault"))
+		test_address(skel->progs.stream_arena_write_fault, &skel->bss->fault_addr);
+
+	stream__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index bb465dad8247..4a5bd852f10c 100644
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
@@ -93,4 +113,125 @@ int stream_syscall(void *ctx)
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
+	user_vm_start = ptr->user_vm_start;
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


