Return-Path: <bpf+bounces-60860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26355ADDF26
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 00:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD70317D198
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECB296159;
	Tue, 17 Jun 2025 22:51:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C0A2F532E;
	Tue, 17 Jun 2025 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750200679; cv=none; b=mR3QiVVKBoRVgPF7eiy5EKuc3WjHOOAGj9t+p/3iyYsd5LAiXeMztTcZczKJmmrl1qLsVrIKA4ro5Sc2oUd443JQSJodi/7CbHJ42n8X+mcV1TkLUf+hxXn3o95ig4ra3ggW+LBfV+HZnVcvmh6UxcQVnCMT9Oxa5InrFNlA8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750200679; c=relaxed/simple;
	bh=EWGXmJKmQ0jbD7nqaVv46xIc+Eb3r2/o/0IQ2btdAb0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=e8T9h9DJJ0AGe95LE8ea1LCpjUD2MX/VA8NGv3M+/M89O8wteRz8gUE+W8MwV7Nccb57cHJA5PwWODtFb9BTKHO4nLY6xXQb9C1uLVE6PmEW6uaxof1ZbuQ7NvfWSyTTSo81WhaMGozToNfKmlG1D/dbRFy6ojSf9DGQFkLuaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 7E61DC110B;
	Tue, 17 Jun 2025 22:51:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 7C28020029;
	Tue, 17 Jun 2025 22:51:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uRf9C-00000002L6O-1RiY;
	Tue, 17 Jun 2025 18:51:18 -0400
Message-ID: <20250617225118.194027083@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Jun 2025 18:50:16 -0400
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
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 07/12] unwind_user/sframe: Wire up unwind_user to sframe
References: <20250617225009.233007152@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 7C28020029
X-Stat-Signature: oziyowqdezgs9wuthxdirco18how7x6d
X-Rspamd-Server: rspamout05
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Z4OeR2/TgIGscoERupcVbBCB1hAC7qI4=
X-HE-Tag: 1750200671-455963
X-HE-Meta: U2FsdGVkX1/WWlJpNd+SnuTlbkDNLIfijgfNyk62qT/1A5scghLhveViLuwLLw88jpKNCQP5B1nKnawjRngXp9J76MWC+k+MQqwmDe6sKX/kwC7HetvuXihuRWkYaIgDLsdEHpfdJTFKm6RvrlPP0AI8/liRSj2rw90TGo6ZdhOs4w1gDbtxfFyKK+SLwCZFRt1KxDhPIMphWpKe8JRVoF/oedEJgLCz2wq9I6xfD61RZSBF1OzXRhgYRAQ5sWPUCkRShN78H5kgRD6vPi9tnof5WzLykxd9FvnyAIv6wuVhl/6t9feaRo10TorjyoCSm+R+N7K7zvqXysTq96cf1p7VgrHLHkyeyDphIE1EwzPu7UzxSsTTpq8ON2InUXxALJBGNHTa16txmDgKTA3AjWkzhSzjjjkGerfADqr4KoI=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Now that the sframe infrastructure is fully in place, make it work by
hooking it up to the unwind_user interface.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v5: https://lore.kernel.org/20250424201824.638379190@goodmis.org

- Have sframe use initialize the frame = &_frame

  The unwind code had the on stack _frame storage removed since it wasn't
  being used. The sframe code needs it. Add it back but only assign it
  when sframe is used.

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
index 29e1f497a26e..e9e1e584753e 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -7,6 +7,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
 #include <linux/uaccess.h>
+#include <linux/sframe.h>
 
 static struct unwind_user_frame fp_frame = {
 	ARCH_INIT_USER_FP_FRAME
@@ -28,6 +29,12 @@ static inline bool compat_state(struct unwind_user_state *state)
 	       state->type == UNWIND_USER_TYPE_COMPAT_FP;
 }
 
+static inline bool sframe_state(struct unwind_user_state *state)
+{
+	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_SFRAME) &&
+	       state->type == UNWIND_USER_TYPE_SFRAME;
+}
+
 #define UNWIND_GET_USER_LONG(to, from, state)				\
 ({									\
 	int __ret;							\
@@ -41,17 +48,27 @@ static inline bool compat_state(struct unwind_user_state *state)
 int unwind_user_next(struct unwind_user_state *state)
 {
 	struct unwind_user_frame *frame;
+	struct unwind_user_frame _frame;
 	unsigned long cfa = 0, fp, ra = 0;
 
 	if (state->done)
 		return -EINVAL;
 
-	if (compat_state(state))
+	if (compat_state(state)) {
 		frame = &compat_fp_frame;
-	else if (fp_state(state))
+	} else if (sframe_state(state)) {
+		/* sframe expects the frame to be local storage */
+		frame = &_frame;
+		if (sframe_find(state->ip, frame)) {
+			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
+				goto the_end;
+			frame = &fp_frame;
+		}
+	} else if (fp_state(state)) {
 		frame = &fp_frame;
-	else
+	} else {
 		goto the_end;
+	}
 
 	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
 
@@ -92,6 +109,8 @@ int unwind_user_start(struct unwind_user_state *state)
 
 	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(regs))
 		state->type = UNWIND_USER_TYPE_COMPAT_FP;
+	else if (current_has_sframe())
+		state->type = UNWIND_USER_TYPE_SFRAME;
 	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 		state->type = UNWIND_USER_TYPE_FP;
 	else
-- 
2.47.2



