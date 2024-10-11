Return-Path: <bpf+bounces-41763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843A99AA81
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F35D1C20B5D
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF041CF2A7;
	Fri, 11 Oct 2024 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/DvKyih"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F01C2DA1;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668373; cv=none; b=kg8ApVqc6e4MpglpTSGTV9vxPePeNs7WwNa1p6RUyTihEUG+xpkLQy6X93jyDHZRyGdq6K4BDLiIr1ITwMqDip75U5JqdxBpYHy9UBPSQwnmUKDsu3MZGKmq2c/xfcNb2atKi5QxTzlaM1CCDzp9CE04e6zD+i4U8teINAnyYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668373; c=relaxed/simple;
	bh=YtrJn4vc+Mgz9wgw7+EugcgaEZCddJzBtXAuSeGGRxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Td8mp8kWVmIWcuY1tuabB1oDG/KJJG5+/o4p3GT1hrvAv40MBXQPwBXGl96jfg+ZQ+DRcPKiHn0Av87mOoAwNVdoHnPrDIQKrSXoMHujhEXTS5S/N83enAhpKfSpVm+VVfehfO64yeILgmeZ49unCFrpdgKy7A15/x9qmElE57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/DvKyih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52A1C4CEC3;
	Fri, 11 Oct 2024 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668373;
	bh=YtrJn4vc+Mgz9wgw7+EugcgaEZCddJzBtXAuSeGGRxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/DvKyihzpbz0F1UjqpYZmPGTveIK/9TCnBiQ5W3BJVe3uTau+kajEEG2W7tkfJHZ
	 h1LaE1XUR1dgbsZfPI+CJv7Ax+r5wvBW1ekLSIQ/XO4NbEBlMSoYaccUf1w1h9YMON
	 u2luxl/PZYPUQLTTDaPkIgWJAaLiRRVnDLQS8o3LLOh+BBaDUceRhJA8a90jLoexuy
	 j/MCaX9f5ZglIJnnavL3Qml//0rTZ61f5UK7e3E7DXyI+sE8lYzwVnrG9+aNhPHhqX
	 WzchLutmfhOlCMg5t54ZA0poLy0UjxtqMdOCeQCiYei1zN1cFSpShi0j1oBjnKvAcf
	 LtT/wZIt7QeUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 986CACE0BB1; Fri, 11 Oct 2024 10:39:32 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH v2 rcu 01/13] srcu: Rename srcu_might_be_idle() to srcu_should_expedite()
Date: Fri, 11 Oct 2024 10:39:19 -0700
Message-Id: <20241011173931.2050422-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
References: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SRCU auto-expedites grace periods that follow a sufficiently long idle
period, and the srcu_might_be_idle() function is used to make this
decision.  However, the upcoming light-weight SRCU readers will not do
auto-expediting because doing so would cause the grace-period machinery
to invoke synchronize_rcu_expedited() twice, with IPIs all around.
However, software-engineering considerations force this determination
to remain in srcu_might_be_idle().

This commit therefore changes the name of srcu_might_be_idle() to
srcu_should_expedite(), thus moving from what it currently does to why
it does it, this latter being more future-proof.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/srcutree.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 31706e3293bce..9ff4ded609ba5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1139,7 +1139,8 @@ static void srcu_flip(struct srcu_struct *ssp)
 }
 
 /*
- * If SRCU is likely idle, return true, otherwise return false.
+ * If SRCU is likely idle, in other words, the next SRCU grace period
+ * should be expedited, return true, otherwise return false.
  *
  * Note that it is OK for several current from-idle requests for a new
  * grace period from idle to specify expediting because they will all end
@@ -1159,7 +1160,7 @@ static void srcu_flip(struct srcu_struct *ssp)
  * negligible when amortized over that time period, and the extra latency
  * of a needlessly non-expedited grace period is similarly negligible.
  */
-static bool srcu_might_be_idle(struct srcu_struct *ssp)
+static bool srcu_should_expedite(struct srcu_struct *ssp)
 {
 	unsigned long curseq;
 	unsigned long flags;
@@ -1469,14 +1470,15 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_expedited);
  * Implementation of these memory-ordering guarantees is similar to
  * that of synchronize_rcu().
  *
- * If SRCU is likely idle, expedite the first request.  This semantic
- * was provided by Classic SRCU, and is relied upon by its users, so TREE
- * SRCU must also provide it.  Note that detecting idleness is heuristic
- * and subject to both false positives and negatives.
+ * If SRCU is likely idle as determined by srcu_should_expedite(),
+ * expedite the first request.  This semantic was provided by Classic SRCU,
+ * and is relied upon by its users, so TREE SRCU must also provide it.
+ * Note that detecting idleness is heuristic and subject to both false
+ * positives and negatives.
  */
 void synchronize_srcu(struct srcu_struct *ssp)
 {
-	if (srcu_might_be_idle(ssp) || rcu_gp_is_expedited())
+	if (srcu_should_expedite(ssp) || rcu_gp_is_expedited())
 		synchronize_srcu_expedited(ssp);
 	else
 		__synchronize_srcu(ssp, true);
-- 
2.40.1


