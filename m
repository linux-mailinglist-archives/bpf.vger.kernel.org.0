Return-Path: <bpf+bounces-60271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884FEAD47AB
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB5E17DABE
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1B19924E;
	Wed, 11 Jun 2025 01:03:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83140183098;
	Wed, 11 Jun 2025 01:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603789; cv=none; b=oPsibl6sgCOtAxQ52/ywNsR4dxBmPQhzu1bV2T056OcSoGADbxFUzoZCzOmN6Ah4bCIUfOJsE4a7rSIFKQPzmMZMpgsOmuG00K4GDcI3tXUrO/ge9/G580/YRYaQi3CiZYyQlHZ3Lc6s6OI7rdljXJLzceRv0dfc2suUJrJ9I3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603789; c=relaxed/simple;
	bh=/EpOwL6wYbL+/lgQQvJ+DJWzgdhfhGfcXoAy1FAyDhU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DysSWoX/E5XF/yqBsx0oCc8PtWR/FvIxC9MVa44eG20H4Ec5B7lSZb3CsfU5DP1VOerYnaRG0f8KDfpB6JXrDb/13i3tov7brUDLu7ZHAt9qAwSuYREi5wLYXEbBOM+F31xfZK2nKmRtuyCPfvpRw5aOgvGLc/y5kC/eyh4Tnj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 57B511D7AA0;
	Wed, 11 Jun 2025 01:02:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 3910220010;
	Wed, 11 Jun 2025 01:02:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uP9tE-00000000v8F-10XJ;
	Tue, 10 Jun 2025 21:04:28 -0400
Message-ID: <20250611010428.092934995@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 20:54:23 -0400
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
Subject: [PATCH v10 02/14] unwind_user: Add frame pointer support
References: <20250611005421.144238328@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 3910220010
X-Stat-Signature: ic673n3y31s4ws8r59hk49ybptk6xru9
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Lz042JoZ3KZn7rLbr13XgkoRnvmAhjnI=
X-HE-Tag: 1749603776-60119
X-HE-Meta: U2FsdGVkX1/Z0y2jp9w6bGKmP/OO0jhQx4cDxClTJySQ8q08wYCTgGdTafH748ZYw6cRP5G3j1tBkXU2UftLnoy6wZivqq1nowVfiK8XpgtQztzN6kFqSXxxOSQl/6kHf4SaZWRgbtzL9+PsgFDx+Y2FNS2B+BvBZni+nDNXKokGPGkn9tjvKvh5iOwROjZbOTQGPi1wwMzZIPXfsLiV+/VmUB6BS/OJT8MXSNWLr+U+ZEHVGcj621TQ7dx/5ZGX03kIQ+L7cuberCEXPSSKDi6F2UfBpxukKODkMhbQKGDmgkh2jSz0O4OBK+aLmtFmE+sg+1ia56T78biAxDZjmf8a0Lp3CplPsbOo/Quw22E3CKb2lwVVJhHfRaBfeUxHUoA3cavDRB1c0n4XSxOO7zOwwgdYuld3YAtP55dzq4M=

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
Changes since v9: https://lore.kernel.org/linux-trace-kernel/20250513223551.290698040@goodmis.org/

As asm-generic headers are not included when an architecture defines the
header, having more than one #ifndef and setting variables does not work
with those checks in the asm-generic header and the architecture header
does not define all the values.

- Move ARCH_INIT_USER_FP_FRAME check to linux/user_unwind.h

- Have linux/user_unwind.h include asm/user_unwind.h and not have C files
  have to call the asm header directly

- Remove unnecessary frame initialization

- Added unwind_user.h to asm-generic/Kbuild

 arch/Kconfig                      |  4 +++
 include/asm-generic/Kbuild        |  1 +
 include/asm-generic/unwind_user.h |  5 ++++
 include/linux/unwind_user.h       |  5 ++++
 include/linux/unwind_user_types.h |  1 +
 kernel/unwind/user.c              | 49 +++++++++++++++++++++++++++++--
 6 files changed, 63 insertions(+), 2 deletions(-)
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
index aa7923c1384f..a405111c41b0 100644
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
 
 int unwind_user_start(struct unwind_user_state *state);
 int unwind_user_next(struct unwind_user_state *state);
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
index d30449328981..4fc550356b33 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -6,10 +6,52 @@
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
 
 int unwind_user_next(struct unwind_user_state *state)
 {
-	/* no implementation yet */
+	struct unwind_user_frame *frame;
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
 
@@ -24,7 +66,10 @@ int unwind_user_start(struct unwind_user_state *state)
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



