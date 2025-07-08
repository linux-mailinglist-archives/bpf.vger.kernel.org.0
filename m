Return-Path: <bpf+bounces-62589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F23AAFBFD5
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CFB42516C
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5A72063E7;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqpRwcK/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F1E1EA7C6;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937838; cv=none; b=PxGxND3uIqJKX53lxQSlv0g0P8LmFfI3cBJZ9hqhm+kSFonPoMbLbYdsfZWn8diVjmybMZ5JnQdh3/o+gYEDALESbKvwdhaHR6CtCmrp79f/EH/9nImJUFfwebML2tnG0qx5F1wzF7RaMBMn/+MKwvWNaA9YyOBrbBN5I1s4KYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937838; c=relaxed/simple;
	bh=dfL0gbtknedEceNctRgbDHaSJtmSBoNoNXZNsBMMW1c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GUqoueBLA1TYN8iDlH1lq6aqs38UwEpE3RQggagGsSHt8mkK/j6c7PXkcqW3Cff+zvx5yq/ynLYmogI5o3FQpKuZKJM/ILhikp82jVgXV2NbQZwMagOetiZS7L/u/ictNDD44BPrzk7kq6zhzPT5uzR18Q1hJ03QMqnMu8m9gAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqpRwcK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C520C16AAE;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937838;
	bh=dfL0gbtknedEceNctRgbDHaSJtmSBoNoNXZNsBMMW1c=;
	h=Date:From:To:Cc:Subject:References:From;
	b=uqpRwcK/bG9SZp/VXcJjnELvjDQs2ILRMig+MhPpf02DPs1OSEdylEqZAyVHZmp5y
	 r1j96iJnvSRAn5PTBi6gUm8lRJdc+MhVuv8M1haurFp3N/v6/psTM5pPiFbTID1mK2
	 L/WF9Uv/mLJeXcV/rBhDLksduyLVp/EIJ8RrkvnCDFrynMT6nG4QW0X9VbemV7Vd/+
	 lwgrtcpPlJ1fSILMhQTZTuizVdERTy/VnSrtYvnql44hBfOzPvlRMjC5jVCNUf553d
	 sC71V8WBZrO2HRss1oP1vpOqQb1LIEB37nKWMEbAEjArfAXjj8wN+k0lt814G2QFzj
	 AMhU/834O6c1Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3u-00000000BqU-1Gcz;
	Mon, 07 Jul 2025 21:23:58 -0400
Message-ID: <20250708012358.152451558@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:42 -0400
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
Subject: [PATCH v13 03/14] unwind_user: Add compat mode frame pointer support
References: <20250708012239.268642741@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add optional support for user space compat mode frame pointer unwinding.
If supported, the arch needs to enable CONFIG_HAVE_UNWIND_USER_COMPAT_FP
and define ARCH_INIT_USER_COMPAT_FP_FRAME.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v12: https://lore.kernel.org/20250701005451.055982038@goodmis.org

- With new alignment check, updated to handle compat mode.

 arch/Kconfig                            |  4 +++
 include/asm-generic/Kbuild              |  1 +
 include/asm-generic/unwind_user_types.h |  5 ++++
 include/linux/unwind_user.h             |  5 ++++
 include/linux/unwind_user_types.h       |  7 +++++
 kernel/unwind/user.c                    | 34 +++++++++++++++++++++----
 6 files changed, 51 insertions(+), 5 deletions(-)
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
index 7f7282516bf5..834b643afd3a 100644
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
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
 
 #endif /* _LINUX_UNWIND_USER_H */
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
index 62b3ef37d71b..03775191447c 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -12,6 +12,10 @@ static struct unwind_user_frame fp_frame = {
 	ARCH_INIT_USER_FP_FRAME
 };
 
+static struct unwind_user_frame compat_fp_frame = {
+	ARCH_INIT_USER_COMPAT_FP_FRAME
+};
+
 static inline bool fp_state(struct unwind_user_state *state)
 {
 	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP) &&
@@ -21,6 +25,22 @@ static inline bool fp_state(struct unwind_user_state *state)
 #define for_each_user_frame(state) \
 	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
 
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
 static int unwind_user_next(struct unwind_user_state *state)
 {
 	struct unwind_user_frame *frame;
@@ -30,7 +50,9 @@ static int unwind_user_next(struct unwind_user_state *state)
 	if (state->done)
 		return -EINVAL;
 
-	if (fp_state(state))
+	if (compat_fp_state(state))
+		frame = &compat_fp_frame;
+	else if (fp_state(state))
 		frame = &fp_frame;
 	else
 		goto done;
@@ -51,15 +73,15 @@ static int unwind_user_next(struct unwind_user_state *state)
 		goto done;
 
 	/* Make sure that the address is word aligned */
-	shift = sizeof(long) == 4 ? 2 : 3;
+	shift = sizeof(long) == 4 || compat_fp_state(state) ? 2 : 3;
 	if ((cfa + frame->ra_off) & ((1 << shift) - 1))
 		goto done;
 
 	/* Find the Return Address (RA) */
-	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+	if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
 		goto done;
 
-	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
+	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
 		goto done;
 
 	state->ip = ra;
@@ -85,7 +107,9 @@ static int unwind_user_start(struct unwind_user_state *state)
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



