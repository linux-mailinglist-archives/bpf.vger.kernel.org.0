Return-Path: <bpf+bounces-61604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B89AE9170
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD921C281BD
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5362E2F94BD;
	Wed, 25 Jun 2025 22:57:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C42F49F8;
	Wed, 25 Jun 2025 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892225; cv=none; b=g92Xh05DE9KAishneau6T5ul8PjDC4eOZnt0fiXg2c3bpmLQm/s03TLaN51yGu2CqtP5Zekz6WxWBRPgoTLCoWhNluce+5pTt8iX1kg7oiz/cOxvhkJwDRJ79+MYY+JQNYTjEvifmvCot4WSoI2kcmOkQ0fxoReaCY4ClzChVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892225; c=relaxed/simple;
	bh=BTki9KcgQuBs03ZLixR3EfsIYgDN30ni9Vj+f0Agnh0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IWizK1PWHIsRqwICFQBcSOZwYiufYZxwzGKaJ3GRGTH1OdpdNw/t8mfxpbHXY/U58LLtWmKhUsvXWPsQPYBW6fMiEBRT8Gy/J7A1k5MrCvYzWWOVf7os7NxA1Cju3YHwVJNe6rd9a+kEaf4bJ3mWigBwgrDYN9G6YWqiKz3tGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 897271047D0;
	Wed, 25 Jun 2025 22:56:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 4DF758000F;
	Wed, 25 Jun 2025 22:56:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZ3L-000000043eL-1xnh;
	Wed, 25 Jun 2025 18:57:15 -0400
Message-ID: <20250625225715.319252952@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 18:56:03 -0400
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
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v11 03/14] unwind_user: Add compat mode frame pointer support
References: <20250625225600.555017347@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: u71xmu1cznptucshk3bon4dmo8t6eszg
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4DF758000F
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/OmbiHdwR6oaDQqzTo3ytvVL/34RQqUa4=
X-HE-Tag: 1750892210-797740
X-HE-Meta: U2FsdGVkX19ptLZDQbVnXH2MvdZXZdeYsg4h4/9amlJ4uuUMEppxK0Jw7m/KMg1PVjp50TUcgvwNahM/NyuPzb8hW2VJWu8FAJT+FrTLajgnzEofH9lx0HEk2r8a4D7bw7NxM6tM+0YzkJPl21HzK4O3BwaGfjQf/pJci+WC/Hm8zs/xaLVeNHrw2XB0xkKtHrSPLeJMZmplzAGGS94HJzddJEQsvYN4gsMOadXdNXGTT9uLXhF3/YEVyB19BN5bol1NX4mwrVdwHPSddBWcbAHOwZRbXDj8xMhfxGyZ+HXz9gRVA47NFW7ZSIsLdYUWoIz0+CLiWsYN0XTZ+ksF972n0nYHQ7A9KBhXPGuiAHKXAS9Z7NLFsO69BR4dUtn8ilPfRpkrjRRiVLX/5dUkzUQy7L3rmDdeZX3oVVAEXZU=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add optional support for user space compat mode frame pointer unwinding.
If supported, the arch needs to enable CONFIG_HAVE_UNWIND_USER_COMPAT_FP
and define ARCH_INIT_USER_COMPAT_FP_FRAME.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v10: https://lore.kernel.org/20250611010428.261095906@goodmis.org

- Rename compat_state() to compat_fp_state() for consistency. (Peter Zijlstra)

- Lowercase macro UNWIND_GET_USER_LONG() to unwind_get_user_long()
  (Peter Zijlstra and Linus Torvalds)

- Remove currently unused arch_unwind_user_init() and
  arch_unwind_user_next() and add them in the later patches when they are
  used. (Peter Zijlstra)

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



