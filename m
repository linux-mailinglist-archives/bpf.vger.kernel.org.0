Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5412D18C3A3
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 00:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCSX1n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Mar 2020 19:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbgCSX1f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 19:27:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F08C20775;
        Thu, 19 Mar 2020 23:27:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jF4ZZ-000hB5-Db; Thu, 19 Mar 2020 19:27:33 -0400
Message-Id: <20200319232733.286726349@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Mar 2020 19:22:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: [PATCH 12/12 v2] tracing: Have the document reflect that the trace file keeps tracing
 enabled
References: <20200319232219.446480829@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Now that reading the trace file does not temporarly stop tracing while it is
open, update the document to reflect this fact.

Link: http://lkml.kernel.org/r/20200317213417.209675068@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 99a0890e20ec..86e76f2a40dc 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -125,10 +125,13 @@ of ftrace. Here is a list of some of the key files:
   trace:
 
 	This file holds the output of the trace in a human
-	readable format (described below). Note, tracing is temporarily
-	disabled when the file is open for reading. Once all readers
-	are closed, tracing is re-enabled. Opening this file for
+	readable format (described below). Opening this file for
 	writing with the O_TRUNC flag clears the ring buffer content.
+        Note, this file is not a consumer. If tracing is off
+        (no tracer running, or tracing_on is zero), it will produce
+        the same output each time it is read. When tracing is on,
+        it may produce inconsistent results as it tries to read
+        the entire buffer without consuming it.
 
   trace_pipe:
 
@@ -142,9 +145,7 @@ of ftrace. Here is a list of some of the key files:
 	will not be read again with a sequential read. The
 	"trace" file is static, and if the tracer is not
 	adding more data, it will display the same
-	information every time it is read. Unlike the
-	"trace" file, opening this file for reading will not
-	temporarily disable tracing.
+	information every time it is read.
 
   trace_options:
 
-- 
2.25.1


