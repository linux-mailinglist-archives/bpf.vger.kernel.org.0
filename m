Return-Path: <bpf+bounces-10714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EF17AC9A9
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 15:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DF3DE281614
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3632AC8F3;
	Sun, 24 Sep 2023 13:36:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57B0CA4C;
	Sun, 24 Sep 2023 13:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720EFC433C9;
	Sun, 24 Sep 2023 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695562590;
	bh=tVeWRc6NY/P1SVA880iIBWSSfIP1iQe2tBoTWU/xgMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjlxvWFQgaGpBMlqFwlnIZ9VGGXN02c/MIxxrj0jkjoXq5Dkp5EVjKLTiQCIZ+qQi
	 t69ATsL1NxjpLZ/BSsGg23XpeCctFsJn6LLHvDohosO1KgMJ6u+R2PRBbG7L+Zaxgx
	 y6+QFBBfA0LjX6LTPp5lOsuNH8U89yONdRb5wIrRKo7ESmLsGg742zPxiF2hCsAyA1
	 jYMJ6u5zAyz3Zsp/OsY2JWun3v1LFrGm7TIkVPFmKVtxfg03TrJKX5ursI4EgZ+w4w
	 J6bWYTBctWkELztWXwOD2byUYJswu6XGjzXsV8QRIL2Wu6TuAKKbm8K53sFgeXY1Rn
	 +euG0vig0MbyQ==
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
Subject: [PATCH v5 03/12] tracing: Add a comment about the requirements of the ftrace_regs
Date: Sun, 24 Sep 2023 22:36:23 +0900
Message-Id: <169556258347.146934.12248055282843332442.stgit@devnote2>
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

Add a comment about the requirements of the ftrace_regs if it is
implemented on the arch-dependent code with
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e8921871ef9a..5da70f238645 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -118,6 +118,14 @@ extern int ftrace_enabled;
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
+/*
+ * The ftrace_regs will be just a wrapper of the pt_regs if
+ * CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS is not set. If it is set on an
+ * architecture, it has to define the ftrace_regs data structure.
+ * The ftrace_regs is expected to save the registers for the function
+ * arguments, the registers for stack dump (e.g. stack pointer and the
+ * frame pointer) and the instruction pointer for reference.
+ */
 struct ftrace_regs {
 	struct pt_regs		regs;
 };


