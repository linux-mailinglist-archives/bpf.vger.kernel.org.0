Return-Path: <bpf+bounces-32259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CA890A207
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 03:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA7F2818B7
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 01:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5B18413D;
	Mon, 17 Jun 2024 01:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoGVDpM5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11A160884;
	Mon, 17 Jun 2024 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588956; cv=none; b=tTUS33brxyN8rPO5X2BKgGXR0UQGZ7BXk55bwzFpIHmH/knJ13UoEFXA4LZSVAETbKH/zo18KHs8s1IvEB9IqXNvyT17GC5p6WBbRqfk5lroved1xMdJv3coTEM7sfUk3WSATqu1Dgzgoo14B42+nUkni5xk3kRjompZDNtdPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588956; c=relaxed/simple;
	bh=6LRuOvaZstDE6JovoZfd2CiVZaFBRwbUc1jP+rvwiso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G50W5dPfD4HXEftDCGq6w0VElL10j2aOAL/xLQUWoYAQJxU2Y0tndZHdAS0xwBWHLAOY5Jel9auDU5gd8czV8sxtN1GI+8t0BRGEXcBO8pfWL5Hi5UxuGblzCz+Goh6CdByY9fWAeV0w9E0FZHhdGlb9tr3IAZWPb1wB7dGsTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoGVDpM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7BDC2BBFC;
	Mon, 17 Jun 2024 01:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718588956;
	bh=6LRuOvaZstDE6JovoZfd2CiVZaFBRwbUc1jP+rvwiso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CoGVDpM5cqUI1Yonuijdd3lN1cTWNj2tbkhGyNWGBr4jnxKFPdjGepjqkfOa13Jx0
	 vIuxgvvcTTQDHPOZRrHeAbN9HAmK87b6VVDMWRovi9tamKs9eM61nX7qRsAPbjwTjH
	 Hs3vAIdPxTL55IA7Ju4miREruJHlWZYaInootkcITaiJqjMRaeCjXukBG5oGziuHWr
	 w/QPMvghXoHJtxHh+VM2FFbooRwb3XPorV9AV51jSSrMdTo46n17SJMsc4EzoKpA+b
	 bXXi2CdaSYGvVOIjEnkqx54NL/rCFQG/jCkcpXPfcpui4eSB1aISugA1g6hAwurs4C
	 3MEPCwYHUn9GQ==
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
Subject: [PATCH v11 14/18] tracing/fprobe: Remove nr_maxactive from fprobe
Date: Mon, 17 Jun 2024 10:49:10 +0900
Message-Id: <171858895032.288820.2501510126596153887.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171858878797.288820.237119113242007537.stgit@devnote2>
References: <171858878797.288820.237119113242007537.stgit@devnote2>
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

Remove depercated fprobe::nr_maxactive. This involves fprobe events to
rejects the maxactive number.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Newly added.
---
 include/linux/fprobe.h      |    2 --
 kernel/trace/trace_fprobe.c |   44 ++++++-------------------------------------
 2 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 2d06bbd99601..a86b3e4df2a0 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -54,7 +54,6 @@ struct fprobe_hlist {
  * @nmissed: The counter for missing events.
  * @flags: The status flag.
  * @entry_data_size: The private data storage size.
- * @nr_maxactive: The max number of active functions. (*deprecated)
  * @entry_handler: The callback function for function entry.
  * @exit_handler: The callback function for function exit.
  * @hlist_array: The fprobe_hlist for fprobe search from IP hash table.
@@ -63,7 +62,6 @@ struct fprobe {
 	unsigned long		nmissed;
 	unsigned int		flags;
 	size_t			entry_data_size;
-	int			nr_maxactive;
 
 	fprobe_entry_cb entry_handler;
 	fprobe_exit_cb  exit_handler;
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 86cd6a8c806a..20ef5cd5d419 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -422,7 +422,6 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 					       const char *event,
 					       const char *symbol,
 					       struct tracepoint *tpoint,
-					       int maxactive,
 					       int nargs, bool is_return)
 {
 	struct trace_fprobe *tf;
@@ -442,7 +441,6 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 		tf->fp.entry_handler = fentry_dispatcher;
 
 	tf->tpoint = tpoint;
-	tf->fp.nr_maxactive = maxactive;
 
 	ret = trace_probe_init(&tf->tp, event, group, false, nargs);
 	if (ret < 0)
@@ -1021,12 +1019,11 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
 	struct trace_fprobe *tf = NULL;
-	int i, len, new_argc = 0, ret = 0;
+	int i, new_argc = 0, ret = 0;
 	bool is_return = false;
 	char *symbol = NULL;
 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
 	const char **new_argv = NULL;
-	int maxactive = 0;
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char sbuf[KSYM_NAME_LEN];
@@ -1048,33 +1045,13 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 
 	trace_probe_log_init("trace_fprobe", argc, argv);
 
-	event = strchr(&argv[0][1], ':');
-	if (event)
-		event++;
-
-	if (isdigit(argv[0][1])) {
-		if (event)
-			len = event - &argv[0][1] - 1;
-		else
-			len = strlen(&argv[0][1]);
-		if (len > MAX_EVENT_NAME_LEN - 1) {
-			trace_probe_log_err(1, BAD_MAXACT);
-			goto parse_error;
-		}
-		memcpy(buf, &argv[0][1], len);
-		buf[len] = '\0';
-		ret = kstrtouint(buf, 0, &maxactive);
-		if (ret || !maxactive) {
+	if (argv[0][1] != '\0') {
+		if (argv[0][1] != ':') {
+			trace_probe_log_set_index(0);
 			trace_probe_log_err(1, BAD_MAXACT);
 			goto parse_error;
 		}
-		/* fprobe rethook instances are iterated over via a list. The
-		 * maximum should stay reasonable.
-		 */
-		if (maxactive > RETHOOK_MAXACTIVE_MAX) {
-			trace_probe_log_err(1, MAXACT_TOO_BIG);
-			goto parse_error;
-		}
+		event = &argv[0][2];
 	}
 
 	trace_probe_log_set_index(1);
@@ -1084,12 +1061,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	if (ret < 0)
 		goto parse_error;
 
-	if (!is_return && maxactive) {
-		trace_probe_log_set_index(0);
-		trace_probe_log_err(1, BAD_MAXACT_TYPE);
-		goto parse_error;
-	}
-
 	trace_probe_log_set_index(0);
 	if (event) {
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
@@ -1147,8 +1118,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		goto out;
 
 	/* setup a probe */
-	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
-				argc, is_return);
+	tf = alloc_trace_fprobe(group, event, symbol, tpoint, argc, is_return);
 	if (IS_ERR(tf)) {
 		ret = PTR_ERR(tf);
 		/* This must return -ENOMEM, else there is a bug */
@@ -1230,8 +1200,6 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
 		seq_putc(m, 't');
 	else
 		seq_putc(m, 'f');
-	if (trace_fprobe_is_return(tf) && tf->fp.nr_maxactive)
-		seq_printf(m, "%d", tf->fp.nr_maxactive);
 	seq_printf(m, ":%s/%s", trace_probe_group_name(&tf->tp),
 				trace_probe_name(&tf->tp));
 


