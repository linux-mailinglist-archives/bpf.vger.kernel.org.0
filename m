Return-Path: <bpf+bounces-7120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F130D771899
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 04:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEF52810F4
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 02:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8439D10F5;
	Mon,  7 Aug 2023 02:55:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F902A5C
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 02:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FE5C433C7;
	Mon,  7 Aug 2023 02:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691376953;
	bh=rmxZE83d3FXHRV2guA/jsebhw3LfN+eEvFVGseZCh3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WnYTCRr1Lss7WR/d5AJQW78eAGilsSVBOaKHG+hpnKM2wB7vUxBgcYYolWgAkJc2I
	 lqE6mV9rwSCLhZVsmgJNIBcySKQ+dbaHFw/kLhdGvySDg2gOwfXwV6bFWak9ONysmt
	 SSti2LMCUdHSdL6H605JndN4N6BneEQuaboVNr5OiSTQW4fAmFY+WOMcVNUniriw+Z
	 9d8dFQob/b5SuMH7nHB2Oryp7xSsoLjrkePhQhjYFQQtrBHBCnPoYnEIJaW70JFmDh
	 IbSL9rolpHsyXCwWEzKzuZOfHJ/2oR6kZoI7rEQYN9JX0BCqog+DemIUY1n0v8DfM7
	 xnWLZQhyvw2PA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v5 8/9] selftests/ftrace: Add BTF fields access testcases
Date: Mon,  7 Aug 2023 11:55:48 +0900
Message-Id: <169137694835.271367.10787741563925762942.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169137686814.271367.11218568219311636206.stgit@devnote2>
References: <169137686814.271367.11218568219311636206.stgit@devnote2>
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

Add test cases for accessing the data structure fields using BTF info.
This includes the field access from parameters and retval, and accessing
string information.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
Changes in v2:
 - Use '$retval' instead of 'retval'.
 - Add a test that use both '$retval' and '$arg1' for fprobe.
Changes in v3:
 - Change a test case with a numeric value.
 - Add a test case with mixed '.' and '->' operators.
Changes in v5:
 - Check fields access availability.
---
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   20 ++++++++++++++++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    8 ++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
index f34b14ef9781..b9c21a81d248 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
@@ -5,6 +5,7 @@
 
 KPROBES=
 FPROBES=
+FIELDS=
 
 if grep -qF "p[:[<group>/][<event>]] <place> [<args>]" README ; then
   KPROBES=yes
@@ -12,6 +13,9 @@ fi
 if grep -qF "f[:[<group>/][<event>]] <func-name>[%return] [<args>]" README ; then
   FPROBES=yes
 fi
+if grep -qF "<argname>[->field[->field|.field...]]" README ; then
+  FIELDS=yes
+fi
 
 if [ -z "$KPROBES" -a -z "$FPROBES" ] ; then
   exit_unsupported
@@ -21,6 +25,9 @@ echo 0 > events/enable
 echo > dynamic_events
 
 TP=kfree
+TP2=kmem_cache_alloc
+TP3=getname_flags
+TP4=sched_wakeup
 
 if [ "$FPROBES" ] ; then
 echo "f:fpevent $TP object" >> dynamic_events
@@ -33,6 +40,7 @@ echo > dynamic_events
 
 echo "f:fpevent $TP "'$arg1' >> dynamic_events
 grep -q "fpevent.*object=object" dynamic_events
+
 echo > dynamic_events
 
 echo "f:fpevent $TP "'$arg*' >> dynamic_events
@@ -45,6 +53,18 @@ fi
 
 echo > dynamic_events
 
+if [ "$FIELDS" ] ; then
+echo "t:tpevent ${TP2} obj_size=s->object_size" >> dynamic_events
+echo "f:fpevent ${TP3}%return path=\$retval->name:string" >> dynamic_events
+echo "t:tpevent2 ${TP4} p->se.group_node.next->prev" >> dynamic_events
+
+grep -q "tpevent .*obj_size=s->object_size" dynamic_events
+grep -q "fpevent.*path=\$retval->name:string" dynamic_events
+grep -q 'tpevent2 .*p->se.group_node.next->prev' dynamic_events
+
+echo > dynamic_events
+fi
+
 if [ "$KPROBES" ] ; then
 echo "p:kpevent $TP object" >> dynamic_events
 grep -q "kpevent.*object=object" dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 72563b2e0812..20e42c030095 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -103,6 +103,14 @@ check_error 'f vfs_read%return ^$arg*'		# NOFENTRY_ARGS
 check_error 'f vfs_read ^hoge'			# NO_BTFARG
 check_error 'f kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
 check_error 'f kfree%return ^$retval'		# NO_RETVAL
+
+if grep -qF "<argname>[->field[->field|.field...]]" README ; then
+check_error 'f vfs_read%return $retval->^foo'	# NO_PTR_STRCT
+check_error 'f vfs_read file->^foo'		# NO_BTF_FIELD
+check_error 'f vfs_read file^-.foo'		# BAD_HYPHEN
+check_error 'f vfs_read ^file:string'		# BAD_TYPE4STR
+fi
+
 else
 check_error 'f vfs_read ^$arg*'			# NOSUP_BTFARG
 check_error 't kfree ^$arg*'			# NOSUP_BTFARG


