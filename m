Return-Path: <bpf+bounces-14247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C657E146D
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 17:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B33AB20E12
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4C14AB2;
	Sun,  5 Nov 2023 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Elgaphgm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752113FF4;
	Sun,  5 Nov 2023 16:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEA8C433C8;
	Sun,  5 Nov 2023 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699200650;
	bh=FCiUbQ7cF3hWz3W5mYkLUGazPgX9XWR3NoQQHaWsf5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElgaphgmZOlJVXyX6c/8ZRvVfsILDJK73lDr2cM6FuDWVRFQVi1Xl/jFjbpWMRuKl
	 qiUTseyiLMuAGQB4ygAmSB7CeXSWOh/6CzLH7qYgVRX9Jy+jGPrVg9GVtf+h173CQ9
	 RV4Zke/9/N12hKsdXTVkAXIZIkd8YoxEa8A+3icYfbcDv8A5agz9eYlOWWKvZ+II4v
	 TlFevh2JOy+CP6/Fv6AcPJ0UFGDoypzm2T99ComFygwZqQrU9IZnD8gBeWnOKNOLaG
	 yzscPjTfm/KgcNUMQEjH92QhLUI4kznMLszTu7TS/vyRKNFwBcaWY7y36iecvK3YxB
	 pTes6Uyn61cGg==
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
Subject: [RFC PATCH 21/32] function_graph: Expand the max reserved data size
Date: Mon,  6 Nov 2023 01:10:45 +0900
Message-Id: <169920064470.482486.9772883857059976420.stgit@devnote2>
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

Expand the maximum reserved data size to 32 from 4. On 64bit system,
this will allow reserving 256 bytes on the ret_stack in maximum but
that may not happen.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fgraph.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 0b8a1daef733..e7188c67356e 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -95,7 +95,7 @@ enum {
 #define FGRAPH_ARRAY_MASK	((1 << FGRAPH_ARRAY_SIZE) - 1)
 #define FGRAPH_ARRAY_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
 
-#define FGRAPH_DATA_SIZE	2
+#define FGRAPH_DATA_SIZE	5
 #define FGRAPH_DATA_MASK	((1 << FGRAPH_DATA_SIZE) - 1)
 #define FGRAPH_DATA_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
 
@@ -113,7 +113,7 @@ enum {
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
 
-#define FGRAPH_MAX_DATA_SIZE (sizeof(long) * 4)
+#define FGRAPH_MAX_DATA_SIZE (sizeof(long) * (1 << FGRAPH_DATA_SIZE))
 
 /*
  * Each fgraph_ops has a reservered unsigned long at the end (top) of the


