Return-Path: <bpf+bounces-851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A00C070798B
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 07:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E191C2100C
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 05:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A2F17F1;
	Thu, 18 May 2023 05:25:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6EA649
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 05:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBBAC4339C;
	Thu, 18 May 2023 05:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684387525;
	bh=Rr6xQgk50Y4ZGBCzUd1zUs+X3lNoqxnJIVxDwxiF6LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfupOR3C9CbatAoUsPn6gZMjegAxOuR8IdLgrzPwWnFe2SS/VJOdhEkoES4m7c2Oj
	 82yYqNxqMKFxmTU2xYEW3JW9jhk/nbPmyKhsnjN0an9N2sExm/YI2meXY11147I6to
	 KHSRDRJXkdyqjfVcXPFXeTPJJyS3flVEXU3lJB8a1WpkU+uhImwUR9Pvsn7h5UiEQt
	 37pYLDkQqerJ0t4fQHUrC9rXRy3UfYm4mS3J7wkTnq3OzFN48cjBXlpwKzPaWV2LGj
	 d7qSGuVU1CdoB8+bGa7lGydetU53VqwlnpWJqWOs52eUhLhBj8LAWrbVUP4UEkMzLZ
	 FMHhhD2psnqSw==
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
Subject: [PATCH v12 03/11] selftests/ftrace: Add fprobe related testcases
Date: Thu, 18 May 2023 14:25:20 +0900
Message-ID:  <168438752058.1517340.18075846446788901894.stgit@mhiramat.roam.corp.google.com>
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

Add syntax error testcase and add-remove testcase for fprobe events.
This ensures that the fprobe events can be added/removed and parser
handles syntax errors correctly.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 ++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   88 ++++++++++++++++++++
 2 files changed, 114 insertions(+)
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
index 000000000000..549daa162d84
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -0,0 +1,88 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Fprobe event parser error log check
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]": README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'trace_fprobe' "$1" 'dynamic_events'
+}
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
+check_error 'f vfs_read ^%rax'		# BAD_VAR
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


