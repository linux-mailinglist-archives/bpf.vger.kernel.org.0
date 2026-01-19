Return-Path: <bpf+bounces-79512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E732D3B7BD
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 20:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 896FD303C127
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA592E8E09;
	Mon, 19 Jan 2026 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PXWm+5GW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12CB2DB791
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852444; cv=none; b=vCPYQvlUwu7BKZHIa3IA09Us/OXzNjKR9oEoRxZ+6p2dKQT69baC1gy9qo7IqkEBppKIBDYZWJ6uVcgMtPyJIBEpAfkOIx3RR7uOLVcpv6FUAx9MNPEeOa0QOKwkA6mO7G81yAZYvb068vvNoI4/DPJ3FYnQNFfg4b2PRuPF0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852444; c=relaxed/simple;
	bh=enheyffyzeRQuTMmVfRf9X1OoExDglgi7I1CfaKQ4F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DCoGJwRhCxOVan20AH/FspZv9IVp30RQuWTnFTYQfSuWU1mvp6DBWWp6jarvFnz951v1nPOovqxTx86OBwmJKqRpjuT/tvK+mjHtM+HB/yBfSeESK4YL3paliEg9lhzZBwgmoUcGZlX6ZtXLWWK2vtnCYsqzMRl9oJY1/c5xqso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PXWm+5GW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b87cc82fd85so252799366b.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 11:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768852441; x=1769457241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLqhUFO5VO0ft/TfIoPNJ2fKHKmLQpH/DMD1yoEvhbQ=;
        b=PXWm+5GWqfIEFpo1g4nlwj2ekIs/lVpkC2z64BLJuuirgdSox4Mmuir8NmhwetUlTx
         tOill6LYqrbNkTrWMt+Vw4QSbjnoHf8hMWrSczjmGxwTVTvMAhRu5co9Cdn93zCMQZL/
         2hi4RDpJOwLbEOnmV23A84igNbM0RXSZilIRPADkZyVNdEV6CupbFiaPwAGZuVuxUx8V
         UHMLOEiYEkWjW59L60AheRFxuR5PdCoQqXpwOMd1HqjslMrDDSrGU1XRzpophQEPBYAN
         POcOJ8ijQKCsOAm9SOhHjyOmKrDCnM5uJwfOhDmpbWmj1n+LYEO45jHB6d6PX8JOn9Y7
         DY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768852441; x=1769457241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HLqhUFO5VO0ft/TfIoPNJ2fKHKmLQpH/DMD1yoEvhbQ=;
        b=sMch7b92JQnrbe5IYdY26of49IPZRLVjquAPJjBtiPZvBjferkdAXkJndV8XpgvUzy
         s+3ny63BRiC6oY8EHcFgPP0LmCdmdW/KVh7DrzynwdS+vkLip88mXCo1sydws6HC3OOq
         37ukS7F6OuffKRrzSj/3qw9FHS31JZ3aW84K62M/WeYoa/5okp9DfgH60JRYhwopDbWt
         YHGHH4XPRFWjxnikMGWpO+CYcTYuHzLkRJrXuhpBPwGLwqj8/sAJZnKKTaONYLc1hmwY
         9cRSRvh6X2z7FYY8FQ/dZlg94ZUFft9RzmmlI42oS9WAoy9pH3seKnsRnbYQfzCe7nkw
         tdGg==
X-Gm-Message-State: AOJu0Yyya9FV22aiJqv9WlkzHF9HBRFqN3xY8ArPDiQ9wKex8ecNxC9J
	XSamtb4vIxUdskbbY1vAbFPpXBoKUwcngJkn8cxE2j/maur48ZBezoLkEzq5h+fp9cg=
X-Gm-Gg: AY/fxX5pLIEiAG9pGhbbxxwnCfAjriXSrJDcaBFmmhHQnc2A660rbK+bAQwyJBfXWH4
	qqwQzpDzMDaiahMVe9YQfErxtTtyu4FqT1O+LaF+AjJMRQr3d9bP0aJyzH14Ni64yxJzS4cah4U
	BkrEcSLBLv7ZqAanDzCHnePz7IT+xez7PxWX2gAeExmWCPrUbzt6xfs8AxvmTRmfsAsdF90OZ3z
	wu1j0TxlpBPqGDSgSvnXpNg4Mybink5owd6Xp6NUck6dAs8yCqD1we6i6Uc6/B4+Uy10Wlpruwx
	NKK9IIZ6RnXHRgqo8zIllTL9Dz+WwMsNMsCFKxhsG/FsOASGWx6gSsjGkDsOzLmkqJZ5MZFLSEM
	u9qmoU5LD5NcO0no5jW+YvCg1ijQy5hwsXDJWZlvtSXi7kaXtceLJngTk+84P07SRblMfKtnAgs
	NGiE8sU1NEAjPaflE6E5gwiKClyxMiivcPZF/F+jqbf5XHXQt301RGNpEtWcg=
X-Received: by 2002:a17:906:f592:b0:b86:fca7:3dc2 with SMTP id a640c23a62f3a-b87968d4b0bmr992663166b.10.1768852440951;
        Mon, 19 Jan 2026 11:54:00 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452bce213sm11290957a12.2.2026.01.19.11.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:54:00 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 19 Jan 2026 20:53:54 +0100
Subject: [PATCH bpf-next 4/4] selftests/bpf: Remove tests for
 prologue/epilogue with kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-4-e8b88d6430d8@cloudflare.com>
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Remove pro_epilogue_with_kfunc test program and its supporting code in
bpf_testmod. This test exercised calling kfuncs from prologue and epilogue,
which is no longer supported after the switch to direct helper calls.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/prog_tests/pro_epilogue.c        |  2 -
 .../selftests/bpf/progs/pro_epilogue_with_kfunc.c  | 88 ---------------------
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 92 ----------------------
 3 files changed, 182 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
index 5d3c00a08a88..509883e6823a 100644
--- a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
+++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
@@ -6,7 +6,6 @@
 #include "epilogue_tailcall.skel.h"
 #include "pro_epilogue_goto_start.skel.h"
 #include "epilogue_exit.skel.h"
-#include "pro_epilogue_with_kfunc.skel.h"
 
 struct st_ops_args {
 	__u64 a;
@@ -56,7 +55,6 @@ void test_pro_epilogue(void)
 	RUN_TESTS(pro_epilogue);
 	RUN_TESTS(pro_epilogue_goto_start);
 	RUN_TESTS(epilogue_exit);
-	RUN_TESTS(pro_epilogue_with_kfunc);
 	if (test__start_subtest("tailcall"))
 		test_tailcall();
 }
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c b/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c
deleted file mode 100644
index a5a8f08ac8fb..000000000000
--- a/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c
+++ /dev/null
@@ -1,88 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
-
-#include <vmlinux.h>
-#include <bpf/bpf_tracing.h>
-#include "bpf_misc.h"
-#include "../test_kmods/bpf_testmod.h"
-#include "../test_kmods/bpf_testmod_kfunc.h"
-
-char _license[] SEC("license") = "GPL";
-
-void __kfunc_btf_root(void)
-{
-	bpf_kfunc_st_ops_inc10(NULL);
-}
-
-static __noinline __used int subprog(struct st_ops_args *args)
-{
-	args->a += 1;
-	return args->a;
-}
-
-__success
-/* prologue */
-__xlated("0: r8 = r1")
-__xlated("1: r1 = 0")
-__xlated("2: call kernel-function")
-__xlated("3: if r0 != 0x0 goto pc+5")
-__xlated("4: r6 = *(u64 *)(r8 +0)")
-__xlated("5: r7 = *(u64 *)(r6 +0)")
-__xlated("6: r7 += 1000")
-__xlated("7: *(u64 *)(r6 +0) = r7")
-__xlated("8: goto pc+2")
-__xlated("9: r1 = r0")
-__xlated("10: call kernel-function")
-__xlated("11: r1 = r8")
-/* save __u64 *ctx to stack */
-__xlated("12: *(u64 *)(r10 -8) = r1")
-/* main prog */
-__xlated("13: r1 = *(u64 *)(r1 +0)")
-__xlated("14: r6 = r1")
-__xlated("15: call kernel-function")
-__xlated("16: r1 = r6")
-__xlated("17: call pc+")
-/* epilogue */
-__xlated("18: r1 = 0")
-__xlated("19: r6 = 0")
-__xlated("20: call kernel-function")
-__xlated("21: if r0 != 0x0 goto pc+6")
-__xlated("22: r1 = *(u64 *)(r10 -8)")
-__xlated("23: r1 = *(u64 *)(r1 +0)")
-__xlated("24: r6 = *(u64 *)(r1 +0)")
-__xlated("25: r6 += 10000")
-__xlated("26: *(u64 *)(r1 +0) = r6")
-__xlated("27: goto pc+2")
-__xlated("28: r1 = r0")
-__xlated("29: call kernel-function")
-__xlated("30: r0 = r6")
-__xlated("31: r0 *= 2")
-__xlated("32: exit")
-SEC("struct_ops/test_pro_epilogue")
-__naked int test_kfunc_pro_epilogue(void)
-{
-	asm volatile (
-	"r1 = *(u64 *)(r1 +0);"
-	"r6 = r1;"
-	"call %[bpf_kfunc_st_ops_inc10];"
-	"r1 = r6;"
-	"call subprog;"
-	"exit;"
-	:
-	: __imm(bpf_kfunc_st_ops_inc10)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__retval(22022) /* (PROLOGUE_A [1000] + KFUNC_INC10 + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
-int syscall_pro_epilogue(void *ctx)
-{
-	struct st_ops_args args = {};
-
-	return bpf_kfunc_st_ops_test_pro_epilogue(&args);
-}
-
-SEC(".struct_ops.link")
-struct bpf_testmod_st_ops pro_epilogue_with_kfunc = {
-	.test_pro_epilogue = (void *)test_kfunc_pro_epilogue,
-};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index bc07ce9d5477..1a5c163455de 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1400,85 +1400,6 @@ static int bpf_test_mod_st_ops__test_pro_epilogue(struct st_ops_args *args)
 	return 0;
 }
 
-static int bpf_cgroup_from_id_id;
-static int bpf_cgroup_release_id;
-
-static int st_ops_gen_prologue_with_kfunc(struct bpf_insn *insn_buf, bool direct_write,
-					  const struct bpf_prog *prog)
-{
-	struct bpf_insn *insn = insn_buf;
-
-	/* r8 = r1; // r8 will be "u64 *ctx".
-	 * r1 = 0;
-	 * r0 = bpf_cgroup_from_id(r1);
-	 * if r0 != 0 goto pc+5;
-	 * r6 = r8[0]; // r6 will be "struct st_ops *args".
-	 * r7 = r6->a;
-	 * r7 += 1000;
-	 * r6->a = r7;
-	 * goto pc+2;
-	 * r1 = r0;
-	 * bpf_cgroup_release(r1);
-	 * r1 = r8;
-	 */
-	*insn++ = BPF_MOV64_REG(BPF_REG_8, BPF_REG_1);
-	*insn++ = BPF_MOV64_IMM(BPF_REG_1, 0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_from_id_id);
-	*insn++ = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 5);
-	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_8, 0);
-	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_6, offsetof(struct st_ops_args, a));
-	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, 1000);
-	*insn++ = BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_7, offsetof(struct st_ops_args, a));
-	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 2);
-	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_release_id);
-	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_8);
-	*insn++ = prog->insnsi[0];
-
-	return insn - insn_buf;
-}
-
-static int st_ops_gen_epilogue_with_kfunc(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
-					  s16 ctx_stack_off)
-{
-	struct bpf_insn *insn = insn_buf;
-
-	/* r1 = 0;
-	 * r6 = 0;
-	 * r0 = bpf_cgroup_from_id(r1);
-	 * if r0 != 0 goto pc+6;
-	 * r1 = stack[ctx_stack_off]; // r1 will be "u64 *ctx"
-	 * r1 = r1[0]; // r1 will be "struct st_ops *args"
-	 * r6 = r1->a;
-	 * r6 += 10000;
-	 * r1->a = r6;
-	 * goto pc+2
-	 * r1 = r0;
-	 * bpf_cgroup_release(r1);
-	 * r0 = r6;
-	 * r0 *= 2;
-	 * BPF_EXIT;
-	 */
-	*insn++ = BPF_MOV64_IMM(BPF_REG_1, 0);
-	*insn++ = BPF_MOV64_IMM(BPF_REG_6, 0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_from_id_id);
-	*insn++ = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 6);
-	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_FP, ctx_stack_off);
-	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
-	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct st_ops_args, a));
-	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 10000);
-	*insn++ = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, offsetof(struct st_ops_args, a));
-	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 2);
-	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_release_id);
-	*insn++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_6);
-	*insn++ = BPF_ALU64_IMM(BPF_MUL, BPF_REG_0, 2);
-	*insn++ = BPF_EXIT_INSN();
-
-	return insn - insn_buf;
-}
-
-#define KFUNC_PRO_EPI_PREFIX "test_kfunc_"
 static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 			       const struct bpf_prog *prog)
 {
@@ -1488,9 +1409,6 @@ static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	    strcmp(prog->aux->attach_func_name, "test_pro_epilogue"))
 		return 0;
 
-	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
-		return st_ops_gen_prologue_with_kfunc(insn_buf, direct_write, prog);
-
 	/* r6 = r1[0]; // r6 will be "struct st_ops *args". r1 is "u64 *ctx".
 	 * r7 = r6->a;
 	 * r7 += 1000;
@@ -1514,9 +1432,6 @@ static int st_ops_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog
 	    strcmp(prog->aux->attach_func_name, "test_pro_epilogue"))
 		return 0;
 
-	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
-		return st_ops_gen_epilogue_with_kfunc(insn_buf, prog, ctx_stack_off);
-
 	/* r1 = stack[ctx_stack_off]; // r1 will be "u64 *ctx"
 	 * r1 = r1[0]; // r1 will be "struct st_ops *args"
 	 * r6 = r1->a;
@@ -1587,13 +1502,6 @@ static void st_ops_unreg(void *kdata, struct bpf_link *link)
 
 static int st_ops_init(struct btf *btf)
 {
-	struct btf *kfunc_btf;
-
-	bpf_cgroup_from_id_id = bpf_find_btf_id("bpf_cgroup_from_id", BTF_KIND_FUNC, &kfunc_btf);
-	bpf_cgroup_release_id = bpf_find_btf_id("bpf_cgroup_release", BTF_KIND_FUNC, &kfunc_btf);
-	if (bpf_cgroup_from_id_id < 0 || bpf_cgroup_release_id < 0)
-		return -EINVAL;
-
 	return 0;
 }
 

-- 
2.43.0


