Return-Path: <bpf+bounces-61908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A403DAEEB60
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A376716A212
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB075157A67;
	Tue,  1 Jul 2025 00:54:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072DA339A1;
	Tue,  1 Jul 2025 00:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331262; cv=none; b=DwlDf+eWzuIsaT0FbYXskPaVY3kXR4Zvnq0D/7F43GYJhvOBFncLWBWlO4JN2k6OshBwgKBG3jn/FCgBXEs4iG5Hft7H94pNdfNus+r+Y7sDJyOPj0D65mtW9rcPG/mL6BKdz7CTDdLi2P7qMRRBNBYQE1tiiFZ3GTcub7amAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331262; c=relaxed/simple;
	bh=5Iasa2WIfq3X+AqTWa+BKLntbTlcAOBg3PK5qlqtnys=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=J/P3Hja/HvhB24Y3jYQJIQ8DNehTbtpolUJBdDMD8O5PsiNGhWnt26oSedFvwXRuzm/wUPKhkKwxC/ClQl+zFhKrHNWSiBDzHKDP5nKS+RXhvc4KCxszoAbhZ/Hnnugnc07W6DKZbyCM0pr16861G0LcRp5+Hbbm7+/mpko4PhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 9F89CB75E5;
	Tue,  1 Jul 2025 00:54:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 35D1C20025;
	Tue,  1 Jul 2025 00:54:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGt-00000007NfE-096E;
	Mon, 30 Jun 2025 20:54:51 -0400
Message-ID: <20250701005450.888492528@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v12 02/14] unwind_user: Add frame pointer support
References: <20250701005321.942306427@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: cmy8obsme1cmom97qsitmp8chnekokxo
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 35D1C20025
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1910KeiyFB1zMtgzd1/IStIF7uzHz5wEpY=
X-HE-Tag: 1751331254-994453
X-HE-Meta: U2FsdGVkX1/8PikpHKWDXxedWTvuKqpUfhekNDq3rJv+5P1OCBp9S+8p9nRSkMOCYnitPJY3ampgGueKaT5heZUNC3waAjV3A1oTcgNX3ujTyUs4vxIjn6HosG/k7QUlHjzk/sTEmOkaA0n1KX9hDRD+LhqK1pDPljKM+48YHEZH5vS8deXZzBoBzHbQCqQxeBCgIanF5J556Ns7OqiifCJ0pS5bSVnOxyRkI8ImQ6oKLAgEFMzwDt0Be5HvpRTz1ZXLszB4Gtah69pDMU4c3kDSTj2nklU0b9his2TkQjKVgENwJasPmCuUObBIBkwb4oPI8pVkxGcs7YApO7PHJsKtdBYipgx+EjwTJMEPN5lrHSHxEIjjOONOBkV4Ey9k4lmDUVNVZbJN6GIMImTwsM+F2SI5BFRa69WYlYm3rMM=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add optional support for user space frame pointer unwinding.  If
supported, the arch needs to enable CONFIG_HAVE_UNWIND_USER_FP and
define ARCH_INIT_USER_FP_FRAME.

By encoding the frame offsets in struct unwind_user_frame, much of this
code can also be reused for future unwinder implementations like sframe.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/Kconfig                      |  4 +++
 include/asm-generic/Kbuild        |  1 +
 include/asm-generic/unwind_user.h |  5 +++
 include/linux/unwind_user.h       |  5 +++
 include/linux/unwind_user_types.h |  1 +
 kernel/unwind/user.c              | 51 +++++++++++++++++++++++++++++--
 6 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 include/asm-generic/unwind_user.h

diff --git a/arch/Kconfig b/arch/Kconfig
index ea59e5d7cc69..8e3fd723bd74 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -438,6 +438,10 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 config UNWIND_USER
 	bool
 
+config HAVE_UNWIND_USER_FP
+	bool
+	select UNWIND_USER
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 8675b7b4ad23..295c94a3ccc1 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -59,6 +59,7 @@ mandatory-y += tlbflush.h
 mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
+mandatory-y += unwind_user.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += video.h
diff --git a/include/asm-generic/unwind_user.h b/include/asm-generic/unwind_user.h
new file mode 100644
index 000000000000..b8882b909944
--- /dev/null
+++ b/include/asm-generic/unwind_user.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_UNWIND_USER_H
+#define _ASM_GENERIC_UNWIND_USER_H
+
+#endif /* _ASM_GENERIC_UNWIND_USER_H */
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index aa7923c1384f..a405111c41b0 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -3,6 +3,11 @@
 #define _LINUX_UNWIND_USER_H
 
 #include <linux/unwind_user_types.h>
+#include <asm/unwind_user.h>
+
+#ifndef ARCH_INIT_USER_FP_FRAME
+ #define ARCH_INIT_USER_FP_FRAME
+#endif
 
 int unwind_user_start(struct unwind_user_state *state);
 int unwind_user_next(struct unwind_user_state *state);
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 6ed1b4ae74e1..65bd070eb6b0 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -6,6 +6,7 @@
 
 enum unwind_user_type {
 	UNWIND_USER_TYPE_NONE,
+	UNWIND_USER_TYPE_FP,
 };
 
 struct unwind_stacktrace {
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index d30449328981..1201d655654a 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -6,10 +6,54 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
+#include <linux/uaccess.h>
+
+static struct unwind_user_frame fp_frame = {
+	ARCH_INIT_USER_FP_FRAME
+};
+
+static inline bool fp_state(struct unwind_user_state *state)
+{
+	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP) &&
+	       state->type == UNWIND_USER_TYPE_FP;
+}
 
 int unwind_user_next(struct unwind_user_state *state)
 {
-	/* no implementation yet */
+	struct unwind_user_frame *frame;
+	unsigned long cfa = 0, fp, ra = 0;
+
+	if (state->done)
+		return -EINVAL;
+
+	if (fp_state(state))
+		frame = &fp_frame;
+	else
+		goto done;
+
+	/* Get the Canonical Frame Address (CFA) */
+	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
+
+	/* stack going in wrong direction? */
+	if (cfa <= state->sp)
+		goto done;
+
+	/* Find the Return Address (RA) */
+	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+		goto done;
+
+	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
+		goto done;
+
+	state->ip = ra;
+	state->sp = cfa;
+	if (frame->fp_off)
+		state->fp = fp;
+
+	return 0;
+
+done:
+	state->done = true;
 	return -EINVAL;
 }
 
@@ -24,7 +68,10 @@ int unwind_user_start(struct unwind_user_state *state)
 		return -EINVAL;
 	}
 
-	state->type = UNWIND_USER_TYPE_NONE;
+	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
+		state->type = UNWIND_USER_TYPE_FP;
+	else
+		state->type = UNWIND_USER_TYPE_NONE;
 
 	state->ip = instruction_pointer(regs);
 	state->sp = user_stack_pointer(regs);
-- 
2.47.2



