Return-Path: <bpf+bounces-61989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D28AF03A9
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD166442F14
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8C3288C37;
	Tue,  1 Jul 2025 19:19:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B72288C17;
	Tue,  1 Jul 2025 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397551; cv=none; b=lNVII0oeW74Y6nU4Hl0bMSyADUJlYQmbWNY2z6rLHfe2X1M9b41RMG3bRRxIoIZIefFZprWMQNFOKC7Jbkd889ye/0rRskNj+g36XRRsfflYtd7xbfPJPislB06bwfmQIB+c9o+o9Y2SGsyOKafCDWAjPsMeOzFK+kSn1XE7gHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397551; c=relaxed/simple;
	bh=hU7wh3L/Y6kWz2ZPGTguNkdzYwHWR2713HobCoHObyQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pXUvSB4W++cl8pcvZ2TloT032YYPlOEiCfvMTg/l/VF+YvkE2jr5HXBB/JPDy2WLrvX3I5pfrgpZd3g5/gZfl8IpVLPLqu/XCgoji5/G5eiwebkwD/pWZeX34+rCKCQ7N8XMzD71EQyDjts3nuxv8ngapvpeSdjxl3DGFchZK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ED2C4AF09;
	Tue,  1 Jul 2025 19:19:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWg3s-00000007gpe-38uG;
	Tue, 01 Jul 2025 14:50:32 -0400
Message-ID: <20250701185032.600017825@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Jul 2025 14:49:45 -0400
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
Subject: [PATCH v7 06/12] unwind_user/sframe: Wire up unwind_user to sframe
References: <20250701184939.026626626@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Now that the sframe infrastructure is fully in place, make it work by
hooking it up to the unwind_user interface.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/Kconfig                      |  1 +
 include/linux/unwind_user_types.h |  1 +
 kernel/unwind/user.c              | 25 ++++++++++++++++++++++---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c54d35e2f860..0c6056ef13de 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -448,6 +448,7 @@ config HAVE_UNWIND_USER_COMPAT_FP
 
 config HAVE_UNWIND_USER_SFRAME
 	bool
+	select UNWIND_USER
 
 config HAVE_PERF_REGS
 	bool
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 0b6563951ca4..4d50476e950e 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -13,6 +13,7 @@ enum unwind_user_type {
 	UNWIND_USER_TYPE_NONE,
 	UNWIND_USER_TYPE_FP,
 	UNWIND_USER_TYPE_COMPAT_FP,
+	UNWIND_USER_TYPE_SFRAME,
 };
 
 struct unwind_stacktrace {
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 2bb7995c3f23..139ca9740875 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -7,6 +7,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
 #include <linux/uaccess.h>
+#include <linux/sframe.h>
 
 static struct unwind_user_frame fp_frame = {
 	ARCH_INIT_USER_FP_FRAME
@@ -28,6 +29,12 @@ static inline bool compat_fp_state(struct unwind_user_state *state)
 	       state->type == UNWIND_USER_TYPE_COMPAT_FP;
 }
 
+static inline bool sframe_state(struct unwind_user_state *state)
+{
+	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_SFRAME) &&
+	       state->type == UNWIND_USER_TYPE_SFRAME;
+}
+
 #define unwind_get_user_long(to, from, state)				\
 ({									\
 	int __ret;							\
@@ -41,17 +48,27 @@ static inline bool compat_fp_state(struct unwind_user_state *state)
 int unwind_user_next(struct unwind_user_state *state)
 {
 	struct unwind_user_frame *frame;
+	struct unwind_user_frame _frame;
 	unsigned long cfa = 0, fp, ra = 0;
 
 	if (state->done)
 		return -EINVAL;
 
-	if (compat_fp_state(state))
+	if (compat_fp_state(state)) {
 		frame = &compat_fp_frame;
-	else if (fp_state(state))
+	} else if (sframe_state(state)) {
+		/* sframe expects the frame to be local storage */
+		frame = &_frame;
+		if (sframe_find(state->ip, frame)) {
+			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
+				goto done;
+			frame = &fp_frame;
+		}
+	} else if (fp_state(state)) {
 		frame = &fp_frame;
-	else
+	} else {
 		goto done;
+	}
 
 	/* Get the Canonical Frame Address (CFA) */
 	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
@@ -94,6 +111,8 @@ int unwind_user_start(struct unwind_user_state *state)
 
 	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(regs))
 		state->type = UNWIND_USER_TYPE_COMPAT_FP;
+	else if (current_has_sframe())
+		state->type = UNWIND_USER_TYPE_SFRAME;
 	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 		state->type = UNWIND_USER_TYPE_FP;
 	else
-- 
2.47.2



