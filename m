Return-Path: <bpf+bounces-36749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE294C7E1
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 03:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979B71C22A81
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 01:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C47947A;
	Fri,  9 Aug 2024 01:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbHBeMNb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABE58F5E
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165555; cv=none; b=XIP4eNniWbAUDQjqQdRy21AK1F/HERUb399eB5oGRwvNp3JD3VevMmmkHJdZstDBT04/3N8Lx8Wwq9jj8ChHM3tgwRD34fWpsoEdYp7ctQlmFf9uKgKHv1CxCGJuwRWIYATizeaLomEY04AV0s59Pu4o8JOOvDKQ4Id/elUBsEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165555; c=relaxed/simple;
	bh=EgeL4RrSGKogPAXhFdM47AF9nV5PFYXAdWvyJ/QMzqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSv9L6c8jKhh+kGCQaTP8hrejhBNOK5zQJnUzUgavAiRUJ1PtKcLlvShSaccgThgM331ybZPxu5qOD3vbtsweQhRH3ufXQoYu/6d8fi8pS78cd1HKG65UGFXRIpdRaot44J/KOgON5m0GeO1cKujMI9Z3w/zDPZWmB9dNNS6zSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbHBeMNb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d18112b60so1021463b3a.1
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 18:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723165553; x=1723770353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lpr1bqtVW2E6vV1iJ3WXpF3fVUh4Rj80PjVcMFzSYQ=;
        b=VbHBeMNbhRKyIGiwpefaRyBdK5u/N/ksgerWMUyn4T5pfZJwTLhAe0s+arvwvd8ttK
         k23dFGDVK/+MZ5uPH5X2060+0oSAoFUwQS6jbPjhmW0DLvF+evU1fjz+8GW5wnzV3hze
         ImARmWyow1VMsBi65e0HhUl6L1Yme1rDBX8N6LE5Sdaf2ep/i7eIDd05HHu3o6xVQ//p
         uLyK5A8R3iPeAdYxDmP0a522MpKDja7MImH8EpGY7H5PXk21JGlQNB5n4M9kvRoEeQ8F
         y+XhlBRV407eoNp0gUxiYJQox/x+MzH+XUxLI9jRMVWYrj3nYHJVtOp/8QARRlV1ksIb
         T+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723165553; x=1723770353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lpr1bqtVW2E6vV1iJ3WXpF3fVUh4Rj80PjVcMFzSYQ=;
        b=oKRA5b/V6Lj6CrX0bPAm0NxwrJIH4kueCGIzBhWogikxyikOCcaPYD+DMU+BIWo+Vz
         fuZC8E3sQK2KraTL9vAysJMN9EbyNzaEtfrCuezJlYTAu29GYnM6IdLogP3BBxjjvcGP
         WP0LsEGQecIwa+5wXj8KilHSGGZTAkNBS5nXdGK2SDFvDvK96S0+JEFmCar/vqHXjn94
         rsqFxd3BIfW/x0RegMzrNmg1clxyeOPfC2i3DsHDsrFvMr1t87fu9snhzpVz/1uvjr8n
         92bhiQHPEE+dOK5XTyVi9siROOiTuGju9Z83LlGeq68bojv0ZcJo0SEaKjh0xhl9FR9l
         fv3Q==
X-Gm-Message-State: AOJu0YxXG3kpzk1Je7WjHwguj6I8PJY9ElFdtsBqZvSWRkdL8d8a78XU
	YdcDYqKTfUlQeuLGwMuM3L9DbU2vwjGt17YtSq4Fy40J3EvpEmeAF7vvDNB0KC0=
X-Google-Smtp-Source: AGHT+IGE4Ikh+5eDIy3QM4Ft/V0qpdQVkbR0n/AuV7ezmvUWia2EuIwepjOh517+B//n3U55fxvjrg==
X-Received: by 2002:a05:6a00:9155:b0:70e:cf99:adc7 with SMTP id d2e1a72fcca58-710cc6e629cmr6376091b3a.3.1723165553316;
        Thu, 08 Aug 2024 18:05:53 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2fc0d8sm1678626b3a.205.2024.08.08.18.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 18:05:52 -0700 (PDT)
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
Subject: [PATCH bpf-next 4/4] selftests/bpf: validate jit behaviour for tail calls
Date: Thu,  8 Aug 2024 18:05:18 -0700
Message-ID: <20240809010518.1137758-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809010518.1137758-1-eddyz87@gmail.com>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
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


