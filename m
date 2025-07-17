Return-Path: <bpf+bounces-63526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A20BFB0824F
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24BE1A623D1
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CB0202998;
	Thu, 17 Jul 2025 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8GHI1c4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215B1E9905;
	Thu, 17 Jul 2025 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715756; cv=none; b=N0IcTz8d7mhARqp9TLHNizMWdaxEiBLmSquqKGA/udDMRsv9M9l/j8ujXaXicigPZ76r8iyfWZVEv6lNm6lSrB9JPL5OiJG3Xx2dDgPvRz9K9XaglDPrdBbvduiuKqyYnPGV4Dwa1aZW4e0L9qK8GtxtIe4MGWUFaaHG5x8YBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715756; c=relaxed/simple;
	bh=P9XXjXhMuNIRa4aikXrGsKJEOWW6WFkYabNwOXfxzKY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BOrXKfYxArvHLWEccR4q2U4k1d3sQ5embHZ/ce+dDf7sRNhTRYktrBQIcyu8yaqVCH/7rnIX3G7QobaDxUZcXFlNHLpq7I1k1VOVaCh+h/xu+t4ZbHGpjjneiA08SWFpw8thDzbmn18PmjFEHfZa74ZLX81dkxNmEckZYESxhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8GHI1c4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6833EC4CEF6;
	Thu, 17 Jul 2025 01:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752715756;
	bh=P9XXjXhMuNIRa4aikXrGsKJEOWW6WFkYabNwOXfxzKY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=A8GHI1c4OPNU27FZQc+UCvRWEeLoYVEMLMAzYlT3l3uFzj7sUOrzyoynV93haVwHX
	 KPr+8wdRKaYLM94b9CkcAFSprK1wn+xlP3ZAd+re9M1Axb1w4s8fr2Ta+JLMzWM/7n
	 /VdMNTKDOd19wWtnrOqCmMNGN1hTr4fIH6Zgx61Z7dc/+xSzrWWE0obNOvM3dfLeK9
	 256VUnTJZSxmQWeeCS5YBTqhj3lquGXztaWAB4nQ/MSU9Ang2LAxO5jNZBt8swgSrC
	 OoWtHjPrrm7v/uhWBq0E6iGoRtw61NP71NaoxF0whOvXEJ9qQ0pCpVuceaFOUfZcJO
	 yHe74WAPIRo0w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucDRI-000000068xC-3DTJ;
	Wed, 16 Jul 2025 21:29:36 -0400
Message-ID: <20250717012936.619600891@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 16 Jul 2025 21:28:54 -0400
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
Subject: [PATCH v9 06/11] unwind_user/sframe: Wire up unwind_user to sframe
References: <20250717012848.927473176@kernel.org>
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
Changes since v8: https://lore.kernel.org/20250708021159.386608979@kernel.org

- Rebased on the changes by Mathieu in the user.c file
  https://lore.kernel.org/all/20250710164301.3094-2-mathieu.desnoyers@efficios.com/

 arch/Kconfig                      |  1 +
 include/linux/unwind_user_types.h |  4 ++-
 kernel/unwind/user.c              | 41 +++++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index edd6393512f5..f3b3e5a91f6d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -444,6 +444,7 @@ config HAVE_UNWIND_USER_FP
 
 config HAVE_UNWIND_USER_SFRAME
 	bool
+	select UNWIND_USER
 
 config HAVE_PERF_REGS
 	bool
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index a449f15be890..d30e8495eaa9 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -9,7 +9,8 @@
  * available.
  */
 enum unwind_user_type_bits {
-	UNWIND_USER_TYPE_FP_BIT =		0,
+	UNWIND_USER_TYPE_SFRAME_BIT =		0,
+	UNWIND_USER_TYPE_FP_BIT =		1,
 
 	NR_UNWIND_USER_TYPE_BITS,
 };
@@ -17,6 +18,7 @@ enum unwind_user_type_bits {
 enum unwind_user_type {
 	/* Type "none" for the start of stack walk iteration. */
 	UNWIND_USER_TYPE_NONE =			0,
+	UNWIND_USER_TYPE_SFRAME =		BIT(UNWIND_USER_TYPE_SFRAME_BIT),
 	UNWIND_USER_TYPE_FP =			BIT(UNWIND_USER_TYPE_FP_BIT),
 };
 
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 85b8c764d2f7..e7ba01cf87a4 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -7,17 +7,24 @@
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
 #include <linux/uaccess.h>
+#include <linux/sframe.h>
 
 static struct unwind_user_frame fp_frame = {
 	ARCH_INIT_USER_FP_FRAME
 };
 
+static struct unwind_user_frame *get_fp_frame(struct pt_regs *regs)
+{
+	return &fp_frame;
+}
+
 #define for_each_user_frame(state) \
 	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
 
-static int unwind_user_next_fp(struct unwind_user_state *state)
+static int unwind_user_next_common(struct unwind_user_state *state,
+				   struct unwind_user_frame *frame,
+				   struct pt_regs *regs)
 {
-	struct unwind_user_frame *frame = &fp_frame;
 	unsigned long cfa, fp, ra = 0;
 	unsigned int shift;
 
@@ -55,6 +62,24 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
 	return 0;
 }
 
+static int unwind_user_next_sframe(struct unwind_user_state *state)
+{
+	struct unwind_user_frame _frame, *frame;
+
+	/* sframe expects the frame to be local storage */
+	frame = &_frame;
+	if (sframe_find(state->ip, frame))
+		return -ENOENT;
+	return unwind_user_next_common(state, frame, task_pt_regs(current));
+}
+
+static int unwind_user_next_fp(struct unwind_user_state *state)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	return unwind_user_next_common(state, get_fp_frame(regs), regs);
+}
+
 static int unwind_user_next(struct unwind_user_state *state)
 {
 	unsigned long iter_mask = state->available_types;
@@ -68,6 +93,16 @@ static int unwind_user_next(struct unwind_user_state *state)
 
 		state->current_type = type;
 		switch (type) {
+		case UNWIND_USER_TYPE_SFRAME:
+			switch (unwind_user_next_sframe(state)) {
+			case 0:
+				return 0;
+			case -ENOENT:
+				continue;	/* Try next method. */
+			default:
+				state->done = true;
+			}
+			break;
 		case UNWIND_USER_TYPE_FP:
 			if (!unwind_user_next_fp(state))
 				return 0;
@@ -96,6 +131,8 @@ static int unwind_user_start(struct unwind_user_state *state)
 		return -EINVAL;
 	}
 
+	if (current_has_sframe())
+		state->available_types |= UNWIND_USER_TYPE_SFRAME;
 	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 		state->available_types |= UNWIND_USER_TYPE_FP;
 
-- 
2.47.2



