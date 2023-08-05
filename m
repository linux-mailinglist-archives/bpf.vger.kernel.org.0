Return-Path: <bpf+bounces-7084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD774771049
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 16:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1201C20A4B
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D9C159;
	Sat,  5 Aug 2023 14:58:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52068BA4B
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 14:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF05C433C8;
	Sat,  5 Aug 2023 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691247522;
	bh=7WBz3LPX1X/CQd4LTl08Nwgbo3NlVRw25ijSgFRSKc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xii3jTe8lh9gNRhhBKJ+Ly1Mn4Po/eAk2+pWT4wL3m02oVIKiaHld5ecavbbtqKyH
	 LVdx90xzfnKfZcIPvuhrzDb+4mCbFd74kxk0beGJ3yWRSZPm9qVN/QZBYQMle0fcV3
	 lHzWtiZ+bvfAc+6ETbeNw+z+fhp10k6ekEkGecSZ6E1ynMuWXV/g3Sd/m3/IhqG6K5
	 YkomnbtxMrsQfFuIsWMeirZeBq8/jVY5Auo33J9j+X16DlY8qS8ORm8kd5v9txHzwP
	 YcejHo5dWWLyihua0zSGsZHzbOc9Xoo3ByVlCp05M3COhGUTXS8aRZqsWCJGv21SPd
	 FYrvp1eDraPAQ==
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
Subject: [RFC PATCH 4/5] ftrace: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
Date: Sat,  5 Aug 2023 23:58:35 +0900
Message-Id: <169124751584.186149.17291016280237570755.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169124746774.186149.2326708176801468806.stgit@devnote2>
References: <169124746774.186149.2326708176801468806.stgit@devnote2>
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

Add ftrace_partial_regs() which converts the ftrace_regas to pt_regs.
If the architecture defines its own ftrace_regs, this copies partial
registers to pt_regs and returns it. If not, ftrace_regs is the same as
pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/arm64/include/asm/ftrace.h |   11 +++++++++++
 include/linux/ftrace.h          |   11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index ab158196480c..b108cd6718cf 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -137,6 +137,17 @@ ftrace_override_function_with_return(struct ftrace_regs *fregs)
 	fregs->pc = fregs->lr;
 }
 
+static __always_inline struct pt_regs *
+ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	memcpy(regs->regs, fregs->regs, sizeof(u64) * 10);
+	regs->sp = fregs->sp;
+	regs->pc = fregs->pc;
+	regs->x[29] = fregs->fp;
+	regs->x[30] = fregs->lr;
+	return regs;
+}
+
 int ftrace_regs_query_register_offset(const char *name);
 
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ce156c7704ee..f4fbc493aceb 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -139,6 +139,17 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
 	return arch_ftrace_get_regs(fregs);
 }
 
+#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
+	defined(CONFIG_HAVE_PT_REGS_COMPAT_FTRACE_REGS)
+
+static __always_inline struct pt_regs *
+ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	return arch_ftrace_get_regs((struct ftrace_regs *)fregs);
+}
+
+#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_COMPAT_FTRACE_REGS */
+
 /*
  * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
  * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.


