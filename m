Return-Path: <bpf+bounces-62623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DD2AFC09E
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAC14A8574
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E0522A7F1;
	Tue,  8 Jul 2025 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRjxgpx7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6889621FF5F;
	Tue,  8 Jul 2025 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940719; cv=none; b=WBzRCe0F9UdoSjELX3mmRFgs3BQoeT1UzhtGyw6VAA3fW7zq3r0R2H4AG50szXMXqSTRQeahzPovj2BohvlUUabin2q9mpk/P8fKxrbTW3HVVXM4BeBhv/9pNrpRPJzEFualjiXWrapNcVYmmByOTEagbTPJ1ZnVREOv2ZQN4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940719; c=relaxed/simple;
	bh=mCPJ2wJkMSxHj5eWYMxvQ3cKpVx1XsIVQRcDHIz7ptQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ksYGLiTGyeAUC6vxUz5t1MFYiINkWhSliMp+4AB7mrtsJ/I3F3GH3/auPR6L6kuJzbNw2nHKA9RNT36NhBPxJdRem3ADdx4mG+3eH4PnqL10buiaBdgcbKE36dD6a6syyJDhQ3+y5FwQJARr8P9eVEE3vp1brjtXAh6/gImA7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRjxgpx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348A3C4CEE3;
	Tue,  8 Jul 2025 02:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940719;
	bh=mCPJ2wJkMSxHj5eWYMxvQ3cKpVx1XsIVQRcDHIz7ptQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=WRjxgpx7ixr/OLWzER0sgV925ibErSPLN39Gg6pPZ2p1j8RrcCC3T/Xys/P8IqgN4
	 R/1ZIvIq4ep9yt41d/6ooDm4+X/D5PLebifZHKpchhJ43xO97D9qW4m4uKyAm5oBKu
	 CLB0XXNgCOzyYwZi9LNPdYfz0IgUVdjnJ8b5xsUbcXC7bk+yhq1pS5BM/EULP08iLZ
	 DYOMhavsW92Smv6Hl7OkaEaFDkNhuw30LB23jQWqc8eLSrI3JzZ0wHh16me8wOxuGG
	 F8sAn9OhvOwjLrvl5ObQIkuGTDdViS/CoRj/QKXQC5uXSpGldlDkGaEYnh5dKl4jEn
	 y1iykIam4u2ZQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxoN-00000000DdW-2EZU;
	Mon, 07 Jul 2025 22:11:59 -0400
Message-ID: <20250708021159.386608979@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:11:21 -0400
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
Subject: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to sframe
References: <20250708021115.894007410@kernel.org>
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
index 249d9e32fad7..6e7ca9f1293a 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -7,6 +7,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
 #include <linux/uaccess.h>
+#include <linux/sframe.h>
 
 static struct unwind_user_frame fp_frame = {
 	ARCH_INIT_USER_FP_FRAME
@@ -31,6 +32,12 @@ static inline bool compat_fp_state(struct unwind_user_state *state)
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
@@ -44,18 +51,28 @@ static inline bool compat_fp_state(struct unwind_user_state *state)
 static int unwind_user_next(struct unwind_user_state *state)
 {
 	struct unwind_user_frame *frame;
+	struct unwind_user_frame _frame;
 	unsigned long cfa = 0, fp, ra = 0;
 	unsigned int shift;
 
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
 
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
@@ -111,6 +128,8 @@ static int unwind_user_start(struct unwind_user_state *state)
 
 	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(regs))
 		state->type = UNWIND_USER_TYPE_COMPAT_FP;
+	else if (current_has_sframe())
+		state->type = UNWIND_USER_TYPE_SFRAME;
 	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 		state->type = UNWIND_USER_TYPE_FP;
 	else
-- 
2.47.2



