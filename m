Return-Path: <bpf+bounces-10723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7427AC9C2
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 15:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C1E41281575
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DC1CA71;
	Sun, 24 Sep 2023 13:38:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C4ECA4C;
	Sun, 24 Sep 2023 13:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0B3C433C7;
	Sun, 24 Sep 2023 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695562700;
	bh=Ylc3TSXa5ifgz7bjH+Ib7u/kImYYyrGh5B2vMyFRLTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Noce4mwmQNAoIZUogYsYCHEBjWbN2VvgLO6lbPFKdhnc1rWxsAAm5qcB/hlWV7MzL
	 6M8uaClcpljpII0+yuMjMcfoXR2E4R03fEuYY1TBanEt2HyxGqBltgcZGu2xlwMcw1
	 GT1nBUt9ctylc2zKowKw8YXTloz3jhxqUqutXd+I1UwjeJr3Fz+fgwqCp1jn6obYvX
	 EbnAwCmrhQ7uQFXszvaCznoy6tg4E3WMRuPOSYmv8+iowSy3I/m+5sghxqx/z/F2qm
	 QL6KhyoirapL2JQ/JB64iPfjQKFoZV2VO2aGFRDutjDqBmqcL1+dhLeHtBXi9ik/4B
	 gmhXMtk+X90zQ==
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
Subject: [PATCH v5 12/12] Documentation: tracing: Add a note about argument and retval access
Date: Sun, 24 Sep 2023 22:38:14 +0900
Message-Id: <169556269377.146934.14829235476649685954.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169556254640.146934.5654329452696494756.stgit@devnote2>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
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

Add a note about the argument and return value accecss will be best
effort. Depending on the type, it will be passed via stack or a
pair of the registers, but $argN and $retval only support the
single register access.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/fprobetrace.rst |    8 ++++++--
 Documentation/trace/kprobetrace.rst |    8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index 8e9bebcf0a2e..e35e6b18df40 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -59,8 +59,12 @@ Synopsis of fprobe-events
                   and bitfield are supported.
 
   (\*1) This is available only when BTF is enabled.
-  (\*2) only for the probe on function entry (offs == 0).
-  (\*3) only for return probe.
+  (\*2) only for the probe on function entry (offs == 0). Note, this argument access
+        is best effort, because depending on the argument type, it may be passed on
+        the stack. But this only support the arguments via registers.
+  (\*3) only for return probe. Note that this is also best effort. Depending on the
+        return value type, it might be passed via a pair of registers. But this only
+        accesses one register.
   (\*4) this is useful for fetching a field of data structures.
   (\*5) "u" means user-space dereference.
 
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 8a2dfee38145..bf9cecb69fc9 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -61,8 +61,12 @@ Synopsis of kprobe_events
 		  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
                   and bitfield are supported.
 
-  (\*1) only for the probe on function entry (offs == 0).
-  (\*2) only for return probe.
+  (\*1) only for the probe on function entry (offs == 0). Note, this argument access
+        is best effort, because depending on the argument type, it may be passed on
+        the stack. But this only support the arguments via registers.
+  (\*2) only for return probe. Note that this is also best effort. Depending on the
+        return value type, it might be passed via a pair of registers. But this only
+        accesses one register.
   (\*3) this is useful for fetching a field of data structures.
   (\*4) "u" means user-space dereference. See :ref:`user_mem_access`.
 


