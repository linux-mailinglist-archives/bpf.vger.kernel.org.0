Return-Path: <bpf+bounces-66221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8980CB2FC57
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6D91BC65FC
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A511E5710;
	Thu, 21 Aug 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oihZH/KS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED421E51FA;
	Thu, 21 Aug 2025 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785768; cv=none; b=QCaWmHDQ1DkuLg0MRwULAyFd1xX1QPPygfp3z0AxFSaMWMwMAzl6bb/pIWxrq/Lz1wEjK5f8MkxJyIFofkHlYIlQB4wmhMi1dh9B+SrANa3c4/HRe09xAoGgjJGA9k/4a88+k1fnVRm9BwJpjrcNDavTdH+NdomFfO2Zz9kAv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785768; c=relaxed/simple;
	bh=yTMUV4/eAHNW0xAJzqb/lh+W1hlD3KfGD1uIJ0E71Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4xm9cbLIm9Mrps1Atsi6IC2zqGqXB0nAfLHapHWJsClOKrBJ0LPoZ5e+wCZAae0sZWKiDkqn+zZ0tZAmZ8bWtJh0cxc51W/SpEcMCo8Sk2a/klz+T4S0huO/mw3uTj2nSkYomsCUkW99Lh3ZC3HnlDKbpLuL0oqekMmCuen4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oihZH/KS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317CBC4CEEB;
	Thu, 21 Aug 2025 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755785768;
	bh=yTMUV4/eAHNW0xAJzqb/lh+W1hlD3KfGD1uIJ0E71Vc=;
	h=From:To:Cc:Subject:Date:From;
	b=oihZH/KSEEw0IYGZ72N/z+vLnlXFHqXieAUmJ74Jow8zoInpON827HZ1vlcVRykXV
	 APQa+zgEGQI8M5jJxZZu0868QEh+BUwi/EQkVpLLiwG2HOtj3RM12pSO55yGYgh7vq
	 WM6P9JXhfd0aySmZ+RUWVu2t7sPhCkE7inWmWA8f1ioTdTyvHJfGjk/tI494rqlEVw
	 +5JsDlGX4CHxkQb2YPs5Eim7G0azwOhf44YLoiVMKszrpEnNm99UIJjGLDg7Ug0B/G
	 sM4LvMT1qAdxADCjxJoomCwduF9fraz0IftGa5O0sXJRNP0p1Dh21NGGyMn0xSr6r0
	 FSU25nahlmwIQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] selftests/bpf: Fix uprobe syscall shadow stack test
Date: Thu, 21 Aug 2025 16:15:57 +0200
Message-ID: <20250821141557.13233-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have uprobe syscall working properly with shadow stack,
we can remove testing limitations for shadow stack tests and make
sure uprobe gets properly optimized.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
sending fix for changes posted in here [1]

[1] https://lore.kernel.org/bpf/20250821122822.671515652@infradead.org/T/#m571d8b1975e1f4ade55aa972940d8568647ac113

 .../selftests/bpf/prog_tests/uprobe_syscall.c | 24 +++++--------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index c1f945cacebc..5da0b49eeaca 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -403,8 +403,6 @@ static void *find_nop5(void *fn)
 
 typedef void (__attribute__((nocf_check)) *trigger_t)(void);
 
-static bool shstk_is_enabled;
-
 static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigger,
 			  void *addr, int executed)
 {
@@ -413,7 +411,6 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
 		__s32 raddr;
 	} __packed *call;
 	void *tramp = NULL;
-	__u8 *bp;
 
 	/* Uprobe gets optimized after first trigger, so let's press twice. */
 	trigger();
@@ -422,17 +419,11 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
 	/* Make sure bpf program got executed.. */
 	ASSERT_EQ(skel->bss->executed, executed, "executed");
 
-	if (shstk_is_enabled) {
-		/* .. and check optimization is disabled under shadow stack. */
-		bp = (__u8 *) addr;
-		ASSERT_EQ(*bp, 0xcc, "int3");
-	} else {
-		/* .. and check the trampoline is as expected. */
-		call = (struct __arch_relative_insn *) addr;
-		tramp = (void *) (call + 1) + call->raddr;
-		ASSERT_EQ(call->op, 0xe8, "call");
-		ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
-	}
+	/* .. and check the trampoline is as expected. */
+	call = (struct __arch_relative_insn *) addr;
+	tramp = (void *) (call + 1) + call->raddr;
+	ASSERT_EQ(call->op, 0xe8, "call");
+	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
 
 	return tramp;
 }
@@ -440,7 +431,7 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
 static void check_detach(void *addr, void *tramp)
 {
 	/* [uprobes_trampoline] stays after detach */
-	ASSERT_OK(!shstk_is_enabled && find_uprobes_trampoline(tramp), "uprobes_trampoline");
+	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
 	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
 }
 
@@ -642,7 +633,6 @@ static void test_uretprobe_shadow_stack(void)
 	}
 
 	/* Run all the tests with shadow stack in place. */
-	shstk_is_enabled = true;
 
 	test_uprobe_regs_equal(false);
 	test_uprobe_regs_equal(true);
@@ -655,8 +645,6 @@ static void test_uretprobe_shadow_stack(void)
 
 	test_regs_change();
 
-	shstk_is_enabled = false;
-
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
 
-- 
2.50.1


