Return-Path: <bpf+bounces-6416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C561768ECC
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE4C28149D
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 07:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838B563A5;
	Mon, 31 Jul 2023 07:31:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2356132
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 07:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B722C433C7;
	Mon, 31 Jul 2023 07:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690788687;
	bh=KGJEEq13A9go4Yhd3XiG1sdw1r30ps972RCgI6Rs1/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1G1qgfTsdvrtkIT3v662J7BXCoWxQlHFUC+VqEihQx14Afq1GzMqwKHyLylUK9Va
	 aTP0YEozlL+xyyAp939Gq+RAou0Bqv5Ggs7biyQBxzUMjnHIofUjXlz9AJI5n3ol9J
	 qUXxIZygZlW3xMn78IJei09bMJ/SzuUIyF81XRNHrclxT59OUuSo6FID0I5WRG//TR
	 /Sm1R432P4Gg/IUBkDyltRHrxLyfTT2oWty0HT6L2JbuvPSzi0cPTzFS7w/zkKp3GP
	 LPNx5dOcTj+D/MG6RDXTr9PNz7F1GUbxNr5usRv11lp2S9R+Cc+77SJXMX8UMOyHV9
	 GMHJ+XmVAaesg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 8/9] selftests/ftrace: Add BTF fields access testcases
Date: Mon, 31 Jul 2023 16:31:22 +0900
Message-Id: <169078868262.173706.15416052542086569996.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169078860386.173706.3091034523220945605.stgit@devnote2>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
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
---
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   14 ++++++++++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 ++++
 2 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
index f34b14ef9781..4bfd2f45db42 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
@@ -21,6 +21,9 @@ echo 0 > events/enable
 echo > dynamic_events
 
 TP=kfree
+TP2=kmem_cache_alloc
+TP3=getname_flags
+TP4=sched_wakeup
 
 if [ "$FPROBES" ] ; then
 echo "f:fpevent $TP object" >> dynamic_events
@@ -33,6 +36,7 @@ echo > dynamic_events
 
 echo "f:fpevent $TP "'$arg1' >> dynamic_events
 grep -q "fpevent.*object=object" dynamic_events
+
 echo > dynamic_events
 
 echo "f:fpevent $TP "'$arg*' >> dynamic_events
@@ -45,6 +49,16 @@ fi
 
 echo > dynamic_events
 
+echo "t:tpevent ${TP2} obj_size=s->object_size" >> dynamic_events
+echo "f:fpevent ${TP3}%return path=\$retval->name:string" >> dynamic_events
+echo "t:tpevent2 ${TP4} p->se.group_node.next->prev" >> dynamic_events
+
+grep -q "tpevent .*obj_size=s->object_size" dynamic_events
+grep -q "fpevent.*path=\$retval->name:string" dynamic_events
+grep -q 'tpevent2 .*p->se.group_node.next->prev' dynamic_events
+
+echo > dynamic_events
+
 if [ "$KPROBES" ] ; then
 echo "p:kpevent $TP object" >> dynamic_events
 grep -q "kpevent.*object=object" dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 72563b2e0812..49758f77c923 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -103,6 +103,10 @@ check_error 'f vfs_read%return ^$arg*'		# NOFENTRY_ARGS
 check_error 'f vfs_read ^hoge'			# NO_BTFARG
 check_error 'f kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
 check_error 'f kfree%return ^$retval'		# NO_RETVAL
+check_error 'f vfs_read%return $retval->^foo'	# NO_PTR_STRCT
+check_error 'f vfs_read file->^foo'		# NO_BTF_FIELD
+check_error 'f vfs_read file^-.foo'		# BAD_HYPHEN
+check_error 'f vfs_read ^file:string'		# BAD_TYPE4STR
 else
 check_error 'f vfs_read ^$arg*'			# NOSUP_BTFARG
 check_error 't kfree ^$arg*'			# NOSUP_BTFARG


