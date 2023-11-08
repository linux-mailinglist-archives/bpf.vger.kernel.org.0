Return-Path: <bpf+bounces-14483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADBE7E58A6
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 15:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD8D1C20AB9
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99A319BCE;
	Wed,  8 Nov 2023 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2uVbebR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F7E19BA8;
	Wed,  8 Nov 2023 14:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F78C433C9;
	Wed,  8 Nov 2023 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699453477;
	bh=n4E0j8qzABvMFqw3IzKBJQSoLeU/goeaPocNkQ11XcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2uVbebRxB1ylSqQ+t2SN5QROmqMPIEbhnk6ue4Qptu9V2AUiYTKdQzHkbX62FwaO
	 u2KyezDq8u4weG+TMuchcAPQh4uxsEjZRCpyq6K/T0QFMONZbq8kiUPhzKCRLwWpiJ
	 dz35a+3226RvbHYlgfR2j6DIEpTtQVBFZ6lYJ3PIup9iWhTMUtfGrFnort9P92eWKI
	 0QcnS8msS4bdMDUYzVSHyknYYurSNMZ2iCuCZIlX0nEvgCbYI/IfMeTZrdCEj2N6pH
	 sMXig9A9lUqHaREe3hkU3okeoMS+cVg0unevvOSjiZ+2qibn+n3yeAqclnDPdDiDOD
	 srXFhtl+Ifq7Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH v2 01/31] tracing: Add a comment about ftrace_regs definition
Date: Wed,  8 Nov 2023 23:24:32 +0900
Message-Id: <169945347160.55307.1488323435914144870.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

To clarify what will be expected on ftrace_regs, add a comment to the
architecture independent definition of the ftrace_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - newly added.
---
 include/linux/ftrace.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e8921871ef9a..b174af91d8be 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -118,6 +118,31 @@ extern int ftrace_enabled;
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
+/**
+ * ftrace_regs - ftrace partial/optimal register set
+ *
+ * ftrace_regs represents a group of registers which is used at the
+ * function entry and exit. There are three types of registers.
+ *
+ * - Registers for passing the parameters to callee, including the stack
+ *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
+ * - Registers for passing the return values to caller.
+ *   (e.g. rax and rdx on x86_64)
+ * - Registers for hooking the function return including the frame pointer
+ *   (the frame pointer is architecture/config dependent)
+ *   (e.g. rbp and rsp for x86_64)
+ *
+ * Also, architecture dependent fields can be used for internal process.
+ * (e.g. orig_ax on x86_64)
+ *
+ * On the function entry, those registers will be restored except for
+ * the stack pointer, so that user can change the function parameters.
+ * On the function exit, onlu registers which is used for return values
+ * are restored.
+ *
+ * NOTE: user *must not* access regs directly, only do it via APIs, because
+ * the member can be changed according to the architecture.
+ */
 struct ftrace_regs {
 	struct pt_regs		regs;
 };


