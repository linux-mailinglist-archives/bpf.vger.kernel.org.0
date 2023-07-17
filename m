Return-Path: <bpf+bounces-5109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EF87567D6
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD671C20A8C
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5DEA94F;
	Mon, 17 Jul 2023 15:24:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5413B253DC
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 15:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B870C433C7;
	Mon, 17 Jul 2023 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689607482;
	bh=ApAG9WsE51kt31Nr613fs76Un6BDs5WAbX0BxsdpAn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXPeI9Olpd2PQ2cSmU1m8gegxcK4xVk5lVci7yDw8I96t9olXP89EYoBZyaYneToh
	 76Ytj785hrK0Fc6BmJ9QWoFW4K1kDH4qVftLjgxKIEyfv98xxZbrHxCmPjFLY6i/r7
	 +4z8fO2yZJAwyiHRz/wuVWBDq3EGn/O0a3aoCzPoOvYyjPuTR5ZSfWj2fhbJ/F/4ux
	 gDZRWt0hxpyGAcAtgkcFG30czTMmtbibdjIQI7zFNi13neGJ1DSfl15vJMzzlaIqnb
	 xIUgJO7bxp18mG797lKvbjacfit1O9feYVfWPGeeC99spMmBTzExUyriXbeMaobdVe
	 FfTbZdcpoUcVw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 8/9] selftests/ftrace: Add BTF fields access testcases
Date: Tue, 18 Jul 2023 00:24:37 +0900
Message-Id: <168960747750.34107.6104527579648222887.stgit@devnote2>
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

Add test cases for accessing the data structure fields using BTF info.
This includes the field access from parameters and retval, and accessing
string information.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Use '$retval' instead of 'retval'.
 - Add a test that use both '$retval' and '$arg1' for fprobe.
---
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   11 +++++++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 ++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
index b89de1771655..93b94468967b 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
@@ -21,6 +21,8 @@ echo 0 > events/enable
 echo > dynamic_events
 
 TP=kfree
+TP2=kmem_cache_alloc
+TP3=getname_flags
 
 if [ "$FPROBES" ] ; then
 echo "f:fpevent $TP object" >> dynamic_events
@@ -33,6 +35,7 @@ echo > dynamic_events
 
 echo "f:fpevent $TP "'$arg1' >> dynamic_events
 grep -q "fpevent.*object=object" dynamic_events
+
 echo > dynamic_events
 
 echo "f:fpevent $TP "'$arg*' >> dynamic_events
@@ -45,6 +48,14 @@ fi
 
 echo > dynamic_events
 
+echo "t:tpevent $TP2 name=s->name:string" >> dynamic_events
+echo "f:fpevent ${TP3}%return path=\$retval->name:string" >> dynamic_events
+
+grep -q "tpevent.*name=s->name:string" dynamic_events
+grep -q "fpevent.*path=\$retval->name:string" dynamic_events
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


