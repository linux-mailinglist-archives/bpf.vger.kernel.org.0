Return-Path: <bpf+bounces-61602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A89D1AE916F
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7735F5A8350
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D3F2F9490;
	Wed, 25 Jun 2025 22:57:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E972F49F5;
	Wed, 25 Jun 2025 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892225; cv=none; b=SYx9XSHTCV7EasUoEBrJinuKhj7zbm27q896xQrNKJ6kfOR/Q5HGmfJ+aKpFw/qw5ZstRTBzRtGG0YtFcIPFzRMzu5K09LGttjap8cN/cp4yUIYTELgczReY9zFAWPX8aF8q82S3pUY4vOj6XtKqlK1GsJ28cfFsGNC8nTCpNVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892225; c=relaxed/simple;
	bh=/aoScwYOkCF4fLnSJ9PusAogYx2TOp0qIdg16G+Yb7Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fQMQslXxeDM0F1A3cjGjzhJkXeoge3KY5g2CQtX0NRaBCv+Bw38pJw35icQxB+Uzu7eOwFs0LAKBz/emNo6muPBuJGJTLla/vNexmS9yHVN8x1/dfABC2SdMapegtimQZTXm8DLY8ILTatDuJlwWjajc+lvWh3/U9xdIWKTsM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id CF0E71047D6;
	Wed, 25 Jun 2025 22:56:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id A6AD22002A;
	Wed, 25 Jun 2025 22:56:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZ3M-000000043ih-4AnM;
	Wed, 25 Jun 2025 18:57:16 -0400
Message-ID: <20250625225716.845688930@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 18:56:12 -0400
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
Subject: [PATCH v11 12/14] unwind_user/x86: Enable frame pointer unwinding on x86
References: <20250625225600.555017347@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: A6AD22002A
X-Stat-Signature: y7ibt1sb6cisnqrdztz7p9mcbh1g56ua
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18chkwuygBM0JT0zRlSrIaGISejPZxbMlQ=
X-HE-Tag: 1750892211-792006
X-HE-Meta: U2FsdGVkX1+r5j0ZARwzTyfNU2rD/H9qo77ZocLDdMtt7vCtufq3VPug3j2uI/FyTqW3TgAt5cfMKkBSzCe3B2PVIEzLB47+BoA+PpbEa/XvMksYqvFowFuvP0SfOYOQ6Fw65dDCCLPTPp14yJRMIOhRVTR72h1N84iggZjRkuLiUCuKFs6y4DCcTFnddSH0PMdshMRpAeN9cRvLjmlJAJdN/0zyL0padb7MdtGjR5dTgriUwTDrMrrDkNuAnw3G5Bo5syrZe2jLYSX2I0e/Ni784ljIDtava2Dybt4IJhSbqVnF14Q4B3rqR8qyEMBjjl7meB67DqkmN/nSW6smNEp5b4umN6ippnJzDW6dZEz6nTmL26ti4C83cvb05gBQvgrfnGYv+9rrls/SZEGDKVjnintwMBXUmOEOGh3HtlQ=

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
index 340e5468980e..2cdb5cf91541 100644
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



