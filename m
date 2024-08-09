Return-Path: <bpf+bounces-36793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C994D728
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 21:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2BE1F22D63
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 19:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176315FA73;
	Fri,  9 Aug 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAzhLSna"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B22B9A9;
	Fri,  9 Aug 2024 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231442; cv=none; b=q8sSuHY7AYRsa3U31Pxtpxz/4r3P8Wu+iCUqPP2AdPVo7dghurK5b74gDTzUaF+LJQN2AaGb6w1aRPe8YFAfCu91N6KZlXM9Bwu+2PyO5VWb2bzadn5cnKB8qDTwBtZPrAMGaLvGU53+Tgs94/y9V6ZNETYmW+jTKoX6c/XHKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231442; c=relaxed/simple;
	bh=zmnG5xSUMyo+9plaKeJ+uvQbkZxCdb3QwwtYbn++p1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNcJtlxBT1A9cFt9VA+c9js5zVLh0U1dVh5bX2bHfrjPnIl0bMpMGLJau215Ci7JNzJsMt/ao8jSHrr3I1qEKNqaTgE5k/d1wm0xEHglXDg82ROFe/5uT4lyfiPzkIfR5u8hpujNUC/kkvIWBP+8jof/qvXcwrt2bTVf4Qan4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAzhLSna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A98C4AF0D;
	Fri,  9 Aug 2024 19:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723231441;
	bh=zmnG5xSUMyo+9plaKeJ+uvQbkZxCdb3QwwtYbn++p1Y=;
	h=From:To:Cc:Subject:Date:From;
	b=rAzhLSnad0hcaVB+vG8FglY5NDsl00xiqannTJyJ7R1OMaf4orx6nYpKJh3i71R/C
	 cfKPqVlLNRVn7177R+UCaiRxkPaJzknGOP6Z4qZd/pOPFafE0+oCed7+qAVFKz6Oa7
	 ZStMgAwLoPNGYNPKrucxFDObkQJJXrD5Dqz4lvbb9X7BzV5pPN0Nd9brC69aSPPVun
	 zZ5pu+O+I0UoPysQL4K5+2FLhlGbB1MgTxXjcB0bJxWs2kIOOLQCTUY+SlL2EFBwh6
	 77lZVx6iJBni56wlWiJ4jsYwMqMLq3Wwf1++WDARkzXOh1b0uZkfclJ23+EvX1SKxs
	 hBhBXuIrA89ew==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: peterz@infradead.org,
	oleg@redhat.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2] uprobes: make trace_uprobe->nhit counter a per-CPU one
Date: Fri,  9 Aug 2024 12:23:57 -0700
Message-ID: <20240809192357.4061484-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace_uprobe->nhit counter is not incremented atomically, so its value
is questionable in when uprobe is hit on multiple CPUs simultaneously.

Also, doing this shared counter increment across many CPUs causes heavy
cache line bouncing, limiting uprobe/uretprobe performance scaling with
number of CPUs.

Solve both problems by making this a per-CPU counter.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/trace_uprobe.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 52e76a73fa7c..002f801a7ab4 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <linux/rculist.h>
 #include <linux/filter.h>
+#include <linux/percpu.h>
 
 #include "trace_dynevent.h"
 #include "trace_probe.h"
@@ -62,7 +63,7 @@ struct trace_uprobe {
 	struct uprobe			*uprobe;
 	unsigned long			offset;
 	unsigned long			ref_ctr_offset;
-	unsigned long			nhit;
+	unsigned long __percpu		*nhits;
 	struct trace_probe		tp;
 };
 
@@ -337,6 +338,12 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	if (!tu)
 		return ERR_PTR(-ENOMEM);
 
+	tu->nhits = alloc_percpu(unsigned long);
+	if (!tu->nhits) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
 	ret = trace_probe_init(&tu->tp, event, group, true, nargs);
 	if (ret < 0)
 		goto error;
@@ -349,6 +356,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	return tu;
 
 error:
+	free_percpu(tu->nhits);
 	kfree(tu);
 
 	return ERR_PTR(ret);
@@ -362,6 +370,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
 	path_put(&tu->path);
 	trace_probe_cleanup(&tu->tp);
 	kfree(tu->filename);
+	free_percpu(tu->nhits);
 	kfree(tu);
 }
 
@@ -815,13 +824,21 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
 {
 	struct dyn_event *ev = v;
 	struct trace_uprobe *tu;
+	unsigned long nhits;
+	int cpu;
 
 	if (!is_trace_uprobe(ev))
 		return 0;
 
 	tu = to_trace_uprobe(ev);
+
+	nhits = 0;
+	for_each_possible_cpu(cpu) {
+		nhits += READ_ONCE(*per_cpu_ptr(tu->nhits, cpu));
+	}
+
 	seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
-			trace_probe_name(&tu->tp), tu->nhit);
+		   trace_probe_name(&tu->tp), nhits);
 	return 0;
 }
 
@@ -1507,7 +1524,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	int ret = 0;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
-	tu->nhit++;
+
+	this_cpu_inc(*tu->nhits);
 
 	udd.tu = tu;
 	udd.bp_addr = instruction_pointer(regs);
-- 
2.43.5


