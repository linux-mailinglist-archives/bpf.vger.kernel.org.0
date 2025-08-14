Return-Path: <bpf+bounces-65638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D506B26533
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 14:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF2F1BC1254
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742B92FE04F;
	Thu, 14 Aug 2025 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ilCN0iHd"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795C2F90C7;
	Thu, 14 Aug 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173751; cv=none; b=DPUauoW6K40n2X7nXOvxPYwb+NeJIBNGydo8oi88aIYud4MgtkT8Hy4CeWCan27s4EveRaOmk5kgGH0f1oxoJDJnj136UMh1sm5UJHpbtOwQrs8DD4culWptfpLInKRBCi4nHr91G3ZNbL6rD3MQgmaYsZl+u/Kwqt/v1XRTwus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173751; c=relaxed/simple;
	bh=ynSr0E47HmXYcUmddedDfIO1NaYKsuWB4E2xbZAmQgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dk2OL7RLt1szQUDq8Z7k13RIzS4TbpzfCeTpfPh17WAimfqJjz5wbRA2TICnVTmYdNSdCnhMDeiGDtE8QRfU88P5bcvn1PchAJuZaDxLRTFqdA7T9FGsGMIfw0zE383BseLto0zdivPlVSguwttILZQnjJQ+KhGYYOEX1JqGaek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ilCN0iHd; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755173745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0ZjbPBfh7ujlNLzE0h5ffJa8LoQU/WhI2aIAZlbPDio=;
	b=ilCN0iHdM5/+X1oXmtFfbHqTsQxh4P2A1hnbK4M+0T3Jqdwoqs9CIsPYsn5pRDSrNF+UVR
	09bqkF36bhYOUxNLMNZboon6nwyTCxPlzlbcpHugtr+bruU0r64TbjlO5f8bDcY+EwMQQF
	VdaYL6tk72VrrSDIHEQ1CQnAcsd8wz0=
From: Tao Chen <chen.dylane@linux.dev>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH v3 bpf-next] bpf: Remove migrate_disable in kprobe_multi_link_prog_run
Date: Thu, 14 Aug 2025 20:14:29 +0800
Message-ID: <20250814121430.2347454-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Graph tracer framework ensures we won't migrate, kprobe_multi_link_prog_run
called all the way from graph tracer, which disables preemption in
function_graph_enter_regs, as Jiri and Yonghong suggested, there is no
need to use migrate_disable. As a result, some overhead may will be reduced.
And add cant_sleep check for __this_cpu_inc_return.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Change list:
 v1 -> v2:
  - s/called the way/called all the way/.(Jiri)
 v1: https://lore.kernel.org/bpf/f7acfd22-bcf3-4dff-9a87-7c1e6f84ce9c@linux.dev

 v2 -> v3:
  - add cant_sleep for __this_cpu_inc_return.(Andrii)
  - shorten comments.(Andrii)
 v2: https://lore.kernel.org/bpf/20250805162732.1896687-1-chen.dylane@linux.dev

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ae52978cae..606007c387c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2728,20 +2728,25 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	struct pt_regs *regs;
 	int err;
 
+	/*
+	 * graph tracer framework ensures we won't migrate, so there is no need
+	 * to use migrate_disable for bpf_prog_run again. The check here just for
+	 * __this_cpu_inc_return.
+	 */
+	cant_sleep();
+
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
 		bpf_prog_inc_misses_counter(link->link.prog);
 		err = 1;
 		goto out;
 	}
 
-	migrate_disable();
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


