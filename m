Return-Path: <bpf+bounces-8376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2718A785BB7
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 17:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DCE281361
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFDAC2ED;
	Wed, 23 Aug 2023 15:15:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0103CAD42
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 15:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728FDC433C8;
	Wed, 23 Aug 2023 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692803745;
	bh=0drD+LQDmx/AHTKLGdH1kpL/kFKRrBczUa0Lao0mBUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHa5BB/ygXp14fJ5mlCzLHnp2z4FiKXUQhn0X611gMkzK0gRcKI25E7Ait3VmQpnF
	 sEc8LFG2fmdqrcsXdRH1QKJStOcgrHyCUVEmy25sJppLkiwv6pdGS2tiSS9gI1bCrN
	 1MlvLL3MGN8oSSD18gHH9xqd6pIH79L51VL78zeon27+Nhq/vhXTNSuBWw2zAVbmNg
	 nI8dPLPSnPshg70iA4RjBdVG0nml2s+LGyxuDEkYhK24dN5J9bSTzZ8cuUFD3QCfGQ
	 sMXoF6ewCGSHdSeeh3KjBPriZwUeQagYnxgFxfj40Uh5gNSIxfHf3nAGvc9Yix0XDW
	 R5qDiyorawPjw==
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
Subject: [PATCH v4 1/9] Documentation: probes: Add a new ret_ip callback parameter
Date: Thu, 24 Aug 2023 00:15:40 +0900
Message-Id: <169280373992.282662.14835192462715188987.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169280372795.282662.9784422934484459769.stgit@devnote2>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
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
 Changes in v4:
  - Update ret_ip description (Thanks Florent!)
---
 Documentation/trace/fprobe.rst |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 40dd2fbce861..5851a14eb893 100644
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
+        This is the return address that the traced function will return to,
+        somewhere in the caller. This can be used at both entry and exit.
+
 @regs
         This is the `pt_regs` data structure at the entry and exit. Note that
         the instruction pointer of @regs may be different from the @entry_ip


