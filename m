Return-Path: <bpf+bounces-13537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B37C7DA508
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 05:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C012EB21637
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 03:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BFE10FF;
	Sat, 28 Oct 2023 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLYxybp8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE07F5;
	Sat, 28 Oct 2023 03:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE39C433C7;
	Sat, 28 Oct 2023 03:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698464056;
	bh=GSCg8MotGa6UfxyDTlFmyiyhwNgWtF3ruxwlA0Hr0wQ=;
	h=From:To:Cc:Subject:Date:From;
	b=uLYxybp8qzfs3zZKcm40jtkuui2m6uv/ZU/cCNRwQnlpWRCDcr5YpdMycqRhhyGOO
	 frv14rnFL8o5KvYRD6kKK0qeknBW8hxTo08XGgzUM+3x9fRafKz5bX3GLuujjEE+/A
	 IuOZvbwtzk/98H237798PTm0kiYylLeThZS9wQ9isTUOO58yeuP6Z43oJVFVOQbOAY
	 z6AqXaQMSYg+cpEV3oGtRGU+HGV8bTYZNwBa1xuB5KZv+hkJ4nmmlsNjP/xsjWr281
	 6JjeSbI3+ImF0m28cOhqu9m3iiN1amU29qtB/7pGtAhdeHdozClxB+hP5JnBn/ajxv
	 l8RTfu4oGLapA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Francis Laniel <flaniel@linux.microsoft.com>,
	linux-kselftest@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] selftests/ftrace: Add test case for a symbol in a module without module name
Date: Sat, 28 Oct 2023 12:34:12 +0900
Message-Id: <169846405196.88147.17766692778800222203.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
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

Add a test case for probing on a symbol in a module without module name.
When probing on a symbol in a module, ftrace accepts both the syntax that
<MODNAME>:<SYMBOL> and <SYMBOL>. Current test case only checks the former
syntax. This adds a test for the latter one.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_module.tc          |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
index 7e74ee11edf9..4b32e1b9a8d3 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
@@ -13,6 +13,12 @@ fi
 MOD=trace_printk
 FUNC=trace_printk_irq_work
 
+:;: "Add an event on a module function without module name" ;:
+
+echo "p:event0 $FUNC" > kprobe_events
+test -d events/kprobes/event0 || exit_failure
+echo "-:kprobes/event0" >> kprobe_events
+
 :;: "Add an event on a module function without specifying event name" ;:
 
 echo "p $MOD:$FUNC" > kprobe_events


