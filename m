Return-Path: <bpf+bounces-66717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B51B38AE3
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8523A208892
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F76A3081A3;
	Wed, 27 Aug 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXf2X4nI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA78C3009F8;
	Wed, 27 Aug 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326262; cv=none; b=fPnj56giJNARcXvfZquMdqr20vcnWmgk9stw0VTSI2jJoJ9V6tnz4q38ukzqokvJd0W9Q9QvaYVh8+dReCj0CiBzgxn4NMTDMyhnnT1bFEdQjVo8I5bhWVCa5Iu/orMFpdbCr4lKFARktgCr/w/yWUDX2gs+bYbXThfX9BwFkDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326262; c=relaxed/simple;
	bh=vircrvv7Zq8GxATMbia1gUCQK1TDM+Rw9iJ5FVuaMNc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ICLclZtTx5QHSplsJ+axJHRBH6WGuyp6qeBM9yQf3lBs8MS7st6f990vlfwSrLaNQK1V7LjUheDHm4VKDsaIvzM8bfY9enESZ5fIXEU69aQnfdBjxyLy+z2W9NAaj+kBZGOTHy6ZsEV4jsAWE/DMNsW9zTTRKr2lv3GT5rKwD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXf2X4nI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5978EC116C6;
	Wed, 27 Aug 2025 20:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756326262;
	bh=vircrvv7Zq8GxATMbia1gUCQK1TDM+Rw9iJ5FVuaMNc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=hXf2X4nI3wC4VendwY6X1JKrPGLSBB1jukfIHjsjm9Z1r4Yy+IB1srFg/yMjjzTfJ
	 17u4cLmAijsGKbk1iWpVcwtfpoLm4YXitZWYS2Um1EpJ8RLDCnKqQ2unr4f/lS+DYW
	 Xyc2tzRML81yHvkKHyIcFHcKTtdg3fENSV9fqL/yBEPcGo/qtfBlkFAxcnCeW+Ja7V
	 TyFTkMMCYoKkpBzpo/KoOPzF/yGx6a6OT1zfk/nGrQ5Qt386eEzDASjUQ0QvtnoPH9
	 gTCZQcXJ13J8wG/iSc5T7/FjTx3Fig5BIyLPwlCLsRB8F2As1+2/7M2t705A5R/Cp4
	 uEv44BvW0pJ+g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urMhF-00000003kyp-1576;
	Wed, 27 Aug 2025 16:24:41 -0400
Message-ID: <20250827202441.115677905@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 27 Aug 2025 16:15:54 -0400
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
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [PATCH v10 06/11] unwind_user/sframe: Wire up unwind_user to sframe
References: <20250827201548.448472904@kernel.org>
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
Changes since v9: https://lore.kernel.org/20250717012936.619600891@kernel.org

- Update the changes to unwind/user.c to handle passing a const
  unwind_user_frame pointer.

 arch/Kconfig                      |  1 +
 include/linux/unwind_user_types.h |  4 ++-
 kernel/unwind/user.c              | 41 +++++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 69fcabf53088..277b87af949f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -453,6 +453,7 @@ config HAVE_UNWIND_USER_FP
 
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
index 97a8415e3216..9d34c7659f90 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -7,17 +7,24 @@
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
 #include <linux/uaccess.h>
+#include <linux/sframe.h>
 
 static const struct unwind_user_frame fp_frame = {
 	ARCH_INIT_USER_FP_FRAME
 };
 
+static const struct unwind_user_frame *get_fp_frame(struct pt_regs *regs)
+{
+	return &fp_frame;
+}
+
 #define for_each_user_frame(state) \
 	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
 
-static int unwind_user_next_fp(struct unwind_user_state *state)
+static int unwind_user_next_common(struct unwind_user_state *state,
+				   const struct unwind_user_frame *frame,
+				   struct pt_regs *regs)
 {
-	const struct unwind_user_frame *frame = &fp_frame;
 	unsigned long cfa, fp, ra;
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
2.50.1



