Return-Path: <bpf+bounces-73316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0243CC2A4B8
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37DE04EE123
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E01C2C0F71;
	Mon,  3 Nov 2025 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWSg0cJ3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE72BEFF9;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154354; cv=none; b=tqtGZI9/Y+17C9RWZqbyOlfgnuRSRL8iNkaEqLqN9S4aS8efEnyWMR0zGNCn5kD5XU9f4LMZru/azRF97D4bmc01OTxmUiWyfroa5Gm/LCLsFinTMezcTBt5He02gy636OdrxCdxlSqJqm3e80ZbAONKAUFqBxRP0TJRN7uapVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154354; c=relaxed/simple;
	bh=8ZCRNXXqmbiShzfe05dmFtCIZXEOypE5e1dE70Rypfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SrmVUqewK4ae0LS7nEjq073MUdqDYkpOxWnzeNQFs/PECsUQTd0dqllCMB0uCJ3aRNvqdUYm/dsZVhGlFM1iKkvIG5ERC3jXEaJgFecwR+sNmfu8aTfcBUKMHFFDyYKuheTs+buL6FnCRs2fMKAPUGR62a4+72yp6MWvnYeN10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWSg0cJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A66C19423;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154354;
	bh=8ZCRNXXqmbiShzfe05dmFtCIZXEOypE5e1dE70Rypfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uWSg0cJ31rkYVJyjqhuAnue/g4l4rIK0s8Konh5jLRD36uxNAaFltUbqKR/ocyvNj
	 u8UV+2QAWAWSbnKTrQrkCyu4LD+3DPPVdnsVB9CToWPEJyg6MOcvieckyqoS88BgMy
	 1nWfYssSxzanfQRhtW4G/QSIDtPlfbn1W3tToDx0yrZ6//SJuYMTICHXoCu4plIemz
	 pH7d/8Ls52k3Cw7gVJl1sa0AaJgwO18qXv0RDuW/lYMsHFHRQWtkn13n9qAoOeVRWx
	 iSnouZb7vALblJe7Txv0uGeCtBuFE4TvReUz1SKKu1HolxAAOdU82xSS5g9YXb0//y
	 Qw3HJjINaeTqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 04793CE160B; Sun,  2 Nov 2025 14:49:50 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 8/8] refscale: Add SRCU-fast-updown readers
Date: Sun,  2 Nov 2025 14:49:48 -0800
Message-Id: <20251102224948.3906224-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
References: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds refscale readers based on srcu_read_lock_fast_updown()
and srcu_read_lock_fast_updown() ("refscale.scale_type=srcu-fast-updown").
On my x86 laptop, these are about 2.2ns per pair.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/refscale.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 7429ec9f0092..07a313782dfd 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -186,6 +186,7 @@ static const struct ref_scale_ops rcu_ops = {
 // Definitions for SRCU ref scale testing.
 DEFINE_STATIC_SRCU(srcu_refctl_scale);
 DEFINE_STATIC_SRCU_FAST(srcu_fast_refctl_scale);
+DEFINE_STATIC_SRCU_FAST_UPDOWN(srcu_fast_updown_refctl_scale);
 static struct srcu_struct *srcu_ctlp = &srcu_refctl_scale;
 
 static void srcu_ref_scale_read_section(const int nloops)
@@ -254,6 +255,42 @@ static const struct ref_scale_ops srcu_fast_ops = {
 	.name		= "srcu-fast"
 };
 
+static bool srcu_fast_updown_sync_scale_init(void)
+{
+	srcu_ctlp = &srcu_fast_updown_refctl_scale;
+	return true;
+}
+
+static void srcu_fast_updown_ref_scale_read_section(const int nloops)
+{
+	int i;
+	struct srcu_ctr __percpu *scp;
+
+	for (i = nloops; i >= 0; i--) {
+		scp = srcu_read_lock_fast_updown(srcu_ctlp);
+		srcu_read_unlock_fast_updown(srcu_ctlp, scp);
+	}
+}
+
+static void srcu_fast_updown_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+	struct srcu_ctr __percpu *scp;
+
+	for (i = nloops; i >= 0; i--) {
+		scp = srcu_read_lock_fast_updown(srcu_ctlp);
+		un_delay(udl, ndl);
+		srcu_read_unlock_fast_updown(srcu_ctlp, scp);
+	}
+}
+
+static const struct ref_scale_ops srcu_fast_updown_ops = {
+	.init		= srcu_fast_updown_sync_scale_init,
+	.readsection	= srcu_fast_updown_ref_scale_read_section,
+	.delaysection	= srcu_fast_updown_ref_scale_delay_section,
+	.name		= "srcu-fast-updown"
+};
+
 #ifdef CONFIG_TASKS_RCU
 
 // Definitions for RCU Tasks ref scale testing: Empty read markers.
@@ -1479,7 +1516,8 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcu_fast_ops, RCU_TRACE_OPS RCU_TASKS_OPS
+		&rcu_ops, &srcu_ops, &srcu_fast_ops, &srcu_fast_updown_ops,
+		RCU_TRACE_OPS RCU_TASKS_OPS
 		&refcnt_ops, &percpuinc_ops, &incpercpu_ops, &incpercpupreempt_ops,
 		&incpercpubh_ops, &incpercpuirqsave_ops,
 		&rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops,
-- 
2.40.1


