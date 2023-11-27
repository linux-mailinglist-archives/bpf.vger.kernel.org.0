Return-Path: <bpf+bounces-15915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB38A7FA198
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 14:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66180281764
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F803035E;
	Mon, 27 Nov 2023 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InfdeYoK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98281108;
	Mon, 27 Nov 2023 13:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2E7C433C7;
	Mon, 27 Nov 2023 13:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701093316;
	bh=6ERBwQiaxIIDNTVWPQkxDhl1p/zo1tlsKma+ZLC6cPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=InfdeYoK/y2VllHqqyuUR/zrdyimXufJGapAUBhCgPsMsg+n2oWKxEP69Q0bFwZfg
	 es9Po9cmiJra9aMWLxdJuaV9GEdtUAQFzv+BUqNkRr/35hUX//I6etAnPdUB7DN98f
	 85XsG6sFG0Y3zxabNvXz4Sni/cECM3KJNgULHeeE3fHxGcrX8z57C7IPle5aSjMw9P
	 6+mAsEc138Qq7PP4+nfKNIoxgL201mwpru0JMw/KIx6I3d/V0N56O7Bug6mnGuK6/Z
	 jD0ihsZ/71U9oFMqWGto01EiqeTidq/EwOGY9kZ3vlbNoc+Hv5BQl7/QghOGyGH0PI
	 joYwrKeqYlybg==
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
Subject: [PATCH v3 11/33] ftrace: Allow ftrace startup flags exist without dynamic ftrace
Date: Mon, 27 Nov 2023 22:55:09 +0900
Message-Id: <170109330957.343914.4603643031632118062.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170109317214.343914.4784420430328654397.stgit@devnote2>
References: <170109317214.343914.4784420430328654397.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Some of the flags for ftrace_startup() may be exposed even when
CONFIG_DYNAMIC_FTRACE is not configured in. This is fine as the difference
between dynamic ftrace and static ftrace is done within the internals of
ftrace itself. No need to have use cases fail to compile because dynamic
ftrace is disabled.

This change is needed to move some of the logic of what is passed to
ftrace_startup() out of the parameters of ftrace_startup().

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 0955baccbb87..7b08169aa51d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -538,6 +538,15 @@ static inline void stack_tracer_disable(void) { }
 static inline void stack_tracer_enable(void) { }
 #endif
 
+enum {
+	FTRACE_UPDATE_CALLS		= (1 << 0),
+	FTRACE_DISABLE_CALLS		= (1 << 1),
+	FTRACE_UPDATE_TRACE_FUNC	= (1 << 2),
+	FTRACE_START_FUNC_RET		= (1 << 3),
+	FTRACE_STOP_FUNC_RET		= (1 << 4),
+	FTRACE_MAY_SLEEP		= (1 << 5),
+};
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 void ftrace_arch_code_modify_prepare(void);
@@ -632,15 +641,6 @@ void ftrace_set_global_notrace(unsigned char *buf, int len, int reset);
 void ftrace_free_filter(struct ftrace_ops *ops);
 void ftrace_ops_set_global_filter(struct ftrace_ops *ops);
 
-enum {
-	FTRACE_UPDATE_CALLS		= (1 << 0),
-	FTRACE_DISABLE_CALLS		= (1 << 1),
-	FTRACE_UPDATE_TRACE_FUNC	= (1 << 2),
-	FTRACE_START_FUNC_RET		= (1 << 3),
-	FTRACE_STOP_FUNC_RET		= (1 << 4),
-	FTRACE_MAY_SLEEP		= (1 << 5),
-};
-
 /*
  * The FTRACE_UPDATE_* enum is used to pass information back
  * from the ftrace_update_record() and ftrace_test_record()


