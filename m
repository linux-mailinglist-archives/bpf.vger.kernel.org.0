Return-Path: <bpf+bounces-37088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB8950E00
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 22:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0A4284D3F
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03291A4F3F;
	Tue, 13 Aug 2024 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRKSMv8a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B504436A;
	Tue, 13 Aug 2024 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723581253; cv=none; b=QRUR4hT9rMGeuR3rvYJwT1bxJQBj0KrgwLsioEQGdGa5UvDxfNoS5vnWlnaP6WQ94IjX8XiIkKvflopqW9UZNBwxc058hkw4wDk0N+eu/5OUd5XAMkKxBDWxLkdKJoS+bwM3pXYJ9k1ke5rOW8qj7jQSBpOYZaKOdJFZnDuUHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723581253; c=relaxed/simple;
	bh=aW7W23fUjUQbZbzoo2O9zrLSi/tpsyqurgJDlIT3Luk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MkFL1nTxfDeVzC+f8TKRmCYVp5HlDRl89w2OVkqPZamIWO1gSjr5Sepyfg3wdzxqAt2u0FNlWESZikgXyNIKSZWQoS6MwLsVmvRCxs71FRhooncUpCQXepleSB3JDrGEKCikDAVI+5hhoUmU414x8UhzOboQb5T4rh1nwHERuGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRKSMv8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAC9C32782;
	Tue, 13 Aug 2024 20:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723581252;
	bh=aW7W23fUjUQbZbzoo2O9zrLSi/tpsyqurgJDlIT3Luk=;
	h=From:To:Cc:Subject:Date:From;
	b=NRKSMv8agI1IaeiAz6EvRYCpGs9PLQF4zp9gOXigS6euL88D9DisYhKc6vvg2otUr
	 5TWRiEj0i52R0oVBxBaokQvW1I3GCcVwvmGCtpou4IqFNt/CQoOGB4Cfqkfw8SGwGg
	 Jw+gEIWFpL6FvliwItwFVNeUgi99+hBJi6dA3mi4B3kMK+W1IcCL/n3BwCAYGfuh6I
	 GUv8XY5vymw15wV3Oa/virVLXZlKNSj1YmdgMT7UVMVSQfJdfJZ93/wc3ZWsExVMLw
	 TyXk48dxO51sB4uAwB50xcGOHeihPCy0O/0zjUFnnMTvxQ0ffXzPYZRI7EPji9p2q1
	 LYX801ZRStHSw==
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
Subject: [PATCH v3] uprobes: turn trace_uprobe's nhit counter to be per-CPU one
Date: Tue, 13 Aug 2024 13:34:09 -0700
Message-ID: <20240813203409.3985398-1-andrii@kernel.org>
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

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/trace_uprobe.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c98e3b3386ba..c3df411a2684 100644
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
 	char				*filename;
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
+		nhits += per_cpu(*tu->nhits, cpu);
+	}
+
 	seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
-			trace_probe_name(&tu->tp), tu->nhit);
+		   trace_probe_name(&tu->tp), nhits);
 	return 0;
 }
 
@@ -1512,7 +1529,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	int ret = 0;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
-	tu->nhit++;
+
+	this_cpu_inc(*tu->nhits);
 
 	udd.tu = tu;
 	udd.bp_addr = instruction_pointer(regs);
-- 
2.43.5


