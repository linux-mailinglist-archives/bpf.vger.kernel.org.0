Return-Path: <bpf+bounces-43219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB7A9B14D7
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 06:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912822873ED
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 04:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED491632ED;
	Sat, 26 Oct 2024 04:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHjT2uwf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F35170A3E;
	Sat, 26 Oct 2024 04:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729917532; cv=none; b=trC6aBBgmAoh2tbeY/DgEqnhJhYflvBX5yDT6Qkn/cbjeX6595yz87ERmfK8+ktzyFKJdhN0gGTevxvp+EKJePSQtByQHVVSgP31JhptuP8oFrM3opUQmlsWl0ZYJoYiqfZA+myyBmrCPEctscoOCjY+TY2YKOZPO6pNycweHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729917532; c=relaxed/simple;
	bh=8t7YVZmoVUR7dCk/2nFP4SmQbrkuMwJVZH30PnGw0sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7FavYXCUCBHEKSj0D+sVP5NkK+l064Jlg+beuv31kDwDCsaTQKgOvrMYXcR2jM/UjGu0m/5EwGKgcXzlKWHGLK40CuRCxBI7sbf6Jjz2qdgIKKdhStKFKKCCx89903qqda9BNjlu/nCbrd9l5wgwcRuw+f+5Qc8k2mFBvfgA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHjT2uwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26969C4CEC6;
	Sat, 26 Oct 2024 04:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729917531;
	bh=8t7YVZmoVUR7dCk/2nFP4SmQbrkuMwJVZH30PnGw0sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHjT2uwfavW09+/4TfjW9DaXoThxOjmY3Ep2B186RVeNbRV+mykv3PGcslez6Z7vf
	 CLJvxQxb6gGXg1hk5vQNYvKxkNkmvXWh266/tblLXcABQnpxPRXuebnt6tOmSZZlxa
	 pzBby5xIN1Mv39D0ep6JqY4ct460ZH2h0jldIxrd6gGO07VeXR4oAgE6B63nK+f3fX
	 d/29JXwKVjmVYRjtM3RMm13yqD5z7NT/lJ7zjqw0kIXWas0IR5qsYINiCzRBqw7WwI
	 8Mh7w1XQsIHL/ABsksnO7lUey216qgrEWkQAVVtx4R7MZWimve416d9oggcUE3UNWg
	 ew3MwE1trSRYw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arch@vger.kernel.org
Subject: [PATCH v18 16/17] Documentation: probes: Update fprobe on function-graph tracer
Date: Sat, 26 Oct 2024 13:38:46 +0900
Message-ID: <172991752671.443985.17111177875574390269.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <172991731968.443985.4558065903004844780.stgit@devnote2>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
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

Update fprobe documentation for the new fprobe on function-graph
tracer. This includes some bahvior changes and pt_regs to
ftrace_regs interface change.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Update @fregs parameter explanation.
---
 Documentation/trace/fprobe.rst |   42 ++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 196f52386aaa..f58bdc64504f 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -9,9 +9,10 @@ Fprobe - Function entry/exit probe
 Introduction
 ============
 
-Fprobe is a function entry/exit probe mechanism based on ftrace.
-Instead of using ftrace full feature, if you only want to attach callbacks
-on function entry and exit, similar to the kprobes and kretprobes, you can
+Fprobe is a function entry/exit probe mechanism based on the function-graph
+tracer.
+Instead of tracing all functions, if you want to attach callbacks on specific
+function entry and exit, similar to the kprobes and kretprobes, you can
 use fprobe. Compared with kprobes and kretprobes, fprobe gives faster
 instrumentation for multiple functions with single handler. This document
 describes how to use fprobe.
@@ -91,12 +92,14 @@ The prototype of the entry/exit callback function are as follows:
 
 .. code-block:: c
 
- int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
+ int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct ftrace_regs *fregs, void *entry_data);
 
- void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
+ void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct ftrace_regs *fregs, void *entry_data);
 
-Note that the @entry_ip is saved at function entry and passed to exit handler.
-If the entry callback function returns !0, the corresponding exit callback will be cancelled.
+Note that the @entry_ip is saved at function entry and passed to exit
+handler.
+If the entry callback function returns !0, the corresponding exit callback
+will be cancelled.
 
 @fp
         This is the address of `fprobe` data structure related to this handler.
@@ -112,12 +115,10 @@ If the entry callback function returns !0, the corresponding exit callback will
         This is the return address that the traced function will return to,
         somewhere in the caller. This can be used at both entry and exit.
 
-@regs
-        This is the `pt_regs` data structure at the entry and exit. Note that
-        the instruction pointer of @regs may be different from the @entry_ip
-        in the entry_handler. If you need traced instruction pointer, you need
-        to use @entry_ip. On the other hand, in the exit_handler, the instruction
-        pointer of @regs is set to the current return address.
+@fregs
+        This is the `ftrace_regs` data structure at the entry and exit. This
+        includes the function parameters, or the return values. So user can
+        access thos values via appropriate `ftrace_regs_*` APIs.
 
 @entry_data
         This is a local storage to share the data between entry and exit handlers.
@@ -125,6 +126,17 @@ If the entry callback function returns !0, the corresponding exit callback will
         and `entry_data_size` field when registering the fprobe, the storage is
         allocated and passed to both `entry_handler` and `exit_handler`.
 
+Entry data size and exit handlers on the same function
+======================================================
+
+Since the entry data is passed via per-task stack and it is has limited size,
+the entry data size per probe is limited to `15 * sizeof(long)`. You also need
+to take care that the different fprobes are probing on the same function, this
+limit becomes smaller. The entry data size is aligned to `sizeof(long)` and
+each fprobe which has exit handler uses a `sizeof(long)` space on the stack,
+you should keep the number of fprobes on the same function as small as
+possible.
+
 Share the callbacks with kprobes
 ================================
 
@@ -165,8 +177,8 @@ This counter counts up when;
  - fprobe fails to take ftrace_recursion lock. This usually means that a function
    which is traced by other ftrace users is called from the entry_handler.
 
- - fprobe fails to setup the function exit because of the shortage of rethook
-   (the shadow stack for hooking the function return.)
+ - fprobe fails to setup the function exit because of failing to allocate the
+   data buffer from the per-task shadow stack.
 
 The `fprobe::nmissed` field counts up in both cases. Therefore, the former
 skips both of entry and exit callback and the latter skips the exit


