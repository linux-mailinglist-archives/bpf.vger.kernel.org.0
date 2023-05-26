Return-Path: <bpf+bounces-1272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF1D711EC1
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 06:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1347280DFB
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 04:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08CB23AD;
	Fri, 26 May 2023 04:18:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D21C26
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 04:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD41C433D2;
	Fri, 26 May 2023 04:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685074713;
	bh=qmpCdAugBgsPhcWrZ4hfdxwV+mGWc1/Br26w6dBtRrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f51v+8GuH2KFPHbPRyfCxJVuDOQFuwr5BUAjN10tE3iPcd+zYLFocp0DbSS+2GHTi
	 LviFFvcuBG2SLcDfzNAFO+FsllQGkZ9kGmiE8wfgPGAp2LqX4e8O5z45Km0fCjF4gq
	 yl8+UEaZLbaLsH8pUzGd1vbHZtxVyDra0UhGyBBs34bHALChDbK4X8SsVYNk4beqgT
	 WaWHLUrQO+T9sgARn9s/LHxwVK23i3Qxvx4s/OQY0rW7vos69TMxNthRFU2F9HNQmS
	 8doW6S5LsHM38vuNCRC5fP/aCxqWB3OvMexDCjPVl8n/QfAJpghEzL4OWI7qpWCKN1
	 iKCxEPaG4B1AQ==
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
Subject: [PATCH v13 04/12] selftests/ftrace: Add fprobe related testcases
Date: Fri, 26 May 2023 12:18:28 +0800
Message-ID:  <168507470812.913472.7489900116963294042.stgit@mhiramat.roam.corp.google.com>
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

Add syntax error testcase and add-remove testcase for fprobe events.
This ensures that the fprobe events can be added/removed and parser
handles syntax errors correctly.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v13:
 - Fix to pass correct register name.
---
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 +++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   97 ++++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
new file mode 100644
index 000000000000..53e0d5671687
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove fprobe events
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]": README
+
+echo 0 > events/enable
+echo > dynamic_events
+
+PLACE=$FUNCTION_FORK
+
+echo "f:myevent1 $PLACE" >> dynamic_events
+echo "f:myevent2 $PLACE%return" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+test -d events/fprobes/myevent1
+test -d events/fprobes/myevent2
+
+echo "-:myevent2" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+! grep -q myevent2 dynamic_events
+
+echo > dynamic_events
+
+clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
new file mode 100644
index 000000000000..48e7a1a6aae3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -0,0 +1,97 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Fprobe event parser error log check
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]": README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'trace_fprobe' "$1" 'dynamic_events'
+}
+
+case `uname -m` in
+x86_64|i[3456]86)
+  REG=%ax ;;
+aarch64)
+  REG=%x0 ;;
+*)
+  REG=%r0 ;;
+esac
+
+check_error 'f^100 vfs_read'		# MAXACT_NO_KPROBE
+check_error 'f^1a111 vfs_read'		# BAD_MAXACT
+check_error 'f^100000 vfs_read'		# MAXACT_TOO_BIG
+
+check_error 'f ^non_exist_func'		# BAD_PROBE_ADDR (enoent)
+check_error 'f ^vfs_read+10'		# BAD_PROBE_ADDR
+check_error 'f:^/bar vfs_read'		# NO_GROUP_NAME
+check_error 'f:^12345678901234567890123456789012345678901234567890123456789012345/bar vfs_read'	# GROUP_TOO_LONG
+
+check_error 'f:^foo.1/bar vfs_read'	# BAD_GROUP_NAME
+check_error 'f:^ vfs_read'		# NO_EVENT_NAME
+check_error 'f:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
+check_error 'f:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
+
+check_error 'f vfs_read ^$retval'	# RETVAL_ON_PROBE
+check_error 'f vfs_read ^$stack10000'	# BAD_STACK_NUM
+
+check_error 'f vfs_read ^$arg10000'	# BAD_ARG_NUM
+
+check_error 'f vfs_read ^$none_var'	# BAD_VAR
+check_error 'f vfs_read ^'$REG		# BAD_VAR
+
+check_error 'f vfs_read ^@12345678abcde'	# BAD_MEM_ADDR
+check_error 'f vfs_read ^@+10'		# FILE_ON_KPROBE
+
+grep -q "imm-value" README && \
+check_error 'f vfs_read arg1=\^x'	# BAD_IMM
+grep -q "imm-string" README && \
+check_error 'f vfs_read arg1=\"abcd^'	# IMMSTR_NO_CLOSE
+
+check_error 'f vfs_read ^+0@0)'		# DEREF_NEED_BRACE
+check_error 'f vfs_read ^+0ab1(@0)'	# BAD_DEREF_OFFS
+check_error 'f vfs_read +0(+0(@0^)'	# DEREF_OPEN_BRACE
+
+if grep -A1 "fetcharg:" README | grep -q '\$comm' ; then
+check_error 'f vfs_read +0(^$comm)'	# COMM_CANT_DEREF
+fi
+
+check_error 'f vfs_read ^&1'		# BAD_FETCH_ARG
+
+
+# We've introduced this limitation with array support
+if grep -q ' <type>\\\[<array-size>\\\]' README; then
+check_error 'f vfs_read +0(^+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(@0))))))))))))))'	# TOO_MANY_OPS?
+check_error 'f vfs_read +0(@11):u8[10^'		# ARRAY_NO_CLOSE
+check_error 'f vfs_read +0(@11):u8[10]^a'	# BAD_ARRAY_SUFFIX
+check_error 'f vfs_read +0(@11):u8[^10a]'	# BAD_ARRAY_NUM
+check_error 'f vfs_read +0(@11):u8[^256]'	# ARRAY_TOO_BIG
+fi
+
+check_error 'f vfs_read @11:^unknown_type'	# BAD_TYPE
+check_error 'f vfs_read $stack0:^string'	# BAD_STRING
+check_error 'f vfs_read @11:^b10@a/16'		# BAD_BITFIELD
+
+check_error 'f vfs_read ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_LOG
+check_error 'f vfs_read ^=@11'			# NO_ARG_NAME
+check_error 'f vfs_read ^var.1=@11'		# BAD_ARG_NAME
+check_error 'f vfs_read var1=@11 ^var1=@12'	# USED_ARG_NAME
+check_error 'f vfs_read ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
+check_error 'f vfs_read arg1=^'			# NO_ARG_BODY
+
+
+# multiprobe errors
+if grep -q "Create/append/" README && grep -q "imm-value" README; then
+echo "f:fprobes/testevent $FUNCTION_FORK" > dynamic_events
+check_error '^f:fprobes/testevent do_exit%return'	# DIFF_PROBE_TYPE
+
+# Explicitly use printf "%s" to not interpret \1
+printf "%s" "f:fprobes/testevent $FUNCTION_FORK abcd=\\1" > dynamic_events
+check_error "f:fprobes/testevent $FUNCTION_FORK ^bcd=\\1"	# DIFF_ARG_TYPE
+check_error "f:fprobes/testevent $FUNCTION_FORK ^abcd=\\1:u8"	# DIFF_ARG_TYPE
+check_error "f:fprobes/testevent $FUNCTION_FORK ^abcd=\\\"foo\"" # DIFF_ARG_TYPE
+check_error "^f:fprobes/testevent $FUNCTION_FORK abcd=\\1"	# SAME_PROBE
+fi
+
+# %return suffix errors
+check_error 'f vfs_read^%hoge'		# BAD_ADDR_SUFFIX
+
+exit 0


