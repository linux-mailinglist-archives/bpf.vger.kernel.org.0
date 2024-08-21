Return-Path: <bpf+bounces-37791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDCE95A860
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299542830A5
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE4917D8A2;
	Wed, 21 Aug 2024 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q8G2cIj2"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C417CA19
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283330; cv=none; b=FngKqTYy9sBp8a3PdYN1udZed3xmpJNpVBkSnjfGIhjLbzYWOKyqUGHCsdBmC0sIt6ERZhZFFNgRzCP41VDeiQeVzIMKHp6FIbERo9wJLG9YFow7a8HhVQVsWhjdBcuINIzHRz/Vhr0HPYCWYJekloTLJeIg5Jx4eP/fQYMHOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283330; c=relaxed/simple;
	bh=3WhTgvQytk56V9rStk9xNUUiRI7Pq7dr6L7nhi9ZeFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkgdhFgxCNN/qDkYY/mPca/g730wql025jWMvrRVLyUZr9hCfDu5AebpAxx+SpcQNUkaKqIbKuSoLCLRRt1wmd7723E1koAdUZO34l8zb/U9ybBpkJgw5PR4I3CvAnBkzUB4uQ3JRkdK/pP2fdUhd4WyeQYcuj1QQq+PusLWYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q8G2cIj2; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724283327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wAudpGr4s0jGpyx5HbEs+P/xvf8PX7y8TNaKM8qptck=;
	b=Q8G2cIj2HL83VsPKNfvXsvAtJvT863cV1MxjtCFjuDBWw36FtaQmrwqrvYBbBeV2R5DbD1
	udM7zjEuw2OyWgnGw6uNpMjDu5X9yMS4fTklUqgJkhj/ofBVoUz9aJ5vIX4ut0cSXw95sq
	1g92+9nQYKFJfEOFUFzj8ig8otyIOw8=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 8/8] selftests/bpf: Add kfunc call test in gen_prologue and gen_epilogue
Date: Wed, 21 Aug 2024 16:34:38 -0700
Message-ID: <20240821233440.1855263-9-martin.lau@linux.dev>
In-Reply-To: <20240821233440.1855263-1-martin.lau@linux.dev>
References: <20240821233440.1855263-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch changes the .gen_pro/epilogue of the bpf_testmod_st_ops
to call kfunc. It will call the inc10 and inc100 kfunc.

The __xlated instructions have been adjusted accordinly.
The same goes for the __retval.

The inc100 kfunc is newly added in this patch which does
args->a += 100. Note that it is not in the register_btf_kfunc_id_set(),
so no need to declare in the bpf_testmod_kfunc.h.
It is enclosed with __bpf_kfunc_{start,end}_defs to avoid the
compiler warning.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 42 +++++++++++-
 .../selftests/bpf/prog_tests/pro_epilogue.c   |  4 +-
 .../selftests/bpf/progs/pro_epilogue_kfunc.c  | 68 ++++++++++++-------
 .../bpf/progs/pro_epilogue_subprog.c          | 58 ++++++++++------
 4 files changed, 123 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 4c75346376d9..6f745d29e124 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -966,6 +966,16 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
 	return args->a;
 }
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_kfunc_st_ops_inc100(struct st_ops_args *args)
+{
+	args->a += 100;
+	return args->a;
+}
+
+__bpf_kfunc_end_defs();
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -1140,6 +1150,10 @@ static int bpf_test_mod_st_ops__test_pro_epilogue(struct st_ops_args *args)
 	return 0;
 }
 
+BTF_ID_LIST(st_ops_epilogue_kfunc_list)
+BTF_ID(func, bpf_kfunc_st_ops_inc10)
+BTF_ID(func, bpf_kfunc_st_ops_inc100)
+
 static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 			       const struct bpf_prog *prog, struct module **module)
 {
@@ -1153,13 +1167,28 @@ static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	 * r7 = r6->a;
 	 * r7 += 1000;
 	 * r6->a = r7;
+	 * r7 = r1;
+	 * r1 = r6;
+	 * bpf_kfunc_st_ops_in10(r1)
+	 * r1 = r6;
+	 * bpf_kfunc_st_ops_in100(r1)
+	 * r1 = r7;
 	 */
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0);
 	*insn++ = BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6, offsetof(struct st_ops_args, a));
 	*insn++ = BPF_ALU32_IMM(BPF_ADD, BPF_REG_7, 1000);
 	*insn++ = BPF_STX_MEM(BPF_W, BPF_REG_6, BPF_REG_7, offsetof(struct st_ops_args, a));
+	*insn++ = BPF_MOV64_REG(BPF_REG_7, BPF_REG_1);
+	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
+	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,
+			       st_ops_epilogue_kfunc_list[0]);
+	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
+	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,
+			       st_ops_epilogue_kfunc_list[1]);
+	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_7);
 	*insn++ = prog->insnsi[0];
 
+	*module = THIS_MODULE;
 	return insn - insn_buf;
 }
 
@@ -1177,7 +1206,10 @@ static int st_ops_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog
 	 * r6 = r1->a;
 	 * r6 += 10000;
 	 * r1->a = r6;
-	 * r0 = r6;
+	 * r6 = r1;
+	 * bpf_kfunc_st_ops_in10(r1)
+	 * r1 = r6;
+	 * bpf_kfunc_st_ops_in100(r1)
 	 * r0 *= 2;
 	 * BPF_EXIT;
 	 */
@@ -1186,10 +1218,16 @@ static int st_ops_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog
 	*insn++ = BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1, offsetof(struct st_ops_args, a));
 	*insn++ = BPF_ALU32_IMM(BPF_ADD, BPF_REG_6, 10000);
 	*insn++ = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_6, offsetof(struct st_ops_args, a));
-	*insn++ = BPF_MOV32_REG(BPF_REG_0, BPF_REG_6);
+	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,
+			       st_ops_epilogue_kfunc_list[0]);
+	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
+	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,
+			       st_ops_epilogue_kfunc_list[1]);
 	*insn++ = BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, 2);
 	*insn++ = BPF_EXIT_INSN();
 
+	*module = THIS_MODULE;
 	return insn - insn_buf;
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
index 98de677c55a9..db6e98096335 100644
--- a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
+++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
@@ -34,8 +34,8 @@ static void test_tailcall(void)
 	prog_fd = bpf_program__fd(skel->progs.syscall_epilogue_tailcall);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "bpf_prog_test_run_opts");
-	ASSERT_EQ(args.a, 10001, "args.a");
-	ASSERT_EQ(topts.retval, 10001 * 2, "topts.retval");
+	ASSERT_EQ(args.a, 10111, "args.a");
+	ASSERT_EQ(topts.retval, 10111 * 2, "topts.retval");
 
 done:
 	epilogue_tailcall__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c b/tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c
index 7d1124cf4942..2bd306f16610 100644
--- a/tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c
@@ -28,13 +28,19 @@ __xlated("0: r6 = *(u64 *)(r1 +0)")
 __xlated("1: r7 = *(u32 *)(r6 +0)")
 __xlated("2: w7 += 1000")
 __xlated("3: *(u32 *)(r6 +0) = r7")
-/* main prog */
-__xlated("4: r1 = *(u64 *)(r1 +0)")
-__xlated("5: r6 = r1")
+__xlated("4: r7 = r1")
+__xlated("5: r1 = r6")
 __xlated("6: call kernel-function")
 __xlated("7: r1 = r6")
-__xlated("8: call pc+1")
-__xlated("9: exit")
+__xlated("8: call kernel-function")
+__xlated("9: r1 = r7")
+/* main prog */
+__xlated("10: r1 = *(u64 *)(r1 +0)")
+__xlated("11: r6 = r1")
+__xlated("12: call kernel-function")
+__xlated("13: r1 = r6")
+__xlated("14: call pc+1")
+__xlated("15: exit")
 SEC("struct_ops/test_prologue_kfunc")
 __naked int test_prologue_kfunc(void)
 {
@@ -65,9 +71,12 @@ __xlated("7: r1 = *(u64 *)(r1 +0)")
 __xlated("8: r6 = *(u32 *)(r1 +0)")
 __xlated("9: w6 += 10000")
 __xlated("10: *(u32 *)(r1 +0) = r6")
-__xlated("11: w0 = w6")
-__xlated("12: w0 *= 2")
-__xlated("13: exit")
+__xlated("11: r6 = r1")
+__xlated("12: call kernel-function")
+__xlated("13: r1 = r6")
+__xlated("14: call kernel-function")
+__xlated("15: w0 *= 2")
+__xlated("16: exit")
 SEC("struct_ops/test_epilogue_kfunc")
 __naked int test_epilogue_kfunc(void)
 {
@@ -89,23 +98,32 @@ __xlated("0: r6 = *(u64 *)(r1 +0)")
 __xlated("1: r7 = *(u32 *)(r6 +0)")
 __xlated("2: w7 += 1000")
 __xlated("3: *(u32 *)(r6 +0) = r7")
+__xlated("4: r7 = r1")
+__xlated("5: r1 = r6")
+__xlated("6: call kernel-function")
+__xlated("7: r1 = r6")
+__xlated("8: call kernel-function")
+__xlated("9: r1 = r7")
 /* save __u64 *ctx to stack */
-__xlated("4: *(u64 *)(r10 -8) = r1")
+__xlated("10: *(u64 *)(r10 -8) = r1")
 /* main prog */
-__xlated("5: r1 = *(u64 *)(r1 +0)")
-__xlated("6: r6 = r1")
-__xlated("7: call kernel-function")
-__xlated("8: r1 = r6")
-__xlated("9: call pc+")
-/* epilogue */
-__xlated("10: r1 = *(u64 *)(r10 -8)")
 __xlated("11: r1 = *(u64 *)(r1 +0)")
-__xlated("12: r6 = *(u32 *)(r1 +0)")
-__xlated("13: w6 += 10000")
-__xlated("14: *(u32 *)(r1 +0) = r6")
-__xlated("15: w0 = w6")
-__xlated("16: w0 *= 2")
-__xlated("17: exit")
+__xlated("12: r6 = r1")
+__xlated("13: call kernel-function")
+__xlated("14: r1 = r6")
+__xlated("15: call pc+")
+/* epilogue */
+__xlated("16: r1 = *(u64 *)(r10 -8)")
+__xlated("17: r1 = *(u64 *)(r1 +0)")
+__xlated("18: r6 = *(u32 *)(r1 +0)")
+__xlated("19: w6 += 10000")
+__xlated("20: *(u32 *)(r1 +0) = r6")
+__xlated("21: r6 = r1")
+__xlated("22: call kernel-function")
+__xlated("23: r1 = r6")
+__xlated("24: call kernel-function")
+__xlated("25: w0 *= 2")
+__xlated("26: exit")
 SEC("struct_ops/test_pro_epilogue_kfunc")
 __naked int test_pro_epilogue_kfunc(void)
 {
@@ -122,7 +140,7 @@ __naked int test_pro_epilogue_kfunc(void)
 }
 
 SEC("syscall")
-__retval(1011) /* PROLOGUE_A [1000] + KFUNC_INC10 + SUBPROG_A [1] */
+__retval(1121) /* PROLOGUE_A [1110] + KFUNC_INC10 + SUBPROG_A [1] */
 int syscall_prologue_kfunc(void *ctx)
 {
 	struct st_ops_args args = {};
@@ -131,7 +149,7 @@ int syscall_prologue_kfunc(void *ctx)
 }
 
 SEC("syscall")
-__retval(20022) /* (KFUNC_INC10 + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+__retval(20242) /* (KFUNC_INC10 + SUBPROG_A [1] + EPILOGUE_A [10110]) * 2 */
 int syscall_epilogue_kfunc(void *ctx)
 {
 	struct st_ops_args args = {};
@@ -140,7 +158,7 @@ int syscall_epilogue_kfunc(void *ctx)
 }
 
 SEC("syscall")
-__retval(22022) /* (PROLOGUE_A [1000] + KFUNC_INC10 + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+__retval(22462) /* (PROLOGUE_A [1110] + KFUNC_INC10 + SUBPROG_A [1] + EPILOGUE_A [10110]) * 2 */
 int syscall_pro_epilogue_kfunc(void *ctx)
 {
 	struct st_ops_args args = {};
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_subprog.c b/tools/testing/selftests/bpf/progs/pro_epilogue_subprog.c
index c91b1bf30e37..3d9cc25c024b 100644
--- a/tools/testing/selftests/bpf/progs/pro_epilogue_subprog.c
+++ b/tools/testing/selftests/bpf/progs/pro_epilogue_subprog.c
@@ -21,10 +21,16 @@ __xlated("0: r6 = *(u64 *)(r1 +0)")
 __xlated("1: r7 = *(u32 *)(r6 +0)")
 __xlated("2: w7 += 1000")
 __xlated("3: *(u32 *)(r6 +0) = r7")
+__xlated("4: r7 = r1")
+__xlated("5: r1 = r6")
+__xlated("6: call kernel-function")
+__xlated("7: r1 = r6")
+__xlated("8: call kernel-function")
+__xlated("9: r1 = r7")
 /* main prog */
-__xlated("4: r1 = *(u64 *)(r1 +0)")
-__xlated("5: call pc+1")
-__xlated("6: exit")
+__xlated("10: r1 = *(u64 *)(r1 +0)")
+__xlated("11: call pc+1")
+__xlated("12: exit")
 SEC("struct_ops/test_prologue_subprog")
 __naked int test_prologue_subprog(void)
 {
@@ -47,9 +53,12 @@ __xlated("4: r1 = *(u64 *)(r1 +0)")
 __xlated("5: r6 = *(u32 *)(r1 +0)")
 __xlated("6: w6 += 10000")
 __xlated("7: *(u32 *)(r1 +0) = r6")
-__xlated("8: w0 = w6")
-__xlated("9: w0 *= 2")
-__xlated("10: exit")
+__xlated("8: r6 = r1")
+__xlated("9: call kernel-function")
+__xlated("10: r1 = r6")
+__xlated("11: call kernel-function")
+__xlated("12: w0 *= 2")
+__xlated("13: exit")
 SEC("struct_ops/test_epilogue_subprog")
 __naked int test_epilogue_subprog(void)
 {
@@ -66,20 +75,29 @@ __xlated("0: r6 = *(u64 *)(r1 +0)")
 __xlated("1: r7 = *(u32 *)(r6 +0)")
 __xlated("2: w7 += 1000")
 __xlated("3: *(u32 *)(r6 +0) = r7")
+__xlated("4: r7 = r1")
+__xlated("5: r1 = r6")
+__xlated("6: call kernel-function")
+__xlated("7: r1 = r6")
+__xlated("8: call kernel-function")
+__xlated("9: r1 = r7")
 /* save __u64 *ctx to stack */
-__xlated("4: *(u64 *)(r10 -8) = r1")
+__xlated("10: *(u64 *)(r10 -8) = r1")
 /* main prog */
-__xlated("5: r1 = *(u64 *)(r1 +0)")
-__xlated("6: call pc+")
+__xlated("11: r1 = *(u64 *)(r1 +0)")
+__xlated("12: call pc+")
 /* epilogue */
-__xlated("7: r1 = *(u64 *)(r10 -8)")
-__xlated("8: r1 = *(u64 *)(r1 +0)")
-__xlated("9: r6 = *(u32 *)(r1 +0)")
-__xlated("10: w6 += 10000")
-__xlated("11: *(u32 *)(r1 +0) = r6")
-__xlated("12: w0 = w6")
-__xlated("13: w0 *= 2")
-__xlated("14: exit")
+__xlated("13: r1 = *(u64 *)(r10 -8)")
+__xlated("14: r1 = *(u64 *)(r1 +0)")
+__xlated("15: r6 = *(u32 *)(r1 +0)")
+__xlated("16: w6 += 10000")
+__xlated("17: *(u32 *)(r1 +0) = r6")
+__xlated("18: r6 = r1")
+__xlated("19: call kernel-function")
+__xlated("20: r1 = r6")
+__xlated("21: call kernel-function")
+__xlated("22: w0 *= 2")
+__xlated("23: exit")
 SEC("struct_ops/test_pro_epilogue_subprog")
 __naked int test_pro_epilogue_subprog(void)
 {
@@ -91,7 +109,7 @@ __naked int test_pro_epilogue_subprog(void)
 }
 
 SEC("syscall")
-__retval(1001) /* PROLOGUE_A [1000] + SUBPROG_A [1] */
+__retval(1111) /* PROLOGUE_A [1110] + SUBPROG_A [1] */
 int syscall_prologue_subprog(void *ctx)
 {
 	struct st_ops_args args = {};
@@ -100,7 +118,7 @@ int syscall_prologue_subprog(void *ctx)
 }
 
 SEC("syscall")
-__retval(20002) /* (SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+__retval(20222) /* (SUBPROG_A [1] + EPILOGUE_A [10110]) * 2 */
 int syscall_epilogue_subprog(void *ctx)
 {
 	struct st_ops_args args = {};
@@ -109,7 +127,7 @@ int syscall_epilogue_subprog(void *ctx)
 }
 
 SEC("syscall")
-__retval(22002) /* (PROLOGUE_A [1000] + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+__retval(22442) /* (PROLOGUE_A [1110] + SUBPROG_A [1] + EPILOGUE_A [10110]) * 2 */
 int syscall_pro_epilogue_subprog(void *ctx)
 {
 	struct st_ops_args args = {};
-- 
2.43.5


