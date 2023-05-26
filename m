Return-Path: <bpf+bounces-1279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCCF711ECD
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 06:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B8E1C20F8B
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 04:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8812116;
	Fri, 26 May 2023 04:19:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411DE1C26
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 04:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D63C433EF;
	Fri, 26 May 2023 04:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685074788;
	bh=dbln3He1tcZb4j0efr7xOCNCz5ZzL9NeUrxJ8odEE98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOZnajfecDl7YEzO4tRAMxQSBnItueWJkiedgNeAoCDmB+Y9RYu2GQ5E7jb50v/P3
	 Xad7t+mahb33ebelopibqZXS5nHGNHOQbwBvXWLZyjz/lC0gMHTJQwFgIsCci6+wFL
	 aYnP/+pNnl/GddLMejmQAPZs4j3j2DFJI+McWnLc2PYPMTpFkAG7BGVwiYnVTgB3PR
	 Jdp7NgUxUKibuA4Ph70u2SLRn3Org8HBvgXl7wyzsdpKzrzthQQMXgZePlxD6x4wJN
	 v5RzSrvRDAOwfWqfg9yiAX9oOyuPTql60jtNU2Z5HGE+n5c+DvV2fCHt8HAmGVWOtf
	 V1fB3E6d9wKbg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Florent Revest <revest@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v13 11/12] selftests/ftrace: Add BTF arguments test cases
Date: Fri, 26 May 2023 12:19:42 +0800
Message-ID:  <168507478292.913472.25631899274942311.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
References:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
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

Add test cases to check the BTF arguments correctly supported.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v13:
 - Add a test case for only "$argN" argument case (no '$arg*')
Changes in v11:
 - Change $args to $arg*
Changes in v10:
 - Change $$args to $args
 - Add new error patterns
 - Fix non BTF case
Changes in v7:
 - Add BTF void retval test case
---
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   58 ++++++++++++++++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   14 +++++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   14 +++++
 3 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
new file mode 100644
index 000000000000..b89de1771655
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
@@ -0,0 +1,58 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove probes with BTF arguments
+# requires: dynamic_events "<argname>":README
+
+KPROBES=
+FPROBES=
+
+if grep -qF "p[:[<group>/][<event>]] <place> [<args>]" README ; then
+  KPROBES=yes
+fi
+if grep -qF "f[:[<group>/][<event>]] <func-name>[%return] [<args>]" README ; then
+  FPROBES=yes
+fi
+
+if [ -z "$KPROBES" -a "$FPROBES" ] ; then
+  exit_unsupported
+fi
+
+echo 0 > events/enable
+echo > dynamic_events
+
+TP=kfree
+
+if [ "$FPROBES" ] ; then
+echo "f:fpevent $TP object" >> dynamic_events
+echo "t:tpevent $TP ptr" >> dynamic_events
+
+grep -q "fpevent.*object=object" dynamic_events
+grep -q "tpevent.*ptr=ptr" dynamic_events
+
+echo > dynamic_events
+
+echo "f:fpevent $TP "'$arg1' >> dynamic_events
+grep -q "fpevent.*object=object" dynamic_events
+echo > dynamic_events
+
+echo "f:fpevent $TP "'$arg*' >> dynamic_events
+echo "t:tpevent $TP "'$arg*' >> dynamic_events
+
+grep -q "fpevent.*object=object" dynamic_events
+grep -q "tpevent.*ptr=ptr" dynamic_events
+! grep -q "tpevent.*_data" dynamic_events
+fi
+
+echo > dynamic_events
+
+if [ "$KPROBES" ] ; then
+echo "p:kpevent $TP object" >> dynamic_events
+grep -q "kpevent.*object=object" dynamic_events
+
+echo > dynamic_events
+
+echo "p:kpevent $TP "'$arg*' >> dynamic_events
+grep -q "kpevent.*object=object" dynamic_events
+fi
+
+clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 4065a21efea1..812f5b3f6055 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -94,4 +94,18 @@ fi
 # %return suffix errors
 check_error 'f vfs_read^%hoge'		# BAD_ADDR_SUFFIX
 
+# BTF arguments errors
+if grep -q "<argname>" README; then
+check_error 'f vfs_read args=^$arg*'		# BAD_VAR_ARGS
+check_error 'f vfs_read +0(^$arg*)'		# BAD_VAR_ARGS
+check_error 'f vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
+check_error 'f vfs_read%return ^$arg*'		# NOFENTRY_ARGS
+check_error 'f vfs_read ^hoge'			# NO_BTFARG
+check_error 'f kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
+check_error 'f kfree%return ^$retval'		# NO_RETVAL
+else
+check_error 'f vfs_read ^$arg*'			# NOSUP_BTFARG
+check_error 't kfree ^$arg*'			# NOSUP_BTFARG
+fi
+
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 97c08867490a..65fbb26fd58c 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -103,4 +103,18 @@ check_error 'p vfs_read^%hoge'		# BAD_ADDR_SUFFIX
 check_error 'p ^vfs_read+10%return'	# BAD_RETPROBE
 fi
 
+# BTF arguments errors
+if grep -q "<argname>" README; then
+check_error 'p vfs_read args=^$arg*'		# BAD_VAR_ARGS
+check_error 'p vfs_read +0(^$arg*)'		# BAD_VAR_ARGS
+check_error 'p vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
+check_error 'r vfs_read ^$arg*'			# NOFENTRY_ARGS
+check_error 'p vfs_read+8 ^$arg*'		# NOFENTRY_ARGS
+check_error 'p vfs_read ^hoge'			# NO_BTFARG
+check_error 'p kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
+check_error 'r kfree ^$retval'			# NO_RETVAL
+else
+check_error 'p vfs_read ^$arg*'			# NOSUP_BTFARG
+fi
+
 exit 0


