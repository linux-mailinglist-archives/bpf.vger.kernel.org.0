Return-Path: <bpf+bounces-20073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7398389ED
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 10:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0939328983C
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA10258ACA;
	Tue, 23 Jan 2024 09:04:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FA658118;
	Tue, 23 Jan 2024 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706000645; cv=none; b=tEwruYsZ07fK0fngMHhqRDd95L3/gZKa1IVfMgLAS/tyzKtSk4UBX2a74D40R0IN9WSBdAiGNvRRQQC54csOnTpPBmyhlqAPqhBO9Ph9tiZl6xkUfcsLqxIKTslwTMJVcSl/DYqvVm7QRrEm6ZXxLoqKYyhblLfrHJVRQ5gytvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706000645; c=relaxed/simple;
	bh=uAuc5NGuAKzHwKhtKCjIf3yoyMD6xJEd9Lpn5xHhucA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSkF7UCBSdGVuqmvTbFJOQmzFQUi5Vqzc3eU6M9N3fSp6xG1KmRwNT5KtuJcsanaAx414pZgeJY3sUzF1FF21oS0UPPNSYTOrJNwNSKdWZVg5E/b4HrXy0d3xivdHAKHR8SKcBhrwZXKjSNvURPKsVoR2lq5kroaIk/nghfRR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxTOn7gK9lRRYEAA--.6357S3;
	Tue, 23 Jan 2024 17:03:56 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs_4gK9lWhMUAA--.24458S4;
	Tue, 23 Jan 2024 17:03:54 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v7 2/2] selftests/bpf: Skip callback tests if jit is disabled in test_verifier
Date: Tue, 23 Jan 2024 17:03:51 +0800
Message-ID: <20240123090351.2207-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240123090351.2207-1-yangtiezhu@loongson.cn>
References: <20240123090351.2207-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs_4gK9lWhMUAA--.24458S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW3tr1UtrW5ur1xAF4UJrc_yoWrKr4Upa
	1kGFWv9F4jq3Wa9ry7ArnakFWrur4vvrW0kFn093yUZa1kWw45Jr1xKFWYy3ZxWrWFvr9a
	yr17GFWrur4UXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_
	Jr0_Gr1lYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jVa09UUUUU=

If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
exist 6 failed tests.

  [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
  [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
  [root@linux bpf]# ./test_verifier | grep FAIL
  #106/p inline simple bpf_loop call FAIL
  #107/p don't inline bpf_loop call, flags non-zero FAIL
  #108/p don't inline bpf_loop call, callback non-constant FAIL
  #109/p bpf_loop_inline and a dead func FAIL
  #110/p bpf_loop_inline stack locations for loop vars FAIL
  #111/p inline bpf_loop call in a big program FAIL
  Summary: 768 PASSED, 15 SKIPPED, 6 FAILED

The test log shows that callbacks are not allowed in non-JITed programs,
interpreter doesn't support them yet, thus these tests should be skipped
if jit is disabled.

Add an explicit flag F_NEEDS_JIT_ENABLED to those tests to mark that they
require JIT enabled in bpf_loop_inline.c, check the flag and jit_disabled
at the beginning of do_test_single() to handle this case.

With this patch:

  [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
  [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
  [root@linux bpf]# ./test_verifier | grep FAIL
  Summary: 768 PASSED, 21 SKIPPED, 0 FAILED

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/test_verifier.c           | 11 +++++++++++
 .../testing/selftests/bpf/verifier/bpf_loop_inline.c  |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 1a09fc34d093..c65915188d7c 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -67,6 +67,7 @@
 
 #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS	(1 << 0)
 #define F_LOAD_WITH_STRICT_ALIGNMENT		(1 << 1)
+#define F_NEEDS_JIT_ENABLED			(1 << 2)
 
 /* need CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON to load progs */
 #define ADMIN_CAPS (1ULL << CAP_NET_ADMIN |	\
@@ -74,6 +75,7 @@
 		    1ULL << CAP_BPF)
 #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
 static bool unpriv_disabled = false;
+static bool jit_disabled;
 static int skips;
 static bool verbose = false;
 static int verif_log_level = 0;
@@ -1524,6 +1526,13 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	__u32 pflags;
 	int i, err;
 
+	if ((test->flags & F_NEEDS_JIT_ENABLED) && jit_disabled) {
+		printf("SKIP (callbacks are not allowed in non-JITed programs)\n");
+		skips++;
+		sched_yield();
+		return;
+	}
+
 	fd_prog = -1;
 	for (i = 0; i < MAX_NR_MAPS; i++)
 		map_fds[i] = -1;
@@ -1844,6 +1853,8 @@ int main(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	jit_disabled = !is_jit_enabled();
+
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 
diff --git a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
index a535d41dc20d..59125b22ae39 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
@@ -57,6 +57,7 @@
 	.expected_insns = { PSEUDO_CALL_INSN() },
 	.unexpected_insns = { HELPER_CALL_INSN() },
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.flags = F_NEEDS_JIT_ENABLED,
 	.result = ACCEPT,
 	.runs = 0,
 	.func_info = { { 0, MAIN_TYPE }, { 12, CALLBACK_TYPE } },
@@ -90,6 +91,7 @@
 	.expected_insns = { HELPER_CALL_INSN() },
 	.unexpected_insns = { PSEUDO_CALL_INSN() },
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.flags = F_NEEDS_JIT_ENABLED,
 	.result = ACCEPT,
 	.runs = 0,
 	.func_info = { { 0, MAIN_TYPE }, { 16, CALLBACK_TYPE } },
@@ -127,6 +129,7 @@
 	.expected_insns = { HELPER_CALL_INSN() },
 	.unexpected_insns = { PSEUDO_CALL_INSN() },
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.flags = F_NEEDS_JIT_ENABLED,
 	.result = ACCEPT,
 	.runs = 0,
 	.func_info = {
@@ -165,6 +168,7 @@
 	.expected_insns = { PSEUDO_CALL_INSN() },
 	.unexpected_insns = { HELPER_CALL_INSN() },
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.flags = F_NEEDS_JIT_ENABLED,
 	.result = ACCEPT,
 	.runs = 0,
 	.func_info = {
@@ -235,6 +239,7 @@
 	},
 	.unexpected_insns = { HELPER_CALL_INSN() },
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.flags = F_NEEDS_JIT_ENABLED,
 	.result = ACCEPT,
 	.func_info = {
 		{ 0, MAIN_TYPE },
@@ -252,6 +257,7 @@
 	.unexpected_insns = { HELPER_CALL_INSN() },
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.flags = F_NEEDS_JIT_ENABLED,
 	.func_info = { { 0, MAIN_TYPE }, { 16, CALLBACK_TYPE } },
 	.func_info_cnt = 2,
 	BTF_TYPES
-- 
2.42.0


