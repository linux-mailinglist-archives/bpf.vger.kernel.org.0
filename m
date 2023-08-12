Return-Path: <bpf+bounces-7636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469C8779D44
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 07:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05707281A5D
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 05:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7C1861;
	Sat, 12 Aug 2023 05:36:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC11CCAF
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 05:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337D9C433C8;
	Sat, 12 Aug 2023 05:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691818613;
	bh=blEGHkYpfxZ/1E7WBPNHsUXM+7p3REUp7I8zSsGXqWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GrCcvdTy2YsEo6/vYNC3BwLrflolqioYyx+EYQOJp/1Pz/a5YY3sXMpalYrFs0R0j
	 JUIQSw6pgmUv7Tfe9wyv74ePTOsgjbJ3zwxZV2V0HsR2T0KIDU+TKt4kyMg3cTp+X5
	 sgQY9Q3NR8p/0zQgnqUQ2qwfpMYUr4xvNEMNKfoliizh9wDQVmxeP/xLrtDBOiwR8v
	 C8h96HzSoorF4DAxA+c4aPR2TZCDrAJ++rqFMe+xEY2Sb4pKSIXPsm1i1atzc2+VcK
	 ie96vOscAPAGsPQPlipmD8M4ucicOAATf3OSw7n6GFcAI1LuilADu3ZHxycQ/at05l
	 HJLuWZRu2LpQA==
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
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 1/8] Documentation: probes: Add a new ret_ip callback parameter
Date: Sat, 12 Aug 2023 14:36:47 +0900
Message-Id: <169181860742.505132.14215380532909911090.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169181859570.505132.10136520092011157898.stgit@devnote2>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
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

Add a new ret_ip callback parameter description.

Fixes: cb16330d1274 ("fprobe: Pass return address to the handlers")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/fprobe.rst |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 40dd2fbce861..a6d682478147 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -91,9 +91,9 @@ The prototype of the entry/exit callback function are as follows:
 
 .. code-block:: c
 
- int entry_callback(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs, void *entry_data);
+ int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
 
- void exit_callback(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs, void *entry_data);
+ void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
 
 Note that the @entry_ip is saved at function entry and passed to exit handler.
 If the entry callback function returns !0, the corresponding exit callback will be cancelled.
@@ -108,6 +108,10 @@ If the entry callback function returns !0, the corresponding exit callback will
         Note that this may not be the actual entry address of the function but
         the address where the ftrace is instrumented.
 
+@ret_ip
+        This is the return address of the traced function. This can be used
+        at both entry and exit.
+
 @regs
         This is the `pt_regs` data structure at the entry and exit. Note that
         the instruction pointer of @regs may be different from the @entry_ip


