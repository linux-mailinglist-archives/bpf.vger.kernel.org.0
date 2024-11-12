Return-Path: <bpf+bounces-44630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391659C5AEE
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 15:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56921F229F7
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8351FF7D1;
	Tue, 12 Nov 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T933MiDd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F81E2309A3;
	Tue, 12 Nov 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423136; cv=none; b=tgiUn2/LUD701x8yvCwo1DDjPwXsKhbVe0f3gjRp4ATfCCIhgi8milzXVL1HJTMltW//r5dcFXPWye7EmY9GAmoKO2E25MvKxbOcxmbt7TOY8/rCDQjSJ4bQpmJATxeGM/Ukr5ykR4BV+Xsf3cB0FOFVabmRzKlGWSKeSYc9FJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423136; c=relaxed/simple;
	bh=z1VXHQ8nm+thKUAOq8fF+b7rvfScDMLO8mSbw0MCNro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFQVVl2sfn809r5jjoC3R/dJ+vOeyd/YKBdtQPeD3J01cP9uTaw/PNi61iOmFS9z1cAxaL9sVLpoCVCHC3bjUdkSHHaLFoEVSfa2Fs7ojVDpzS77NoxmPVylSvXHQgFhynxCIyqXUXuLfq61sV/377y6HVMNlattbEn+gu+Huo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T933MiDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E22C4CED0;
	Tue, 12 Nov 2024 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423133;
	bh=z1VXHQ8nm+thKUAOq8fF+b7rvfScDMLO8mSbw0MCNro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T933MiDdj+qYN+IK2kYLW4s3EmTvllNqGp0Y+/7B3jmv6+D4wg/FUx8Ro3h19b57M
	 5IINo09bsWhFRaCitBUgTDMeCzOPmkIA64my1IksBllOCVVgH7X+8AwLB+3YYx13Ve
	 vlXMileo9CvfBG8H+ggvTtXOm+BTtv8UivK/89oI8X7Q7dZuoibFzIsytBXJMPUjwZ
	 XsvsfYVZi1BIZrOjOlfMlPQq2tAjo/Ll9jEBwXae9TjXc2QLAKdUjDHMPcA4xy1j/w
	 fD/fcogS2cmvcUwq+g08zVELkQeREKE4AnwNYDsUkC0ctI6zJQkmOKjKkrlfBYoiJs
	 SGq84tMDNgfMA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 02/16] srcu: Rename srcu_might_be_idle() to srcu_should_expedite()
Date: Tue, 12 Nov 2024 15:51:45 +0100
Message-ID: <20241112145159.23032-3-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112145159.23032-1-frederic@kernel.org>
References: <20241112145159.23032-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

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
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 78afaffd1b26..2fe0abade9c0 100644
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
2.46.0


