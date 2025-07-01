Return-Path: <bpf+bounces-61917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97077AEEB75
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A91F3A90C0
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8251582899;
	Tue,  1 Jul 2025 00:54:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA85F1D5ABF;
	Tue,  1 Jul 2025 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331268; cv=none; b=Z3nk1JVR+WwXCdSqSwKVjKUCY/3+WyTadBpvaebveMuf27U9I7ymh/iNvCL0AUURpBjqrgVOKH0FNJ65NGsw3b1SAXVQ7w07xLwDWlkV9ZlBdJ/IpOYle6OTEKMP5SOs9YEywYK6lWL89+B+Ui3YuinorDTNSOSM1vMK7BZmWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331268; c=relaxed/simple;
	bh=q2QsKEvtnIKsRdYt6OTQ9dXxhzHlZleBu1wcHPb4KmA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fdRTXlvTZCatZU98wf/UjNBhzDTW5QNwXW2hcUfFWQOwWIynGojaKxuh+PgkdO6BIkgPP1U6tZaR5dR3i88/MdJrKfz0h1chq0X31j52ZVGBR/U+bYUWczeD50eCYpya5qHwb3+4hTSBhw6C8aoqaBL+iti2rB7aWB7TuphaCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id BEF2A1D2D80;
	Tue,  1 Jul 2025 00:54:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 6CFE56000B;
	Tue,  1 Jul 2025 00:54:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGt-00000007Nfl-0rbh;
	Mon, 30 Jun 2025 20:54:51 -0400
Message-ID: <20250701005451.055982038@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:24 -0400
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
Subject: [PATCH v12 03/14] unwind_user: Add compat mode frame pointer support
References: <20250701005321.942306427@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: 5hpuu3emhuceecpm319cziywgnc1ygs9
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 6CFE56000B
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19k3B6nUg7dyH2F0CIW8f4HjMWdFjC0G5o=
X-HE-Tag: 1751331254-312351
X-HE-Meta: U2FsdGVkX1/DSa5YrJ0EqUry+7RAgMfcXxUqCjstXSI5ukRGng9ZgNNxgrGk/YwqDao/Ro4lFJEFqz4L0LnbckzEagG/18D4Up9iuc1YwSGa1Z1sTGXvhyCAlf61vlU+qtaJ0IucN3D86xW10XDkW2mfFfD0ug/iHG9kSPuEZYz5dOsYUbS4DLjT4d4HRvG8qf8ZX16gv14+pbbAbU3OddcEjAqYbRLHIHon/qTdoS57X0ZThTx4Zy963MRatzUpPM/hliGsdDy9DANdbUb4hr3lKnpTyX0H/vlQL/kBIBSsCUtBGnVvc0WAR2l6NhZBhnUU+9/71gamt4qO9ljixls1lGHcDuWvZ4qu41UXuXZq+h36aR0RI7lDgml/S7X9poGAsT8Gmg5ra03jDoxU3mHHjWOKC5TQDujB4Yasr/g=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add optional support for user space compat mode frame pointer unwinding.
If supported, the arch needs to enable CONFIG_HAVE_UNWIND_USER_COMPAT_FP
and define ARCH_INIT_USER_COMPAT_FP_FRAME.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/Kconfig                            |  4 ++++
 include/asm-generic/Kbuild              |  1 +
 include/asm-generic/unwind_user_types.h |  5 ++++
 include/linux/unwind_user.h             |  5 ++++
 include/linux/unwind_user_types.h       |  7 ++++++
 kernel/unwind/user.c                    | 32 +++++++++++++++++++++----
 6 files changed, 50 insertions(+), 4 deletions(-)
 create mode 100644 include/asm-generic/unwind_user_types.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 8e3fd723bd74..2c41d3072910 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -442,6 +442,10 @@ config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
 
+config HAVE_UNWIND_USER_COMPAT_FP
+	bool
+	depends on HAVE_UNWIND_USER_FP
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 295c94a3ccc1..b797a2434396 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -60,6 +60,7 @@ mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
 mandatory-y += unwind_user.h
+mandatory-y += unwind_user_types.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += video.h
diff --git a/include/asm-generic/unwind_user_types.h b/include/asm-generic/unwind_user_types.h
new file mode 100644
index 000000000000..f568b82e52cd
--- /dev/null
+++ b/include/asm-generic/unwind_user_types.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_UNWIND_USER_TYPES_H
+#define _ASM_GENERIC_UNWIND_USER_TYPES_H
+
+#endif /* _ASM_GENERIC_UNWIND_USER_TYPES_H */
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index a405111c41b0..ac007363820a 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -9,6 +9,11 @@
  #define ARCH_INIT_USER_FP_FRAME
 #endif
 
+#ifndef ARCH_INIT_USER_COMPAT_FP_FRAME
+ #define ARCH_INIT_USER_COMPAT_FP_FRAME
+ #define in_compat_mode(regs) false
+#endif
+
 int unwind_user_start(struct unwind_user_state *state);
 int unwind_user_next(struct unwind_user_state *state);
 
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 65bd070eb6b0..0b6563951ca4 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -3,10 +3,16 @@
 #define _LINUX_UNWIND_USER_TYPES_H
 
 #include <linux/types.h>
+#include <asm/unwind_user_types.h>
+
+#ifndef arch_unwind_user_state
+struct arch_unwind_user_state {};
+#endif
 
 enum unwind_user_type {
 	UNWIND_USER_TYPE_NONE,
 	UNWIND_USER_TYPE_FP,
+	UNWIND_USER_TYPE_COMPAT_FP,
 };
 
 struct unwind_stacktrace {
@@ -25,6 +31,7 @@ struct unwind_user_state {
 	unsigned long ip;
 	unsigned long sp;
 	unsigned long fp;
+	struct arch_unwind_user_state arch;
 	enum unwind_user_type type;
 	bool done;
 };
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 1201d655654a..3a0ac4346f5b 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -12,12 +12,32 @@ static struct unwind_user_frame fp_frame = {
 	ARCH_INIT_USER_FP_FRAME
 };
 
+static struct unwind_user_frame compat_fp_frame = {
+	ARCH_INIT_USER_COMPAT_FP_FRAME
+};
+
 static inline bool fp_state(struct unwind_user_state *state)
 {
 	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP) &&
 	       state->type == UNWIND_USER_TYPE_FP;
 }
 
+static inline bool compat_fp_state(struct unwind_user_state *state)
+{
+	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) &&
+	       state->type == UNWIND_USER_TYPE_COMPAT_FP;
+}
+
+#define unwind_get_user_long(to, from, state)				\
+({									\
+	int __ret;							\
+	if (compat_fp_state(state))					\
+		__ret = get_user(to, (u32 __user *)(from));		\
+	else								\
+		__ret = get_user(to, (unsigned long __user *)(from));	\
+	__ret;								\
+})
+
 int unwind_user_next(struct unwind_user_state *state)
 {
 	struct unwind_user_frame *frame;
@@ -26,7 +46,9 @@ int unwind_user_next(struct unwind_user_state *state)
 	if (state->done)
 		return -EINVAL;
 
-	if (fp_state(state))
+	if (compat_fp_state(state))
+		frame = &compat_fp_frame;
+	else if (fp_state(state))
 		frame = &fp_frame;
 	else
 		goto done;
@@ -39,10 +61,10 @@ int unwind_user_next(struct unwind_user_state *state)
 		goto done;
 
 	/* Find the Return Address (RA) */
-	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+	if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
 		goto done;
 
-	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
+	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
 		goto done;
 
 	state->ip = ra;
@@ -68,7 +90,9 @@ int unwind_user_start(struct unwind_user_state *state)
 		return -EINVAL;
 	}
 
-	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
+	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(regs))
+		state->type = UNWIND_USER_TYPE_COMPAT_FP;
+	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 		state->type = UNWIND_USER_TYPE_FP;
 	else
 		state->type = UNWIND_USER_TYPE_NONE;
-- 
2.47.2



