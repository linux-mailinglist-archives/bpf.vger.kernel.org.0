Return-Path: <bpf+bounces-38786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4468196A47A
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00228287F04
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDD518E762;
	Tue,  3 Sep 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO+w/qlJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E218B483;
	Tue,  3 Sep 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381200; cv=none; b=QTo05r1q+IlmC81h2U9yuYbA+gSq3lkca+vPXFm1inYy4fdQavHCCBmMOVvBKrFtgSHGrLLjZUv4sBWdpnM4wukdREVqnnG/EyeXBri+hqqGGv1Kfkw226s6lsfV++GiluGyXQFprBmM2Chmu5JVdL8yKm+O/qwbou9ACySO8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381200; c=relaxed/simple;
	bh=j+GBaMobCYd+dv4VU4yUifuxTy86KDN9UwwTtEBGrGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlQSgIp+vLs9lNh5CF6pL6oATs0o/YAp0M7bC+G9riunreIPOqA6Jz7LeDaoaffql1G+z2pl5ZD4sMHM+1LMQOvoxvPedx9nbag533ELpA7FTFkH96muzBWqPwl21q6Cq0+UyUOOeSE/SiMDibrN6sDMBEk6vpVhqi9br19wFB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO+w/qlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F780C4CEC4;
	Tue,  3 Sep 2024 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381199;
	bh=j+GBaMobCYd+dv4VU4yUifuxTy86KDN9UwwTtEBGrGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WO+w/qlJOhmrRmUL9VDVVVVKiQ6FUcIL9L6fC9VVgpL5PiFnldmCC3JTFWbGjNz0i
	 lGOEoRPOapqGAcbqEkm3QZI+R9Ye0wRG9D+FWKUyXTxKTVSxm3fdjX96l+k4GOg8ne
	 ZIA6lx1vyur1hJe1uHbz8ETTrsgUjrhg+ON8W9ar9OUzL6Fg1i2WmnD8RUrN0MMLCq
	 Q3ziB+HosuKuQ7czW5j7mYkqp7u0n9udNeWMi4CCzwZWyiBAYYzQ0J5MTEW9wDe/iP
	 lLNRuXwlunvBojn2BY2rx0urm5sTpXDaW6saA2iCtmc2rt6vYk9E/D0SamCid/EJIa
	 1VljOvalP68cA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 39714CE1D36; Tue,  3 Sep 2024 09:33:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/11] srcu: Rename srcu_might_be_idle() to srcu_should_expedite()
Date: Tue,  3 Sep 2024 09:33:08 -0700
Message-Id: <20240903163318.480678-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
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
index 78afaffd1b262..2fe0abade9c06 100644
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


