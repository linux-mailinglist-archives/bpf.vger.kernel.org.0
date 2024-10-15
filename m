Return-Path: <bpf+bounces-42068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4A499F262
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7F31C20A6F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177771F9EAD;
	Tue, 15 Oct 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjWuaejM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4DE13B284;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008674; cv=none; b=ad1ebIscDXQHb73Eu0PfM2zFofYo0sB4gftK+EI64b25+frYDKUJkUlZVJF8bjJkG4pjdjhZ1Ofy7utfS5R0872jbBPV6B2LO28qr/JyVvNc1OB/W2s/qGK4FGRLDDTTcF7al8ySLUE0TJrhx2yaV8kVVZfV3Ca+wCUjE0QdiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008674; c=relaxed/simple;
	bh=YtrJn4vc+Mgz9wgw7+EugcgaEZCddJzBtXAuSeGGRxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvubs8C2ZpfMhTgQsiky77H86/QqZAhdKctqdAirgEol/NHMmJ2S+B7BVsA6jBgM60OKrHwbgWWVNwulox5eyqAijYFxFsqqlsqrj7ke4Q4nXKAG2ugUi2aJou3eN4RIiHvRtRvpOPvwJib21Xdkl/NxK9sQatfV0H/6KkbDtU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjWuaejM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102FBC4CEC6;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008674;
	bh=YtrJn4vc+Mgz9wgw7+EugcgaEZCddJzBtXAuSeGGRxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjWuaejMz3s2kw0x85c0BKmvxqsG68srpL0BWdgw5AbFisGdZpWkE88Lx8rFTSHA8
	 2VSsfnTjowFQzl7SIbV2FhnAWREHbhdxERR6dwrvif+bomJo3QZ5eI08901VU8byHO
	 6kqnhcWrYQuVeC/PIZclBNHNz5llVCAfSFXJ8fflzdV7Zfo6wVmv9FDH+6Au0ZIY+Q
	 oOXOdYwmvw2zCFb/cpHli8WSDJVmnd3vslEhRdCAAjlUEa/FVk3V5Jnz+0JkHz5h7L
	 YjONZx3hl9Stfqqfi84e9Lu/VF6yVMow50/k6fimHFOIubWyAFQDkTfLMRl4DtXpP3
	 P0AcGDYJLUg6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B34EECE0971; Tue, 15 Oct 2024 09:11:13 -0700 (PDT)
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
Subject: [PATCH rcu 01/15] srcu: Rename srcu_might_be_idle() to srcu_should_expedite()
Date: Tue, 15 Oct 2024 09:10:58 -0700
Message-Id: <20241015161112.442758-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
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


