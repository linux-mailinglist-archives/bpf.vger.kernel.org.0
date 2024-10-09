Return-Path: <bpf+bounces-41461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084F0997417
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EEA1F215EB
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053651E1C01;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET1UOC2l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748501E049A;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497241; cv=none; b=Q3JT+SU02L7V0NJOIQaZBy1Wz+RNTlFZZe16RltMSMNX/xTvpAav0TSw0AFG02rLjBhKfxREn/j4FE3YUxesoF5uibHyEn3ZEIY0qG10ax5CYTo8quSxMk0wpQg7GdzFiKw/C3ug1awo1EA2bzlKsaJbLxjPHS+aKH5HolT/MMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497241; c=relaxed/simple;
	bh=YtrJn4vc+Mgz9wgw7+EugcgaEZCddJzBtXAuSeGGRxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fk0RXcNnr1hf07NQDbapjfUh2o2PgMfQPRIiQDE1fHhC198Ld6qJ9EqOB7QKqjRMzL2gXD0CEtgV1QwONYQq2k5fv3x8R7ZYLapfsgPccBAfRJyLf81kGxUzNvVk+KR8YCpbvl7Lxt88LsjcMmkh4/MHPRiI+qI5nLH2x1aSV7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET1UOC2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBD9C4CEC3;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497241;
	bh=YtrJn4vc+Mgz9wgw7+EugcgaEZCddJzBtXAuSeGGRxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ET1UOC2lI3v1Dq1UGsIUa/wz6CxnBK0fLf+88jg3nMdROL9RjWii/LfE0MVDpOtsU
	 8YqrAUdUogXgllkIIZdxN/UNCE8G2VEtWjOxNAw+v5Q++kUrb8xUNcm5U/SoTQPrkv
	 CfD4SydBPN8otoyPqEPkv4SVHS+6RIGdXa/YMpi92aR4InHtuUSBl8o6b31bRu5CkJ
	 7Hn2ld5c5JwfM+KfZFnotvxQdOLJwAp2rOH6hqiw4RZVBwBB+2cjQJn20pfUZPY9ql
	 S6CV6f81tnS/rT9gr02xy1vplk5KRbmUgHOjRSIQwEHgB2Kuwp3QtFOsuCMpmqZMec
	 ZwbJQz0NrCEpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0EFF7CE08E5; Wed,  9 Oct 2024 11:07:21 -0700 (PDT)
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
Subject: [PATCH rcu 01/12] srcu: Rename srcu_might_be_idle() to srcu_should_expedite()
Date: Wed,  9 Oct 2024 11:07:08 -0700
Message-Id: <20241009180719.778285-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
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


