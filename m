Return-Path: <bpf+bounces-52095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB8FA3E35D
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 19:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEA219C1D69
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C82144D1;
	Thu, 20 Feb 2025 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3yyUQZP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E421215F7D
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074708; cv=none; b=Pk/mM87D62tqqPIU9kHjZf/82jmhHyNWyMaHWNmty89UWqCrzcdKczd0c6wk9Zz9poAAgpK1Q1sIvntZp/ri9RAjhw2QcnaiQ5gQl4NmAlGFLWLT4fM6A0jZMN1i0q6X17xdYZUe99zZ658ITAJ8jikSyLNf0YogDD+I+2Zgg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074708; c=relaxed/simple;
	bh=muc/46IY+rZ8a/c5kLZuhSpmlb1Ay0HWhzijL0Jkupw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3+9c7JGMofXRUj7y3C/cXotGf2ucS8xLkH3mtt3wIduI9X3tPaW1PW26dMEPtpwXozip/4J0h0IYylpc0d4XZmTV3kkIz4nbgzzTY7U8MT3dXBWvpYkfm1Tx3FnzYYZvPW12W6H5apDawPOnBzQQmVc5/BgkLjDKAFLroH2URc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3yyUQZP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fce3b01efcso707953a91.3
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 10:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740074705; x=1740679505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkE7FmLXL/wpfwmq6+0sVcMH1rdwDfl7AoyhflMSP5I=;
        b=R3yyUQZP39ATpmBTjIKyNXHrNqFtB3FJpcAMGBsH6pEv3L2PvKvsFJm0CDZFO5TxeL
         lY0uI6fmIKncyh8lJrbNc5Pcm+B+wnvskC8SzuiA1JCvBLGUvWumEKwO6ULF1kzG3b8F
         /nzyMYPmX2fEeVf3W5pq16LNjpM7FCRZhHwMol8gUfjSPpAWmkZyT9IjLOxh5ZtrwsQj
         FlCeI6zoNTGALBiV6/jR0itODFRxThNPDOhcMwVcRtYLP93XHPqFgviYUN82A6cujWb6
         hstVDoUHodDJZWqwaRRJnv/S5X28VSPg3q5FD18IQN2Q1LOHe2Vhm2SaNbX+WBDiCstF
         E7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074705; x=1740679505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkE7FmLXL/wpfwmq6+0sVcMH1rdwDfl7AoyhflMSP5I=;
        b=I3tDiBX3gkEntCUN7QMH3nRslQ+B9luCYLjoYr5iMNjRGTyyD2EX4hNHV+ZCel8Ipx
         MinpRIyQrnI07bCC5pmYOA1n71zh7s00B7rnrQ2thBPB1DQa//LU8Jso088yYN9tJNWR
         8xeii3ePQ2kJFqAExI03ZznEl4ilFXGf4NK0hOR6nRmHNb8GEFCMIZ75Md1mr7AtSMZ5
         y/puM9+gnSY0d/BtjaSC9zXJyWu2l0GCdZwxUXbqatPwtb1MSRj6m4sC7fqrZPlXHBbO
         I6uuQlj60o9LCMeLJDTDknpcbXb/g30+RLPafgoPCIw5jBu/sbiiTB39NyEiZT/vhyNH
         tIWw==
X-Gm-Message-State: AOJu0Yz0r279htkrP/Jo61H4FinIr7ftn4C3EudDjwm/030uWiJZfDTp
	83XxAz/cXQsvUdGPVoK7MqAkR/ZyYWnpfDquajeFQn49oiDTY+K8MoEoSw==
X-Gm-Gg: ASbGnct8OEzlFOTbeZ5HuRwBfiVtiWJ4/i+pQpr+F2x0OGQqzFLN1lnGe3+nnSQth48
	Ky53/CCs64U5TV9AkonLbpOQkCstmKz5qIMl4dyuFhjxHM8+wiMRV7VWYZhG4zrqLMKcLnnIPsd
	XEzZyo27ebh8y1b3XZxnVBQV+espygx3Wgg4Umf5SBVJQ8CEf0eBhnbkNtintlvxBKXCjZWPy1R
	6v+bkjDUzewsKtTGgsvFW6IJ3kwdUqxvuIG1KFehK9F+1Bf9AWjTktDDEYFSTrLxyTnjRI899lO
	oASVZVrqnVRAmrmz0Lvxp0oiVyMk2X1/mpAKeFywQN+bV8zgy5UJJFhvibR92Wd6ug==
X-Google-Smtp-Source: AGHT+IFoHn8x/bglcvZJxK6G+gTlK2TREXIbIJ8u0mpK84waJpmSWolMjoMoHJaZEEbNMY9gWPB5WQ==
X-Received: by 2002:a17:90b:4a07:b0:2ee:bc1d:f98b with SMTP id 98e67ed59e1d1-2fce7b058e3mr117374a91.31.1740074705413;
        Thu, 20 Feb 2025 10:05:05 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ba60c1sm14399682a91.44.2025.02.20.10.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:05:05 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Test gen_pro/epilogue that generate kfuncs
Date: Thu, 20 Feb 2025 10:04:55 -0800
Message-ID: <20250220180455.436748-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220180455.436748-1-ameryhung@gmail.com>
References: <20250220180455.436748-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test gen_prologue and gen_epilogue that generate kfuncs that have not
been seen in the main program.

The main bpf program and return value checks are identical to
pro_epilogue.c introduced in commit 47e69431b57a ("selftests/bpf: Test
gen_prologue and gen_epilogue"). However, now when bpf_testmod_st_ops
detects a program name with prefix "test_kfunc_", it generates slightly
different prologue and epilogue: They still add 1000 to args->a in
prologue, add 10000 to args->a and set r0 to 2 * args->a in epilogue,
but involve kfuncs.

At high level, the alternative version of prologue and epilogue look
like this:

  cgrp = bpf_cgroup_from_id(0);
  if (cgrp)
          bpf_cgroup_release(cgrp);
  else
          /* Perform what original bpf_testmod_st_ops prologue or
           * epilogue does
           */

Since 0 is never a valid cgroup id, the original prologue or epilogue
logic will be performed. As a result, the __retval check should expect
the exact same return value.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/btf.c                              |   1 +
 .../selftests/bpf/prog_tests/pro_epilogue.c   |   2 +
 .../bpf/progs/pro_epilogue_with_kfunc.c       | 182 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  90 +++++++++
 4 files changed, 275 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6c296ff551e0..ddebab05934f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -606,6 +606,7 @@ s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
 	spin_unlock_bh(&btf_idr_lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(bpf_find_btf_id);
 
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
 					       u32 id, u32 *res_id)
diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
index 509883e6823a..5d3c00a08a88 100644
--- a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
+++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
@@ -6,6 +6,7 @@
 #include "epilogue_tailcall.skel.h"
 #include "pro_epilogue_goto_start.skel.h"
 #include "epilogue_exit.skel.h"
+#include "pro_epilogue_with_kfunc.skel.h"
 
 struct st_ops_args {
 	__u64 a;
@@ -55,6 +56,7 @@ void test_pro_epilogue(void)
 	RUN_TESTS(pro_epilogue);
 	RUN_TESTS(pro_epilogue_goto_start);
 	RUN_TESTS(epilogue_exit);
+	RUN_TESTS(pro_epilogue_with_kfunc);
 	if (test__start_subtest("tailcall"))
 		test_tailcall();
 }
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c b/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c
new file mode 100644
index 000000000000..c8fc31c4c3c4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+void __kfunc_btf_root(void)
+{
+	bpf_kfunc_st_ops_inc10(NULL);
+}
+
+static __noinline __used int subprog(struct st_ops_args *args)
+{
+	args->a += 1;
+	return args->a;
+}
+
+__success
+/* prologue */
+__xlated("0: r8 = r1")
+__xlated("1: r1 = 0")
+__xlated("2: call kernel-function")
+__xlated("3: if r0 != 0x0 goto pc+5")
+__xlated("4: r6 = *(u64 *)(r8 +0)")
+__xlated("5: r7 = *(u64 *)(r6 +0)")
+__xlated("6: r7 += 1000")
+__xlated("7: *(u64 *)(r6 +0) = r7")
+__xlated("8: goto pc+2")
+__xlated("9: r1 = r0")
+__xlated("10: call kernel-function")
+__xlated("11: r1 = r8")
+/* main prog */
+__xlated("12: r1 = *(u64 *)(r1 +0)")
+__xlated("13: r6 = r1")
+__xlated("14: call kernel-function")
+__xlated("15: r1 = r6")
+__xlated("16: call pc+1")
+__xlated("17: exit")
+SEC("struct_ops/test_prologue")
+__naked int test_kfunc_prologue(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"r6 = r1;"
+	"call %[bpf_kfunc_st_ops_inc10];"
+	"r1 = r6;"
+	"call subprog;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_st_ops_inc10)
+	: __clobber_all);
+}
+
+__success
+/* save __u64 *ctx to stack */
+__xlated("0: *(u64 *)(r10 -8) = r1")
+/* main prog */
+__xlated("1: r1 = *(u64 *)(r1 +0)")
+__xlated("2: r6 = r1")
+__xlated("3: call kernel-function")
+__xlated("4: r1 = r6")
+__xlated("5: call pc+")
+/* epilogue */
+__xlated("6: r1 = 0")
+__xlated("7: call kernel-function")
+__xlated("8: if r0 != 0x0 goto pc+6")
+__xlated("9: r1 = *(u64 *)(r10 -8)")
+__xlated("10: r1 = *(u64 *)(r1 +0)")
+__xlated("11: r6 = *(u64 *)(r1 +0)")
+__xlated("12: r6 += 10000")
+__xlated("13: *(u64 *)(r1 +0) = r6")
+__xlated("14: goto pc+2")
+__xlated("15: r1 = r0")
+__xlated("16: call kernel-function")
+__xlated("17: r0 = r6")
+__xlated("18: r0 *= 2")
+__xlated("19: exit")
+SEC("struct_ops/test_epilogue")
+__naked int test_kfunc_epilogue(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"r6 = r1;"
+	"call %[bpf_kfunc_st_ops_inc10];"
+	"r1 = r6;"
+	"call subprog;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_st_ops_inc10)
+	: __clobber_all);
+}
+
+__success
+/* prologue */
+__xlated("0: r8 = r1")
+__xlated("1: r1 = 0")
+__xlated("2: call kernel-function")
+__xlated("3: if r0 != 0x0 goto pc+5")
+__xlated("4: r6 = *(u64 *)(r8 +0)")
+__xlated("5: r7 = *(u64 *)(r6 +0)")
+__xlated("6: r7 += 1000")
+__xlated("7: *(u64 *)(r6 +0) = r7")
+__xlated("8: goto pc+2")
+__xlated("9: r1 = r0")
+__xlated("10: call kernel-function")
+__xlated("11: r1 = r8")
+/* save __u64 *ctx to stack */
+__xlated("12: *(u64 *)(r10 -8) = r1")
+/* main prog */
+__xlated("13: r1 = *(u64 *)(r1 +0)")
+__xlated("14: r6 = r1")
+__xlated("15: call kernel-function")
+__xlated("16: r1 = r6")
+__xlated("17: call pc+")
+/* epilogue */
+__xlated("18: r1 = 0")
+__xlated("19: call kernel-function")
+__xlated("20: if r0 != 0x0 goto pc+6")
+__xlated("21: r1 = *(u64 *)(r10 -8)")
+__xlated("22: r1 = *(u64 *)(r1 +0)")
+__xlated("23: r6 = *(u64 *)(r1 +0)")
+__xlated("24: r6 += 10000")
+__xlated("25: *(u64 *)(r1 +0) = r6")
+__xlated("26: goto pc+2")
+__xlated("27: r1 = r0")
+__xlated("28: call kernel-function")
+__xlated("29: r0 = r6")
+__xlated("30: r0 *= 2")
+__xlated("31: exit")
+SEC("struct_ops/test_pro_epilogue")
+__naked int test_kfunc_pro_epilogue(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"r6 = r1;"
+	"call %[bpf_kfunc_st_ops_inc10];"
+	"r1 = r6;"
+	"call subprog;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_st_ops_inc10)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__retval(1011) /* PROLOGUE_A [1000] + KFUNC_INC10 + SUBPROG_A [1] */
+int syscall_prologue(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_prologue(&args);
+}
+
+SEC("syscall")
+__retval(20022) /* (KFUNC_INC10 + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+int syscall_epilogue(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_epilogue(&args);
+}
+
+SEC("syscall")
+__retval(22022) /* (PROLOGUE_A [1000] + KFUNC_INC10 + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+int syscall_pro_epilogue(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_pro_epilogue(&args);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_st_ops pro_epilogue_with_kfunc = {
+	.test_prologue = (void *)test_kfunc_prologue,
+	.test_epilogue = (void *)test_kfunc_epilogue,
+	.test_pro_epilogue = (void *)test_kfunc_pro_epilogue,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 89dc502de9d4..ecf2ef073fee 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1308,6 +1308,83 @@ static int bpf_test_mod_st_ops__test_pro_epilogue(struct st_ops_args *args)
 	return 0;
 }
 
+static int bpf_cgroup_from_id_id;
+static int bpf_cgroup_release_id;
+
+static int st_ops_gen_prologue_with_kfunc(struct bpf_insn *insn_buf, bool direct_write,
+					  const struct bpf_prog *prog)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	/* r8 = r1; // r8 will be "u64 *ctx".
+	 * r1 = 0;
+	 * r0 = bpf_cgroup_from_id(r1);
+	 * if r0 != 0 goto pc+5;
+	 * r6 = r8[0]; // r6 will be "struct st_ops *args".
+	 * r7 = r6->a;
+	 * r7 += 1000;
+	 * r6->a = r7;
+	 * goto pc+2;
+	 * r1 = r0;
+	 * bpf_cgroup_release(r1);
+	 * r1 = r8;
+	 */
+	*insn++ = BPF_MOV64_REG(BPF_REG_8, BPF_REG_1);
+	*insn++ = BPF_MOV64_IMM(BPF_REG_1, 0);
+	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_from_id_id);
+	*insn++ = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 5);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_8, 0);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_6, offsetof(struct st_ops_args, a));
+	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, 1000);
+	*insn++ = BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_7, offsetof(struct st_ops_args, a));
+	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 2);
+	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
+	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_release_id),
+	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_8);
+	*insn++ = prog->insnsi[0];
+
+	return insn - insn_buf;
+}
+
+static int st_ops_gen_epilogue_with_kfunc(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
+					  s16 ctx_stack_off)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	/* r1 = 0;
+	 * r0 = bpf_cgroup_from_id(r1);
+	 * if r0 != 0 goto pc+6;
+	 * r1 = stack[ctx_stack_off]; // r1 will be "u64 *ctx"
+	 * r1 = r1[0]; // r1 will be "struct st_ops *args"
+	 * r6 = r1->a;
+	 * r6 += 10000;
+	 * r1->a = r6;
+	 * goto pc+2
+	 * r1 = r0;
+	 * bpf_cgroup_release(r1);
+	 * r0 = r6;
+	 * r0 *= 2;
+	 * BPF_EXIT;
+	 */
+	*insn++ = BPF_MOV64_IMM(BPF_REG_1, 0);
+	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_from_id_id);
+	*insn++ = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 6);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_FP, ctx_stack_off);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct st_ops_args, a));
+	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 10000);
+	*insn++ = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, offsetof(struct st_ops_args, a));
+	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 2);
+	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
+	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_release_id),
+	*insn++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_6);
+	*insn++ = BPF_ALU64_IMM(BPF_MUL, BPF_REG_0, 2);
+	*insn++ = BPF_EXIT_INSN();
+
+	return insn - insn_buf;
+}
+
+#define KFUNC_PRO_EPI_PREFIX "test_kfunc_"
 static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 			       const struct bpf_prog *prog)
 {
@@ -1317,6 +1394,9 @@ static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	    strcmp(prog->aux->attach_func_name, "test_pro_epilogue"))
 		return 0;
 
+	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
+		return st_ops_gen_prologue_with_kfunc(insn_buf, direct_write, prog);
+
 	/* r6 = r1[0]; // r6 will be "struct st_ops *args". r1 is "u64 *ctx".
 	 * r7 = r6->a;
 	 * r7 += 1000;
@@ -1340,6 +1420,9 @@ static int st_ops_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog
 	    strcmp(prog->aux->attach_func_name, "test_pro_epilogue"))
 		return 0;
 
+	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
+		return st_ops_gen_epilogue_with_kfunc(insn_buf, prog, ctx_stack_off);
+
 	/* r1 = stack[ctx_stack_off]; // r1 will be "u64 *ctx"
 	 * r1 = r1[0]; // r1 will be "struct st_ops *args"
 	 * r6 = r1->a;
@@ -1410,6 +1493,13 @@ static void st_ops_unreg(void *kdata, struct bpf_link *link)
 
 static int st_ops_init(struct btf *btf)
 {
+	struct btf *kfunc_btf;
+
+	bpf_cgroup_from_id_id = bpf_find_btf_id("bpf_cgroup_from_id", BTF_KIND_FUNC, &kfunc_btf);
+	bpf_cgroup_release_id = bpf_find_btf_id("bpf_cgroup_release", BTF_KIND_FUNC, &kfunc_btf);
+	if (!bpf_cgroup_from_id_id || !bpf_cgroup_release_id)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.47.1


