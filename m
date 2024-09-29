Return-Path: <bpf+bounces-40516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7160E98976B
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 22:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 001F2B21D2E
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD43B13C3EE;
	Sun, 29 Sep 2024 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL8LRKxR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83F18EB0;
	Sun, 29 Sep 2024 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643457; cv=none; b=ERMIdCgyH4039N0bvKYtzHegMnTkDrGSTGa0dGZ4jOp7IhONWP2CU9R3yflnAOBjs8cITWjBB6Gg3RQBxqoGvTxapZLuApibkyzu0l5tyOmtUFOtyiZAyNDLBcbzAVhJYO/FvYn1oj/4mSQ/sxpQWA7mU6fPbPzR4iuagiGJKqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643457; c=relaxed/simple;
	bh=UdjtvmBJEuA72j3JoZh2o4f116ut1IgN0CDDTK9Tvss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpIYL8S9fqJfQMvqLckgK7bBvFT3+qM9QclWwKX7+HfetF3I+Kzjbj2qqJzOdXSQBy+tl6oSJWQHOoT+4sN4tW71Ii893vudqi5aFdMXNNdDPWzuVCLXFRvJQrVoMIXZdkJp3M3grzRRlqYene0LR8uAo5EuLK27GODyZ+aRHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL8LRKxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558CEC4CEC5;
	Sun, 29 Sep 2024 20:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727643456;
	bh=UdjtvmBJEuA72j3JoZh2o4f116ut1IgN0CDDTK9Tvss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PL8LRKxRfP5BbhdJ0WQWAIHdICrxRZ9p41+RVEhdPZvju8T3X6o8uiqRJ/8SEBX8P
	 l2LJ8oB3pQypc6nFU86tCohLaegvgTTmMEOs9Jw+xdCBoyWLB6EA6PFQYyOz4LPDd6
	 sMVRZ+ifjEnj+v0DV9XMiK7Yr1RrKKBOZywGNzDLzJUJ5vdi+GzL3/31HBLTllsQml
	 /X+onDiZh2ib9dC5MtvorAIm+uTTXWwKL5OdXdsQXLwOy76s8Vsf/+JmX2sQDgWLa7
	 ZKBX4SEABdJ4SWJQ5k6d/8i6+39TxUe8V9HX5INd7A+wT6JN24eHYMLNzmzLITkSa3
	 S7To1heoyjhHA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv5 bpf-next 01/13] uprobe: Add data pointer to consumer handlers
Date: Sun, 29 Sep 2024 22:57:05 +0200
Message-ID: <20240929205717.3813648-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240929205717.3813648-1-jolsa@kernel.org>
References: <20240929205717.3813648-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding data pointer to both entry and exit consumer handlers and all
its users. The functionality itself is coming in following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h                              |  4 ++--
 kernel/events/uprobes.c                              |  4 ++--
 kernel/trace/bpf_trace.c                             |  6 ++++--
 kernel/trace/trace_uprobe.c                          | 12 ++++++++----
 .../testing/selftests/bpf/bpf_testmod/bpf_testmod.c  |  2 +-
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 2b294bf1881f..bb265a632b91 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -37,10 +37,10 @@ struct uprobe_consumer {
 	 * for the current process. If filter() is omitted or returns true,
 	 * UPROBE_HANDLER_REMOVE is effectively ignored.
 	 */
-	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
+	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data);
 	int (*ret_handler)(struct uprobe_consumer *self,
 				unsigned long func,
-				struct pt_regs *regs);
+				struct pt_regs *regs, __u64 *data);
 	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
 
 	struct list_head cons_node;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ec796e2f055..2ba93f8a31aa 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2139,7 +2139,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 		int rc = 0;
 
 		if (uc->handler) {
-			rc = uc->handler(uc, regs);
+			rc = uc->handler(uc, regs, NULL);
 			WARN(rc & ~UPROBE_HANDLER_MASK,
 				"bad rc=0x%x from %ps()\n", rc, uc->handler);
 		}
@@ -2179,7 +2179,7 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
 				 srcu_read_lock_held(&uprobes_srcu)) {
 		if (uc->ret_handler)
-			uc->ret_handler(uc, ri->func, regs);
+			uc->ret_handler(uc, ri->func, regs, NULL);
 	}
 	srcu_read_unlock(&uprobes_srcu, srcu_idx);
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a582cd25ca87..fdab7ecd8dfa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3244,7 +3244,8 @@ uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
 }
 
 static int
-uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
+uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
+			  __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
 
@@ -3253,7 +3254,8 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
 }
 
 static int
-uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs)
+uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs,
+			      __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f7443e996b1b..11103dde897b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -88,9 +88,11 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
 static int register_uprobe_event(struct trace_uprobe *tu);
 static int unregister_uprobe_event(struct trace_uprobe *tu);
 
-static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
+static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
+			     __u64 *data);
 static int uretprobe_dispatcher(struct uprobe_consumer *con,
-				unsigned long func, struct pt_regs *regs);
+				unsigned long func, struct pt_regs *regs,
+				__u64 *data);
 
 #ifdef CONFIG_STACK_GROWSUP
 static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
@@ -1500,7 +1502,8 @@ trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
 	}
 }
 
-static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
+static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
+			     __u64 *data)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
@@ -1530,7 +1533,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 }
 
 static int uretprobe_dispatcher(struct uprobe_consumer *con,
-				unsigned long func, struct pt_regs *regs)
+				unsigned long func, struct pt_regs *regs,
+				__u64 *data)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 8835761d9a12..12005e3dc3e4 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -461,7 +461,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
 
 static int
 uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
-		   struct pt_regs *regs)
+		   struct pt_regs *regs, __u64 *data)
 
 {
 	regs->ax  = 0x12345678deadbeef;
-- 
2.46.1


