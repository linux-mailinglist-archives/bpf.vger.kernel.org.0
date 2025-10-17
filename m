Return-Path: <bpf+bounces-71181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 604BCBE7BEF
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D942035C0BC
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D0B3168E8;
	Fri, 17 Oct 2025 09:22:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8B92D5C92;
	Fri, 17 Oct 2025 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692931; cv=none; b=c8qkOTF/nnpaUwoNnOmqnBNi/kpDQJVXfZgLPQ0QUncfVG512ssy5+qTMe2/0MWcGZVs0oalQv4c57DvGgU+clhmXeodoUClUg5pMjtShjYL24y4aADeTjDt0RtvtZkiIEk4Lw1GMQ9qWDcWCU2H2K8eaDS6e8yGuiJmYoHueXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692931; c=relaxed/simple;
	bh=VkRj1wYzRbfRS0ez+8qxzMZrr2DJNkoPHU5GAVvwJOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zwg6lgbIUr2H7Scj/B1yXYOOGMqBC0uE+GBvukXeW5nqv/yTWJh2wtPO/FA2WBlq9PKbRQzWGky0CkYYg5+lVefiiDbf/dUVLROr1qhzWhuzzRQp1vBHZNshT/sGk8CUR/IOHzqU3lTRZdJsJQ1QyyfEjzXe3sNwV9FCUnOKggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dxfb+2CvJoMUgXAA--.48322S3;
	Fri, 17 Oct 2025 17:21:58 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDx6sC1CvJoZ7PtAA--.42366S2;
	Fri, 17 Oct 2025 17:21:57 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1] selftests/bpf: Fix set but not used errors
Date: Fri, 17 Oct 2025 17:21:56 +0800
Message-ID: <20251017092156.27270-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx6sC1CvJoZ7PtAA--.42366S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JF45trWfKry7Zw1fCFyUurX_yoW7GF1xpa
	4kZ34qkF1SvF1aq3WxGa9FqF4fKr4DXFWFkr10qr98Zr1DJr97Xr1xKF45Jr9xWrZYvFn3
	Z34xKrs5ua18X3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xuctUUUUU==

There are some set but not used errors under tools/testing/selftests/bpf
when compiling with the latest upstream mainline GCC, add the compiler
attribute __maybe_unused for the variables that may be used to fix the
errors, compile tested only.

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c | 3 ++-
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c            | 3 ++-
 tools/testing/selftests/bpf/prog_tests/find_vma.c              | 3 ++-
 tools/testing/selftests/bpf/prog_tests/perf_branches.c         | 3 ++-
 tools/testing/selftests/bpf/prog_tests/perf_link.c             | 3 ++-
 tools/testing/selftests/bpf/test_maps.h                        | 1 +
 tools/testing/selftests/bpf/test_progs.h                       | 1 +
 7 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
index d32e4edac930..2b8edf996126 100644
--- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
@@ -226,7 +226,8 @@ static void test_lpm_order(void)
 static void test_lpm_map(int keysize)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
-	volatile size_t n_matches, n_matches_after_delete;
+	/* To avoid a -Wunused-but-set-variable warning. */
+	__maybe_unused volatile size_t n_matches, n_matches_after_delete;
 	size_t i, j, n_nodes, n_lookups;
 	struct tlpm_node *t, *list = NULL;
 	struct bpf_lpm_trie_key_u8 *key;
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 75f4dff7d042..119fbe478941 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -423,7 +423,8 @@ static void tp_subtest(struct test_bpf_cookie *skel)
 
 static void burn_cpu(void)
 {
-	volatile int j = 0;
+	/* To avoid a -Wunused-but-set-variable warning. */
+	__maybe_unused volatile int j = 0;
 	cpu_set_t cpu_set;
 	int i, err;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
index f7619e0ade10..ba4b7cbc1dea 100644
--- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
+++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
@@ -49,7 +49,8 @@ static bool find_vma_pe_condition(struct find_vma *skel)
 static void test_find_vma_pe(struct find_vma *skel)
 {
 	struct bpf_link *link = NULL;
-	volatile int j = 0;
+	/* To avoid a -Wunused-but-set-variable warning. */
+	__maybe_unused volatile int j = 0;
 	int pfd, i;
 	const int one_bn = 1000000000;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
index bc24f83339d6..7ce4df59b603 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -64,7 +64,8 @@ static void test_perf_branches_common(int perf_fd,
 	int err, i, duration = 0;
 	bool detached = false;
 	struct bpf_link *link;
-	volatile int j = 0;
+	/* To avoid a -Wunused-but-set-variable warning. */
+	__maybe_unused volatile int j = 0;
 	cpu_set_t cpu_set;
 
 	skel = test_perf_branches__open_and_load();
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
index d940ff87fa08..6cbd5b7bcb57 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -12,7 +12,8 @@
 
 static void burn_cpu(void)
 {
-	volatile int j = 0;
+	/* To avoid a -Wunused-but-set-variable warning. */
+	__maybe_unused volatile int j = 0;
 	cpu_set_t cpu_set;
 	int i, err;
 
diff --git a/tools/testing/selftests/bpf/test_maps.h b/tools/testing/selftests/bpf/test_maps.h
index e4ac704a536c..8d7413bca13c 100644
--- a/tools/testing/selftests/bpf/test_maps.h
+++ b/tools/testing/selftests/bpf/test_maps.h
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdbool.h>
+#include <linux/compiler.h>
 
 #define CHECK(condition, tag, format...) ({				\
 	int __ret = !!(condition);					\
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index eebfc18cdcd2..927c159d7fad 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 typedef __u16 __sum16;
 #include <arpa/inet.h>
+#include <linux/compiler.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 #include <linux/ip.h>
-- 
2.42.0


