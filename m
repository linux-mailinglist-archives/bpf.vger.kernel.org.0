Return-Path: <bpf+bounces-50152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E06BA2345C
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CBA18837DF
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC411F2C32;
	Thu, 30 Jan 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvqgOp/a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E11F1523;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=FRHr5zAIjr5AJJlEMchWRYseGDi5Jm6EZAIgecCOumjdTr4+3J+Znj5LSqsTgbcEYiziuNHEeRy1rInJUWQhQoQkjKTAwUsmFF0WSZh8Lo/z2+X9I1QFT6DDcRQRb2zbWaieHL19pNH+qnfxpwyGOxWUx2S+BPBEig/uJKKLVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=rzttFulWXFHlVagRx0vJ3s9U1XCsDzVFtAX/Lp+7Vq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dmS2gBO9jmY6ve333vph5hH/3lFIyPezBRNSzxz72dMuFpfTaH7+VidALUciHqaCoOHnyv6mcjPf6kIpdAiRBxWqWPlTZwhMAip5mAkmnkALT8gUwT+nQUqUrBr+PXt/Ndxf0ThTWNklurVTfZlNBuDvJSWV+Y3sNTiCW2GT5sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvqgOp/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2434C4CED2;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=rzttFulWXFHlVagRx0vJ3s9U1XCsDzVFtAX/Lp+7Vq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvqgOp/a4GfsCpTIWU0Mj/KxW8kVoqGOYWbEW4wd+dkdTfecfRCz0kaY7d1Y7gtsf
	 jfslVsVLL7cj8TzhjIwZ7dcmwPy919XsebZBxf8ZXbZD/NmSfArFF6SyYShLiau3S3
	 FG8UpxbAxhm0b8Zbq3aXPFH6n36mi8rdlMG8K1UPEKUiztihwUHRzSvMLGQJGIkzo+
	 WvsL7uoanq+YHZqV0C7sfXb7yZ7c0y23Xf2qxXghQveF1OvfnWYTxGKCBjW/qnW5q9
	 nIyPCp39R8g2GlOC5NKIXuZw3G901dDrEZgSeT1UqxSGUhFUjFx1pTsGD5NnTtqOF2
	 3PiDaU0wDhQ9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0748CCE3806; Thu, 30 Jan 2025 11:03:19 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu v2] 15/20] refscale: Add srcu_read_lock_fast() support using "srcu-fast"
Date: Thu, 30 Jan 2025 11:03:12 -0800
Message-Id: <20250130190317.1652481-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
References: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit creates a new srcu-fast option for the refscale.scale_type
module parameter that selects srcu_read_lock_fast() and
srcu_read_unlock_fast().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/refscale.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 1b47376acdc4..f11a7c2af778 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -216,6 +216,36 @@ static const struct ref_scale_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+static void srcu_fast_ref_scale_read_section(const int nloops)
+{
+	int i;
+	struct srcu_ctr __percpu *scp;
+
+	for (i = nloops; i >= 0; i--) {
+		scp = srcu_read_lock_fast(srcu_ctlp);
+		srcu_read_unlock_fast(srcu_ctlp, scp);
+	}
+}
+
+static void srcu_fast_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+	struct srcu_ctr __percpu *scp;
+
+	for (i = nloops; i >= 0; i--) {
+		scp = srcu_read_lock_fast(srcu_ctlp);
+		un_delay(udl, ndl);
+		srcu_read_unlock_fast(srcu_ctlp, scp);
+	}
+}
+
+static const struct ref_scale_ops srcu_fast_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= srcu_fast_ref_scale_read_section,
+	.delaysection	= srcu_fast_ref_scale_delay_section,
+	.name		= "srcu-fast"
+};
+
 static void srcu_lite_ref_scale_read_section(const int nloops)
 {
 	int i;
@@ -1163,7 +1193,7 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
+		&rcu_ops, &srcu_ops, &srcu_fast_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
 		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
 		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
-- 
2.40.1


