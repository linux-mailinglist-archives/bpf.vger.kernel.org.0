Return-Path: <bpf+bounces-64988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B1B1A118
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 14:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3393189F6C4
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 12:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B862571DE;
	Mon,  4 Aug 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bDYto4Y8"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D89254846
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309819; cv=none; b=JsauO70kb08Ad2adsDBPdXPG8MtXQv4YpuPCsTNTnLpHnq7dGjGK2jNy6B+t5TrNo6lQFcvYjtUwgenfj+CkGBLQlPIVTXKdWgjmh9TtVwFbKsfLQfJ+RcbThGNE4DzNSiDTpHGQ1T8dK/sYTXAZK2fE+uekVHyOsoKSP90dD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309819; c=relaxed/simple;
	bh=+QbjGDEaHCUYMo3kIkI0nfYav4d+Fau99j5zD5gp8V4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lkx6aSItTrPedTaRrq9iKE24inyArySpsgznPogVcVBizRQpJmGCcdZ6ZG8PnSh3NmOUm9Zdz1ies79/by2EUaj0U79e5POIqYNlhCZS52zhNT1xWjBG4lRCCvCiNvdEIs4i0KfJ862gIggu6JfzDghLizeNtOMkJgg3kjGi/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bDYto4Y8; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754309805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dsCCYJVf50voJUlyGqf8P6lX4sGjnQ9vneNNYICjjks=;
	b=bDYto4Y8g2xjYdtZVG3OTKbd3cmcOZypPFOvFyrXQXHxnFIJLmJI6J+RKHaiIHMnC00E5z
	vrYbHW7Mg4Bka9kugv7cj2t3GZQOtiYdsVFXpicPViR8i6limBYoXOcp80tE6F3bYUZaCn
	lNz+r1nJW7DNHzUggAtcjaRb1+gVDSw=
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
Subject: [PATCH bpf-next] bpf: Disable migrate when kprobe_multi attach to access bpf_prog_active
Date: Mon,  4 Aug 2025 20:16:15 +0800
Message-ID: <20250804121615.1843956-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The syscall link_create not protected by bpf_disable_instrumentation,
accessing percpu data bpf_prog_active should use cpu local_lock when
kprobe_multi program attach.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ae52978cae..f6762552e8e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2728,23 +2728,23 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	struct pt_regs *regs;
 	int err;
 
+	migrate_disable();
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
+	migrate_enable();
 	return err;
 }
 
-- 
2.48.1


