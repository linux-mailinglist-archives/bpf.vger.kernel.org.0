Return-Path: <bpf+bounces-37078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF18950C8B
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61812839BD
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EE21A3BD4;
	Tue, 13 Aug 2024 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AqIkxXuC"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857C1A3BCF
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575014; cv=none; b=F0XdXRVnPtFMy+f8ThJ7ffwf97FBnBv5cFuuzLSdLEDBA6hZ9rWj4j525umsHjFv8ZmlSQXWnFwEvRHvFOnq12srfnxeu3y/k0V0rChZzyHLgIFGkxi8JLOxdunhVXiNMfiN0d23lioK7VBs1XS2hwW4qcP2Uhx9uSbLX9FkzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575014; c=relaxed/simple;
	bh=2TLCZJDsZTCCYfFcRzoi406vm9XrhYvBt44yD8/JtXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3eejMcIWOyO/q5mYT5aZovLbHZYWJxsihx5OBW5zE0eVrzLa7pFCYGBSsZ/uzJSnkN7jef5xzOBpGdkMn65P6epg9GXJQGSUDVfaF5UH41BpHCnufTvBpeIYfeA/c2c90LWrD9eL7u2KWPe8yQTxGibPQ5LDQcRZoNG5YO4dRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AqIkxXuC; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723575010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ztwuooFE0dM711Tb5cypKEnLdHL0COCVYbfberE/6Y=;
	b=AqIkxXuCY85/5E3II/gd+sGD4IFvN85cebL36CJqUQmPaqF6L4Hnq8jgBsnaW+kcsAhaeK
	AuN5o5esPMr9Y5X9fYEk3A0QrYmyIQSNGlTFsB7DBmviwo16LP3l6pIQaswM6K7X49Ef4J
	l4ynm8aSK8zQjpB1sffGO1nOGbH4xVQ=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next 6/6] selftests/bpf: Add kfunc call test in gen_prologue and gen_epilogue
Date: Tue, 13 Aug 2024 11:49:39 -0700
Message-ID: <20240813184943.3759630-7-martin.lau@linux.dev>
In-Reply-To: <20240813184943.3759630-1-martin.lau@linux.dev>
References: <20240813184943.3759630-1-martin.lau@linux.dev>
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
The value of the PROLOGUE_A and EPILOGUE_A macro are adjusted
to reflect this change also.

The inc100 kfunc is newly added in this patch which does
args->a += 100. Note that it is not in the register_btf_kfunc_id_set(),
so no need to declare in the bpf_testmod_kfunc.h.
It is enclosed with __bpf_kfunc_{start,edn}_defs to avoid the
compiler warning.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 42 ++++++++++++++++++-
 .../bpf/prog_tests/struct_ops_syscall.c       |  5 ++-
 2 files changed, 43 insertions(+), 4 deletions(-)

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
 
diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_syscall.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_syscall.c
index a293a35b0dcc..2a73066adbf5 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_syscall.c
@@ -3,10 +3,11 @@
 #include <test_progs.h>
 #include "struct_ops_syscall.skel.h"
 
-#define EPILOGUE_A  10000
-#define PROLOGUE_A   1000
+#define KFUNC_A100    100
 #define KFUNC_A10      10
 #define SUBPROG_A       1
+#define EPILOGUE_A (10000 + KFUNC_A100 + KFUNC_A10)
+#define PROLOGUE_A  (1000 + KFUNC_A100 + KFUNC_A10)
 
 #define SUBPROG_TEST_MAIN	SUBPROG_A
 #define KFUNC_TEST_MAIN		(KFUNC_A10 + SUBPROG_A)
-- 
2.43.5


