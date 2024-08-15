Return-Path: <bpf+bounces-37299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FCD953C39
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3593D1F2230D
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5F1411F9;
	Thu, 15 Aug 2024 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8cAoh2a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF3914B092
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755397; cv=none; b=jnm4GStWZPnut4raEul8+u5w2o7qqOzfwKl86FY4fDQQlVItImn0KtaXI6vgj2ug/5yOpyuDXuXA0FNAkbwMs6KZqTwRaYswJYDhp40Og7QHl1udxqquykhhjsO+iCiaZ5WsVKEsqR2IBHelhsREoj2oZEq/yeAplKo5sWyINkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755397; c=relaxed/simple;
	bh=EgeL4RrSGKogPAXhFdM47AF9nV5PFYXAdWvyJ/QMzqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRybc+soBs3eivimeq4nS1P6VjKmkRjP76apeingU1GCjOZkz+bb36/IdoW9uwy868FE0/3ObDek3l9/WGqW0pU0b/B4mJkOE5pK5MO0sPeMbQntdVQ85d4D6VmsPy6bLxaNWyui8LGWKcwMF4FF1YxfjoID0X6l2KTeM+7/6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8cAoh2a; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3e44b4613so144995a91.3
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 13:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723755395; x=1724360195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lpr1bqtVW2E6vV1iJ3WXpF3fVUh4Rj80PjVcMFzSYQ=;
        b=N8cAoh2aEjLh2/sixYwJHLD5GlYqjHkr0lC+/yCcgLVmDvrqmFPeRdZqw2/v952Oo+
         UBOn6k7TKv9MznB8lhSbMr79lD3nVxS51e9axa5LHu92LsHl7v4hYPuqBr7K+5b52M9d
         5gySJloI/GDEUmbLP1O2KMvLF6m199XtcPRQ4T2JC4+hLX+3sg6yZp7XGJlEL8pp0Voi
         Mo1Z0lhvrkZX/Rqd76zRhsxfSPRogI/fMZjllqtBcLoY8l1LfYPbSnnpAP0Z1WQazS5c
         9VXx4lwuaJtJilleCWwsH/RwO20VLJuyvwQXfOleiCcswnOg8GMj1gSSogXF4d9I3DTq
         6DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755395; x=1724360195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lpr1bqtVW2E6vV1iJ3WXpF3fVUh4Rj80PjVcMFzSYQ=;
        b=RSh68brU1eYoyGJhlsIknLDR6guOVLLCETuiCcX7CzsFe3hrdmQ8dU2qrCqTnh3Y1c
         gfYLS+BHb67GrEqhba7e6ukPKQ7CwE0WWWssGlhFZQ842Bm7dEKi52by/241BGNz+dI6
         Ian+FEnUeDIZHvwS7hj7tQfM8FCxsaeml781v9aiIgtcWDwGt/cBP58b0+P7KMR0FqJA
         8r77aHRy1MMojM1Z8/XpgrPA8htWEsjOQTPvWYnv3k0Qq8DBB9Ib0Y36J4xhIgqZlq4e
         h7dUeipRgA5F/hmhY58HYGmw3GNiFDyoRbq6f7czvDZ3dvyqYC8SiAGkZnNimH/GAj7T
         gNbg==
X-Gm-Message-State: AOJu0YxggIUMkoMWgPlpKkWtm02ZKommnNxxjMfwp7I2AFGBCRrinwHN
	D6U7EUF/at8a15SibWxkBTNu+bUggmxHngGwQnOJBer5O0MMWQUqra2DZCL60No=
X-Google-Smtp-Source: AGHT+IG4cz9ct5y4bBv0MIajKNmPWEKmuEWcGUPLXvrsBZxl4aOHWRwUW7uLVjs50Pgqip751qGJnA==
X-Received: by 2002:a17:90a:eb08:b0:2c9:8189:7b4f with SMTP id 98e67ed59e1d1-2d3e00f4185mr976209a91.32.1723755394978;
        Thu, 15 Aug 2024 13:56:34 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7f2eb2sm4024364a91.26.2024.08.15.13.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 13:56:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: validate jit behaviour for tail calls
Date: Thu, 15 Aug 2024 13:54:49 -0700
Message-ID: <20240815205449.242556-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815205449.242556-1-eddyz87@gmail.com>
References: <20240815205449.242556-1-eddyz87@gmail.com>
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
 .../bpf/progs/verifier_tailcall_jit.c         | 103 ++++++++++++++++++
 2 files changed, 105 insertions(+)
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
index 000000000000..1a09c76d7be0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
@@ -0,0 +1,103 @@
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
+/* program entry for main(), regular function prologue */
+__jit_x86("	endbr64")
+__jit_x86("	nopl	(%rax,%rax)")
+__jit_x86("	xorq	%rax, %rax")
+__jit_x86("	pushq	%rbp")
+__jit_x86("	movq	%rsp, %rbp")
+/* tail call prologue for program:
+ * - establish memory location for tail call counter at &rbp[-8];
+ * - spill tail_call_cnt_ptr at &rbp[-16];
+ * - expect tail call counter to be passed in rax;
+ * - for entry program rax is a raw counter, value < 33;
+ * - for tail called program rax is tail_call_cnt_ptr (value > 33).
+ */
+__jit_x86("	endbr64")
+__jit_x86("	cmpq	$0x21, %rax")
+__jit_x86("	ja	L0")
+__jit_x86("	pushq	%rax")
+__jit_x86("	movq	%rsp, %rax")
+__jit_x86("	jmp	L1")
+__jit_x86("L0:	pushq	%rax")			/* rbp[-8]  = rax         */
+__jit_x86("L1:	pushq	%rax")			/* rbp[-16] = rax         */
+/* on subprogram call restore rax to be tail_call_cnt_ptr from rbp[-16]
+ * (cause original rax might be clobbered by this point)
+ */
+__jit_x86("	movq	-0x10(%rbp), %rax")
+__jit_x86("	callq	0x[0-9a-f]\\+")		/* call to sub()          */
+__jit_x86("	xorl	%eax, %eax")
+__jit_x86("	leave")
+__jit_x86("	retq")
+/* subprogram entry for sub(), regular function prologue */
+__jit_x86("	endbr64")
+__jit_x86("	nopl	(%rax,%rax)")
+__jit_x86("	nopl	(%rax)")
+__jit_x86("	pushq	%rbp")
+__jit_x86("	movq	%rsp, %rbp")
+/* tail call prologue for subprogram address of tail call counter
+ * stored at rbp[-16].
+ */
+__jit_x86("	endbr64")
+__jit_x86("	pushq	%rax")			/* rbp[-8]  = rax          */
+__jit_x86("	pushq	%rax")			/* rbp[-16] = rax          */
+__jit_x86("	movabsq	$-0x[0-9a-f]\\+, %rsi")	/* r2 = &jmp_table         */
+__jit_x86("	xorl	%edx, %edx")		/* r3 = 0                  */
+/* bpf_tail_call implementation:
+ * - load tail_call_cnt_ptr from rbp[-16];
+ * - if *tail_call_cnt_ptr < 33, increment it and jump to target;
+ * - otherwise do nothing.
+ */
+__jit_x86("	movq	-0x10(%rbp), %rax")
+__jit_x86("	cmpq	$0x21, (%rax)")
+__jit_x86("	jae	L0")
+__jit_x86("	nopl	(%rax,%rax)")
+__jit_x86("	addq	$0x1, (%rax)")		/* *tail_call_cnt_ptr += 1 */
+__jit_x86("	popq	%rax")
+__jit_x86("	popq	%rax")
+__jit_x86("	jmp	0x[0-9a-f]\\+")		/* jump to tail call tgt   */
+__jit_x86("L0:	leave")
+__jit_x86("	retq")
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


