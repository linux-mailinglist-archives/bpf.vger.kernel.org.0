Return-Path: <bpf+bounces-66669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E654B3859F
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77E73BBDDA
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6981FF60A;
	Wed, 27 Aug 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LENlZCvi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B41DE3B7
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306896; cv=none; b=d0r9XtzW0M19BpjMIxQRv4Dwv7Qz9HNtJF/DyN8hDg36HmKQgXsB48W2ooxacWv8aSnbMnDCRfq1c4fURMH1sgKKgnrDBb18e73L6BLrk9tIPXod4DYbLPYG8umRq3v8CC8r9GQt0rk+C/hE4RuZ7b6i/dIcxdtc9rCw2mKhCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306896; c=relaxed/simple;
	bh=OyAzXuHXc9OUCR4AGM9NlMT6vxJE75RgFGzDe48IoJk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6+55CqABWag11UI/cRV6/YkjQEnIrLOdNFGAr08215jIlTcwwT3V9swyxbUsu973FWJsYFGys9W3YBnS0DdbtFohtn0vEXk9xlg0aAWepagVOhe45KOTPRz565kqxJ9EOBt2zCSf5D2WxzXXFJfKgOzgVM6IIyhpxVP8nGcx2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LENlZCvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA001C4CEEB;
	Wed, 27 Aug 2025 15:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756306896;
	bh=OyAzXuHXc9OUCR4AGM9NlMT6vxJE75RgFGzDe48IoJk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LENlZCvi/hrteOPN2JY2UsLiBRIyaVI2iKXqOVXqdu9Pky72IQlT7bP7Tntahxy9u
	 eKFpneWHoxO5Dnl5oZfj25AZ00o9Po06Lvux0kz/Dz00daCviJEK+Byh7Ck2NDwOsS
	 FpTQxojYRjUnjxkjLENWQG9Mc2DWwx0psPzb1ijr4/pus5UPpCuRKJrY8C6MIYyi0D
	 UDh+pNwBYgQW+OwNEyVdxg62bbse6PKmIYhzZPMZgo2jIXQX8xjG+o+c8FcHqrPNaT
	 Iv0rZ0WUnjoqnzjsYFmkUnRaL8zoFjcu/XYuSqxHmYZp4OdElJfGbq6+6dFm15+Eww
	 DtQPiC3I1XGyA==
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
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for arena fault reporting
Date: Wed, 27 Aug 2025 15:00:39 +0000
Message-ID: <20250827150113.15763-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827150113.15763-1-puranjay@kernel.org>
References: <20250827150113.15763-1-puranjay@kernel.org>
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

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/stream.c | 33 +++++++++++++++-
 tools/testing/selftests/bpf/progs/stream.c    | 39 +++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index 36a1a1ebde692..8fdc83260ea14 100644
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
@@ -92,8 +117,14 @@ void test_stream_errors(void)
 		buf[ret] = '\0';
 
 		ret = match_regex(stream_error_arr[i].errstr, buf);
-		if (!ASSERT_TRUE(ret == 1, "regex match"))
+		if (ret && (i == 2 || i == 3)) {
+			sprintf(fault_addr, "0x%lx", skel->bss->fault_addr);
+			ret = match_regex(fault_addr, buf);
+		}
+		if (!ASSERT_TRUE(ret == 1, "regex match")) {
 			fprintf(stderr, "Output from stream:\n%s\n", buf);
+			fprintf(stderr, "Fault Addr: 0x%lx\n", skel->bss->fault_addr);
+		}
 	}
 
 	stream__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 35790897dc879..9de015ac3ced5 100644
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
@@ -76,4 +84,35 @@ int stream_syscall(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success __retval(0)
+int stream_arena_write_fault(void *ctx)
+{
+	struct bpf_arena *ptr = (void *)&arena;
+	u64 user_vm_start;
+
+	barrier_var(ptr);
+	user_vm_start =  ptr->user_vm_start;
+
+	fault_addr = user_vm_start + 0xbeef;
+	*(u32 __arena *)(user_vm_start + 0xbeef) = 1;
+
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
+	barrier_var(ptr);
+	user_vm_start =  ptr->user_vm_start;
+
+	fault_addr = user_vm_start + 0xbeef;
+
+	return *(u32 __arena *)(user_vm_start + 0xbeef);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3


