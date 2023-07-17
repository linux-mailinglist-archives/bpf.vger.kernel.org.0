Return-Path: <bpf+bounces-5108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C213B7567D3
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE8F28120E
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA249253DB;
	Mon, 17 Jul 2023 15:24:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969A7A94F
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 15:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239C4C433C7;
	Mon, 17 Jul 2023 15:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689607472;
	bh=Ud+/WgVDgP+xcku85SFsEC4AToiKRsKLRxeToviMbLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRLWgmFjqOYNpjJ7uT98XQf53pRsqoJ4KmYQWSnI4dydNJiKY+NUpsytf0n08osMl
	 bVICQQ33luLAfE1ZmrCsyk8Xbu2GIQanzzFIlTnoi/YVyASFCwDX2OlrfAAp/RNGcu
	 s3JUM/jYOhZyt7JPBTY9K/c48UNAEr9Xz80nb6FVW4FP3ftIqkTyLym+QUvSSs+HMo
	 w6odgw62hH6rmuzXxgGnwOHMUm+GDEWTEf1bQPB7ro8WMzecBIVVoxPZXUSrCQn92U
	 4inLw+VzOJrEaOP5xrkXWOnF69dfEcUyq34fSbGX4UXG8Na9YBu9YTlqld0wQo1jq/
	 wX4MzPAn06RvA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 7/9] tracing/fprobe-event: Assume fprobe is a return event by $retval
Date: Tue, 18 Jul 2023 00:24:27 +0900
Message-Id: <168960746736.34107.3486065330592238119.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <168960739768.34107.15145201749042174448.stgit@devnote2>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
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

Assume the fprobe event is a return event if there is $retval is
used in the probe's argument without %return. e.g.

echo 'f:myevent vfs_read $retval' >> dynamic_events

then 'myevent' is a return probe event.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c                        |   58 +++++++++++++++-----
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    2 -
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index dfe2e546acdc..3ac0e04071aa 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -898,6 +898,46 @@ static struct tracepoint *find_tracepoint(const char *tp_name)
 	return data.tpoint;
 }
 
+static int parse_symbol_and_return(int argc, const char *argv[],
+				   char **symbol, bool *is_return,
+				   bool is_tracepoint)
+{
+	char *tmp = strchr(argv[1], '%');
+	int i;
+
+	if (tmp) {
+		int len = tmp - argv[1];
+
+		if (!is_tracepoint && !strcmp(tmp, "%return")) {
+			*is_return = true;
+		} else {
+			trace_probe_log_err(len, BAD_ADDR_SUFFIX);
+			return -EINVAL;
+		}
+		*symbol = kmemdup_nul(argv[1], len, GFP_KERNEL);
+	} else
+		*symbol = kstrdup(argv[1], GFP_KERNEL);
+	if (!*symbol)
+		return -ENOMEM;
+
+	if (*is_return)
+		return 0;
+
+	/* If there is $retval, this should be a return fprobe. */
+	for (i = 2; i < argc; i++) {
+		tmp = strstr(argv[i], "$retval");
+		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
+			*is_return = true;
+			/*
+			 * NOTE: Don't check is_tracepoint here, because it will
+			 * be checked when the argument is parsed.
+			 */
+			break;
+		}
+	}
+	return 0;
+}
+
 static int __trace_fprobe_create(int argc, const char *argv[])
 {
 	/*
@@ -927,7 +967,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	struct trace_fprobe *tf = NULL;
 	int i, len, new_argc = 0, ret = 0;
 	bool is_return = false;
-	char *symbol = NULL, *tmp = NULL;
+	char *symbol = NULL;
 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
 	const char **new_argv = NULL;
 	int maxactive = 0;
@@ -983,20 +1023,10 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	trace_probe_log_set_index(1);
 
 	/* a symbol(or tracepoint) must be specified */
-	symbol = kstrdup(argv[1], GFP_KERNEL);
-	if (!symbol)
-		return -ENOMEM;
+	ret = parse_symbol_and_return(argc, argv, &symbol, &is_return, is_tracepoint);
+	if (ret < 0)
+		goto parse_error;
 
-	tmp = strchr(symbol, '%');
-	if (tmp) {
-		if (!is_tracepoint && !strcmp(tmp, "%return")) {
-			*tmp = '\0';
-			is_return = true;
-		} else {
-			trace_probe_log_err(tmp - symbol, BAD_ADDR_SUFFIX);
-			goto parse_error;
-		}
-	}
 	if (!is_return && maxactive) {
 		trace_probe_log_set_index(0);
 		trace_probe_log_err(1, BAD_MAXACT_TYPE);
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 812f5b3f6055..72563b2e0812 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -30,11 +30,11 @@ check_error 'f:^ vfs_read'		# NO_EVENT_NAME
 check_error 'f:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
 check_error 'f:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
 
-check_error 'f vfs_read ^$retval'	# RETVAL_ON_PROBE
 check_error 'f vfs_read ^$stack10000'	# BAD_STACK_NUM
 
 check_error 'f vfs_read ^$arg10000'	# BAD_ARG_NUM
 
+check_error 'f vfs_read $retval ^$arg1' # BAD_VAR
 check_error 'f vfs_read ^$none_var'	# BAD_VAR
 check_error 'f vfs_read ^'$REG		# BAD_VAR
 


