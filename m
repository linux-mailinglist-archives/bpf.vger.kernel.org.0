Return-Path: <bpf+bounces-42464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E539A47D2
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE50C1F249EB
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A520898D;
	Fri, 18 Oct 2024 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKH8oD7e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711120513E;
	Fri, 18 Oct 2024 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282992; cv=none; b=jCGvEyTq5TCx8ghhZFUCX0CvP/9wvMTnqNRigrPR5U6EklTJCz+tyjB/EeH3NqzAoUmsPVIv421iE6jDDyxvTkcFIJuMfprgHd7WhLEllW/+6FG9cGBAVByXi3nnqq3MDWCFVSlT4iBfwqc42K7LTyAEn/IvqzjExNbu+4iLESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282992; c=relaxed/simple;
	bh=lyivNG7QkcWF//27U5OwYwaUvTLVf7GexR1n3yjWShI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaADgW1TJ0zvU4rOvmGrZk+JGaEgdJvsF6sGYkwuD+4pfSn/1LC7y1GrY7Nv2421drXc4A83noytlt5rxAAAdWVI6QVE+Td/9QQI3cRMvfgv/4Vy0/PjyropZTo4B8yYhob92k/cbgNovDnAy9FQUAn13TkxEGFEBrUFU5VhV4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKH8oD7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91238C4CEC3;
	Fri, 18 Oct 2024 20:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729282991;
	bh=lyivNG7QkcWF//27U5OwYwaUvTLVf7GexR1n3yjWShI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKH8oD7eH2raB7qgZmGvf9AG8Pb7la+dBmXIfHzdvx9WWWglEsogPPE16o8ll2NFE
	 Y0LtwUjl+DBpXN68xNgn+I9Mr0pbuHz1yBs7DNfS1eqCKbfAZ76bnjSnWKBpxU136e
	 IOD2QlOvn+5YL1+gUKnw+IfA8Eqq5wC/fC4e/ajmgS9P5HUnFaYfGpv8XtG2+CE2Qp
	 GaqaR6be1Gg/XA3gL7RXRKl841FV5ps17C9/Lk3W1lj9Emh4HLNecnv9l7h99p706s
	 4JFrXRfAoL3CCg9Q3IGeIdO/bY8wfS5YoW8Uy7HRrNIU76sYiWrbZYCyIs32wUc66/
	 RmVIYF8VPBqGw==
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
Subject: [PATCHv8 perf/core 1/2] uprobe: Add data pointer to consumer handlers
Date: Fri, 18 Oct 2024 22:22:51 +0200
Message-ID: <20241018202252.693462-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018202252.693462-1-jolsa@kernel.org>
References: <20241018202252.693462-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding data pointer to both entry and exit consumer handlers and all
its users. The functionality itself is coming in following change.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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
index 2a0059464383..6b44c386a5df 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2090,7 +2090,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 		int rc = 0;
 
 		if (uc->handler) {
-			rc = uc->handler(uc, regs);
+			rc = uc->handler(uc, regs, NULL);
 			WARN(rc & ~UPROBE_HANDLER_MASK,
 				"bad rc=0x%x from %ps()\n", rc, uc->handler);
 		}
@@ -2128,7 +2128,7 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 	rcu_read_lock_trace();
 	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		if (uc->ret_handler)
-			uc->ret_handler(uc, ri->func, regs);
+			uc->ret_handler(uc, ri->func, regs, NULL);
 	}
 	rcu_read_unlock_trace();
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
index c40531d2cbad..5895eabe3581 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -89,9 +89,11 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
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
@@ -1517,7 +1519,8 @@ trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
 	}
 }
 
-static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
+static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
+			     __u64 *data)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
@@ -1548,7 +1551,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
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
2.46.2


