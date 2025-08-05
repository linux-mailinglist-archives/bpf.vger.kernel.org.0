Return-Path: <bpf+bounces-65074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F78B1B87E
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 18:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44186216F5
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D3292B54;
	Tue,  5 Aug 2025 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ot62REN9"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA68292B22
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411290; cv=none; b=aFClKq1PUHzlxscbnwVWbWmBhvZlIfQNAYoZMqb0p6zaAsYihEhigh0btR1E7PvcaZTgD6bA6kxLG9Q72XZVxNfX8Wf1Rz4NXwthDqd3Sw0507tclanUDElCBMXY3f96OJQ2El9ArApENtpsmi+79Yrph5iXBZEkhv5WJ/Xsa3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411290; c=relaxed/simple;
	bh=0THvNMFdfFhOxdvVstvFWtM+3I1dikuGop1BGeqltLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8ILFXLlLhXj/b3xMzQe8KdPOvjzNJHIHCgPQExx3DFBIrZ1BbPct3EkRCfdV9QdGKNk/ele6ON8j60Q9cB9fffFH8DsOUyjQ0FJLzEse439zBr3bbNHTcbecrmrIH+0nvtm62Dkl9POFTf7jV9t+9fwxutFrAlTWqdC+Nqkz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ot62REN9; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754411276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Z7pYFfWoLH1aXLvPg1vJ4VkW5EEtjCy8xcya4QuHqA=;
	b=ot62REN9lJLUGMUhPDjXjgTP+uLp3mM3Db4gCSkY2RqjkRUfLZV0puuIP/Bho6hsSGO8A6
	H/FE3iatZ/u503Z47D6V/MbWu89/sPL0z0j3LKxmn4KFzTw1R6m16es9txHzcRdMKKUzEk
	D1KujsxdypwmivC2GlxbwvX+ujsN490=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2] bpf: Remove migrate_disable in kprobe_multi_link_prog_run
Date: Wed,  6 Aug 2025 00:27:32 +0800
Message-ID: <20250805162732.1896687-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bpf program should run under migration disabled, kprobe_multi_link_prog_run
called all the way from graph tracer, which disables preemption in
function_graph_enter_regs, as Jiri and Yonghong suggested, there is no
need to use migrate_disable. As a result, some overhead maybe will be
reduced.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Change list:
 v1 -> v2:
  - s/called the way/called all the way/.(Jiri)
 v1: https://lore.kernel.org/bpf/f7acfd22-bcf3-4dff-9a87-7c1e6f84ce9c@linux.dev

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ae52978cae..5701791e3cb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2734,14 +2734,19 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 		goto out;
 	}
 
-	migrate_disable();
+	/*
+	 * bpf program should run under migration disabled, kprobe_multi_link_prog_run
+	 * called all the way from graph tracer, which disables preemption in
+	 * function_graph_enter_regs, so there is no need to use migrate_disable.
+	 * Accessing the above percpu data bpf_prog_active is also safe for the same
+	 * reason.
+	 */
 	rcu_read_lock();
 	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock();
-	migrate_enable();
 
  out:
 	__this_cpu_dec(bpf_prog_active);
-- 
2.48.1


