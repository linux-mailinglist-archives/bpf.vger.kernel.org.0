Return-Path: <bpf+bounces-37624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB71E958462
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2979BB2801C
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4BD18EFD4;
	Tue, 20 Aug 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxsiaUG1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074A18FC79
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149463; cv=none; b=bUnXKyzu1Z91efbcqBSY+tbbGjZhOMyG4gi2aiOg9pK7Hvcb70DhTbmrsi+S3ZO2D3LAt0pFjIEfdWjyw7RK4DtH3lUECwlnylCLX2nmNnDNwdv0i+rHDCtsp6/pcR/xt0K/DEJ6izJvR/M6Ldz4YIH7dytDYwt/hRsPLW1a4Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149463; c=relaxed/simple;
	bh=MOwEd5WaTuidL1At3Q85rfKIgf1ZvTMqBh/FpL19+d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5smIrk8hDUZH31YPGPydGU8eaMyNHGSWepVDvYpin+aadyJB/CnI/iPVVUdmisvDdT31o7ePnep6zzxGyLVnq33+bWeH9xm31TtkEje6YOB+9s1Zh18jqlBjCbct+guk5MPZ3/nwjLn+QsWQymtc+NyXsBxnkFwR7w4svmFpzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxsiaUG1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso4043714a91.2
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 03:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149461; x=1724754261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XF6LED9hCLCc1TGB+X4DY2KX7XE1HShy+5rzy1zSX5Y=;
        b=kxsiaUG1xISpOHtseXolGluLpt4SrqHRPPcBXh2oyIfeMGpxtO+7VL6V4zJYUBcOAL
         s5GHI9GHO+otZlP4fWNM2C7n0QkHsAzybwzDx4l0bAk1muuCqzY311LA5f/7tpbz2eZl
         AtkJRX7NTVit1+4luGDdpm1zrX2p4cBwWjOEDGAj0d317ORmD0AN9MtMP4Nr7z6pbCdi
         DidpViNSkoFpPKIJvzbvSfMXPvb+h94Sx9mgRXQS5rm2XUkOtbPzWaPA143MKlsmFtq9
         4BuyQMJpMSBL3BHst759gQkLWaI85IJsXcmCblLZadFBF2FlJ7zqLN4gacj6Q8rwFHEe
         hC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149461; x=1724754261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XF6LED9hCLCc1TGB+X4DY2KX7XE1HShy+5rzy1zSX5Y=;
        b=YCfHV30cs25nvi4rTKBMA76qcta51C+k3kUGOUaScgWZ2WPKcFsF2MESpBUGSKe1t2
         diUT1QYqXGnr9lKzyeb0ZL4GRvDQPQoIn90JfiDWtGaM+RRpaQo3QFPtm2Q0Ca8qURtQ
         J6tdWu00Lb5lUkQn+TKlaIlgD9rcrbE6qMveaNG0ARSHxx8yQMzlyvw2zVPY7JxAu/Yr
         td1Rpm2Z5onJ9CMQUnU/2uxbLW2JvDgFNbS0mWdnyDsxWkEZfjsuCtavm4up9poxIDbH
         sYOeC7dDILO1SepSROlra88ekxLTZM+6H/GfLQPQmXd/juPetkboku9K3Y4XdzwZg0gE
         4otQ==
X-Gm-Message-State: AOJu0YyXi1AMgTeDFYDZl4Pmwa3UtUgKi2sKTN6gNqwXnrElV3IOFOty
	gg7t127rmtgig+JiE2vs3YuN9nK+26SBHD94o/Wi3rHXmMR8OhlcxcwAuoIS
X-Google-Smtp-Source: AGHT+IHg6U5/DV8tRBrAXQn8+Gz2llJLjGmC9NKkyp3y0gafCkElt3j5fKf0pU5JEz8x2r/9ACy08Q==
X-Received: by 2002:a17:90b:70e:b0:2d3:bc5e:8452 with SMTP id 98e67ed59e1d1-2d3e0561f93mr14067733a91.32.1724149460454;
        Tue, 20 Aug 2024 03:24:20 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8976166a91.27.2024.08.20.03.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:24:20 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	hffilwlqm@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 7/8] selftests/bpf: validate jit behaviour for tail calls
Date: Tue, 20 Aug 2024 03:23:56 -0700
Message-ID: <20240820102357.3372779-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820102357.3372779-1-eddyz87@gmail.com>
References: <20240820102357.3372779-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A program calling sub-program which does a tail call.
The idea is to verify instructions generated by jit for tail calls:
- in program and sub-program prologues;
- for subprogram call instruction;
- for tail call itself.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_tailcall_jit.c         | 105 ++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index f8f546eba488..cf3662dbd24f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -75,6 +75,7 @@
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_subprog_precision.skel.h"
 #include "verifier_subreg.skel.h"
+#include "verifier_tailcall_jit.skel.h"
 #include "verifier_typedef.skel.h"
 #include "verifier_uninit.skel.h"
 #include "verifier_unpriv.skel.h"
@@ -198,6 +199,7 @@ void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
+void test_verifier_tailcall_jit(void)         { RUN(verifier_tailcall_jit); }
 void test_verifier_typedef(void)              { RUN(verifier_typedef); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
new file mode 100644
index 000000000000..06d327cf1e1f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+int main(void);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__array(values, void (void));
+} jmp_table SEC(".maps") = {
+	.values = {
+		[0] = (void *) &main,
+	},
+};
+
+__noinline __auxiliary
+static __naked int sub(void)
+{
+	asm volatile (
+	"r2 = %[jmp_table] ll;"
+	"r3 = 0;"
+	"call 12;"
+	"exit;"
+	:
+	: __imm_addr(jmp_table)
+	: __clobber_all);
+}
+
+__success
+__arch_x86_64
+/* program entry for main(), regular function prologue */
+__jited("	endbr64")
+__jited("	nopl	(%rax,%rax)")
+__jited("	xorq	%rax, %rax")
+__jited("	pushq	%rbp")
+__jited("	movq	%rsp, %rbp")
+/* tail call prologue for program:
+ * - establish memory location for tail call counter at &rbp[-8];
+ * - spill tail_call_cnt_ptr at &rbp[-16];
+ * - expect tail call counter to be passed in rax;
+ * - for entry program rax is a raw counter, value < 33;
+ * - for tail called program rax is tail_call_cnt_ptr (value > 33).
+ */
+__jited("	endbr64")
+__jited("	cmpq	$0x21, %rax")
+__jited("	ja	L0")
+__jited("	pushq	%rax")
+__jited("	movq	%rsp, %rax")
+__jited("	jmp	L1")
+__jited("L0:	pushq	%rax")			/* rbp[-8]  = rax         */
+__jited("L1:	pushq	%rax")			/* rbp[-16] = rax         */
+/* on subprogram call restore rax to be tail_call_cnt_ptr from rbp[-16]
+ * (cause original rax might be clobbered by this point)
+ */
+__jited("	movq	-0x10(%rbp), %rax")
+__jited("	callq	0x{{.*}}")		/* call to sub()          */
+__jited("	xorl	%eax, %eax")
+__jited("	leave")
+__jited("	retq")
+__jited("...")
+/* subprogram entry for sub(), regular function prologue */
+__jited("	endbr64")
+__jited("	nopl	(%rax,%rax)")
+__jited("	nopl	(%rax)")
+__jited("	pushq	%rbp")
+__jited("	movq	%rsp, %rbp")
+/* tail call prologue for subprogram address of tail call counter
+ * stored at rbp[-16].
+ */
+__jited("	endbr64")
+__jited("	pushq	%rax")			/* rbp[-8]  = rax          */
+__jited("	pushq	%rax")			/* rbp[-16] = rax          */
+__jited("	movabsq	${{.*}}, %rsi")		/* r2 = &jmp_table         */
+__jited("	xorl	%edx, %edx")		/* r3 = 0                  */
+/* bpf_tail_call implementation:
+ * - load tail_call_cnt_ptr from rbp[-16];
+ * - if *tail_call_cnt_ptr < 33, increment it and jump to target;
+ * - otherwise do nothing.
+ */
+__jited("	movq	-0x10(%rbp), %rax")
+__jited("	cmpq	$0x21, (%rax)")
+__jited("	jae	L0")
+__jited("	nopl	(%rax,%rax)")
+__jited("	addq	$0x1, (%rax)")		/* *tail_call_cnt_ptr += 1 */
+__jited("	popq	%rax")
+__jited("	popq	%rax")
+__jited("	jmp	{{.*}}")		/* jump to tail call tgt   */
+__jited("L0:	leave")
+__jited("	retq")
+SEC("tc")
+__naked int main(void)
+{
+	asm volatile (
+	"call %[sub];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(sub)
+	: __clobber_all);
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.45.2


