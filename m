Return-Path: <bpf+bounces-14246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2472F7E146B
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 17:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5782E1C20918
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C1414A8E;
	Sun,  5 Nov 2023 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9r39sEc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF56DF9DA;
	Sun,  5 Nov 2023 16:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D8AC433C9;
	Sun,  5 Nov 2023 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699200639;
	bh=2WlQKdWbi99vKuQZnLhkUQgCEXy+Nfuzu2d7nEzVsTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t9r39sEcBlbf74NlrzR4B8Lle9WJaLJPkd7Yj8058moBUJM9BSEIitXmIzuxEEaXi
	 xfkKEr9LFKF5//Xf6ZTafDe5ngETaGLMNpSCFrglua32coY+eWP255NG3KIJGChiJM
	 0mPhZ4OmmEk0xGvLSIY6RR+Kz4+MC4xpgpuqNvffIJkR7UBCwyinyVK+eafTCP3MbP
	 hE8/xAY8TcGzILkYg8YnukhSFlP5gLxADP46/f1t6q+O1md8kd0PjUFDHEwEXUGkyI
	 21TvMVdjRGRPaE51PhOxqGcdeEsaN4MM+WVwTluLfRpn1M/g0G99Zs5mItY7YHZsWO
	 0gnyqS2oZQ8hg==
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
Subject: [RFC PATCH 20/32] function_graph: Pass the size of reserved data when retrieving it
Date: Mon,  6 Nov 2023 01:10:34 +0900
Message-Id: <169920063363.482486.14684899342898937044.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169920038849.482486.15796387219966662967.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
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

Make the fgraph_retrieve_data() returns the reverved data size via
size_byte parameter.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace.h        |    2 +-
 kernel/trace/fgraph.c         |    5 ++++-
 kernel/trace/trace_selftest.c |   10 +++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 115758fe9fec..2e24a2611ca8 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1050,7 +1050,7 @@ struct fgraph_ops {
 };
 
 void *fgraph_reserve_data(int size_bytes);
-void *fgraph_retrieve_data(void);
+void *fgraph_retrieve_data(int *size_bytes);
 
 /*
  * Stack of return addresses for functions
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index e51695441476..0b8a1daef733 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -289,6 +289,7 @@ void *fgraph_reserve_data(int size_bytes)
 
 /**
  * fgraph_retrieve_data - Retrieve stored data from fgraph_reserve_data()
+ * @size_bytes: pointer to retrieved data size.
  *
  * This is to be called by a fgraph_ops retfunc(), to retrieve data that
  * was stored by the fgraph_ops entryfunc() on the function entry.
@@ -300,7 +301,7 @@ void *fgraph_reserve_data(int size_bytes)
  *    matching entryfunc() for the retfunc() this is called from.
  *   Or NULL if there was nothing stored.
  */
-void *fgraph_retrieve_data(void)
+void *fgraph_retrieve_data(int *size_bytes)
 {
 	unsigned long val;
 	int curr_ret_stack = current->curr_ret_stack;
@@ -313,6 +314,8 @@ void *fgraph_retrieve_data(void)
 	val = current->ret_stack[curr_ret_stack - 2];
 	if (__get_type(val) != FGRAPH_TYPE_DATA)
 		return NULL;
+	if (size_bytes)
+		*size_bytes = (__get_data(val) - 1) * sizeof(long);
 
 	return &current->ret_stack[curr_ret_stack -
 				   (__get_data(val) + 1)];
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 14966d8509ed..c656ec5b3348 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -807,15 +807,23 @@ static __init void store_return(struct ftrace_graph_ret *trace,
 	const char *type = fgraph_store_type_name;
 	long long expect = 0;
 	long long found = -1;
+	int size;
 	char *p;
 
-	p = fgraph_retrieve_data();
+	p = fgraph_retrieve_data(&size);
 	if (!p) {
 		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
 			 "Failed to retrieve %s\n", type);
 		fgraph_error_str = fgraph_error_str_buf;
 		return;
 	}
+	if (fgraph_store_size > size) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "Retrieved size %d is smaller than expected %d\n",
+			 size, (int)fgraph_store_size);
+		fgraph_error_str = fgraph_error_str_buf;
+		return;
+	}
 
 	switch (fgraph_store_size) {
 	case 1:


