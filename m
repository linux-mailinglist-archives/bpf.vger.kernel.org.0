Return-Path: <bpf+bounces-62585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B16AFBFD2
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A962425050
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84FE1F8677;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge+s6SrG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211E35893;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937838; cv=none; b=MRvnhRomKHL7QboTLysNFlVl3nwrHfQD9eoK0KOgH06i5Ja++kDEaIC1w1LPuwRv3NPfXEkBRyeKWJYXU6N58PwVMY9zuy4G1FJKPOyz4GEXH8cHFrOQsuH6AGwFB9pYzQp3C8mxAFCslv67dpJyv1crK3KU3sbJgnJErEoLOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937838; c=relaxed/simple;
	bh=aN8l2NtS9Oba9cJOPW3Q9OnFBUI6l6LjWtk/C1O7k5w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=a4FzgBqrvrQUZpW63hnaqEs6XLn55pu67ekjkNMJB15zAK2B7XOjBK2s1cUV5P2dfsGLn+GYo0WfWo2NBY6vbWYNPy/NtLyxcIybCqj7SCccKRebvRvhUxbQzHcmFpZJ+rWFUA1NDy8y9hw7RMGe2xpHwj77VpsWFvxjd5yZEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge+s6SrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6606C4CEF4;
	Tue,  8 Jul 2025 01:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937838;
	bh=aN8l2NtS9Oba9cJOPW3Q9OnFBUI6l6LjWtk/C1O7k5w=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Ge+s6SrGDoYX7jmof8Ey6SY4sX3JaZYAukf71gTKevMu4R3kBDb09MQgv5HgB/9zS
	 DGvuNdEbB1rlqgpyKWCEbB7ZkmDB42D5MRaRTECkzIHKIgS/A/uTMcp07Ye/QJX3Vp
	 gbZD7dj7Ahn5pcybQNFtcmSpxzPuYUgaK6TlUALQrtKliP9y4GWxJLdoxfEvXpwwnN
	 bwC5xjxEJXY/xe4CyEwUJIWrnHtQI5mdpDGJ/WvWezd4A7j7NSROFsnXX4XtZOzpHq
	 +xAduRJm1BCRObcEXL32vJuUAI7FAgsvSjNifHTo3jzgM+h1sy1+QJh+w00pzTtaBz
	 fQrFHqhuawD1g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3u-00000000Bq0-0Xzw;
	Mon, 07 Jul 2025 21:23:58 -0400
Message-ID: <20250708012357.982692711@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
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
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v13 02/14] unwind_user: Add frame pointer support
References: <20250708012239.268642741@kernel.org>
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
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v12: https://lore.kernel.org/20250701005450.888492528@goodmis.org

- Added test when use_fp is true to make sure fp < sp (Jens Remus)

- Make sure the address read is word aligned (Linus Torvalds)

 arch/Kconfig                      |  4 ++
 include/asm-generic/Kbuild        |  1 +
 include/asm-generic/unwind_user.h |  5 +++
 include/linux/unwind_user.h       |  5 +++
 include/linux/unwind_user_types.h |  1 +
 kernel/unwind/user.c              | 65 ++++++++++++++++++++++++++++++-
 6 files changed, 79 insertions(+), 2 deletions(-)
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
index 1d77bed8de2c..7f7282516bf5 100644
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
 
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
 
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
index d0cf3ee2706d..62b3ef37d71b 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -6,13 +6,71 @@
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
 
 #define for_each_user_frame(state) \
 	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
 
 static int unwind_user_next(struct unwind_user_state *state)
 {
-	/* no implementation yet */
+	struct unwind_user_frame *frame;
+	unsigned long cfa = 0, fp, ra = 0;
+	unsigned int shift;
+
+	if (state->done)
+		return -EINVAL;
+
+	if (fp_state(state))
+		frame = &fp_frame;
+	else
+		goto done;
+
+	if (frame->use_fp) {
+		if (state->fp < state->sp)
+			goto done;
+		cfa = state->fp;
+	} else {
+		cfa = state->sp;
+	}
+
+	/* Get the Canonical Frame Address (CFA) */
+	cfa += frame->cfa_off;
+
+	/* stack going in wrong direction? */
+	if (cfa <= state->sp)
+		goto done;
+
+	/* Make sure that the address is word aligned */
+	shift = sizeof(long) == 4 ? 2 : 3;
+	if ((cfa + frame->ra_off) & ((1 << shift) - 1))
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
 
@@ -27,7 +85,10 @@ static int unwind_user_start(struct unwind_user_state *state)
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



