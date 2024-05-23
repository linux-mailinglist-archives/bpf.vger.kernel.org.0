Return-Path: <bpf+bounces-30396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEDA8CD207
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 14:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1091F21790
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1613A14A622;
	Thu, 23 May 2024 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISKfJZRU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14A1494A6;
	Thu, 23 May 2024 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466415; cv=none; b=CYKqg/XjyOEMeNC8/P8Si0G4xYwEafFr/UOjC6UG4dViEHH6vs87CK5bqJXSz4e2Uef7uJU1khTbl4Q5dp/A/uJ6Ag57NqA/tntQB1y7E9hvzY9DHJWBc/4DI3exYYPAcwluzZWtxD7mW5eOFloLZLqqEmEKkuzyFSmes4jjUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466415; c=relaxed/simple;
	bh=NLl5mEZyEGlLBWZKWJAZJaAbIuD+JryQyaQkxyvfexw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsMHd59nn3QCG6loT9mO/ETUWFmsBTjXhntKYix05VVwXNsGNSaXMC9s6HhlFr+KeoUpO8Z9jCCKKzD2LXXMsmAVfe6GOJOsN7qERMX4ORGpD11A16D61gNc+kNLNohexWZbMy2+JFGXi9Q68FnfobBmEpWStomofWMMRRGtZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISKfJZRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2B2C2BD10;
	Thu, 23 May 2024 12:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716466415;
	bh=NLl5mEZyEGlLBWZKWJAZJaAbIuD+JryQyaQkxyvfexw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISKfJZRU6QGq4EeCtkm2TtebUHjizOeiUILC/UJ75B3Skx+CNJt4zKFYYqENb+luB
	 baAIh7+QhBIIM9JPQCWamdlcovEBWfz6+1MSetOrHcYaoR2q6x9cCYhGxEEhGN8L97
	 mPE1BDRYNG6vNh/9dN4D4BqfcG2+DKnNiIrF4XbDInHfZ1sYM67yrXG7BdHcsakEBH
	 FElEwn2n08YDPn4iVOPP4ZbToZbX00AffhsdOmfVhykG9PRZML46hBsGAtdsPEfQtO
	 0atjDwGG4dEGiDOTIvankn7n/PmcW0ZlEwtrypoPFksmvBByiGLO4T5/kRslu+gUGT
	 nCHn5xioZp93g==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCHv7 bpf-next 8/9] selftests/bpf: Add uretprobe shadow stack test
Date: Thu, 23 May 2024 14:11:48 +0200
Message-ID: <20240523121149.575616-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523121149.575616-1-jolsa@kernel.org>
References: <20240523121149.575616-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uretprobe shadow stack test that runs all existing
uretprobe tests with shadow stack enabled if it's available.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 3ef324c2db50..fda456401284 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -9,6 +9,9 @@
 #include <linux/compiler.h>
 #include <linux/stringify.h>
 #include <sys/wait.h>
+#include <sys/syscall.h>
+#include <sys/prctl.h>
+#include <asm/prctl.h>
 #include "uprobe_syscall.skel.h"
 #include "uprobe_syscall_executed.skel.h"
 
@@ -297,6 +300,56 @@ static void test_uretprobe_syscall_call(void)
 	close(go[1]);
 	close(go[0]);
 }
+
+/*
+ * Borrowed from tools/testing/selftests/x86/test_shadow_stack.c.
+ *
+ * For use in inline enablement of shadow stack.
+ *
+ * The program can't return from the point where shadow stack gets enabled
+ * because there will be no address on the shadow stack. So it can't use
+ * syscall() for enablement, since it is a function.
+ *
+ * Based on code from nolibc.h. Keep a copy here because this can't pull
+ * in all of nolibc.h.
+ */
+#define ARCH_PRCTL(arg1, arg2)					\
+({								\
+	long _ret;						\
+	register long _num  asm("eax") = __NR_arch_prctl;	\
+	register long _arg1 asm("rdi") = (long)(arg1);		\
+	register long _arg2 asm("rsi") = (long)(arg2);		\
+								\
+	asm volatile (						\
+		"syscall\n"					\
+		: "=a"(_ret)					\
+		: "r"(_arg1), "r"(_arg2),			\
+		  "0"(_num)					\
+		: "rcx", "r11", "memory", "cc"			\
+	);							\
+	_ret;							\
+})
+
+#ifndef ARCH_SHSTK_ENABLE
+#define ARCH_SHSTK_ENABLE	0x5001
+#define ARCH_SHSTK_DISABLE	0x5002
+#define ARCH_SHSTK_SHSTK	(1ULL <<  0)
+#endif
+
+static void test_uretprobe_shadow_stack(void)
+{
+	if (ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK)) {
+		test__skip();
+		return;
+	}
+
+	/* Run all of the uretprobe tests. */
+	test_uretprobe_regs_equal();
+	test_uretprobe_regs_change();
+	test_uretprobe_syscall_call();
+
+	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
+}
 #else
 static void test_uretprobe_regs_equal(void)
 {
@@ -312,6 +365,11 @@ static void test_uretprobe_syscall_call(void)
 {
 	test__skip();
 }
+
+static void test_uretprobe_shadow_stack(void)
+{
+	test__skip();
+}
 #endif
 
 void test_uprobe_syscall(void)
@@ -322,4 +380,6 @@ void test_uprobe_syscall(void)
 		test_uretprobe_regs_change();
 	if (test__start_subtest("uretprobe_syscall_call"))
 		test_uretprobe_syscall_call();
+	if (test__start_subtest("uretprobe_shadow_stack"))
+		test_uretprobe_shadow_stack();
 }
-- 
2.45.1


