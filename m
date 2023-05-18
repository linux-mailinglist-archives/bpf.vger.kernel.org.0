Return-Path: <bpf+bounces-857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3191707997
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 07:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6032D2811E5
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 05:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B66417FD;
	Thu, 18 May 2023 05:26:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5255137A
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 05:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5E0C433D2;
	Thu, 18 May 2023 05:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684387577;
	bh=swEECm8NRQdrlStMrPiiTWCZiesY9e/fVW5ZeJPBjhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcF1gKLhxNSkixVhfdUtkTKWDeHxMyQA7xjEZoEsM1rlH3IDuOwwnKlM4y3SKpqZx
	 kqqxQGpXllIQ2EGfpR5zoPxiXyoSHVXBhifhhk44S+xM11Z69ZmRvoP8ch1WH2BgBr
	 hqkAB+sZBl7AN+J9y1rtNJoRgo7/Cnj0RdCro/71A9qs9W31/GNMia7LaOYcgNSDhB
	 kJ81g9SareP8MWOI5QKuq8ZAaXgd18B4crMSmObWTPoI+jruNhOU1JohLH8/WGTG4q
	 zcU/PnUj2LR783LAZl0OJ5JpGQMbrHFM8ZRU+IQkRT0CVEUzJ/58/9M8rZRN9hgREq
	 6Y2FM7O3z+0Vg==
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
Subject: [PATCH v12 09/11] selftests/ftrace: Add tracepoint probe test case
Date: Thu, 18 May 2023 14:26:13 +0900
Message-ID:  <168438757331.1517340.15682668789699005853.stgit@mhiramat.roam.corp.google.com>
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

Add test cases for tracepoint probe events.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v12:
 - Fix to remove buggy space in requires line.
---
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |    2 
 .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   27 +++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    2 
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |   82 ++++++++++++++++++++
 4 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 53e0d5671687..dc25bcf4f9e2 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove fprobe events
-# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]": README
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README
 
 echo 0 > events/enable
 echo > dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
new file mode 100644
index 000000000000..155792eaeee5
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove tracepoint probe events
+# requires: dynamic_events "t[:[<group>/][<event>]] <tracepoint> [<args>]":README
+
+echo 0 > events/enable
+echo > dynamic_events
+
+TRACEPOINT1=kmem_cache_alloc
+TRACEPOINT2=kmem_cache_free
+
+echo "t:myevent1 $TRACEPOINT1" >> dynamic_events
+echo "t:myevent2 $TRACEPOINT2" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+test -d events/tracepoints/myevent1
+test -d events/tracepoints/myevent2
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
index 549daa162d84..d98e37c3ddc5 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Fprobe event parser error log check
-# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]": README
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'trace_fprobe' "$1" 'dynamic_events'
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
new file mode 100644
index 000000000000..da117b8f1d12
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
@@ -0,0 +1,82 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Tracepoint probe event parser error log check
+# requires: dynamic_events "t[:[<group>/][<event>]] <tracepoint> [<args>]":README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'trace_fprobe' "$1" 'dynamic_events'
+}
+
+check_error 't^100 kfree'		# BAD_MAXACT_TYPE
+
+check_error 't ^non_exist_tracepoint'	# NO_TRACEPOINT
+check_error 't:^/bar kfree'		# NO_GROUP_NAME
+check_error 't:^12345678901234567890123456789012345678901234567890123456789012345/bar kfree'	# GROUP_TOO_LONG
+
+check_error 't:^foo.1/bar kfree'	# BAD_GROUP_NAME
+check_error 't:^ kfree'			# NO_EVENT_NAME
+check_error 't:foo/^12345678901234567890123456789012345678901234567890123456789012345 kfree'	# EVENT_TOO_LONG
+check_error 't:foo/^bar.1 kfree'	# BAD_EVENT_NAME
+
+check_error 't kfree ^$retval'		# RETVAL_ON_PROBE
+check_error 't kfree ^$stack10000'	# BAD_STACK_NUM
+
+check_error 't kfree ^$arg10000'	# BAD_ARG_NUM
+
+check_error 't kfree ^$none_var'	# BAD_VAR
+check_error 't kfree ^%rax'		# BAD_VAR
+
+check_error 't kfree ^@12345678abcde'	# BAD_MEM_ADDR
+check_error 't kfree ^@+10'		# FILE_ON_KPROBE
+
+grep -q "imm-value" README && \
+check_error 't kfree arg1=\^x'	# BAD_IMM
+grep -q "imm-string" README && \
+check_error 't kfree arg1=\"abcd^'	# IMMSTR_NO_CLOSE
+
+check_error 't kfree ^+0@0)'		# DEREF_NEED_BRACE
+check_error 't kfree ^+0ab1(@0)'	# BAD_DEREF_OFFS
+check_error 't kfree +0(+0(@0^)'	# DEREF_OPEN_BRACE
+
+if grep -A1 "fetcharg:" README | grep -q '\$comm' ; then
+check_error 't kfree +0(^$comm)'	# COMM_CANT_DEREF
+fi
+
+check_error 't kfree ^&1'		# BAD_FETCH_ARG
+
+
+# We've introduced this limitation with array support
+if grep -q ' <type>\\\[<array-size>\\\]' README; then
+check_error 't kfree +0(^+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(@0))))))))))))))'	# TOO_MANY_OPS?
+check_error 't kfree +0(@11):u8[10^'		# ARRAY_NO_CLOSE
+check_error 't kfree +0(@11):u8[10]^a'		# BAD_ARRAY_SUFFIX
+check_error 't kfree +0(@11):u8[^10a]'		# BAD_ARRAY_NUM
+check_error 't kfree +0(@11):u8[^256]'		# ARRAY_TOO_BIG
+fi
+
+check_error 't kfree @11:^unknown_type'		# BAD_TYPE
+check_error 't kfree $stack0:^string'		# BAD_STRING
+check_error 't kfree @11:^b10@a/16'		# BAD_BITFIELD
+
+check_error 't kfree ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_LOG
+check_error 't kfree ^=@11'			# NO_ARG_NAME
+check_error 't kfree ^var.1=@11'		# BAD_ARG_NAME
+check_error 't kfree var1=@11 ^var1=@12'	# USED_ARG_NAME
+check_error 't kfree ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
+check_error 't kfree arg1=^'			# NO_ARG_BODY
+
+
+# multiprobe errors
+if grep -q "Create/append/" README && grep -q "imm-value" README; then
+echo "t:tracepoint/testevent kfree" > dynamic_events
+check_error '^f:tracepoint/testevent kfree'	# DIFF_PROBE_TYPE
+
+# Explicitly use printf "%s" to not interpret \1
+printf "%s" "t:tracepoints/testevent kfree abcd=\\1" > dynamic_events
+check_error "t:tracepoints/testevent kfree ^bcd=\\1"	# DIFF_ARG_TYPE
+check_error "t:tracepoints/testevent kfree ^abcd=\\1:u8"	# DIFF_ARG_TYPE
+check_error "t:tracepoints/testevent kfree ^abcd=\\\"foo\"" # DIFF_ARG_TYPE
+check_error "^t:tracepoints/testevent kfree abcd=\\1"	# SAME_PROBE
+fi
+
+exit 0


