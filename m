Return-Path: <bpf+bounces-31817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836099039F0
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2191C22525
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0240817BB23;
	Tue, 11 Jun 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UURsNnVW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130D17B435;
	Tue, 11 Jun 2024 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105023; cv=none; b=CHkUjUiu8uekNw6DkjSfChXCttKipV5pM6x7Mv7CUPBaTQpaAHiGSYwz+9KG0b6wDff4TgMndv3o2mzyX2n9rsGRx1c8g0o2t8smqLtJ2m1aMXbL6X8CXTGIkRiBqqppaBdUUyi6TE1ZebzsKYQj9aaDZv1VfgjIRtqKsin4vpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105023; c=relaxed/simple;
	bh=kBK6B58Bhm3uiXQkslA98Oc+NYgflR4HydITuxmbZ60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diYo6hBN1JIJzH7quvbGzC+rbcegadsJA7+PAqmVYsf124iZQrdFNUspsQyUKo4taT2mPPQh13RmZdyfydnnygXLYtOMUkr7EJ61/nFTK49RMF7T9E6CWiF6X+hRUvyNmBO3WsL1xmttqdE9t5FQ5+NvqYHsWk2DhfcvXQduIOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UURsNnVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6F7C2BD10;
	Tue, 11 Jun 2024 11:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718105023;
	bh=kBK6B58Bhm3uiXQkslA98Oc+NYgflR4HydITuxmbZ60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UURsNnVWR31opOrXriepN03nD8Dx7jAHOlXVkSYgqBXCFb01g6w2wAa3LuhYaRYy1
	 iU39oQCu2vyWqOsw/u87i49jFQW9Nb26HKhj72NwVlXJvPa6PwospB/bxBfTsN7i/R
	 BHA7GQlgoPLrqqg3/WVq/AEJ/exYqwhn7NMhdcHu+LIsTvMmxgKw6ja3OMFrMOz4/L
	 9hihFD9BAnCbedRRjYKRFmAgl4YX5Xftxbqd3U30G8DMLLKmeCtCeQdyyXh4A7EwCT
	 cE2L0SBeID3yXlK3ZCRI4D2/ao74Dj0KR/Vv0owVvdUQu02EyyX7a1fYSZclhTSjnW
	 qjyjhkqgBV+2g==
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
Subject: [PATCHv8 bpf-next 8/9] selftests/bpf: Add uretprobe shadow stack test
Date: Tue, 11 Jun 2024 13:21:57 +0200
Message-ID: <20240611112158.40795-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611112158.40795-1-jolsa@kernel.org>
References: <20240611112158.40795-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uretprobe shadow stack test that runs all existing
uretprobe tests with shadow stack enabled if it's available.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 11ccd693ef73..c8517c8f5313 100644
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


