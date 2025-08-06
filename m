Return-Path: <bpf+bounces-65107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDE4B1C28F
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 10:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26423A64AC
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 08:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF1528935D;
	Wed,  6 Aug 2025 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uabQIIK8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940D223311
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470755; cv=none; b=IvVKbdUa65PRtyDnb+VsPUjuspOsPJ6m/KeMXRyyNyM2uWOHJZujNuB07ab3O3rNlhbQOBO01BXpVgqlgXpz8u+Rrv8fTdQtC030scYpqlIMe3UTd4Fj66IyNSciesdC6dxCOnuxoi8BKa9ahtTcp7/YQYEIsCRdMSgPqb2ck+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470755; c=relaxed/simple;
	bh=R8DY7B1C60z8T7w/qiuv9BCN8CkV414G/UiSJLimdJs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecgMRt9v7l83Xum1RqdC+UIOilOClcci2ndp1wz5V/3DsN8Yk7R/p9xwoKAriC2i0FauoW2aKG8x/rDa3SzX3/gm2PYgNSo2+53zJAKQIjm2CekBWKJueNgok2Knas4jFdRaL/HNe3Xzb+UDwItrVjBZ2o3MwW97EB7hnRDjb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uabQIIK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E003C4CEE7;
	Wed,  6 Aug 2025 08:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754470754;
	bh=R8DY7B1C60z8T7w/qiuv9BCN8CkV414G/UiSJLimdJs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uabQIIK8pIywLp3HWWMF61WHDETtShZ3nz3uvtTCS5m4UomMCIWq/UtlVbEnPlnVE
	 kDgvwXg6vJfUf8LqAljnacby4hGdufos78+2cQqeAOZQrlZbG63crTU5mkr0qoXy7A
	 ql8WvHXv+OYD+Cc87ArrTRSSBSk/iPexk2B/v8HUcFSqmIQURQmwH1FLUtFqDu1BD+
	 /c9pmDierzSUHyV+9lJtE1jOtfwggPJke74tEwBPVCDvjKFAApknFkXF/s2jcjZAqA
	 VX2/vzYCSZ/S9izorvd6xcXqcQWmdcfxr4yyS22HS2Mc/x6RrFL6E9wtnGLp/uA+k3
	 jDA1AY9SQ4OQw==
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add tests for arena fault reporting
Date: Wed,  6 Aug 2025 08:58:36 +0000
Message-ID: <20250806085847.18633-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250806085847.18633-1-puranjay@kernel.org>
References: <20250806085847.18633-1-puranjay@kernel.org>
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
 .../testing/selftests/bpf/prog_tests/stream.c | 24 ++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    | 37 +++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index d9f0185dca61b..4bdde56de35b1 100644
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
@@ -85,6 +101,14 @@ void test_stream_errors(void)
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
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 35790897dc879..58ebff60cd96a 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -1,10 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#define BPF_NO_KFUNC_PROTOTYPES
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
+#include "bpf_arena_common.h"
+
+extern int bpf_res_spin_lock(struct bpf_res_spin_lock *lock) __weak __ksym;
+extern void bpf_res_spin_unlock(struct bpf_res_spin_lock *lock) __weak __ksym;
 
 struct arr_elem {
 	struct bpf_res_spin_lock lock;
@@ -17,6 +22,12 @@ struct {
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
 
@@ -76,4 +87,30 @@ int stream_syscall(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success __retval(0)
+int stream_arena_write_fault(void *ctx)
+{
+	unsigned char __arena *page;
+
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	bpf_arena_free_pages(&arena, page, 1);
+
+	*(page + 0xbeef) = 1;
+
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int stream_arena_read_fault(void *ctx)
+{
+	unsigned char __arena *page;
+
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	bpf_arena_free_pages(&arena, page, 1);
+
+	return *(page + 0xbeef);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3


