Return-Path: <bpf+bounces-30109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179F28CAC9D
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A742839AE
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EC676025;
	Tue, 21 May 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BidipBjr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE46D1BC;
	Tue, 21 May 2024 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288612; cv=none; b=Bl8TpK1+yvt4AMVxG+5++m3kN89jBF3gJAB56vhxDUVRFApGTamBsCyTEl3f55F4IZQ07tSk1DEX3ZbfF4ONfAQpjdY9Ohq7LwYXEkdzof1FyAfe8OtUh3Z0DQTiKOu4BEn44asloQ667Pbj7fodeHlvj8GyYc4uRrmgqMoe82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288612; c=relaxed/simple;
	bh=n/oAy5vJBvR1F5+qZWIuxrNBXKK0jB6rNDZbMLCp8L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6UPiAWtiPF8cFjgpbpn9YJskw9QIUbtlcyNjf7MBoGzWorSRK3IOm9Mnn6+ln9yHCr+HT5JVAgajTpX+KnCOGvSF5tNNPU0yxBs4RUZ1FRmgTKL1WF/ObdXXbMWSWkldGdXYsCKJA9I4du8bkBQ1VA4cd2Tf7NMQwiLm5kAbEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BidipBjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B7BC2BD11;
	Tue, 21 May 2024 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716288611;
	bh=n/oAy5vJBvR1F5+qZWIuxrNBXKK0jB6rNDZbMLCp8L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BidipBjrGuOkSoCJXdzboXiMvk2URky/b33HNpaGWJeUHyhqmKZS0OY9NUF9hcHb7
	 6ie3tZdttprh1P9doOvDqnaQq4dtM++Pwem1Iqw5jwBxjU1nc2ctH8vDeucDTmSxqH
	 DmH7Dpe5eAn1gBD5e5TERM9HuHJp+TDqomJ4uz92gwssuxkmZJ4JV6raoZw1PjLn5K
	 wK7Qw139BYrqlgSyF4fOYjCfWZDJsVKbsTMvxC+WrLfSl92f8fRbzEMbXYeDkMW2NC
	 3H5cwzIVjiyC4CTb578+XkLarmsYLvVYirxPHdws2MuGC+cdG0pxza3/c019sMX+WF
	 7nRFnK+VteRIw==
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
Subject: [PATCHv6 bpf-next 8/9] selftests/bpf: Add uretprobe shadow stack test
Date: Tue, 21 May 2024 12:48:24 +0200
Message-ID: <20240521104825.1060966-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521104825.1060966-1-jolsa@kernel.org>
References: <20240521104825.1060966-1-jolsa@kernel.org>
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
2.45.0


