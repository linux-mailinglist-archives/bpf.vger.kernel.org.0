Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA2C6E9292
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 13:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjDTL2S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 07:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjDTL16 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 07:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6708983E0;
        Thu, 20 Apr 2023 04:27:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCDC664852;
        Thu, 20 Apr 2023 11:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D55C4339B;
        Thu, 20 Apr 2023 11:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681990022;
        bh=JMzuvPGaUtd3Ue61+R7r8JPv3Iwr1kA9f/gFM8QNZ7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IySFugKIUT2dEWjVXdKzZwZgpZCG4MYXlHqWVQAdHl9Cbb/s3CqMmq2QYhVCgJUXX
         VeHdv6jUpOwreOtK9HmssmqGtAEVU0CRB6yz4mYW0KlqpjrgwKkVsOt/geHTIpGnWX
         821KZV2sm+3JI/8Wk3MrKHcmFhEEenMHUfHRCBMX2SojdnHltiY4Kc9IOJYtX5flRO
         1qjzQsE/LJHRZ86r+85i+WtswxNOUX2p+9Djvjp0S1HUG+wMZ/plQvPCwO/rEWvsE8
         Zk2sPfLRcI8afYT/ZdQHkMbG66a5YeJhuuV61D/PFxpLl/P9WUe1IQi7QCGRYBP+5F
         2S3WDCTfZPJoA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH v5 9/9] selftests/ftrace: Add BTF arguments test cases
Date:   Thu, 20 Apr 2023 20:26:57 +0900
Message-ID:  <168199001790.1795549.440521983895126009.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To:  <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
References:  <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add test cases to check the BTF arguments correctly supported.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   54 ++++++++++++++++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   10 ++++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   10 ++++
 3 files changed, 74 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
new file mode 100644
index 000000000000..15515f0a8c9a
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
+echo "f:fpevent $TP "'$$args' >> dynamic_events
+echo "t:tpevent $TP "'$$args' >> dynamic_events
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
+echo "p:kpevent $TP "'$$args' >> dynamic_events
+grep -q "kpevent.*object=object" dynamic_events
+fi
+
+clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 549daa162d84..fb92566916a9 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -85,4 +85,14 @@ fi
 # %return suffix errors
 check_error 'f vfs_read^%hoge'		# BAD_ADDR_SUFFIX
 
+# BTF arguments errors
+if grep -q "<argname>" README; then
+check_error 'f vfs_read $$args ^$$args'		# DOUBLE_ARGS
+check_error 'f vfs_read%return ^$$args'		# NOFENTRY_ARGS
+check_error 'f vfs_read ^hoge'			# NO_BTFARG
+else
+check_error 'f vfs_read $$args'			# NOSUP_BTFARG
+check_error 't kfree $$args'			# NOSUP_BTFARG
+fi
+
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 97c08867490a..f2d1edbb650a 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -103,4 +103,14 @@ check_error 'p vfs_read^%hoge'		# BAD_ADDR_SUFFIX
 check_error 'p ^vfs_read+10%return'	# BAD_RETPROBE
 fi
 
+# BTF arguments errors
+if grep -q "<argname>" README; then
+check_error 'p vfs_read $$args ^$$args'		# DOUBLE_ARGS
+check_error 'r vfs_read ^$$args'		# NOFENTRY_ARGS
+check_error 'p vfs_read+8 ^$$args'		# NOFENTRY_ARGS
+check_error 'p vfs_read ^hoge'			# NO_BTFARG
+else
+check_error 'p vfs_read $$args'			# NOSUP_BTFARG
+fi
+
 exit 0

