Return-Path: <bpf+bounces-69184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C2AB8F592
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 09:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F79917E384
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 07:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1B62F745F;
	Mon, 22 Sep 2025 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kJAqmp7N"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806E2F83DB
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527676; cv=none; b=Q16Yjp8or+DUyawkcOIfiVGR3ugbcj1E4ampQ3LENU2KTbpzh//DnM5po0riDF7vmtDkamM/xzhiv5uJSrWPL0NBTCess8hQIQGOpdoTbhbB25JrFSrqUsiU8ao9WP5JFgbc1sQTlDXYNGtYtzC97UHLl8VouUdLjb8phx10pQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527676; c=relaxed/simple;
	bh=R28uxE32gqNwzcXDbG30ZDmSivgFql4fRGlFePdTlx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVff7ZQQYrxakTd8Gjz3VJop0aakA41ifp4H9lEwVDHabRVLsXa4ppONRHTlw7CONxbE7ppsDfxTDqUHnyGo1ufkItBlPbMABltgdfN9dvdqLJhQriqq2VPlLunuwmNmvG6oFQdNmiLbGm2Ge7QBAa7sIs8+uaVvh9i1GACYlO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kJAqmp7N; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758527662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/F+if3ZmRE6mryxGtP8tu86KfXMMdeV8BX6DdblMOk4=;
	b=kJAqmp7NaxLfxx26YA6GVjs4ktc1ebWFEKRMDv4BWqK1OxIn6erNAm8cmR23qOYFb0kAix
	QyuuQqZ/KJEdkj9zV0u7CjV+OibDS+I5EO3cNCtBfEgrM3eKjOtEwe64XQDSJEPsdQxba+
	v0kHkr4jM1Wh3labWYO68T5uRjLuBag=
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
	haoluo@google.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next] bpf: Add preempt_disable to protect get_perf_callchain
Date: Mon, 22 Sep 2025 15:53:33 +0800
Message-ID: <20250922075333.1452803-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As Alexei suggested, the return value from get_perf_callchain() may be
reused if another task preempts and requests the stack after BPF program
switched to migrate disable.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/stackmap.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 2e182a3ac4c..07892320906 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -314,8 +314,10 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
+	preempt_disable();
 	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
 				   false, false);
+	preempt_enable();
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
@@ -443,9 +445,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (sysctl_perf_event_max_stack < max_depth)
 		max_depth = sysctl_perf_event_max_stack;
 
-	if (may_fault)
-		rcu_read_lock(); /* need RCU for perf's callchain below */
-
+	preempt_disable();
 	if (trace_in)
 		trace = trace_in;
 	else if (kernel && task)
@@ -455,8 +455,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 					   crosstask, false);
 
 	if (unlikely(!trace) || trace->nr < skip) {
-		if (may_fault)
-			rcu_read_unlock();
+		preempt_enable();
 		goto err_fault;
 	}
 
@@ -474,10 +473,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	} else {
 		memcpy(buf, ips, copy_len);
 	}
-
-	/* trace/ips should not be dereferenced after this point */
-	if (may_fault)
-		rcu_read_unlock();
+	preempt_enable();
 
 	if (user_build_id)
 		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
-- 
2.48.1


