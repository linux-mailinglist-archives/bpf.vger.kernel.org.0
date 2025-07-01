Return-Path: <bpf+bounces-61911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B05AEEB64
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A463BAC5F
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC96192D83;
	Tue,  1 Jul 2025 00:54:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15A18248C;
	Tue,  1 Jul 2025 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331263; cv=none; b=RwXwdp3fHiVpI4h6CYXLIcxicp0Fxb5vToFLJ5nEIMfnVUkIUQvB/4/4WWgzWWCkkhxcYqC+846oyIYBiOrKuzQyIKmq4c3OkoHlWl52ebK5h+wqUd4hNriJ8M0ZRek4+U7gPcdHFFKqJi5tx+4t3x4NEhGRU9z0hCHzqm4wEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331263; c=relaxed/simple;
	bh=q9368biQbKFkdqwUJGMNR4U7z4DEcx2lmBxRY3YPNYQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ThFvY9YiIcfVKUHfXB284QfTWyuvUJQ4UoG+FAI70pwXb5ejE0N/I67r1Lita/85C42OjpFS7VF0CwfnUlF/JjuyuielRgWjAhD17ZZaEdiKj/0tWoKs95a/rXNC2f0XhhCP6fiFxG9cnwlA066MOF9kIiL2YFpWhlSFpRtPEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 61A0DC020C;
	Tue,  1 Jul 2025 00:54:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id EDCB435;
	Tue,  1 Jul 2025 00:54:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGu-00000007Nkc-3o8t;
	Mon, 30 Jun 2025 20:54:52 -0400
Message-ID: <20250701005452.754512359@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:34 -0400
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
Subject: [PATCH v12 13/14] unwind_user/x86: Enable frame pointer unwinding on x86
References: <20250701005321.942306427@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: e4kj9kydhumeoou84895ssrqromn74qb
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: EDCB435
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18aFETgkKjQnCAuepSv4j+KA0JmuNmOu8A=
X-HE-Tag: 1751331255-519679
X-HE-Meta: U2FsdGVkX18cGjudfIGcv7XWJ4dSMPaYc2Tjc0fCQMSwV8s8Pn2czI+QQOAZIq4WhF/kT66ktE0fEJK+ANqhHJ4fzBtgFAP+ZZ/7jK8dXl75CGBWGyxIxjVga0vo0TjhnGY4vbpNfIOa+7Wa7QLQzr/WUVw/MI8z/YQEBcnerGLQvy+U2ZTkM5d7Ln7hRlvl0Do9USjwYd/dUNhGr9wFQT4GkNno5fAeCPnwxzy+C97w8o2rPwhq+l6lK9N7UZvyvgLGjjxRgHVAa4f7eUQdA+Ey9GkFsAE1AjGFw12Pvk5rb2WBwSqo7oEuXWSTUmQ+ukCd3/9+aEcz14A9Zz6WZ6Q2/N1GCLFX48p0vtnkviTsNenPdqvMc0zKgM3EQl7ENcLZ7+HWzC5TJ9SFXZly7Ub6ZSWGUVIrHRVDrm5ny/o=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
on x86, and enable CONFIG_HAVE_UNWIND_USER_FP accordingly so the
unwind_user interfaces can be used.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/unwind_user.h | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..5862433c81e1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -302,6 +302,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
new file mode 100644
index 000000000000..8597857bf896
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UNWIND_USER_H
+#define _ASM_X86_UNWIND_USER_H
+
+#define ARCH_INIT_USER_FP_FRAME							\
+	.cfa_off	= (s32)sizeof(long) *  2,				\
+	.ra_off		= (s32)sizeof(long) * -1,				\
+	.fp_off		= (s32)sizeof(long) * -2,				\
+	.use_fp		= true,
+
+#endif /* _ASM_X86_UNWIND_USER_H */
-- 
2.47.2



