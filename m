Return-Path: <bpf+bounces-40024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FE897AD12
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932CA284F79
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDB315A862;
	Tue, 17 Sep 2024 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYrpNOHq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7679155C87;
	Tue, 17 Sep 2024 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563045; cv=none; b=nCtyfCHElRmn3CT4GHmypmVkkZhhdyPqHpHFANo1oeLL5QNIVK0zNJq7St6hSayFH+CIzeW8Sn0p8bAU7NH2J0qu3BJXVOWDa4kj4+mL1cpjDiyuN5yIXgqpA5Lir32AU1X+3G0hxejeDt+UxecfnwiBw0mcj4llrZ869aA+WKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563045; c=relaxed/simple;
	bh=Du2SNnKFgCVIlfZ2+m1F3OX3IIVtJLXzSWzXf6k0IkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXX2h1XyIKvWGI7UqvTx/n3gTD2lhwXRb0boK1DkttZtyGLx2b5mDLUsWVUjB7LFEr6iAhUBpZvFw5sVqFegyN1zGeazAqRNSZrzUePk3k6ff+n0kwZ2FIh98TxHsVzzoIHisXDvmrTQ5l5AIiKqqCkYiVP9LNtkgnZmdhpaPRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYrpNOHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79BEC4CEC5;
	Tue, 17 Sep 2024 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563044;
	bh=Du2SNnKFgCVIlfZ2+m1F3OX3IIVtJLXzSWzXf6k0IkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYrpNOHqND8Ftwo5xVQr6eHLlwUeSmGS0iTNwcnKCz/isrsIJRnzJqVHn+EAQIb11
	 9w9WwRuPbIMoBaJpjNNmA4HF3hLhjhXS0vsvpxTkgg9EpeNaIKpCEPSkNp1ZCFVVL6
	 wdb/puXzljRcRi7G5fNi+XUpUr51NJXxkieKJA1+XFCamYdO351MAYVMqtLWnMeAta
	 qiUOVQo5th2KaPpvkxMSQP+RoJt+GbNhtnTIBH+HN5KvpAP9TIFoTN8Q0NYOREqM57
	 QmwxQwXoLN0kDVsnEPN0WlF1yG0vhjgJ5706mNOmtwSwIf7F3lJA838mq3uspY9uU7
	 ofwNZPyQnZOHA==
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
Subject: [PATCHv4 01/14] uprobe: Add data pointer to consumer handlers
Date: Tue, 17 Sep 2024 10:50:11 +0200
Message-ID: <20240917085024.765883-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917085024.765883-1-jolsa@kernel.org>
References: <20240917085024.765883-1-jolsa@kernel.org>
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
 kernel/trace/bpf_trace.c                             |  6 ++++--
 kernel/trace/trace_uprobe.c                          | 12 ++++++++----
 .../testing/selftests/bpf/bpf_testmod/bpf_testmod.c  |  2 +-
 4 files changed, 15 insertions(+), 9 deletions(-)

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
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ac0a01cc8634..de241503c8fb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3332,7 +3332,8 @@ uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
 }
 
 static int
-uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
+uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
+			  __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
 
@@ -3341,7 +3342,8 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
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
index 1fc16657cf42..e91ff5b285f0 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -421,7 +421,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
 
 static int
 uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
-		   struct pt_regs *regs)
+		   struct pt_regs *regs, __u64 *data)
 
 {
 	regs->ax  = 0x12345678deadbeef;
-- 
2.46.0


