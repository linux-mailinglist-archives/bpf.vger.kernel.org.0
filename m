Return-Path: <bpf+bounces-57874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09415AB1AE7
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E289A0512F
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269432397BF;
	Fri,  9 May 2025 16:51:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C42367CD;
	Fri,  9 May 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809498; cv=none; b=PyRBoBeQDOc9PrPMstinsecNCKtzIS0YZ10Urg3dCw0/mnjoAT9+AIzeA7kKCcB5183ABSA3EwHx4Rll1VU0vsjYs/BEnL3d9tDXcyoupAzEWYOy20lOv8evNlHGuQ7FqPNC7Sy7xM2kAX4+NY4PlCxmE/sBcb5bXvoezpnHcgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809498; c=relaxed/simple;
	bh=YQCIvf5LGT5XFWsFFOofkXUiq80zAe/dxuiLdDbLBHk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Fe76uPud3A3nXg10ZHLbQ838OLKxLWRqPOV4pQ5GqiL6VWQ0CoRyMyRUJKvJZvlHE1emc44Mkbijagq778EC0vLgTjWDovnisveMimpdV3n95EwPVyyJOeLx1r2EtSgqSuDAG/9DlFIhdcGTUVIPN74lhdZw9jwCAjq4A87EQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C9CC4CEF1;
	Fri,  9 May 2025 16:51:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uDQx0-00000002gEE-0RSL;
	Fri, 09 May 2025 12:51:54 -0400
Message-ID: <20250509165153.956076418@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 09 May 2025 12:45:26 -0400
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
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v8 02/18] unwind_user: Add frame pointer support
References: <20250509164524.448387100@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add optional support for user space frame pointer unwinding.  If
supported, the arch needs to enable CONFIG_HAVE_UNWIND_USER_FP and
define ARCH_INIT_USER_FP_FRAME.

By encoding the frame offsets in struct unwind_user_frame, much of this
code can also be reused for future unwinder implementations like sframe.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/Kconfig                      |  4 +++
 include/asm-generic/unwind_user.h |  9 ++++++
 include/linux/unwind_user_types.h |  1 +
 kernel/unwind/user.c              | 51 +++++++++++++++++++++++++++++--
 4 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 include/asm-generic/unwind_user.h

diff --git a/arch/Kconfig b/arch/Kconfig
index ccbcead9fac0..0e3844c0e200 100644
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
diff --git a/include/asm-generic/unwind_user.h b/include/asm-generic/unwind_user.h
new file mode 100644
index 000000000000..832425502fb3
--- /dev/null
+++ b/include/asm-generic/unwind_user.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_UNWIND_USER_H
+#define _ASM_GENERIC_UNWIND_USER_H
+
+#ifndef ARCH_INIT_USER_FP_FRAME
+ #define ARCH_INIT_USER_FP_FRAME
+#endif
+
+#endif /* _ASM_GENERIC_UNWIND_USER_H */
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
index d30449328981..0671a81494d3 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -6,10 +6,54 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
+#include <linux/uaccess.h>
+#include <asm/unwind_user.h>
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
+	struct unwind_user_frame _frame;
+	struct unwind_user_frame *frame = &_frame;
+	unsigned long cfa = 0, fp, ra = 0;
+
+	if (state->done)
+		return -EINVAL;
+
+	if (fp_state(state))
+		frame = &fp_frame;
+	else
+		goto the_end;
+
+	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
+
+	/* stack going in wrong direction? */
+	if (cfa <= state->sp)
+		goto the_end;
+
+	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+		goto the_end;
+
+	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
+		goto the_end;
+
+	state->ip = ra;
+	state->sp = cfa;
+	if (frame->fp_off)
+		state->fp = fp;
+
+	return 0;
+
+the_end:
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



