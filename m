Return-Path: <bpf+bounces-858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E2707998
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 07:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743C51C21038
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 05:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAAC17F1;
	Thu, 18 May 2023 05:26:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3B1FD3
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 05:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89634C433EF;
	Thu, 18 May 2023 05:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684387586;
	bh=WJ6N6MyKxI4LZfN4V0rKvxGhhdskUteODidgGjvX5ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rISHn17j8SHwXDcizyPewpD1DDuBGj7wRi7Uheg+HlECy4aXyrOEKE5ErEcyaKAz6
	 AjgEVINJJWWdQCXDwRchTH90O+NxCoqUpeRRlveY8r8+4i0RfiBIjN7tiCa+IxpZe4
	 3uKNDJf/XYWlH7iUfujl4pYqyUi8ykrwUeQZ/UoHDO9mZTdKk5MSeAZv6bTB6Y1ZzR
	 VbnxFBqJqIASz0UM6sNCm6wRZgEqI1RjxtD8Q7GRPx1Bhg4ip9/wcpziT4jSj70pEl
	 S1Oa/q6enWYWfurSLJs6FInBdm0Nauad17WntkTo8+1sWcqtJivAdav31lia15yWct
	 0ErMezjtqrmcA==
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
Subject: [PATCH v12 10/11] selftests/ftrace: Add BTF arguments test cases
Date: Thu, 18 May 2023 14:26:22 +0900
Message-ID:  <168438758204.1517340.6948648432407802640.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To:  <168438749373.1517340.14083401972478496211.stgit@mhiramat.roam.corp.google.com>
References:  <168438749373.1517340.14083401972478496211.stgit@mhiramat.roam.corp.google.com>
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
Changes in v11:
 - Change $args to $arg*
Changes in v10:
 - Change $$args to $args
 - Add new error patterns
 - Fix non BTF case
Changes in v7:
 - Add BTF void retval test case
---
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   54 ++++++++++++++++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   14 +++++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   14 +++++
 3 files changed, 82 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
new file mode 100644
index 000000000000..d2043346548d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
@@ -0,0 +1,54 @@
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
index d98e37c3ddc5..d94f55895e2f 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -85,4 +85,18 @@ fi
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


