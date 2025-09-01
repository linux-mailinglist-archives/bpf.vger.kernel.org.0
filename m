Return-Path: <bpf+bounces-67128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49593B3EE7B
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 21:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52AC1A85F31
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 19:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC12320A3F;
	Mon,  1 Sep 2025 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vzp4S3zo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2CC45C0B
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755478; cv=none; b=NUO8eoBHxfqyZgMd/ogohzuHacQVYae2PvBb0C0ZalJ8G+74i3llGwT1wqVY4Cn+XKCJJSSrD0Q76xBNXiHquNKlkoL7iuuLZnK5VoaMK8YzFwPmSG5P2DILWqNUtYJ7ln1+rjOK5b8FlFF3zDeSL0wAKnigDhiWJ4CFxGw+bgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755478; c=relaxed/simple;
	bh=fKslYKD8OIfdgcm5UkwVebYAqos1eY3DZESHQHl4t+8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liK2ThHrMPxrGTsP4+ITLsZo/BzwNwBAPhi2hHEb/iwL7FXleZ+4d6ogLLFmo528Ez44C8A+LBkdBl4UQHhZbrS79CXR2gjZrbWlL1WqUwfVspMumjoJtQZLXYhqTTNT4B8m3Uy15Gz4qgcGOT5touezNZ+nkoP1+zZMVrLYh88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vzp4S3zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E79C4CEF0;
	Mon,  1 Sep 2025 19:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756755478;
	bh=fKslYKD8OIfdgcm5UkwVebYAqos1eY3DZESHQHl4t+8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Vzp4S3zoHhyOjqXPAOugmF/UCp+26VIbgr6Z/nc/XMSUfp1uJ4Cjfuaz0DNZer/u0
	 ELd3hEsMKEQlutpey1JdBa0ylAZo91E3n2LN8Np5P8S9Af1xE2D7oecPJY4YAjcYVs
	 fnVn3rvgLw7rAeTJb4LcHAvof8vQBIeeGJSbhOQCdl0oZAu9Jw4LKGLrgYhDk+KiLw
	 gBLBHKSM/IioaW6qihZ/qlYt/BWib77vNBaO+wLmsvk/bd79ry+xq0RAJNgmzdynDi
	 cuhQ22y6HR6qTgnrYWcfCPJFUzQ7+0i4Cx2Pk7+jO1WJ7UoP7YTNBy5rGJHEjBeWvs
	 DcmCnHCdgjn3A==
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
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: Add tests for arena fault reporting
Date: Mon,  1 Sep 2025 19:37:26 +0000
Message-ID: <20250901193730.43543-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250901193730.43543-1-puranjay@kernel.org>
References: <20250901193730.43543-1-puranjay@kernel.org>
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
 .../testing/selftests/bpf/prog_tests/stream.c | 34 ++++++++++-
 tools/testing/selftests/bpf/progs/stream.c    | 61 +++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index 9d0e5d93edee7..b2a85364e3c4f 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -41,6 +41,22 @@ struct {
 		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
 		"|[ \t]+[^\n]+\n)*",
 	},
+	{
+		offsetof(struct stream, progs.stream_arena_read_fault),
+		"ERROR: Arena READ access at unmapped address 0x.*\n"
+		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
+		"Call trace:\n"
+		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+		"|[ \t]+[^\n]+\n)*",
+	},
+	{
+		offsetof(struct stream, progs.stream_arena_write_fault),
+		"ERROR: Arena WRITE access at unmapped address 0x.*\n"
+		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
+		"Call trace:\n"
+		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+		"|[ \t]+[^\n]+\n)*",
+	},
 };
 
 static int match_regex(const char *pattern, const char *string)
@@ -63,6 +79,7 @@ void test_stream_errors(void)
 	struct stream *skel;
 	int ret, prog_fd;
 	char buf[1024];
+	char fault_addr[64] = {0};
 
 	skel = stream__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
@@ -85,6 +102,14 @@ void test_stream_errors(void)
 			continue;
 		}
 #endif
+#if !defined(__x86_64__) && !defined(__aarch64__)
+		ASSERT_TRUE(1, "Arena fault reporting unsupported, skip.");
+		if (i == 2 || i == 3) {
+			ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
+			ASSERT_EQ(ret, 0, "stream read");
+			continue;
+		}
+#endif
 
 		ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
 		ASSERT_GT(ret, 0, "stream read");
@@ -92,8 +117,15 @@ void test_stream_errors(void)
 		buf[ret] = '\0';
 
 		ret = match_regex(stream_error_arr[i].errstr, buf);
-		if (!ASSERT_TRUE(ret == 1, "regex match"))
+		if (ret && (i == 2 || i == 3)) {
+			sprintf(fault_addr, "0x%lx", skel->bss->fault_addr);
+			ret = match_regex(fault_addr, buf);
+		}
+		if (!ASSERT_TRUE(ret == 1, "regex match")) {
 			fprintf(stderr, "Output from stream:\n%s\n", buf);
+			if (i == 2 || i == 3)
+				fprintf(stderr, "Fault Addr: 0x%lx\n", skel->bss->fault_addr);
+		}
 	}
 
 	stream__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 35790897dc879..8ca6d3396a20a 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
+#include "bpf_arena_common.h"
 
 struct arr_elem {
 	struct bpf_res_spin_lock lock;
@@ -17,10 +18,17 @@ struct {
 	__type(value, struct arr_elem);
 } arrmap SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1); /* number of pages */
+} arena SEC(".maps");
+
 #define ENOSPC 28
 #define _STR "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
 
 int size;
+u64 fault_addr;
 
 SEC("syscall")
 __success __retval(0)
@@ -76,4 +84,57 @@ int stream_syscall(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success __retval(0)
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
+__success __retval(0)
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
 char _license[] SEC("license") = "GPL";
-- 
2.47.3


