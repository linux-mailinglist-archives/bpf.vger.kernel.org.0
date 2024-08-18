Return-Path: <bpf+bounces-37458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9658A955C91
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 14:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9741C21197
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7434B14D29C;
	Sun, 18 Aug 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIUz1yb4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E484529D0C;
	Sun, 18 Aug 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723985434; cv=none; b=G5zEUpZQIkgf6M5IZnHCoPxyKMFVOeZ+6Dk6y9rlQzj5hvxOXSWYhXWw/mJpLZebeNRyZhMrg4KRymKILlFdFxReJqTIBRVvwN5wQG0j1531EZeK2w8EH1916MrN8a3DKKh8CCHR/NnOlfdVrRPicuYQ01SNTcQy29h7TSNohCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723985434; c=relaxed/simple;
	bh=TU7U/7cI5u4iMQ6JCxAHG0ipOgBf+qmHbAaqBlHtV9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LA0x5O/EXJ6aq7zFQ/lNPWzs0D3UQ3yBr6YYldZpOCQ7UrTQIto9IGhjhffUSR87I2PEU7NE0Kn8V/Q73pLxvgtrO3qLsgj0lQMI/WKCLCjd133pYnuY/1z0DZxY8C3Sy/RrhrS3RaCxAZCJNjFW+3eQUlkb03z+K9WSO4dOgHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIUz1yb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A73C32786;
	Sun, 18 Aug 2024 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723985433;
	bh=TU7U/7cI5u4iMQ6JCxAHG0ipOgBf+qmHbAaqBlHtV9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIUz1yb4M7ayBUr2BbV2goGetNjwWmo7abR5PRZUdCuHIqvNXibtBSfEFgWQTtPrA
	 sxFcZJ7x+nlv4t9ovsh6dwrfPP9+BN0d5dZtn79rClDzTATc+71xM7IejCWpcPP879
	 gOxyTD5EveZlcLY3Daf51pzJKMzExGA0nBsq5hqNlso6rwWYUo6ZSENovp7fnh3eDH
	 4aUyBi8VS8i1g6gPC/zxQsjUhIN3tAXEQQ4gmOMR4PxWiReduL/h5rct3PYUxwH0Sh
	 f1JDY7udA1d7hYq8zYZ0JFjayXg0kE1kc8gLl7WgOYwIWfq47kQbxzP04dowveFE78
	 yQOIn64sdpEdQ==
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
Subject: [PATCH v13 15/20] tracing: Fix function timing profiler to initialize hashtable
Date: Sun, 18 Aug 2024 21:50:28 +0900
Message-Id: <172398542854.293426.832756994547822125.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172398527264.293426.2050093948411376857.stgit@devnote2>
References: <172398527264.293426.2050093948411376857.stgit@devnote2>
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

Since the new fgraph requires to initialize fgraph_ops.ops.func_hash before
calling register_ftrace_graph(), initialize it with default (tracing all
functions) parameter.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ftrace.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fd6c5a50c5e5..c55cf21fd53c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -885,6 +885,10 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 }
 
 static struct fgraph_ops fprofiler_ops = {
+	.ops = {
+		.flags = FTRACE_OPS_FL_INITIALIZED,
+		INIT_OPS_HASH(fprofiler_ops.ops)
+	},
 	.entryfunc = &profile_graph_entry,
 	.retfunc = &profile_graph_return,
 };


